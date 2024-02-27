Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA652F62
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020433; cv=none; b=dXlaUv4jj8wxocIvvmhUnGt0MF4vUW28Iardgy4P6Az8q67hUy8ECeYuyQ8ObENJPIpxTaQ76lu2HXfC7gUOw0dPNu60lPO9pdXWcxh5noFWZMENQfVy1Hgd0IEFq8qKia5zFvchC3zlO/gv0C4cewAR3/lSNbjAH/OmIWDAtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020433; c=relaxed/simple;
	bh=z+WFzGHacLvHMKAb6fi0tkQ/or1arOzBi6sAhxcVCFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2lrWT5sMnKdRgKAr57xcHtsROULCX/tLF3CzH6/Ut+TaxSCBkCvU0mpmsVyOFm1zRv0G7SS9T0anxVpk/gpoIkfkH0I/RKYK9PooHeM3CiALR8DomaZQr5P3iOmuAnRRc+WgEkv4DxUYY01r5gunsfeM7oIB7kbG+FD99l/Cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10979 invoked by uid 109); 27 Feb 2024 07:53:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 07:53:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7131 invoked by uid 111); 27 Feb 2024 07:53:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 02:53:54 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 02:53:50 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] mem-pool: add mem_pool_strfmt()
Message-ID: <20240227075350.GE3263678@coredump.intra.peff.net>
References: <20240225113947.89357-1-l.s.r@web.de>
 <20240225113947.89357-2-l.s.r@web.de>
 <20240226070844.GB780982@coredump.intra.peff.net>
 <1868c502-b915-42fd-8cb2-efe90429f9b7@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1868c502-b915-42fd-8cb2-efe90429f9b7@web.de>

On Mon, Feb 26, 2024 at 07:17:00PM +0100, René Scharfe wrote:

> > This is pulling heavily from strbuf_vaddf(). This might be a dumb idea,
> > but... would it be reasonable to instead push a global flag that causes
> > xmalloc() to use a memory pool instead of the regular heap?
> >
> > Then you could do something like:
> >
> >   push_mem_pool(pool);
> >   str = xstrfmt("%.*s~%d^%d", ...etc...);
> >   pop_mem_pool(pool);
> >
> > It's a little more involved at the caller, but it means that it now
> > works for all allocations, not just this one string helper.
> 
> That would allow to keep track of allocations that would otherwise leak.
> We can achieve that more easily by pushing the pointer to a global array
> and never freeing it.  Hmm.

I see two uses for memory pools:

  1. You want to optimize allocations (either locality or per-allocation
     overhead).

  2. You want to make a bunch of allocations with the same lifetime
     without worrying about their lifetime otherwise. And then you can
     free them all in one swoop at the end.

And my impression is that you were interested in (2) here. If what
you're saying is that another way to do that is:

  str = xstrfmt(...whatever...);
  attach_to_pool(pool, str);

  ...much later...
  free_pool(pool);

then yeah, I'd agree. And that is a lot less tricky / invasive than what
I suggested.

> It would not allow the shortcut of using the vast pool as a scratch
> space to format the string with a single vsnprintf call in most cases.
> Or am I missing something?

So here it sounds like you do care about some of the performance
aspects. So no, it would not allow that. You'd be using the vast pool of
heap memory provided by malloc(), and trusting that a call to malloc()
is not that expensive in practice. I don't know how true that is, or how
much it matters for this case.

-Peff
