Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17898768FD
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216442; cv=none; b=cM1eZwE1e+Kg/GMt3wYRBS+DspAZI4zvv87c2hVGqjKO2ur24pE/5DoxAWmEVNTIhIKVbMEXUjMYQRaS7zpOsIRaB4js04fLfpu1Vc5iuKtKp5LU4j6stQKYr/NMsylx63KcsulraUVhhO5gEKjtRDHIRG2JVe86Y+hA9iafRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216442; c=relaxed/simple;
	bh=GVLQv+QqnKbqw5R2fflJb2K//3pzlMc7Am1b4clmFWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5npwOLFUXj7qy6c7SVrsyIpzPlQByhTBpnkHHho16gsOjO7rKiZjUnuAYjYBJxlWiJkZ+kcFyiB+1/E8COYHF/FFgjFlRLCw1TLoPk0S9bVnIrg2Gj80yOY32BF18MfwXPS8+W61ZNG37KyZpGUoJCcDOvSBlenqCyAOwuCXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15671 invoked by uid 109); 24 Sep 2024 22:20:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:20:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19056 invoked by uid 111); 24 Sep 2024 22:20:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:20:39 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:20:39 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] finalize_object_file(): implement collision check
Message-ID: <20240924222039.GB1148242@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
 <ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>
 <20240924203718.GA586150@coredump.intra.peff.net>
 <ZvM2Lkb0/LPrqizO@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvM2Lkb0/LPrqizO@nand.local>

On Tue, Sep 24, 2024 at 05:59:10PM -0400, Taylor Blau wrote:

> > So the argument I'd make here is more like: this is the wrong place to
> > do it.
> 
> I think that is reasonable, and I agree with your reasoning here. I'm
> happy to reword the commit message if you think doing so would be
> useful, or drop the paragraph entirely if you think it's just confusing.
> 
> Let me know what you think, I'm happy to do whatever here, reroll or not
> :-).

I'm content to let this live in the list archive, but it sounds like
Junio had the same reaction, so it may be worth trying to rework the
commit message a bit.

> >     In general, the use of unpack-objects versus index-pack is up to the
> >     attacker (based on pack size). So I think it would be nice if
> >     unpack-objects did the collision check. Even if the attacker beats
> >     you to writing the object, it would be nice to see "holy crap, there
> >     was a collision" instead of just silently throwing your pushed
> >     object away.
> 
> Right, I agree that unpack-objects definitely should do the collision
> check here. And indeed, that is the case, since that code (which all is
> directly implemented in the builtin) uses the regular
> collision-detecting SHA-1 implementation.

It uses sha1dc, but what I mean by "collision check" is an additional
belt-and-suspenders check. That even once we see an object which
hashes to a particular sha1 which we already have, we'll do the
byte-for-byte comparison. See index-pack's "check_collison".

And that's what I think should be added to unpack-objects (but again,
this is all orthogonal to your series).

> I thought about this when writing it, and came to the conclusion that
> the checks we have for "are we in something that looks like a loose
> object shard?" are sane. That's only because we won't bother reading a
> pack in $GIT_DIR/objects/pack/xx/yy.pack, since we do not read packs
> recursively from the pack sub-directory.
> 
> So I think that the diff you posted below isn't hurting anything, and
> the implementation looks correct to me, but I also don't think it's
> helping anything either as a consequence of the above.

Right, it's purely about future-proofing against a hypothetical change
where we'd be more inclusive (both in what we read, but also in what
we'd ourselves write!).

-Peff
