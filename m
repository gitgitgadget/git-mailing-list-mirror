Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21959132103
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308504; cv=none; b=SPPnnqL7OpqKcbgPU9GleUZm1KDwswcV3E/hh7bj9qaMq5jnYSdHsBRsQdNbQy03GfmGUYvu5N4508DhS96snRUWhcLhqaEnOhx+BAP0xzjc6kO6ED/gfiDF3k8ObPSfxgpTDZclq+DepCv/dsDQTyT/t3YltOfjGoMSkBJ5+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308504; c=relaxed/simple;
	bh=jCUieFkuY8CFatjIGIT/o2I2uA7sxTmARwFcw5/4efw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpYnBat+v3ZFWxu0XfHM/v1UgnOFYeG+JW9ePhCEsvqYsnTXazmAiza7MeEzI2fJc3CJBbu94S+coTLPEo6LbiBAqKDiZxNWdsgpADKsWGnQXRFEtO83vdnFO18tfMjnv46ea7nbspeiKsMsdHtATqp6EpppO8V4c1VM/hLPiI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fRpg8Zym; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fRpg8Zym"
Received: (qmail 11921 invoked by uid 109); 11 Nov 2024 07:01:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jCUieFkuY8CFatjIGIT/o2I2uA7sxTmARwFcw5/4efw=; b=fRpg8ZymI9ZU91VeWO50pcLBExI5o8JvohZhwYcbfNgcOo1Vsma2EtvtsFpLDHkxKoke48Z8Yo5RlgnxTN1EDjO8+NS9bP4GUuwL5wMgJiOx+/KPuTM/l/bAK7ALW7y5v4yGqD40Wz0ODLATVwf1ReT0eab+oOw/EvHeT9SKuYKIlrmjGqxWQ8Yc4f/npetABRuedvmV2IEuh7sQRnFLZQzliwjT6rosyFdoPp4w/cp0fzsaOhqHN1xRMMNh5/3jajxYVTHp64x8x4vHm3QtLWcXwbkNjZraVZNcqoIHs7gaKHJx2LCHzTKMuctIpX/nNqXf07z4mZGmGP6HL3gfuw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Nov 2024 07:01:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12650 invoked by uid 111); 11 Nov 2024 07:01:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 02:01:38 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 02:01:34 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>, Elia Pinto <gitter.spiros@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH] test-lib: check malloc debug LD_PRELOAD before using
Message-ID: <20241111070134.GA675125@coredump.intra.peff.net>
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
 <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
 <87msi85vc9.fsf@igel.home>
 <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
 <Zy-IYwjb_RO5NW-s@teonanacatl.net>
 <20241109190012.GA588841@coredump.intra.peff.net>
 <xmqq7c9aihvx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c9aihvx.fsf@gitster.g>

On Mon, Nov 11, 2024 at 12:11:46PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't offhand know of a good portable way to ask the system about
> > available libraries. But I guess just doing something like:
> >
> >   err=$(LD_PRELOAD=libc_malloc.so.0 git version 2>&1 >/dev/null)
> >   if test -z "$err"
> >   then
> > 	...seemed to work...
> >   fi
> >
> > would do it?
> 
> I do not necessarily view it as "asking the system about available
> libraries"; we are checking if we can sensibly run things with this
> set to LD_PRELOAD.  And presumably the answer was "no" in the
> original report, so it is a very direct way to ensure that we are
> setting it to a sensible value.  I like it.

Yeah, I agree that is a better way to think about it; it is more
directly asking what we want to know. So here it is as an actual patch.

> The above did not work for me until I did "s/malloc/&_debug/" on the
> command line.

Oops, yes. I should have said "not tested". ;) On the other hand,
writing the wrong name is an easy way to test the failure mode. I pulled
it out into a variable in the patch below so we only have to write it
once.

I tested before and after with a typo'd version of the library name and
it seems to work. But it would be great to get confirmation from Usman
that this fixes the problem.

-- >8 --
Subject: [PATCH] test-lib: check malloc debug LD_PRELOAD before using

This fixes test failures across the suite on glibc platforms that don't
have libc_malloc_debug.so.0.

We added support for glibc's malloc checking routines long ago in
a731fa916e (Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the test
suite for detecting heap corruption, 2012-09-14). Back then we didn't
need to do any checks to see if the platform supported it. We were just
setting some environment variables which would either enable it or not.

That changed in 131b94a10a (test-lib.sh: Use GLIBC_TUNABLES instead of
MALLOC_CHECK_ on glibc >= 2.34, 2022-03-04). Now that glibc split this
out into libc_malloc_debug.so, we have to add it to LD_PRELOAD. We only
do that when we detect glibc, but it's possible to have glibc but not
the malloc debug library. In that case LD_PRELOAD will complain to
stderr, and tests which check for an empty stderr will fail.

You can work around this by setting TEST_NO_MALLOC_CHECK, which disables
the feature entirely. But it's not obvious to know you need to do that.
Instead, since this malloc checking is best-effort anyway, let's just
automatically disable it when the LD_PRELOAD appears not to work. We can
check it by running something simple that should work (and produce
nothing on stderr) like "git version".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a278181a05..4fe757fe9a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -593,9 +593,12 @@ then
 	}
 else
 	_USE_GLIBC_TUNABLES=
+	_USE_GLIBC_PRELOAD=libc_malloc_debug.so.0
 	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
 	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
-	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
+	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null &&
+	   stderr=$(LD_PRELOAD=$_USE_GLIBC_PRELOAD git version 2>&1 >/dev/null) &&
+	   test -z "$stderr"
 	then
 		_USE_GLIBC_TUNABLES=YesPlease
 	fi
@@ -607,7 +610,7 @@ else
 		if test -n "$_USE_GLIBC_TUNABLES"
 		then
 			g=
-			LD_PRELOAD="libc_malloc_debug.so.0"
+			LD_PRELOAD=$_USE_GLIBC_PRELOAD
 			for t in \
 				glibc.malloc.check=1 \
 				glibc.malloc.perturb=165
-- 
2.47.0.495.g1253739cc1

