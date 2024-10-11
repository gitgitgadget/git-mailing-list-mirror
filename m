Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AE1CDA31
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633713; cv=none; b=TBGpkYbKtQghL5avZhvR2J76FJ+zTsyEuIh9Se9hGyL9SRMWC2Od36PPfAyseuL1LB9Pqis/E0H53o/0xhXxJ8vqGF0XQiLlZN/mfESGVSsr53v2OtSCtE1ssMl52ZYQ5UXfRsH8bLAVSXYnnSWyTgP9B/w5Za4y5SkYDBE8rwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633713; c=relaxed/simple;
	bh=HXSliCXN/OdtOsx4QaPILqkmdhQBiyCKgGxWWxbWLPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWXgTDmosEvreRB4CeW2u1PLCCHNimHBk4r+By/cw9skeHKAgNJLO9WDmPUv7IlZGGTdvnOQtT8iHgSjzIOABj+ntk3BZk4Ix5Jmve0gO8gCdUR8A+MawriQ7GesLPNoNqI1hGKQ6h850n+yBF+llsJzNUllxWy/V5xk2Pi6BEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Guvo/ul4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Guvo/ul4"
Received: (qmail 5197 invoked by uid 109); 11 Oct 2024 08:01:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HXSliCXN/OdtOsx4QaPILqkmdhQBiyCKgGxWWxbWLPs=; b=Guvo/ul4FF3QO87QPOmkr3hN2tiwUzFrH6OeJh0UzfcW1o68ALi33VPRW94msp3nQ+TSGJtOgS/oTHzF58PPwaYxIZ2C3gKN7ccUb+8KHV3dfurJxrSov9dftXJjO/YUOGM5jcEE3LWRhBWsoRqHRRcRGzSEeNp7wGZdGG+HiU1ksCQfwmgEoHfUsf+ooDHSfUAbJgJOGu51FHZtPSOKpPU7C6dB/3x9jtodowR2sPL0RzRllOepqC7WfbOSAKQMlAEMK0ANcoVSZp8w7c9lNi5n5GnFvf6rWc0hbltVMRLY8NKWxm6lJyZaLuFhdoPHa0QTJdSC7W1ZHmq+mvGo3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 08:01:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17532 invoked by uid 111); 11 Oct 2024 08:01:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 04:01:50 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 04:01:49 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <20241011080149.GA560372@coredump.intra.peff.net>
References: <cover.1728505840.git.me@ttaylorr.com>
 <xmqqzfnblxdj.fsf@gitster.g>
 <ZwgJt19kWVRTQhld@nand.local>
 <xmqq8quvk8w9.fsf@gitster.g>
 <20241011075451.GD18010@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011075451.GD18010@coredump.intra.peff.net>

On Fri, Oct 11, 2024 at 03:54:51AM -0400, Jeff King wrote:

> [1] I wish we had good names to distinguish the various cases, because
>     the term "reuse" is kind of overloaded. The "slower" regular
>     object-sending path may still reuse verbatim bytes found in an
>     on-disk path. But this "blit out matching parts of a pack without
>     otherwise considering the objects" feature happens outside of that.
>     We called it "pack reuse" back in 2013, but that was not a good name
>     even then. I don't have a good suggestion, though.

Actually, confusing things more, there are really _three_ layers of
reuse:

  1. At the beginning of a pack, we can blit out the bytes for objects
     starting from the beginning of the pack that are being sent (we
     know any delta will be satisfied since its base comes before it).

  2. After that, we process objects one by one, but do so very cheaply
     by just deciding if we can blit them out one by one, fixing up
     delta base offsets to account for gaps.

  3. Otherwise, we generate an object_entry struct in packing_data for
     them, try to find new deltas, and so on. We may then reuse the
     on-disk bytes after deciding they're suitable.

We call all of these "reuse", and certainly both (1) and (2) are "pack
reuse", but I think that term is sufficiently vague that it could apply
to (3) as well.

-Peff
