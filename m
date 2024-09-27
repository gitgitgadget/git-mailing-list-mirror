Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFF170A0E
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409515; cv=none; b=He8yYD1rEIambZKQ8ZfW9d6yrQ7334NfY6OFwF1LQyfYnc4LFgAUnhyxUKwNk/7CbeOayfjwkARppTdgQMV+LFKA8sFghJLXqoesPKEwW8Ja9mUXKofaPekMGRJ4siaRwl395GtHsPuMG4gEHzvTtR6tE77Keol+zVammmNbDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409515; c=relaxed/simple;
	bh=N4OChJpxBD3P5zpTSXPPHjZJqPRlvIph4icBiJniexE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dawh4tt3jsPGN3o6SjZk2iQhgAlkjMJoSwsGjKKRQQzREn9hzJwAu5xjIA45fpmdFW8MqmwYY3OLdTXzVxdwKspDhvAz3AkHQVWogfNOHB64N9THnJ/GhjuAAv2w/EnqsF213qaG/Ph/f0Lv/2WlvsfXa/wuUjNy6uFDV8lDYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4906 invoked by uid 109); 27 Sep 2024 03:58:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:58:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9099 invoked by uid 111); 27 Sep 2024 03:58:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:58:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:58:32 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] test-lib: check for leak logs after every test
Message-ID: <20240927035832.GI567395@coredump.intra.peff.net>
References: <20240924213404.GA1142219@coredump.intra.peff.net>
 <20240924213836.GC1142403@coredump.intra.peff.net>
 <ZvVtbPw5VjTSfwzH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvVtbPw5VjTSfwzH@pks.im>

On Thu, Sep 26, 2024 at 04:19:24PM +0200, Patrick Steinhardt wrote:

> On Tue, Sep 24, 2024 at 05:38:36PM -0400, Jeff King wrote:
> > If you are trying to find and fix leaks in a large test script, it can
> > be overwhelming to see the leak logs for every test at once. The
> > previous commit let you use "--immediate" to see the logs after the
> > first failing test, but this isn't always the first leak. As discussed
> > there, we may see leaks from previous tests that didn't happen to fail.
> > 
> > To catch those, let's check for any logs that appeared after each test
> > snippet is run, meaning that in a SANITIZE=leak build, any leak is an
> > immediate failure of the test snippet.
> > 
> > This check is mostly free in non-leak builds (just a "test -z"), and
> > only a few extra processes in a leak build, so I don't think the
> > overhead should matter (if it does, we could probably optimize for the
> > common "no logs" case without even spending a process).
> 
> So previously, `--immediate` didn't detect tests that should have failed
> because they were leaks, and now it does? Sounds like a sensible change
> to me, too.

Yes, though just to be pedantic, they are marked as failures even
without --immediate. It is just that doing so is a lot more useful with
--immediate, since otherwise we'd find the leaks at the end (but even
that it may still be useful to point to a particular test).

So it really is "if you are in a SANITIZE=leak build, generating a leak
log fails the test even if it would otherwise pass".

-Peff
