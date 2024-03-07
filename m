Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFF82D9C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805524; cv=none; b=DiGBandzSkyO0OYoWeABdPzVzCoYdOzLkseN+PdV/2pyhtxNIlwazS8xNadKPpAsSwaKzf8E+4kbmo6hAFQeSgjaOCyVz9RNGNcHLSDBzYVSRerW0ahpvys/7487zTtVQWFd7QZkQkgeTI3c34dhgnENYdahcqE+OSf9erQzjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805524; c=relaxed/simple;
	bh=ArgoCyd2iiQHPcSZPyD1hpNCISB9fH13MDO7vk0CS5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftN5zFRBGWu0gXtEZSBIeXiDjWcwKP9qeotShzIrKC/G+2MchwuJuRIq0Qcy9pm3PuszmciCXtqa1Fq3lrx99SlDHSXcvRcVLSeaSW3lBeYIBjKMrYQBMZ+wREZldJgBdKqbe445rfOIYmOwAUhyBpnVhbzwaamghfHCbfeq0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7233 invoked by uid 109); 7 Mar 2024 09:58:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:58:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12983 invoked by uid 111); 7 Mar 2024 09:58:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:58:46 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:58:41 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] mem-pool: add mem_pool_strfmt()
Message-ID: <20240307095841.GD2650063@coredump.intra.peff.net>
References: <20240225113947.89357-1-l.s.r@web.de>
 <20240225113947.89357-2-l.s.r@web.de>
 <20240226070844.GB780982@coredump.intra.peff.net>
 <1868c502-b915-42fd-8cb2-efe90429f9b7@web.de>
 <20240227075350.GE3263678@coredump.intra.peff.net>
 <3aed87d0-4789-4e96-8c6c-31cab2d996cc@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aed87d0-4789-4e96-8c6c-31cab2d996cc@web.de>

On Tue, Feb 27, 2024 at 06:58:26PM +0100, René Scharfe wrote:

> >> It would not allow the shortcut of using the vast pool as a scratch
> >> space to format the string with a single vsnprintf call in most cases.
> >> Or am I missing something?
> >
> > So here it sounds like you do care about some of the performance
> > aspects. So no, it would not allow that. You'd be using the vast pool of
> > heap memory provided by malloc(), and trusting that a call to malloc()
> > is not that expensive in practice. I don't know how true that is, or how
> > much it matters for this case.
> 
> In the specific use case we can look at three cases:
> 
> 1. xstrfmt() [before 1c56fc2084]
> 2. size calculation + pre-size + strbuf_addf() [1c56fc2084]
> 3. mem_pool_strfmt() [this patch]
> 
> The performance of 2 and 3 is basically the same, 1 was worse.
> 
> xstrfmt() and strbuf_addf() both wrap strbuf_vaddf(), which uses
> malloc() and vsnprintf().  My conclusion is that malloc() is fast
> enough, but running vsnprintf() twice is slow (first time to determine
> the allocation size, second time to actually build the string).  With a
> memory pool we almost always only need to call it once per string, and
> that's why I use it here.
> 
> The benefit of this patch (to me) is better code readability (no more
> manual pre-sizing) without sacrificing performance.
> 
> The ability to clear (or UNLEAK) all these strings in one go is just a
> bonus.

Ah, OK. I admit I did not read the series all that carefully. Mostly I
am just concerned about a world where there are parallel-universe
versions of every allocating function that takes a mem-pool. If it's
limited to this obvious string formatting variant that may not be too
bad, though.

-Peff
