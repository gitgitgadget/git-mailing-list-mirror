Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A0145346
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057299; cv=none; b=QWdWa0VD0NE76fRzsAOrj+9kFwsFj8pbZlENCX+ggx3J2G2BH2Kn/01oMbViYODYlVQjw33u3GlYM5unTOPQkMD8sKDvAENMbQIMSRWHjUcoPaos+7tpmXr596iSBfn3j6DUxk7wZvhT+nXuUCcqiM1loFWUOrA1mJGYGNltfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057299; c=relaxed/simple;
	bh=YIvCR2X3zIY9wq8jfNNrkLgDVMqrK1li0rEiEGzrf9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jC7oXGwRrRwZtvuRYSo/BpE/A/10ngsbRQzR/NAHH9i4VxKa2yvOSh0vqPsd0vA7Q08zmooSeJseMhcYkI0Qyn9wWjXKyxBQoZIm+hXQyBH38F5GoIGbZNSV/pCf1wafJHkPvIdYmHrO8WLjnemBOHPbYuqyWioNZehp7yrXHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bNibdFQ3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNibdFQ3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 35154247A2;
	Tue, 27 Feb 2024 13:08:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YIvCR2X3zIY9wq8jfNNrkLgDVMqrK1li0rEiEG
	zrf9E=; b=bNibdFQ3kwtd41IxJgnhpzxen6ntsxjqebob5mpwmi4z5jUIPrZMm5
	AIVc70NfLSrQPktDRRj7DelGmBGd07VhJVvOW3LueoCgVpw20zbPjZFqtScHxOaQ
	s7pfgv5OeVaq3yb/LTn1BatMvuP44Jo/KSPS0N8ZrnXOiAmn1fq8M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E02724799;
	Tue, 27 Feb 2024 13:08:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 589C524796;
	Tue, 27 Feb 2024 13:08:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Dirk Gouders <dirk@gouders.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 04/11] Prepare `paint_down_to_common()` for handling
 shallow commits
In-Reply-To: <79914d16-f58d-7ab0-5c25-f29870a73402@gmx.de> (Johannes
	Schindelin's message of "Tue, 27 Feb 2024 16:00:46 +0100 (CET)")
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<84e7fbc07e08956e6c493baf499fee455887b16c.1709040499.git.gitgitgadget@gmail.com>
	<gha5nmnex4.fsf@gouders.net>
	<79914d16-f58d-7ab0-5c25-f29870a73402@gmx.de>
Date: Tue, 27 Feb 2024 10:08:11 -0800
Message-ID: <xmqqcyshu6es.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C3B5DFC-D59B-11EE-AE31-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Currently, that logic pretends that a commit whose parent
> 	commit is missing is a root commit (and likewise merge commits
> 	with missing parent commits are handled incorrectly, too).
> 	However, for the purpose of `--update-shallow` that is exactly
> 	what we need to do (and only then).

I suspect that what made it harder to follow in the original
construct is that we called the behaviour "incorrect" upfront and
then come back with "that incorrectness is what we want".  I wonder
if it makes it easier to follow by flipping them around.

    For the purpose of `--update-shallow`, when some of the parent
    commits of a commit are missing from the repository, we need to
    treat as if the parents of the commit are only the ones that do
    exist in the repository and these missing commits have no
    ancestry relationship with it.  If all its parent commits are
    missing, the commit needs to be treated as if it were a root
    commit.

    Add a flag to optionally ask for such a behaviour, while
    detecting missing objects as a repository corruption error by
    default ...

or something?

> 	Therefore [...]
>
> Better?
>
> Ciao,
> Johannes
