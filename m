Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B8385D9E
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594922; cv=none; b=AFPP6rR7LI9nuHIhcRUH1ZvdR72tuA0+/O/HIMzjS/UCPCfC6ff+2D8fiD0JwzjKFCGM5/6kPEJgbn+b5jjFalK5Sk1zMISzwCzvKwU2nRg6l1e92lTHimlOiUh5sZDzOV9/ao778RmAZv7Qo20h1NKSB1mBwsWTos5VW/UewwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594922; c=relaxed/simple;
	bh=aS0is/Nmrww5otazAZX4mMvVbrq+P1Uc//C19K87OO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIv8h1US2ut197zibiricUmwrqow3sLgyfR8MWqMwVs5tGcroeZnmXflQctMqeddHA7ZgFkUpVftqhzQAQz2aj4XoBme2ePxfTNgUeG3KAJD/4ugZ6EId8ek8C+njedcrlyK8TKaBmrqk3mrvZD8cntIM9is3uYSeanW7bivbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DusidyeL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DusidyeL"
Received: (qmail 9873 invoked by uid 106); 1 Aug 2026 14:35:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aS0is/Nmrww5otazAZX4mMvVbrq+P1Uc//C19K87OO8=; b=DusidyeLFiPD1nwUTg6xI7P24rTIOlSorYZaLifmvZvabOIqI9H0zO31I13V59sDti1N32+zDfUXNeKKB3xdtawcAHQRnXLjAvtv1K1LJF79lrL/V5j8IqgC9xcXBGB58ssC3oCKNpYvZMsFQ5g+uPJkMK1hUlE/2Wkgcv3pn0a+CX3zrItxzuuaP6Cp28EA0IOd2c9dDyE5wzxiRiJnZN4I7gEEx8WxyB5LNNL2dperRJ3vUFT/KFWsUMYrEcQwKmEaMz92edOJ+ni4An5Id1wX+h3alYU26QnSlVetO867snOM0kAkKEjACNkTXGfktfI6Cj03BVIiLsXcTN8BLA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2026 14:35:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17637 invoked by uid 111); 1 Aug 2026 14:35:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Aug 2026 10:35:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 1 Aug 2026 10:35:13 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] hex: make hex_to_bytes accept kind of hex to use
Message-ID: <20260801143513.GE2041176@coredump.intra.peff.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-4-sandals@crustytoothpaste.net>
 <xmqqzez7hamu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzez7hamu.fsf@gitster.g>

On Fri, Jul 31, 2026 at 12:38:17AM -0700, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > -int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
> > +int hex_to_bytes(unsigned char *binary, const char *hex, size_t len, enum hexkind kind)
> >  {
> >  	for (; len; len--, hex += 2) {
> > -		unsigned int val = (hexval(hex[0], HEX_KIND_MIXED) << 4) | hexval(hex[1], HEX_KIND_MIXED);
> > +		unsigned int val = (hexval(hex[0], kind) << 4) | hexval(hex[1], kind);
> >  
> >  		if (val & ~0xff)
> >  			return -1;
> 
> It depends on how big 'len' would be to matter, but if we are
> looping for a long stretch, choosing which one of the two hexval
> tables to use outside the loop and using that inside may of course
> be more performant.
> 
> I wondered how ugly such a restructure of the API would look like,
> and it does not look _too_ bad.
> 
> 	void *hextable = hex_table(HEX_KIND_MIXED);
> 
> 	for (; len; len--, hex += 2) {
> 		unsigned int val =
> 			(hexval(hex[0], hextable) << 4) | hexval(hex[1], hextable);
> 		...
> 	}
> 
> The true type of hextable would be "signed char [256]", but the
> callers of the hexval() function do not need to know it, hence I
> chose "void *" here.

I had the same thought when reading this, but I wondered if the compiler
might be able to hoist the comparison out of the loop itself (because
hexval() it inlined anyway). It doesn't seem to do so, though (at least
with gcc-15). It loads both table addresses into registers, but there's
still a branch in the loop to decide which table to use.

So in theory this kind of manual hoisting could help.  Might not be that
big a deal with branch prediction, though.

-Peff
