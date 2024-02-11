Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F133F9FA
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640506; cv=none; b=Vly1MQD43NsVvtl2AOgNuVZjtgmHVqjFSR6vztQ4e/4Wp3oSBTrDZa4rOa3DvlrFazj4AD1JAaaMHifV3uNhboiX5bcUpPu9YYTzhPAdHzq9l0jwvXunrwI/QnpbvdRJa+F+iLOqQwWcG/YYy+2PGXrUcCKTqxVUcypqH23heNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640506; c=relaxed/simple;
	bh=jsRF8SZsoaO0P2RfsBGY0ivu1jooxEKXCImS3YAjP78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnK5tUzqb2wX7Yuq6WzJ+wU9gjJe76s8gybZseArcYKf3KZCvWEw9E3CfEww+ZNcIwVl6ydzC6fRnISIaMgrCrqDZ4B8ti96cdH4DYaMcGW7VbWABBY1Z8yyjchWHRsFk5cC+cwisE5C9wSAprxqj1l1OQ9HsYYclYj+L5g8dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4TXgrH5330z5vBM
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 09:34:55 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4TXgqp10Zsz5tlF;
	Sun, 11 Feb 2024 09:34:30 +0100 (CET)
Message-ID: <2cf557e9-bf48-4bf3-be24-c1eeaa887418@kdbg.org>
Date: Sun, 11 Feb 2024 09:34:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, Michael Lohmann
 <mial.lohmann@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Patrick Steinhardt <ps@pks.im>, Michael Lohmann <mi.al.lohmann@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for stepping in and resubmitting with an extended commit
message and documentation!

Am 11.02.24 um 00:35 schrieb Philippe Blain:
> From: Michael Lohmann <mi.al.lohmann@gmail.com>
> 
> 'git log' learned in ae3e5e1ef2 (git log -p --merge [[--] paths...],
> 2006-07-03) to show commits touching conflicted files in the range
> HEAD...MERGE_HEAD, an addition documented in d249b45547 (Document
> rev-list's option --merge, 2006-08-04).
> 
> It can be useful to look at the commit history to understand what lead
> to merge conflicts also for other mergy operations besides merges, like
> cherry-pick, revert and rebase.
> 
> For rebases, an interesting range to look at is HEAD...REBASE_HEAD,
> since the conflicts are usually caused by how the code changed
> differently on HEAD since REBASE_HEAD forked from it.
> 
> For cherry-picks and revert, it is less clear that
> HEAD...CHERRY_PICK_HEAD and HEAD...REVERT_HEAD are indeed interesting
> ranges, since these commands are about applying or unapplying a single
> (or a few, for cherry-pick) commit(s) on top of HEAD. However, conflicts
> encountered during these operations can indeed be caused by changes
> introduced in preceding commits on both sides of the history.

I very much agree. Thank you for spelling it out!

> Adjust the code in prepare_show_merge so it constructs the range
> HEAD...$OTHER for each of OTHER={MERGE_HEAD, CHERRY_PICK_HEAD,
> REVERT_HEAD or REBASE_HEAD}. Note that we try these pseudorefs in order,
> so keep REBASE_HEAD last since the three other operations can be
> performed during a rebase. Note also that in the uncommon case where
> $OTHER and HEAD do not share a common ancestor, this will show the
> complete histories of both sides since their root commits, which is the
> same behaviour as currently happens in that case for HEAD and
> MERGE_HEAD.

Well explained!

> 
> Adjust the documentation of this option accordingly.
> 
> Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Co-authored-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> [jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Signed-off-by trailers should occur in temporal order. Therefore, when
you pick up a commit and resend it, you should keep existing
Signed-off-by and add yours last.

> ---
>  Documentation/gitk.txt             |  8 ++++----
>  Documentation/rev-list-options.txt |  6 ++++--
>  revision.c                         | 31 +++++++++++++++++++++++--------
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index c2213bb77b..80ff4e149a 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -63,10 +63,10 @@ linkgit:git-rev-list[1] for a complete list.
>  
>  --merge::
>  
> -	After an attempt to merge stops with conflicts, show the commits on
> -	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
> -	that modify the conflicted files and do not exist on all the heads
> -	being merged.
> +	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
> +	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
> +	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
> +	when the index has unmerged entries.

Unfortunately, this patch does not help gitk. Gitk has its own logic to
treat --merge and needs its own patch. This hunk should not be part of
this patch.

>  
>  --left-right::
>  
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 2bf239ff03..5b4672c346 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -341,8 +341,10 @@ See also linkgit:git-reflog[1].
>  Under `--pretty=reference`, this information will not be shown at all.
>  
>  --merge::
> -	After a failed merge, show refs that touch files having a
> -	conflict and don't exist on all heads to merge.
> +	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
> +	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
> +	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
> +	when the index has unmerged entries.

Good. I used --left-right to check that the direction is indeed
HEAD...$OTHER and not $OTHER...HEAD.

-- Hannes

