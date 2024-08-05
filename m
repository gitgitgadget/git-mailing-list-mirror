Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C420D10953
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851236; cv=none; b=rbMewcdCgYds4z2R2m65WVa1WxcLABLHgzLxoAwyX/I+Y1GVfls1GcDG9xNyKwM0RJprN49YZducvzt2ojg+yTtRtf69h/xim8H3Giotn29i/1fUloa3MM0NUi4yqjWkAZzNek2pigIxK8Rxarix4YZp7FmlvX802TD478sD3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851236; c=relaxed/simple;
	bh=TIwQzgGmDY9ZnrllUf5i9V5CU/sCApBYdPf46qkGE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLxOQyJop+7osPf2s3DmvkJ5JGOHnLWsRQ6hVRafe4Yo9aUZysPxMEAzh7T0aEpJh4jIH4yeLeCQZg+DEEADkO2XOYwEnubS2jfUZUmmhXmN0zaSDT08yctkfGYvLO1ieU0eH4+GQbK01qsGRMQu8/F9jP2nLYd3njGg91rcJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26559 invoked by uid 109); 5 Aug 2024 09:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Aug 2024 09:47:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9727 invoked by uid 111); 5 Aug 2024 09:47:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Aug 2024 05:47:15 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 5 Aug 2024 05:47:09 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "W. Michael Petullo" <mike@flyn.org>
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <20240805094709.GA632664@coredump.intra.peff.net>
References: <20240728224807.GA1299337@coredump.intra.peff.net>
 <ZqjQi6i2kiY4gcc1@imp.flyn.org>
 <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
 <xmqqv80m8pha.fsf@gitster.g>
 <ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
 <20240731072832.GB595974@coredump.intra.peff.net>
 <xmqqo76d7coa.fsf@gitster.g>
 <xmqq1q391afc.fsf@gitster.g>
 <20240801061417.GD621899@coredump.intra.peff.net>
 <Zqv9b_B5wKGp331o@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zqv9b_B5wKGp331o@tapette.crustytoothpaste.net>

On Thu, Aug 01, 2024 at 09:26:07PM +0000, brian m. carlson wrote:

> On 2024-08-01 at 06:14:17, Jeff King wrote:
> > ...this is doing that loosening for upload-pack by default. I'm not sure
> > if that is OK or not. My mental model has remained "it is OK to run
> > upload-pack on an untrusted repository", but it would make sense to get
> > input from folks who looked at this in the past, like Dscho, and/or to
> > reassess the threat model from scratch.
> > 
> > In particular I did not follow all of the potential issues with linked
> > local files. Are we good now after other fixes (in which case this patch
> > is OK)? Are we good only for non-local clones (so this patch is OK only
> > combined with a fix for clone to check ownership for --local mode)? Or
> > are there still problems if an attacker controls the repo paths, in
> > which case upload-pack should remain conservative?
> 
> I think we already have such a patch.  In clone, clone_local either has
> option_shared (in which case we simply refer to the other repository via
> an alternates file and don't touch it in any way), or it calls
> copy_or_link_directory, which in turn calls die_upon_dubious_ownership.

Ah, thanks, I didn't realize that. Looks like it comes from 1204e1a824
(builtin/clone: refuse local clones of unsafe repositories, 2024-04-15).
I'm not sure if this is redundant currently; we still run
git-upload-pack even in the --local case, to get the list of refs. So
presumably it would fail on the same ownership check before even getting
to the local copy code.

But regardless, it would not be redundant if we loosen upload-pack. And
it means that my first two questions have the same answer.

The third one (does upload-pack have race problems with an attacker who
owns the repo?) I'm still not sure of.

> One related topic that is potentially interesting as well is whether
> `git bundle create` also offers the same security guarantees as `git
> upload-pack` in that it can be safely run on an untrusted repository.
> Either way, we may want to document that.

I suspect it could be made to give similar guarantees, but I don't think
anybody has ever made a conscious effort. At the very least this isn't
great:

  $ git config pager.bundle 'echo yikes'
  $ git bundle create foo.bundle --all
  yikes

upload-pack doesn't trigger this because the pager setup is tied to
the builtin RUN_SETUP option (arguably it should be made more explicit,
though). I think pack-objects actually exhibits the same problem, but
the pager is only triggered if isatty(1), and that would never be the
case when upload-pack runs it.

-Peff
