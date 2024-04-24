Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879894C7C
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921101; cv=none; b=EH9UiAPmsM5PXRu4GergyNP95wLINAuaSw7ifxNihzMx5Gq76Q3Tf7mT3r/a9s5oqu26LcoUWKjhfD9+NxA0zSf6FagoiPc3wjsfuOQkVsJuKEZaCovrwpFVCg5ABYt1+O18GhGZA/GFnqzwfXvJelH2y7d2GxpnuNQqw4dgVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921101; c=relaxed/simple;
	bh=Dbp4K3yhZdhSgg3oQUU+CU4f8SIMLHiz+F54PPWfxFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eilOhHVNs5qBCoJk2VYrzNf3JCaf4GaK5RoHGHpjnJLC9FqjmsXCVWCqmNiDGIiUa4jBZ4ezxrkJAboCdFPJnDQw6N99MbWSXCwGGpkY1JFyaT8dijWj1esaa+MUDHDL/NqflFxsj/7FkE7HctzkK/an12HoIkr2Gom7jifP5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9712 invoked by uid 109); 24 Apr 2024 01:11:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Apr 2024 01:11:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6560 invoked by uid 111); 24 Apr 2024 01:11:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Apr 2024 21:11:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Apr 2024 21:11:37 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: free and errno, was Re: [PATCH] apply: replace mksnpath() with a
 mkpathdup() call
Message-ID: <20240424011137.GA1180766@coredump.intra.peff.net>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <20240404225313.GA2512966@coredump.intra.peff.net>
 <14c99998-cc4a-4581-aab3-607d7fac7edb@web.de>
 <20240405173517.GA2529133@coredump.intra.peff.net>
 <0fc77134-94fb-4d60-95b4-509c3582e20f@web.de>
 <20240407011834.GA1085004@coredump.intra.peff.net>
 <10b7fff3-7a2c-4555-9210-8000aae43583@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10b7fff3-7a2c-4555-9210-8000aae43583@web.de>

On Sun, Apr 14, 2024 at 05:17:23PM +0200, René Scharfe wrote:

> > In other words, it really depends on the contract of foo() with respect
> > to errno. And I don't think there is a way in C to specify that
> > contract in away that the compiler can understand.
> 
> The context attribute of sparse could be used, I guess.  We'd have to
> duplicate the declaration of all library functions, though, to tag them
> with a may_have_changed_errno attribute.  And we'd need to clear it on
> success, so we'd have to modify all callers.  On the flip side it would
> allow detecting consecutive errno changes, e.g. by two I/O functions
> with no error checking in between.  But the implementation effort seems
> way too high.
> 
> It would be easier if the error information was in one place instead of
> one bit in the return value (NULL or less than 0) and the rest in errno.

Yeah. In a world where every failing function returned the equivalent of
-errno, you could just do:

  ret = xread(fd, ...); /* actually returns -errno! */
  if (ret < 0) {
	close(fd);
	return ret; /* open's errno preserved via ret */
  }

We could live in that world if we wrapped all of the syscalls with
xread(), etc, that behaved that way. I don't know if it would run into
weird gotchas, though, or if the result would simply look foreign to
most POSIX/C programmers.

I also wonder if it might end up having the same 1% overhead that the
free() checks did, as it involves more juggling of stack values.

> >> An xfree() to go along with xmalloc()/xrealloc()/xcalloc()/xstrdup() would
> >> fit in nicely and might be easier to remember than free() after a while.
> >> Having to convert thousands of calls is unappealing, though.
> >
> > My biggest concern with it is that we'd have to remember to use it, and
> > there's not good compiler enforcement. But I guess coccinelle can help
> > us there.q
> 
> Yes, converting all free(3) calls is easy with Coccinelle, and the same
> semantic patch can be used to enforce the use of xfree().  Still the
> initial diff would be huge (2000+ changed lines in 300+ files).

True. It's one more weird thing to remember, but for the most part we
are there already with xmalloc().

> > My secondary concern is that it might make people think that xmalloc()
> > and xfree() are always paired, and thus you can do clever things in one
> > as long as the other matches it. But we sometimes free memory from
> > system routines like getline(). Maybe a scary comment would be enough?
> 
> Amazing foresight!  Currently we only use getline(3) (which can act like
> realloc(3)) in contrib/credential/, though.  Any others?

Heh, I actually meant to say getdelim(), which obviously is closely
related. There's only one call to it, but as it underlies
strbuf_getwholeline(), many strbufs will use it.

And as you might have guessed, my "amazing foresight" came from being
bitten by the same thing already. ;) Annoyed at how long git took to run
a large workload under massif, I once wrote a hacky peak-heap profiler
that wraps the system malloc(). Naturally it needs to match frees to
their original allocations so we know how big each one was. Imagine my
surprise when I saw many frees without a matching allocation.

> The "x" prefix doesn't promise exclusivity (hermetic seal?), but it
> certainly suggests there are some shared feature between the allocator
> functions and xfree(), while they only have in common that the are
> wrapped.  We could call the latter errno_preserving_free() instead or so.

That's a mouthful, for sure. I think it is OK to suggest they are
related as long as there is a comment in xfree() mentioning that we
might see pointers that didn't come from our x*() functions. That's
where somebody would have to add code that violates the assumption.

> I'm more worried about the overhead.  For a 0-1% slowdown (in the case of
> git log) git_free() or xfree() give us accurate error numbers on all
> platforms.  Non-misleading error codes are worth a lot (seen my share of
> cursed messages), but xfree() is only necessary in the error handling
> code.  The happy path can call free(3) directly without harm.
> 
> But how to classify call sites accordingly?  It's easy for programmers
> once they know it's necessary.  Is there a way in C, macro or Coccinelle
> to have our cake and only eat it if really needed?  I don't see any. :-|

I don't see a way either. I'd be willing to consider the 0-1% slowdown
if it buys us simplicity, though. I'm also not even sure it's real.
There seemed to be a fairly large variation in results, and switching my
powersaving functions around got me cases where the new code was
actually faster. If we think there's a real benefit, we should make sure
the costs aren't just illusory.

-Peff
