Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14164C84
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890339; cv=none; b=aTZGFbN6vVkpJSY7MfeisoqhllxPZzTTK/ix+9I8JWooC2++EfEVr6MOJVr1nGcxjt8pCoKgTKyYgltSD08BNT6q/dLKbTZjn6VYKlHOO858zmsDo+DgXcjsCB5LprzbvgieyltWm1dVWCM49fIfqd4wyUM0UyBb7++HHm1EadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890339; c=relaxed/simple;
	bh=DP/6nYzsKqNX6SoA9e8sdja7vSM78PcBwHU+iRI4SSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSsRofVjkLypCKgKmblrfyLsys/cQ7+4QZOJcW18cWprxpmG99XSH7d0tzc+/qEfeWyF4AoRgS5QWJBlVju0UQHeE0uPOe4nBeB/o/j1Ij+50XHtEZuUslyB99dmHccBWo3BnhbrwXALq6xnxF6e65mmzgM921qRHhuPcBJwanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6038 invoked by uid 109); 25 Jul 2024 06:52:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Jul 2024 06:52:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19239 invoked by uid 111); 25 Jul 2024 06:52:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jul 2024 02:52:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 25 Jul 2024 02:52:14 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Randall S. Becker" <the.n.e.key@gmail.com>, git@vger.kernel.org,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
Message-ID: <20240725065214.GA590196@coredump.intra.peff.net>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
 <xmqqed8me36c.fsf@gitster.g>
 <20240624235557.GA2727@coredump.intra.peff.net>
 <402c12c2-7ada-4d9e-c3da-1a78827e7496@gmx.de>
 <20240724205541.GA557365@coredump.intra.peff.net>
 <8ef819f0-e80a-74ec-274d-fe10991fe992@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ef819f0-e80a-74ec-274d-fe10991fe992@gmx.de>

On Thu, Jul 25, 2024 at 12:17:08AM +0200, Johannes Schindelin wrote:

> All true, but the name `git version` also sets some expectations. Users
> who run `<command> version` will expect to see the version of the command
> they are actually using currently.
> 
> For example, `curl -V` will list something like:
> 
> 	curl 7.81.0 (x86_64-pc-linux-gnu) libcurl/7.81.0 OpenSSL/3.0.2
> 	zlib/1.2.11 brotli/1.0.9 zstd/1.4.8 libidn2/2.3.2 libpsl/0.21.0
> 	(+libidn2/2.3.2) libssh/0.9.6/openssl/zlib nghttp2/1.43.0
> 	librtmp/2.3 OpenLDAP/2.5.18
> 
> Those are the versions of the components that are actually used when
> invoking `curl` commands, not versions that were present on the machine
> that built the `curl` package.
> 
> Compare that to what we're experiencing with Git for Windows v2.46.0-rc2:
> `git version --build-options` lists `libcurl: 8.8.0`. But running `git
> fetch` will actually use libcurl v8.9.0, not v8.8.0. And the output does
> not mention that this is the compile-time version. It lists only one
> version, as if it was the one that the Git executable were using.

Well, yes. The whole point of farming it out to remote-curl was so that
we could show that run-time version, which was what I said in the
message you were responding to. So I think we agree.

I would be fine showing _both_ the run-time and compile-time versions,
if they are clearly marked.

> > So whether that is in the form of "git bugreport --dump", or if all of
> > the collection is moved to "git version --build-info" and then bugreport
> > uses that to fill out its template, I don't care.
> 
> I feel that we may need a different command for that than `bugreport
> --dump`, something that reflects that the user wants to gather data to
> investigate an issue, but not necessarily report a bug to the Git project,
> and that we should guide users to use that command instead of `git
> version` when investigating such issues.
> 
> A command with a name along the lines of `git diagnose`, I'd say.

OK. I don't really care much either way how it is spelled, though my
inclination is that we already have a confusing number of commands and
should avoid adding more.

But my main point was that we have two ways of collecting data now, and
it would be easier for users if they were unified, however the result is
invoked.

-Peff
