Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7118E
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621852; cv=none; b=P9Rkj6ohM+4Hhr+3Jg6zjjrQAuLdOc6u42ERon3j6rykZeS2g90zJrcRtJb5abyd0sAFgtfgVBFKFZqUIVRmOBVeUntvyDWMFMD3sJclKI7zd6J5DqgE1z9Odn7x3RElWJxF/dlcdtu04h1SyRIVx3Qn4TfCpxFIt903SYPO6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621852; c=relaxed/simple;
	bh=8cDZoM7mdtWX4sz0nCRZlAzwsKgt4ZZYvfcAVK3FSvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr72002U5KjG1KYr4T2dsQ8Af6tB6uHT6KciRZUsnzTaIXTh12C76gKCmsmglaK06xSSzOg4VE9NWHqD1Tloagt6fy67rNtJfQrqG2woQ19p61eXUlkCmedI0znBGHmQ/SCEBMUMeGajfs5KZWjn/tgjjjkAr9tJtAIM7vu++UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32228 invoked by uid 109); 9 Apr 2024 00:17:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Apr 2024 00:17:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30617 invoked by uid 111); 9 Apr 2024 00:17:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Apr 2024 20:17:32 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Apr 2024 20:17:28 -0400
From: Jeff King <peff@peff.net>
To: Paul Smith <psmith@gnu.org>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org,
	Dario Gjorgjevski <dario.gjorgjevski@gmail.com>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional
 statements
Message-ID: <20240409001728.GB1647304@coredump.intra.peff.net>
References: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
 <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
 <xmqqle5n8rcr.fsf@gitster.g>
 <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
 <20240409000414.GA1647304@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409000414.GA1647304@coredump.intra.peff.net>

On Mon, Apr 08, 2024 at 08:04:14PM -0400, Jeff King wrote:

> I do find it curious that in:
> 
> ifdef FOO
> 	SOME_VAR += bar
> endif
> 
> the tab is significant for "ifdef" but not for SOME_VAR (at least that
> is implied by Taylor's patch, which does not touch the bodies within the
> conditionals).
> 
> I may just be showing my ignorance of the parsing issue, though. For
> anybody else digging into the details, I think the correct link is:
> 
>   https://savannah.gnu.org/bugs/index.php?64185
> 
> (the commit has the wrong bug number, 64815).

Answering my own question (at least what I think the answer is): there's
basically two levels of parsing going on. The outer layer is respecting
conditionals to decide which lines to care about at all, and the inner
one is figuring what are assignments, rules, recipes, etc.

So the outer parser cares about things that look like conditionals, but
nothing else. The inner one has more context and can more easily realize
that "\tSOME_VAR += bar" is not part of a recipe.

I'd guess it's _possible_ to fix the case discussed in the bug by
letting the outer parser know more of the inner-parser context (i.e.,
whatever rules it uses to decide that the assignment line is not a
recipe line could similarly be used for a line like "\telse"). But I
also wouldn't be at all surprised if it would involve a substantial
rewrite.  At any rate, I'd certainly defer to you on such matters. I'm
mostly just thinking out loud from my peanut-gallery perspective.

-Peff
