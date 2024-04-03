Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC6BE4D
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175548; cv=none; b=T6XQKDjDQ2e5TNDecOEOlkShUrPmUSRkgkgqcfp71RY6TytLc8pRdk1Z3FzK1IYNJugLrFoySx2IP0ToE3+9tgEwYl7C2Nv/M+jPgrnLaKRk48ESPDAL4PaYjitN9H4BkSdeVIhKQOuhW6Lt0p8uQWe2Cs+VsDs/rZoQ1ylHelo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175548; c=relaxed/simple;
	bh=eFFRpJoe+uow1YB1yrde21gnOaAeLiuD/Xk4i5Y/uTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGReIIKooGLDKyGY6irGdYURb7Gtc8zGqJAMHKQT7mjyH38xb5bTT0Buu/punoQWgSqeG1cZQ7yzJG6L3pabl12KkVnIOKMSRupJ6HP4SeMsmY6Z+bHzDMDkUNcL3cnnkpjFANk6EEOgQOBoH3z7k3+JAOP1CvcUVQrr77r0GM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26588 invoked by uid 109); 3 Apr 2024 20:19:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 20:19:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11403 invoked by uid 111); 3 Apr 2024 20:19:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Apr 2024 16:19:01 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Apr 2024 16:18:58 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http: reset POSTFIELDSIZE when clearing curl handle
Message-ID: <20240403201858.GA1949464@coredump.intra.peff.net>
References: <20240402200254.GA874754@coredump.intra.peff.net>
 <20240402200517.GA875182@coredump.intra.peff.net>
 <Zgz3nvMLg4ts2rRI@tanuki>
 <Zgz4fTJg2iL07W_h@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zgz4fTJg2iL07W_h@tanuki>

On Wed, Apr 03, 2024 at 08:34:37AM +0200, Patrick Steinhardt wrote:

> > Can't we refactor this code to instead use `curl_easy_reset()`? That
> > function already resets most of the data we want to reset and would also
> > end up setting `POSFIELDSIZE = -1` via `Curl_init_userdefined()`. So
> > wouldn't the following be a more sensible fix?
> [...]
> Oh well, the answer is "no", or at least not as easily as this, as the
> failing tests tell us. I guess it resets more data than we actually want
> it to reset, but I didn't dig any deeper than that.

Yeah. The curl setup is really in two parts:

  1. we make a handle in get_curl_handle(), which also sets up a bunch
     of options. We use that to make a single "curl_default" handle, and
     then when we want a new handle we curl_easy_duphandle() that

  2. when we want to make a request we call get_active_slot(), which
     will either return an already-used handle or duphandle() a new one.
     And then reset some options, but also do some more setup.

Your patch touches spot (2), so it's erasing all of the setup done in
(1). I don't think there's a way to say "go back to state when we called
duphandle(), but keep reusing connections, etc".

Possibly it could be solved by pushing all of the setup from (1) into
(2). Though that would probably require separating out some config
handling, etc, from the actual curl_easy_setopt() calls (we wouldn't
want to complain about invalid config for _every_ request, for example,
just once per program run).

This is all also a bit more complicated than it needs to be for
smart-http. The dumb-http code may want to have several handles going at
once to do individual object/pack downloads. Whereas for smart http, we
really are only working with one handle, and doing one request at a
time. I don't know if we'll ever drop dumb-http support, but there would
probably be a lot of cleanup possibilities if we did.

-Peff
