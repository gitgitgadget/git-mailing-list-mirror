Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F294172773
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506799; cv=none; b=gs2J26VJqt814u9YY8CyFR7jG6B7jdrrbut4wqD9R2dk/yAry539ofPGWN+ycLSvFhhFnbl3JLcZPs/YrUEg95W+uM9aM26EqPyaB494Y3Q6HksNWHRb3zagOpolXb745MsiopDRFfwczHBRR8MEshUDufUR2dY6V7dbDjZeoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506799; c=relaxed/simple;
	bh=Qvp0+dWaCoAN1L0vQAIQ5rZrmHiPP0c/qhkKmuk1fl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv2dxO50UCf6F63y3aqYTbbFWiM+aRFt+3gJzk+GJMU4eg/JZlc+5kPy61uPSLlF4MAVBCffxxUti0+lQDR367EuF6amfVEMoHLO8jold9Q9YNXzA5dM/+PgMnIp9jk5bGgT4AYwMMF2juSBRtr99ft4WcDjEnl6JcmRxOQKBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18902 invoked by uid 109); 1 Aug 2024 10:06:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:06:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30402 invoked by uid 111); 1 Aug 2024 10:06:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:06:41 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:06:35 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/19] midx: introduce `bsearch_one_midx()`
Message-ID: <20240801100635.GG1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <bfd1dadbf15cf735392ca15b52834f104cbd6538.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfd1dadbf15cf735392ca15b52834f104cbd6538.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:16PM -0400, Taylor Blau wrote:

> The `bsearch_midx()` function will be extended in a following commit to
> search for the location of a given object ID across all MIDXs in a chain
> (or the single non-chain MIDX if no chain is available).
> 
> While most callers will naturally want to use the updated
> `bsearch_midx()` function, there are a handful of special cases that
> will want finer control and will only want to search through a single
> MIDX.
> 
> For instance, the object abbreviation code, which cares about object IDs
> near to where we'd expect to find a match in a MIDX. In that case, we
> want to look at the nearby matches in each layer of the MIDX chain, not
> just a single one).

Hmm. That seems like a weird thing for the object abbreviation code to
want, just because the layers of the midx are essentially random with
respect to object names. So you have to search each layer individually
when looking for a contiguous segment of hash names. But maybe that's
why you want the one_midx() variant. Let's see...

>  static void unique_in_midx(struct multi_pack_index *m,
>  			   struct disambiguate_state *ds)
>  {
> -	uint32_t num, i, first = 0;
> -	const struct object_id *current = NULL;
> -	int len = ds->len > ds->repo->hash_algo->hexsz ?
> -		ds->repo->hash_algo->hexsz : ds->len;
> -	num = m->num_objects;
> +	for (; m; m = m->base_midx) {
> +		uint32_t num, i, first = 0;
> +		const struct object_id *current = NULL;
> +		int len = ds->len > ds->repo->hash_algo->hexsz ?
> +			ds->repo->hash_algo->hexsz : ds->len;
>  
> -	if (!num)
> -		return;
> +		num = m->num_objects + m->num_objects_in_base;
>  
> -	bsearch_midx(&ds->bin_pfx, m, &first);
> +		if (!num)
> +			continue;
>  
> -	/*
> -	 * At this point, "first" is the location of the lowest object
> -	 * with an object name that could match "bin_pfx".  See if we have
> -	 * 0, 1 or more objects that actually match(es).
> -	 */
> -	for (i = first; i < num && !ds->ambiguous; i++) {
> -		struct object_id oid;
> -		current = nth_midxed_object_oid(&oid, m, i);
> -		if (!match_hash(len, ds->bin_pfx.hash, current->hash))
> -			break;
> -		update_candidates(ds, current);
> +		bsearch_one_midx(&ds->bin_pfx, m, &first);
> +
> +		/*
> +		 * At this point, "first" is the location of the lowest
> +		 * object with an object name that could match
> +		 * "bin_pfx".  See if we have 0, 1 or more objects that
> +		 * actually match(es).
> +		 */
> +		for (i = first; i < num && !ds->ambiguous; i++) {
> +			struct object_id oid;
> +			current = nth_midxed_object_oid(&oid, m, i);
> +			if (!match_hash(len, ds->bin_pfx.hash, current->hash))
> +				break;
> +			update_candidates(ds, current);
> +		}
>  	}
>  }

This is much easier to read with "-w", of course. So yeah, the gist of
it is that we're going to loop over items in the chain via the base_midx
pointer, and then search each individually. So that makes sense.

One thing that confused me, though, is setting "num". From the "-w"
diff:

  -       num = m->num_objects;
  +
  +               num = m->num_objects + m->num_objects_in_base;
  
                  if (!num)
  -               return;
  +                       continue;

Before we only had one midx, so that was our limit. But now we are
looking at "num" as a limit in the global size of the chained midx.
Which feels weird, since we're just considering a single layer here. We
seem to use "num" in two ways:

  - we return if it's 0 (or now continue to the next layer). But
    wouldn't we want to do that per-layer? I don't think it will produce
    wrong answers, but we're less likely to kick in this early return
    (though it's not clear to me when it would ever kick in really; a
    zero-length midx?).

  - later we loop "i" from "first", using "num" as a boundary. But this
    "i" is a global position, since that's what bsearch_one_midx()
    returns, and what nth_midxed_object_oid() expects.

    So I think it's correct, though it feels like bsearch_one_midx()
    should still return the position within that midx (and then
    bsearch_midx() could add back m->num_objects_in_base to get a global
    position). And then I guess likewise there would need to be a
    midx-local version of nth_midxed_object_oid().

    I'm not sure if that would make things simpler, or just add to the
    confusion, though. It's easy to get the global/local functions mixed
    up, since of course the global ones also have to take a "struct
    multi_pack_index". We could make them take a
    "multi_pack_index_chain" instead, but now all of the other code
    which wants to treat chains and single midx files the same has to
    care about the distinction (probably by wrapping the single midx in
    a one-entry chain struct).


> @@ -708,37 +712,40 @@ static int repo_extend_abbrev_len(struct repository *r UNUSED,
>  static void find_abbrev_len_for_midx(struct multi_pack_index *m,
>  				     struct min_abbrev_data *mad)

And likewise here (again, much more readable with "-w"). Interestingly,
in this one...

>  {
> -	int match = 0;
> -	uint32_t num, first = 0;
> -	struct object_id oid;
> -	const struct object_id *mad_oid;
> +	for (; m; m = m->base_midx) {
> +		int match = 0;
> +		uint32_t num, first = 0;
> +		struct object_id oid;
> +		const struct object_id *mad_oid;
>  
> -	if (!m->num_objects)
> -		return;
> +		if (!m->num_objects)
> +			continue;

We do the early return/continue directly on the layer's m->num_objects,
which makes sense.

> -	num = m->num_objects;
> -	mad_oid = mad->oid;
> -	match = bsearch_midx(mad_oid, m, &first);
> +		num = m->num_objects + m->num_objects_in_base;
> +		mad_oid = mad->oid;
> +		match = bsearch_one_midx(mad_oid, m, &first);

But then of course we go back to the same global "num", as we must.

So I think it's all correct, minus the early continue on "!num" in the
first function.

-Peff
