Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9069C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8783061507
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbhKPPe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:34:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:60086 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237560AbhKPPeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 10:34:25 -0500
Received: (qmail 20392 invoked by uid 109); 16 Nov 2021 15:31:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 15:31:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29997 invoked by uid 111); 16 Nov 2021 15:31:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 10:31:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 10:31:26 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116033542.3247094-2-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 03:35:41AM +0000, brian m. carlson wrote:

> The order of options is also important here.  On systems with
> arc4random, which is most of the BSDs, we use that, since, except on
> MirBSD, it uses ChaCha20, which is extremely fast, and sits entirely in
> userspace, avoiding a system call.  We then prefer getrandom over
> getentropy, because the former has been available longer on Linux, and
> finally, if none of those are available, we use /dev/urandom, because
> most Unix-like operating systems provide that API.  We prefer options
> that don't involve device files when possible because those work in some
> restricted environments where device files may not be available.

I wonder if we'll need a low-quality fallback for older systems which
don't even have /dev/urandom. Because it's going to be used in such a
core part of the system (tempfiles), this basically becomes a hard
requirement for using Git at all.

I can't say I'm excited in general to be introducing a dependency like
this, just because of the portability headaches. But it may be the least
bad thing (especially if we can fall back to the existing behavior).
One alternative would be to build on top of the system mkstemp(), which
makes it libc's problem. I'm not sure if we'd run into problems there,
though.

> diff --git a/Makefile b/Makefile
> index 12be39ac49..1d17021f59 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -234,6 +234,14 @@ all::
>  # Define NO_TRUSTABLE_FILEMODE if your filesystem may claim to support
>  # the executable mode bit, but doesn't really do so.
>  #
> +# Define HAVE_ARC4RANDOM if your system has arc4random and arc4random_buf.
> +#
> +# Define HAVE_GETRANDOM if your system has getrandom.
> +#
> +# Define HAVE_GETENTROPY if your system has getentropy.
> +#
> +# Define HAVE_RTLGENRANDOM if your system has RtlGenRandom (Windows only).

It seems like these will be mutually exclusive (and indeed, the #ifdef
in the code ends up defining a particular precedence). Would we be
better off exposing that to the user with a single CSPRNG_METHOD set to
arc4random, getrandom, getentropy, etc?

> diff --git a/config.mak.uname b/config.mak.uname
> index 3236a4918a..5030d3c70b 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -257,6 +257,9 @@ ifeq ($(uname_S),FreeBSD)
>  	HAVE_PATHS_H = YesPlease
>  	HAVE_BSD_SYSCTL = YesPlease
>  	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
> +	HAVE_ARC4RANDOM = YesPlease
> +	HAVE_GETRANDOM = YesPlease
> +	HAVE_GETENTROPY = YesPlease

So here we claim to support a whole bunch of methods, but in practice,
we only use arc4random, because these are all in an #elif chain:

> +int csprng_bytes(void *buf, size_t len)
> +{
> +#if defined(HAVE_ARC4RANDOM)
> +	arc4random_buf(buf, len);
> +	return 0;
> +#elif defined(HAVE_GETRANDOM)

though we still respect the others in other places, like including
headers that we don't end up using:

> +#ifdef HAVE_GETRANDOM
> +#include <sys/random.h>
> +#endif

If csprng_bytes() could fallback between methods based on runtime
errors, it would make sense to me to allow support for multiple methods
to be declared. But without that, it just seems to invite confusion (and
I am not sure runtime fallbacks are really worth the trouble).

> +int csprng_bytes(void *buf, size_t len)
> +{
> +#if defined(HAVE_ARC4RANDOM)
> +	arc4random_buf(buf, len);
> +	return 0;

OK, presumably this one can't return an error, which is nice.

> +#elif defined(HAVE_GETRANDOM)
> +
> +	ssize_t res;
> +	char *p = buf;
> +	while (len) {
> +		res = getrandom(p, len, 0);
> +		if (res < 0)
> +			return -1;
> +		len -= res;
> +		p += res;
> +	}
> +	return 0;

Do we ever have to worry about a "0" return from getrandom()? I'd expect
it to block rather than return 0, but what I'm wondering is if we could
ever be in a situation where we fail to make progress and loop
infinitely.

The manpage says that reads up to 256 bytes will always return the full
output and never be interrupted. So for the caller you add in patch 2,
we wouldn't need this loop. However, since cspring_bytes() is generic,
being defensive makes sense. But in that case, do we need to handle
EINTR when it returns -1?

> +#elif defined(HAVE_GETENTROPY)
> +	int res;
> +	char *p = buf;
> +	while (len) {
> +		/* getentropy has a maximum size of 256 bytes. */
> +		size_t chunk = len < 256 ? len : 256;
> +		res = getentropy(p, chunk);
> +		if (res < 0)
> +			return -1;
> +		len -= chunk;
> +		p += chunk;
> +	}
> +	return 0;

Heh, I see that getentropy() punted on all of those questions above by
just insisting you ask for 256 bytes at a time. Cute solution. ;)

> +#elif defined(HAVE_RTLGENRANDOM)
> +	if (!RtlGenRandom(buf, len))
> +		return -1;
> +	return 0;

I have no comment on this one. :)

> +#else
> +	ssize_t res;
> +	char *p = buf;
> +	int fd, err;
> +	fd = open("/dev/urandom", O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +	while (len) {
> +		res = xread(fd, p, len);
> +		if (res < 0) {
> +			err = errno;
> +			close(fd);
> +			errno = err;
> +			return -1;
> +		}
> +		len -= res;
> +		p += res;
> +	}
> +	close(fd);
> +	return 0;
> +#endif
> +}

This loop is basically read_in_full(), except that it doesn't treat a
"0" return as an EOF. I'm not sure if that's intentional (because we
want to keep trying on a 0 return, though I'd expect the read to block
in such a case), or if it would be an improvement (because it would
prevent us from infinite looping if /dev/urandom wanted to signal EOF).

-Peff
