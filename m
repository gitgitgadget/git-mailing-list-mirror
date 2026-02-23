Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF03644D3
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851527; cv=none; b=iAoSP86NYaxE8qAW37TlmU6t5eXZHosATaDiHej2kn8OHtcspLRRHvDddF+1rkj7CFmuJnq15Ai6OUYjiJwz1dV2E9ZDPSh/7ibGl3MwInWEMgewWnRJlADNNXu/bfq2g7yX6LreD+y0Ku9iLJJk6WZsh0Zyg6h0IbhG1WJjKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851527; c=relaxed/simple;
	bh=fYn9IDpQ6IE73KzAowrKuHcKYHNg9p+zI6MLduqJBbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT2/WGnD2ePmV/z4+6eMb0fj8f46D5gynfGfca9NbYQDDJUJpqNhm0sIhl5XRKlKUx0tMOG8gNp4Q5Q0KuySkqOa28S/5vvjmuYiqdbVXOYPquBDCJ73bVStpoCKDO3ISqp6DbQqG6fcE1+ywGpfjHTPIxkQp3oD5t3w+BW0acU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CYRfLBFb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CYRfLBFb"
Received: (qmail 54035 invoked by uid 109); 23 Feb 2026 12:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fYn9IDpQ6IE73KzAowrKuHcKYHNg9p+zI6MLduqJBbE=; b=CYRfLBFbuxe6h6GwYNuOAzsSf8/Y7eAWpsMd3T9Ix6xfB+9tNYXmN6M2Hyr7gH+LcqxDSmCKraK2qajTI3Z1QyS5sAgbPV5JEr/Xp6Le2aAmyX775cjkF6Uz/XT4UE8AtLG0yjTSnz1N46BLaZ84RFTRZ8RFVU1LHI+ppy+BXVZVBHpJ5zcRRGQ3tGKCeNrykKNLoDAuVmgkJNU7TJqWD/zC+6IG17xv61Z59pVj6QIgkRkD57h7MeFH4vUEQj2IIAkAsNCJwsjk7iqSYTpxjhjqESSb/7i6B8tskcepATfxopjmfWBGgk1ermdlzW59bgnN5rhWXN61mlMwzaFm6g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 12:58:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 104146 invoked by uid 111); 23 Feb 2026 12:58:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 07:58:44 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 07:58:43 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pack-check: fix verification of large objects
Message-ID: <20260223125843.GA215671@coredump.intra.peff.net>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im>
 <20260223111120.GC215364@coredump.intra.peff.net>
 <aZw6W_BHoYiC9RYl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZw6W_BHoYiC9RYl@pks.im>

On Mon, Feb 23, 2026 at 12:30:35PM +0100, Patrick Steinhardt wrote:

> > A more concrete test would probably be something like:
> > 
> >    1. Two packs, $X and $Y, both contain the same object.
> > 
> >    2. The object is corrupt in $X but not in $Y.
> > 
> >    3. Running fsck detects that one copy is corrupt but the other is
> >       not.
> > 
> > Right now it may or may not fail depending on the ordering of the packs
> > in the MRU list (which we might be able to tweak via mtimes). But
> > hopefully in the "after" state it should deterministically complain
> > about $X.
> 
> Yeah. The problem I had here is that I'm not sure whether we have any
> tools to reliably create a corrupted object, e.g. with a hash mismatch.
> I'll have a look for v2.

You can see how do_corrupt_object() in t5303 does it. It's basically
finding an offset via show-index and then writing a zero over it with
dd.

-Peff
