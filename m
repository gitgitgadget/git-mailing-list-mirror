Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014C30C17D
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494271; cv=none; b=b5BeMzhoHCG7n5iJtOBiy0UJw/815uqyTC2+OONu3XDfyblrdlSRaQ4b9t6MyH1S60vB9Dk1zd5H9TfUq0z9uc0pFKy2vw4q2g+/1UcIvI0zRche1nUeG9KHO9ts+PkUDMN3ocGx4zqDbTStliilG87N6EJgCB3vbDDMna8hnIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494271; c=relaxed/simple;
	bh=WJC9Alii8tzD1YC1D5aoEAq2Lep4q7YXTJMZLfODuiM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fbuKsyhAZzSISzuF55aOh9M0McqhXHvhB6cJ/BNH76NRkdrIn/Rcx4AJFFWhkF1qJrRCMUGk4idX1Sw8pwKO9p7s8UAj5SJG2ShGFrPNVijHQ2Xo67ETBaGe8QmEYJfzw1yuNc3QadgUG+9JLRNlr2tTRw0BuIG1P9AnGJ23wPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gNGPFuD8; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gNGPFuD8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1780494265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6gjwfTDXkEffENfusv2Z+hWOrxdxee3C1KRLTupBqNE=;
	b=gNGPFuD8SFiPcke10gfZTiPyos4PWu1c+HQz4qA8MRuP/Ricsh9iL91TE2Ot1OsOBds0qB
	+HimS9a3g5dG6Eyb/m4qZrtzkJh0IAMyFazOhDQ8SIBrsr4JFOvB9qfZBWmPOdcjlQFIws
	tMXdZ2tE61QN+1bbK8g/yvRiDBUc5vI=
From: Toon Claes <toon@iotcl.com>
To: Matthew Hughes <matthewhughes934@gmail.com>, git@vger.kernel.org
Subject: Re: Suggetsions for collaboration workflows in large repos
In-Reply-To: <ahnUeESE1x802Z9N@desktop>
References: <20260529163117.z2auhbg4sdxxgmis@archP14s>
 <ahnUeESE1x802Z9N@desktop>
Date: Wed, 03 Jun 2026 15:44:11 +0200
Message-ID: <87tsrj20yc.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Matthew Hughes <matthewhughes934@gmail.com> writes:

> On Fri, May 29, 2026 at 05:31:17PM +0100, Matthew Hughes wrote:
>> I thought about doing something like tracking
>> `refs/heads*/some-colleague-branch` from the remote, since with the wildcard
>> `*` I at least won't the fatal error on the missing reference during fetch, but
>> that risks my config containing an ever growing list of such wildcards, or a
>> bunch of manual work occasionally cleaning up old ones (or maybe that could be
>> automated).

I feel your problem, although a lot less in the project I'm working on
lately. I have these refspecs by the way:

	fetch = +refs/heads/master:refs/remotes/origin/master
	fetch = +refs/heads/toon-*:refs/remotes/origin/toon-*


