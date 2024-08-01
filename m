Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C0CEEB3
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504953; cv=none; b=g9+Lmd+DMEthkYcCfxg/CaUGpFZN8KzDOvEIJh5bg/Vq8fxj/2lhhTQJYQ5aIB/E4ExE/MoLrcC88o9U6kC0bv6NCr19DRvToC9Si/nM2m2RPI3zAeAd7nxBE9kS5F2kcT9c3BtJm6ztmyh+W2T+ucOJ+m7QnxWAQRlPbcVAxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504953; c=relaxed/simple;
	bh=wNg5oCgOUhtoAibYjIZ2ZA1ekaxCZgtdWRDuI2sDNW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqSIgfj4MvhnZrZLtXDDIiuBiYmCpJWsscYbcd35FrzBvN0oTW+9TgEaTFx0Rh2CaKQazBhCY4RDEYQAGRnGZWGPxRVaJJ7L/niBGhfB05jQUf07I1/Ro+NycEOf80guixunbeeFtasWdSDfB+emp7cS4mrxl60TpEAoUI92V+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18562 invoked by uid 109); 1 Aug 2024 09:35:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 09:35:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30181 invoked by uid 111); 1 Aug 2024 09:35:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 05:35:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 05:35:50 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/19] midx: teach `prepare_midx_pack()` about
 incremental MIDXs
Message-ID: <20240801093550.GD1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <f88569c819292a824c78cdffd4e1fbc329f07f8e.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f88569c819292a824c78cdffd4e1fbc329f07f8e.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:07PM -0400, Taylor Blau wrote:

> The function `prepare_midx_pack()` is part of the midx.h API and
> loads the pack identified by the MIDX-local 'pack_int_id'. This patch
> prepares that function to be aware of an incremental MIDX world.
> 
> To do this, introduce the second of the two general purpose helpers
> mentioned in the previous commit. This commit introduces
> `midx_for_pack()`, which is the pack-specific analog of
> `midx_for_object()`, and works in the same fashion.
> 
> Like `midx_for_object()`, this function chases down the '->base_midx'
> field until it finds the MIDX layer within the chain that contains the
> given pack.
> 
> Use this function within `prepare_midx_pack()` so that the `pack_int_id`
> it expects is now relative to the entire MIDX chain, and that it
> prepares the given pack in the appropriate MIDX.

OK, I'm adequately prepared for more global/local confusion. :)

> -int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
> +static uint32_t midx_for_pack(struct multi_pack_index **_m,
> +			      uint32_t pack_int_id)
>  {
> -	struct strbuf pack_name = STRBUF_INIT;
> -	struct packed_git *p;
> +	struct multi_pack_index *m = *_m;
> +	while (m && pack_int_id < m->num_packs_in_base)
> +		m = m->base_midx;

OK, so we chase down the pack id as before...

> +	if (!m)
> +		BUG("NULL multi-pack-index for pack ID: %"PRIu32, pack_int_id);
> +
> +	if (pack_int_id >= m->num_packs + m->num_packs_in_base)
>  		die(_("bad pack-int-id: %u (%u total packs)"),
> -		    pack_int_id, m->num_packs);
> +		    pack_int_id, m->num_packs + m->num_packs_in_base);

...with the same sanity checks...

> +	*_m = m;
> +
> +	return pack_int_id - m->num_packs_in_base;

...and the same global to local offset conversion. Looks good so far.

> +int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
> +		      uint32_t pack_int_id)
> +{
> +	struct strbuf pack_name = STRBUF_INIT;
> +	struct packed_git *p;
> +	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);

This one uses a separate variable with the word "local" in it. Helpful. :)

> +	if (m->packs[local_pack_int_id])
>  		return 0;
>  
>  	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
> -		    m->pack_names[pack_int_id]);
> +		    m->pack_names[local_pack_int_id]);

OK, and then this is just existing lazy-load of the pack struct. Good.

I guess if you just reused pack_int_id for the local id, the diff would
be much smaller (this part would remain exactly the same). I dunno which
is better, but it was a little curious that the two patches differed in
approach. Probably not worth caring too much about, though.

-Peff
