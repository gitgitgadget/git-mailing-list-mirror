Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939B183CAB
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507139; cv=none; b=BM/wA0dAzgCceSjVwI3IMMYVFMcGAfB6V+1jXF1s/YtNl8sEuqjtfIbhwjh+LYghyZIiotcAWxQ68DrvCAvJDk6I3SoXG+hfpnBkPcgkOecZIslcleEaQIXIXbN9nPB83Kl7aSxJ72C7jV5cxgMUO7VUEDockfXOR8MNrOwid5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507139; c=relaxed/simple;
	bh=uMJziOkdeH484wEF7T9ooqBiJBLMz6m8lVk2dJnz1e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNkws3GgyLqRyQrBLtAYEClpVUM34n0KyjacxEYykJZpeX4/EGBvzHsYxN3WY9GzgIazscCGNecbbqvG2B5QrilshDFgj5FyI1a1pyNCXIKOTZIPQRaSGrADJkaeA1FGcKKputpDPXtV1pI1DcsjObcZx/sKUKZ7c9BoIUH9aqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18985 invoked by uid 109); 1 Aug 2024 10:12:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:12:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30469 invoked by uid 111); 1 Aug 2024 10:12:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:12:21 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:12:15 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/19] midx: teach `fill_midx_entry()` about
 incremental MIDXs
Message-ID: <20240801101215.GJ1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <2b335c45ae7832b886ef9adccc2530e4ca53d267.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b335c45ae7832b886ef9adccc2530e4ca53d267.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:25PM -0400, Taylor Blau wrote:

> After that point, we only need to make two special considerations within
> this function:
> 
>   - First, the pack_int_id returned to us by `nth_midxed_pack_int_id()`
>     is a position in the concatenated lexical order of packs, so we must
>     ensure that we subtract `m->num_packs_in_base` before accessing the
>     MIDX-local `packs` array.
> 
>   - Second, we must avoid translating the `pos` back to a MIDX-local
>     index, since we use it as an argument to `nth_midxed_offset()` which
>     expects a position relative to the concatenated lexical order of
>     objects.

OK. I think this is correct, but this would be another place where we
could use an nth_midxed_offset_one() function if we had one.

My thinking was that we'd avoid walking back over the midx chain again.
But I guess we don't actually do that, because our midx_for_object()
will have overwritten our "m" variable, as well. So inside
nth_midxed_offset_one() we'll immediately realize that the global
position is inside the midx we passed in. A little extra arithmetic, but
there's no pointer chasing.

-Peff
