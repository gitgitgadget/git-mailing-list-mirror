Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100A329C71
	for <git@vger.kernel.org>; Fri, 15 May 2026 04:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820290; cv=none; b=sR90rCKQSSX1Ty/RP78UIbtG45WZ5WM5Rt3iXqpswXj3QhfoOz5SggHUk7sEKUOazIHf4/jDQapmrdXGCloVXcpaf36gxR3VpfBprdq/gUMDqW7HrCtACl+trqhw1kxzYAFZikSqN1etbEcN3MSH2bVXVLCwwL9kyoMARvENASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820290; c=relaxed/simple;
	bh=Gvjov9W49NsJQ43fbdkJfHK4BUIqjxJavrPyDiO2u7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnEIVpU8QUY+0hAgo3gsXl1rK53+RK1MagOf2WR2aJIooYkOVOc0f9ZmNKOTQP1ouscj8J8OEsyUwAgIj1vvJHxs09F3ZKT+yt7n0WsA1TI2/Z4o+q0f2OW4KlnsswrNXqtqMRqwPHByOHnwHoeA8BTxXk8+8hBRea7S4shgqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iQq8nmwM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iQq8nmwM"
Received: (qmail 52857 invoked by uid 106); 15 May 2026 04:44:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Gvjov9W49NsJQ43fbdkJfHK4BUIqjxJavrPyDiO2u7Y=; b=iQq8nmwMjaLySTiKW2/GCIJwQ0mXFLUP6vSyBaetxX6F5yA80Ln3ppTBe27GUey6RineC5SyOPXycM7iD0QwMkR4Ye1e4LEKq3TRRaVueXoZbvUDcnky3nCiXU9j9HyUy/WD+2/IJX0dhbuthinpK7Sob1gMFhUsXKXUNrPNFFmKM+APL1yKJbag50DGzbafp0Fp1d7ROda5InnQ5gWIb7Ncnb5nT33d86EcVWcNMq9d/wWGpuoPOs/mz2zuAIG+OMICzbM9GshUPZti+mJNv84LRTkuBT99RHSDY4OCG37UHBJBmwa1tX4yW75HEeetE5ZGG2Z14x6vptoMFJd/yQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 04:44:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96832 invoked by uid 111); 15 May 2026 04:44:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 00:44:47 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 00:44:47 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] trailer: change strbuf in-place in unfold_value()
Message-ID: <20260515044447.GC83595@coredump.intra.peff.net>
References: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>
 <a4da346d-3800-40ea-8828-970b15088bf3@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4da346d-3800-40ea-8828-970b15088bf3@ramsayjones.plus.com>

On Thu, May 14, 2026 at 10:30:37PM +0100, Ramsay Jones wrote:

> >  	i = 0;
> >  	while (i < val->len) {
> >  		char c = val->buf[i++];
> >  		if (c == '\n') {
> >  			/* Collapse continuation down to a single space. */
> >  			while (i < val->len && isspace(val->buf[i]))
> >  				i++;
> > -			strbuf_addch(&out, ' ');
> > -		} else {
> > -			strbuf_addch(&out, c);
> > +			val->buf[pos++] = ' ';
> > +		} else if (pos != i) {
> 
> Hmm, isn't 'pos' strictly (always) less than 'i' here? (note the post update
> of 'i' when setting 'c' at the head of the loop).
> 
> > +			val->buf[pos++] = c;
> 
> So, this (non-newline-or-'trailing'-space char) is always copied.
> 
> Not that it matters much (depending on how long the first line is, I doubt
> the difference is measurable :) ).
> 
> [Unless I'm not reading it correctly, of course - in which case, oops!]

Yeah, I think you're right. If it were a for-loop which incremented "i"
at the end then the comparison could make sense. But even then, I think
usually in such modify-in-place loops we don't bother trying to skip
self-assignment (e.g., see remove_space() in builtin/patch-id.c). In
practice I don't know which is worse: the extra branch or a pointless
memory store.

-Peff
