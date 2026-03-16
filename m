Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EC3E929D
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690850; cv=none; b=s9KqFA96x1LtsH8rpKmSRDD3pM99UQ1Q/FMhYxVgbymL8xqbhcRL1f5H977BiuZ1lGzRJYbErD4wVXZvl2Pr3VKbCect26idQtrdJjnt8HOSW16UB6tbO0BjOMc33RN9eLjc6ZBYOgQETuV3/ViwapvUD+5hwxZvb8EZ+aiggzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690850; c=relaxed/simple;
	bh=gbP80IbdhJLwzcK+vRvClV1/56BjvsGTz9MFGkI3xLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNunY0s/Zny5bqj19/suL2445d5FOXhSqiLgNdgMVvVk2MEE0b3FUqmYQ/VW/07FTM8FmRMtcl5QBIHNKFh7QLnisLH+GPf8MNuv+bibNdi2kuJ0D+IeSk89U2mSUQ19t015VY1sbzJXaiiA34CiBgbf4cPqbOBRV413fm8rjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VTaI67Ym; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VTaI67Ym"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773690846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4+t9CT/sDo8aplQfwfsv8QJyn50xbtqdhaBNKTvvWk0=;
	b=VTaI67YmVqXqYn3syxqEISG+xLdT58sjAaDAubdTh8B4eSME3au8BwqqloafZ8KegS1UMd
	RIZkEaf41VNPHSKd19XCPmnGOPnfDc1p0bVOQMSoNkv4j7YtZf/t9GYQACgsxtIzv1yAbN
	QcT+1vEhUdpzHf0DGCJ2xm1whFIGrUs=
From: Toon Claes <toon@iotcl.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, Siddharth Asthana
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH v4 0/2] replay: add --revert mode to reverse commit changes
In-Reply-To: <20260313054035.26605-1-siddharthasthana31@gmail.com>
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-1-siddharthasthana31@gmail.com>
Date: Mon, 16 Mar 2026 20:53:52 +0100
Message-ID: <87ikavsg8f.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Hi,
>
> git replay currently supports cherry-picking (--advance) and rebasing
> (--onto), but not reverting. We need this at GitLab for Gitaly to
> reverse commits directly on bare repositories without a checkout.
>
> The approach is the same as sequencer.c -- cherry-pick and revert are
> just the same three-way merge with swapped arguments. We swap the base
> and pickme trees passed to merge_incore_nonrecursive() to reverse the
> diff direction.
>
> Patch 1 extracts the full revert message formatting logic into a new
> sequencer_format_revert_message() function, following Phillip's
> suggestion to move everything into one shared function rather than
> just the header. refer_to_commit() is updated to take a struct
> repository and a bool instead of replay_opts so it works outside the
> sequencer.
>
> Patch 2 adds --revert <branch> as a standalone mode. Reverts are
> processed newest-first (matching git revert) to reduce conflicts by
> peeling off changes from the top.
>
> The series is based on top of d181b9354c (The 13th batch, 2026-03-07).
>
> CI: https://gitlab.com/gitlab-org/git/-/pipelines/2329880894
> The msvc-meson / Chocolatey failures are pre-existing infrastructure
> issues unrelated to this series.
>
> Changes in v4:
> - Replaced sequencer_format_revert_header() with a more complete
>   sequencer_format_revert_message() that handles everything: subject
>   prefix, commit reference via refer_to_commit(), and merge-parent
>   references -- per Phillip
> - Updated refer_to_commit() signature to take (struct repository *r,
>   bool use_commit_reference) instead of (struct replay_opts *opts)
> - Reverts are now newest-first (revs.reverse = 0 for --revert),
>   chaining on last_commit rather than the parent mapping
> - Changed doc example to cross-branch scenario and restored the
>   merge-tree NOTE
> - Updated error message format to "'--revert' cannot be used with
>   multiple revision ranges..." (and same for --advance)
> - Empty revert commits are now dropped, consistent with cherry-pick
> - Link to v3: https://public-inbox.org/git/20260218234215.89326-1-siddharthasthana31@gmail.com/
> - Link to v2: https://public-inbox.org/git/20251202201611.22137-1-siddharthasthana31@gmail.com/
> - Link to v1: https://public-inbox.org/git/20251125170056.34489-1-siddharthasthana31@gmail.com/
>
> Thanks,
> Siddharth

I've added various nitpicks here and there. Overall nothing really
blocking for a reroll I think, but maybe the combination of them all is.

-- 
Cheers,
Toon
