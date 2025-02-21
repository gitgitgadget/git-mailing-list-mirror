Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5E1FFC67
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124806; cv=none; b=ZYDp+HjyKZYMQHLtfUfKDjKwnuHU0BxD8aZBPzUIgDifQBfuj5sppelbkalOijZzmzT50uba7i+7H5hxpHmGGF/kc6Wp0Hjm1eCHgRP5ESWaxxDjBkxFNxvg9j1Gw/ZsrUko+LqJV0qAqVZkjv8UAWGlVjgnKLpvmuqwgJqT+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124806; c=relaxed/simple;
	bh=LRl3D7NNx4vsv1XeR7BSlybbBIEqC0acj9Md3iFg584=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHM/zHjpKDx63F0nd06QMaRG67Ph7K3AMDZ2zr484G8EvkzMoZgowxGHNfgo/YZgQFMJ2/+WAUPRv5MMlv6BLct8jwxbkdEOWe2WHU1HHvmehKT1O0LnHdzeFfesnIJYg0ssaEAImLFrWhEHCQKZ9hJ2W/4HPT9p58bITyuyDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LbtZmKFE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LbtZmKFE"
Received: (qmail 3364 invoked by uid 109); 21 Feb 2025 08:00:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LRl3D7NNx4vsv1XeR7BSlybbBIEqC0acj9Md3iFg584=; b=LbtZmKFEwVreh5hd7pekaldD3Ad0DwGsFmggZjHNkYM33Lan5cajU9pADqqXU6ETOvgo9Y4Ertaz+Q3lr1vjPQPggzO3jOSKuw9298ynP/qNsc9GlfMrYsFeYexOIRwIye//pJwC+yCIgP1uj+45Bh15ZWPWk2pdTfWo42HA6XrKYMDm9vRZha5iSqdODP++fIPeG9vOYOFyz+WjlNyxtF8DVj7zXvgFoeVN7aN0e+4vg0MrPrwzpCfDkitw0p9aQBBKm68NNPVcIcZaxXfmrc0fNrnP1E4c8bOoatPDzVO0njKIgQmblFSUNNO3BNamFVXQxGSy2uqMKLdIWPvwFg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Feb 2025 08:00:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31169 invoked by uid 111); 21 Feb 2025 08:00:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2025 03:00:03 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Feb 2025 03:00:03 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Message-ID: <20250221080003.GD1988395@coredump.intra.peff.net>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-2-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219-pks-update-ref-optimization-v2-2-e696e7220b22@pks.im>

On Wed, Feb 19, 2025 at 02:23:29PM +0100, Patrick Steinhardt wrote:

> When reading an object ID via `get_oid_basic()` or any of its related
> functions we perform a check whether the object ID is ambiguous, which
> can be the case when a reference with the same name exists. While the
> check is generally helpful, there are cases where it only adds to the
> runtime overhead without providing much of a benefit.
> 
> Add a new flag that allows us to disable the check. The flag will be
> used in a subsequent commit.

If we are going to switch to this and get rid of the global
warn_on_object_refname_ambiguity flag, I could see it being worth it.

But when I looked into doing that, it did not make much sense (there are
too many code paths that share the same get_oid calls, and you'd have to
plumb the flags through the stack).

So if we are going to leave the global flag anyway, and if your patch 3
is just changing all of update-ref to pass the per-call flag in every
call, why don't we just skip this new mechanism and have update-ref
unset the warn_on_object_refname_ambiguity flag?

That makes patch 3 a one-liner, and patches 1 and 2 can go away.

-Peff

PS Sorry, I haven't looked carefully at the rest of the series. I've
   been moving houses and am way back-logged on Git stuff, so don't
   count on me reviewing it anytime soon.
