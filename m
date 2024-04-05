Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236217279C
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344640; cv=none; b=rdxftpT/lbTzOYxrkGfcvGQVQHzkri9/fgMGvcLATfkO7J8CSfLm9mV8NpiH49GC1X/zFm+1pJV8IEGCm9WhdoPAqxItLFQmf9/r1/cYmD9boeWVTfbsmdH8CmdGwLiG7Eg3Td4XusJ/ZO2gUCq/npppBPCA4FnivLmoIuNjrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344640; c=relaxed/simple;
	bh=7cqP2+8YLYMOo3hgGM8BjFccvBlPE/nqJCDF0ktfNeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9Z/uw06lndwTT6JfUZ5LGnLz/TfoeNiB+kDs3FgDNxFfn8MOgGDyu390HuZ683eRUERyzBnnRg3P3Q/iOGSgkCVIGxhIJAzqMiALHclA5zSI9wfLev3P0SkXWQGehOzIRQgwZlZVL6S/Ok8rwaMovMqYNOO3CtNN4q8tTyifEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19323 invoked by uid 109); 5 Apr 2024 19:17:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 19:17:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31591 invoked by uid 111); 5 Apr 2024 19:17:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 15:17:17 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 15:17:14 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
Message-ID: <20240405191714.GA2561807@coredump.intra.peff.net>
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
 <20240402204153.GE875182@coredump.intra.peff.net>
 <c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>

On Fri, Apr 05, 2024 at 07:44:59PM +0200, René Scharfe wrote:

> Am 02.04.24 um 22:41 schrieb Jeff King:
> >
> > I don't have a
> > strong opinion on compound literals in general, but if we did allow
> > them, we could clean up the horrible non-reentrant DATE_MODE().
> 
> We can easily make them reentrant without compound literals.  It just
> requires simple changes to lots of places.  Patch below.
> 
> --- >8 ---
> Subject: [PATCH] date: make DATE_MODE thread-safe
> 
> date_mode_from_type() modifies a static variable and returns a pointer
> to it.  This is not thread-safe.  Most callers of date_mode_from_type()
> use it via the macro DATE_MODE and pass its result on to functions like
> show_date(), which take a const pointer and don't modify the struct.
> 
> Avoid the static storage by putting the variable on the stack and
> returning the whole struct date_mode.  Change functions that take a
> constant pointer to expect the whole struct instead.

Yeah, this seems pretty reasonable. I think we've traditionally been
hesitant to pass or return structs by value, but that's mostly
superstition. IIRC it was illegal before C89, but that's long enough ago
that we can presumably ignore it.

-Peff
