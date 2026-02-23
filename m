Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759481E49F
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855731; cv=none; b=B3jywAZ5jSf8RNwVk2K9SKVWg2KdE3nlplEVxRiYxBtYH1zUEzdIsZ+Yl9jRyvwCBHNy8tcFyO3sDBf6hzddYHQ5302vlH4gqONgPW8PHTvLLOWjyFCuf/xw65D4teL/8LPSIUWGkVHOUGstECKVlgpTqX4vLOeh/f73HudKecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855731; c=relaxed/simple;
	bh=4DYaHNd7Pp/WFPsLOjkWvu5Boe/l6SzVPEkH9UO6S0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd00H69xxmDu3I6aiM1kLCV6N8Zi8zBDIWwG/FBpt/6ydWFbYbkWdAx2ySFbnePd38SKsrFVx5DbDkjhjBONblTyt4XajPkCukLHE7Mibdhd0/GQgC/DCdMVZlk4E9cUrlEV8GljDwxgVChq59yz66m4vivXgSM7zyxD7cqx1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FFqPmeNl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FFqPmeNl"
Received: (qmail 55279 invoked by uid 109); 23 Feb 2026 14:08:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4DYaHNd7Pp/WFPsLOjkWvu5Boe/l6SzVPEkH9UO6S0I=; b=FFqPmeNlHsFnOW4PcSAPmi2bS7IgGgCVGqIUhondQzn4akVfI1t7Va5u4g1VXuZxeihW6JvxDL6LYxHwhIkOhJjBzWvYVlw33+o7dvfz5Pd0nxxQlvyb4GiMYKAr0bE6MpnIVwwmQchpAq9IUNfAV57er6ftRYpNH2G7XIlup+JzPQWnvSMowIkjAoRxdp2RvheqkRXRbomiZhVFrpvbe3fVjcmWCRl5/RkD4LOQ8kU1+1eRPRp+Gn25fU4og1ZaO8/ncPHBkvl+vXAPETvj4NXBRKL3/rruAMz39v93wT2fgQ4pZqHJ4YfGfOrN4Dc+my2WxoBRhgQhNeMhK2pKLw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 14:08:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 106409 invoked by uid 111); 23 Feb 2026 14:08:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 09:08:48 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 09:08:47 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/18] midx: incremental MIDX/bitmap layer compaction
Message-ID: <20260223140847.GB271392@coredump.intra.peff.net>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <xmqqbjhjvysm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjhjvysm.fsf@gitster.g>

On Fri, Feb 20, 2026 at 02:24:25PM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > [Note to the maintainer: this is based on 'master' with my
> > 'tb/midx-write-corrupt-checksum-fix' merged in and should produce zero
> > conflicts when applied on top.]
> >
> > This is a reroll of my series to implement MIDX layer compaction
> > adjusted in response to reviewer feedback.
> 
> Haven't seen a lot happen since the end of last month or so.
> Anything left to do here?

Sorry, I promised Taylor I would review it and I have been dragging my
feet.

I just read through the whole series, and didn't find anything that
hadn't already been brought up. The scariest / most complicated bits
are:

  1. Dropping the sort-order requirement for midx pack lists in patch
     10. But I think the approach with the version bump is the maximally
     conservative one, and I feel good about that. IIRC we discussed
     previously the possibility of using new chunks to give the
     alternate ordering, but I think this keeps the complexity in the
     code to a minimum.

  2. The actual compaction bits in the final two patches. I didn't see
     anything wrong here, but this is exactly the kind of spot where I
     think review fails, because you don't realize the corner case that
     you missed (speaking from experience with midx and bitmap code).
     But the nice thing here is that it should be quite unlikely to
     cause a regression if you're not using compaction. As this is
     mostly a building block for "part 3" that starts doing compaction
     as part of a broader repacking strategy, I think it is OK to
     consider it somewhat-experimental, build the next layer, and then
     eventually let it see more exercise in a production environment.

     That's how we've traditionally found those corner cases, and I
     think trying to spend more time staring at it in review is not
     likely to produce more insights.

There were a couple minor issues brought up in review, like out-dated
comments and the u32_add interface. So I think we might need a v3 with a
few touch-ups, but that's it.

-Peff
