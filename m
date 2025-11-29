Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87223093BC
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764413431; cv=none; b=G5HjmB4CNWgcbomvoOCfikQHjy30ldoM20lW2e0kdAibsamrTJMG13qAjJ18jNit38Hm5Qrg0mmL19XhVZK5FrYA1eGR2LDckcdM5z9CyH0D/fFLTiO1T/cqy/T/OrQvpc6ZfKUZaQBDc+bxQgvvRTYBGpoX0CoL14g4ex86AfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764413431; c=relaxed/simple;
	bh=FNSnqZG1rCbbh65oDG887UnCP+MdHM/V+KLDNObfiP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djm3k2aGkO/EzHfFIdE3DNHiMIeQGaT/Huef6aetyUmaB+hScEc2RSMt6xRJjVlo9LTJGUPz7EtOoVdU/awrvrRDi/Y+rKyvtPIqOULfHIvYT80e1EOhTWM2C6VjtaTU03JLtjMs1oqhbTjRmHT5WDslySe2tGIYZmGa06Y9MAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IqZ8wUGI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IqZ8wUGI"
Received: (qmail 142928 invoked by uid 109); 29 Nov 2025 10:50:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FNSnqZG1rCbbh65oDG887UnCP+MdHM/V+KLDNObfiP8=; b=IqZ8wUGITdUovATFMB8/LfpwbE2bQvc9sAZ+b0F/Q1jfDkUQyZvJfmP4efcL2nI68/95tuLpilxeQ3I+SZXmybbVvcDAtVAjrtjQaBDDFjKdqYWITWv7qFj24cYmvWQXlsMtb6GWeI7rXrdzadKUxPDeHnUi4trgX5sCsSe3QxFeNdOSWgoG7ZYMc/hq++KxShK6iJrblkefVdWb3u/5PV7Xm/3AQBWYXM6eqT5ffyijqNLw5fToJ4J4m4wFKF3jGA+W294wODApXUy3zMsMu0sc4IimkI332cSjSF+qEbCnaYbZjRZgCUM2PPzQTmBuRaIOaZoR31TXr/GAV7D5dg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 29 Nov 2025 10:50:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 236079 invoked by uid 111); 29 Nov 2025 10:50:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Nov 2025 05:50:29 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 29 Nov 2025 05:50:23 -0500
From: Jeff King <peff@peff.net>
To: Anders Kaseorg <andersk@mit.edu>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
Message-ID: <20251129105023.GA646133@coredump.intra.peff.net>
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
 <20251128205514.GA605489@coredump.intra.peff.net>
 <5699f2cc-5157-441e-af98-4d8df492ec72@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5699f2cc-5157-441e-af98-4d8df492ec72@mit.edu>

On Fri, Nov 28, 2025 at 02:20:22PM -0800, Anders Kaseorg wrote:

> On 11/28/25 12:55, Jeff King wrote:
> > In the same vein, probably using "sizeof(lm->scratch->words)" is better
> > than "sizeof(eword_t)". But again, I find it an unlikely detail for us
> > to catch under the hood.
> 
> As words is a pointer, you must have meant sizeof *lm->scratch->words or
> sizeof lm->scratch->words[0].

Whoops, yes. I prefer sizeof(*var) over sizeof(type) because it tracks
changes to the type of "var" automatically. But the opportunity to
forget the "*" is perhaps a point against it. :)

-Peff
