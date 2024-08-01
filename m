Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6816DC03
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510446; cv=none; b=H4syUR5hjuNDc5bSQG6cZVhGuZJEPm3DF9MtwS1icDuF+z4prBHK8Xn3OHgFpuCJSyRi6/dEoiI81+9EPfP6XToBSaR+D6vIwu9TtK0KGErkyLWbajGMccUcXRfJxlunB3rmeLPNyQhMek1TvfV6p1VCqbxuaW6ct7LX4huahhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510446; c=relaxed/simple;
	bh=gLikl4kAKocWT0r5w2rlnmfXxODDcs9dtPFVcdmM+Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKjXA38DWw+Q0xi02/gNLex7q7uyfF/5RKwSqHM2ISbiBli5W9bPERjtNVYMJ0maspfwW0Hp6FniZaaSlVadJh5AGOStVnqc4Ww4cRvgqUJNevT6V9Ko2QDl8Z18Yna6DvL8XCg+5PoMu0LMn7uppcjUrzFD7RnWuCx1D0PivkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19796 invoked by uid 109); 1 Aug 2024 11:07:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 11:07:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31239 invoked by uid 111); 1 Aug 2024 11:07:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 07:07:22 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 07:07:22 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/19] midx: implement support for writing incremental
 MIDX chains
Message-ID: <20240801110722.GR1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <e2b5961b4556122e594b657efe2f1d3337368cdd.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2b5961b4556122e594b657efe2f1d3337368cdd.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:53PM -0400, Taylor Blau wrote:

> The implementation for doing so is relatively straightforward, and boils
> down to a handful of different kinds of changes implemented in this
> patch:
> 
>   - The `compute_sorted_entries()` function is taught to reject objects
>     which appear in any existing MIDX layer.

OK, I think this is one part I was looking for earlier but didn't see.
The implementation looks pretty easy (we can always ask about just the
earlier layers by feeding the base_midx pointer to midx_has_oid(), etc).

>   - Functions like `write_midx_revindex()` are adjusted to write
>     pack_order values which are offset by the number of objects in the
>     base MIDX layer.
> 
>   - The end of `write_midx_internal()` is adjusted to move
>     non-incremental MIDX files when necessary (i.e. when creating an
>     incremental chain with an existing non-incremental MIDX in the
>     repository).
> 
> There are a handful of other changes that are introduced, like new
> functions to clear incremental MIDX files that are unrelated to the
> current chain (using the same "keep_hash" mechanism as in the
> non-incremental case).

That all makes sense. I wondered a bit about selection of packs, size of
incremental, etc. We'd probably want a geometric-ish progression, just
like with packs, to balance cost of generation versus cost of lookups.
But I guess we get that for free to some degree with "repack
--geometric", assuming that our incremental midx is just covering the
new packfiles.

> The tests explicitly exercising the new incremental MIDX feature are
> relatively limited for two reasons:
> 
>   1. Most of the "interesting" behavior is already thoroughly covered in
>      t5319-multi-pack-index.sh, which handles the core logic of reading
>      objects through a MIDX.
> 
>      The new tests in t5334-incremental-multi-pack-index.sh are mostly
>      focused on creating and destroying incremental MIDXs, as well as
>      stitching their results together across layers.

Do you mean here that t5319 will get coverage when
GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL is set? In the long run, I
wonder if we should pull t5319's tests into lib-midx.sh and run them in
incremental and non-incremental modes.

>   2. A new GIT_TEST environment variable is added called
>      "GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL", which modifies the
>      entire test suite to write incremental MIDXs after repacking when
>      combined with the "GIT_TEST_MULTI_PACK_INDEX" variable.
> 
>      This exercises the long tail of other interesting behavior that is
>      defined implicitly throughout the rest of the CI suite. It is
>      likewise added to the linux-TEST-vars job.

Makes sense.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 8f34f05087..be1188e736 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -7,6 +7,9 @@ test_description='git repack works correctly'
>  . "${TEST_DIRECTORY}/lib-midx.sh"
>  . "${TEST_DIRECTORY}/lib-terminal.sh"
>  
> +GIT_TEST_MULTI_PACK_INDEX=0
> +GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
> [...]
> -		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adl --write-bitmap-index 2>err &&
> +		git repack -Adl --write-bitmap-index 2>err &&

This pulls the GIT_TEST_MULTI_PACK_INDEX=0 out of the individual tests
and sets it for the whole file. Are we losing some coverage for the
other tests? I doubt it's that big a deal either way (and I can
certainly see the argument that t7700, which is concerned with the
details of repacking, should be in control of the details of midx
generation). But I wonder if just setting WRITE_INCREMENTAL=0 would be
enough?

The rest of the changes all looked pretty reasonable, though again, it's
easy to review code you wrote and say "that looks good" but not realize
any gotchas that both of us missed.

-Peff
