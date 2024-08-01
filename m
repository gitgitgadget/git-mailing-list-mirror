Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E5446A1
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507920; cv=none; b=PoBtXC83w2+vPSlLoDMQ0fkrOtx9yvHjhNhmXUv0o92Q5VHj0JnNsgNkF2tnsERRkNxpUUiUcipD+3Y5KAS3djXH9pJqZMvWsH/c7bDP2xC+Evpz9hZ4WUoPHlfOEWAX1sduVvtyoPf9wXtHuekqUywOz7ZpNeJtH59sJLG97N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507920; c=relaxed/simple;
	bh=31NNyLdDb5FKUxOhDQqXX4v3LB/exgNN9jIJShhnKMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKg4uO33MIf35vHg1zu65Cxx4gr2WWLOkwQSx25radFMrDfzw3hXAeqyUojMnIhRuHjTa9ykZiNm9CnzIGpAInZrtDkGsUFM4kRmDfpVrYf1/HkdDZ14fm699vogt4N0ngCC5HNx73M+0+2PfCPyTABGOk6SsKuLIPgFTIjfrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19114 invoked by uid 109); 1 Aug 2024 10:25:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:25:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30603 invoked by uid 111); 1 Aug 2024 10:25:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:25:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:25:17 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/19] midx: teach `midx_preferred_pack()` about
 incremental MIDXs
Message-ID: <20240801102517.GM1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <38b642d40423f2e14dd47d676de54f264b9d6f22.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38b642d40423f2e14dd47d676de54f264b9d6f22.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:35PM -0400, Taylor Blau wrote:

> The function `midx_preferred_pack()` is used to determine the identity
> of the preferred pack, which is the identity of a unique pack within
> the MIDX which is used as a tie-breaker when selecting from which pack
> to represent an object that appears in multiple packs within the MIDX.
> 
> Historically we have said that the MIDX's preferred pack has the unique
> property that all objects from that pack are represented in the MIDX.
> But that isn't quite true: a more precise statement would be that all
> objects from that pack *which appear in the MIDX* are selected from that
> pack.
> 
> This helps us extend the concept of preferred packs across a MIDX chain,
> where some object(s) in the preferred pack may appear in other packs
> in an earlier MIDX layer, in which case those object(s) will not appear
> in a subsequent MIDX layer from either the preferred pack or any other
> pack.

OK, that matches my intuition for how the preferred concept should
exist. I'm not quite clear on how that will affect the code, though.

> diff --git a/midx.c b/midx.c
> index 0fa8febb9d..d2dbea41e4 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -500,13 +500,16 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
>  int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
>  {
>  	if (m->preferred_pack_idx == -1) {
> +		uint32_t midx_pos;
>  		if (load_midx_revindex(m) < 0) {
>  			m->preferred_pack_idx = -2;
>  			return -1;
>  		}
>  
> -		m->preferred_pack_idx =
> -			nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
> +		midx_pos = pack_pos_to_midx(m, m->num_objects_in_base);
> +
> +		m->preferred_pack_idx = nth_midxed_pack_int_id(m, midx_pos);
> +

OK, so rather than looking for the pack of object 0, we're looking for
the first one in _this_ layer, since the position is global within the
midx. That makes some sense, but is pack_pos_to_midx() ready for that?
It looks like it just looks at m->revindex_data. Are we going to be
generating a revindex for the whole chain? I'd think that each layer
would have its own revindex (and any trickiness would happen at the
generation stage, making sure we don't insert objects that are already
mentioned in earlier layers).

-Peff
