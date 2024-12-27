Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CC320B
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310172; cv=none; b=dRN00J3urou9O7c0MpSMns0MZwUPeIZanoYyzmBMQiSRBYd2/3FSVB6dp7a9D2AtrxEe41RB1oJHot7iZfAMqIfGC6w0tEVZaCJWYhlM8bIXqEQLy+k4H2Rjl5hO2+2H2FgvDaJd3fzUvabD6ma4FPBhSodySTihO8RJzaUo7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310172; c=relaxed/simple;
	bh=lkh5zj4sXMYBfH/H47X1HFz4LX2TLVsGp92FrSBpYAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI+0GK+hj040+/plFMKShcodnPvdmGddsZlrHJy3BznC2yJc1eyA4ImVDxs/21pnX2v7ynoB2xqv/e7AgWgFpbUa83FODaZJe52wuHtPwTNYc9s6l2q8UPGGM+Ss92Llfm8QkzhkVxsNLCHNGEmt4r0Fd4/uWL+QCD/BTUjbaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gXYlL+Lh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gXYlL+Lh"
Received: (qmail 7982 invoked by uid 109); 27 Dec 2024 14:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lkh5zj4sXMYBfH/H47X1HFz4LX2TLVsGp92FrSBpYAM=; b=gXYlL+Lh+seUaG4fyeYrqoybdgMzkLGLhtRNPbYxLjeUgt2JfHh50gY+Ss/3j3vQP/veHEz99jptnHcxVjC/LZu9SrMltffcU6mPC7wEa6tNmMU3VikkqLeHEFii6V85mfrMSJJHWQQyHeFF9SwxFZ35ZgClv4r703a7XaYBx6cOcSSuTdec5at48QYKbYLBBty0IjGvWpkBQXc0M0TcmKGrnjOqxQyvpJW2BgAOzxFZc3MPpZQWrFTaQw5m8xvGCGwLyo56zlqINh6AWHsjor0oRyZFm7ozLWwYFyD2OTFNX3GTJIqpw/MMIqyS08NEEa7lrgn0rDIZNIrqToJq3w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Dec 2024 14:36:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14462 invoked by uid 111); 27 Dec 2024 14:36:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Dec 2024 09:36:08 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Dec 2024 09:36:08 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] prio-queue: fix type of `insertion_ctr`
Message-ID: <20241227143608.GC88306@coredump.intra.peff.net>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-1-07c59c2aa632@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-1-07c59c2aa632@pks.im>

On Fri, Dec 27, 2024 at 11:46:21AM +0100, Patrick Steinhardt wrote:

> In 62e745ced2 (prio-queue: use size_t rather than int for size,
> 2024-12-20), we have converted `struct prio_queue` to use `size_t` to
> track the number of entries in the queue as well as the allocated size
> of the underlying array. There is one more counter though, namely the
> insertion counter, that is still using an `unsigned` instead of a
> `size_t`. This is unlikely to ever be a problem, but it makes one wonder
> why some indices use `size_t` while others use `unsigned`. Furthermore,
> the mentioned commit stated the intent to also adapt these variables,
> but seemingly forgot to do so.
> 
> Fix the issue by converting those counters to use `size_t`, as well.

Yep, this looks good, and was what I meant to send in 62e745ced2.

-Peff
