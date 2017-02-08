#!/bin/bash

set -e

QUERY=$1
PATH=/usr/local/bin:$PATH
export PASSWORD_STORE_CLIP_TIME=10

# GPG agent
envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
    eval "$(cat "$envfile"); export GPG_AGENT_INFO"
else
    eval "$(gpg-agent --daemon --write-env-file "$envfile")"
fi

pass show -c "$QUERY"
