Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0B481D1
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758417; cv=none; b=qtV9d71yEdaigQxSiuUd5yQw4cBQJspZxJPeGAtlC/zERos8xxhDRpQaJMLm6yqlcFIi/8RriwMlb8Ni32AWM+Y9fgQrT2pd7HJIKLslrUcDDFoHhk54TobUsyj5eFquXCKmIMDBKlWQ2SJQ8s6Vi7JwHU0UbLQ17iRyn4X4UGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758417; c=relaxed/simple;
	bh=PuvPfubKTpx0sBB7QNYBv0RmnPdWZG8xyCwKAV3T/b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZsJqaqikcUQcddzo9zIliqDlHzBAaUGtmUjGqsdx5dvW4g8ZxJ2OsD75aJyx4SjqG2nR9fAVzIspwLQ/7LpFh/qtImIu3NwJvFbMXTI5Kx57ekwiFqkhXXfjSIIteI2bZ7pS9YdwADWR2Ymz4R2ypON5ueMAb0EoEFSibKAysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11822 invoked by uid 109); 3 May 2024 17:46:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 May 2024 17:46:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17491 invoked by uid 111); 3 May 2024 17:46:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 May 2024 13:46:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 May 2024 13:46:53 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
	Dhruva Krishnamurthy <dhruvakm@gmail.com>
Subject: Re: Re* using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git 2.42
Message-ID: <20240503174653.GD3631237@coredump.intra.peff.net>
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net>
 <ZjLfcCxjLq4o7hpw@nand.local>
 <ZjPOd83r+tkmsv3o@nand.local>
 <xmqqfrv0ds7f.fsf@gitster.g>
 <ZjPTlrMdpI+jXxyW@nand.local>
 <CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
 <xmqqbk5ndiqk.fsf@gitster.g>
 <CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
 <xmqqzft6aozg.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzft6aozg.fsf_-_@gitster.g>

On Fri, May 03, 2024 at 08:34:27AM -0700, Junio C Hamano wrote:

> And for folks who had been happy with the pre 2.42 behaviour,
> we could do something like the attached as the first step to a real fix.

It looks like lots of discussion happened with out me, and everybody
already posted all of the responses I was going to. Good. :)

In particular...

> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] stop using HEAD for attributes in bare repository by default
> [...]
> The right fix for this is to optimize the code paths that allow
> accesses to attributes in tree objects, but that is a much more
> involved change and is left as a longer-term project, outside the
> scope of this "first step" fix.

...this was the exact first step I was going to suggest. And your patch
looks correct to me. I assume you'd target this for 'maint'. The
regression goes back to v2.43.0, so it's not exactly new, but given the
severity in some cases it seems like it's worth getting it into a
release sooner rather than later.

I am mildly surprised nobody noticed the issue until now. I wonder if
t/perf would notice it and nobody is running it, or if this is a gap in
our coverage there. If the latter, it might be worth adding such a
script, which should be able to show off that your change here takes us
back to the v2.42 state.

Running the perf suite against linux.git between 2.42 and 2.43 would
answer the "is this a gap" question, but I haven't had a chance to do
so, and it takes a while.

-Peff
