Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BF26738B
	for <git@vger.kernel.org>; Tue, 19 May 2026 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151445; cv=none; b=rX6AL2El8vdunGyL0mKC6FL347xpq3hHNJrhGsvvxPkv4VqavWowx/r508qWKP9Q8eyTImGZWkV8FVk809YpnrRnEYdXfQ3b/hp62M5kgDnADavhGJz0CLl69xgy6Qy1NoPSxwrlVER9Hjh9UqiuZXH0NFgiSxK3GDEpEXnQ5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151445; c=relaxed/simple;
	bh=TNnniUJ2m9+N+UyV6pyb/aV/Jd95SWGJ/gSm+UhKYaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh37/SOxVly4J+JXcQU/ieH0X1oE6kSN55WaZtelgjpyBfYG6LiCHqa44hsNTPDVDECSxt4elK2SOFxAzIRo9cgzaKnuC6qPawkh2Azecb75J8QWad+2fRmgBAe58M9GaKaW/VjmeGESZta3qnzAPab3WLxAZpFxinX1CETLY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C58p/2hI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C58p/2hI"
Received: (qmail 15627 invoked by uid 106); 19 May 2026 00:44:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=TNnniUJ2m9+N+UyV6pyb/aV/Jd95SWGJ/gSm+UhKYaI=; b=C58p/2hIUnSxqyekY4Y8EtvsAwJXaBXuC05kvKzZ03yYFlcXTceEJe7l/3+f1HyNZnC5tLPE9FiB+CEi5SVZofbHtv5V7xR/zZgNms98EUbnJzHn5HsjzzLpX3yZAzjh9EJnlYM9f+s2U+oZhS8Y8q6OEk8CxWgWeL+BOXvGO1p7i2Hk3Yr/2YxN/WNjtvp0zF2nqkrgjPEwmBfMzDOAg6QiXeLUfcQK44V3iXRyLHeKUadOIOwcjN9cYJKF+6UXKVW4UoX9rskwkQTBIHGtNhelaBWdrcF8EO8eOuxsuIRTuH8QHo+D3qAfYzj576eH0807SFH3lkXJWL3/YQY9VA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 00:44:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38254 invoked by uid 111); 19 May 2026 00:44:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 20:44:05 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 20:44:01 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] use __builtin_add_overflow() in st_add() with
 Clang
Message-ID: <20260519004401.GB1612961@coredump.intra.peff.net>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <20260518202502.25682-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518202502.25682-1-l.s.r@web.de>

On Mon, May 18, 2026 at 10:25:00PM +0200, René Scharfe wrote:

> Changes since v2:
> - Pass variable instead of st_add3() expression to ALLOC_GROW.
> - Add the helper st_add_overflow() that mimics __builtin_add_overflow()
>   for size_t to avoid duplicating most of the definition of st_add().
> 
>   strbuf: use st_add3() in strbuf_grow()
>   use __builtin_add_overflow() in st_add() with Clang

Thanks, this seems reasonable to me. The type-generic version of
builtin_add_overflow() is much harder, but doing it just for st_add() is
enough for our purposes here.

-Peff
