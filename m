Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DE168DC
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772623; cv=none; b=DQC6yBqFSTaNIwecpXd/X2NrzI5z4xgZYWbrHDsu2m++X/q3cLz3HyhOU3/nm0HeB17UgPJleHylwC/sx3rhn8sxN5ffo/CKShGVEufWTbhuvpKAMdnlxPmwBpUsLiH4jqN6Df8SW/Qz7GILLIgfUtisw/KSPcWWtC2QCKwhCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772623; c=relaxed/simple;
	bh=3HcfYHuqh2i6mrDwLhQo9O300JVdnlwgLPiuMr88T+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTKEwPtdxC2glCj8YoENWkLwrxzwSf8S34Bmes8jA7WsK39atqfhvXjESv5ZZWVnCFvF6UfoMvStH/8XtVz4OcqZobEPJahxAVwqrZvJsrLMLp/ah5Raqxn0be66GkZi2J6l/nUEayriqN4DQGNmt+VBs7glqzqCLOU0uspYWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15664 invoked by uid 109); 10 Apr 2024 18:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Apr 2024 18:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18412 invoked by uid 111); 10 Apr 2024 18:10:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Apr 2024 14:10:21 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Apr 2024 14:10:20 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/24] pack-bitmap: move some initialization to
 `bitmap_writer_init()`
Message-ID: <20240410181020.GD2260545@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <a65316567391160dddae70fb036f03858772014f.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a65316567391160dddae70fb036f03858772014f.1710972293.git.me@ttaylorr.com>

On Wed, Mar 20, 2024 at 06:05:13PM -0400, Taylor Blau wrote:

> The pack-bitmap-writer machinery uses a oidmap (backed by khash.h) to
> map from commits selected for bitmaps (by OID) to a bitmapped_commit
> structure (containing the bitmap itself, among other things like its XOR
> offset, etc.)
> 
> This map was initialized at the end of `bitmap_writer_build()`. New
> entries are added in `pack-bitmap-write.c::store_selected()`, which is
> called by the bitmap_builder machinery (which is responsible for
> traversing history and generating the actual bitmaps).
> 
> Reorganize when this field is initialized and when entries are added to
> it so that we can quickly determine whether a commit is a candidate for
> pseudo-merge selection, or not (since it was already selected to receive
> a bitmap, and thus is ineligible for pseudo-merge inclusion).

OK, makes sense. I don't think this should violate any assumptions in
the current bitmap code (and the sanity checks for duplicate/missing
entries in the hash seem right to me).

-Peff
