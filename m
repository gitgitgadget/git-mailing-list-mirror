Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00741E0DDF
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735756110; cv=none; b=GPp7kC9I/VmxovZcY7tnMJnoU/aHnUpyLlfcLnlZKJ8t886pPcSZ/mPKEk8jpyd9tg+CIJzT9YsJE0lVvB4B+RKOH9g6KyTprUzVlvY05EiKPJ8dW+Q69vrwMGVpldhEyYkbwYiDqKZrCezex5bYoYLe7CeG4XHsmTTQfjYIJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735756110; c=relaxed/simple;
	bh=1kliGFJmJp7tb17BuUM6glLUHo3fWTtItrh8/MPh3fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtUoYpRl3FjhBDF7MvegFSjWrhjmUbcCG4mafdt3PY4C76Kl/RqOKCWy4NwbHo3CRVtAXbXWfVwpkT6a1/rmG7qiq/HaK7dECUlwGl3ZTViHTJFHc+cWEpxFGoqbp2nyoEnTRW+8DmcymzAAHlzsaIBc8BCK2o/nzN8+ZqO3hmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DJYYEjwu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DJYYEjwu"
Received: (qmail 20789 invoked by uid 109); 1 Jan 2025 18:28:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1kliGFJmJp7tb17BuUM6glLUHo3fWTtItrh8/MPh3fw=; b=DJYYEjwuP7I1waJGnswCLqSkBl09njcpT8ON55Vk88pzFgwwG+HWjzyTxRqFFkGvyznDQ/gXn6pMSCBYrvR6VwtL6Gd6adguokulVlSnKbszmeDvpp5QT9eUx5qsMiyaV/z/sJ8LPNA4rgy+K0HryUI3v2MhO5fvk/JXUeIb71ZwwIz2pxPTadm42JaUhImOhPLfDnc8zB1ENjbOkWaaKyf8G8eztoLFYt0kExySJwDUG0FQCD5Ue0CQ5bgKX7ohA5SA8cbtSD3N6YIrZbxSIEJd20I0sznrfA/erYkYTiIStqqxGdcuPJ+Jb+LajIzgZJ/IXtZFf71013udkmD+VA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 18:28:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10606 invoked by uid 111); 1 Jan 2025 18:28:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 13:28:27 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 13:28:26 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] thread-utils: introduce optional barrier type
Message-ID: <20250101182826.GB1391912@coredump.intra.peff.net>
References: <20241230042325.GA112439@coredump.intra.peff.net>
 <20241230042830.GC113400@coredump.intra.peff.net>
 <Z3JFyniivEd716aX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3JFyniivEd716aX@pks.im>

On Mon, Dec 30, 2024 at 08:03:38AM +0100, Patrick Steinhardt wrote:

> >   - we could turn it on only for LSan builds. But that would break
> >     builds on non-Linux platforms (like macOS) that otherwise should
> >     support sanitizers.
> 
> Mh. I'm not a huge fan of having extra code for just a subset of our
> builds and think that having the code generally enabled on platforms
> that support it is preferable to reduce the number of build variants.
> But...
> 
> >   - we could trigger only on the combination of Linux and LSan together.
> >     This isn't too hard to do, but the uname check isn't completely
> >     accurate. It is really about what your libc supports, and non-glibc
> >     systems might not have it (though at least musl seems to).
> > 
> >     So we'd risk breaking builds on those systems, which would need to
> >     add a new knob. Though the upside would be that running local "make
> >     SANITIZE=leak test" would be protected automatically.
> 
> ... this is a fair remark. So I dunno.

Yeah. I do not like having the behavior differ only for LSan, or only on
Linux. But I also do not like having tricky threading code that we do
not otherwise need in all of the other builds. So it is really about
picking the least-bad option, and they all seem similarly bad to me. So
I picked the one that involved writing the least amount of code. ;)

> Okay. The Meson equivalent would be:
> [...]

Yeah, I figured it would need something similar (but for our CI it does
not yet matter). Do you want to prepare that as a patch on top? (Though
also see the message I'm about to send that we might be able to avoid
this series entirely!).

> > +#ifdef THREAD_BARRIER_PTHREAD
> > +#define maybe_thread_barrier_t pthread_barrier_t
> > +#define maybe_thread_barrier_init pthread_barrier_init
> > +#define maybe_thread_barrier_wait pthread_barrier_wait
> > +#define maybe_thread_barrier_destroy pthread_barrier_destroy
> > +#else
> > +#define maybe_thread_barrier_t int
> 
> Out of curiosity: why did you pick a define here and not a typedef?

That's what we do for all of the NO_PTHREADS fallbacks, so I was just
following that style. I suspect it matters more there, because you would
not want to typedef pthread_t on a system that is building with
NO_PTHREADS but actually does define that type (whereas the "maybe"
variants are our own invention, so we can be confident those names won't
conflict).

I don't think it matters too much either way.

> > +static inline int maybe_thread_barrier_init(maybe_thread_barrier_t *b UNUSED,
> > +					    void *attr UNUSED,
> > +					    unsigned nr UNUSED)
> > +{
> > +	errno = ENOSYS;
> > +	return -1;
> > +}
> > +#define maybe_thread_barrier_wait(barrier)
> > +#define maybe_thread_barrier_destroy(barrier)
> 
> So the way these wrappers are implemented it is not possible to check
> for errors of `pthread_barrier_init()` et al. When the implementation
> exists we do have return codes, but if it's stubbed out we don't.

Yeah, again I was following the NO_PTHREADS fallbacks defined above.
Perhaps those are different in that we wouldn't generally expect to ever
call them if we don't have threads at all (whereas these "maybe" ones
are meant to be quiet noops).

> I think we should align these two implementations so that it does become
> possible to check for errors, or otherwise we wouldn't be using the
> pthread APIs correctly. It does raise the question though whether we
> should really return `-1` in the stubbed-out variant or whether we
> should instead pretend as if things were alright.

You'd have to return a fake success if you expect to check errors, I'd
think. Unless you want to introduce a bunch of conditional code to say
"well, we tried to initialize a barrier but it didn't work, so let's not
actually wait".

For all of the existing pthread calls, we simply assume init stuff like
pthread_mutex_init() doesn't fail. Possibly we should change that
globally, but this is just following the same pattern.

> An alternative would be to die in case the pthread-functions return an
> error.

That's certainly akin to xmalloc(). But probably we don't want to go
that direction, simply because it works against libification in the long
run.

-Peff
