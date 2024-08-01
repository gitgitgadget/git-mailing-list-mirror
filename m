Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B518B482
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504106; cv=none; b=PAhL6Em39CnnchZ1EJnavWatqdfEVWGZj//iCg/Rke3kEZqWIfmI1vtVTQc7lAKb4SkxIY2gXQyMjRCsRGHgLuRV/9M02Lfe4WG7rnyTiK/bZtXy79eK2kui1AsPNi874IFhU8qz9CaHkGtV1kSCepOpDA1uRTPxPHS8oyMlKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504106; c=relaxed/simple;
	bh=m7nkgrxK1taXBsNgIJCnXSQExbwwFqEpjEtlJ1/OVlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXHYMxqZXONUb0/zOQm3QeGkn5Z3lkPYq+yK9M1q5EQBDDEjqjKDoldiKHtGUyXX2NCZBC1VemghA/VO75O+T+zAxNhgY14Ke0heoTFjXQ/C/IRf2K7Lw109jC641l6+k4K1u4j3+gTPQJCmKJzGk2vg4KrlipsAfdQXqAfBRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17725 invoked by uid 109); 1 Aug 2024 09:21:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 09:21:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30059 invoked by uid 111); 1 Aug 2024 09:21:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 05:21:48 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 05:21:42 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/19] midx: add new fields for incremental MIDX chains
Message-ID: <20240801092142.GB1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <337ebc6de7bdf6ff3b4b09c2bea3df2802174e8b.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <337ebc6de7bdf6ff3b4b09c2bea3df2802174e8b.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:01PM -0400, Taylor Blau wrote:

> The incremental MIDX chain feature is designed around the idea of
> indexing into a concatenated lexicographic ordering of object IDs
> present in the MIDX.
> 
> When given an object position, the MIDX machinery needs to be able to
> locate both (a) which MIDX layer contains the given object, and (b) at
> what position *within that MIDX layer* that object appears.
> 
> To do this, three new fields are added to the `struct multi_pack_index`:
> 
>   - struct multi_pack_index *base_midx;
>   - uint32_t num_objects_in_base;
>   - uint32_t num_packs_in_base;
> 
> These three fields store the pieces of information suggested by their
> respective field names. In turn, the `num_objects_in_base` and
> `num_packs_in_base` fields are used to crawl backwards along the
> `base_midx` pointer to locate the appropriate position for a given
> object within the MIDX that contains it.

OK, so base_midx is a back-pointer. I think in theory you could compute
num_objects_in_base on the fly by doing that crawl yourself, but we'd
want to be able to do it in constant time, rather than O(# of midx)?

Makes sense.

-Peff
