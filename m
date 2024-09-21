Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14829A1
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726947451; cv=none; b=Wi9Yw9U4B4bmBJ1fJxBzpNSvQGPKmbF3wVRVgVaFnbjTlVO0Cckr4KmdAICP5zkaZzT2SwxhpV/xgAvNPtLVvNEVPSp9J08Hv1W5vVXntxOAfzrRcKClVTZiYh6oskF9bYeyFH+er0XcUZ8YJZDTbSHQhF/OCjKBnYl/RaOF14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726947451; c=relaxed/simple;
	bh=m27FIMC/H0cUzQ4V3VQmulMorrt+UMXCRJiBpPvdxPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hIWS933P789Shqxnr7PQkkFM7OfqT4kVYlu5qcfBlTAsAXt2GkVai7J80xwg/UKSIzLDhwrLIkIO4wYFpseFHr1UJ4hoHoNV9v5XV0xAPjL8L9lGi1qLSYFdGVX0gxNeXEE7Ha/W7Q97uylWe17ZnqcUUalkuJzgr9ZKsU84b+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vUC20dQI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vUC20dQI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 409E129703;
	Sat, 21 Sep 2024 15:37:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=m27FIMC/H0cUzQ4V3VQmulMorrt+UMXCRJiBpP
	vdxPM=; b=vUC20dQIbCKF4JxydNyTCV6qpLz5ipoaXBr9f9Y7yDFG9jiiiybBlP
	hx6h9McxX8c1MOHpQqhhjTvBFMEzJ5ITB2ZjH9VTnBpqFN05DqtdML2iLG5bwW2W
	8wYMfFTkmDJJFuG+Q6gjC4hEDHSHyQ8PW0hYd5VLN3Pgur9GZjcI4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36F0729701;
	Sat, 21 Sep 2024 15:37:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D41229700;
	Sat, 21 Sep 2024 15:37:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
In-Reply-To: <e6ded75f630ea309d5b76126560a0ec3d526bf71.1726489647.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 14:28:26 +0200")
References: <cover.1726489647.git.ps@pks.im>
	<e6ded75f630ea309d5b76126560a0ec3d526bf71.1726489647.git.ps@pks.im>
Date: Sat, 21 Sep 2024 12:37:26 -0700
Message-ID: <xmqqed5cajd5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF2462F2-7850-11EF-9907-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Handle allocation failures in `reftable_calloc()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/basics.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/reftable/basics.c b/reftable/basics.c
> index 4adc98cf5de..b404900b5d9 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -39,6 +39,8 @@ void *reftable_calloc(size_t nelem, size_t elsize)
>  {
>  	size_t sz = st_mult(nelem, elsize);
>  	void *p = reftable_malloc(sz);
> +	if (!p)
> +		return NULL;
>  	memset(p, 0, sz);
>  	return p;
>  }

Since this series is not about eradicating all avenues in reftable
library code that can lead to die(), but only about dealing with
allocation errors from the underlying malloc/realloc routines, I
think the code posted is perfectly fine as-is as a part of this
series, but since I noticed something, let me comment before I
forget.

When st_mult() detects overflow, you'd still die(), wouldn't you?

We'd probably want a variant of st_mult() that lets us notice a
condition that would yield too large a result, and code the above
like so,

	size_t sz;
	void *p;

	if (st_mult_gently(nelem, elsize, &sz) ||
            !((p = reftable_malloc(sz))))
		return NULL;
	memset(p, 0, sz);
	return p;

or use the underlying helper ourselves, and say

	size_t sz;
	void *p;

	if (unsigned_mult_overflows(nelem, elsize)) ||
            !((sz = nelem * elsize, p = reftable_malloc(sz))))
		return NULL;
	memset(p, 0, sz);
	return p;

which lets us without an extra helper but after writing it myself, I
find it a bit too wordy.

In a sense, it is on the borderline to handle st_mult() overflow in
this function for a topic whose theme is about allocation failures.

From the point of view of callers of reftable_calloc(), whether the
arguments they are feeding the function is too large to be
multiplied or whether the request is too big for the underlying
allocator to handle, the end result should be the same: they
requested too large an allocation.

So I wouldn't complain that it is out of scope, if use of st_mult()
that computes the allocation size is fixed as part of this series.
But as I already said, I am also OK if we leave it to a separate
series to tackle other potential callers of die().

Thanks.
