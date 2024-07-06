Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4472557A
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307588; cv=none; b=BI3YltIVoZS/fvrSY1U4CUP7jrJ6kpjNJokhCYj5ckHN6LzlmGpazD87Xy928+JnMmB+iJCNrZRdmms/jxP3mk16gCwf8kVLSdwv8LIfAoLD0STmqm/Miy1oELRVCp8KH5iU6jB32PYyjvj9MYdYJvJ0UX/whQPx/NQVF2q70zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307588; c=relaxed/simple;
	bh=JfYn2dkp8eFwesRbppLlkakuC6XgCgo7kQg4Knu2isA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a+uQQn3k0jJgDN+zRT3KIOxdmTou8vLjuhICxklEI8SiViPoJMkCJePMkQ5YD2M7s2Y0NKn7CU4vLiJvT9XVeG/yoFjcl77oR72+hAFByM+8WEaywyBt96W6bvkm3Gy80p0DQd/ZBEwahpN2BvyJ+yx2YwB0RG62q1VxsJSYK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31868 invoked by uid 109); 6 Jul 2024 23:13:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 23:13:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7061 invoked by uid 111); 6 Jul 2024 23:13:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 19:13:04 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 19:13:04 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH] config.mak.dev: fix typo when enabling -Wpedantic
Message-ID: <20240706231304.GB746087@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zolim6llm3cphdTT@nand.local>
 <Zolfn81ygqfw0iOK@nand.local>

On Sat, Jul 06, 2024 at 11:15:43AM -0400, Taylor Blau wrote:

> > But why does make complain here only sometimes? Does it depend on the
> > version of make?
> 
> It seems to depend on the version of make you're using. On my system,
> 'make' is GNU Make 4.4.90, which has the more restrictive checks around
> the recipe prefix in nested conditionals.
> 
> With that version (and the pre-image of this commit), I get:
> 
>     $ make -v | head -1 && make DEVELOPER=1 2>&1 | head -1
>     GNU Make 4.4.90
>     config.mak.dev:13: extraneous text after 'ifneq' directive
> 
> , but with /usr/bin/make (which on my machine is GNU Make 4.3), I
> instead get:
> 
>     $ /usr/bin/make -v | head -1 && /usr/bin/make DEVELOPER=1 2>&1 | head -1
>     GNU Make 4.3
>     GIT_VERSION = 2.45.2.746.g06e570c0df

Ah, thanks for digging. That makes perfect sense (I'm on 4.3 from Debian
unstable).

> On Sat, Jul 06, 2024 at 11:15:43AM -0400, Taylor Blau wrote:
> > It is tempting to just want to rip out support for older compilers, but
> > given that ebd2e4a13a (Makefile: restrict -Wpedantic and
> > -Wno-pedantic-ms-format better, 2021-09-28) is only three years old, I
> > imagine that some builders may still want support for older / pre-GCC 4
> > compilers.
> 
> Hmm... thinking on it more, edb2e4a13a hasn't been working at all on the
> older versions of Make that people with ancient compilers are likely
> also using. So it's possible that that commit isn't doing as much as we
> think, in which case we could rip it out altogether.

Right, that's what I meant by "nobody seems to have complained". But as
you note, it's not like it gets rid of the detect-compiler script. It's
just this one check. So it doesn't hurt much to leave it.

-Peff
