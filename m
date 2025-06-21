Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA77FD
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 04:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750480563; cv=none; b=DSrCaluuXDfMCxBtolMnX3sZwJyhGparx+ZkATeUj0Vu6JBWwThv9XH0gqJEmiVI2eVtMWj7ToLNhuaSh7lH06yUtJQe/mDnZ0GljrMMnqbRslaQ/ZHYokALbxo6odGXApZTzhWCr9whsLpzUGAjZWuTNGZmBW6JqH4Gz2FmZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750480563; c=relaxed/simple;
	bh=wO7WS79ugx9xKPDt/66lsqLtCeFCiAnsHwNGWu0KQgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oasRRz0R9ge3jHes5BP2Tb6SnSyVrtce1vgzVAZI5WGwlF2BbP8S4WG9i5D/lADcuBiQSBWlXvcPSZuDcdRgt4Gapw+GDtmFYmE1kstfysGLXn22fn8dOlAFzcxGUiQYRNpUGFnOfDiv5LnNgYF1N3PgcscJjzm+KrlD8uIAmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QpdUqOjz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QpdUqOjz"
Received: (qmail 31568 invoked by uid 109); 21 Jun 2025 04:35:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wO7WS79ugx9xKPDt/66lsqLtCeFCiAnsHwNGWu0KQgs=; b=QpdUqOjzeMw2RKwDWY9XyjvXTsGSWgAibLupfFPw6wJJbl2WJFXkg3N2IHObB7857JMClwkeqPIPKNhFlUhlVgpVMovWXZFv+tHSOGUXYJEVQ73g3B5N+w5p24VjYfEClAMnOLImyCwfEw9LW0XPa2gVgY2Lm6dIdbzzFv1JGnBQh/5mfR5HrlR3K1ZD5TQjCesGZ+Zr14N/JQzkvLGashTYXxzRYH3AxEvNQVcuWKV4W7FNkhVr59GRN3RqiTQ6uZLP4vKg5xJQ5E142bPIoHMLYfKXNQS0eFeTr/jTr14lCkqJjk11BXF8gwN9cj7CNtmUKgU7KpvyHFIJsbj8Zg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Jun 2025 04:35:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11927 invoked by uid 111); 21 Jun 2025 04:35:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Jun 2025 00:35:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Jun 2025 00:35:51 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 9/9] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <20250621043551.GA3002138@coredump.intra.peff.net>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
 <6487001f64653d1434890df39b4c4937ea4d0b2c.1750375803.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6487001f64653d1434890df39b4c4937ea4d0b2c.1750375803.git.me@ttaylorr.com>

On Thu, Jun 19, 2025 at 07:30:33PM -0400, Taylor Blau wrote:

> +test_expect_success 'repack --write-midx excludes cruft where possible' '
> +	setup_cruft_exclude_tests exclude-cruft-when-possible &&
> +	(
> +		cd exclude-cruft-when-possible &&
> +
> +		GIT_TEST_MULTI_PACK_INDEX=0 \
> +		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
> +
> +		test-tool read-midx --show-objects $objdir >midx &&
> +		cruft="$(ls $packdir/*.mtimes)" &&
> +		test_grep ! "$(basename "$cruft" .mtimes).idx" midx &&
> +
> +		git rev-list --all --objects --no-object-names >reachable.raw &&
> +		sort reachable.raw >reachable.objects &&
> +		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
> +
> +		test_cmp reachable.objects midx.objects
> +	)
> +'

This test (but none of the others) fails when run with:

  GIT_TEST_MULTI_PACK_INDEX=1 \
  GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1 \
  ./t7704-repack-cruft.sh

The culprit is the incremental flag, but you need the first one for the
second to do anything. The issue is that the cruft pack unexpectedly
appears in the midx:

  error: '! grep pack-45dcff625845dc0ad702f91d853d0950f9be0eb9.idx midx' did find a match in:
  header: 4d494458 1 20 6 3
  chunks: pack-names oid-fanout oid-lookup object-offsets
  num_objects: 12
  packs:
  pack-110f8bab659db6e691a75b6462d043214fd1da92.idx
  pack-45dcff625845dc0ad702f91d853d0950f9be0eb9.idx
  pack-91db7b4b856b00c3e675824c5bc5389b6810037a.idx
  object-dir: .git/objects
  07d4aa2eb79f3a92e1dadaee6ef6b883cdbba641 12	.git/objects/pack/pack-45dcff625845dc0ad702f91d853d0950f9be0eb9.pack
  139b20d8e6c5b496de61f033f642d0e3dbff528d 114	.git/objects/pack/pack-45dcff625845dc0ad702f91d853d0950f9be0eb9.pack
  25e18d2c3e3563b690593dcce936302010e6aa7e 12	.git/objects/pack/pack-110f8bab659db6e691a75b6462d043214fd1da92.pack
  2bdf67abb163a4ffb2d7f3f0880c9fe5068ce782 270	.git/objects/pack/pack-45dcff625845dc0ad702f91d853d0950f9be0eb9.pack
  2f00a404aed7e63d867313d504bd0fccea53fd25 285	.git/objects/pack/pack-45dcff625845dc0ad702f91d853d0950f9be0eb9.pack
  5626abf0f72e58d7a153368ba57db4c673c0e171 182	.git/objects/pack/pack-91db7b4b856b00c3e675824c5bc5389b6810037a.pack
  7c7cd714e262561f73f3079dfca4e8724682ac21 358	.git/objects/pack/pack-45dcff625845dc0ad702f91d853d0950f9be0eb9.pack
  8510665149157c2bc901848c3e0b746954e9cbd9 271	.git/objects/pack/pack-110f8bab659db6e691a75b6462d043214fd1da92.pack
  a7cddf35737959e1438bc929b665619e9e79bfee 138	.git/objects/pack/pack-91db7b4b856b00c3e675824c5bc5389b6810037a.pack
  d79ce1670bdcb76e6d1da2ae095e890ccb326ae9 12	.git/objects/pack/pack-91db7b4b856b00c3e675824c5bc5389b6810037a.pack
  db6165b80a148f78daad30f4e29c7b77fe8f04c2 169	.git/objects/pack/pack-110f8bab659db6e691a75b6462d043214fd1da92.pack
  f719efd430d52bcfc8566a43b2eb655688d38871 517	.git/objects/pack/pack-45dcff625845dc0ad702f91d853d0950f9be0eb9.pack

I'm not sure if it's just a funky interaction with the hacky GIT_TEST_*
variables, or if it's a real bug.

-Peff
