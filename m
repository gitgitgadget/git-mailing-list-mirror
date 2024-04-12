Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF8182C3
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896166; cv=none; b=SFQ957xJV6QCjP1DO05AvzEwmQqC/8OoaJrcQT/sUAyoUQJ8FapEQMZmVNCoWJq/Llmd8khFaT6/CkofD1xtOBwj9DDKjTjq8mxSj23zhZBytq8Avfu8noLQM++poxYY/SwIa7rtwZAdhoE6cZDk3peqAIKUIsv1AopBAeSBvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896166; c=relaxed/simple;
	bh=C8SXvupo1hKWkuDTUOcMjLmeKWy6SRGPPZThgMKjR98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROiOxDZUrEKc1Zy1NkxaNthDRMwI8Lk3AttaFOq7/JdsuJjZ46vM1/+lW/bQ7Q69onZVV1ew+P5/ElOjj1ABi42YNnLEDT3cgV46mbixXHiTgSXDfPgyYoHvXldu244Pm80V7ztGzaigwiNYTbnDDjcVhVW2ez+aH6RRm7zl18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11727 invoked by uid 109); 12 Apr 2024 04:29:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Apr 2024 04:29:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2584 invoked by uid 111); 12 Apr 2024 04:29:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Apr 2024 00:29:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Apr 2024 00:29:22 -0400
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [PATCH v3 6/7] t/Makefile: run unit tests alongside shell tests
Message-ID: <20240412042922.GB1077925@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1708728717.git.steadmon@google.com>
 <cfcc4bd427318fed1cacc8457381d5a0c408460a.1708728717.git.steadmon@google.com>
 <20240327085827.GA846805@coredump.intra.peff.net>
 <ZhgvefDKhTQ6rfnD@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhgvefDKhTQ6rfnD@google.com>

On Thu, Apr 11, 2024 at 11:44:09AM -0700, Josh Steadmon wrote:

> > An earlier step required that runs via "test-tool run-command" have
> > TEST_SHELL_PATH set correctly. So defaulting to /bin/sh here is
> > pointless, I'd think? This is used only for the in-Makefile "prove"
> > invocation, so running individual tests or even a manual "prove" outside
> > of the Makefile (where the user might not have set TEST_SHELL_PATH)
> > would not apply.
> 
> Actually, I think the "manual prove outside of the Makefile" situation
> is worth keeping this. I know I sometimes copy commands from Makefiles
> and run them manually when debugging issues, so it could be annoying for
> folks if we remove the default here.

Hmm, by "manually running prove" I meant running:

  prove t0001-init.sh

and so on. Or even "prove --state=failed" to re-run failed tests. But
neither of those would even use this script, because there's no --exec
option.

But it sounds like you mean literally cutting and pasting the "prove
--exec" line from the Makefile. That seems to me like a weird thing to
want to do, but OK, I'll try not to judge your workflow. ;)

But if you are worried about making debugging more confusing, it seems
like silently defaulting to /bin/sh might make things worse. It is not
necessarily what "make test" did, and complaining loudly might be more
helpful than trying to run with an alternate shell.

I don't feel too strongly about it, though. I'd generally just run
single tests as "./t0001-init.sh", which runs into the same issue. I've
been working on Git long enough that I know it is one of the possible
gotchas when a test failure does not reproduce. :)

-Peff
