Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32522139F
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264247; cv=none; b=g2PXL2lvh4gDbh/Zhq3zVp70kjHHSR5LKqh8/iNFARhC8ThaAAUv5UgNaYO82xjUJeygLFKlgYpIyVfsv7b/vfe/ggAX4aMtaYFzLpk601CyrazTFyLyWUnOI4uH/qrT2EzcJJ1GZEWish0FwuOFVAzEFJyXZWS/sFnULLqCvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264247; c=relaxed/simple;
	bh=ZWPfy6tZVnrBbR4qDwxopRLH9sjGi+LlmGSmBabi6dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv4J6/anvaZy6df04BA/siHUGgWvTBoz3Hib6f223mMue1G6zL5e27khfcPyIdzUir+3xnbLAE+Kfc5DPgGjNHjIVAymyVE5qjDWOky7sbBAvXITzHN6ZINXiGyA4T2ljDAf6PfYsQhcxerGKjdi1ohy5R4fwASZvmdpEM87L40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12316 invoked by uid 109); 18 Jul 2024 00:57:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jul 2024 00:57:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10894 invoked by uid 111); 18 Jul 2024 00:57:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 20:57:26 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 20:57:23 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <adam@dinwoodie.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.46.0-rc0 test failures on cygwin
Message-ID: <20240718005723.GA675057@coredump.intra.peff.net>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <20240717064241.GF547635@coredump.intra.peff.net>
 <3e6abe6c-2c15-47f9-89e8-3e8710802562@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e6abe6c-2c15-47f9-89e8-3e8710802562@ramsayjones.plus.com>

On Wed, Jul 17, 2024 at 07:05:43PM +0100, Ramsay Jones wrote:

> > This is a shot in the dark, but: could the problem be an open file that
> > cannot be moved? If I run a "ref migrate" on my Linux system in the
> > debugger and stop at move_files(), checking /proc/<pid>/fd shows an open
> > descriptor for .git/ref_migration.WnJ8TS/reftable/tables.list.
> 
> Heh, a very good shot in the dark! ;)

Lucky guess. :) When Junio pointed out that we'd expect Windows to fail
in that case, too, I thought for sure I was just wrong. So I'm glad it
worked out.

> The patch given below fixes the test for me! (I have only run t1460-refs-migrate.sh,
> since the full test-suite takes 6 hours to run, but now all 30 tests pass!)
> 
> I also don't know the code well enough to answer your question regarding
> the re-opening of the migrated ref-store, but it doesn't look like it would
> cause any problems (famous last words).

Thanks for testing. This is new in the upcoming release, but I think
it's localized to the "git ref migrate" command. So aside from the
annoyance of the test failure for you, it is not too urgent. I'm tempted
to put it off until Patrick has had a chance to weigh in, even if it
means missing the v2.46 cutoff.

I'd also be OK with pursuing it in the meantime if folks feel
differently. Having slept on it, I think the answer to one of my
questions here...

> > -	free(new_refs->gitdir);
> > -	new_refs->gitdir = xstrdup(old_refs->gitdir);
> > +	/*
> > +	 * Re-open the now-migrated ref store. I'm not sure if this is strictly
> > +	 * needed or not. Perhaps it would also be a good time to check that
> > +	 * we correctly opened it, it's in the expected format, etc?
> > +	 */
> > +	new_refs = ref_store_init(repo, format, old_refs->gitdir,
> > +				  REF_STORE_ALL_CAPS);
> >  	repo->refs_private = new_refs;
> >  	ref_store_release(old_refs);

...is that we must put _something_ useful into repo->refs_private,
because old_refs is an alias for it that we are freeing. I suspect that
"git ref migrate" does not really look at the repo any more after this
migration function returns, but it makes sense for it to leave things in
a consistent state.

So my biggest question is just whether there is any downside to doing
the release/init pair rather than trying to reuse the existing struct.

I do think it probably causes a small memory leak. The "init" function
allocates the actual ref_store struct, but the "release" function
doesn't seem to free it. So we are probably leaking the store that
points to the temp directory. But that is also true of "old_refs", or of
"new_refs" if we hit an error. So I think the solution is probably for
init/release to be symmetric, and for the latter to clean up everything.
But again, I'd prefer to get input from Patrick there.

-Peff
