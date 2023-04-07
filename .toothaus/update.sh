#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_REMOTE='upstream'
UPSTREAM_REPO='https://github.com/mastodon/mastodon.git'
LOCAL_BRANCH_PREFIX='toothaus-'

if ! git remote -v | grep -c upstream >/dev/null; then
    git remote add "$UPSTREAM_REMOTE" "$UPSTREAM_REPO"
fi

LAST_TAG=${1}
TARGET_TAG=${2}

git fetch --tags "$UPSTREAM_REMOTE"
git switch -c "${LOCAL_BRANCH_PREFIX}${TARGET_TAG}" "$TARGET_TAG"
git cherry-pick "${LOCAL_BRANCH_PREFIX}${LAST_TAG}...${LAST_TAG}"

echo "Ready to push $LOCAL_BRANCH_PREFIX${TARGET_TAG}"
