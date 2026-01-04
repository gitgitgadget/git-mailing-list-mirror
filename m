Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863AA224B0D
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767536894; cv=none; b=RKDB/Ux+bJoWBSMfVqoLV4ek0J7cyp8l17D4GXKYOL61qTEtAnUQeshKGv3RIcF0qHBd/DgtxJgi0cCv0ihZWc5B4pDfsl6pxslDiCH7y3crnUkvLH4O31mKeLBW6jhPA5FBg7+bL598aYxpXFWGY98w6xg5UIULY/oNuqqnmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767536894; c=relaxed/simple;
	bh=yeD95E9VdIt9bJ7mR4Whf+okYJXcBar5JEWGZSpWCnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhiGrV7TkSL8fWyAts6ZFk/vR2hrWzi/kroc2XASkxACuTn8IFQqPtJAVbTFbNg72GDUQcm/iU3Ke0tIUaSuCPzr2NwtyXD9+YcnJ0zPA+Ndy+/h735im/b5Ii0j6n5fRDnjY5xqtnaQMhOnQT6WZRnsHIbCh6Or0B+2P/ZJe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub; spf=pass smtp.mailfrom=mail.dietrich.pub; dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b=fDca2tHk; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b="fDca2tHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.dietrich.pub;
	s=protonmail; t=1767536878; x=1767796078;
	bh=zwb5lQZg82NNmsZjvyIzyUiuYXmZeT/6swOTA8ZjL9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fDca2tHk5Hft/46dhwzVr+G3LCvYMgfbX/ptP2peQ4sb6P+eAeYJYo39RsaH96HhB
	 51KB5LVTya8QH0eBiFbnEYoi2i4rGiAW7uJ1xjCb6L/1PPMxmenFr+sS3mg0o3VpFL
	 rWgUS38nbpg2ulDaw1iMZI+p91lYTBN5rv2NmsQRDcfAfXybPehPVVL0Ofdl4UuDIn
	 wfKXlp3gDad01n5D5Qg2U63yjJRhL2qryO6VyzHQW4iTzLso6I/U1koBtm2FVBDLmE
	 /FAs9iwsnHfXoG6XhWmmU7mDDNrlAvIgkI1Ec38y7hQ6gg5lhVcgMQv8rE++C0Z1It
	 QSAWLG40IGviA==
X-Pm-Submission-Id: 4dkfsm3gqHz2Scn7
From: george@mail.dietrich.pub
To: ask+git@howdoi.land
Cc: george@mail.dietrich.pub,
	git@vger.kernel.org
Subject: Re: [Bug] Git subtree regression
Date: Sun,  4 Jan 2026 09:27:26 -0500
Message-ID: <20260104142733.2334796-1-george@mail.dietrich.pub>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <e25b4d76-c1b5-4b6b-ba77-e1e2f7243ce9@howdoi.land>
References: <e25b4d76-c1b5-4b6b-ba77-e1e2f7243ce9@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

---

Ahh, yes. It seems you also need to add `clock` as a remote and fetch it:
```
$ git clone git@github.com:athena-framework/athena.git
$ cd athena
$ git remote add clock git@github.com:athena-framework/clock.git
$ git fetch clock
$ git subtree split --prefix="src/components/clock"
0efb3d9858e3bfee65165508aeeacc50417c9a99
```

I wasn't able to use _exactly_ 2.43.7, but I was able to use 2.43.0 which would still be before that other change.
It also produced the expected commit hash, unlike 2.52.0.
It, also was significantly faster, took ~9s vs 2.51.1 which was ~26s.
2.52.0 was better at ~14s, but of course produces the wrong hash.

This reproduces the issue quite well, and what the root cause likely.
It does seem one component was added differently, as a non-merge commit, which seems break things.
Looking at the Athena monorepo, this can somewhat be confirmed via https://github.com/athena-framework/athena/commits/master/?after=ee21a41e9dfc969e759b532d45c0c0faa21876d6+0.
How the first two commits show up as verified, unlike the other times when I normally do `git subtree add --squash` and push directly to main, they show up as unverified.

