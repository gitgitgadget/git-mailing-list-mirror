Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907D49620
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594845; cv=none; b=d2jFYSbmBnHWUqPoVQUlwWLygGsXwBFin05uEb25Mf0O2FGoVivS3kw5zo5aljUWuyWdK7uK/L5/uM151PEL8+eEbS6/E3lN7yPWrTx73p7j/cCm0HChlg42VCDI9LxoQQI6o/cxrJn9cSbBSvlBYv05fSo+gKrwM7BEc7rWf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594845; c=relaxed/simple;
	bh=LL2Xuk9JANLLKVsPpoAYW66i05+FAhyMm/bBx144Tc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzNCzlaG1lJUbF2u03yHFvgJ+JYSJl0gZ4xhiAMbA1otvTV/u9oGf4a/I/COnTfgWjO0Nlm+REeeJOTu2N7tNBp5vI5zpAc92DW/LHwY/8KDpUVMp2IUeJ+p9D/GOKqHfjyicQPhXlZa6wuM5HkYUQ+ah7ZwkhbEWBVepMbvbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15286 invoked by uid 109); 6 Sep 2024 03:54:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 03:54:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16424 invoked by uid 111); 6 Sep 2024 03:54:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 23:54:02 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 23:54:01 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] drop trailing newline from warning/error/die messages
Message-ID: <20240906035401.GA4168449@coredump.intra.peff.net>
References: <20240905085149.GA2340826@coredump.intra.peff.net>
 <ZtmOsjjcMZ4nEsQN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtmOsjjcMZ4nEsQN@pks.im>

On Thu, Sep 05, 2024 at 12:57:54PM +0200, Patrick Steinhardt wrote:

> > I just happened to notice one of these, so I grepped for more.
> 
> Do we maybe want to add a script that detects these via a Coccinelle
> script? As it turns out, Coccinelle has an embedded Python interpreter
> that allow us to extend it with arbitrary checks. So the following
> script would check for trailing newlines in `die()`, `die_errno()`,
> `error()` and `warning()`:

If you want to pursue this, I certainly have no objection, but
personally I have burned enough time trying to make Coccinelle work that
I don't want to fall down that particular rabbit hole again. ;)

I think long ago we tried to avoid using the embedded python, because
not all builds had it (notably Debian's). But I think that may not be
the case anymore.

If you did want to do automated quality checks of error messages, there
are probably a few other common pitfalls we could detect (like ending with
a full stop ".", and starting with a capital).

>     unpack-trees.c:408: trailing newline in "the following paths have collided (e.g. case-sensitive paths\n" "on a case-insensitive filesystem) and only one from the same\n" "colliding group is in the working tree:\n"
> 
> The last three lines are a bit of a false positive, I think. All of
> these calls are `warning()` messages though, so we could potentially
> just drop those conversions.

Yeah, mine didn't find those because it looked for "warning(" on the
same source code line as the trailing newline. Which is sort of sloppy,
but also kind of works because any message long enough to require
multiple lines probably meant the author knew what they were doing. :)

-Peff
