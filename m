Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62872E54C
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808646; cv=none; b=BjFKFoLTkEgJHnnpamR+qsm8gbm36WUny6tk8eNN82Y+GZXcmfuTLnnWZVYx8/jtqOgea0y8CJH6MI9gf7eornf70ZVYw9R8pGf80oCV/NeU82auLhifDNA3R6vY/aYyvVG1efC307g72+el7E/58hXsHlD/6iOvFE7d4eXl0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808646; c=relaxed/simple;
	bh=76M0O11YjXDhVOwNQyf+2MrBPy9R89P6xMZgiZ5YPCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Szj7AHCXccE1+YVlGPLipxoDDVTnM6U/9la9oSxwXcGtNAplbAYN0rOPxhPxsiLXqJd025XXmSTGdPAV5Ggtj4UFRy46JjqQE2Yekiwnq+w9xBZxcbxubl+rEFI/jfJxjCgWiEH/C6UZwZDj3vPX86bAe6uzvZeiiyaRQFu3Nng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10118 invoked by uid 109); 19 Jun 2024 14:50:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 14:50:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22147 invoked by uid 111); 19 Jun 2024 14:50:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 10:50:42 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 10:50:42 -0400
From: Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
Message-ID: <20240619145042.GA957055@coredump.intra.peff.net>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org>
 <20240619134533.GA943023@coredump.intra.peff.net>
 <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
 <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>

On Wed, Jun 19, 2024 at 04:01:57PM +0200, Christian Couder wrote:

> On Wed, Jun 19, 2024 at 3:50 PM Dragan Simic <dsimic@manjaro.org> wrote:
> 
> > > I don't mind if this is present but disabled by default, but then I
> > > guess it is not really serving much of a purpose, as hardly anybody
> > > would enable it. Which makes collecting large-scale statistics by
> > > hosting providers pretty much useless (and I don't think it is all that
> > > useful for debugging individual cases).
> >
> > I agree that it should actually be disabled by default, for privacy
> > and security reasons, but that would actually defeat its purpose, so
> > I'm not really sure should it be merged.
> 
> One possibility is to send just the `sysname`, described as 'Operating
> system name (e.g., "Linux")', field of the struct utsname filled out
> by uname(2) by default.

That would be better to me. I still don't love it, but I admit it's
coming more from a knee-jerk response than from some rational argument
against people knowing I run Linux.

Since HTTP user-agent fields are common, we can look at those for prior
art. curl sends its own version but nothing else. Most browsers do seem
to include some OS information. My version of firefox gives its own
version along with "Linux x86_64". So basically "uname -sm".

> And then there might be a knob to deactivate it completely or to make
> it more verbose (which might be useful for example in a corporate
> context).

Yes, I think we should definitely have an option to suppress or override
it, just like we do for the user-agent string.

-Peff
