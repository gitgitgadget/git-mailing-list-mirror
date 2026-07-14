Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F23EFFC3
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015112; cv=none; b=jhShRvksK+IpVonFKMRZdt/0xL7ncQ+AGeZ3zslpVpJ8VW3DNftFIvoJjZzGtW91jLVNh0yhXhJOn0IgnmenbwYpO9rIfQ6058eZEca9cOczcmT9RwQhxlDfDq+ybdcA58jut29PB2KALOi7xaCIiCeYNfkvPAavlwvIGmlazDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015112; c=relaxed/simple;
	bh=brZnm1yhfxlAPPcYmI74fDOWFz4rTrOAPE4WvD6rN7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8TXYFBcK2PelHJ7FYj8ae/PZBKiGaiRdx+e1tLcvpe/bR748by+dgjluVYCDhUa9Ey3RVrj/pG60hzIEPAb2l9HKGjKWrRDusyYTApsar2wGRcNlURDbe/ymQ1AIEEd47pfZzv9tyxeo9iTwTKCC/GgCpnX3sGqaEYmSbHKNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gSdRiYSo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gSdRiYSo"
Received: (qmail 21908 invoked by uid 106); 14 Jul 2026 07:45:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=brZnm1yhfxlAPPcYmI74fDOWFz4rTrOAPE4WvD6rN7s=; b=gSdRiYSoYpoeW+XLq8K7m1WSn1HbuxfxK7JkBQXQvqCUoFQCGrbrHolpGSA5R3VetqcDg49nCUN9/viGOZiKt4In8RyM6hXZls/FfeA/ytKV4nKswIj5sEwfEFehw7B7IXdZkss5XVJj0qcKob2awDfq28CZmeZ3jNCkHXVOuz0FHojUxubNngTP2/I+XKwEFo5r6epbbgtoluCH3E405O0u7F1m0zFlgqMxpVtuDRFOLkbbrz4+ntLJVndLsfMfnxF2E769xGEL+TnE+gkD0VrZHbRPJueYL3EKRPPbudLisJRpik6WFLWpjlDsEHaw1F0J3KUhXXfsC8aPFZKfGQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 07:45:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 43325 invoked by uid 111); 14 Jul 2026 07:45:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 03:45:11 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 03:45:06 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] send-pack: introduce a `no-ref-delta` capability
Message-ID: <20260714074506.GD4058320@coredump.intra.peff.net>
References: <alQ7U8TOWjhasaWk@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alQ7U8TOWjhasaWk@com-79390>

On Sun, Jul 12, 2026 at 06:11:47PM -0700, Taylor Blau wrote:

> Some 'receive-pack' implementations may wish to retain the incoming pack
> without first building an object ID index, in which case requiring delta
> bases to appear earlier in the same pack makes them easier to locate.

This explanation puzzles me. OK, I can see why you might want to take in
the incoming pack and then sit on it for a bit. But surely you are not
going to update refs without seeing what's in the pack, right? Otherwise
any pushing client can corrupt your repo.

And the only way to know what's in the pack is to index it. At which
point resolving REF_DELTAs is the least of your worries there.

So I have the feeling that there's some ulterior motive, or that this is
part of a larger system, but I don't quite understand what it is. And so
it's hard to say whether this is a sensible approach.

> Bitmap pack reuse is different, since it copies entries directly from
> an existing pack. Under `--no-ref-delta`, it must inspect candidate
> objects individually, omit `REF_DELTA` entries from direct pack reuse,
> and leave them to the normal object-writing path.

Hmm. We wouldn't normally expect verbatim pack-reuse to kick in, since
this is about the client sending to the server. But OK, we certainly
need to make sure that path remains correct.

>  - The final patch advertises and consumes the new `no-ref-delta`
>    capability.

What about thin packs? They'll result in REF_DELTAs on the server once
the pack is completed/indexed. I guess we have the "no-thin" capability,
but I don't think our receive-pack implementation support sending it. I
also wouldn't be terribly surprised if not every client implementation
supports it (it was added in 2013 I think to support libgit2). But I
guess that is also true of your new no-ref-delta; only updated clients
will respect it.

What will/should a server do when they get a ref delta anyway? That
again goes back to the question of: why don't we want ref deltas?

-Peff
