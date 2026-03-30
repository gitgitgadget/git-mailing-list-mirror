Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133613E6395
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910042; cv=none; b=RiS7qZ6SMgjIdEzmT1XnBecWbV5wtZ2WapV8c5K1uZjdLBmofy8P/pNLDMb1lO4w7m49ajsrNgEs1NEp1pG00Lly//oPkzkJjtcfDtGlocpPG1/nEGNls5OukEIHtFiQs2ejRQDPDo29/b0PJ2x5WoACfr+zI14DyeB+DPSO1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910042; c=relaxed/simple;
	bh=pnfVn54+0mvaOjbNHQynZGIKuQyMLZmrZCnPgVdXPHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7OZSz3oAAKdxhdZUO4OtMyGUwzniPJG5z6owoLLE3vz86cl2BvxWqIvvAlorKOPS0vI7gbm7jFuillJRcI0t+4AW/Y9Gxo564onJus4l7F8YxzaFzfKUd4Qa0aM3X8xrj78fCyLQdLmlqbD+uC1XLEXv5xQ9BA7kdy1+BP7MYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PO2XTzOT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PO2XTzOT"
Received: (qmail 199106 invoked by uid 106); 30 Mar 2026 22:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pnfVn54+0mvaOjbNHQynZGIKuQyMLZmrZCnPgVdXPHk=; b=PO2XTzOTx+WF5cFOmCBHQ5CLGhn3dD6L6Ve7Cy7Qa2EKuaNLyuwjbBd7XH41sBmNwkDcwjPSSG6/t3IlwC5qsW1UuW5OuQgADdS9tZanwdYGN1SSHlYtbIJn7AL5puoSIn21cxWxGOEHptmeGWvns7s6eZa1b4CDxt734qql+KO04PA7PSpknNGqun1MzVfFz+5Jqv4gnuglI23uAnNfp7TvSNzV0bLWdGQ1VKUQypPagnmWE7x6VwPWOt0XG4UL4x1Re/PHWSGG+vtxJQl6qt1yu5zITRyQSIcE2Aij/V2NjNcMRy+o7js7oYSiyCYQ7VA0yra5Q5jlnJt1WldFgg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Mar 2026 22:33:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 305915 invoked by uid 111); 30 Mar 2026 22:33:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2026 18:33:47 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Mar 2026 18:33:46 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 01/16] midx-write: handle noop writes when converting
 incremental chains
Message-ID: <20260330223346.GA41843@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <0c7a68ca5a777cce9c0c951643ea2220b1b56a8c.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c7a68ca5a777cce9c0c951643ea2220b1b56a8c.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:40:53PM -0400, Taylor Blau wrote:

> This comparison fails when we have an incremental MIDX chain with
> at least two layers, since we do not recursively peel through earlier
> layers, instead treating the `->pack_names` array of the tip MIDX layer
> as containing all `m->num_packs + m->num_packs_in_base` packs.
> 
> Adjust this to instead look through the MIDX layers one by one when
> comparing pack names. While we're at it, fix a typo above in the same
> function.

Makes sense.

> @@ -1208,14 +1208,16 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
>  			BUG("same pack added twice?");
>  	}
>  
> -	for (uint32_t i = 0; i < ctx->nr; i++) {
> -		strbuf_reset(&buf);
> -		strbuf_addstr(&buf, midx->pack_names[i]);
> -		strbuf_strip_suffix(&buf, ".idx");
> +	for (struct multi_pack_index *m = midx; m; m = m->base_midx) {
> +		for (uint32_t i = 0; i < m->num_packs; i++) {
> +			strbuf_reset(&buf);
> +			strbuf_addstr(&buf, m->pack_names[i]);
> +			strbuf_strip_suffix(&buf, ".idx");
>  
> -		if (!strset_contains(&packs, buf.buf))
> -			goto out;
> -		strset_remove(&packs, buf.buf);
> +			if (!strset_contains(&packs, buf.buf))
> +				goto out;
> +			strset_remove(&packs, buf.buf);
> +		}

I wondered here if we would also need to adjust the check of the count,
but it is already OK. Just above the context is:

          if (ctx->nr != midx->num_packs + midx->num_packs_in_base)
                  goto out;

which handles the layered midx. Since we were counting up to ctx->nr
before, which includes packs in base midx layers, I guess these old
lines:

> -	for (uint32_t i = 0; i < ctx->nr; i++) {
> [...]
> -		strbuf_addstr(&buf, midx->pack_names[i]);

was probably reading garbage off the end of the array.

Now we iterate through each layer individually. We assume that the total
count matches ctx->nr, otherwise the midx struct is totally corrupt. We
could count them and double-check, I guess, but I don't think there's
much point (it would be a BUG() if they were mismatched).

So looks good to me.

-Peff
