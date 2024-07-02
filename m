Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0578F4E
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881867; cv=none; b=JOqvk84KE7yV3SdMMsHPbuBNSY9yvqdr5DNWTFBEsq9h5F/QxFhik65BIRNA+I/uDaw6yIh574wYTQSsrsriUJyh0tjohO8ik4apMACKJtMg6uqfm/DqaivKxLV0ueClQKhVHMDRsTdRxuCI9WwD6Kgp+P0l6gDy7G8qO+INYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881867; c=relaxed/simple;
	bh=n8wVAUiBHJE93G3jv7cNweBNYUL1U4rsk0oXw9BMUkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oz+7mlWLA5siN/rng/x3KXUDwDmtsPYQhsRgRLra52zEpQ9C4roFlZ2omsSe9itzQAmQobPNUOV4Jd0Xrqu0fxrddy9rA4AFdLy1WNblnXU8/h3Atr8nd/cjDXqGzoFUcrtwc/nSJ5ObANgtr4I+WbCi2owfTbCiHq4OJtfZZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30440 invoked by uid 109); 2 Jul 2024 00:57:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jul 2024 00:57:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19243 invoked by uid 111); 2 Jul 2024 00:57:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 20:57:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 20:57:43 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/6] t0080: move expected output to a file
Message-ID: <20240702005743.GB27170@coredump.intra.peff.net>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>
 <20240701032047.GA610406@coredump.intra.peff.net>
 <xmqqed8cx6q0.fsf@gitster.g>
 <20240701221019.GA20683@coredump.intra.peff.net>
 <xmqqcynwu1h6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqcynwu1h6.fsf@gitster.g>

On Mon, Jul 01, 2024 at 04:38:45PM -0700, Junio C Hamano wrote:

> > I just (re-)posted it in:
> >
> >   https://lore.kernel.org/git/20240701220815.GA20293@coredump.intra.peff.net/
> >
> > so you can see the improvement in some other real cases.
> 
> ;-)
> 
> The shells we care about (and that does not include the /bin/sh on
> ancient Solaris ☹) should be OK, but "IFS= read -r line" somehow
> makes me feel nervous.  Maybe I am superstitious.

I don't know offhand of any case where it will fail. I'd prefer to start
with it and see if it bites us, given that it saves us a process
invocation per test (and those do add up in some cases).

I also wondered if we might be able to save the syscall-per-byte
overhead of "read" for some shells (since we know we are reading until
EOF anyway). Using "read -N" with bash would let us do that, but
obviously we'd still need to fall back to regular "read" for other
shells. I don't think it's worth the complexity unless we can really
show a measurable speedup (and I didn't seem to see one).

-Peff
