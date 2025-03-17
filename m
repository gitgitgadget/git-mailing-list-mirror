Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6B1527B4
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234419; cv=none; b=TxKNEr2m44z06zD6Qh54yv8kUaW1U1VrXgYWTOp7pp31s1MTcPSwN25dHqIG32Sn2dVwkTWjVIrIhOO6vSaM7RazlIZaLQQElIPyNMu4ZTPlV8P/d2LWzZ2YYCx/FyaaFrxrFzz0ouaG6d8yoiJvlh2IIPXOssSQgoQL4bBqCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234419; c=relaxed/simple;
	bh=agTLVfGH7vWvUcXhGIvX0H0JwcZXTNXMAe3dbj8qb90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sztUAhsmhJGD0PrbpzhthfpEkAdR5nj0dWZQySjVyxFmL9Aad5LAJO5ArhLxO5kX/dsmi4l6cA46PtyfvoGxC8xjwfs4Tz0a4NmUsyvIDiaOT9tBd2to+TqY9GTkr7htqNVq+WZGs5Kl1iiVfiA5qaKz//Sh9koBE4mgD+Qtv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aLjrdej5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aLjrdej5"
Received: (qmail 21391 invoked by uid 109); 17 Mar 2025 18:00:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=agTLVfGH7vWvUcXhGIvX0H0JwcZXTNXMAe3dbj8qb90=; b=aLjrdej55DvpKSj2Q4f49TF26cL/fTwtyHqxuGtp/OwzaUy8f4GIZBgmKLMO63fyi68E9f0J3T+noTgfmeMbqF5CZJU9vvG9NQV5+3KQeky7FuSw7EdEvXxeM732HI8BEdXWC8J6B8AG0lQEakbSHWI8/ixEFe1YKwxr4Lwi2Pvg6KUy/t/bAAwsnmr7OmEYez/7BhFXKravMvCCN9glv48GrWofsOdWAH1rNQecGcMG7c/2UVAhAOFFsX8BfdAc5U4VGZ9u2nLAk3Dx6YR7SaWse0IzzpXPtYIzj3Q/AJatJqnyCJ4Lf16xsVXaTcBtM6atAJpyxThYgfgd7e2LJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Mar 2025 18:00:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28072 invoked by uid 111); 17 Mar 2025 18:00:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 14:00:14 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 14:00:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/3] git-compat-util: add NOT_A_CONST macro and use it
 in atfork_prepare()
Message-ID: <20250317180014.GA704553@coredump.intra.peff.net>
References: <20250307225444.GA42758@coredump.intra.peff.net>
 <20250314210909.3776678-1-gitster@pobox.com>
 <20250314210909.3776678-4-gitster@pobox.com>
 <xmqqecyzdz4t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqecyzdz4t.fsf@gitster.g>

On Fri, Mar 14, 2025 at 03:29:54PM -0700, Junio C Hamano wrote:

> ---- >8 ----
> Our hope is that the number of code paths that falsely trigger
> warnings with the -Wunreachable-code compilation option are small,
> and they can be worked around case-by-case basis, like we just did
> in the previous commit.  If we need such a workaround a bit more
> often, however, we may benefit from a more generic and descriptive
> facility that helps document the cases we need such workarounds.
> 
>     Side note: if we need the workaround all over the place, it
>     simply means -Wunreachable-code is not a good tool for us to
>     save engineering effort to catch mistakes.  We are still
>     exploring if it helps us, so let's assume that it is not the
>     case.

Yup, I very much agree with this, especially the side note. (I'd
probably have just dropped patch 2 and gone straight here, but I don't
mind leaving it in as documentation of that other direction).

> Introduce NOT_A_CONST() macro, with which, the developer can tell
> the compiler:
> 
>     Do not optimize this expression out, because, despite whatever
>     you are told by the system headers, this expression should *not*
>     be treated as a constant.

This is definitely better than the other name. I might spell it out
as "NOT_A_CONSTANT", just because "const" to me is a variable annotation
(for something that _could_ change, but we are not allowed to). Whereas
"constant" is something defined to a single value in the program. Maybe
splitting hairs, but as somebody who read NOT_A_CONST(foo) I might
expect it to be casting away "const" or something.

> --- a/Makefile
> +++ b/Makefile
> @@ -1018,6 +1018,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
>  LIB_OBJS += ewah/ewah_io.o
>  LIB_OBJS += ewah/ewah_rlw.o
>  LIB_OBJS += exec-cmd.o
> +LIB_OBJS += fbtcdnki.o

That name is a mouthful, for sure. The long name is really an
implementation detail. Would calling it not-constant.c or something be
more descriptive? (Yes, the macro itself does not appear in the file,
but hopefully it links the two semantically in the reader's head).

I almost want to suggest a name like "compiler-tricks.c", but part of
the point of this particular trick is that there's nothing else in its
translation unit. So later when somebody adds another trick, it cannot
use this macro. ;)

> +/*
> + * Prevent an overly clever compiler from optimizing an expression
> + * out, triggering a false positive when building with the
> + * -Wunreachable-code option. false_but_the_compiler_does_not_know_it_
> + * is defined in a compilation unit separate from where the macro is
> + * used, initialized to 0, and never modified.
> + */
> +#define NOT_A_CONST(expr) ((expr) || false_but_the_compiler_does_not_know_it_)
> +extern int false_but_the_compiler_does_not_know_it_;

Good explanation. I do wonder if we'd eventually see a compiler that
reaches across translation units to optimize, but I'd hope we probably
bought ourselves a decade or two.

> diff --git a/run-command.c b/run-command.c
> index d527c46175..535c73a059 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -516,14 +516,12 @@ static void atfork_prepare(struct atfork_state *as)
>  	sigset_t all;
>  
>  	/*
> -	 * Do not use the return value of sigfillset(). It is transparently 0
> -	 * on some platforms, meaning a clever compiler may complain that
> -	 * the conditional body is dead code. Instead, check for error via
> -	 * errno, which outsmarts the compiler.
> +	 * POSIX says sitfillset() can fail, but an overly clever
> +	 * compiler can see through the header files and decide
> +	 * it cannot fail on a particular platform it is compiling for,
> +	 * triggering -Wunreachable-code false positive.
>  	 */
> -	errno = 0;
> -	sigfillset(&all);
> -	if (errno)
> +	if (NOT_A_CONST(sigfillset(&all)))
>  		die_errno("sigfillset");

And this looks much nicer and more descriptive. You could probably even
get away without the comment, but I certainly do not mind it.

s/sitfillset/sigfillset/ in your comment text, though.

-Peff