> I hacked some scripts to automate this. Firstly, one for fetching:
>
> 1. Fetches the branch
> 2. Adds a fetch config with wildcard hacks so `git fetch` brings in updates for
>   that branch (the refspec should match _exactly_ that branch and never
>   anything more)
> 3. Adds a separate ref to record that we're tracking this branch (so something
>   knows to clean it up later)
>
>     #!/usr/bin/env bash
>
>     set -o errexit -o pipefail -o nounset
>
>     # save command as e.g. git-fetch-other
>     CMD_NAME="$(basename "$0" | sed 's/git-//g')"
>     if [ $# -lt 1 ]
>     then
>         echo "usage: git $CMD_NAME branch-name [ remote-name ]" >&2
>         exit 1
>     fi
>
>     BRANCH_NAME="$1"
>     REMOTE_NAME="${2:-origin}"
>     FETCH_CONFIG_NAME="remote.$REMOTE_NAME.fetch"
>
>     git fetch "$REMOTE_NAME" "$BRANCH_NAME"
>     git checkout -b "$BRANCH_NAME"
>
>     # we want to record that we are tracking this branch, to do this create
>     # a new ref whose name tells us what we're tracking, but whose value is
>     # unimportant. So as a placeholder value just use the hash of an empty tree
>     # taken from https://git.kernel.org/pub/scm/git/git.git/commit/?id=9c8a294a1ae1335511475db9c0eb8841c0ec9738
>     EMPTY_TREE_REF="$(git hash-object -t tree /dev/null)"
>
>     # refspec used to track the branch: we expect branches to be deleted from the
>     # upstream when merged so tracking exactly:
>     # "+refs/heads/$BRANCH_NAME:refs/remotes/$REMOTE_NAME/$BRANCH_NAME" will error
>     # when we go to fetch that exact ref after its removed upstream.
>     # so HACK around this: add wildcards that we still expect to only ever match
>     # this exact branch (but doesn't have the issue of git complaining when it
>     # tries to fetch an _exact_ ref)
>     TRACKING_REFSPEC="+refs/heads*/$BRANCH_NAME:refs/remotes*/$REMOTE_NAME/$BRANCH_NAME"
>
>     # record that we're tracking this branch. First check we've not already
>     # recorded this, then ...
>     if ! git config get --local --fixed-value --value "$TRACKING_REFSPEC" "$FETCH_CONFIG_NAME" >/dev/null
>     then
>         # ... set the config to track it for fetching, and ...
>         git config set --comment "$CMD_NAME: tracking at $(date -I)"  --local --append "$FETCH_CONFIG_NAME" "$TRACKING_REFSPEC"
>         # ... record that we have special cased this tracking
>         git update-ref "refs/tracked/$REMOTE_NAME/$BRANCH_NAME" "$EMPTY_TREE_REF"
>     fi

It seems to be a bit more advanced than the alias I have:

    cofetch = !sh -c 'git fetch $1 $2:remotes/$1/$2 && git switch -c $2 remotes/$1/$2' -

You need to pass it the remote and the branch name (in reverse order of
yours, which makes sense if you want the remote to be optional).

> And the cleanup script (needs to be run periodically):
>
> 1. Collects all the remote branches we know about
> 2. Checks all the references from step 3. above and checks if any branches
> defined there are missing remotes (I have fetch.prune=true to keep the remote
> tracking references up-to-date)
> 3. If they are, drops the tracking config for that branch
>
>     #!/usr/bin/env bash
>
>     set -o errexit -o pipefail -o nounset
>
>     REMOTE_NAME="${1:-origin}"
>     TRACKED_REF_PREFIX="refs/tracked/$REMOTE_NAME"
>     REMOTE_REF_PREFIX="refs/remotes/$REMOTE_NAME"
>
>     declare -A remote_branch_lookup
>     while read -r remote_ref
>     do
>         # strip prefix, e.g. 'refs/remotes/origin/some-branch' -> 'some-branch'
>         branch_name="${remote_ref#$REMOTE_REF_PREFIX/}"
>         remote_branch_lookup["$branch_name"]=1
>     done < <(git for-each-ref --format='%(refname)' "$REMOTE_REF_PREFIX/")
>
>     while read -r tracking_info
>     do
>         tracked_branch="${tracking_info#$TRACKED_REF_PREFIX/}"
>         if ! [[ -v "remote_branch_lookup[$tracked_branch]" ]]
>         then
>             echo "branch $tracked_branch has been removed from the remote, untracking it"
>             git update-ref -d "$TRACKED_REF_PREFIX/$tracked_branch"
>
>             tracking_refspec="+refs/heads*/$tracked_branch:refs/remotes*/$REMOTE_NAME/$tracked_branch"
>             git config unset --local --fixed-value --value "$tracking_refspec" "remote.$REMOTE_NAME.fetch"
>         fi
>     done < <(git for-each-ref --format='%(refname)' "$TRACKED_REF_PREFIX/")
>
> So functionally I think this allows for the workflow I want, but does feel like
> a big ol' hack :>

I agree it feels hacky, but I don't really see how we can generalize it
more so it will become a standard feature in git?

I was thinking you can already pass `-c remote.origin.fetch=<refspec>`
(multiple times) to git-clone(1), but in practice it doesn't seem to
work because that config is additive, so it adds the refspec, instead of
overwriting, so you're getting:

  fatal: multiple updates for ref 'refs/remotes/origin/main' not allowed

And you cannot combine it with `--single-branch`, although you could do
a single branch clone and then add additional refspecs later.

-- 
Cheers,
Toon
