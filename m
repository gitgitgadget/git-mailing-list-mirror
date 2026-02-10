Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE16A32E12E
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770709819; cv=none; b=r9kCl0dwrakrFeI4k/VPgEWEmyohSyBmBXQP9Q14y1qW0WG9/+f3A4r3t/sqdle8RnI+Q2oNtFpw2XFNGNePVipit7j7a1fnTs/TWgWAo62GecS7M1oZsNpPqQ9zQYwxFwfHmdFJQ4cMKqipeSAJxCP/ZutRIvQo86dKNSqP2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770709819; c=relaxed/simple;
	bh=/L2Ifras8+qC9zMYmAieGafZPqbxaU52SqiFwe3r4oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB8669TKrx4ySEXk+ENXpMrKA/hfkn6OdxcLD/innNUFTD0RFwvPu2i6POCvByiNk36BLDJoIwiF+tl/WemojAmT9egYVfmTNJQWeG3q5ONNsMzNz0scxK1xtlcZ9pyzncq2Seu2NJKrRxSVeDr5KIhoJ8g11FZaWtF55Hc5mzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fFipMX2W; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fFipMX2W"
Received: (qmail 353606 invoked by uid 109); 10 Feb 2026 07:50:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/L2Ifras8+qC9zMYmAieGafZPqbxaU52SqiFwe3r4oU=; b=fFipMX2WlpXb5Hks/WJUk5S83W2HJ2WaF0kYDB38RXjkWUicFvQKNtsbrXLNhCdELJouQadcxyZo/TcidygIZK0YdQEIBOAkoz7jjYTcF6SVaD5o4w1FQIEGK38YW+LTn1ONM/XEbdbUN7uKXjjgG9myNDryjCjvxsqaG7TWGEK9zjXESSHkLaNiBLAyYGWHvCwPSHPWeYw9WB7zbqYxK6y9KZ39WxWKtK8C4W9wvl6sKqwpna5L3AQjGkcs0a2unxvubQ3KsrWM3r0mCmxDXg4fVWlxFx1jP0nINpTzWhBZh7/GdK6aOv0kOXS96qa4YIM9FyM+JCcGhkj8ZcylwA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 07:50:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 698453 invoked by uid 111); 10 Feb 2026 07:50:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 02:50:22 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 02:50:17 -0500
From: Jeff King <peff@peff.net>
To: Tyler Breisacher <matrixfrog@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git fetch --dry-run can modify the repo
Message-ID: <20260210075017.GF1756549@coredump.intra.peff.net>
References: <CAGf4dO6QQ+ZG0iWqOY4StM-_UfmH2rZsBjFUcv0ziK5qvbkTHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGf4dO6QQ+ZG0iWqOY4StM-_UfmH2rZsBjFUcv0ziK5qvbkTHg@mail.gmail.com>

On Mon, Feb 09, 2026 at 09:33:33PM -0800, Tyler Breisacher wrote:

> Interesting bug we came across -- or at least I think it's a bug. In
> any git repo that is not a shallow clone:
> 
> $ cat .git/shallow # "No such file or directory"
> $ git fetch --depth=1 --dry-run
> $ cat .git/shallow # Prints a git sha
> 
> I would think no command should make any changes to the local repo if
> --dry-run is passed.

Here's a related thread with some more discussion:

  https://lore.kernel.org/git/CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com/

This is intended-ish, as --dry-run does still transfer objects, but just
avoids updating any refs. And if we have shallow'd objects, we have to
mark them as such (otherwise they appear corrupted).

There's some discussion in the thread above about whether a truly "dry"
fetch would be a good idea. But short of that, probably the
documentation could stand to be updated.

-Peff
