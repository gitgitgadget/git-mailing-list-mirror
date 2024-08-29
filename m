Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA381BE25C
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960938; cv=none; b=Cw9aqBmm4LbQZ7mHcst8YbpFD1Pouub6KLi3iPQOpapwb+HPvyk9MIIXpGcN1LPlD44Y2bFXUnFE6xv6MsHt/tAc7rEKHC0ItDhryxNQ19CEYA8ZAQKFUObtufdGf2XYCXkQeP7f6sEni8JaZqqTbQtHwvNLRzfvFpD5tAH8FCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960938; c=relaxed/simple;
	bh=BOGiOE8zKwlptXIx+OAeCwbZK/MS5QOSTtrd3l/u8GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT7wgUYeRr8bF2QAPpngxKzNTGqD4uZu42nYL8qlaPZdqGem1PdHt42W1fGCtQYoohcl1L8emggtFgtX65sryzG3odDONorat7cyTB9u4kc//rrzYNZHomvLwonpoGic5fjt4NrRkHW+WLaSPc5flQyIGZTktiNEVTcOJ2zEE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5890 invoked by uid 109); 29 Aug 2024 19:48:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 19:48:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10067 invoked by uid 111); 29 Aug 2024 19:48:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 15:48:57 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 15:48:55 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] add ref content check for files backend
Message-ID: <20240829194855.GE423429@coredump.intra.peff.net>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <Zs348uXMBdCuwF-2@ArchLinux>
 <xmqqbk1cz69c.fsf@gitster.g>
 <20240829040215.GA4054823@coredump.intra.peff.net>
 <xmqq5xrjzzxt.fsf@gitster.g>
 <ZtAcowXWinP2Iguj@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtAcowXWinP2Iguj@tanuki>

On Thu, Aug 29, 2024 at 09:00:58AM +0200, Patrick Steinhardt wrote:

> > diff --git c/Documentation/BreakingChanges.txt w/Documentation/BreakingChanges.txt
> > index 0532bfcf7f..2a85740f3c 100644
> > --- c/Documentation/BreakingChanges.txt
> > +++ w/Documentation/BreakingChanges.txt
> > @@ -115,6 +115,12 @@ info/grafts as outdated, 2014-03-05) and will be removed.
> >  +
> >  Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
> >  
> > +* Support for core.prefersymlinkrefs will be dropped.  Support for
> > +  existing repositories that use symbolic links to represent a
> > +  symbolic ref may or may not be dropped.
> > ++
> > +Cf. <20240829040215.GA4054823@coredump.intra.peff.net>
> > +
> >  == Superseded features that will not be deprecated
> 
> Yes, I'm very much in favor of that. As Peff said, I don't see a single
> reason why it would make sense to use symlinks nowadays. We have also
> supported the "new" syntax for ages now, and I'd be surprised if there
> were repos out there using it on purpose.
> 
> We should probably do the above together with a new check that starts to
> warn about symbolic links in "refs/" such that users become aware of
> this deprecation. We'd have to grow the infrastructure to also scan root
> refs though, which to the best of my knowledge we don't currently scan.

I think the first step of the proposal (and what I had written in the
patches that I linked) was just that we would stop _writing_ symlinks.
And there we'd only need to warn people who have that config option set.

Whether to drop the reading side is less clear to me. I think in the
long run it is good as a cleanup (and one less source of weird behavior
that malicious local repos can trigger). But that decision can be made
separately. I think it would be OK to just issue a deprecation warning
whenever we actually follow a symlink (because I think we do so
manually, since we need to know the target name as part of the
resolution process).

-Peff
