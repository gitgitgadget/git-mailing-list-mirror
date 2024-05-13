Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046284D07
	for <git@vger.kernel.org>; Mon, 13 May 2024 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641866; cv=none; b=jDfTWdnUlFj3YUyUaZMsRbUJkoGlBRequ8Oz6QKigwTb8imTQ3q21wCs0wKuwGkloG8t6PN0ax2w8MrcVZD1jaOdvUlPqDvmAe/sD6H/3gnlxyDVXKz6owFw0P7Hu0I65c70VqaPUZ8QRmJ0lkfafXNrI9q/c331YAHZNv7/ZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641866; c=relaxed/simple;
	bh=1X6Fk+GJSu0uWhTRH2WFRCbYn68EbxDbpE6p/sBcQqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nh1JDGCTV0K0GJHR54XR4Yd6gVrW/dSzTan5q8Cji/46QeBkm44SeoqZYCvRFVvtgVKSTDrhB7TwCeZrGq+tO7slbFUWiB4JMEkKkniv5csqDvi/bp+mShX2/YzIhtotxwox+/Nk0JHsQ6wmmhPgH5zPjJs1CtWjamLAC1S5T9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ADbxWEbF; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ADbxWEbF"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C9FE373D2;
	Mon, 13 May 2024 19:11:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1X6Fk+GJSu0uWhTRH2WFRCbYn68EbxDbpE6p/s
	BcQqw=; b=ADbxWEbFcUUe99Zz0ocRvdBgN9ARqpgtH0rqpoYjhzV0DsSMh9AVEq
	p/837FUCM4pLfYB0ys45pHICgesYvcRYafN1oN18jBU+IH1y8rqEbkOIm7wqs7Sp
	Q8vlgRP+wOzAloL/W26g1KjMZN75BLvDeXEQ96113EuRO9IBAUBGA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CA88373D1;
	Mon, 13 May 2024 19:11:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5814B373CF;
	Mon, 13 May 2024 19:11:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/5] builtin/patch-id: fix uninitialized hash function
In-Reply-To: <20240513224127.2042052-4-gitster@pobox.com> (Junio C. Hamano's
	message of "Mon, 13 May 2024 15:41:25 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240513224127.2042052-1-gitster@pobox.com>
	<20240513224127.2042052-4-gitster@pobox.com>
Date: Mon, 13 May 2024 16:11:01 -0700
Message-ID: <xmqqbk59cnp6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 11CC741E-117E-11EF-96C0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> We explicitly document patch IDs to be using SHA-1. Furthermore, patch
> IDs are supposed to be stable for most of the part. But even with the
> same input, the patch IDs will now be different depending on the repo's
> configured object hash.
>
> Work around the issue by setting up SHA-1 when there was no startup
> repository for now. This is arguably not the correct fix, but for now we
> rather want to focus on getting the segfault fixed.

I tend to agree that the use of SHA-256 in patch-id computation is a
regression when we added the SHA-256 support.  Even with the
GIT_DEFAULT_HASH_ALGORITHM fallback, we cannot fix it in an
initialized SHA-256 repository.

We should fix it but I agree that is probably outside the scope of
the "oops, we leave the hash algorithm totally uninitialized" fix.
> +	/*
> +	 * We rely on `the_hash_algo` to compute patch IDs. This is dubious as
> +	 * it means that the hash algorithm now depends on the object hash of
> +	 * the repository, even though git-patch-id(1) clearly defines that
> +	 * patch IDs always use SHA1.
> +	 *
> +	 * NEEDSWORK: This hack should be removed in favor of converting
> +	 * the code that computes patch IDs to always use SHA1.
> +	 */
> +	if (!startup_info->have_repository)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

Hmph, in other places I did

	if (!the_hash_algo)
		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

to find the case where we need a reasonable default.

Is there a practical difference?  If there isn't we should
standardise one and use the same test consistently everywhere.

Not that it matters for this particular case, where we in the longer
term should be hardcoding the use of SHA-1 even in SHA-256 repository
for the pupose of computing the patch-id.

Thanks.
