Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2D17C9
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712452717; cv=none; b=ITEYc8NJh/F/hXRjM3Jl2CAPcmhCMYw4ttrwwRXah5kOq/R77RIHfDeQCLh1+G9Kl0Fq0EIw79EcvuU9vTU95qZla/DdblQzRBV6QVlEAHCF1oZdM0O9314nwevHJiiHEMWDY4Yoqdi90mMTa/4/dP6+A2oxpaD5oJysxF+ZZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712452717; c=relaxed/simple;
	bh=iiz5VdVGTzJNSxgUSJgEZpjpniV5ZMywt6WWTUIfEXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2QMEh18fkpsgudddqCx7HWxEyaQmbTbs/nWL+OOJyEhg4A4fFwecBQsJHtpmSwoxZ995AiQxTXYOl4eN7cN0tQoh2nMrQQxInopWKD7ko2r1Cduai1YTgTat9pOWHbpJutTRb/rMzBbpZRc4JZz3mplzpDHMrkv6vOYpFMnfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7865 invoked by uid 109); 7 Apr 2024 01:18:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:18:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11470 invoked by uid 111); 7 Apr 2024 01:18:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:18:37 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:18:34 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: free and errno, was Re: [PATCH] apply: replace mksnpath() with a
 mkpathdup() call
Message-ID: <20240407011834.GA1085004@coredump.intra.peff.net>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <20240404225313.GA2512966@coredump.intra.peff.net>
 <14c99998-cc4a-4581-aab3-607d7fac7edb@web.de>
 <20240405173517.GA2529133@coredump.intra.peff.net>
 <0fc77134-94fb-4d60-95b4-509c3582e20f@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fc77134-94fb-4d60-95b4-509c3582e20f@web.de>

On Sat, Apr 06, 2024 at 07:45:17PM +0200, René Scharfe wrote:

> I calmed down a bit now.  And ask myself how widespread the issue actually
> is.  Used the following silly Coccinelle rule to find functions that use
> errno after a free(3) call:
> 
> @@
> @@
> - free(...);
>   ...
>   errno
> 
> Found only a handful of places, and they all set errno explicitly, so
> they are fine.

Is that enough, though? Imagine I have:

  int foo(const char *x)
  {
     char *y = xstfrmt("something/%s", x);
     int fd = open(y, ...);
     free(y);
     return fd;
  }

Then errno is important if some caller of foo() checks errno after foo()
returns an error. And that caller might not even be in the same file.

In other words, it really depends on the contract of foo() with respect
to errno. And I don't think there is a way in C to specify that
contract in away that the compiler can understand.

> No idea how to match any use of errno except assignment.  And no idea how
> to find indirect callers of free(3) that use errno with no potential
> assignment in between.

Yeah, I guess the indirect callers of free() are really the flip-side.
My example was indirect users of errno. ;)

> > The other reason is that macros (especially of system names) can create
> > their own headaches.  We could require xfree() everywhere as a
> > complement to xmalloc (or maybe even just places where the errno
> > preservation seems useful), but that's one more thing to remember.
> 
> An xfree() to go along with xmalloc()/xrealloc()/xcalloc()/xstrdup() would
> fit in nicely and might be easier to remember than free() after a while.
> Having to convert thousands of calls is unappealing, though.

My biggest concern with it is that we'd have to remember to use it, and
there's not good compiler enforcement. But I guess coccinelle can help
us there.

My secondary concern is that it might make people think that xmalloc()
and xfree() are always paired, and thus you can do clever things in one
as long as the other matches it. But we sometimes free memory from
system routines like getline(). Maybe a scary comment would be enough?

> Found four places that did not expect free(3) to mess up their errno by
> running the test suite with that.  Patch below.

These are perhaps worth fixing (though not if we come up with a
universal solution). But I'd be surprised if they are the only ones. By
its nature, this problem only manifests when there are actual errors,
and our test suite is mostly checking happy paths. So I'd assume there
are a ton of "if (ret < 0) { free(foo); return -1; }" spots that are
simply not exercised by the test suite at all.

-Peff
