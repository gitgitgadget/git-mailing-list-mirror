Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EB48B36C
	for <git@vger.kernel.org>; Wed, 13 May 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688119; cv=none; b=QpBvB0X9m5PO3nSwxWd2m1DwW+vpPUHtj4Dmc2YVUOiv/V3Jk553wk9PBtSgCiP48pJ9WsTF8Uv7B6f99ffr0grk9XHsNZ1cXZ7mYpoAjEhSsnTo8EQ7CX36Vj84kez6Whe9vHaZfrsDUZoQwnMRxkQv4OXl0TJLoePoQf2X+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688119; c=relaxed/simple;
	bh=evfiaYLoznLEj2vhlkHxJIotl3O1EuQ3yIFCSfPvCxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYDs+zdX58cRHBQ8KqOxyw1vihp5hQNKl2rNslRWs17pHolhahJoyYVfEWYFY3Yu5L40Me47dFVlPUf3k14fl7eed+gfwkwLddWmsgIcMZZrwF9Crn2a71wzAfPlKnf7DbDmoJAxWzCGkusNXqrX2CPU2LJfFwz8cMkHMAktFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZPt/III3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZPt/III3"
Received: (qmail 38941 invoked by uid 106); 13 May 2026 16:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=evfiaYLoznLEj2vhlkHxJIotl3O1EuQ3yIFCSfPvCxg=; b=ZPt/III3gOFYb67f1dOFp+CwGM0GSZV1BTahsBPNjG0Q3PEnwIMZsdkyHqTKc3N4GBMi24BWaDi9u8tj8gdqcjBGMxA4CKCuP9fHahn4PpZqWN9/qUX3S1Z2rJ23mqvUVgiStASpEvozzNiwovzqTsj34Rph0kRdBwhkHWXhoWrIyCD+LSUHadLEJGjWvA4Hgi9aHBGJoppGKD6kJo2cLZjQCT+rnLmw53UcTl4VFsXRAe0pB0V+iceaAo3ie1VgFTjLDp5QJR7CDHSCtYDeXk2H2T/2Dsj3vgIJcRQoQYHD52+H3foAHMVG05mExTwG1DzIYlfUYJMC66MIJ2Vq9g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 May 2026 16:01:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 66733 invoked by uid 111); 13 May 2026 16:01:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2026 12:01:55 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 May 2026 12:01:55 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] hex: add and use strbuf_add_oid_hex()
Message-ID: <20260513160155.GA103037@coredump.intra.peff.net>
References: <183aa0fd-d455-4ec9-9c42-d511fac8b3e4@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <183aa0fd-d455-4ec9-9c42-d511fac8b3e4@web.de>

On Wed, May 13, 2026 at 05:49:11PM +0200, René Scharfe wrote:

> Add a function for adding the full hexadecimal hash value of an object
> ID to a strbuf.  It's thread-safe and slightly more efficient than using
> strbuf_addstr() with oid_to_hex() because it doesn't have to determine
> the length of the string or copy it from the intermediate static buffer.
> 
> Add and apply a semantic patch to use it throughout the code base.
> 
> I get a tiny speedup for git log showing a single hash per commit:
> 
> Benchmark 1: ./git_main log --format=%H
>   Time (mean ± σ):      91.2 ms ±   0.7 ms    [User: 51.9 ms, System: 38.6 ms]
>   Range (min … max):    89.8 ms …  92.6 ms    31 runs
> 
> Benchmark 2: ./git log --format=%H
>   Time (mean ± σ):      90.5 ms ±   0.7 ms    [User: 51.0 ms, System: 38.8 ms]
>   Range (min … max):    89.2 ms …  92.3 ms    32 runs

Probably the most extreme benchmark would be:

  git cat-file --batch-all-objects --batch-check='%(objectname)'

which is really just dumping the oids from packfiles. I got ~3% speedup,
though like yours it's within the run-to-run noise.

I think this is worth doing solely for removing more instances of global
buffers, though.

-Peff
