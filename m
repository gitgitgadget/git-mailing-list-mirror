Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8013CF99
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378554; cv=none; b=XxRdBR6ddWbMvIS9nhLISH6Fj1vhq1xKI/BbIqcEuB9a45SMM0yUfhtDTa2xJi46fv/ksO4tcm8hcehmUTqiSjAZS1ihX+HMthRadbT//OajTgtkf/BbQufZMsC5BwIsqjWtboGHSfOBd8YiaC8+OL1kZ+KiKsZj58B/HuqV11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378554; c=relaxed/simple;
	bh=pVgNojyj2rDn/CW3S5q+MeS4EgT6eZCrhfju6vokDRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo5XmyahuKIfY1ZWrAsoKjbvOnG47KsSP6W6XNnd9vxeeGnJ0AGrYeTDfEAdyYdfFRHZRffl1MNv0E6fYbQG/YG+JuA3q3bJ6+h2rtcg/kX0KENgFxGhYmaGL/9mzDDrPRsAhpNyK8Zuq05bbSyV0HKa1EsBaGxzcivsD0+o3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19581 invoked by uid 109); 10 May 2024 22:02:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 22:02:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13986 invoked by uid 111); 10 May 2024 22:02:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 18:02:30 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 18:02:28 -0400
From: Jeff King <peff@peff.net>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <20240510220228.GA1962678@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>

On Fri, May 10, 2024 at 01:32:15PM -0700, Kyle Lippincott wrote:

> On Thu, May 9, 2024 at 9:24 AM Jeff King <peff@peff.net> wrote:
> >
> > On macOS, a bare "gcc" (without a version) will invoke a wrapper for
> > clang, not actual gcc. Even when gcc is installed via homebrew, that
> > only provides version-specific links in /usr/local/bin (like "gcc-13"),
> > and never a version-agnostic "gcc" wrapper.
> >
> > As far as I can tell, this has been the case for a long time, and this
> > osx-gcc job has largely been doing nothing.
> 
> If it's been doing nothing (which I interpreted as "it's doing the
> same thing as osx-clang"), and we've not noticed any issues with that,
> do we need the job at all? Should we just rely on clang and not test
> with gcc on macOS, since it's not a compiler that's provided by the
> platform anymore?

Your interpretation is correct; it was just doing the same thing as
osx-clang. As I said earlier, I'd be fine with just dropping it. It's
possible that there is value in testing there with gcc (that we've been
missing out on), but to know that we'd have to understand the original
reasons it was added.

Looks like it came from 889cacb689 (ci: configure GitHub Actions for
CI/PR, 2020-04-11), but that was just porting from the Azure pipelines
config. That system got its osx_gcc job from 27be78173d (Add a build
definition for Azure DevOps, 2019-01-29), but that in turn was just
porting the Travis config. The Travis job came from 522354d70f (Add
Travis CI support, 2015-11-27), and there's no specific rationale given.
But it used a build matrix of (os, compiler), so we got all four of
{linux,osx}-{gcc,clang}. So it mostly seems like "more is better" and
that was the easiest way to define it.

I do think there's value in testing with both clang and gcc in
general[1]. And there is _some_ code which is compiled only on macos
and not elsewhere. So this would be our only chance for gcc to see it.
But it seems like a pretty small return for an entire parallel job.
Especially as I do not think it has uncovered anything interesting in
the past (even when it was working).

-Peff

[1] Another quirk is that we run the whole test suite for both
    compilers, which is probably overkill. The main value in comparing
    gcc vs clang is that we don't use any constructs that the compiler
    complains about. It's _possible_ for there to be a construct that
    the compiler does not notice but which causes a runtime difference
    (say, undefined behavior which happens to work out on one compiler),
    but I think we're again hitting diminishing returns.