```
#!/bin/bash
#
# THE BUG:
# When a commit's direct parent is a squash commit for a DIFFERENT subtree,
# and that squash commit's ancestry includes OUR subtree's squash commit,
# the split breaks.
#
# Old code: `git log -1 --grep` searches ancestry, finds our marker → don't ignore
# New code: only checks parent's own trailers → ignores → breaks parent chain
#
# This pattern occurs when subtree squash commits are cherry-picked or rebased
# into a linear history (instead of the normal merge structure).

set -e

KEEP_TMPDIR="${KEEP_TMPDIR:-}"

TMPDIR=$(mktemp -d)
echo "Working directory: $TMPDIR"

cleanup() {
    if [ -n "$KEEP_TMPDIR" ]; then
        echo "Preserving temp directory: $TMPDIR"
    else
        rm -rf "$TMPDIR"
    fi
}
trap cleanup EXIT

create_repo() {
    local repo="$1"
    git init -b main "$repo"
    git -C "$repo" config user.email "test@test.com"
    git -C "$repo" config user.name "Test User"
    git -C "$repo" config log.date relative
}

create_commit() {
    local repo="$1"
    local name="$2"
    (
        cd "$repo"
        mkdir -p "$(dirname "$name")"
        echo "$name" > "$name"
        git add "$name"
        git commit -m "$name"
    )
}

cd "$TMPDIR"

echo "=== Creating repositories ==="

create_repo monorepo
create_repo subA
create_repo subB

echo "=== Creating upstream commits ==="

create_commit subA subA1
create_commit subA subA2
create_commit subB subB1
create_commit subB subB2

echo "=== Setting up monorepo with linear squash structure ==="

# Initial commit
create_commit monorepo main1

# Add subA with --squash (normal way - creates merge)
git -C monorepo fetch ../subA HEAD
git -C monorepo subtree add --prefix=subA --squash FETCH_HEAD

# Make a change in subA
create_commit monorepo subA/change1

# Now we simulate cherry-picking JUST the squash commit for subB
# (This is what seems to have happened in the athena repo)
# First, get subB ready
git -C monorepo fetch ../subB HEAD

# Create a LINEAR squash commit for subB (simulating cherry-pick of just the squash commit)
# This is the key pattern that triggers the bug - a squash commit as a regular linear commit
(
    cd monorepo
    mkdir -p subB
    git -C ../subB archive HEAD | tar -x -C subB
    git add subB
    # Create a squash-style commit with subtree trailers but as a LINEAR commit
    # Trailers must be in the last paragraph, separated by blank line
    subB_short=$(git -C ../subB rev-parse --short HEAD)
    subB_full=$(git -C ../subB rev-parse HEAD)
    git commit -F - <<EOF
Squashed 'subB/' content from commit $subB_short
git-subtree-dir: subB
git-subtree-split: $subB_full
EOF
)

echo ""
echo "=== Key structure: subB squash is a LINEAR commit, not a merge ==="
git -C monorepo log -1 --format='%H %s' HEAD
echo "Parent count: $(git -C monorepo cat-file -p HEAD | grep -c '^parent')"

# Now make a commit that touches subA
# This commit's parent is the subB squash commit (linear)
create_commit monorepo subA/change2

echo ""
echo "=== Repository structure ==="
git -C monorepo log --oneline --graph

# Verify the squash commit's ancestry includes subA's marker
subB_squash=$(git -C monorepo rev-parse HEAD^)
echo ""
echo "=== Checking ancestry of subB squash commit ($subB_squash) ==="
echo "Looking for subA marker in ancestry..."
if git -C monorepo log -1 --grep="git-subtree-dir: subA" "$subB_squash" --oneline 2>/dev/null; then
    echo "  FOUND - old code would search this and NOT ignore"
else
    echo "  NOT FOUND - test setup may be incomplete"
fi

echo ""
echo "=== Running subtree split on subA ==="

split_hash=$(git -C monorepo subtree split --prefix=subA 2>/dev/null)
echo "Split hash: $split_hash"

split_count=$(git -C monorepo rev-list --count "$split_hash")
echo "Commits in split: $split_count"

echo ""
echo "=== Split history ==="
git -C monorepo log --oneline "$split_hash"

echo ""
echo "=== Result ==="

# Expected: 4 commits (2 upstream + 2 local changes)
if [ "$split_count" -ge 4 ]; then
    echo "PASS: Split produced connected history ($split_count commits)"
    exit 0
else
    echo "FAIL: Split produced disconnected history (only $split_count commits, expected >= 4)"
    exit 1
fi
```
