Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2F17C2
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094215; cv=none; b=m7beM5tjUSIdPD5Bo5RAru7KsjK2m1/2tAhbqUK9SDoJf/rPSMjrokhahi9kqQ++0nACMssthFrle0sCcnG5jAnnX75oE6ArHhYXxInzi18OISW9zN2zBREycJjsmc/IfCncNE86JOjGpDDoarLI4w0hXVy/YYjSDnHyh3Xcma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094215; c=relaxed/simple;
	bh=7PD6rPDmvEaXhzO+TBruHHnYmww6rGTiClZ9QYJj3CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw24JPX03kaM8mqZRr+Pn9/euVw83bQxZ0VtIykubnzVIdAnd6KJVTPKby4SoLogMoZisWJniSFjQrurLItgQxN2xRD6MOXVD1mTjHpOtkhuBRRM7ygqQYnmvixcfT7tZMFzpy/pwpJhBhvkW6Gg9KbRnBBpDixxw4cUyyHLgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9705 invoked by uid 109); 16 Jul 2024 01:43:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jul 2024 01:43:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4347 invoked by uid 111); 16 Jul 2024 01:43:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Jul 2024 21:43:29 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Jul 2024 21:43:30 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t-strvec: use test_msg()
Message-ID: <20240716014330.GA639947@coredump.intra.peff.net>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
 <20240709113201.GA994226@coredump.intra.peff.net>
 <442b692d-a51b-4f45-a131-a44ac08c431b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <442b692d-a51b-4f45-a131-a44ac08c431b@web.de>

On Sun, Jul 14, 2024 at 12:17:09PM +0200, René Scharfe wrote:

> > Should we be using check_str_loc() in the post-image?
> 
> Yes, and check_uint_loc() and check_pointer_eq_loc() as well.  Which
> would be a pain.  Or we drag everything into the macro check_strvec and
> get the caller's line number for free.

Is it that big of a pain? It's mostly just passing "loc" along to the
relative functions. To me it is more a problem that it is super easy to
forget.

Are the unit tests themselves multi-threaded within a single program?
I'd think not. In which case, I kind of wonder if a simpler pattern
would be to just set a global "location" variable (probably as a stack
of strings) that all of the individual check functions used. And then we
could set it once at the top-level of the test which wants its location
reported, and any helper functions that get called in the middle would
not have to care. And existing check_foo() functions could use the
current file/line location if the stack is empty (so code that isn't
using helper functions can remain unaffected).

-Peff
