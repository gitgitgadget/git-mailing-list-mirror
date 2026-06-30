Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40E233927
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782797908; cv=none; b=KOze5gVgf3sIGzlCD/gPjeijRZ8TA1H8vUSPQQV+MpYb5n5pVMh4DszF4fN2DFEKNeuqVpiokTjTDelFTIgpxk26Sbojla7uicV0Txrs0rm0LpauO4mvF3GzZ2pCMUli5pr52oq8m3WoVzHDFoY1eSbQweEBvVpFThM95K+N7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782797908; c=relaxed/simple;
	bh=zXv6VnvAqje3gjRo1hby9BC+1mlZrvgEZErJ1RI9zP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV+M/yAawcFZiBbckUJufIIVNC+jK+gdhsnklOEYTq59tl4vaxaPR1cmgNg06a231mNswEdsf7v50J/75n2m6XczMVfQlV648o3ymInP/QuYpzsZkoa8RTJ/XYULcqc6v9TEafKdOlxBnGYqgGC42HMisto0rc1lMuVzJoUfGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FlRSmnC7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FlRSmnC7"
Received: (qmail 69689 invoked by uid 106); 30 Jun 2026 05:38:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zXv6VnvAqje3gjRo1hby9BC+1mlZrvgEZErJ1RI9zP8=; b=FlRSmnC7qyMlLN7tF9IJtxM/CuFG9bLEyy4WB+IFrEZ9fvWyAorvtPd1uW8NHddNBguL/ClHompwVcspNXfpFgqS1Q7dTbpDzntzTQw/ntvPwYF35X/qYTy3S2uY//8EqIQa5IPWhz7NA3jZAGUrDcyNjP4l07cP+P+in6HXGZHXti7m/htidnz2CUcUDuIDyuDJYzuVc6+ftDhuY2c1V0keblIP7hsSfJK45i61I/mrYfi681xSDWFZF5gykBhXWvqGNYSH2W/zsBq1x0DLYNS10K/a8B3lGKBBy+2Lx1PGNGYMPpLM1P6NYq/NgGkCA+xZiaehLwdQREC8qsl0iw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 05:38:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140913 invoked by uid 111); 30 Jun 2026 05:38:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 01:38:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 01:38:25 -0400
From: Jeff King <peff@peff.net>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
Message-ID: <20260630053825.GC2495216@coredump.intra.peff.net>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
 <ai_KWo9o1Fhc6OFs@pks.im>
 <94b0bed5-c86a-4291-b958-52f09faebd29@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94b0bed5-c86a-4291-b958-52f09faebd29@gmail.com>

On Tue, Jun 30, 2026 at 09:13:28AM +0530, Kaartic Sivaraam wrote:

> On 15/06/26 15:18, Patrick Steinhardt wrote:
> > Huh, curious. That seems to hint that we're missing test coverage for
> > this specific scenario, as our test suite doesn't detect this leak.
> > 
> 
> Indeed. The tricky thing is (as mentioned in another thread), this is
> happening only when we get a commit not cached in the commit slab. Once we
> get an idea on how certain commits get cached in the commit slab while
> others don't, we can write a test case that would catch this leak.

Try:

  make SANITIZE=leak
  cd t
  GIT_TEST_COMMIT_GRAPH=1 ./t3451-history-reword.sh -v -i

That shows off the leak. It's possible we should be running the LSan
tests in CI with more feature flags enabled, but I suspect it's just as
likely to miss a case as to add one (i.e., there might be a leak when we
_don't_ use the commit graph). We could do both, but the combinatorics
get expensive.

You could add a specific test that builds a commit graph and runs a
history-reword. That would show off the fix, but it's so specific that I
find it a bit unlikely that it would catch a useful regression in the
future.

So I dunno. I would be content with showing the commands above in the
commit message.

-Peff
