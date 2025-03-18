Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203483FE4
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742264169; cv=none; b=ttkzmChp2LaXTO3xD3IaZWstVrWb7JdfrLbQAR95GYyR4kzzEkfKtdlyXHtfss6xlhGjoHMeM3fzFLG6U4q2nsEKpJTzHP6y3mHUngnBahlAYB17abRfwiEWHKTxKuK7y3FvrHMtxnHZdeGleM96UKexCMz93AaYpHo9YbuKAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742264169; c=relaxed/simple;
	bh=B2XeBhyKKsjIPqQiKpELe/7nLkIHk6ZylOOIPwrSfFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+As/bNozxfOXhC7RMO7zmRcyx0IXDvkMas2MHZtbjgz1b7v2MqcFW0FkGNiJ6zfHYFTQ+MuXbUE7zVsHjxtdcnKgvsqWBuMPVHw66YiM2E3t6jXfwOSb9p0O3lCyeuYtCvWzwoDx++l3p5CRxIUNY0dc5RwJ8OvQYOX0hS/QUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FqNcEPDT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FqNcEPDT"
Received: (qmail 26841 invoked by uid 109); 18 Mar 2025 02:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B2XeBhyKKsjIPqQiKpELe/7nLkIHk6ZylOOIPwrSfFA=; b=FqNcEPDT7GOlziLBTu+SgkIAJS0XaBE7NVlph6Pv6UmxsH66UKEh/GfzLz0lWJvoqvGWcCFNecpXdPDIplbvzbImK02lV34QHwQlmpk/iBYoy+4ZN0rMAFfhBYeUX1swLmCPzd/9MUibi3UF8l7bo4hxXFBtWqvO4X20d0w0cy8MTcQWY0X1bTwkeyV4SoPNIbdWiaY/6sHb9Xn2wlwzDy0WObqyJ20yYELYekmmpytcQhhhdxw4E8+mpWAE0q17Ad0XTStR5+1x2tZu7c17qngIi2NnJFtnUOtUvhKsAwphmEeptTLqjGxzv5pqAl/ELPsRTFStu0R+JoAyKkKMBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 02:16:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3948 invoked by uid 111); 18 Mar 2025 02:16:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 22:16:05 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 22:16:05 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 13/13] midx: implement writing incremental MIDX bitmaps
Message-ID: <20250318021605.GC1473033@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <d0d564685bc66df71b4c3ed1093452e58e0f54fd.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0d564685bc66df71b4c3ed1093452e58e0f54fd.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:19:00PM -0400, Taylor Blau wrote:

> +write_midx_layer () {
> +	n=1
> +	if test -f $midx_chain
> +	then
> +		n="$(($(wc -l <$midx_chain) + 1))"
> +	fi
> +
> +	for i in 1 2
> +	do
> +		test_commit $n.$i &&
> +		git repack -d || return 1
> +	done &&
> +	git multi-pack-index write --bitmap --incremental
> +}
> +
> +test_expect_success 'write initial MIDX layer' '
> +	git repack -ad &&
> +	write_midx_layer
> +'
> +
> +test_expect_success 'read bitmap from first MIDX layer' '
> +	git rev-list --test-bitmap 1.2
> +'
> +
> +test_expect_success 'write another MIDX layer' '
> +	write_midx_layer
> +'
> +
> +test_expect_success 'midx verify with multiple layers' '
> +	git multi-pack-index verify
> +'

Perhaps a silly suggestion, but do you want to confirm in one of these
tests that there are in fact multiple layers of bitmaps? (I expect it to
be true, but just trying to cover all bases in the test).

I guess that happens somewhat here:

> +test_expect_success 'relink existing MIDX layer' '
> +	rm -fr "$midxdir" &&
> +
> +	GIT_TEST_MIDX_WRITE_REV=1 git multi-pack-index write --bitmap &&
> +
> +	midx_hash="$(test-tool read-midx --checksum $objdir)" &&
> +
> +	test_path_is_file "$packdir/multi-pack-index" &&
> +	test_path_is_file "$packdir/multi-pack-index-$midx_hash.bitmap" &&
> +	test_path_is_file "$packdir/multi-pack-index-$midx_hash.rev" &&
> +
> +	test_commit another &&
> +	git repack -d &&
> +	git multi-pack-index write --bitmap --incremental &&
> +
> +	test_path_is_missing "$packdir/multi-pack-index" &&
> +	test_path_is_missing "$packdir/multi-pack-index-$midx_hash.bitmap" &&
> +	test_path_is_missing "$packdir/multi-pack-index-$midx_hash.rev" &&
> +
> +	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.midx" &&
> +	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.bitmap" &&
> +	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.rev" &&
> +	test_line_count = 2 "$midx_chain"

where we check that we switched to $midxdir.

-Peff
