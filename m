Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A78495
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083043; cv=none; b=PnzewrA2qtGS0tPNoOo90uyeY9qpvc/8oAvVgqlBXQlj3aQuN6OU4KlMBicU/s58UxnVhyFQEkn8TbRfHNZPe9bgI2CkSuS8o2Nv6qFTy2kbe8TZ7KOAAng2FAoLHlORSW5Cw7k9EMbL2k9zpso0W+VPzKFbKzTq0aq789SbnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083043; c=relaxed/simple;
	bh=dx6F0dUW/9CsieKLNjAP3YCTu7nhJaxp//rUFOumtBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=elI0XlR9ycSYFuPoNjFQk/QraZnurYS41ZMxBDBVvknVN5QcBi7I3h/FoYemHTdhjGD2akHtUHGW0bNW3vFG4+YOLYriAMWlvzTHs9ICDN1ONzgaTcpPmxVs/gMnMo7Vf7bDi1X5FLZvoDU26iC/m+H0V1K2m0kY0x5lBu1GPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gTCN2Lge; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gTCN2Lge"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B20DF2AC02;
	Tue,  2 Apr 2024 14:37:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dx6F0dUW/9CsieKLNjAP3YCTu7nhJaxp//rUFO
	umtBo=; b=gTCN2LgeTO7shDXXj6v0No9PsS7vuZ1u8m80ylQt823VO/EH7u1CWB
	jEKHZJOM50xrHfMBUESKoBeIrL+egeIfbQhEhKYpG6wffr7vFaDX4c04NzLvcAx8
	je+zR982RgNuRTL4TlkNwYLu71U98RfkK0ZE49OMA4tMontncjnyI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AAB172AC01;
	Tue,  2 Apr 2024 14:37:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33A962AC00;
	Tue,  2 Apr 2024 14:37:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t7700-repack.sh: fix test breakages with
 `GIT_TEST_MULTI_PACK_INDEX=1`
In-Reply-To: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 2 Apr 2024 12:26:34 -0400")
References: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>
Date: Tue, 02 Apr 2024 11:37:10 -0700
Message-ID: <xmqqr0fn4nmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 051FB056-F120-11EE-BEC7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> There are a handful of related test breakages which are found when
> running t/t7700-repack.sh with GIT_TEST_MULTI_PACK_INDEX set to "1" in
> your environment.
>
> Both test failures are the result of something like:
>
>     git repack --write-midx --write-bitmap-index [...] &&
>
>     test_path_is_file $midx &&
>     test_path_is_file $midx-$(midx_checksum $objdir).bitmap
>
> , where we repack instructing Git to write a new MIDX and corresponding
> MIDX bitamp.
>
> The error occurs when GIT_TEST_MULTI_PACK_INDEX=1 is found in the
> enviornment. This causes Git to write out a second MIDX (after
> processing the builtin's `--write-midx` argument) which is identical to
> the first, but does not request a bitmap (since we did not set the
> GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP variable in the environment).

Doesn't it sound more like a bug, though?  If a command line option
requests something, should we still be honoring a contradicting
instruction given by environment variable(s)?

But anyway.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 94f9f4a1da..127efe99f8 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -629,6 +629,7 @@ test_expect_success '--write-midx with preferred bitmap tips' '
>  		git log --format="create refs/tags/%s/%s %H" HEAD >refs &&
>  		git update-ref --stdin <refs &&
>  
> +		GIT_TEST_MULTI_PACK_INDEX=0 \
>  		git repack --write-midx --write-bitmap-index &&
>  		test_path_is_file $midx &&
>  		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&

Is it a viable alternative approach to skip this check (and the
other one) when GIT_TEST_MULTI_PACK_INDEX is set (i.e., lazy
prereq).  It will give us a better documentation value, e.g.,

	test_lazy_prereq FORCED_MIDX '
                # Features that are broken when GIT_TEST_* forces it
                # to enable are protexted with this prerequisite.
		test "$GIT_TEST_MULTI_PACK_INDEX" = 1;
	'

	test_expect_success !FORCED_MIDX '--write-midx with ...' '
		...
	'

With a single comment, we can annotate any future tests that relies
on features working correctly even with GIT_TEST_MULTI_PACK_INDEX.
