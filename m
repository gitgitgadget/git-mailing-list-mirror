Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD6189B8E
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509210; cv=none; b=hBsi4Coc0uDF/F5YARubgoCA7GhtC14jF0kz2TUY0LYkEJinp7w47YOCBtmtqAOO1LxqQKD6CpJa7c3flJRapZr+kctFLN16b5H/Gr9D63YOCYNs3hqq+OrxVL/KSLtvHqr7YRPdQJ4elYHFOn7Lo/CbohGHK5vSw5Xg8JOz+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509210; c=relaxed/simple;
	bh=VxTqff5+MSqgDwekZtxQoI0NLsLvwXksp6I3UHEBMlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIJwGdB+9yyrbwQhDN3hVSx4qEWKx3+QmQoOcvQFslFLMRf2WGWVcfsrTY2YMtz58wfILfLk8SsJJt/+xRUumIdWQ/mK1Beou+AlyH85J8Com2UqeCdRqZT0yHlrzM9M5tbuXig3kYNdoQC96AiZ00XoU2vT5ksyYhu8fSeGg98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19544 invoked by uid 109); 1 Aug 2024 10:46:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:46:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30936 invoked by uid 111); 1 Aug 2024 10:46:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:46:52 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:46:47 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/19] t: retire
 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <20240801104647.GQ1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <23912425bf7c0106ed388f7712e7bb822572fe5d.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23912425bf7c0106ed388f7712e7bb822572fe5d.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:47PM -0400, Taylor Blau wrote:

> Two years ago, commit ff1e653c8e2 (midx: respect
> 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP', 2021-08-31) introduced a new
> environment variable which caused the test suite to write MIDX bitmaps
> after any 'git repack' invocation.
> 
> At the time, this was done to help flush out any bugs with MIDX bitmaps
> that weren't explicitly covered in the t5326-multi-pack-bitmap.sh
> script.
> 
> Two years later, that flag has served us well and is no longer providing
> meaningful coverage, as the script in t5326 has matured substantially
> and covers many more interesting cases than it did back when ff1e653c8e2
> was originally written.

I do think it could be providing some value still, just because other
scripts may create unusual setups that will exercise the code in
different ways. That said...

> Remove the 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' environment variable
> as it is no longer serving a useful purpose. More importantly, removing
> this variable clears the way for us to introduce a new one to help
> similarly flush out bugs related to incremental MIDX chains.
> 
> Because these incremental MIDX chains are (for now) incompatible with
> MIDX bitmaps, we cannot have both.

...if it is one or the other, I think it is better to test the new code.

And I do think that midx bitmap code is less likely to be exercised in
interesting ways by random parts of the test suite (versus something
like GIT_TEST_DEFAULT_HASH, whose effects are pervasive). So I think
this is a good tradeoff.

>  builtin/repack.c                  | 12 ++----------
>  ci/run-build-and-tests.sh         |  1 -
>  midx.h                            |  2 --
>  t/README                          |  4 ----
>  t/t0410-partial-clone.sh          |  2 --
>  t/t5310-pack-bitmaps.sh           |  4 ----
>  t/t5319-multi-pack-index.sh       |  3 +--
>  t/t5326-multi-pack-bitmaps.sh     |  3 +--
>  t/t5327-multi-pack-bitmaps-rev.sh |  5 ++---
>  t/t7700-repack.sh                 | 21 +++++++--------------
>  10 files changed, 13 insertions(+), 44 deletions(-)

Patch looks good.

-Peff
