Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B45524B4
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399293; cv=none; b=b+SNeyGn5GuOLSncxohPlOFEXqtwqWHaIyGRERzxR3QUguLRjsPJ/qwCGxYHCgfG/nP1bvtnP1alzQa/cpwDDmfWEkUeTsjyoYkVPvcJ03ilWCJaGJIoftZVv0zdDGLQ+pYfXReUCthTjdGea+bsS1k6odnstQrbNNxt0DaUKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399293; c=relaxed/simple;
	bh=RgriahAkcPG/AkZq22sD6UYYmnXmhnVOv6QWDOrL/mc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZVmfiVX6ZqjOyJzRNpd2d19uho7GIug3C+PwoMbhkgYWr+8WaPERkQBoV0LD4vgDdIITvZKC8xKsxFu2K8kUMPtBe977dwJqV3OBESFm73BdVzdL6XRa8qGTk4fpiw9WcnJI3/Ua5rLw4v7H9MQFMT6N5gfu7u84K6eYLax8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aEFcIWz/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aEFcIWz/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 317D630CAA;
	Mon, 25 Mar 2024 16:41:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RgriahAkcPG/AkZq22sD6UYYmnXmhnVOv6QWDO
	rL/mc=; b=aEFcIWz/tUFJ1wr8Uu7aeo02s54uG0XEerPegLmYOSARnpbFKtv1+0
	DO8WqiDklmIOjmhIbwViE8DhDvwBwAr+QrXgXIGh1AZkbilcdeHegq9iNnw1YATH
	SUQ3kTYoIXktajo7axtJ/rdWwbtAwyxTA6meRN4BIxGMs7E3ddXGI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 29EDC30CA9;
	Mon, 25 Mar 2024 16:41:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA92030CA8;
	Mon, 25 Mar 2024 16:41:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/11] midx-write.c: check count of packs to repack
 after grouping
In-Reply-To: <f77e3167aad4b60c381cf1def2ee1eeb26218d06.1711387439.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 25 Mar 2024 13:24:47 -0400")
References: <cover.1711387439.git.me@ttaylorr.com>
	<f77e3167aad4b60c381cf1def2ee1eeb26218d06.1711387439.git.me@ttaylorr.com>
Date: Mon, 25 Mar 2024 13:41:27 -0700
Message-ID: <xmqqjzlqhwnc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E3B2E60-EAE8-11EE-AEDE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> In both fill_included_packs_all() and fill_included_packs_batch(), we
> accumulate a list of packs whose contents we want to repack together,
> and then use that information to feed a list of objects as input to
> pack-objects.
>
> In both cases, the `fill_included_packs_` functions keep track of how
> many packs they want to repack together, and only execute pack-objects
> if there are at least two packs that need repacking.
>
> Having both of these functions keep track of this information themselves
> is not strictly necessary, since they also log which packs to repack via
> the `include_pack` array, so we can simply count the non-zero entries in
> that array after either function is done executing, reducing the overall
> amount of code necessary.

It does make the logic at the caller simpler to follow.

> -	if (batch_size) {
> -		if (fill_included_packs_batch(r, m, include_pack, batch_size))
> -			goto cleanup;
> -	} else if (fill_included_packs_all(r, m, include_pack))
> +	if (batch_size)
> +		fill_included_packs_batch(r, m, include_pack, batch_size);
> +	else
> +		fill_included_packs_all(r, m, include_pack);
> +
> +	for (i = 0; i < m->num_packs; i++) {
> +		if (include_pack[i])
> +			packs_to_repack++;
> +	}
> +	if (packs_to_repack <= 1)
>  		goto cleanup;
>  
>  	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);

Queued.  Thanks.

