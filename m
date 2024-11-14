Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D3257D
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543908; cv=none; b=JwUpVMtUqGGPufWSX03abqeQZHXnOGr/41UN3l7uPHOGVvyc7TwI9bnWoJXaOxVNdBDC0Ap1InuZgdA7v/wmd9BlsCVls50CGzgmM71hiLmbqtq+ZW9rd6d6ZrPtYFYcCzv9GldZ1tLeRWb7Z50QD1j1g7JhTKslOYW9yZ9WiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543908; c=relaxed/simple;
	bh=M5jtp+OHabQVACo+5YUq7nSqBU6rocZzOvwlo8fqXnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnwK1dgEhw9/BH2Wwg53AWzTss7/XUinLKPqoVy+xKwm5TRpO1Hnz0gWRvzsfbj7WonqNN6YYBE+t9SrLpz5X0254JTXyphLkGO3pXPKd4J4P3Gp1bfC2LZtg7Bb9IzbeTA07EMu1EQrknaOEXn1UhpGPs8SznsziWCi9HWA9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VhCM/QYf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VhCM/QYf"
Received: (qmail 26060 invoked by uid 109); 14 Nov 2024 00:25:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=M5jtp+OHabQVACo+5YUq7nSqBU6rocZzOvwlo8fqXnI=; b=VhCM/QYfxBqCCvbBIZd8C4qJQ9izzGCqD+13w73UD4Oz+WeADbzxg5FmTCJe1C+SSqUwMKxzw+Z24hkh8YLBeedSudR1lHNLq9gcMi46mMzKmz8WxvLTnX+Fn16R1r2/lTLSrf/nFfhQI8QEmucyALQzBy6E5RUQ39amXQQWCy4hZy6ljghe9jYDvJt1SdbUYAHkp0FuRo9T8Lws9T5Xo+iCKu3sanmKmuEVO7ymyXLm/6TgLCp7QUsNhN8OL6/7laKdWo72Rn13P8bXLVHjtLM2ZQ0HnaQJbLoLu/RHnh/lptT6awk0W4+JgnFmH7NHAKAMI0ZfgdMDS095YTun2Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Nov 2024 00:25:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19473 invoked by uid 111); 14 Nov 2024 00:25:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2024 19:25:07 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Nov 2024 19:25:04 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: only perform verbatim reuse on the
 preferred pack
Message-ID: <20241114002504.GB1140565@coredump.intra.peff.net>
References: <cover.1731518931.git.me@ttaylorr.com>
 <2520abf24a8a194b3f7040e218f878dc88a740a0.1731518931.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2520abf24a8a194b3f7040e218f878dc88a740a0.1731518931.git.me@ttaylorr.com>

On Wed, Nov 13, 2024 at 12:32:58PM -0500, Taylor Blau wrote:

> Instead, we can only safely perform the whole-word reuse optimization on
> the preferred pack, where we know with certainty that no gaps exist in
> that region of the bitmap. We can still reuse objects from non-preferred
> packs, but we have to inspect them individually in write_reused_pack()
> to ensure that any gaps that may exist are accounted for.

Yep. With the disclaimer that I'm biased because I helped a little with
debugging, this change is obviously correct. Forgetting the bug you saw
in the real world, we know this function cannot work as-is because of
the potential for those gaps.

> This allows us to simplify the implementation of
> write_reused_pack_verbatim() back to almost its pre-multi-pack reuse
> form, since we can now assume that the beginning of the pack appears at
> the beginning of the bitmap, meaning that we don't have to account for
> any bits up to the first word boundary (like we had to special case in
> ca0fd69e37).
> 
> The only significant changes from the pre-ca0fd69e37 implementation are:
> [...]

Thanks for this section. My first instinct was to go back and look at
the diff to the pre-midx version of the function, and this nicely
explains the hunks I see there.

So this patch looks good to me. I was able to follow your explanation in
the commit message, but that may not count for much since I'm probably
the only other person with deep knowledge of the verbatim-reuse code in
the first place. ;)

I do think the explanation in the message of the first commit would be a
lot simpler if it were simply combined into this patch. With them split
you effectively have to explain the problem twice. I don't feel that
strongly about changing it, though.

-Peff
