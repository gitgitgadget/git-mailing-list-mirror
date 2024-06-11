Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1A17623F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097066; cv=none; b=OzyzUeFYfW81yZjc3ZZG3mSKqt2SEFJfRmddcUSS7Zg6ztLAudEAF2a3mUZZwK/zoTKjjymsrk0Hjht+4v3WAV+ajKVhY25wkM8jyJ1bHHHOxTR0soPKBSEv8l9WqCzDkYD2aeQ9Fy2Nzy0+zPodrtswlc1Tao5huT9o4Q3ldzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097066; c=relaxed/simple;
	bh=DPS6+k0XvRc2RHr6CtfXsLrvmgyF6YwuJMpsrIT9mrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5azuwgOBSr+275xVT7YtIALqC6tteeGn6+0wec7Iw8KskT9r4o8FxCRo/tboe5qogp6tYfrT3gTCSSKxfgbY2vFHxfNnvb4+FOC6NAAUhGpQ50S2lqGGu0ifk7DxtMkDkbvfwPnPPY+r4qyuQXcMyLRLcAbNRFeSFz3N0hhCpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18779 invoked by uid 109); 11 Jun 2024 09:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 09:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25077 invoked by uid 111); 11 Jun 2024 09:11:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 05:11:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 05:11:02 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/3] pack-bitmap.c: avoid uninitialized `pack_int_id`
 during reuse
Message-ID: <20240611091102.GL3248245@coredump.intra.peff.net>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <cover.1718050244.git.me@ttaylorr.com>
 <a3c28f12020712818060bd50d1483507c9b11556.1718050244.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3c28f12020712818060bd50d1483507c9b11556.1718050244.git.me@ttaylorr.com>

On Mon, Jun 10, 2024 at 04:10:53PM -0400, Taylor Blau wrote:

> Avoid the uninitialized read by ensuring that the pack_int_id field is
> set in the single-pack reuse case by setting it to either the MIDX
> preferred pack's pack_int_id, or '0', in the case of single-pack
> bitmaps.  In the latter case, we never read the pack_int_id field, so
> the choice of '0' is arbitrary.

Could we set it to some sentinel value for the single-pack case? If we
set it to "-1", then the BUG() added in patch 3 would trigger if we did
accidentally try to feed it to the midx code. Assuming you do not have
2^32-1 packs, of course. ;)

I am OK either way, though. And the rest of the patch looked good.

-Peff
