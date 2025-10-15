Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133D3074A2
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524344; cv=none; b=X38sHy+hqF7uDae6c280ESPD9n5x2RtGY9On8Ivi+kWoznqD5pkut2fdYObC3EzBX/eniqhepO7MKqtEvCVUkyFNeGWgPmZOoxJQvRtL8E1d8GJlBp1iirmSWNcEdyUem+LkrwnqP2sLQhfeBKRIkymxSmUZ+a3WkMmnKoCxXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524344; c=relaxed/simple;
	bh=ri96r/ZrDjJJhwLOw7+eZfUqKnyprZro0akCFVycW4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XE9L2/CGbs4TX+/vScEghwYV3Uk1CBI8zcer7QqelJk/d5rg+JIj9fouR1+bglSwxf3aaXpht5UvlEByl7g3ZxjE0Px7kk/7WQOvK0KMger/OAnuYZd4Xd7DR+fUD00YQ3SAK2KIm5NNnsp5zKgzLfdMavD+1Lz59DLWlIMl/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aIki/tLl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aIki/tLl"
Received: (qmail 226780 invoked by uid 109); 15 Oct 2025 10:32:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ri96r/ZrDjJJhwLOw7+eZfUqKnyprZro0akCFVycW4o=; b=aIki/tLlO++0W+bXe4zX2d3Pj9seki9HSLXJ5EjSDNlCnpoUst6ViEUSWihtwmZkaR83miuU0WnLAGepOOZtfDwXcm+kOGkUW3GcYPrFrO8jP9ZJN79zDnf/T2t270u3XNhrAg9pzjHjHPvdS5QT/tMp2c6De6j1wBpgcoiuZN6xZwBA/T3d/uetz499oR48GdrqpMoWHU3Qk2Mcwf0SKIvs1LRmsidItEyXuhbNpQlFgvYXD+z+8bxmVIKuch5GaXAMb0/cMTFAaCGrK4Mf7rlwObsFWXu5q5mWhaWDGuqOg4jjNr3+apGaKr4S4DqLOop75bHPlhuj/33Mj+toyg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Oct 2025 10:32:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 363003 invoked by uid 111); 15 Oct 2025 10:32:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Oct 2025 06:32:20 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Oct 2025 06:32:20 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 42/49] repack: move `find_pack_prefix()` out of the
 builtin
Message-ID: <20251015103220.GD2250228@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <c50ffce0781d0fbb24eb72f437dab257694a6b99.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c50ffce0781d0fbb24eb72f437dab257694a6b99.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:10:02PM -0400, Taylor Blau wrote:

> Both callers within the repack builtin which call functions that take a
> 'write_pack_opts' structure have the following pattern:
> 
>     struct write_pack_opts opts = {
>         .packdir = packdir,
>         .packtmp = packtmp,
>         .pack_prefix = find_pack_prefix(packdir, packtmp),
>         /* ... */
>     };
>     int ret = write_some_kind_of_pack(&opts, /* ... */);
> 
> , but both "packdir" and "packtmp" are fields within the write_pack_opts
> struct itself!
> 
> Instead of also computing the pack_prefix ahead of time, let's have the
> callees compute it themselves by moving `find_pack_prefix()` out of the
> repack builtin, and have it take a write_pack_opts pointer instead of
> the "packdir" and "packtmp" fields directly.

Oh. You'd really think by now that I'd have learned to read ahead in the
series before commenting.

So you can ignore my responses to the previous two patches. This does
what I propose, plus takes it further by using the opts struct itself.

-Peff
