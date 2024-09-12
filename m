Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49919F42B
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140166; cv=none; b=tqEf5pXv2iQzi5Ue8jZnjBUT5kG6orA3PMh1/3ntRaf70n4CLSDF/Z705tLpH9+qOG660svaw50c69rkp1zIu8/XmVEIBEB6CEms3Etu/DWPSD9Zy4qmhMSOt3ZMPakANqL77HafDnfIhK8YletibSmAGduoYlW6RUkQ0Sc3UkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140166; c=relaxed/simple;
	bh=kaZUb0CnRhfdJR3kRNrd1Pre5ft0DwScnW70yL+Lyr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQJwFb3+YY7ZCWe3XIDun68bXaPmKMVc1uWMBlRgdwm4WpqlLfZ54eo3A4rj0lTR5dXppTZeAglNOuoHF25GyjH8L6AYy0M6rJj4cAs+OUGdIPC5D6N6ayAE8pjKsuy9uwMM4sb7aekehCcAEInntf0ZqwyjYC6FIJFkBjrrLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17701 invoked by uid 109); 12 Sep 2024 11:22:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 11:22:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24912 invoked by uid 111); 12 Sep 2024 11:22:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 07:22:43 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 07:22:42 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci: use more recent linux32 image
Message-ID: <20240912112242.GA622312@coredump.intra.peff.net>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <20240912094730.GC589828@coredump.intra.peff.net>
 <ZuLFPxsDiMB9UBhF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuLFPxsDiMB9UBhF@pks.im>

On Thu, Sep 12, 2024 at 12:41:03PM +0200, Patrick Steinhardt wrote:

> On Thu, Sep 12, 2024 at 05:47:30AM -0400, Jeff King wrote:
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 97f9b06310..db8e8f75a4 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -339,8 +339,8 @@ jobs:
> >            image: alpine
> >            distro: alpine-latest
> >          - jobname: linux32
> > -          image: daald/ubuntu32:xenial
> > -          distro: ubuntu32-16.04
> > +          image: i386/ubuntu:focal
> > +          distro: ubuntu32-20.04
> >          - jobname: pedantic
> >            image: fedora
> >            distro: fedora-latest
> 
> We could counteract the loss of testing against Ubuntu 16.04 by adding
> it to GitLab CI instead:
> 
>     diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>     index 2589098eff7..80b1668ebeb 100644
>     --- a/.gitlab-ci.yml
>     +++ b/.gitlab-ci.yml
>     @@ -25,6 +25,9 @@ test:linux:
>            fi
>        parallel:
>          matrix:
>     +      - jobname: linux-old
>     +        image: ubuntu:16.04
>     +        CC: gcc
>            - jobname: linux-sha256
>              image: ubuntu:latest
>              CC: clang
> 
> I didn't test it, but it should work alright. GitLab doesn't put any
> additional executables into the container, so it is entirely self
> contained. Let me know in case you think this is a good idea and I'll
> run a CI pipeline against this change.

That seems like a good thing to do to mitigate the loss. In a perfect
world we'd have all platforms running all the tests, just because it
helps align the work between finding and fixing (i.e., I might introduce
a bug and not even know it is failing, and you have to spend time
reporting it to me). But the world isn't perfect, so finding out about
my bug _eventually_ is OK. :)

> It's not 32 bit, but at least we continue to verify that Git builds
> against old distros.

I think that's OK. AFAICT this was just another case of overloading CI
jobs with multiple independent variables (and leaving people to wonder
if any failure was because of the 32-bit nature, or because it was old).
Having a dedicated "old" job makes that more obvious.

-Peff
