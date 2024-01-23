Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF954BD2
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970589; cv=none; b=ej+9xCHnWfmiA8Cs0Jq8AAg2UzscTSDMyohmy2BdbWpgaC4OVpORTYMjw0N/sOgkOw5oGnx5JVVpBtGpYu46azjjmVdznVszA+ItV1rsP5YnHCtr/4S+HTC76kwtexdajjS4uvXqVevMnstzXjE1lNuSFppJry4OWiBx8femcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970589; c=relaxed/simple;
	bh=btVaHcFQX3JgvdLqMtCSQXI8x+KCfTD4knYuVJx0w7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPnBxxGn+tPFc6jS5l3/vgk9QlZJummVOr3LSyk5GVqTXtVnEMiNJr/03sAZjniex8kHeSrfzFp1xt2+7/1te+8WUg3uAr3G/YPc5DaTODUdQiIi/ePQnkKIP3ND/zSWHxhzB2TJDqX7o4PyDDhjiAt55GqURxuVdBfud5JgRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12614 invoked by uid 109); 23 Jan 2024 00:43:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jan 2024 00:43:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11027 invoked by uid 111); 23 Jan 2024 00:43:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 19:43:08 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 19:43:06 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/4] t0080: turn t-basic unit test into a helper
Message-ID: <20240123004306.GA835964@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <a9f67ed703c8314f0f0507ffb83b503717b846b3.1705443632.git.steadmon@google.com>
 <xmqqa5p4yjmq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5p4yjmq.fsf@gitster.g>

On Tue, Jan 16, 2024 at 02:54:21PM -0800, Junio C Hamano wrote:

> > ... so let's move it to t/t0080/t-basic.c and
> > adjust Makefiles and .gitignores as necessary.
> 
> ... this conclusion.  I somehow thought that t-basic part would be a
> good test-tool subcommand, as it is run from the suite of shell
> scripts for end-to-end testing CLI interaction.

Heh, I was about to ask the same thing.

In particular...

> Do we have any precedent to place programs placed under t/tXXXX/ and
> get them compiled?

...no, I don't think we do. And quite often I exclude those directories
when grepping around the code base, because there is often code there
that is purely used as a data fixture. E.g., t4256 contains a copy of
mailinfo.c which it uses as input for some of the tests. That code also
happens to have out-of-bounds memory reads which we have since fixed in
the real mailinfo.c, but of course "grep" finds them both. :)

So I would prefer a rule like "no buildable code in t/t[0-9]*". Barring
that, maybe we could avoid using things that look too much like real Git
code in our tests (though we sometimes do need fake code for things like
funclines, and even that might end up creating false positives).

-Peff
