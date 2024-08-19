Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7316190B
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063168; cv=none; b=n8Zkc1rD6ZGgHzwBZzMswPnV1DIG3QAH2F+qnRPpicodWnqLB9HCQN4jnBHDceRaxO23wog8l2fmm+TF20hVfel5/bl+2fUhjFri8G4XM0mpL1I2hGTTo8GDHjq9usvRek5uV06SV0O3ckgUUIao4N1rxPJwPrUDvR2nLHZoS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063168; c=relaxed/simple;
	bh=h0RiNHJlYltcDUAtteV4tWURjZK7UaXobcoZUTWBOfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh4qyzPNaw282GERseRaomY7JAcEj57E5gy43Vomp75+TtCjrHOoLAPHjbjOOnI/JbBNisuS/2Oij9Nj6qw7LxnIAE6ivlxaFqhsJCr+5EYuMc4SckoanhiR5CAu/z8IjdcNC8YuIjEColgOhUTamd2lXfsH4AzaogbgB26n6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9318 invoked by uid 109); 19 Aug 2024 10:26:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Aug 2024 10:26:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19076 invoked by uid 111); 19 Aug 2024 10:26:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Aug 2024 06:26:08 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Aug 2024 06:26:02 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/maintenance: fix loose objects task emitting
 pack hash
Message-ID: <20240819102602.GA2961332@coredump.intra.peff.net>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
 <20240819085522.GD2955268@coredump.intra.peff.net>
 <ZsMLZ3Tlhxsg6Qdr@tanuki>
 <20240819091715.GB2958552@coredump.intra.peff.net>
 <ZsMPqEWVOSLOi39o@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsMPqEWVOSLOi39o@tanuki>

On Mon, Aug 19, 2024 at 11:26:06AM +0200, Patrick Steinhardt wrote:

> > Am I misreading the documentation? The entry for maintenance.autoDetach
> > on 'next' says:
> > 
> >   If unset, the value of `gc.autoDetach` is used as a fallback. Defaults
> >   to true if both are unset, meaning that the maintenance process will
> >   detach.
> 
> You've omitted the important part:
> 
> 	Many Git commands trigger automatic maintenance after they have
> 	written data into the repository. This boolean config option
> 	controls whether this automatic maintenance shall happen in the
> 	foreground or whether the maintenance process shall detach and
> 	continue to run in the background.
> 
> The `maintenance.autoDetach` setting only impacts auto-maintentance as
> run via `run_auto_maintenance()`. The `--auto` flag is somewhat
> orthogonal: it asks the git-maintenance(1) job to do nothing in case the
> repository is already optimal.

Ah. I naively assumed that they did so by passing the "--auto" flag. But
I see now that the caller actually checks the config and passes
"--detach" or not.

That seems kind of unfriendly to scripted porcelains which want to
invoke it, since they have to reimplement that logic. The idea of "git
gc --auto" was that it provided a single API for scripts to invoke,
including respecting the user's config. Now that "maintenance --auto"
has taken that over, I'd have expected it to do the same.

To be clear, I don't feel all that strongly about it, but I'm not sure I
buy the argument that it is orthogonal, or that here:

> For git-gc(1) we indeed did tie the `--auto` flag to backgrounding,
> which is somewhat nonsensical. There are usecases where you may want to
> pass `--auto`, but still have it run in the foreground. That's why we
> handle this differently for git-maintenance(1), which requires you to
> pass an explicit `--detach` flag.

we couldn't just patch "--no-detach" for cases where you want to be sure
it is in the foreground.

> Also, we cannot change the behaviour of git-maintenance(1) retroactively
> to make `--auto` detach. While it already essentially did detach for
> git-gc(1), that was a bug. E.g. when running as part of the scheduler,
> we'd always have detached and thus ended up with a bunch of concurrent
> git-gc(1) processes. So even though it does make sense for the scheduler
> to use `--auto`, it wouldn't want the process to detach.

Backwards compatibility is a more compelling argument here, if we've had
"maintenance --auto" that didn't ever detach (though it sounds like it
did, via gc, anyway). But yes, one kicked off from a scheduler should be
using --no-detach, I'd think.

Like I said, I don't feel strongly enough to work on any changes here.
I'd hoped to never think about repository maintenance ever again. So you
can take these as just impressions of a (relatively) clueful user seeing
it for the first time. ;)

-Peff
