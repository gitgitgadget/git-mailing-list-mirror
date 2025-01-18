Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CDD155747
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737192975; cv=none; b=LZi21bz7Kr7Ko1jYE9NdGmEqoJeSltmhvrvGp5NZ6iqPsERlx5fGEkuFNcpnpsREz5iYkFYRbZU2xlXmUkwIKZFOn53Quf9Thk7mkes6sZ9K/WYp/NpV85wOTJD5K2DFceFZNwGRzg/UolCUr1MCe5hSvtRT5ZRoerEsF3T4cg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737192975; c=relaxed/simple;
	bh=Wvqj1kYYke8wWfihnFLCXDsTbWSI3L0WU15g1FlcFgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asMDM7v5bL4Fmu9ypNFPSz2FN8RoYa6pZDlBxp4Zf97aZ/4AcJ6GYpIs63j/M8rYRghoLmtF53iiML1B3e01awG+lM0552YfwnT18QbqrdNyUOR5fILUTac72kNZl9zC4GntrOMxjP9aIodq1gdnzwL0qwOkBplrW46z0OTMwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YGHpA7tO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YGHpA7tO"
Received: (qmail 30191 invoked by uid 109); 18 Jan 2025 09:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Wvqj1kYYke8wWfihnFLCXDsTbWSI3L0WU15g1FlcFgA=; b=YGHpA7tOY1YZeDX5pkevoogjB3kTat+M54bzJVzsw52A8rwK4a6GykhDfLZ09bgJTKQCM6ukhg1bnlx3rRGifpQv9XDVnx/NHJ8B2CeFqhPSDAV/fpxfcY+uGpeipBUTZSxApPuZKstFhZKpFIK3z0gTB84MdvwuuSIZs+i2OkD1xVXDHFMyfla6XogoNbpBh8fihiVJyZwTX+EOv+ceWWQNSCMaoTWsOFXncjwvUwOmYb7v0/frWktQ2+R/WKWZ5sDqNhHBUsmOKbH4+pUHsAgEukb0BD04DXQr50wE4B8mFEFMX4SLm+VE0WC3u5TDEcb1jqFHsciidVFyCcJeuw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jan 2025 09:36:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19087 invoked by uid 111); 18 Jan 2025 09:36:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jan 2025 04:36:17 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jan 2025 04:36:12 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Koakuma <koachan@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] parse_pack_header_option(): avoid unaligned memory
 writes
Message-ID: <20250118093612.GC3474411@coredump.intra.peff.net>
References: <20250117125207.GB2356599@coredump.intra.peff.net>
 <20250117125530.GB2893666@coredump.intra.peff.net>
 <xmqq7c6s52ti.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c6s52ti.fsf@gitster.g>

On Fri, Jan 17, 2025 at 05:27:21PM -0800, Junio C Hamano wrote:

> static inline void put_be32(void *ptr, uint32_t value)
> {
> 	unsigned char *p = ptr;
> 	p[0] = value >> 24;
> 	p[1] = value >> 16;
> 	p[2] = value >>  8;
> 	p[3] = value >>  0;
> }
> 
> But sparse seems not to like that.
> 
> compat/bswap.h:175:22: error: cast truncates bits from constant value (5041 becomes 41)
> compat/bswap.h:176:22: error: cast truncates bits from constant value (504143 becomes 43)
> compat/bswap.h:177:22: error: cast truncates bits from constant value (5041434b becomes 4b)
> 
> Of course we could do the mask, but should we have to?

Cute. I think the above is well defined in terms of the C standard. But
I could see how a linter might want to remind you that you're truncating
a constant.

It is kind of lame that it only flags the call with a constant. If you
want to warn people that they are accidentally truncating, surely it's
obvious in the code above that truncation is _possible_ depending on the
value. It seems like it's either worth flagging as a dangerous
construct, or not; but doing it only for a constant is not super
helpful.

> I think the real compiler would be clever ehough to produce the
> identical binary with the following patch that is only needed to
> squelch this error, but I feel dirty after writing this.

I checked with "gcc -s" and it produces the same asm before and after
your patch, with both -O0 and -O2. So I don't think there's a practical
downside. As far as feeling dirty, I dunno. It is basically telling any
linter "yes, I know we are truncating here". Since it is contained
within put_be32() and won't spread across the code base, I'm not too
offended by it.

I guess the other option is to pass -Wno-cast-truncate to sparse.

> By the way, a "git grep" finds 
> 
> 	put_be32(&hdr_version, INDEX_EXTENSION_VERSION2);
> 
> in the fsmonitor.c file, which does not get flagged only because the
> CPP macro expands to a small integer (2).  That is doubly insulting.

Heh. Yeah, that goes back to my "kind of lame" comment above. ;)

-Peff
