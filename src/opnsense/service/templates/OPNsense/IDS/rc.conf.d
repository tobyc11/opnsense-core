{# Macro import #}
{% from 'OPNsense/Macros/interface.macro' import physical_interface %}
{% if not helpers.empty('OPNsense.IDS.general.enabled') %}
suricata_precmd="/usr/local/opnsense/scripts/suricata/setup.sh"
suricata_enable="YES"
{% if OPNsense.IDS.general.ips|default("0") == "1" %}
# IPS mode, switch to netmap
suricata_netmap="YES"
{% else %}
# IDS mode, pcap live mode
{% set addFlags=[] %}
{%   for intfName in OPNsense.IDS.general.interfaces.split(',') %}
{#     store additional interfaces to addFlags #}
{%     do addFlags.append(physical_interface(intfName)) %}
{%   endfor %}
suricata_interface="{{ addFlags|join(' ') }}"
{% endif %}
{% else %}
suricata_enable="NO"
{% endif %}
