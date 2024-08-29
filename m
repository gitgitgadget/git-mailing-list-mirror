Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987A1B9B32
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960740; cv=none; b=JqIqDKSKKGSAZHGPc8bypzDoUNv10FVilk1YWwb5s7xAqgr6hMd+G13ega3b0okKNOaCqP4O0Urz9ZSpCocME6mFdahfOU7EvL4jOY0tNm3A2s2zOQDKpDXGmdQ2rbd9jpRZ6KpHKuvjtoaaKyYgQPmOR74aswBaW+8eDGJg+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960740; c=relaxed/simple;
	bh=Y2ZpiRs0hPqxVkJYdWSMGaqhu0qiAjTN/D135raMd6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n92E1bgI4+m7drF5tAAkTKSxEYEihHnRopNHvDBTbTpgzvUPS+vOedQgaR41INqdaYi5Mit9+xnwS2By30CJ/yD1cKgonFQ20wZb7FxhB0qDwi/i0i6yZ3ZwLHR64hIJJagLUK9chNRDyCX6F+2pdsMX/UTxMxgbduyhr/eRC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5873 invoked by uid 109); 29 Aug 2024 19:45:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 19:45:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10016 invoked by uid 111); 29 Aug 2024 19:45:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 15:45:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 15:45:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 9/6] git-compat-util: guard definition of MAYBE_UNUSED
 with __GNUC__
Message-ID: <20240829194536.GD423429@coredump.intra.peff.net>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <Zs348uXMBdCuwF-2@ArchLinux>
 <xmqqbk1cz69c.fsf@gitster.g>
 <20240829040215.GA4054823@coredump.intra.peff.net>
 <xmqqseunxtks.fsf_-_@gitster.g>
 <20240829175215.GA415423@coredump.intra.peff.net>
 <xmqq8qwfw6e9.fsf@gitster.g>
 <xmqq4j73w5up.fsf_-_@gitster.g>
 <xmqqttf3uquc.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttf3uquc.fsf_-_@gitster.g>

On Thu, Aug 29, 2024 at 11:27:39AM -0700, Junio C Hamano wrote:

> Just like we only define UNUSED macro when __GNUC__ is defined,
> and fall back to an empty definition otherwise, we should do the
> same for MAYBE_UNUSED.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * Before I forget that we have discussed this, just as a
>    documentation (read: this is not a patch to be applied).
> 
>    I think this only matters when a compiler satisfies all three
>    traits:
> 
>    - does not define __GNUC__
>    - does have its own __attribute__() macro
>    - barfs on __attribute__((__unused__))
> 
>    Otherwise we will define __attribute__(x) away to empty to cause
>    no harm.
> 
>    Since we have survived without complaints without such a guard
>    for quite some time, it may be a sign that no compiler that knows
>    __attribute__() that people ever tried to compile Git with barfs
>    with __attribute__((__unused__)).  I dunno.

Yeah, I was surprised that this didn't have a guard and was not
currently barfing on other compilers. And the answer is that we already
turn __attribute__ into a noop on non-GNUC platforms.

Which made me wonder if UNUSED really needs its guards. It does, because
it is defined early in the file, before the __attribute__ handling. I
don't think we want to move it down, since it needs to be available for
use by inline'd compat wrappers. But arguably we should move the
attribute macro earlier in the file?

I don't know that it is really worth spending too much time futzing
with, though.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index e4a306dd56..74ed581b5d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -673,7 +673,11 @@ static inline int git_has_dir_sep(const char *path)
>   * would give a warning in a compilation where it is unused.  In such
>   * a case, MAYBE_UNUSED is the appropriate annotation to use.
>   */
> +#ifdef __GNUC__
>  #define MAYBE_UNUSED __attribute__((__unused__))
> +#else
> +#define MAYBE_UNUSED
> +#endif

So yeah, I'm not necessarily opposed to this, but I don't think it's
really doing anything in practice.

-Peff
