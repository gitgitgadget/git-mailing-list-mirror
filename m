Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21A1F4C9C
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 01:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262102; cv=none; b=iFiwB5KDH8D3/RYgv/QENhQvPhKGcuTzwcyUED/YE6PRRmdiNjnus7irQ46G1oFPoii2YW+v6FXEU8nCBFMln09aHo6SRTYkGtS7VHIWoZ4cZL4UoO5yQ8mMMnpqmaBkAEk2Ip2IlJjxhJmI5z1qRj5YwDRznNZuhhK7HWjptCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262102; c=relaxed/simple;
	bh=ok0XHqWeEzrPelDpONxBjX+fZIJiGSa0Z936p55k7tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBmVj5aA4A9wv+HmRBSE2IHKv7Hi6gsQnicCB1xMKfY5jHeSsYOPC5HLSRRkCU4yaZT0PFxVWC0YUYHPa86wPu6M6FNV/7ShHOazhHGZqX8PdxK35vQKKur8CgGnq9Ybrc2f8wb7VQpvSkUPIdmLNuV00+IxGkYZjZu9keJXC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sj4IXQkI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sj4IXQkI"
Received: (qmail 26483 invoked by uid 109); 18 Mar 2025 01:41:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ok0XHqWeEzrPelDpONxBjX+fZIJiGSa0Z936p55k7tM=; b=Sj4IXQkIoFFYOUQYlcN9jKyPOohrbiRjLREJmwV3nREJIF+kjNgCmaM5/ysv1CrZBjmPWqkyWY489FNYG0D0OBkHICBozyqopj+p51SqB3tTT+Nk2Hi2NPnbZY/w/QEiY7eGN/CxYWKXmN74QCswRPI36W99GMKDmxJx3ms1sMcNAN/hVZdwNcdefTXo1CLhDui54oh6ZY6BG/f91QTsh2SSNyNxf8O7KjiOTlL8x1jQKxDCABflDO1/Wb5+Q96qGxpU12KUL4O8ooacNrZBAqVoySowkblgmeplWTrnPR+H5VYKeHpycbgL8yr9u+plwT75NkhWdTgqxDexSiiQdg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 01:41:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3489 invoked by uid 111); 18 Mar 2025 01:41:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 21:41:39 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 21:41:39 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 08/13] pack-bitmap.c: compute disk-usage with
 incremental MIDXs
Message-ID: <20250318014139.GD1471939@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <c1eefeae993f2c8778dd0ec9626f977dbb2011a2.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1eefeae993f2c8778dd0ec9626f977dbb2011a2.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:18:44PM -0400, Taylor Blau wrote:

> In a similar fashion as previous commits, use nth_midxed_pack() instead
> of accessing the MIDX's ->packs array directly to support incremental
> MIDXs.

Probably not worth it to change it in an actual patch, but is it worth
renaming midx->packs to something else to make sure we catch all of the
spots that need to be considered? Or maybe you already did that, which
is how you found all of these. :)

-Peff
