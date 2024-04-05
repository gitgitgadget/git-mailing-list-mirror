Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8493016C858
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339141; cv=none; b=q8h4dEK51KVBh8tVUcaeQe1usQEfOsKpDAei3QFDDftMptxL5njlvE/Ecf0FKeQs2ynww5ccaeGh8L0vFY36dj79crmtNAIEUAxbrfEUjHScfmmr3nbgRiywx2HyKaJM1j/7INQT1VDiJVCULyO2TV3dMu7a8s24hXOHrr/hUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339141; c=relaxed/simple;
	bh=tH5SgAqcczvKSs+ZxzSHkeA+Eq4oYN7ZeM7mqFZJLUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeZh/nRFreCLW1rlkrS7pwyLAHZfxk3vd8pUQDtCxqz7NyGKHyLI3euXOn6YMh9rMQ02THvCdMwiuvnVr8Pg7phx/IbA5fCrBS+j+IrmMsSYJWkyyEF1Xh4AJCagWFKN5DZ6Z7wz8SS+BDgL46dxIrUZJJ53wEZUgLcjzs0MXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18188 invoked by uid 109); 5 Apr 2024 17:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 17:45:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30929 invoked by uid 111); 5 Apr 2024 17:45:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 13:45:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 13:45:37 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
Message-ID: <20240405174537.GD2529133@coredump.intra.peff.net>
References: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
 <20240401033642.GB2639525@coredump.intra.peff.net>
 <9f26b9f0-f8d7-4988-b6d4-e0446dab30b1@web.de>
 <20240403011818.GB892394@coredump.intra.peff.net>
 <b48fd3ee-2975-481f-aa0e-8ec4d07ea705@web.de>
 <20240403204836.GC1949464@coredump.intra.peff.net>
 <6f727926-a901-4d9f-8a7f-d966f222f15d@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f727926-a901-4d9f-8a7f-d966f222f15d@web.de>

On Fri, Apr 05, 2024 at 03:10:33PM +0200, René Scharfe wrote:

> >>>  	memcpy(msg, prefix, prefix_len);
> >>>  	p = msg + prefix_len;
> >>> -	if (vsnprintf(p, pend - p, err, params) < 0)
> >>> +	if (vsnprintf(p, pend - p, err, params) < 0) {
> >>> +		if (snprintf(p, pend - p, "could not format error: %s", err) < 0)
> >>>  		*p = '\0'; /* vsnprintf() failed, clip at prefix */
> >>> +	}
> >>>
> >>>  	for (; p != pend - 1 && *p; p++) {
> >>>  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
> >>>
> >>> Though most of the rest of the function is not that useful (it is mostly
> >>> removing unreadable chars, and hopefully we do not have any of those in
> >>> our format strings!).
> 
> Hmm, this might be worth doing to avoid messing up the terminal if
> 'err' points into the weeds for some reason.

I think we have bigger problems if "err" is messed up, because we'll be
interpreting garbage as a format string and almost certainly triggering
undefined behavior. And in general if we are not using a constant string
as the format it's a potential security vulnerability. So I think we can
mostly rely on the compile-time -Wformat checks for this.

> OK, right, a format error doesn't have to be fatal and we can keep
> running and possibly provide more details.
> 
> But mixing the format error with the actual payload message is not ideal.
> At least we should give the format error its proper prefix, while still
> reporting the prefix of the original message, e.g. like this:
> 
>    error: unable to format message: unable to open loose object %s
>    fatal:
> 
> ... or this:
> 
>    error: unable to format message: fatal: unable to open loose object %s
> 
> I tend to like the first one slightly better, even though the empty
> message looks silly.  It doesn't mix the two and answers the questions
> that I would have:  Why did the program stop?  Due to a fatal error.
> Why is the fatal message silent?  The preceding error explains it.
> 
> While the second one only reveals the fatality somewhere in the middle
> of the text, weakening the meaning of prefixes.

Yeah, I think your first one is good. It's _ugly_, but it's easy to
figure out what happened, and this is not something people generally see
(and the status quo is just "fatal:", so you're easily 50% less ugly).

> I still don't know why the error code varies between runs, but it
> clearly does not come from vsnprintf(3) -- if I set errno to some
> arbitrary value before the call, it is kept.  Which is enough to
> convince me to ignore errno here.

Agreed. Thanks for digging into it.

-Peff
