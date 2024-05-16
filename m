Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CE2EB10
	for <git@vger.kernel.org>; Thu, 16 May 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844477; cv=none; b=lCXLlyVPnp8MEDaxjqiCcO5by3upGIqZCUJ9y1pvg40ZU0mkBGbZ6WZOMpXpwn4UsCZvAGV3NZkON0HrNpVINk/VYh9V8juTSa68CBjjq5NCcY/I9sH1OOgiYFRw4hQFncf+YWwtZ343RheUqNDLCGFvTF+61vyGqU/sQgLfgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844477; c=relaxed/simple;
	bh=suX6nCH70QMR55Yqn10uv8CpHrLf6qDnmcdaFBBK+wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT36sqCvWqB9HBoY3doFzKyyXKjXOV+Z8d5bqoJJKv/MvcCsWgIh92BYf9T2ltt/EE7s+OzK9z1SzxJlvQoRkKpFI5Sj4aebatPvIMbIjB2xhpJmf5KxrwxphMdds14qxazCQePeYVetusIT4HA+eno2VGbNOdN6a6V0+bxTENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28519 invoked by uid 109); 16 May 2024 07:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 May 2024 07:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11698 invoked by uid 111); 16 May 2024 07:27:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 May 2024 03:27:58 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 May 2024 03:27:53 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <20240516072753.GA85091@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
 <20240510220228.GA1962678@coredump.intra.peff.net>
 <xmqqseyp1dys.fsf@gitster.g>
 <Zj-pGGGJEXlH02nR@framework>
 <20240516071930.GB83658@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240516071930.GB83658@coredump.intra.peff.net>

On Thu, May 16, 2024 at 03:19:30AM -0400, Jeff King wrote:

> On Sat, May 11, 2024 at 07:21:28PM +0200, Patrick Steinhardt wrote:
> 
> > On Fri, May 10, 2024 at 03:47:39PM -0700, Junio C Hamano wrote:
> > > Jeff King <peff@peff.net> writes:
> > [snip]
> > > > [1] Another quirk is that we run the whole test suite for both
> > > >     compilers, which is probably overkill. The main value in comparing
> > > >     gcc vs clang is that we don't use any constructs that the compiler
> > > >     complains about. It's _possible_ for there to be a construct that
> > > >     the compiler does not notice but which causes a runtime difference
> > > >     (say, undefined behavior which happens to work out on one compiler),
> > > >     but I think we're again hitting diminishing returns.
> > > 
> > > Yeah, that is a very good point.
> > 
> > On Linux, we have the "pedantic" job that runs Fedora and only compiles
> > the sources with DEVOPTS=pedantic without running any of the tests. We
> > could do the same on macOS.
> 
> Yeah, I think the infrastructure is there (looks like just resetting
> $run_tests). We probably could stand to use it in more places. E.g., is
> there even value in running the tests for linux-gcc and linux-clang?
> It's _possible_ for there to be a run-time difference in the compiler
> outputs, but we may be hitting diminishing returns. The main value I
> think is just seeing what the compilers complain about.

Actually, scratch that. I forgot we dropped linux-clang last summer in
d88d727143 (ci: drop linux-clang job, 2023-06-01), since it was mostly
redundant with the sanitizer builds (which use clang).

There is still "linux-gcc" and "linux-gcc-default", the former of which
uses an older version of the compiler. And again, it's not clear to me
that running the actual tests is uncovering useful stuff there.
Certainly it is possible, but I wonder if that is the best bang for the
buck (e.g., if we wanted to spend a "make test" worth of CPU, then
something like osx-sha256 would IMHO be more likely to uncover something
useful).

-Peff
