Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DD2139CD
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804737; cv=none; b=oalgB3joxveQqSIpQdvWK/lJF1zXgF7OVLLwd49TvgGIWkXFXMdvSJZC67jm664qQZNAPHmZUjJnrrhCDL11epAS84okJerl3sJ5dOmckb1ZXuCJda45b3sqqjCRohDMiO9IlgmUBtB37LnybzjjbA+ArLFgiIYIDEDNQ5OvONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804737; c=relaxed/simple;
	bh=bo2KJ2+dJvOvVloUf6/OI4KyHA+/zFzHv3qjoiTWo+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDn2d0MaeHgG1AqIm3hTpekuTmoeX1kQUXaqSd4PivXKyWQ7XjEw/indVGJqf8okmxSS8i8mKHsBuMvSZQIGlX5Yy0NpgqoaQyXTOArowJ9jDs5M7CDOjV2f1O0YgJGylzASlCYS1JduZkSCEWi0IzqjLdOWLsuGTMuR2Homhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9350 invoked by uid 109); 19 Jun 2024 13:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 13:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21552 invoked by uid 111); 19 Jun 2024 13:45:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 09:45:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 09:45:33 -0400
From: Jeff King <peff@peff.net>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
Message-ID: <20240619134533.GA943023@coredump.intra.peff.net>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0448495385b009f25a66b0712afb28f1@manjaro.org>

On Wed, Jun 19, 2024 at 03:18:40PM +0200, Dragan Simic wrote:

> Hello Christian,
> 
> On 2024-06-19 14:57, Christian Couder wrote:
> > For debugging and statistical purposes, it can be useful for Git
> > servers to know the OS the client are using.
> > 
> > So let's add a new 'os-version' capability to the v2 protocol, in the
> > same way as the existing 'agent' capability that lets clients and
> > servers exchange the Git version they are running.
> > 
> > This sends the same info as `git bugreport` is already sending, which
> > uses uname(2). It should be the same as what `uname -srvm` returns,
> > except that it is sanitized in the same way as the Git version sent by
> > the 'agent' capability is sanitized (by replacing character having an
> > ascii code less than 32 or more than 127 with '.').
> 
> This may probably be a useful debugging feature, but I strongly
> suggest that a configuration knob exists that makes disabling it
> possible.  For security reasons, some users may not want to
> publicly advertise their OSes and kernel versions.  Count me in
> as one of such users. :)

Agreed. We do send the Git version, which is already a slight privacy
issue (though it can be overridden at both build-time and run-time). But
OS details seems like crossing a line to me.

I don't mind if this is present but disabled by default, but then I
guess it is not really serving much of a purpose, as hardly anybody
would enable it. Which makes collecting large-scale statistics by
hosting providers pretty much useless (and I don't think it is all that
useful for debugging individual cases).

-Peff
