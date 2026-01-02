Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F811397
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767334590; cv=none; b=TrLnRNipG+egl+3z9DvFb6RPkzWo9UnIbcYPVyOWFezRB+YUvPCJFtUyJf4xXRrQ0j8AyAvOtJzD2O/Le+RvJUpVi3axLZS+Xd28uTlUyazKcN/KH9/Ra/3dV5vHPoB8TnLmszW5Fu1HDBxpwwUn0I0SiVrJGXndcaeLfgaC2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767334590; c=relaxed/simple;
	bh=riBhv38UeLNYorPAb8OUuHlh3oDi+mqUFMTscVtF6uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3WT5mWuP+ruchHq7TN73lNiXCtAU7WqQckxHRX5ScIS+c/u4aV6zgQWb/VkDbYqZpTpCx3IQJCRpwNBCAUG8/9MRQkRly+iMl4dCJdejOay+V9QjLKQontqckL3wrz+m07d+eG3xAvqtSuno92QvUaGWDSE7YEBeTJZL+kPEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TjPrN1Y2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TjPrN1Y2"
Received: (qmail 552304 invoked by uid 109); 2 Jan 2026 06:16:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=riBhv38UeLNYorPAb8OUuHlh3oDi+mqUFMTscVtF6uU=; b=TjPrN1Y2APLtFJPouxE6wvc7earlH3p8d/jX7D8SJ7ifOjbdHibk/n2qhT5k76sJuLjSG4sl9L2MnFH0JVWrleeO+yL57DkmZ2d7307hLUX5I1ZGwvRshtYBHcbPX1WQrID8/ms4dLJQF5UM4qF/FPyHdcpWHbdUO4dCqHDzj5XgqyadYBaP/4pxjjzdUkf/IroY6/e6mSFEOf7gik1AESJpVJBzY/w5+uUqdbf0ciyr7P3wx6VnR/SQRku0l/kQFmlli8pWx0etrQ3T7xu/lB/eWXnDIgm9nTQ6OR0HVkSAdxgzuIAbFAuRNbYkkDX3nBJoSQP0SwYULeg9IoHUAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Jan 2026 06:16:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 719071 invoked by uid 111); 2 Jan 2026 06:16:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Jan 2026 01:16:31 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Jan 2026 01:16:27 -0500
From: Jeff King <peff@peff.net>
To: Rostislav Krasny <rostiprodev@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 1/1] compat: modernize and simplify byte swapping
 functions
Message-ID: <20260102061626.GA2581074@coredump.intra.peff.net>
References: <20260102002735.31390-1-rostiprodev@gmail.com>
 <20260102002735.31390-2-rostiprodev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260102002735.31390-2-rostiprodev@gmail.com>

On Fri, Jan 02, 2026 at 02:27:35AM +0200, Rostislav Krasny wrote:

> Replace manual bit operations with memcpy + network functions for better
> maintainability. Add missing 16-bit network byte order conversion.

This is burying the lede a bit, as they say. I don't know that the
maintainability is much changed, especially as these are not functions
that anybody looks at or touches very often.

But this part might be compelling:

> - Performance improvements (GCC 15.2.1, Clang 21.1.7):
>   * on x86-64 with -O0 4.2x faster (GCC), 3.7x faster (Clang)
>   * on x86-64 with -O1 4x faster (GCC), identical (Clang)
>   * on x86-64 with -O2 identical (GCC), 1.8x faster (Clang)

The -O0 numbers are IMHO not very interesting (and are entirely
expected; you are comparing optimized library memcpy versus unoptimized
assignments). But clang making -O2 faster is quite interesting.

If we are going to do this, I think it would be for the improved
performance. And it would be nice for the commit message to go into
details about what was measured and how. I'll respond elsewhere in the
thread with some more thoughts.

-Peff
