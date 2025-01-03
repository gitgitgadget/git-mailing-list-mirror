Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C4186A
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735936008; cv=none; b=cPl8J/NBH76KYwnwGcH/i7FOJVJpAeQsGuhIsXmuSzWDvi4R7yrk4S6o8DTjHwZgSOjdLlk+2lwkEZ2hRifbZVu5Ey+0Uu8iv7bR2dMJeg9i8BpP8GqrldhcLF9jNhqoRGFFTBwMTA5BvgtTVhEiirgGPtTivCrbZUsuimRCmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735936008; c=relaxed/simple;
	bh=IJ+EHOorWobI96AcIk9wxSUHQJaywl162izvwDlS454=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6dgsSxG1ggigGaXP2gEt2LkEOs+3HEaoGtW4z8vVvd/UXHTDfLdE48QTiB5sFA9W4x5ShSGjlqQbFscLP50w0MEqsnS7UWbB7w7nP3YvFnZVUrFYazAr3Ria7w+PKGhbUxP9ntmSNq3jhci0SGcSbOo6LOsaPxLhm5kKR3fkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BjT4PeVJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BjT4PeVJ"
Received: (qmail 19061 invoked by uid 109); 3 Jan 2025 20:26:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IJ+EHOorWobI96AcIk9wxSUHQJaywl162izvwDlS454=; b=BjT4PeVJLnFM8I6purtS52il3se2Fps2QZuaKvhpFJ5DoPH+d2K9e81z1JeuLjREJ7xgKLo2QEx6Ya7xsUDMLu+RgRw4qF3KYdOQe2eL3WqhF0C3ZesLDtsg399lhjVnB2ppOzK1v/MMo3i3/PSDkpHkiMcn2Ez/sl92FDEJ4vVZf3tSDpOgoPgXUU7Hs6f+mTZenUeNoZ0UjjKO5GorTHKD6YF5WkwtjuzvMX6cfDH+r3oYcu9LkCrKj+sOLnMnL5TOVqbCwrK+mSRDwihiTV9ivWRuvvYPuHRNEgnU81N9aJDP5/2BSqqofSt0+/qoJcoFA3OHlkQbBakwCm+Jfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 20:26:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4909 invoked by uid 111); 3 Jan 2025 20:26:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 15:26:45 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 15:26:45 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] test-lib: ignore leaks in the sanitizer's thread code
Message-ID: <20250103202645.GD3212696@coredump.intra.peff.net>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101202124.GF3305462@coredump.intra.peff.net>
 <Z3fSnK21nRBrjyfM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3fSnK21nRBrjyfM@pks.im>

On Fri, Jan 03, 2025 at 01:05:48PM +0100, Patrick Steinhardt wrote:

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index c9487d0805..d1f62adbf8 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1177,7 +1177,8 @@ check_test_results_san_file_empty_ () {
> >  	! find "$TEST_RESULTS_SAN_DIR" \
> >  		-type f \
> >  		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
> > -	xargs grep -q ^DEDUP_TOKEN
> > +	xargs grep ^DEDUP_TOKEN |
> > +	grep -qv sanitizer::GetThreadStackTopAndBottom
> >  }
> 
> It would be nice to provide some more context here in the form of a
> comment so that one doesn't have to blame the commit.

We can add that on top, but I'm not sure what it should say. Do you want
something along the lines of "add false positives to ignore here..." or
are an explanation of why we are ignoring this particular false
positive?

-Peff
