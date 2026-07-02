Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B322AE48
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026365; cv=none; b=Diu64m8O1/UkpVXLbuVfvtCUFHFqzqeDSgQkbMvSde1DpZAyJqHDKwx0IsI6Oq9ISYCzlSJE0gcFiWUCEVaqH2HBlvVYbpv2C/qjzcqQUJjsN/cPbCzuuaxp0nCOsq4l4aAw2M4cTYj4rUSxn+5RM7pe6K5uUDAmC2qxNduMTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026365; c=relaxed/simple;
	bh=1amXDpl5JTVmlXRAmxJMUTPh8qHn54xuZZpTnMooBpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+5X/S7tpTzFWltlknhZzOLBB/YMJGWnR2fWSY1raU/QApU9NsC8n+CTbVRW2KtrmE40XOO0Cyu+AJANU7KSnjG531z/JL9y8V3ED/Qy5K0vliH+2eplRBM3RA02ykU086zbqv7CwC9eXLraVFO2flHkAdbcD28AhefjTnHFf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b+9ADycx; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b+9ADycx"
Received: (qmail 88788 invoked by uid 106); 2 Jul 2026 21:06:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1amXDpl5JTVmlXRAmxJMUTPh8qHn54xuZZpTnMooBpo=; b=b+9ADycxZN7W1Oif9n1l61cKOvG2fKQ7j+K2AGhw/W4Fi3Fh/x+U5/IYMZdqxse4PNV1UUHFRCL7F1xAsKXZIOnHXlGs1YgGA+0qi9CtLbfO+k5lzuFJeKn7oevnpeJZWbMvySlKgXrw/hIoa+gV6OhXznF4EzCHO85XfaEDV08JfZ2YeUeCaMH4kXWmH61wTA1qyRtsP4KXEan7BfEQkDcxOkxy51SeeO4PGD0BbsAfShBKLMMvAqQDXfDOJ4CQkwzdrhAwCS7eFDjk57IMt28qkipvai+LPNP6bK1wqqZVW7dGQzwSZfRs23k1ef6o1MCqiCmDRaNx3aSq8FUOVQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 21:06:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 187678 invoked by uid 111); 2 Jul 2026 21:06:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 17:06:01 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 17:06:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/9] csum-file: drop discard_hashfile()
Message-ID: <20260702210601.GA2051171@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702075744.GA2029434@coredump.intra.peff.net>
 <xmqqik6xl0fb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqik6xl0fb.fsf@gitster.g>

On Thu, Jul 02, 2026 at 11:19:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So now we have two functions, discard_hashfile() and free_hashfile(),
> > and we only need one. Which one do we want to keep?
> >
> > The only difference between them is that the discard variant also closes
> > the descriptors held in the struct. Let's look at the three callers:
> > ...
> > Note that I said "descriptors" plural above. Those callers all care
> > about the "fd" member of the struct. But discard_hashfile() also closes
> > check_fd. That is only used if the struct is initialized with
> > hashfd_check(), and neither of its two callers call either discard or
> > free (they always "finalize" instead). So closing it is irrelevant for
> > the current callers.
> >
> > I think we're better off sticking with the simpler free_hashfile()
> > interface, and the handful of callers can decide how to handle the
> > descriptors themselves.
> 
> Sonds good.
> 
> Our resident naming czar (already Cc'ed) may have preference about
> the names and word order, though ;-)

Heh, yes, it should be hashfile_free() but that would require changing
the whole interface. We could do that on top, which might also be a good
time to do s/free/discard/ without worrying about a subtle behavior
change.

-Peff
