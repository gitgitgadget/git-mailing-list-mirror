Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1A1C57A5
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782904; cv=none; b=SfGMMzV4CeOhiuUyXVtjD8axLiaqt/MleRY2KaR1+ANxgSAfcvwgxaXTSY7kZUuu0joGMn/XSyhEozuIOJHVPG8HY+xLRVMRdL8Prju6PTmJo84MbJ6QSawnGo40HaJtck34UyFlfGZzLOk3yLscLsiivJCOIU5ip/9HF21zJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782904; c=relaxed/simple;
	bh=Yh8aqyDbYdgyhkQec+HWJNWYtImRzVurwoirdMadd/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eQMTUHYRlFkXfWnKk9JynfktSKCGMJTfzTQApSJWIc3DMQaJXYeqocxxX4LQV3wy+qfLI1z4IjZeyG5aX1GcSaBGqKez11JHKIE2NI47oay7nCx6iJs8vjBt8tVF5AmXp3JxVi3g1tu6Fd+vf/5HES8UCGuwWl6R7ciO5eXx3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bmLBmi+v; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bmLBmi+v"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEB6836C16;
	Tue, 27 Aug 2024 14:21:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Yh8aqyDbYdgyhkQec+HWJNWYtImRzVurwoirdM
	add/o=; b=bmLBmi+vfGhXv5GtMw5s+v2Rtj2uODywHT1/JAPIhxc743DkDStkQ2
	s5YvpzyKBn2bEN2gRdTb0HiAmIpXmmJa3mYSIH+h+kc4PMGZRX9gyei16kiDoI9H
	Ba8pHAbpkZ4SMhw1m69vKBHdTeOSvlthzbBPcBu7yxc+vFkyTCHXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6D9136C15;
	Tue, 27 Aug 2024 14:21:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25FE736C14;
	Tue, 27 Aug 2024 14:21:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
In-Reply-To: <Zs353oLDaw2SbNQs@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 28 Aug 2024 00:07:58 +0800")
References: <Zs348uXMBdCuwF-2@ArchLinux> <Zs353oLDaw2SbNQs@ArchLinux>
Date: Tue, 27 Aug 2024 11:21:34 -0700
Message-ID: <xmqqjzg1aksx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 31E9FEC6-64A1-11EF-BD41-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> We implicitly rely on "git-fsck(1)" to check the consistency of regular
> refs. However, when parsing the regular refs for files backend by using
> "files-backend.c::parse_loose_ref_contents", we allow the ref content to
> be end with no newline or contain some garbages.

"to be end with" -> "to end with".
"or contain" -> "or to contain" (optional, I think).

Or "... the ref content without terminating newline, or with extra
bytes after the terminating newline."

> It may seem that we should report an error or warn fsck message to the
> user about above situations. However, there may be some third-party
> tools customizing the content of refs. We should not report an error
> fsck message.

    Even though we never created such loose refs ourselves, we have
    accepted such loose refs forever, so it is entirely possible
    that third-party tools may rely on such loose refs being valid.
    Let's notice such a "curiously formatted" loose ref files and
    tell the users our findings, so that we can assess the possible
    extent of damage if/when we retroactively tightened the parsing
    rules in the future.

> We should not allow the user to upgrade the fsck warnings to errors. It
> might cause compatibility issue which will break the legacy repository.

I am not sure this is a right thing to say.  If the user wants to
ensure that the tool they use in their repository, which may include
some third-party reimplementation of Git, would never create such a
(semi-)malformed loose ref files, it is within their right, and it
is the most reasonable way, to promote these "curiously formatted
loose ref" fsck warnings to errors.

Is your "We should not allow" above backed by code that prevents
them from promoting the warnings to errors, or is it merely a
declaration of your intention?

> So we add the following two fsck infos to represent the situation where
> the ref content ends without newline or has garbages:
>
> 1. "refMissingNewline(INFO)": A valid ref does not end with newline.
> 2. "trailingRefContent(INFO)": A ref has trailing contents.

OK.

> In "fsck.c::fsck_vreport", we will convert "FSCK_INFO" to "FSCK_WARN",
> and we can still warn the user about these situations when using
> "git-refs verify" without introducing compatibility issue.

OK.

> In current "git-fsck(1)", it will report an error when the ref content
> is bad, so we should following this to report an error to the user when
> "parse_loose_ref_contents" fails. And we add a new fsck error message
> called "badRefContent(ERROR)" to represent that a ref has a bad content.

Good.

> @@ -170,6 +173,12 @@
>  `nullSha1`::
>  	(WARN) Tree contains entries pointing to a null sha1.
>  
> +`refMissingNewline`::
> +	(INFO) A valid ref does not end with newline.
> +
> +`trailingRefContent`::
> +	(INFO) A ref has trailing contents.
> +
>  `treeNotSorted`::
>  	(ERROR) A tree is not properly sorted.

There is no mention of "you shouldn't promote these to error" here,
which is good.  But wouldn't we want to tell users to report such
curiously formatted loose refs, after figuring out who created them,
to help us to eventually make the check stricter in the future?

Git 3.0 boundary might be a good time to tighten interoperability
rules such that we won't accept anything we wouldn't have written
ourselves (not limited to loose ref format, but this applies to
anything on-disk or on-wire), but we'd need enough preparation if we
want to be able to do so in the future.

Thanks.


