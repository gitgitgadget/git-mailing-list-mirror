Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3D366817
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108994; cv=none; b=QtOM0Myf2jlyGyuEEfGAKdr65rOMxvsaugONXk+l6syP7F5vYLxxefGdwqrybGpEG9BqMubWq+Alw9+T89ioLMwGjxp/9jnUyj1DiADYQviOdGQrOWBCd0V5rrG0ptVVIeHggdMnC1V5pFhlyKtCuexbm8x7L0xefYjpqys/ZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108994; c=relaxed/simple;
	bh=eh29IieZZpkpz5hR2w5GWQ5p5zolqE3T+0yntofBF6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRGLoWNcAfrqDwJqh017IdfGIhoWJrcShzHAHLd6PSPOfk69NcT3qYZYPvJBmn8+cFmFjQhl7fG2q8fEZwxi4Jd2a2qmugKgPBUVxnXsQIhjKTG9z6t8ctJcMIeOmlImVQ2fhiZjCR5lfm0Gwb57H4aDA4VD1wk5RPFKADZ02MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RJargEsn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RJargEsn"
Received: (qmail 130395 invoked by uid 109); 22 Jan 2026 19:09:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eh29IieZZpkpz5hR2w5GWQ5p5zolqE3T+0yntofBF6c=; b=RJargEsnCawZFoCO4gZ2NOeOQ56c3sZbpXyknwuU8bW8KP5YexMDHBwHBoFCtf7MiINpUXXRVgqKdVsSv12SGs/90ligKGEjC3n2bHoXo5/fkmer7Yh2dRy4aTQbJsOXyQCglogaPy9n7jNM468lNzp0p9qZPxeYqexN7HibTq6hnaJiqxjJNclu6B8btpwKjGt+XUAr9g3Yzc2AXgfE4PPwmaB0Zw3CMFco6CreA1xrfYyIwUermp3T6kofkUXuVFtFicGdy1/gAwUX167WTEMR678snyL6R9wAko1HZTbLNrTrEQpppPqutmKdv/T8eQnsuo5BRd0QAxyClYPlgw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Jan 2026 19:09:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 236157 invoked by uid 111); 22 Jan 2026 19:09:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Jan 2026 14:09:43 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 22 Jan 2026 14:09:41 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] reset: avoid reflog update on no-op reset
Message-ID: <20260122190941.GB2098026@coredump.intra.peff.net>
References: <20260122154743.20496-3-pushkarkumarsingh1970@gmail.com>
 <xmqqwm19mq69.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwm19mq69.fsf@gitster.g>

On Thu, Jan 22, 2026 at 10:57:02AM -0800, Junio C Hamano wrote:

> Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:
> 
> > When "git reset" is invoked with a target that already matches HEAD,
> > it currently writes a reflog entry even though no reference is updated.
> >
> > Detect this no-op case and avoid updating ORIG_HEAD and HEAD, skipping
> > the reflog entry entirely.
> 
> I am mildly negative on this one.  A scripted use that gets which
> commit to reset to from the caller in the outside world, e.g.,
> 
>     #!/bin/sh
>     git reset --hard "$1"
>     git diff --stat @{1}
> 
> would be confused if reflog does not reliably store the state before
> running "reset --hard" to @{1}.  In other words ...
> 
> > Add a regression test to ensure no reflog entry is written for a no-op
> > reset.
> 
> ... this change may already be a regression for existing users.

I was just writing the same message. ;) In addition to scripted use,
that reflog does contain some human-readable information: the message
field tells us what name we "git reset --hard" to. That might be helpful
when digging through it trying to piece together what happened.

-Peff
