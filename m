Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F55126C05
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182108; cv=none; b=GviLvMsDXESj0uxKAoF/UFhkgRhaEwhh15PlbpBTZAAK/JJSLFxi0n3MXMGTXYR8vvjRWhnKxGxdBAWY5cia30RekPX1qRD72OPecXRGkbUWqwK24N2/MbBgqxKEkCWD53osOitVSH7dAB9GecThOlXVQ28fVpbnbeI+8mUNgwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182108; c=relaxed/simple;
	bh=3KY9obgBZ3550nAHYLiDXMbrXUxamn16NDi99ZJB7G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDMZaLdQhZ/jk61rujUJfM1zsJuyCkRQeSqK/2wZyHKeaeXVXMZUg9jAOeOgJBSDCTKtsq3a6l5pkjkeOlUabTMzA10G8j0z/RaRIJYD5kFcuRNofH+LbZDvTxdypvp9oWOV9t5uG5HoxH7p2ji6CDTuHbQxYUiqIH4FtjWalRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q8twI3oT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q8twI3oT"
Received: (qmail 30523 invoked by uid 109); 21 Nov 2024 09:41:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3KY9obgBZ3550nAHYLiDXMbrXUxamn16NDi99ZJB7G4=; b=Q8twI3oTfiLXZN61y1O2MzrtqhsajGzGHBX1QMPKNpkXt/agyIwiEVHdrOSGlPDmxg15JFJrzpwaLJZjaaSH+8RlMhmerPNhxVKmchZJajbDM7ZpYY1YzHdDoz+/WWpgImfdyCZhEvtpoeMi0jor3y7iXzphW+wFeHc6jYSuPeS0lDrulZcmMuuQnjYxSoazXPpV6CO2xlpSbpBoeJNUpzTPe0ySoMTLs4kRW7vR1x6kOPEezBKklm+hpfmV8ToNn2yNFn8HPSENhm+A8UOC8uUMLInuVQ+xzu0KoqpxBMLYhyKAlWcWKhNsKmMKz8CoWUyr2YG8TzC+HZJ6/k201g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Nov 2024 09:41:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22755 invoked by uid 111); 21 Nov 2024 09:41:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2024 04:41:49 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Nov 2024 04:41:44 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 6/6] hash.h: drop unsafe_ function variants
Message-ID: <20241121094144.GE602681@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <4081ad08549895a1b05c45fbc6f229683fec3963.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4081ad08549895a1b05c45fbc6f229683fec3963.1732130001.git.me@ttaylorr.com>

On Wed, Nov 20, 2024 at 02:13:59PM -0500, Taylor Blau wrote:

> Now that all callers have been converted from:
> 
>     the_hash_algo->unsafe_init_fn();
> 
> to
> 
>     unsafe_hash_algo(the_hash_algo)->unsafe_init_fn();
> 
> and similar, we can remove the scaffolding for the unsafe_ function
> variants and force callers to use the new unsafe_hash_algo() mechanic
> instead.

Nice. Especially for sha256, which does not even need to care about this
unsafe thing at all (so in 2099, when we finally remove sha1 support,
this whole system can go away!).

I think this also opens up alternatives for how we conditionally compile
things. E.g., if you have no *_SHA1_UNSAFE macro defined, we could avoid
defining sha1_unsafe_algo at all, and just leave it as NULL. I can't
think of a significant enough advantage to merit the work in converting
to that, though, so it's probably not worth doing unless we later decide
it would make things simpler for some reason.

-Peff
