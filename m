Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9645EEB5
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291330; cv=none; b=W0v7LRSRlFxj9YFx6TF6iPY4WmL0o14gVS0SihD310YewR5wEtv6YzMzGqfqai2913ljAtfgscxLpcFDgoU/xrIVMvu3Cxta3GS370z4qpCU6lb2+2PxmBdzdekE3Uc9k1O2lHiuroc/swa2UB0CyMCmRxoa9m8XTHW9DCO1jZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291330; c=relaxed/simple;
	bh=R1fAjwkZkgtgMMJwH8apJJVXkdMddRcwE8zep7/lO1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyshqELAJRDDxsgG8aH+nKPT/yhLslSLHU5hPd/5/GhQrclS3/Igk9SktGs3mYOmDD+Wu7hddyx2gdTGTuu75wpavEcSAEXeGrqdaqlOu+STMxuGfMxXcO28+s7efzJbADr9A3GAJZiBcb1go414ze+OA/0wXljrUEFGZ/1PoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XsKEJML7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XsKEJML7"
Received: (qmail 7910 invoked by uid 109); 19 Jan 2025 12:55:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=R1fAjwkZkgtgMMJwH8apJJVXkdMddRcwE8zep7/lO1A=; b=XsKEJML7ih1JW9HS9U7S9G5IvqPJ9W9Cv+nPNYpwM8txFyZ3D49cwPohJtaq/5X9Qmt8KvoWrlTQpcCi0ybrFA6k1vyWyD+vggza46d/TmvJ5kQRFHzKCUJm20Lifix7Zi591yVLZmODKLCD3A9rwEvkeV4aU+ybaP8jU+QQUDAql14KYI+9iMR4LpbXJvztInhDT4iw0FVnFkoKsPtt4bAThiIdiB+sFht8w2Z+nhwyNIr/u4MzPqHpt5wK1lGE9J9/6S2Mv9NGjskAYGTLL2H/6CS9307FzwMXqA8zMafJ+FVG4OuOEEahOgO1XlMv24Nwbvg+QHx/bGdJsJEFUg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jan 2025 12:55:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 457 invoked by uid 111); 19 Jan 2025 12:55:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jan 2025 07:55:27 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jan 2025 07:55:26 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
Message-ID: <20250119125526.GA1540196@coredump.intra.peff.net>
References: <xmqqwmetgdgm.fsf@gitster.g>
 <20250118131507.GA387197@coredump.intra.peff.net>
 <xmqq34hg3utv.fsf@gitster.g>
 <20250119125146.GB1538605@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250119125146.GB1538605@coredump.intra.peff.net>

On Sun, Jan 19, 2025 at 07:51:46AM -0500, Jeff King wrote:

> > Unless we have the buffer _inside_ the helper function that may
> > perform the possibly-unaligned access, I am not sure how it helps.
> 
> We sort-of do. The offending code is all static local to
> unpack-objects.c, and always operates on the same buffer (directly for
> writing, and for reading through the static fill() macro which returns
> it directly). And likewise in index-pack.c.

Oh, reading this again, I guess you were thinking of the helper that I
had factored out. Yes, if that requires aligned memory that is an awful
interface. :-/

I was thinking to just leave the offending code untouched in the
individual commands if we went this route.

But anyway, I'll prepare a version going the other get_be32() direction.

-Peff
