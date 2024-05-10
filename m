Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9604DA11
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372033; cv=none; b=cTNYD37ZTLyfHuRDhONlFuDBatpeC1v6cBRrafnTTAr6T0i/lRrbkj5utRu0Tx5901PnH1vPMkjOp1F2cbNWjmEZpWWbQ7lWBDch2uDUywVnhOb+3rtNjHz+NVWR5iAwFg/+YWUD4N4GrL/qETGcdgC1bLgAcmcl87jC/jK//TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372033; c=relaxed/simple;
	bh=/CBwIKRc1ItnehGrZKUNaJqIF+ZvpI0VcrGPxYJID5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiyPmItCZVxfxwfyxR0iDzAXBeiFfPba+dGhvimALJlqewMvM5K0tPUFYec2b2e4dreOjbWuKCwuissVyDxqQX7PALBrlc/vGdib7xFMvCk4mVbXg4ktPgqxGRSMP1TWfucKeZqeAIcjZHAP8liFUxKx70X0Sy2WphcUr/keKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18988 invoked by uid 109); 10 May 2024 20:13:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 20:13:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12388 invoked by uid 111); 10 May 2024 20:13:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 16:13:51 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 16:13:48 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <20240510201348.GE1954863@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net>
 <Zj3F9EVpSmQtyy0R@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zj3F9EVpSmQtyy0R@tanuki>

On Fri, May 10, 2024 at 09:00:04AM +0200, Patrick Steinhardt wrote:

> On Thu, May 09, 2024 at 12:25:44PM -0400, Jeff King wrote:
> [snip]
> > I'd like to report that this let me get a successful CI run, but I'm
> > running into the thing where osx jobs seem to randomly hang sometimes
> > and hit the 6-hour timeout. But I did confirm that this lets us get to
> > the actual build/test, and not barf while installing dependencies.
> 
> Yeah, this one is puzzling to me. We see the same thing on GitLab CI,
> and until now I haven't yet figured out why that is.

Drat. I was hoping maybe it was a problem in GitHub CI and somebody else
would eventually fix it. ;)

It feels like a deadlock somewhere, though whether it is in our code, or
in our tests, or some system-ish issue with prove, perl, etc, I don't
know. It would be nice to catch it in the act and see what the process
tree looks like. I guess poking around in the test environment with
tmate might work, though I don't know if there's a way to get tmate
running simultaneously with the hung step (so you'd probably have to
connect, kick off the "make test" manually and hope it hangs).

> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 5f92a50271..13cc0fe807 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -285,7 +285,6 @@ jobs:
> >              pool: macos-13
> >            - jobname: osx-gcc
> >              cc: gcc-13
> > -            cc_package: gcc-13
> 
> As far as I can see this means that we don't install GCC at all anymore
> via Homebrew. Does this mean that we now rely on the GCC version that is
> preinstalled by Homebrew? Won't this break every time that Homebrew
> changes the default GCC version?
>  
> I may be missing the obvious.

Yes, we'll have to update to a different version when the runner image
stops carrying gcc-13. But it's not based on homebrew's default.
According to:

  https://github.com/actions/runner-images/blob/macos-13/20240506.1/images/macos/macos-13-Readme.md

the runner image contains gcc-11, gcc-12, and gcc-13. So presumably it
would be a while before gcc-13 ages out and we have to bother bumping. I
do agree it would be nice to just use the latest gcc in the image, but I
don't think we can specify that here. I guess we could say "gcc-auto" or
something, and then the actual shell code could poke around for it.

-Peff
