Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2581C8D1
	for <git@vger.kernel.org>; Thu, 16 May 2024 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715843973; cv=none; b=KTrS53Z3KdqBf5bwJbCqtCrCYvNIo4eC6QiYkXFDzgNHMpXx9M+ADxATKtZTZL7Ox8rNQ76L5snCqQF2c8qP3cJxzHNVbPGuEkLaCSWhL6cYEWEvTxCP58Y6yrdZvUUqJt2EahBWDthqZ/z68+a7MLzPUWEL6ftFMBAHBiQesdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715843973; c=relaxed/simple;
	bh=mMyRBtGniiRnjbxkx5Iw/G0+Dzs+wHVYuzv7Jxg6tkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrPEf5aL6oS6nZpXpykQph7r7v+8nJGMvrsBfjlKFpanIGwPH2+t123Tav/ANSqlFCTWoweXQz0NTXvfJ1XCVDmzZjPsnCI2oBRfJeLpfv5R+m0U49L811l6PULaXP8IpL1g9uXs5v4YtitzuF/V9GwGgWPnSc7R54sZCWEdkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28497 invoked by uid 109); 16 May 2024 07:19:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 May 2024 07:19:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11595 invoked by uid 111); 16 May 2024 07:19:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 May 2024 03:19:35 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 May 2024 03:19:30 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <20240516071930.GB83658@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
 <20240510220228.GA1962678@coredump.intra.peff.net>
 <xmqqseyp1dys.fsf@gitster.g>
 <Zj-pGGGJEXlH02nR@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zj-pGGGJEXlH02nR@framework>

On Sat, May 11, 2024 at 07:21:28PM +0200, Patrick Steinhardt wrote:

> On Fri, May 10, 2024 at 03:47:39PM -0700, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> [snip]
> > > [1] Another quirk is that we run the whole test suite for both
> > >     compilers, which is probably overkill. The main value in comparing
> > >     gcc vs clang is that we don't use any constructs that the compiler
> > >     complains about. It's _possible_ for there to be a construct that
> > >     the compiler does not notice but which causes a runtime difference
> > >     (say, undefined behavior which happens to work out on one compiler),
> > >     but I think we're again hitting diminishing returns.
> > 
> > Yeah, that is a very good point.
> 
> On Linux, we have the "pedantic" job that runs Fedora and only compiles
> the sources with DEVOPTS=pedantic without running any of the tests. We
> could do the same on macOS.

Yeah, I think the infrastructure is there (looks like just resetting
$run_tests). We probably could stand to use it in more places. E.g., is
there even value in running the tests for linux-gcc and linux-clang?
It's _possible_ for there to be a run-time difference in the compiler
outputs, but we may be hitting diminishing returns. The main value I
think is just seeing what the compilers complain about.

But I dunno. This thread argues there is value in running the tests with
the separate compiler:

  https://lore.kernel.org/git/pull.266.git.gitgitgadget@gmail.com/

which I guess would argue for doing the same for osx-clang and osx-gcc
(if the latter continues to exist).

-Peff
