Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158B3E51D9
	for <git@vger.kernel.org>; Wed, 27 May 2026 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872631; cv=none; b=nbz1w3uy3T77Azw05KH00dG2zjVYqRlK3Mop5xiiid2X/bByW0piLXWauLAI7VLtBD3gXFQpWZImMosKsajXT3HyrDbg7zt2U6+HXecL3+ZP0b/ciMIvG09mrpWPhFgl5ZNRCIqYysCbIFLOpBZjI5mwsWKdpqK+kBvJXF68SSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872631; c=relaxed/simple;
	bh=22brtlwwsnUc0Jn9HM3QHU/VWf7a+Ys6wnXan5er8Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imrIhhR5tipxuYIAfZ9rg8mvrA1bVI8tgujGy9WpGDFEYBc+ramDmKPei/QQTPZOF+W9tnXALaVKfpo7WiQQKuJEt3UbLdv5NKgWQ1iTe3RW0tlNiWsM9HIHm/T9tlcqI/YlaXYSlAeT10WYeUfaMhc4aIp7jdTUqE/DxoxsiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DepvNmiW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DepvNmiW"
Received: (qmail 28815 invoked by uid 106); 27 May 2026 09:03:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=22brtlwwsnUc0Jn9HM3QHU/VWf7a+Ys6wnXan5er8Eg=; b=DepvNmiW3+1TarF8rVfC5jgchhEMP1fFl6tPVATlgJvsoSUjiKXivHSOXcVUZf7WFcYoQeVbpH6n/bAVa2+fRB3JJjufKrGlrBrLKoLmowm75nYn2iRH0r4kMcLQ2+i7OhNPZsNc2/5Pa9wLQZfBYCSHIgw7W5CEaeXFFqtMYNzk/qhfNMx1lNRTlq0UqE8I4ZyN1nTswjr86bkPkxDEponGUy9DLuGNaD1EwrZGvzbVLNVBmAjm7eQ+YRLZBoEc/6kZ+fPAuSy17wSauwHIjXf8CfOI9cDk1CdMckmQmLY0ym799Pe1OyS1yXo1/Gv0Evnx2PuYRb+II8Ltkpc4Iw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 09:03:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71430 invoked by uid 111); 27 May 2026 09:03:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 05:03:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 05:03:48 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/8] pack-bitmap: check subtree bits before recursing
Message-ID: <20260527090348.GC981444@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <7d6d1cec0dd2706ba176c7fa070da46c98155018.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d6d1cec0dd2706ba176c7fa070da46c98155018.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:39PM -0400, Taylor Blau wrote:

> In the previous commit, we adjusted the callers of `fill_bitmap_tree()`
> to pass in the bit position of the tree they wish to fill.
> 
> This commit makes use of that information at the call site to avoid
> setting up a stack frame for fill_bitmap_tree() entirely whenever a
> tree's bit position is already set.

OK, this one at least has a plausible explanation. ;)

I can reproduce your speedup on linux.git (~5% again). I don't love that
we have to duplicate the logic in each of the callers, but there are
only two sites (and unlikely to ever be more). And it is only one line,
the comment notwithstanding. That seems like a good tradeoff for a
multiple-second speedup.

The patch itself looks obviously correct.

-Peff
