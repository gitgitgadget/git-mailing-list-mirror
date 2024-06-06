Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D10DDD2
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661157; cv=none; b=Tltt0lX2xVHG0ivXWVtXG12GWGc1H+Jsyzc8TtEfKNkgjQiB6BhtaKldufA9LsWuYV7y2QcEHZj/sW6kcUltfl72ckUr9bb6dywBIbV6mHzPEBRRjkxmmACLWJjhYhkhrPMIE92P+SJDhke+GaalMGyH5p6zVB3e39sLHhg0cQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661157; c=relaxed/simple;
	bh=jBPsv+Tkv8mvty/RNT/416rCePr/wAPR9DqINjFQqSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFHbKrNYnFb/P5aAkEydMjwOlit8WH5z7tXxBnNMmkcfT8+/wynJC32T6hOlSbkTkmTAUDGAMM1GrQ+cULBF0w605IzsS1GHfJ3FioiMdpVXM1jBLu7aHM4McfzY9JQIOglhsn3aRWScMQmi9q6gy5e+K+ySV9GAx0Vh55RzX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10840 invoked by uid 109); 6 Jun 2024 08:05:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:05:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6506 invoked by uid 111); 6 Jun 2024 08:05:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:05:50 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:05:52 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ci: let pedantic job compile with -Og
Message-ID: <20240606080552.GA658959@coredump.intra.peff.net>
References: <cover.1717655210.git.ps@pks.im>
 <351dec4a4d5a5619e7627e11a8e674e32125125e.1717655210.git.ps@pks.im>
 <20240606065236.GA646308@coredump.intra.peff.net>
 <ZmFoRPd52iqxbOTJ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmFoRPd52iqxbOTJ@tanuki>

On Thu, Jun 06, 2024 at 09:41:56AM +0200, Patrick Steinhardt wrote:

> > If we want to get coverage of -Og, I'd suggest doing it in a job that is
> > otherwise overlapping with another (maybe linux-TEST-vars, which I think
> > is otherwise a duplicate build?).
> 
> I don't think linux-TEST-vars would be a good candidate for this because
> it uses Ubuntu 20.04. Ideally, we'd want to have a test run with an
> up-to-date version of Ubuntu so that we also get a recent version of the
> compiler toolchain.

Oof, yeah, I agree that if the point is to find obscure warnings, newer
is going to be better.

> I kind of wonder whether we should revamp this pedantic job in the first
> place. The consequence of that job is that our codebase needs to be
> compile cleanly with `-Wpedantic`. So if that is a requirement anyway,
> why don't we run all jobs with `DEVOPTS=pedantic` and just drop this job
> altogether? This may surface some additional warnings on platforms where
> we currently don't set that, but is that a bad thing?

Yeah, if we always compile cleanly with pedantic, then I don't see why
it wouldn't just be the default for DEVELOPER=1. The point of that flag
is to be as picky as possible so that we catch things early. If some
platform can't handle it (let's imagine Windows or something), then I
think we should be explicitly _disabling_ pedantic there.

> The only downside I can think of is that we stop compiling on Fedora,
> which may have a more up-to-date GCC version than Ubuntu. But if the
> goal of this job was to _really_ get an up-to-date compiler toolchain,
> then we should rather pick a rolling release distro like Arch. Otherwise
> I find this to be of dubious benefit.

There may be some value in general in compiling on multiple distros, as
a sort of "unknown unknowns" thing. We don't know what we might turn up,
but exposing ourselves to more variables may lead to catching failures
before users see them.

I don't know if Fedora was specifically chosen for recent gcc there, or
if it was simply for variety.

Once again, these overlapping variables within various jobs make it hard
to reason about (but I don't propose normalizing all of them; that would
increase the amount of CPU work by a lot; I am just grumbling).

But yeah, between Arch and Fedora, I don't have an opinion. Doing both
might even be valuable, if we are shoving random variations into random
jobs. ;)

> If we merge it into the other jobs, then I'd just pick any random job
> that uses "ubuntu:latest" like "linux-gcc-default" to compile with
> `-Og`.

That would be OK with me. I also think it would be OK to do nothing for
now. We saw one case where "-Og" found a warning that "-O2" didn't. We
could wait to see if it happens twice before acting. I dunno.

-Peff
