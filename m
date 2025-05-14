Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B0280304
	for <git@vger.kernel.org>; Wed, 14 May 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245809; cv=none; b=M8a5rzpAbYnbjzXX3zLEXnXK+3Qu7JwjMeKmA/1ja1EY8gafyJKwBRIgJdBw03SbQ3pJ0d7OPFXWElJuIEAeCfAeVnFVjAiSWvDe/Cs4C1b+z98a7s/0sk5WbcRD+I3B9bFnhbRkSDxIorCM4pal6fEiydmtFmU2+eqlzapPMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245809; c=relaxed/simple;
	bh=Cxe4Pvlpg5Biay9+DBX4wZXR4xvibQLs1IBxkKwzywM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2u1/B2rTrSCWhr1w8xWskYFI/QSa4siToN8tZ7F2kP3vM65aNp/AE+yJZG/Z472aGEsnK+dtNfuEJLqJmETVrnoyCYe0sHKIUfpy9oNw5rolcm1BFzI/wChAWyXzGWxDGJbMqcC1RdK0PD7PgaTTjIq9TVPKMpGsFu6G7032Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TEESqhzq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TEESqhzq"
Received: (qmail 22812 invoked by uid 109); 14 May 2025 18:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Cxe4Pvlpg5Biay9+DBX4wZXR4xvibQLs1IBxkKwzywM=; b=TEESqhzqetc2GUPk8kj7jv8YtLeuj4jtO9i3GbQVo2gCejDQ21lUnT57Jud+ctNDer/HlXxPZX1aY7Qg3UXr2j9nc2m6trodtxbmUJQbYjzqk3HRUHuf5T4HIRfuKcvdLzhL9ElNu3cYtgNMEkN4ytbHZ7knqnU1yX3bolwJ2YKFmbZCeZEvpAduK2iHm8brkRm6/c/ifIgBExXMeuQZIh2owQz7npC2w8/9ZE5qm9eHLKgE7Z8cqoxxAJKXX0MgBE6kQ3ypIypnRG8kFamyYWCXsYy1j1ht7rKt2cYsqhhYW4pj3kBPkD4/YMqAUPhxmSKy8ND53EMHv6bOazLSlQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 May 2025 18:03:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12558 invoked by uid 111); 14 May 2025 18:03:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 May 2025 14:03:27 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 May 2025 14:03:25 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] pack-bitmap: fix memory leak if `load_bitmap_entries_v1`
 failed
Message-ID: <20250514180325.GB2196784@coredump.intra.peff.net>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <20250512131315.GD1191360@coredump.intra.peff.net>
 <aCOFqYdnPp1Lne4Y@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCOFqYdnPp1Lne4Y@nand.local>

On Tue, May 13, 2025 at 01:47:21PM -0400, Taylor Blau wrote:

> > > In pack-bitmap.c:load_bitmap_entries_v1, the function `read_bitmap_1`
> > > allocates a bitmap and reads index data into it. However, if any of
> > > the validation checks following the allocation fail, the allocated bitmap
> > > is not freed, resulting in a memory leak. To avoid this, the validation
> > > checks should be performed before the bitmap is allocated.
> >
> > Thanks, this looks correct to me.
> 
> It looks correct to me as well, and is a strict improvement. But I think
> there is a leak outside of this function as well that is not touched by
> this patch.

Good catch, and your analysis looks correct to me. I don't think that
changes anything for this patch, which is fixing a more "inner" issue of
the allocated memory hitting store_bitmap() at all.

So I think this can graduate independently, and then you can prepare
your fix on top (but no rush).

It would be nice if we triggered these cases in the test suite so that
LSan could confirm that all leaks are covered. But I suspect it may not
be worth the effort to craft a bitmap file that is broken in such
particular ways.

> I suspect the fix looks something like:
> [...]
> , since all callers of load_bitmap() will themselves call
> free_bitmap_index(), so there is no need for us to open-code a portion
> of that function's implementation ourselves.

Deleting that extra code would be doubly satisfying.

-Peff
