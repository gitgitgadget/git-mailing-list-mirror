Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4182AF00
	for <git@vger.kernel.org>; Fri, 29 May 2026 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032768; cv=none; b=GZen8s1rDd2ehOmgG7qQ8X70HsTkpK4HlGgTrZKEjy+D38qLoqt9XK+ygKtBEWhxI/FIZvF7Cx62qWDHcnYGvm+xxZI2xqbrbWlWUKvGsAZ28cfuP4YyXKsIvF7Nqz95kVjYVbqoI9xr0Iaq1mh6zAtu/cNFJXwb8eVXq+YGrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032768; c=relaxed/simple;
	bh=hDJ5dxqx/QD/uuINehRtYZfJnuMedf/629ulrncZUSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK2zKlBguS0836+jsbF7wRP7nemCZzySHRG48Alx7YJX6pW5veRb0rvATBVseTklg42wOKlBqK0Mna0lylybuX6dgXxskwmbtSvJh1iC1A9UfiwF3SPLzGWC2BKHZT7mr7pvzTcOZWbslWzkPhpc8T59NyDBrAPj1MVHIgUkNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G7YbnlCb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G7YbnlCb"
Received: (qmail 3831 invoked by uid 106); 29 May 2026 05:32:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hDJ5dxqx/QD/uuINehRtYZfJnuMedf/629ulrncZUSk=; b=G7YbnlCbDS6wjbZfuN1On0WoXR0l0sTelnu1IMBZHXbIm9pENdGT8qpOBtNUfQIXGd74GND2Tix+1g2YxsgwaIyJqxLyjZYnQfylHDwIvxi6BIw2Ypnolfb/bDBOTdeCXd5qyA3ypf7KBOw8/3QMBIsBNgAHMz+FwpbfLTnqBuXzPyOSXSbrQkOaiGViTJ6rod1aUfuxOdERPXo5RKtRp433daZNVZTORdr3/jvnLRp6LWKjn8XleZF1eVAHmFEhH55K1aTnyPM2OZXHp+cInbwNcOqZYhA24tZ3nyQ88sMI6iG680oXFTXK1LBAYyziKh4o0JMbpUU38YkVo4uEbw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 05:32:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7199 invoked by uid 111); 29 May 2026 05:32:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 01:32:49 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 01:32:45 -0400
From: Jeff King <peff@peff.net>
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	fox <fox.gbr@townlong-yak.com>
Subject: Re: [PATCH] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <20260529053245.GB1099450@coredump.intra.peff.net>
References: <agx5tblaCZNsYEBq@lorenzo-VM>
 <20260519191743.GA2269222@coredump.intra.peff.net>
 <aheY6bLM2gxtMDdr@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aheY6bLM2gxtMDdr@lorenzo-VM>

On Thu, May 28, 2026 at 03:22:49AM +0200, Lorenzo Pegorari wrote:

> > So I _think_ we could get away with dropping the existing unlink() call
> > and just let it get cleaned up at process exit. But if we are going to
> > keep it, do we want to also unlink() in this error path? At which point
> > it might make more sense to have an "out" label to consolidate all of
> > this cleanup.
> > 
> > If we are going to unlink() here it may also make sense to just return
> > the tempfile struct from fetch_pack_index(), and then we can call
> > delete_tempfile() on it. See the in-code comment in 63aca3f7f1 which
> > mentions this hackery.
> > 
> > So I dunno. I think your patch is doing the right thing as-is, but it
> > may be worth taking a moment to clean this up a bit further.
> 
> The `unlink()` indeed is weird. Pointing me to the commit 63aca3f7f1
> really helped me understand how the code changed and the current
> situation. Thanks a lot for that.
> 
> I've tried testing as thoroughly as possible whether removing the
> `unlink()` function call wouldn't change the expected behavior.
> *I think* that it can be removed safely, but I'm not 100% sure yet.

I think the only behavior difference in removing the unlink() is whether
we immediately delete the downloaded packfile on error, or if we wait
until process exit. From the perspective of somebody calling git-fetch,
the outcome is roughly the same (when the process ends, the file is
gone). It would only differ if the system crashed before the process
ended.

-Peff
