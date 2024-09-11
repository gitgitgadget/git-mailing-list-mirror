Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B436154425
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089844; cv=none; b=FzGBrvie4sN3zwFVWhwriHDKHvXq8ndmRDNdcj2kM7DTpuSbo8+F7qCK9uBmCdJiWbtEvGZSq5lXu4wCg6XzzV92XEQ3HCiT0juch8C7/3/wZqPyNbTGAy3UmWach37jDodXp+nmjtBwp5i8pjm8xjQoFpubl6Yccr/6VB9mMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089844; c=relaxed/simple;
	bh=41kbrJ+MC+kGJ89ZLdjV2K6VkjviZx71v+N6zg8Vjs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itE0CbZC/Xp1BNV7NrssIGP74AFnZch+lC3v/5QmR1Dz4e0RmPVX/6nTX6Q1Gmf2ITQfE9uhicpX9swsoUO6cCenJlXuwY4gMPsEcMrvhwIcHKPygbqq6hz54Fvk4zKig8Arju1y1x4pyqbeEoTL79uwE4iWt6WGGLB2hjdixv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14665 invoked by uid 109); 11 Sep 2024 21:24:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Sep 2024 21:24:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13110 invoked by uid 111); 11 Sep 2024 21:24:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2024 17:24:00 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Sep 2024 17:23:59 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 5/9] i5500-git-daemon.sh: use compile-able version of
 Git without OpenSSL
Message-ID: <20240911212359.GA1659@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
 <bfe992765cd562b036cb235dfdddb78f5e662812.1725651952.git.me@ttaylorr.com>
 <20240911061009.GA1538383@coredump.intra.peff.net>
 <xmqqr09qb462.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr09qb462.fsf@gitster.g>

On Wed, Sep 11, 2024 at 08:28:37AM -0700, Junio C Hamano wrote:

> > -		make $GIT_INTEROP_MAKE_OPTS >&2 &&
> > +		make $2 $GIT_INTEROP_MAKE_OPTS >&2 &&
> 
> The build options should be simple enough and this should do for now
> (and when it becomes needed, it is easy to add an eval around it).
> 
> The use of $GIT_INTEROP_MAKE_OPTS here looks a bit curious.  It
> overrides what the inidividual script gave in MAKE_OPTS_{A,B} and
> what is globally given in GIT_INTEROP_MAKE_OPTS_{A,B}.
> 
> With this design, the following is not what we should write:
> 
>     # by default we use the frotz feature
>     GIT_INTEROP_MAKE_OPTS=USE_FROTZ=YesPlease
>     # but version A is too old for it
>     MAKE_OPTS_A=USE_FROTZ=NoThanks
>     # we do not need any cutomization for version B
>     MAKE_OPTS_B=
> 
> Rather we would want to say:
> 
>     # the default should say nothing conflicting with A or B
>     GIT_INTEROP_MAKE_OPTS=
>     # version A is too old to use the frotz feature
>     MAKE_OPTS_A=USE_FROTZ=NoThanks
>     # version B is OK
>     MAKE_OPTS_B=USE_FROTZ=YesPlease
> 
> As long as it is understood that GIT_INTEROP_MAKE_OPTS and *_{A,B}
> are *not* meant to be used in a way for one to give default and the
> other to override the defautl, but they are to give orthogonal
> settings, this is fine.

Yes, there are really three levels: what your platform needs for every
version, what the script asks about for its specific version, and what
you override for that specific version. So arguably the "best" order is:

  MAKE_OPTS_A < GIT_INTEROP_MAKE_OPTS < GIT_INTEROP_MAKE_OPTS_A

which always puts your preferences in front of the script's defaults,
but still lets you do a per-script override. But it didn't seem worth
the complexity to implement that. I mostly left GIT_INTEROP_MAKE_OPTS_A
as an escape hatch if you are testing an alternate version from what's
in the script, and I doubt anybody will need it at all (in all these
years I have only used it to set NO_OPENSSL for this exact case, and
judging by the lack of other people mentioning this issue I suspect
hardly anybody else has ever even run these tests).

> > @@ -76,9 +76,11 @@ generate_wrappers () {
> >  
> >  VERSION_A=${GIT_TEST_VERSION_A:-$VERSION_A}
> >  VERSION_B=${GIT_TEST_VERSION_B:-$VERSION_B}
> > +MAKE_OPTS_A=${GIT_INTEROP_MAKE_OPTS_A:-$MAKE_OPTS_A}
> > +MAKE_OPTS_B=${GIT_INTEROP_MAKE_OPTS_B:-$MAKE_OPTS_B}
> 
> Among the variables we see around here, GIT_INEROP_MAKE_OPTS
> is the only one that is recorded in the GIT-BUILD-OPTIONS file,
> which is included in t/interop/interop-lib.sh file.  Shouldn't
> we record GIT_INEROP_MAKE_OPTS_{A,B} as well?

No, I don't think that would make sense. Everything in
GIT-BUILD-OPTIONS, including GIT_INTEROP_MAKE_OPTS, is going to apply to
_all_ scripts. These _A and _B variants will vary based on individual
scripts. It's possible you might try to run the whole suite between two
specific versions, but then you'd set up GIT_INTEROP_MAKE_OPTS_{A,B} in
the environment (as you already have to do for VERSION_{A,B}).

-Peff
