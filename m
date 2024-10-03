Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98292C95
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914904; cv=none; b=ERqLBhoGLTNZKIQexng0XyZTv5ZZbaIE5OViJsNEFxPhSBfud8BhPOkwT824iaL3P3M5WqhxdrJAYfuadMv0pXI3Jou/A8XhTC0UY8Uf27G6WgxvPPINjzeHuMeRFeoZ45EHqjfCK4MONl4FAGkTtWso442zqvxaSUGSFh2D1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914904; c=relaxed/simple;
	bh=OYPR8hJUPMQ9rGr/3NODvc3h7dT9GHu5u20NzX7NmuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjnPWi3N5p0MMogVA4qhG948HgbxhYCtV7pCvq83DzJfVxr2HR2EW1qA/QyQUA8+BVCiX2PmqbWbGtcFh2SeIMOkt1LECJlFtB2Hw9XnH8QbtstZFu6Y/CeQgdxm6USINhvCpZ1PDLaplbD5fiWvvXyQSM5Prfr8Pbr51IjIE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CFkRL54X; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CFkRL54X"
Received: (qmail 10894 invoked by uid 109); 3 Oct 2024 00:21:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OYPR8hJUPMQ9rGr/3NODvc3h7dT9GHu5u20NzX7NmuM=; b=CFkRL54XRIeOL72zk5lf++7zIZZCnMPtwOi58JXxknzbDR7MJwlhTC/wHCsS2mG40vlpaTE5EldwbpX3tHbsmKMx21xkymdJcUkSziiJXMyBa7xAo2lh0TFONDZGRqreje9hqJh4cQfMJGA9l+d1nI2Im7BCSIGslv/crwAy7D3wftK9djh5kGsTaQOq/xRnMJ1mh1ygiWjnJaMBX+MBVA6z1EbaKF24p24illZNPX7WqMXcIlESRYCbxiIfPcyuBsqBrwHp5CXDDMiNOcdQvU4xRFhQ/2gA7Xpv1z910vws763ejZxFdZxT965NI5vTQDUL+stO8M5RyjwlTc8P4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 00:21:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11276 invoked by uid 111); 3 Oct 2024 00:21:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2024 20:21:41 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Oct 2024 20:21:40 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (v2.47 regression)] hash.h: set NEEDS_CLONE_HELPER_UNSAFE
 in fallback mode
Message-ID: <20241003002140.GB3486271@coredump.intra.peff.net>
References: <20241002232618.GA3442753@coredump.intra.peff.net>
 <Zv3huwCNuqi5C8Wm@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zv3huwCNuqi5C8Wm@tapette.crustytoothpaste.net>

On Thu, Oct 03, 2024 at 12:13:47AM +0000, brian m. carlson wrote:

> On 2024-10-02 at 23:26:18, Jeff King wrote:
> > This is a regression in v2.47.0-rc0. As mentioned above, I kind of doubt
> > anybody will hit it in practice (I only did because I was trying to do
> > some timing tests between the fast and dc variants). And it is almost
> > tempting to leave it as a wake-up call for anybody who is still not
> > using a collision-detecting sha1. ;)
> 
> I think this is a fine fix for 2.47.  I have a branch on my remote
> (sha1-dc-only), which I'll send out after it passes CI (probably later
> this week), that removes support for the everything but SHA-1-DC (except
> for the unsafe code).
> 
> I don't think there's a reasonable configuration where people can use
> Git with other SHA-1 code except in extremely limited circumstances we
> shouldn't have to maintain code for.  The code is open source, so people
> who really must have maximum performance with all of the vulnerabilities
> can patch it back in themselves.

Yeah, I feel the same way. I only happened to try this because it was
the easiest way to speed-compare different implementations using
"test-tool sha1". ;)

Possibly that helper could grow an option to use the unsafe variant,
though even that is probably not a high priority.

-Peff
