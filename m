Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2416FF3B
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504609; cv=none; b=hWedH8LCaj7nd19yETugY06c5Jz6+9j31bZBoIgj3mS90s4k0TAaNoYqOMgrYMZIdQveYFjJUCcXs0saOCa6020xqzrgTVOBrJuE5VbXzmaogW2LvHE95HxZq4qIX/rKJ57DBkJZqJvanSkf7Z8PRYf+5q64s+BZMGjiqB+S5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504609; c=relaxed/simple;
	bh=RanWnV+eZXk6eJrtrg5FTttNCNvZOBAc83SnaRg4NPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiRi7bHC2IDl/Dxg3sYNW/hTk5vG4bH1i/ipWCf7r3nefZ25FhLaRqQVOd/7cJ2VaLoqIqoGDXPwmypTmNo5vthWU3NggO1Ft8BP/+YpSAe1vt/yCPEqVP9vIFLf8p/mnsz+lQ9dxgoa8TNPLxCDe5ve22kzaohszFAuBEg487g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17767 invoked by uid 109); 1 Aug 2024 09:30:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 09:30:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30109 invoked by uid 111); 1 Aug 2024 09:30:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 05:30:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 05:30:06 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/19] midx: teach `nth_midxed_pack_int_id()` about
 incremental MIDXs
Message-ID: <20240801093006.GC1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <f449a72877de97d89e31a56724b4f65be2f33f20.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f449a72877de97d89e31a56724b4f65be2f33f20.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:04PM -0400, Taylor Blau wrote:

> [^1]: As a reminder, this means that the object is identified among the
>   objects contained in all layers of the incremental MIDX chain, not any
>   particular layer. For example, consider MIDX chain with two individual
>   MIDXs, one with 4 objects and another with 3 objects. If the MIDX with
>   4 objects appears earlier in the chain, then asking for pack "6" would
>   return the second object in the MIDX with 3 objects.

I think this is "object 6" in the final sentence?

Otherwise, the explanation lays things out pretty well. Let's look at
the code.

> +static uint32_t midx_for_object(struct multi_pack_index **_m, uint32_t pos)
> +{
> +	struct multi_pack_index *m = *_m;
> +	while (m && pos < m->num_objects_in_base)
> +		m = m->base_midx;

OK, so given a global position, we walk backwards until we find the
correct midx...

> +	if (!m)
> +		BUG("NULL multi-pack-index for object position: %"PRIu32, pos);
> +
> +	if (pos >= m->num_objects + m->num_objects_in_base)
> +		die(_("invalid MIDX object position, MIDX is likely corrupt"));

...and we double check that the given base claims to have that position.
Seems obvious.

> +	*_m = m;
> +
> +	return pos - m->num_objects_in_base;

And then we adjust it into a per-midx position.

> @@ -334,8 +351,10 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
>  
>  uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
>  {
> -	return get_be32(m->chunk_object_offsets +
> -			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
> +	pos = midx_for_object(&m, pos);
> +
> +	return m->num_packs_in_base + get_be32(m->chunk_object_offsets +
> +					       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
>  }

OK, so now this function translates a global position into a local one,
and then we get the pack id for the local midx/pos, and then turn it
back into a global pack id.

That all makes sense, but you definitely have to read carefully to make
sure which positions/ids are global within the chain and which are local
to a midx.

I wonder if the type system can help us annotate them, but I suspect it
becomes awkward. Just typedef-ing them to uint32_t means the compiler
won't warn us when we use one in the wrong spot. Sticking them in
structs would solve that, but then using them is painful. Let's keep
reading and see if it's even an issue in practice.

-Peff
