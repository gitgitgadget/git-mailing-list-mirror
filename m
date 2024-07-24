Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9071CFB9
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839027; cv=none; b=g2sScUzS9yNCW/CJI6ki/m0J9Dshmnu2JFt6LBWxCYclcg1cvUMadt+joEXDJVUhZ0DnRNluLUUR+25lXsX1KxAfzgquTCvISetV2R9vwTGQJfIlKghP1xmLJR63wiYpvB7XtNQwwWjnAve8C2W1OkJmHeB+EXVA/dm3j473c5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839027; c=relaxed/simple;
	bh=rPl2OtewuBDWcSf1AWaFI5yMSf8T3FGSj4jWWIUFfc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kla7m/+nwdH1xqOeKG6nnLfDbTH8RdpfihIJT8cOtCw7nQ3tG2Kt6NztaXCGtgcEK8CLK6HFPAnZWjBYYKIlPqy+BU1YwvdzQg39uYBaC6as6TwxdTAzU/peJd6UZszXM/zBfGlhKodWyRNNE+o2Mot66Je7lkNxULS3StA6qK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i4yP5m3E; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i4yP5m3E"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0636B19247;
	Wed, 24 Jul 2024 12:37:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rPl2OtewuBDWcSf1AWaFI5yMSf8T3FGSj4jWWI
	UFfc0=; b=i4yP5m3Ec8Px5FaD3hKTxmK1Ex6wA5MoB59h6rbk9PtGd/HlyTYXEc
	JLcCDUTLg85DCfUG3xoFBxSb9bBC/DiJzuCZX/weoxPQ1/cXDIw7Zt4qGGT+1i9I
	7TixU1UJkP8+XkBzvlMP+vE3konKvdYMiCGET/GrrtYqMpIOktjA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E536719246;
	Wed, 24 Jul 2024 12:37:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2820D19245;
	Wed, 24 Jul 2024 12:37:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Robert Coup <robert.coup@koordinates.com>
Cc: git <git@vger.kernel.org>
Subject: Re: bug/defaults: COMMIT_EDITMSG not reused after a failed commit
In-Reply-To: <CAFLLRpJgpjJpNRC_UpZmUXF2626e0BiH8CkOkoMrX3zcrOp7YA@mail.gmail.com>
	(Robert Coup's message of "Wed, 24 Jul 2024 12:28:47 +0100")
References: <CAFLLRpJgpjJpNRC_UpZmUXF2626e0BiH8CkOkoMrX3zcrOp7YA@mail.gmail.com>
Date: Wed, 24 Jul 2024 09:37:01 -0700
Message-ID: <xmqq1q3iyceq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F4E1E650-49DA-11EF-BA76-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Robert Coup <robert.coup@koordinates.com> writes:

> 1. delete COMMIT_EDITMSG on success
>
> 2. reopen COMMIT_EDITMSG on commit if it exists. Maybe logging something like
>    "Restoring previous in-progress commit message..." might explain what's
>    happening.
> 3. if COMMIT_EDITMSG doesn't exist, re-populate from the template before opening
>    the editor. We could also do this for "parsed-as-empty" commit messages.

Unconditionally doing this change would be disruptive to workflows
of existing users.  To them, Git left COMMIT_EDITMSG available even
after the commit to them almost forever, but suddenly it stops doing
so.  Like "git cherry-pick|rebase|revert" that got stopped can be
restarted _with_ some state information with "--continue", offering
this as an optional feature might be a possibility, but I haven't
thought things through.

An obvious and a lot more lightweight first step is to make it clear
(perhaps in the error message after a failed commit---after all,
such a failure from "git commit" should be a rare event) where you
can resurrect the draft commit message from.  That is independent
and orthogonal to the "let's reuse COMMIT_EDITMSG file" change.

A similar issue was reported a few years ago but without any
response or action.

https://lore.kernel.org/git/CAJ2_uEOk8xoLvK8B8PYc0_=kA8W_LqKwGyhKghemQDdRzA2nFA@mail.gmail.com/

Let's see if we find somebody interested in it this time.

Thanks.
