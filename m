Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3819E7F4
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273364; cv=none; b=PIM1O/F7a47oOPjGmHwbAz2tcVW4i6NtDNY45tgN25gW+q8898ksvsMZM5X/kYr7nWz8KI+ivuFRgZujVGCfHA6CIFpXPY3ySYyVOirbKQXFW9K03BRBH6zB4/YHtXoURFaU2LJdkv1XQ5SSGrdHLpnkVHe1/F0lgB3btwptWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273364; c=relaxed/simple;
	bh=tFWvU5kpgPaDgJJRza4X+c3SitM7/ZTDcTU1bYO9PTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3RjsYl7xaKA5P2WPtGyEJLmY/4N1sHSa0gGNf3EhY31ULowVeulhhRNmLSqbgntUJw1Ug4DIG7jjerHDBrAcKWb39uwzmEGEc7pS0zGw/LvuCLC3LBKOgvW9vkGrGd+dLqg8ZmRyj/PE21+68mj62XtV71Qyb/HJBAarvV3Fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4599 invoked by uid 109); 24 Jun 2024 23:56:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Jun 2024 23:56:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6252 invoked by uid 111); 24 Jun 2024 23:55:58 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Jun 2024 19:55:58 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Jun 2024 19:55:57 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randall S. Becker" <the.n.e.key@gmail.com>, git@vger.kernel.org,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
Message-ID: <20240624235557.GA2727@coredump.intra.peff.net>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
 <xmqqed8me36c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqed8me36c.fsf@gitster.g>

On Mon, Jun 24, 2024 at 09:06:03AM -0700, Junio C Hamano wrote:

> > Wouldn't calling `curl_version()` make more sense here?
> 
> I wouldn't give that question an outright "no", but unless "git
> version" is split out of the builtin suite of commands and made into
> a standalone binary, I would *not* be able to give an unconditional
> "yes".
> 
> For now, let's stop at the simplest solution---if the library
> project gives us a CPP macro to use for _this exact purpose_, let's
> take the offer.

Here's another point of view: libcurl is not a dependency of the git
binary at all! It is a dependency of the "curl" remote helper. Would it
make sense for "git remote-https --build-options" to exist?

I'm not sure. It resolves the linking problem and matches how the actual
programs are structured. But it is also not something that normal users
would tend to think about (even if you are having trouble with https
remotes, you might not know that is implemented as a remote helper).

But we could also have "git version --build-options" call "remote-https
--build-options" automatically, and just let it dump to the shared
stdout stream.

-Peff
