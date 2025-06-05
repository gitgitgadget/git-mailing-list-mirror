Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F653C2F
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108308; cv=none; b=I934ag7t+yX757pzUQOy3sEVh7uZxqgn2Ce9K8bDaix7FcvkeTvcOxacKWlCVkoT0jO5iUqDQeCEtdFLfOBad/3zzJcmN7pvx5IcchRSS2qpa576BBya1ROhK55eUAoVxJSiCZ5NXdk+xXE65yX7Ysic3+HmTciKJ9oNgSkT9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108308; c=relaxed/simple;
	bh=KQ9ItMm0C27Loj+2IaWuiN2BVsddG0xtwCU225hFV9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4mFF1TFmjc2aJwEHUEOyvPfkTelfIiwZ4ZcmEfQhYbu6sjbuAbUJZ3OGPiOO7TC59uqwEKhcyykfZkLCgKgPCSnPD1N3Prgq2a0e6bUUYs+kd+wLPYmRViL8fFUEu0UsA93LDwPJcDiiv4kJkHzgK0phbQ94/kCspCxumJhKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JrfmyoWH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JrfmyoWH"
Received: (qmail 17280 invoked by uid 109); 5 Jun 2025 07:25:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KQ9ItMm0C27Loj+2IaWuiN2BVsddG0xtwCU225hFV9c=; b=JrfmyoWHrmR0I70C6oXMWCdea0Eq3uZ4/ilPR9g6jogSWwZm0fEXi0iDARfB7RmorgSpccGL3xDIFchjx5Vem72wvNd6glupj8syXwsDqqsQTkje+WWwD00EKOyvB3D+woOKufFPAdAfxsEAazPXS+TtcXWAod326cR7j6clXOVA4DI+DC9MTlUhTXwyrHBPhrSaXk1ezx9YNdz0ZjD1pqnql8NKUaJEDFPQ0okBBLybPut3dEXgCbRiCCLRZ1PmRD/wQkICkGx4Ce9cwVlN1es8ZQMLKTispkm9rbUdkMUwPxs6hjZ6zBl38pYm+vgKmV189UIzqTRUOzVJ2gtxJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 07:25:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21138 invoked by uid 111); 5 Jun 2025 07:25:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 03:25:09 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 03:25:04 -0400
From: Jeff King <peff@peff.net>
To: Daniel Stenberg <daniel@haxx.se>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] curl: fix symbolic constant typechecks with
 curl_easy_setopt()
Message-ID: <20250605072504.GB2066712@coredump.intra.peff.net>
References: <20250604205505.GA1510724@coredump.intra.peff.net>
 <20250604205622.GC1510819@coredump.intra.peff.net>
 <r1197994-o3so-6453-q16n-6n3on33n4nrp@unkk.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <r1197994-o3so-6453-q16n-6n3on33n4nrp@unkk.fr>

On Thu, Jun 05, 2025 at 08:13:09AM +0200, Daniel Stenberg wrote:

> On Wed, 4 Jun 2025, Jeff King wrote:
> 
> > It seems kind of weird to me that curl doesn't define these constants as
> > longs, since the point of them is to pass to curl_easy_setopt().
> 
> Agreed. Mostly just because of my lack of imagination when I added them a
> long time ago.

Oh, OK. :)

> We have over recent times updated several public option related defines to
> better help applications to get int vs long right, but I have clearly missed
> to do that for this particular set.
> 
> I intend to fix this omission, but since you want to support building with
> lots of old curl versions as well, this correction probably won't help you
> for another decade or so... :-)

Sounds like a good plan. But yeah, we'll want to continue with the casts
here for a while.

-Peff
