Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799133DF
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630384; cv=none; b=X8c3aDOK7BhhxIErTM/VRUcsz2r98u90aa0uXNWrJ2bszxLpFnBwaXcKuYQhrRSzvhXXKz9ojU4TnBKbZQwqviIoF92qImK7tXhNnheW/vc7g4atY2RNowFC1L6SOhNnRIBY9Ztw5RsmKtQi642/ffvlx0Hy/XNAU/gYB2EhTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630384; c=relaxed/simple;
	bh=sJmN767Y4xL9ixrZ1QNle3kHHPLbce4CoLIDM0FMfPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AhLs+XF+GKlNxyBXt2rTYgcKvOc2t0UMyIGmbCD92iZxwa+1Yvb3yfAQ4XATtya06SoYyCzqijvWO3KqmFd2b1vKEzKFf37IzLyAOz19wJIdCq739QVZPIVWjOAGrDTeJ6dBsElUyzcrYfTICiIvztrNEXfrfi6X5mk1294ya2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FmzoZOZ/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FmzoZOZ/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CBF8A1C325;
	Fri,  2 Aug 2024 16:26:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sJmN767Y4xL9ixrZ1QNle3kHHPLbce4CoLIDM0
	FMfPc=; b=FmzoZOZ/9aHMb1K5LKS5kj3UBSNrcZBDqauZe0n1rjHuT7Ym0p6QYF
	l3ELltjWB+iwFR+79QfH47zWuPOznlsPaWZvKidH253DsW2L+kqJAKdHqZoI8ZUK
	qLnqONkCzkMpwE57c1iv1MTOCr7y3Y3KFH+TLy+hfZCAnH9XTM1rM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C5DE41C324;
	Fri,  2 Aug 2024 16:26:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A8F5D1C323;
	Fri,  2 Aug 2024 16:26:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] reftable/stack: refactor function to gather table
 sizes
In-Reply-To: <5d99191f5c30927f01f9281dcccfa51a120fc698.1722435214.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 31 Jul 2024 16:14:52 +0200")
References: <cover.1722435214.git.ps@pks.im>
	<5d99191f5c30927f01f9281dcccfa51a120fc698.1722435214.git.ps@pks.im>
Date: Fri, 02 Aug 2024 13:26:14 -0700
Message-ID: <xmqq5xsid63d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 78559C64-510D-11EF-8661-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Refactor the function that gathers table sizes to be more idiomatic. For
> one, use `REFTABLE_CALLOC_ARRAY()` instead of `reftable_calloc()`.
> Second, avoid using an integer to iterate through the tables in the
> reftable stack given that `stack_len` itself is using a `size_t`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 737591125e..ba8234b486 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1305,14 +1305,15 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
>  
>  static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
>  {
> -	uint64_t *sizes =
> -		reftable_calloc(st->merged->stack_len, sizeof(*sizes));
>  	int version = (st->opts.hash_id == GIT_SHA1_FORMAT_ID) ? 1 : 2;
>  	int overhead = header_size(version) - 1;
> -	int i = 0;
> -	for (i = 0; i < st->merged->stack_len; i++) {
> +	uint64_t *sizes;
> +
> +	REFTABLE_CALLOC_ARRAY(sizes, st->merged->stack_len);
> +
> +	for (size_t i = 0; i < st->merged->stack_len; i++)
>  		sizes[i] = st->readers[i]->size - overhead;
> -	}
> +

OK.
