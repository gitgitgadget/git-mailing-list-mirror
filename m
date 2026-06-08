Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCD33D6DD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780960341; cv=none; b=PDCLx00K3hq5VkYXRhHVP0I3sUioMW7CCHgRbsFtyWDVwmHi+V1QYpIsbiZqJbLF3OECg3hPnE/5tJsB/vJeiBjHan/DM90HILHS91IVDMjQf5ezpByWyzGulTZcEng9acSl/e42MKH/lcZPcHRYBra0T1L797bddlYyG8GCSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780960341; c=relaxed/simple;
	bh=TT9JXkzAlr19EH+KLcHRQtoPQGJKjJtuzTpNG+WWIpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6mOoVn6+rKXWSsmvDtOodONn60NewYheUvj24upHVgllkLnfYK06hXFssMVHo807i0PlNrtbAEc/ChJ/7JuNFqeZ5hmzKRsgo5gZDWOZ79aMUUP3usNFjGcqbcBVdQUl6dIB1p7q0D5aWolD/aoCY1kJasyzyj6KKvA8onjP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Pw1nSE3I; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Pw1nSE3I"
Received: (qmail 83650 invoked by uid 106); 8 Jun 2026 23:12:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TT9JXkzAlr19EH+KLcHRQtoPQGJKjJtuzTpNG+WWIpM=; b=Pw1nSE3IuD3QvAgwZ0buUtXqZ6ceIQ/hiuYYYxfAD0JjdYXajscUBEuO5Md3crP1z3jd95X65XB+IwaDup4q+pBA1gcM5O4DsixT/fC4XKJSm3+5JC58Qz87gfgJsqalHOaYOISwDrw0upMUkkgb/3rdP+kA6TXd6t2mIqRW8dCyzmsVJ3p9RUAfLwLFrmCdsFyqb4Oy6kvXGc6BG+Po+bC7VTfBN3sy42NkRLTZeiVqBW/R7RWJbrFz7XyKp2J9vzNzFKVBD00IykO2qSCskygQMsyMZYVJ/ygJC1n0MFpJBV8IlirDrkSV1xpf4JqCd/6MECnh3aC1/6cBLE/xbg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jun 2026 23:12:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 244557 invoked by uid 111); 8 Jun 2026 23:12:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 19:12:21 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 19:12:18 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: limiting git branch --contains
Message-ID: <20260608231218.GD340696@coredump.intra.peff.net>
References: <20230324191009.GA536967@coredump.intra.peff.net>
 <20260527070510.3510836-1-krka@spotify.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527070510.3510836-1-krka@spotify.com>

On Wed, May 27, 2026 at 09:05:09AM +0200, Kristofer Karlsson wrote:

> With generation numbers (commit-graph), the cached algorithm is
> strictly at least as good as the uncached one. Both have the same
> walk floor -- the generation cutoff in contains_tag_algo is equivalent
> to the STALE boundary in paint_down_to_common. The cache then provides
> a pure win: O(total unique commits) instead of O(N * commits per ref).
> 
> In my benchmarks, the improvement is significant and scales with the
> number of refs and the depth of the target commit:

Yeah, I think this is worth pursuing. Looks like somebody else also
generated a similar patch recently:

  https://lore.kernel.org/git/20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com/

But I think the approach in this thread (to use depth-first only when we
have generation numbers) makes more sense.

I cc'd you on that thread.

-Peff
