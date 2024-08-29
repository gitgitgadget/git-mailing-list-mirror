Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7C192B85
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953939; cv=none; b=gztPjiwJckY9ANb1NDr6pyLGzv8/CWZUXliIAzOqs7TGpUmRPudxF1kUFlMxAOZ0F13BVJ8oXJeNa0mpuSawbsclu8jQNh8tqQ0N29YO20XLSCXkk+jOUgviorw+H3z2CeTOPZoNOZ/EFWvzFdUIglKWm/OxNcsQBjxnbaAXkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953939; c=relaxed/simple;
	bh=h2J2LTynUlX6Q6qAavWKG1704MTnGi265lXwZJrBB2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixlog+fCxvKJOSbJnGkBdqWyHbQjETSExWfbR9dpX6jAR7DPBcsnV2a3HhzGSXkNzy+tSAScIgQ7WVTkbE3P+9m1tcGKbCBukouezkCU9+9N1nw8u2XzhDIIYdZ2pjMLHAQNLn4shbFUVu927HvK/Rf5ATZm3SAutQh/1IOY+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4818 invoked by uid 109); 29 Aug 2024 17:52:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 17:52:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8968 invoked by uid 111); 29 Aug 2024 17:52:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 13:52:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 13:52:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/6] CodingGuidelines: also mention MAYBE_UNUSED
Message-ID: <20240829175215.GA415423@coredump.intra.peff.net>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <Zs348uXMBdCuwF-2@ArchLinux>
 <xmqqbk1cz69c.fsf@gitster.g>
 <20240829040215.GA4054823@coredump.intra.peff.net>
 <xmqqseunxtks.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqseunxtks.fsf_-_@gitster.g>

On Thu, Aug 29, 2024 at 08:00:19AM -0700, Junio C Hamano wrote:

> > Yes, it would be fine to use MAYBE_UNUSED in a case like this.
> 
> It turns out that I was, without realizing it myself, making an
> oblique reference to your patch 7/6 ;-)
> 
> Perhaps something along this line?

Yeah, this looks good. A few small comments below (but I'm not sure
anything needs to be changed).

> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
> index d0fc7cfe60..3263245b03 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -262,8 +262,9 @@ For C programs:
>     like "error: unused parameter 'foo' [-Werror=unused-parameter]",
>     which indicates that a function ignores its argument. If the unused
>     parameter can't be removed (e.g., because the function is used as a
> -   callback and has to match a certain interface), you can annotate the
> -   individual parameters with the UNUSED keyword, like "int foo UNUSED".
> +   callback and has to match a certain interface), you can annotate
> +   the individual parameters with the UNUSED (or MAYBE_UNUSED)
> +   keyword, like "int foo UNUSED".

Here I was going to suggest explaining why you'd use one or the other
(because I'm afraid of people using MAYBE_UNUSED when UNUSED would be
more appropriate). But I think the extra comments you added later are
even better, as it lets us explain without cluttering up the
CodingGuidelines document.

> +/*
> + * UNUSED marks a function parameter that is always unused.
> + *
> + * A callback interface may dictate that a function accepts a
> + * parameter at that position, but the implementation of the function
> + * may not need to use the parameter.  In such a case, mark the parameter
> + * with UNUSED.
> + *
> + * When a parameter may be used or unused, depending on conditional
> + * compilation, consider using MAYBE_UNUSED instead.
> + */

Looks good.

> +/*
> + * MAYBE_UNUSED marks a function parameter that may be unused, but
> + * whose use is not an error.
> + *
> + * Depending on a configuration, all uses of a function parameter may
> + * become #ifdef'ed away.  Marking such a parameter with UNUSED would
> + * give a warning in a compilation where the parameter is indeed used,
> + * and not marking such a parameter would give a warning in a
> + * compilation where the parameter is unused.
> + */
>  #define MAYBE_UNUSED __attribute__((__unused__))

This is all good as pertains to function parameters. But the original
reason we added MAYBE_UNUSED was actually for static functions that were
auto-generated by the commit-slab macros. Saying "...marks a function
parameter" implies to me that it's the only use. I don't know if we want
to be more expansive here or not. Adding auto-generated macro functions
should be quite a rarity, I'd think.

-Peff
