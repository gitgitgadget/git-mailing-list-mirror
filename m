Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA916F8E3
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087487; cv=none; b=j13xGC8RAHNQiDf8cje6fo2vym5ckGrRnPIfddizEgiICRm0rbmxf6LsdYnzhwe/dhDQeElnO+C4a6aO6beT7qZZfzs+NtuE7XR7ihDeqFQbO0MfBSlaBFV2sv8nA5F3LdScK4M7Y0YOpWpiJRFIUUqB3t4T0vumqypPkAVxrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087487; c=relaxed/simple;
	bh=3yQqarJUcu06w0XWKEivUeHtdTKf8VToY68TtuBvRT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECv3aFUXM26saXwL0F5Ay0VIIeOUOua5ywt4U9ZmmrbCv3fEV/69hQR/ahz/HtDTlkRuTkV6U3RjgRtgsN9SLBK0eWaZXr9sapVzdTiR0QG3UUcAdfy/iUvYCaALmkaGdyKZCV+quBuDFy4eJuSiMdBs96YnP5YEJuvx8k4uUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16709 invoked by uid 109); 11 Jun 2024 06:31:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 06:31:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23916 invoked by uid 111); 11 Jun 2024 06:31:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 02:31:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 02:31:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Emily Shaffer <nasamuffin@google.com>, ellie <el@horse64.org>,
	rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <20240611063123.GB3248245@coredump.intra.peff.net>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
 <xmqq5xug1qrf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xug1qrf.fsf@gitster.g>

On Mon, Jun 10, 2024 at 01:34:12PM -0700, Junio C Hamano wrote:

> Emily Shaffer <nasamuffin@google.com> writes:
> 
> > It seems to me that packfile URIs and bundle URIs are similar enough
> > that we could work out similar logic for both, no? Or maybe there's
> > something I'm missing about the way bundle offloading differs from
> > packfiles.
> 
> Probably we can deprecate one and let the other one take over?  It
> seems that bundleURI have plenty of documentation, but the only hit
> for packfile URI side I find in the output of
> 
>     $ git grep -i 'pack.*file.*uri' Documentation
> 
> is the description of how the designed protocol extension is
> supposed to work in Documentation/technical/packfile-uri.txt and not
> even the configuration variable uploadpack.blobPackfileURI that
> controls the "experimental" feature is documented.

I think they serve two different purposes. A packfile URI does not have
any connectivity guarantees. So it lets a server say "here's all the
objects, except for XYZ which you should fetch from this URL". That's
good for offloading pieces of a clone, like single large objects.

Whereas bundle URIs require very little cooperation from the server.
While a server can advertise bundle URIs, it doesn't need to know about
the particular bundle a client grabbed. The client comes back with the
usual have/want, just like any other fetching client.

At least that's my understanding. I have to admit I didn't follow the
recent bundleURI work all that closely.

-Peff
