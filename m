Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41709EEB5
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291110; cv=none; b=KmGip38oTSL+3DdOjs93uy2qZi9cssVlSibf1Xdhh0f0lWMgPBeULM1ruRgApkqUHA9mrwN4fFWuK8/8ncb41CEfSSL5dBdV/rZViYfU0rKS/V/eK08+TG/UGp+e8PngGQi++KkuwjAXO/ZV3Natlz0RieM7jQthc3Nvk2sP5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291110; c=relaxed/simple;
	bh=r/tDUyog3xHq9DNPKYWuJelv95dT88+wbg+Dujfrwu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4GBPcj85eYElIU9PuyG9hJaD0u8SH7Oh0gsRGf/Vk2bMCQB3U4mJYgOegLm12fCcd6GUNEAXZddonWiFsJIpzkQpDcW0eMHK7Dzu0Epu2afBZMq0KdMzeJFkiQeKboHUeGeoX9Sy6zuGH2DIo4t1c1mM81gjp/mfG8GTke0Ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U9SRfRYM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U9SRfRYM"
Received: (qmail 7898 invoked by uid 109); 19 Jan 2025 12:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=r/tDUyog3xHq9DNPKYWuJelv95dT88+wbg+Dujfrwu0=; b=U9SRfRYMeT+RSllbNJU7KZKrk5padt7u2ujDmmy0Yk522Sh4eV/7xotiLogYi00a4fOkwBSTAV0EBp3EQH3YzWuFBipk1E1FaidE8qrl07YSNdopTNhwY8V7ExV5RBRmcUp6Fym80EtOldDis7ZhSjA1zVGx0T6MiD+pkxcECob4Q8ipX5Ny7zH92syQSVzhqh54ZHRomj2ckI/sCClCR/zzDyqWG94XZLE0EBkf1z3YhvY3y/wMhcmNjaPRFw/67rfDDXt3HR2vfX+VWb0jG9TqtJ5AKmxtX3oL/nAvGckblw28KJ/YqKx0r7zn+6m8eXoKBS13CQHeqVDloZRkEA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jan 2025 12:51:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32676 invoked by uid 111); 19 Jan 2025 12:51:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jan 2025 07:51:46 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jan 2025 07:51:46 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
Message-ID: <20250119125146.GB1538605@coredump.intra.peff.net>
References: <xmqqwmetgdgm.fsf@gitster.g>
 <20250118131507.GA387197@coredump.intra.peff.net>
 <xmqq34hg3utv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34hg3utv.fsf@gitster.g>

On Sat, Jan 18, 2025 at 09:17:32AM -0800, Junio C Hamano wrote:

> > (I'd also be interested in any comments on the "maybe we should just
> > align these buffers" approach; I'm undecided on it).
> 
> Unless we have the buffer _inside_ the helper function that may
> perform the possibly-unaligned access, I am not sure how it helps.

We sort-of do. The offending code is all static local to
unpack-objects.c, and always operates on the same buffer (directly for
writing, and for reading through the static fill() macro which returns
it directly). And likewise in index-pack.c.

I think these two are oddballs in that they read parts of a pack into a
buffer. Whereas all of the more generic pack code will mmap() it, and
presumably that ends up with suitable alignment. I guess platforms with
NO_MMAP would read into a malloc'd buffer, but that should likewise be
prepared for any alignment. (I suppose another way of achieving
alignment would simply be to turn "buffer" into a pointer and malloc it
at the program start, but that still leaves the need to fix sizeof()
calls).

> I guess that we can align buffers used by two existing callers,
> document that the helper function takes an aligned buffer and that
> it is a fault of the caller if somebody passes an unaligned buffer,
> but I am not sure if that is where we want to go.

The functions themselves aren't really reusable, so any new code which
wants to do the same thing would end up rewriting it and potentially
creating the same problem. But that's probably an argument for switching
away from the cast and to put/get_be32(). It provides a more obviously
better example for people to copy from.

I'll post a re-roll in a bit.

-Peff
