Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3316C2E3
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162903; cv=none; b=Hr72+E8CfggC9WPG68cgeUtN3DS9U1mMVGKY9BIxTSaswZ4tSKv3TFLVJ1EMZE/FTDD2RLzHqzofHBIl8m1hfKWFtzCNfxUM3DmnqA6BWuDgMv2T3/OhkIeB8tllxv5ABvTfMRc82MIXPIeO8zBvjL0EANS/w1V6lF9wrBXLbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162903; c=relaxed/simple;
	bh=BD1NwDX0IhADqR623wxcbTwjKoKaxjMIEmfwGorfsSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjBQI85qEKLroakWfMZQtpkWaI9cMovVyPbeJGM2RVTqx8a0XWjBfFywCXXWtfglmwh94twLN7WUsRqk6bxdK6HSTZ1V2M/bvRPcXH4y9DAyruvJbt08P/Yph+SwcI696ZPFfMibs/hzigr7+OElJeBVlX8JnSt9vz2qU43GoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13504 invoked by uid 109); 26 Apr 2024 20:21:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Apr 2024 20:21:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3077 invoked by uid 111); 26 Apr 2024 20:21:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Apr 2024 16:21:36 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Apr 2024 16:21:33 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] add-patch: response to unknown command
Message-ID: <20240426202133.GA13703@coredump.intra.peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <20240425014432.GA1768914@coredump.intra.peff.net>
 <CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>

On Wed, Apr 24, 2024 at 10:15:25PM -0400, Eric Sunshine wrote:

> > I got a test failure on Windows CI from this. The test_cmp output looks
> > like this:
> >
> >   -(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command 'W' (use '?' for help)
> >   -(1/1) Stage addition [y,n,q,a,d,e,p,?]?
> >   +(1/1) Stage addition [y,n,q,a,d,e,p,?]? (1/1) Stage addition [y,n,q,a,d,e,p,?]?
> >   +Unknown command 'W' (use '?' for help)
> >
> > which makes me suspect a race. Perhaps because the prompt is going to
> > stdout, but the "Unknown command" message goes to stderr? Maybe we
> > should keep stdout and stderr separate and check them independently.
> 
> That's very reminiscent of [1]. Although, unlike [1], the output
> presented to the user in this case is (I suppose) less likely to be
> messed up; only the combined captured output is probably affected. So,
> capturing stdout and stderr separately would indeed be a good idea.

Ah, yeah, that is almost certainly the same issue. I could not reproduce
it on my local system with --stress, so I think it may be unique to
Windows. What it looks like is that stderr is buffered when output to a
file (whereas on most systems it would still be line buffered at most).
But I didn't actually run it through a debugger to see.

So I _suspect_ that yet another possible solution here is to do an
explicit:

  setvbuf(stderr, NULL, _IOLBF, BUFSIZ);

in common-main. Though grepping for setvbuf() in our code base, it looks
like compat/winansi.c already does:

          if (fd == 2)
                setvbuf(stderr, NULL, _IONBF, BUFSIZ);

which would imply that output should happen even more immediately than
line-buffering. So maybe there is some other layer at work. There are
probably dragons, and definitely pursuing that line would involve some
experimentation.

The "if you want them in order, make sure they are on the same stream"
approach suggested elsewhere is by comparison much simpler. :)

-Peff
