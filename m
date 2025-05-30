Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAF10F1
	for <git@vger.kernel.org>; Fri, 30 May 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587840; cv=none; b=rUEipwonupzqXRK+gJh0TNvUauckU/mfdw+jpyMOq1OvQI3UpDwXO655GSFHLLkfuhaoH5NwNdvv3T7R+xa44SxZExoesnyBZKOgu3eZftlp/nOAdS3flhywoWX83GDyo/3SfH04duqEP/2KHAajTGvHurjke7qOwzEzcwR7eAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587840; c=relaxed/simple;
	bh=w50Gpgdtvdx8ixg8YmaOkc8v62FLVROYn+C/gr39wus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyvF9UdBBDjpkTuXoYnmzseYM8lbAygcUNlNunwyAOrTJxkFtu+YVaWQzLooSDr294sIxV/Uu5IbVFkaUngzXEhubFho1DXaMCjbrubHOiQO4Uz0aPn4e0gf0u7WY0w60OEDkAJD38MpG5S9G3/R8ZANXqMqmzJ60h9imlw0lCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gW2b0LG2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gW2b0LG2"
Received: (qmail 2434 invoked by uid 109); 30 May 2025 06:50:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=w50Gpgdtvdx8ixg8YmaOkc8v62FLVROYn+C/gr39wus=; b=gW2b0LG2TxjlaELBfEHB8n9LFl03JL7D0eREUaqqlgCOUou/5Du/hmxa5vmP252gwjw2Za0PLkWdU5hpK01v5Av51LgNIVgYJaT6/SLdO2s1h0Z0TcuNZYOOt2X2XWghO6Kvy+TALMXCcBjY1kTP4bzdMPIw5MWrr5PyyHCDI0tEdMxXKoQVDoRRev64HShUGYJsJm+WoDrs9IQuZvXk2+kAahlzuMJdQxGR0yPx9/bws57cBNvuyyj71lMpURKx746G3FvYHHHRyT4bkJuWk0FKkOeKFppt1BUeN3J9cbfDENSt/Y7RUyITpW+fkBpQ+89+++Otbl/jklioD33RWg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 May 2025 06:50:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8360 invoked by uid 111); 30 May 2025 06:50:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 May 2025 02:50:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 May 2025 02:50:34 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] midx: return a `packed_git` pointer from
 `prepare_midx_pack()`
Message-ID: <20250530065034.GC1321283@coredump.intra.peff.net>
References: <cover.1748198489.git.me@ttaylorr.com>
 <cover.1748473122.git.me@ttaylorr.com>
 <e3e21db673f3ae6e574333d4678a0450fa44fb9c.1748473122.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3e21db673f3ae6e574333d4678a0450fa44fb9c.1748473122.git.me@ttaylorr.com>

On Wed, May 28, 2025 at 06:59:09PM -0400, Taylor Blau wrote:

> Let's instead have prepare_midx_pack() return a pointer to the
> packed_git structure itself, hiding the above as an implementation
> detail of prepare_midx_pack(). This patch turns the above snippet into:
> 
>     struct packed_git *p = prepare_midx_pack(the_repository, some_midx,
>                                              some_pack_int_id);
>     if (!p)
>         die("could not load pack xyz");
> 
> making it far easier and less error-prone to access packs by their
> pack_int_id in a MIDX chain.

So obviously I like this direction, but a few small comments:

> (In the future, we may want to consider similar treatment for, e.g., the
> pack_names array. Likewise, it might make sense to rename the "packs"
> member of the MIDX structure to suggest that it shouldn't be accessed
> directly outside of midx.c.)

Is this note still valid for v2? It looks like patch 1 adds
nth_midxed_pack_name() and tries to use it everywhere.

> @@ -1649,9 +1646,9 @@ static int want_included_pack(struct repository *r,
>  
>  	ASSERT(m && !m->base_midx);
>  
> -	if (prepare_midx_pack(r, m, pack_int_id))
> +	p = prepare_midx_pack(r, m, pack_int_id);
> +	if (!p)
>  		return 0;
> -	p = m->packs[pack_int_id];
>  	if (!pack_kept_objects && p->pack_keep)
>  		return 0;
>  	if (p->is_cruft)

The ASSERT() in the context is from earlier in the series. But do we
need it once we have this patch? We no longer look at pack_int_id except
to pass it to prepare_midx_pack(), which handles non-base midx slices
just fine.

So we could loosen the assertion now. Or we could wait for later when
somebody wants/needs to do so, but I'm not sure how easy they would find
it to dig in the history. They would find the commit that added the
ASSERT(), but may not realize that this later commit made it OK to
loosen.

I didn't check the other ASSERT() spots from that earlier patch (IIRC,
some of them may actually look use the pack_int_id for other things, and
wouldn't be ready for non-base slices).

> -int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
> -		      uint32_t pack_int_id)
> +struct packed_git *prepare_midx_pack(struct repository *r,
> +				     struct multi_pack_index *m,
> +				     uint32_t pack_int_id)

We used to return "1" for failure and "0" for success. Now we're
reversed: we return NULL for failure and non-zero for success.

So code like:

  if (prepare_midx_pack(...))
	return error("yikes");

needs to be updated, but the compiler won't help us because it is happy
to convert both an int and a pointer into a boolean check.

Should we rename the function to make sure we catch any callers for
topics in flight?

I'd have thought we could call it nth_midxed_pack(), but that seems to
exist already, with the caveat that it never prepares the pack, but only
serves what's in the cache. I wonder if we could simply replace that
with what prepare_midx_pack() does, but it may be more conservative to
leave the two separate. So I guess nth_midxed_pack_load() or something.

-Peff
