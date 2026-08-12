Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876648D869
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570205; cv=none; b=QMh6NMP4h3pAvRDBNzV/oNoh0Fk3Lejf0EXMgX5uD/zJ7IRuT6+tTPGXkFgdKPRiVGAUt60yj3SbbagAkgW5Ni2e8HLVwsek863r7OvXJBJnHKE0fm/E6mISiyfCv0YstGYJjcsBzcXcyx6dltnV6o17B8sv07IBlukLojqEXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570205; c=relaxed/simple;
	bh=DGuQ/iRldMca7HXbS3c9kufaauSuGCSfNHAUGZ21b60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPHBCfZiMsF8qC7FnJ9yAIFgPwp50IUQUgNd0uM0JZMtX5ZEqTu5vIWY9Rn2Ga44UTVwf87vN2zCuK8PCqOiWiOLGpjt7Wf6k8N9N4HzdXxWDGCx0n9voNSrZCBjT+EfWQoiqR2Kn4sGT2Nx9R8FRNFKT7nE+tO3jPIjhxS2cOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Qst6iF9j; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Qst6iF9j"
Received: (qmail 44818 invoked by uid 106); 12 Aug 2026 21:29:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=DGuQ/iRldMca7HXbS3c9kufaauSuGCSfNHAUGZ21b60=; b=Qst6iF9j8rUqhODyed260DqUkxyZfN33xwS7jmI1QkRmmZ1mglHFocSpJ5YQypmmkfvuLTP3Uzz6wiscyhgHPx8Ta5vFUJdllGrAcewVAXmuC5JxszvQnFnpZVg9SLuKmEDXRJNCw4sKTIfXeadKHolgx4O8y3SlhyNap41Rl+LKNbT0RROLZBHBaL3kSm19yT79N6epqHuT40VwJoaW4KnyHwE+qsS1Mwb4xgkiICT29dkdFHbYZPKnyy9O/Wp2Wbbsal2auvN5G1q6S/ynBH8DAExdgBffr6CObjnAyLQedLPWUgtIc8m+FDVK5B0pW4Tyt6bPlaGwgX84tFrFTw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2026 21:29:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31261 invoked by uid 111); 12 Aug 2026 21:29:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2026 17:29:55 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Aug 2026 17:29:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <20260812212955.GA152730@coredump.intra.peff.net>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <xmqqfr0jw20t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfr0jw20t.fsf@gitster.g>

On Wed, Aug 12, 2026 at 12:51:30PM -0700, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > In one reported use case (https://github.com/microsoft/git/issues/970),
> > N equals 37,815 and caused a slow-down of a simple `git rev-parse
> > --short HEAD` (which is regularly executed as part of `GIT_PS1`) from
> > 0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
> > increased from under 2 minutes to over half an hour.
> 
> Face with Rolling Eyes (1f644) 🙄
> 
> As we grow older, more and more extreme use cases that we initially
> thought were simply crazy become reality.

Sort of. The quadratic adding became a problem long ago, hence
ec48540fe8 (packfile.c: speed up loading lots of packfiles, 2019-11-27).

So this was something we already dealt with that regressed. We can even
see the regression in our perf suite:

  $ GIT_SKIP_TESTS='p5303.[1-9] p5303.1[0-9]' ./run 589127caa730^ 589127caa730 p5303-many-packs.sh
  Test                         589127caa730^     589127caa730
  ----------------------------------------------------------------------
  5303.21: load 10,000 packs   0.13(0.11+0.02)   0.45(0.42+0.02) +246.2%

Unfortunately I don't think anybody pays close attention to the perf
suite (partially because it's clunky and expensive to run, but also
because it often requires human judgement to decide when something is a
real change and not just a blip).

None of that has any bearing on the fix, which seems reasonable to me,
but...

> > --- a/t/perf/p5303-many-packs.sh
> > +++ b/t/perf/p5303-many-packs.sh
> > @@ -141,4 +141,8 @@ test_perf "load 10,000 packs" '
> >  	git rev-parse --verify "HEAD^{commit}"
> >  '
> >  
> > +test_perf "abbreviate with 10,000 packs" '
> > +	git rev-parse --short HEAD
> > +'

...I wonder what value this is adding. It shows the same slowdown as the
existing test you can see in the context (and whose results I showed
above).

-Peff
