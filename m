Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF22EB1F
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426045; cv=none; b=P+OfNkp2/7TCFkcwkt+nf6anaKjgnc0vISw0p7tvb8S739g90C2JAo1G63yJBbKvybd37omnaHXKFubsszFPNtulfPfeQ+aSUPHwnXb2TVUbtt6Te+ev9/8wO4Pb0XYaIIKxib1p27PRWvAKHTmiBhpGd5zkLk+0CkBQo81RX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426045; c=relaxed/simple;
	bh=RvjkMSsoRFwUVNOPKvDhp4/mslbJVIkxQI1VGNaF/7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVoS4U2uvCfCGg4D5PTkJROwjVIlnLN/IUiyWY3jlfL515IUqHAqKd6q9vtTwIfR9xdy7AZox7eLzIrQLsebXtQ+YLidiTWbxPWl7VKGw6kgHvGMyFcQ22YElZvD3YKmk0f7b049xBcEiz9lHrLsEzVwlUmhHbV9YFOMpKXcdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F155osxO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F155osxO"
Received: (qmail 31226 invoked by uid 109); 5 Dec 2024 19:14:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RvjkMSsoRFwUVNOPKvDhp4/mslbJVIkxQI1VGNaF/7U=; b=F155osxON++998Pj0xgJtIiWyVtjkgw0bEmnfX395kLwidoea7K1CjIJClvNuCIhBCvBgGrvmOaopSFCzgRg4fBnkAunf7QPyyvzo0LDXEwmPUfKyacN3DahazUM+Eqb4/t8QwZ441KRDJajSsFt3GT9BS00NHvKM4lwTz04jb95dsUE/pnF6mGNougZ6fdJ/Z/HtqgCBW5S0MBlX1dPdG8HQ9ube7OB0selRLq65asoRq4kEeWo4XTEScEHsR3EfqQUXK1Lnw+GhHg0u7wkjVFnWeKdVngdf20CKyfahLWrPbdfn/Tiwtd0tycM5OjD/+Y0rAp4oLrG1Eu5qqW4Iw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 19:14:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8999 invoked by uid 111); 5 Dec 2024 19:14:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 14:14:02 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 14:14:01 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/10] daemon: fix loops that have mismatching integer
 types
Message-ID: <20241205191401.GB2629822@coredump.intra.peff.net>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-9-fc406b984bc9@pks.im>
 <20241201220802.GF145938@coredump.intra.peff.net>
 <Z01nm6C5FEdy2nEW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z01nm6C5FEdy2nEW@pks.im>

On Mon, Dec 02, 2024 at 08:54:03AM +0100, Patrick Steinhardt wrote:

> > > @@ -503,8 +503,7 @@ static struct daemon_service daemon_service[] = {
> > >  
> > >  static void enable_service(const char *name, int ena)
> > >  {
> > > -	int i;
> > > -	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
> > > +	for (size_t i = 0; i < ARRAY_SIZE(daemon_service); i++) {
> > >  		if (!strcmp(daemon_service[i].name, name)) {
> > >  			daemon_service[i].enabled = ena;
> > >  			return;
> > 
> > look exactly the same as the ones fixed in the previous patch. Is there
> > a reason I'm missing that these are split out?
> 
> Yeah, they do. I decided to not touch places in the trivial conversion
> where we couldn't also remove the macro in the same step due to warnings
> that require a bit more though to fix.

Ah, that makes complete sense.

-Peff
