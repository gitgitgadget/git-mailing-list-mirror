Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7711E3789
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234629; cv=none; b=eFkxA8RF+AoDgIl+vajHxIuxq63CP5tLY0mjSFOcvxnQT+LTTERyxgYaCjj7LNl7QYstd+ZUF28qNm18nDPQa/Loaafy1xDfH5wHqdUkHhd/6WXKyl+4vHVe2pyARyiWXq1epAc+6dEU4kRP3Nl4Zjll57Bqyxv6lZQvWggyyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234629; c=relaxed/simple;
	bh=SdEauIF4TQHb+Ig2Svo8YKRLnxJcw77IGwBnkzun7qk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rTPqY8Diru0DFCc9rlpt4MIdYpX+xOnTH5kPsUUFdl4HTtYA79x31yGe5hSwqJdE/ZlU4i5htsUjKHXWbayUZyCpDree3eDcbR2o7Jt9L+pf1zagpSmx9c7o4toZEv4IyRtBLNk2GpiVU1ydiIprVJHgPC8WivB8B0FKsbBuQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=JlgybZ3H; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="JlgybZ3H"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:666:7ab6:84f4:fbbf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id A87AF60A9C;
	Tue,  3 Dec 2024 14:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1733234144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TC/xgryxUlRrB/P/R3ZPOL7qNB/MyFnT94TnlajAYOw=;
	b=JlgybZ3Hvm+oRPr1wa2d2zaH1X7ZrZqmSjAAH9yDZaZv2Xew+AxA8BfV1J7E3x5v07ZXQ4
	VEoZgW0MNWobrxUW7inSdo2PAOjev0o8xqFQlU6XBE2njNRlF1V6HfPpH21yUq6Hni/lWL
	gRdIeVAm07hXa6g39hTmHXOpkJXfAtm8zdPCXnjBpx4HfNqLgBz3sXZX+DteoLzcw2nVjq
	2vULcKXJWW1vf34xeWItB5uEly2DQJhU4YXbKw5Xz/GW+iib7UXaXIUebl2fcDEs1DnvKf
	OmohxGXTxCbgczX3JpNGI3/Tjw98qftjRHuKLK3A4VM/L7bS8elYXfkYkR+LIw==
Date: Tue, 3 Dec 2024 14:55:44 +0100
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Denton Liu <liu.denton@gmail.com>
Subject: Detecting squash-merged branches (and question about git-diff-tree)
Message-ID: <Z08N4AlQKiNi-IOI@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I tend to work on project which do a lot of "squash-merging" e.g, merge
branches by having a robot squash the branch in a new commit on top of
the main branch.

This makes it a bit hard to remove my branches when they are
"squash-merged" (in contrast to using `git branch --merged`)


I started a little script to detect such branches; initially I used git
cherry, but this only detect the case where the branch has 1 commit,
which is not enough.

Sharing below if anyone is interested and/or want to give some feedback
(warning, this is probably full of bash-ism/gnu-ism).

Which leads me to my actual question:
I wanted to use diff-tree in --stdin mode (instead of calling it
repeatedly in a loop), feeding it my target branch and
the list of relevant commits, but apparently --merge-base and --stdin
are mutually exclusive. What's the reason for that ?
I suppose it's related to the 3 possible line forms diff-tree accepts in
--stdin mode, but I didn't find a spelled out explanation in the
original thread implementing --merge-base [1].

Is there another alternative for computing the patches ids of branches
in that way ? A '%(mergebase)' token for git for-each-ref would also
work, but there is no such thing either that I know of. 

(Of course, the script as such runs ~reasonably~ well, but it does spend
95% of it's time waiting for subprocess, which bugs me a little^^)

Thanks for reading me !

[1]: https://lore.kernel.org/git/cover.1599332861.git.liu.denton@gmail.com/

---

#!/bin/bash
# $1 : target ref (in which we search for squashed branches)
# (default: upstream/HEAD)
# ${@:2} (all scripts args after the first one): git for-each-ref
# patterns for refs candidates for squash-merge detection
# (default: refs/{remotes/origin,heads}/}

declare -A commit_by_patch_ids
oldest_merge_base=${1-upstream/HEAD}
ref_patterns=${@:2}
ref_patterns=${ref_patterns:-refs/remotes/origin/ refs/heads/}

for ref in $(git for-each-ref ${ref_patterns} \
                --format='%(objectname)' \
                --no-merged=${1-upstream/HEAD} )
do
  patch_id=( $(git diff-tree -p --merge-base ${1-upstream/HEAD} $ref \
              | git patch-id --stable) )
  commit_by_patch_ids[$patch_id[0]]=$ref
  # Caveat:
  # It's possible for different commit to have the save patch-id
  # (for instance on a feature branch do: git checkout feature;git branch
  # old;git rebase main -> old and feature would probably have the same
  # patch-id, if I understand this correctly)
  # proper treatment of this would need to use array of commits by
  # patch-id, but bash does not support multidimensional arrays.

  # Check oldest commit we will need to go back to when checking if a
  # patch-id exist in the source branch.
  # This assumes that branches are not squash-merged before their fork
  # point.  This avoids going back all the way to the first commit,
  # which can be prohibitively expensive on repository with a long
  # history (e.g, linux kernel tree takes 13 minutes on a recent machine
  # for git log -p | git patch-id)
  oldest_merge_base=$(git merge-base $oldest_merge_base $ref)
done

declare -a squashed
# Extract commits whose patch-id exist in the target branch.
#
for patch_id in $(git log -p ${oldest_merge_base}..${1-upstream/HEAD} \
                 | git patch-id --stable | cut -d ' ' -f 1)
do
    if [[ -n "${commit_by_patch_ids[$patch_id]+exists}" ]];then
        squashed+=("--points-at=${commit_by_patch_ids[$patch_id]}")
    fi
done

printf "%s\n" "$(git for-each-ref $ref_patterns \
                    --format='%(refname:short)' \
                    ${squashed[@]})"

-- 
Max Gautier
