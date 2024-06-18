Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61715E5B0
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735065; cv=none; b=HQLA1kDwUyXOrEjr8BcylCaR7JFGdDwiGwdOXzUIK/YDZAtZsrRIi5O1RdfgS0/ayHDWEccBhDSCdgnqnP3MxkDX8fJcXGrBeM3WW05blPl2O4QtKguBwT0DWHo6KmCb5UySPcdNmk1vmYuzPtFaiv0i7Ar/4LHkuw796hzXEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735065; c=relaxed/simple;
	bh=aN7Kj0pwgWBSyMrg13mvxYMYr7qv+iiQT1rmK3SAEGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klSI79BfD+ExZXJ7bN53t1CqtpB0Xm1/I9J+gNX9O4myNNPrPU/2Gy56cD07ctZlHrbRkBSe6xogsW/OHt1rbPsfDMPwuWJxPs+GYW/bcGtcNonCTXVFXobWnrXi1ShcYxWDrbG/kxR64mhhtRYrQy0ha1rV2Wn3QHVCUOJpoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1278 invoked by uid 109); 18 Jun 2024 18:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Jun 2024 18:24:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13299 invoked by uid 111); 18 Jun 2024 18:24:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Jun 2024 14:24:14 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Jun 2024 14:24:15 -0400
From: Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Devste Devste <devstemail@gmail.com>, git@vger.kernel.org
Subject: Re: Add warning when v0 protocol is used/downgraded
Message-ID: <20240618182415.GA178291@coredump.intra.peff.net>
References: <CANM0SV3CQPRyJCDanB8JFpkAMwuoo-mg3A=_L743_GXJtoFtQA@mail.gmail.com>
 <Zm8EqOfc_v4KBVVK@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zm8EqOfc_v4KBVVK@google.com>

On Sun, Jun 16, 2024 at 03:33:41PM +0000, Jonathan Nieder wrote:

> Specifying protocol version is meant to be backward compatible, and
> there are cases where the old protocol still needs to be used - for
> example, if an SSH server doesn't support transmitting the
> GIT_PROTOCOL environment variable, then having the fallback to v0 is
> still useful there.
> 
> So I'd be concerned that printing the protocol version in the default
> case would be overly disruptive for such cases.  This would be even
> more so for protocol v2 for push, which doesn't exist yet - once it
> exists, it wouldn't be great if all pushes using existing servers
> produced an extra piece of noisy output. :)
> 
> That said, I'm sympathetic to the debugging use case you've described
> here.  Do tools like GIT_TRACE_PACKET, GIT_TRACE2_EVENT, and "git
> bugreport" produce the right information in these scenarios?  Would
> "git fetch -v" (i.e., when the user has explicitly asked git to be
> more verbose) be a good place to provide some additional diagnostic
> output?

You can certainly distinguish v2 with GIT_TRACE_PACKET; the first line
of the v2 response is "version 2". But recognizing v0 as "not v2" is
harder for the layman. Plus it generates a ton of otherwise confusing
output. I do agree that "fetch -v" might be a reasonable spot for this.

> > If
> > protocol.version is not explicitly set or v2
> > and both the local and server git version are >=2.26
> > and the reply is not in v2 protocol format
> 
> Interesting!  We haven't previously used the "agent" field (server
> version) for anything other than logging it verbatim; I'd worry a bit
> about getting into the same kind of mess as User-Agent parsing on the
> web if we go that direction.  But I would expect the main obstacles to
> updating protocol version support to be in (a) reimplementations of
> git protocol rather than the standard git reference implementation and
> (b) plumbing such as httpd and sshd around git, rather than git
> itself.

Yeah, I'd really prefer if we can keep "agent" as purely informative, at
least by default. But having a debug/verbose mode that says "looks like
you should both support v2, but it wasn't used for some reason" seems
reasonable to me.

We don't distinguish right now between the default behavior and
explicitly setting "protocol.version" to "2". We could perhaps take the
latter as a hint to be a bit more chatty about falling back to v0.
 
I do think that v2 isn't going to make that big a difference in many
cases. For most clients the main benefit is the reduced advertisement,
but that's probably only meaningful if the server has a ton of refs
(often refs/changes or refs/pull, since you end up seeing all of "heads"
and "tags" anyway). There are other features (like fetching individual
blobs for partial clones) that some clients might care about, and where
finding the v0/v2 distinction would be valuable for debugging. But
complaining any time we fall back to v0 seems a bit excessive to me.

There may be some error messages we could improve there (e.g., if the
server comes back with "not our ref" and v0 is in use, we might give a
hint that the protocol version is the problem).

-Peff
