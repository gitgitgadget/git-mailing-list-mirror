Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48B32B13A
	for <git@vger.kernel.org>; Fri, 29 May 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043620; cv=none; b=unOGSkrCUasgTC+kk7kbwk0UhM1EJEr4YcqQcCWNkXhySdGQSj88OJ5vAAa1UQpbHsJlC5lPIRnE0//wg+NN2YbdzrCUB+Oi4U8FUgYa0/4KJ0djYrqbsxKe39ewNS+5xoCaOz9o1ivBVraMWredyP+iaNad8Im7huRd+t7sduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043620; c=relaxed/simple;
	bh=H9XPf3FHAQWigMzbPj5VlN9XAO2tq//U7kT3/RBydGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs5FMDQjQkBta58Y+Yh9bap8cTCPGmu1ez7kCOmENo3SfaPDAAspzCKRTB5bnY+5B20Js1YpiWEGARXHHpvcbeTWjE+73382bV475mvYcxZP48y4I2hGtqgx2eOLS1OHV5+QWznT+X5vqr5IzV7Dx8zIN5h/tMA6/GuTcrZ8Wf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UP3yTqwh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UP3yTqwh"
Received: (qmail 5784 invoked by uid 106); 29 May 2026 08:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=H9XPf3FHAQWigMzbPj5VlN9XAO2tq//U7kT3/RBydGc=; b=UP3yTqwhsXFLAy3bwHozYNPk74tTsAPGoV7c0UFKR/XhNaePvNFuvjRL3S+UIt5O05gG2BI6V53ldx1C7LZe6bm8ld4ohK+uMee1OfgQ85eL38/VHAxrewibXf4iYsx4zsx7V7GM98/77MHGu9y8+gOKNhf891eWFZqryqdD/fGg31GrN2jdXk8e4j+PdHxstyfR2LVr2PTSl9rORTPGVjXkXOH6gfwhTo+E614Tyin8zYN6sZJNJsy+REIFonPozyvmvELmmPtXgiNN0c1QCCz0drvszn/25JOPFiksqMYX8ZV+REu9KunOd5BsGoW8UKzqoQ83nu8wrkjHZPv5Iw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 08:33:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9136 invoked by uid 111); 29 May 2026 08:33:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 04:33:42 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 04:33:37 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 8/8] pack-bitmap: build pseudo-merge bitmaps after
 regular bitmaps
Message-ID: <20260529083337.GC1106035@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <30ce254312cfee2a2a82f08246c3a2546ae32578.1779207127.git.me@ttaylorr.com>
 <20260527102534.GH981444@coredump.intra.peff.net>
 <ahdE+Je5YK9JoE7B@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahdE+Je5YK9JoE7B@nand.local>

On Wed, May 27, 2026 at 03:24:40PM -0400, Taylor Blau wrote:

> Below are some numbers that give you a sense of how the runtime scales
> with the number of pseudo-merges. I'm relying exclusively on "stable"
> pseudo-merges here since they have more predictable bucketing behavior,
> though note that there isn't an exact way to dial in the number of these
> so-called "stable" pseudo-merge groups. We can only control their *size*
> (in terms of number of parents), so I ran the harness which produced the
> above code with powers of 10 between [10^3, 10^6].
> 
> Results are as follows:
> 
>     +------------+-------+----------+
>     | stableSize | count | time (s) |
>     +------------+-------+----------+
>     |    1000000 |     1 |   34.963 |
>     |     100000 |     3 |   36.954 |
>     |      10000 |    26 |  221.963 |
>     |       1000 |   252 | 2779.373 |
>     +------------+-------+----------+
> 
> Which scales roughly like O(x^1.165) (the best fit function I could find
> was t(n) = 25.18 + 4.386 * n^1.165, where 'n' is the number of
> pseudo-merges, and t(n) is the time it took to generate them).
> 
> So it does grow faster than linearly, but it's not too bad. The jump
> from 26 to 252 pseudo-merges is pretty significant, though, but having
> that many pseudo-merges is probably not something that we would want to
> do in practice.

OK, that matches my intuition. 1.165 is close enough that I can squint
and call it linear. ;) I agree that probably you'd want to target a
dozen or fewer pseudo-merges. In the long run we might be able to
auto-tune this a bit, or at the very least document the tradeoffs and
expectations. But think that can only come after getting some more
real-world experience. For all we know the feature might not help at all
in the real world, since any grouping strategy will be highly dependent
on heuristics about how refs are updated, what queries look like, and so
on.

Not that I'm not optimistic, just that I think it is too soon to try
writing this stuff up.

-Peff
