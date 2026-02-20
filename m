Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3D199EAD
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608938; cv=none; b=Xf8YngWOWN8ntQKXaAa7C7YaLKZkYDBKmK7U3BBDOUYe2c3+RJYW4ldwfH1JVvDkKH4YnrerV/l+cHd1s77Yom1Y5zjtLmszwwj4wPtMt8dtlB70a6Q8wxIMyklKAQiJGq4HjALa6zD4p+TfMyBmLKnrKp2sZi5B56X7SuilcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608938; c=relaxed/simple;
	bh=6esR4aacEiWSpZAr6YoF0fhz0pEydllV5qD54qHVFaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I5STTaZiMVkYmbwGcFIhJQLsQbmWos1a387MNq7c3XGYTkDev1v/+h2JOFcgB/MmRbjn2CDDKfQ8Yai63KsfpQwFby+H2lB3JrnyxJ2fyWs30wZ2bb5RIXkg2UmcfPWsYJx5xteoit3mJvctH+75rLDo5nK2qUKM+4q1ih25dI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=13bHhDHE; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="13bHhDHE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771608932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyXZQ/FPWgtWDOifHlW8MozHeZ1o4T1TDcj22FX4K1M=;
	b=13bHhDHEJWwSOyiHi0Ub1In74duBGvGeIwcCq2JwiHv92VaEJ9ZiN/+3M9kkaqyfyQe3W1
	w4rzNab5UxOb3GzFh4XR+WpfRLctEDUnlp7JwwGicv8KlrhuypGw1GQjDOMJ9bqz79PzVy
	yrjV+jNCf9Te9xfn+n+DT+HVL6DCW7I=
From: Toon Claes <toon@iotcl.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de, Siddharth Asthana
 <siddharthasthana31@gmail.com>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit changes
In-Reply-To: <20260218234215.89326-3-siddharthasthana31@gmail.com>
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-3-siddharthasthana31@gmail.com>
Date: Fri, 20 Feb 2026 18:35:21 +0100
Message-ID: <87tsvbe2sm.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Add a `--revert <branch>` mode to git replay that undoes the changes
> introduced by the specified commits. Like --onto and --advance, --revert
> is a standalone mode: it takes a branch argument and updates that branch
> with the newly created revert commits.
>
> At GitLab, we need this in Gitaly for reverting commits directly on bare
> repositories without requiring a working tree checkout.
>
> The approach is the same as sequencer.c's do_pick_commit() -- cherry-pick
> and revert are just the same three-way merge with swapped arguments:
>
>   - Cherry-pick: merge(ancestor=parent, ours=current, theirs=commit)
>   - Revert: merge(ancestor=commit, ours=current, theirs=parent)
>
> We swap the base and pickme trees passed to merge_incore_nonrecursive()
> to reverse the diff direction.
>
> Revert commit messages follow the usual git revert conventions: prefixed
> with "Revert" (or "Reapply" when reverting a revert), and including
> "This reverts commit <hash>.". The author is set to the current user
> rather than preserving the original author, matching git revert behavior.
>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Elijah Newren <newren@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  Documentation/git-replay.adoc |  37 +++++++-
>  builtin/replay.c              |  25 ++++--
>  replay.c                      | 162 ++++++++++++++++++++++++----------
>  replay.h                      |  11 ++-
>  t/t3650-replay-basics.sh      | 107 ++++++++++++++++++++--
>  5 files changed, 277 insertions(+), 65 deletions(-)
>
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index 8d696ce3ab..ffdf790278 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>  SYNOPSIS
>  --------
>  [verse]
> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>
> +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...

The modes `--onto`, `--advance` and `--revert` seem to be extremely
different from each other. So I'm starting to wonder whether it won't
make more sense to instead create subcommands instead of options for
these. Maybe something like:

    git replay revert --base=<branch> <revision-range>
    git replay pick --base=<branch> <revision-range>
    git replay replay --base=<branch> <revision-range>


-- 
Cheers,
Toon
