Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327918452B
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508830; cv=none; b=mg5YffgwBYAVt1/WljgJg2QAuqi9Vnajwol9L5cXGWA7B1LEe2feD3xX72AekxUBNhGvygw8vkCtgOOaYeu7vp9FPsuCScEn3pAdUeWiGs/ZoqGS/tjXxFFQ1wvKb7wsofc6XAD2VtmktSbiXE1F/R7PYerw0wNmPrT40IA+QAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508830; c=relaxed/simple;
	bh=ew8/TRdHqFAO/bb5zmdw14+18+b7eY71j78O/1XLrUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUAHzcwrPGz6DNST/r3xurIQgm61DoaA30l0x1UkRQd/9yuWOPIodKyJQ+hftzKuw0t2YpZLRQvdYBgicjQIm4/GlDUUAz3m37vhWJt7RHFE5CbBRZ3thVntWxCS3rmm4l1QXarD6S2JdTXCOiYzuKaG57lZQyl2lmG82ppJHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19388 invoked by uid 109); 1 Aug 2024 10:40:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:40:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30791 invoked by uid 111); 1 Aug 2024 10:40:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:40:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:40:26 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/19] midx: support reading incremental MIDX chains
Message-ID: <20240801104026.GO1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <dad130799c0d41d14375539bb12978e37849a721.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dad130799c0d41d14375539bb12978e37849a721.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:41PM -0400, Taylor Blau wrote:

> Now that the MIDX machinery's internals have been taught to understand
> incremental MIDXs over the previous handful of commits, the MIDX
> machinery itself can begin reading incremental MIDXs.
> 
> (Note that while the on-disk format for incremental MIDXs has been
> defined, the writing end has not been implemented. This will take place
> in the commit after next.)
> 
> The core of this change involves following the order specified in the
> MIDX chain and opening up MIDXs in the chain one-by-one, adding them to
> the previous layer's `->base_midx` pointer at each step.

This makes it sound like reading a chain file of:

  multi-pack-index-$H1.midx
  multi-pack-index-$H2.midx
  multi-pack-index-$H3.midx

will have H1's base_midx pointing to H2. But the design document from
the first patch made me think it went the other way (H1 is the oldest
midx, then H2, then H3). For many things the ordering doesn't matter,
but I'd think the pseudo-pack order would go from the root of the
base_midx walk to the tip. That is, the base_midx pointers go in reverse
chronological order.

Looking at the code, I think it's doing what I expect. Not sure if I'm
mis-reading what you wrote above, or if it's wrong.

> [...]

The code itself all looked reasonable. There are a scary number of spots
where we have to do global/local position conversion. It's hard to know
if you got them all.

-Peff
