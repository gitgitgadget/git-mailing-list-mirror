Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402B227EAA
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077758; cv=none; b=DXpmeDsPP7oUczFmZkAXh1wDppofDrM8qXi+uixd+4I/SxyC2KxIHveR/5sGtwzyhKvc62LxBGCR5MiJvrwsU98m5O8BlKP+FUS1JDiKn/8qTR66bonU7KRJg+c1x/QbXqUe6rtR/jb6dsfKJMUPax/58xrOJrgPvPUXKf8pxVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077758; c=relaxed/simple;
	bh=eH4AM1CMo1WasGaXBRoh6BDYx8M9MYCWrFf5duKWdkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgWWZqbkSFPmtUcU2jGzg8RNzNVx1C/cKVHtA4gQ4CZDRRbi4ILaUyZOs3MZC5OhMG+qHiCXvYQHUIpiT7dNzhnQPuv+BFdwGr8az2XQtR0YUP3tERGkGOODc6mQqeWlkO3fwDnFIlCQljHlwvAyYFCpcz4KRhXktW//6zMXp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Rpz0Iefa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Rpz0Iefa"
Received: (qmail 182444 invoked by uid 109); 10 Oct 2025 06:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eH4AM1CMo1WasGaXBRoh6BDYx8M9MYCWrFf5duKWdkY=; b=Rpz0IefapSQCLEmPUdJFopQARgwvje3WbKvt/2pVqV5f0rfEL5lsGsOl0JclqtoZtk6EwtUMnirwlQu/ZGzgYR14100J0EXMaoIu6/6k4IlBx1f4fpno0JEcDfKG6XlLeKGw37kjXol2ToIsl+yfWzeiwczwHR+VDRtmLAJFW1FBvrFn29rXmueiRM3IAbUnvx86sxP3QEQH5dER46MBuVRl7yTYmDpQlB1XrWr0Pw/OuyXw/a6HV7TJJq9BYY4JQTrJgLua4lqn5r4GGtF039697Uox5G2OcFP1eqCWX4L4W8C4avGxc3SuW03xaxq2rlD7XxwN2u0uoC7cDeeRRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 06:29:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283728 invoked by uid 111); 10 Oct 2025 06:29:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 02:29:13 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 02:29:13 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 00/49] repack: prepare for incremental MIDX-based
 repacking
Message-ID: <20251010062913.GJ1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:07:10PM -0400, Taylor Blau wrote:

> This series moves the vast majority of the builtin's functionality into
> several new compilation units, all grouped under a new repack.h API:
> 
>  * repack.c
>  * repack-cruft.c
>  * repack-filtered.c
>  * repack-geometry.c
>  * repack-midx.c
>  * repack-promisor.c

I've read up through patch 37. My eyes were starting to glaze over at
that point, and it looked like the patches were starting to get more
interesting, so I've saved the rest for another session.

From what I read, the changes all look reasonable. I brought up a few
small naming and interface questions, but I don't think there's anything
incorrect here. And there may be diminishing returns in polishing an API
which is realistically only going to be called from one place.

The split you have seems reasonable. It's not quite as clean as one
might hope (e.g., repack's existing_packs gets passed around to some of
the other subsystems). But again, diminishing returns on trying to
untangle it further.

-Peff
