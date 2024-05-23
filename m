Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30A26AC6
	for <git@vger.kernel.org>; Thu, 23 May 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461320; cv=none; b=GBFklwOJqukPtBWStsO2CcKy4QBfBupNyyDvl7oOiSgX/oc77v3t2Jp3Sg/v7k1s9DjdT5n+IFvxJB0KjCR3L7mvlLiesSxCVt9fFiRIsUBSnjhKG0IhFewKHZXBCxvsUjAW6faFgyrt7GFMM1e8UhHl/Vxb2OoZdrHSV3KTDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461320; c=relaxed/simple;
	bh=BXwwOMB4BblG6Ojz0wQSnZc1xHTGyH4r+YLNroMxUOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8qbekD6AEtr+YdLxuGWUxyoDrPrXAnonp4uBMsBz/G2IgF7BZnTcUinQPafBURFCniRGZbkdj3yVCpK5C7PTBxQ90e6ndAqAJHpTvBYhtAdFFEwTVQqiEv7SLd3hhfe/yhL1+d6tyv43R6F8820cByEfBSryLe8qk8/mRfPR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31364 invoked by uid 109); 23 May 2024 10:48:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 10:48:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29252 invoked by uid 111); 23 May 2024 10:48:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 06:48:43 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 06:48:37 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 26/30] pack-bitmap.c: use pseudo-merges during
 traversal
Message-ID: <20240523104837.GE1308330@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <41691824f78818f3c70cad6d02cd7f66d12c68c3.1716318089.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41691824f78818f3c70cad6d02cd7f66d12c68c3.1716318089.git.me@ttaylorr.com>

On Tue, May 21, 2024 at 03:03:03PM -0400, Taylor Blau wrote:

> The basic operation is as follows:
> 
>   - When enumerating objects on either side of a reachability query,
>     first see if any subset of the roots satisfies some pseudo-merge
>     bitmap. If it does, apply that pseudo-merge bitmap.
> 
>   - If any pseudo-merge bitmap(s) were applied in the previous step, OR
>     them into the result[^1]. Then repeat the process over all
>     pseudo-merge bitmaps (we'll refer to this as "cascading"
>     pseudo-merges). Once this is done, OR in the resulting bitmap.
> 
>   - If there is no fill-in traversal to be done, return the bitmap for
>     that side of the reachability query. If there is fill-in traversal,
>     then for each commit we encounter via show_commit(), check to see if
>     any unsatisfied pseudo-merges containing that commit as one of its
>     parents has been made satisfied by the presence of that commit.
> 
>     If so, OR in the object set from that pseudo-merge bitmap, and then
>     cascade. If not, continue traversal.

Ah, OK. This is the high-level overview I was looking for in the earlier
commit. ;) I think it is fine here. I just hadn't gotten to it yet (and
I think it is much better stated than what I wrote in my earlier
response).

> [^1]: Importantly, we cannot OR in the entire set of roots along with
>   the objects reachable from whatever pseudo-merge bitmaps were
>   satisfied.  This may leave some dangling bits corresponding to any
>   unsatisfied root(s) getting OR'd into the resulting bitmap, tricking
>   other parts of the traversal into thinking we already have a
>   reachability closure over those commit(s) when we do not.

I think I know how you made this realization. :)

The code itself looks as I'd expect, and the entry points are nice and
clean.

-Peff
