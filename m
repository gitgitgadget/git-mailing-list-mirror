Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33D26F2A8
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455234; cv=none; b=rupcAMTJN5FPrmupdQeWOisuMe+B3FkYRBXMGwZ/vAZbJ8hUeuOVbKwjtT34zlhj12bFRtL+6Y1YmINm9qVTvzmFMpbS7+d6HKMjUe2ainDlJFd+s6xvaR4Byaw6xMT7IUF8KxcNwzmdM81+bzSo5kVKbN32ZVirG1VmmCPiC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455234; c=relaxed/simple;
	bh=+MVoKl32sagTmnzDLHSyVjzP0Vm6zHH7BaYP8+lThZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOFTCxSW8yrOmnPbQ9e9bNXhILxyCFWaIQyUnCRcslyj8thaCSP/9Dta/42KxM12bGTb2RLM5r+swFMWQ9NTbDGVXL7Js+Giv+QaPnCYAsSKNJ6VWF9IQAqvuAnQUy4OzvqQi1XYroQXc9JOJfwWlm5+MnVLS9YrCOhmpoirQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L9WKX736; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L9WKX736"
Received: (qmail 19313 invoked by uid 109); 18 Nov 2025 08:40:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+MVoKl32sagTmnzDLHSyVjzP0Vm6zHH7BaYP8+lThZA=; b=L9WKX736R6hDEqUgZUBffxw1jZeNriKNXthlGIVdGHsgfBagkQD6up5upFTkScBMMdmCxR8ZzXFy6SXvG9ZatfFNmK6+1ll3Fzlrcs4KIyp22qN56frNsqI7OMNfnKe5lyoqRAGtqtXSh/Id2apwRX+jkyRkan/Ppgn5maDC2WeWFJXh61YMBJX8qK2hC8B2DQqIW03JTguZdENGkX7Xqevw0bjQtTB57+wTbiZZqsyM3gg7Eit+D1hd92a4w2bMDUzwTkWqD35up7fybJT0pM+M+6miDLYosutIhefKGwlm3DZ4Lbd+RNtbDGRTeg8hIAvwRbsGF90D4pvOYW6gBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 08:40:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27073 invoked by uid 111); 18 Nov 2025 08:40:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 03:40:35 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 03:40:30 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>
Subject: Re: [PATCH 4/9] cache-tree: avoid strtol() on non-string buffer
Message-ID: <20251118084030.GB4164207@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080537.GD979063@coredump.intra.peff.net>
 <aRRuzrmbJBW8q4Dd@pks.im>
 <aRVL4iptEeLm/+cs@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRVL4iptEeLm/+cs@nand.local>

On Wed, Nov 12, 2025 at 10:09:22PM -0500, Taylor Blau wrote:

> On Wed, Nov 12, 2025 at 12:26:06PM +0100, Patrick Steinhardt wrote:
> > Hm. I'm not a huge fan of not having any error handling at all. It just
> > feels way too fragile for my taste:
> >
> >   - As you mention we don't detect overflows, as we would detect them at
> >     a later point in time when trying to access index entries at invalid
> >     offsets. But if the input is crafted in a way that the overflow ends
> >     up with a reasonable index entry we might just as well _not_ detect
> >     that an overflow has happened and end up using the wrong index
> >     entry.
> >
> >   - We don't verify that we even have a number in the first place. We'd
> >     simply return "0" in that case and not advance the pointer. This is
> >     fine though as we verify that the returned size is non-zero, so we'd
> >     detect this case.
> >
> > I'd much rather prefer to have an interface similar to `git_parse_int()`
> > and related functions, which are way easier to use compared to the likes
> > of `stroi()`.
> 
> Those git_parse_XYZ() functions all end up calling either
> git_parse_signed() or git_parse_unsigned() under the hood, which bolts
> on our k/m/g suffixes, which we probably don't want here when parsing an
> on-disk format.

It's much worse than that. They are just wrappers around strtoimax(),
etc, themselves. So we cannot use them for a non-string buffer, and have
to start from scratch (see my other reply).

-Peff
