Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B531847A
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247507; cv=none; b=gCLxNtYXTDnWN1vmFm2xpi33vlx/AgkuABYj7Gk7KnwDLxpJIWFbt62RxXoozchNPRrTcWF1BTStwQ2gikMNPskT7lqfbFtcw+hhKoerWY7frPfnm+xaG3/HidCaY2B1Rvzj3Qi0u7J2PWm1YvifhLV9VFZayhwu8R/v9dL9rIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247507; c=relaxed/simple;
	bh=7UwM+FdwqhwHaM+7d3oZ3zvgsOpbKZfmOmps3/65rgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY3gNdnX7bWh0x6I9FjsEWLIu/fBOibiYmAXj8p7Rt1693w700dVvD93+RGcCwUE4hMTnAW6FmvjcAxTawc+vUellM7HgGdni7cuTeywLdNiPT0BBHpem8SF49neEDMauk2qS89xhHerQadgid0w57jRxCLPqMCYRGS4Ol0VitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23838 invoked by uid 109); 6 Jul 2024 06:31:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:31:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31400 invoked by uid 111); 6 Jul 2024 06:31:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:31:42 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:31:43 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH] config.mak.dev: fix typo when enabling -Wpedantic
Message-ID: <20240706063143.GE700645@coredump.intra.peff.net>
References: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>

On Fri, Jul 05, 2024 at 02:51:09PM -0400, Taylor Blau wrote:

> But ebd2e4a13a has a typo where instead of writing:
> 
>     ifneq ($(or ($filter ...),$(filter ...)),)
> 
> we wrote:
> 
>     ifneq (($or ($filter ...),$(filter ...)),)

Good catch. Your fix is obviously the right thing. But one thing that
puzzled me...

> Causing our Makefile (when invoked with DEVELOPER=1, and a sufficiently
> recent compiler version) to barf:
> 
>     $ make DEVELOPER=1
>     config.mak.dev:13: extraneous text after 'ifneq' directive
>     [...]
> 
> Correctly combine the results of the two "$(filter ...)" operations by
> using "$(or ...)", not "$or".

...why don't I see this error? Based on the bug, I think that we'll
always pass -Wpedantic, even for old compilers (because our weird "or"
will never be the empty string).

So I could understand if the symptom was then that when you have an old
compiler, we feed it -Wpedantic and it complains (though the fact that
nobody noticed such a behavior makes me wonder if we even care about
such old compilers now?).

But why does make complain here only sometimes? Does it depend on the
version of make?

-Peff
