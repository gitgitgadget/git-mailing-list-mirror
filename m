Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1D70CC9
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271204; cv=none; b=O3YSOysyQSPamJkutTWljSFTem0X59HLeRI8qodUNygo+EgJf4LaZGZ00xxGsF3N35WDg844V93kQKlIAINgXTx2EriAp/lSm3HvqsytDPgSeKD8ZeCDDay9p7IHYnE25cyfW5geTHbx1gSTe76JHuWAmezF8QPAeK2kzJjaJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271204; c=relaxed/simple;
	bh=1cVClsV3AQPsSvBx5Zs71O2SzivytsdAPoL4QOK1Ii0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csj99eulO3uu4QIV4Q05j99Vfd11pch8FGzxneMIi8Kta84ZipHJ+BY8tqRqjexTEDcy58Vs3S1cUB3BV8EB4DZIYePLsiEW8jPTRyRlmScqIls8Kd60KjkeTHh1Ny6zn43uKoVeIItHjRsxCXqI509GnTrjr8yPeb76uRIsN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9911 invoked by uid 109); 4 Apr 2024 22:53:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Apr 2024 22:53:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23124 invoked by uid 111); 4 Apr 2024 22:53:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Apr 2024 18:53:16 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 4 Apr 2024 18:53:13 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: free and errno, was Re: [PATCH] apply: replace mksnpath() with a
 mkpathdup() call
Message-ID: <20240404225313.GA2512966@coredump.intra.peff.net>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df774306-f29b-4a75-a282-59db89812b9a@web.de>

On Thu, Apr 04, 2024 at 11:08:38PM +0200, René Scharfe wrote:

> Support paths longer than PATH_MAX in create_one_file() (which is not a
> hard limit e.g. on Linux) by calling mkpathdup() instead of mksnpath().
> Remove the latter, as it becomes unused by this change.  Resist the
> temptation of using the more convenient mkpath() to avoid introducing a
> dependency on a static variable deep inside the apply machinery.
> 
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: René Scharfe <l.s.r@web.de>

Heh, so obviously I had the same patch stewing. But one thing that gave
me pause is: do we need to worry about preserving errno across free()
boundaries?

Traditionally touching errno was something free() was allowed to do, and
there were definitely cases where glibc would do so (mostly due to
munmap). But recent versions of POSIX clarify that it should not touch
errno, and glibc as of 2.33 does not (which dates to 2021).

This issue from 2015 talks about "the next version of POSIX" making that
change:

  https://sourceware.org/bugzilla/show_bug.cgi?id=17924

but it looks to me from:

  https://www.austingroupbugs.net/view.php?id=385

that the change wasn't accepted there until 2020 (and AFAICT that hasn't
resulted in a new published spec yet).

Now it would be pretty darn useful to not have to worry about preserving
errno. It's subtle code that's hard to remember is needed, and sometimes
hard to get right depending on the rest of the flow control.

Years like "2020" and "2021" are too recent for us to say "oh, that's
ancient history, we don't have to care anymore". But I wonder if we can
be a little cavalier here for two reasons:

  - it's rare; for the most part free() isn't going to touch errno.
    Failures from munmap() are pretty rare, and small allocations like
    this are probably done with sbrk() anyway. Of course that's just
    talking about glibc, and there are other platforms. But it still
    seems like it should be a rarity for any free() implementation to
    fail or to want to touch errno.

  - the stakes are usually pretty low; the outcome in most cases would
    be a misleading error message as we clobber errno. But note that it
    does sometimes affect control flow (this patch is an example; we are
    checking for EEXIST to break out of the loop).

So would it be that unreasonable to assume the modern, desired behavior,
and mostly shrug our shoulders for other platforms? We could even
provide:

  #ifdef FREE_CLOBBERS_ERRNO
  void git_free(void *ptr)
  {
        int saved_errno = errno;
        free(ptr);
        errno = saved_errno;
  }
  #define free(ptr) git_free(ptr)
  #endif

if we really wanted to be careful, though it's hard to know which
platforms even need it (and again, it's so rare to come up in practice
that I'd suspect people could go for a long time before realizing their
platform was a problem). I guess the flip side is that we could use the
function above by default, and disable it selectively (the advantage of
disabling it being that it's slightly more efficient; maybe that's not
even measurable?).

>  		for (;;) {
> -			char newpath[PATH_MAX];
> -			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
> +			char *newpath = mkpathdup("%s~%u", path, nr);
>  			res = try_create_file(state, newpath, mode, buf, size);
> -			if (res < 0)
> +			if (res < 0) {
> +				free(newpath);
>  				return -1;
> +			}
>  			if (!res) {
> -				if (!rename(newpath, path))
> +				if (!rename(newpath, path)) {
> +					free(newpath);
>  					return 0;
> +				}
>  				unlink_or_warn(newpath);
> +				free(newpath);
>  				break;
>  			}
> +			free(newpath);
>  			if (errno != EEXIST)
>  				break;
>  			++nr;

At any rate, you can probably see the places where free() clobbering
errno would be a problem here. Our return when "res < 0" (though I don't
think any of the callers actually care about errno after that), the
check for EEXIST at the bottom of the loop, and after we break out of
the loop, we use error_errno() to report it.

-Peff
