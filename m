Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32410F1
	for <git@vger.kernel.org>; Sat, 25 May 2024 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716606807; cv=none; b=dDE+FsCJkBMTbAiel16LBkf1YVyTvsPKLVx03J916TwwkL6yvYyygbgKvljKwEaTHtNWjnvZjy6KF38WPIbX83A7gtZt5Te9hJB4lggDzaPy9R7pPSJa1D4vumWBoQdSODzYyJAOf2VAU+HGDoc4qw5TUXTJq4fByXLy/2LSPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716606807; c=relaxed/simple;
	bh=Am0mknBMYfQcDkGufiEAhxVM9NH1uuqyqlaN/ArLW34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCszljBniZvmo4vZ0MAimBBD0eSUz+CEf+R4jSzB70spFOUYOa79usJiihBkQvtsOfw/8+BCZL8Zg5NgOX6ARW5s64rzAZnPDjgz/qOcn/KezgxiESq1U4wrlKIzV5t/u+EA28atbzFGt8Q2pCIvq+2wKK2G7GRMcda+1oqJWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3771 invoked by uid 109); 25 May 2024 03:13:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 03:13:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15282 invoked by uid 111); 25 May 2024 03:13:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 May 2024 23:13:21 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 May 2024 23:13:17 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 30/30] t/perf: implement performace tests for
 pseudo-merge bitmaps
Message-ID: <20240525031317.GA1889620@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <6a6d88fa512ba344543f5f0df33d5a61e406f3db.1716318089.git.me@ttaylorr.com>
 <20240523105422.GF1308330@coredump.intra.peff.net>
 <Zk+epE2S4KErPyVk@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zk+epE2S4KErPyVk@nand.local>

On Thu, May 23, 2024 at 03:53:08PM -0400, Taylor Blau wrote:

> -	GIT_TEST_USE_PSEDUO_MERGES=0 \
> +	GIT_TEST_USE_PSEUDO_MERGES=0 \

Whoops.

> Sure enough, that shows us a little gap between the "no pseudo-merges"
> and "with pseudo-merges" case:
> 
> ```
> Test                                                                this tree
> -----------------------------------------------------------------------------------
> 5333.2: git rev-list --count --all --objects (no bitmaps)           3.54(3.45+0.08)
> 5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.43(0.40+0.03)
> 5333.4: git rev-list --count --all --objects (with pseudo-merges)   0.12(0.11+0.01)
> ```

OK, that seems more like it. 300ms is nice, but there's just not that
much improvement to make here.

This one is much more exciting:

> ```
> Test                                                                this tree
> ---------------------------------------------------------------------------------------
> 5333.1: git rev-list --count --all --objects (no bitmaps)           122.29(121.31+0.97)
> 5333.2: git rev-list --count --all --objects (no pseudo-merges)     21.88(21.30+0.58)
> 5333.3: git rev-list --count --all --objects (with pseudo-merges)   5.05(4.77+0.28)
> ```

Very nice improvement.

I wonder what we spend the final 5s on.  Maybe just book-keeping to
assemble all the tips (and maybe even parse tip commits? I can't
remember if we ever optimized that out). Anyway, that's all out of scope
for your series. Getting rid of the expensive traversal would let us
focus on those final bits. ;)

-Peff
