Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558091422DC
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156184; cv=none; b=IWK0xOqyhy2Wg+Mx36i0V+B86jo/c6H2c+02W9aD47MtivK0ZVuKr4eyjM4ErlyFdwVXjkXd1GfJu4vf25xO5Os58M0K0IrJYSf6Y2aYFl5Sm24Bm/sz6HcdWGUElHmDzMhRZpg7vQ9dVGy627o2spwOIUJm51bxHZa/O5z532c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156184; c=relaxed/simple;
	bh=9sUnU1FngitUaJkxCzWCyAQSmdRKhyZkY6lbznt76No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0rKqgTuaQLXzj9fNpxHq0/OCnewj1uWDO/cc2pcfYD/yWYGjJq66g6z086276c2EhtXOnChdqC9KMLKlZpeZTLFKekDrBEv2t+sGLxHXZ+nA0p7Va+T9PR7vMV5XGMrZA5FmC/I1hVv8KGrHca5RJBCgQhI9Wl/htOpFiEmDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22804 invoked by uid 109); 31 May 2024 11:49:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:49:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9483 invoked by uid 111); 31 May 2024 11:49:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:49:41 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:49:41 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/13] leak fixes for sparse-checkout code
Message-ID: <20240531114941.GA429026@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531112433.GA428583@coredump.intra.peff.net>

On Fri, May 31, 2024 at 07:24:33AM -0400, Jeff King wrote:

> But as you might guess, that didn't make t1091 leak-free. And I couldn't
> bear leaving it on a cliffhanger like that, so patches 8-13 fix the rest
> of the issues triggered by that script.
> 
> And along the way we managed to make t1090 and t3602 leak-free, too
> (actually in patch 2, but I didn't notice until the whole thing was
> done).

Oh, btw, there's one interesting workflow I found. It's nice to see if
your incremental work is making things better (and to make sure that the
fixes are being exercised somewhere in the test suite).  But the
granularity of "is this script leak-free" is too coarse to see the
incremental steps.  Likewise even for individual test failures, as you
can have many leaks in a single program.

So I ended up doing this a lot:

  script=t1091-sparse-checkout-builtin.sh
  make SANITIZE=leak &&
  (
	cd t &&
	rm -rf test-results &&
	LSAN_OPTIONS=abort_on_error=0:exitcode=0 \
	GIT_TEST_SANITIZE_LEAK_LOG=true \
	./$script
  )
  for i in Indirect Direct; do
	echo "$i: $(grep "^$i leak" t/test-results/${script%.sh}.leak/* | wc -l)"
  done

It keeps running instead of aborting on leaks (otherwise your counts
may go up as "failing" programs are fixed and we run more code). And
instead just logs it all and counts up the log entries.

I wonder if it would be useful to have something like that baked into
test-lib.

-Peff
