Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF392E630
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526678; cv=none; b=pEpGAb6ejBzzQNAJfuN9dPzJNcTMhWEaNWwP/33ogIKm4idSrd3hGnirMKkwd0Sv2zyd8dxbIcbLap3G79Ri/MDgLnbszeRctzRu28FXEUQGUOslzw0WTb3m7hfjcJDs8Df9Aws1y7NXgpMPxixftzuQFoNXDqt5LiDBlaf1Xbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526678; c=relaxed/simple;
	bh=/HYKmDfrVt7QTWP8VelZ07QCHzBeaEZjLWRc8ussDMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIqhGpLRnXOgCDZh7tCch9OGbhfYay4AwHneoIA/EX45LxWaU456ldLFCOBie8IG346DW95bUCPsD3hXsNOq2qDpj+y0dJMGwOOQsL8zQQ+y2sdadSdIPXPm+2nnspETKElmMwdIS6BYtKbvFq1dd5c8QDM7ZrPANEdb58RB2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L9n+8UwH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L9n+8UwH"
Received: (qmail 7378 invoked by uid 109); 18 Dec 2024 12:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/HYKmDfrVt7QTWP8VelZ07QCHzBeaEZjLWRc8ussDMc=; b=L9n+8UwHD3bqOUya8hl6JPByvPS0pBjnhEAVI9hF+hak5HhIciUxh6ziDDr5RcNkrm5Y8RXgvbgDOiuF9mo3GVzjJCYWzSFFjbHIaWHAFuWooucGQ9RBk2VoUm3nSHOp5rmOQcKH+HEl32ZWnXRrs9u1KexqsoalMBmpBJ0GsC4/0NTs5YmV0d2lxkdu+hHAKKeUYTrXHNwYPvRq4mvP0NrOqLzJjWBP/oCW1QtfxPlq+KTrR/dlNmRF8XoytccPScJGC84ULsdvhDRMFkul9tCNHqqy/vDcDsrKbksAc/ghsbdBkSW7YgMw7g1Vu13B2bu+wT924nOdh5UU2BtWDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Dec 2024 12:57:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25390 invoked by uid 111); 18 Dec 2024 12:57:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2024 07:57:54 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Dec 2024 07:57:54 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <20241218125754.GC695807@coredump.intra.peff.net>
References: <cover.1728505840.git.me@ttaylorr.com>
 <20241011083838.GI18010@coredump.intra.peff.net>
 <Zz0aaPdHiFyoRkKg@nand.local>
 <Zz0gdHrwC4CTAtZn@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz0gdHrwC4CTAtZn@nand.local>

On Tue, Nov 19, 2024 at 06:34:12PM -0500, Taylor Blau wrote:

> On Tue, Nov 19, 2024 at 06:08:24PM -0500, Taylor Blau wrote:
> > Then when running the same command, we get results that are quite
> > encouraging. The runtime jumps to 24.213 seconds, which is ~9.73 seconds
> > slower than the average of the baseline measurements. But it takes
> > ~10.418 seconds on my machine to compute the forward index. So it's
> > really around 688ms *faster* than the baseline, despite doing a little
> > more work.
> 
> Sorry, there is a much quicker way to generate the forward index at
> runtime, which is the following:
> [...]

Neat. I didn't see timings for this method, but I'd assume it's quite
fast. So if it shaves off the same 688ms, I'd expect it to be an overall
win. The code itself looks reasonable to me.

I think when you re-post this series it might make sense to add a t/perf
script to demonstrate these timings (not just what we're discussing
here, but also the overall speedup we're hoping to achieve).

-Peff
