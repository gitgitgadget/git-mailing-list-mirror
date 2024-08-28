Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA09460
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804059; cv=none; b=bcKwkBEbQgQPht8xePgw7YR9TI+KNJt1jgXzJj38+6MGQIdbt5y8arJ2F3rY4j/qYV/frOc7Yf9GZ7uLIiQEPc1ct0xFM8n1KfQUbkjIpwwtaktBIkoBGN9tUXWmG3vGLitJavBROhRhFygTZ0Y2fRomoWUsZUY74b+W9nIDt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804059; c=relaxed/simple;
	bh=iSF3dLY6A5Wa5jIRDt/g3k1dYt1N2p0fih/VOqPGrNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6bbgbuZ1MYFzADtJz95fsSKM0vtQARg6CJY70zN/AOlYjb4rgqHmajzrzm1l3tPfnNuJhPDeJUBdQJq2s3HfcWzjElxJqnfCtkFjGLOWXsrj7wt5B2dfNq8el1V7xRe9tqFy1Zq77QA5maD4qyPueVyP6ypmerYtoOXAf+XsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L4TJr68p; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L4TJr68p"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC5711F628;
	Tue, 27 Aug 2024 20:14:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iSF3dLY6A5Wa5jIRDt/g3k1dYt1N2p0fih/VOq
	PGrNQ=; b=L4TJr68pLX0qmwCDJf/53i+qOok5dY1SE0DRvEP7T3cNlR4vCxzljg
	Tofrhv6q/LM8NQo3qaj20JdW4OPIw9JUUZh+yseXCljmAPtZoGoS/MppzgnT277y
	BxRm8eMqWIW4EK0D160uQK9BkGhl/H+YSXCn8uuzt628on/JXjIq8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2CC61F627;
	Tue, 27 Aug 2024 20:14:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 074A01F626;
	Tue, 27 Aug 2024 20:14:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] pack-bitmap: tag bitmapped packs with their
 corresponding MIDX
In-Reply-To: <1838bbcf7fe6daa58a7db78b81a2d08138fe176e.1724793201.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 27 Aug 2024 17:13:30 -0400")
References: <cover.1724793201.git.me@ttaylorr.com>
	<1838bbcf7fe6daa58a7db78b81a2d08138fe176e.1724793201.git.me@ttaylorr.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 27 Aug 2024 17:14:14 -0700
Message-ID: <xmqqplpt5wrt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 762F8642-64D2-11EF-89C0-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> The next commit will need to use the bitmap's MIDX (if one exists) to
> translate bit positions into pack-relative positions in the source pack.
>
> Ordinarily, we'd use the "midx" field of the bitmap_index struct. But
> since that struct is defined within pack-bitmap.c, and our caller is in
> a separate compilation unit, we do not have access to the MIDX field.
>
> Instead, add a "from_midx" field to the bitmapped_pack structure so that
> we can use that piece of data from outside of pack-bitmap.c. The caller
> that uses this new piece of information will be added in the following
> commit.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c        | 1 +
>  pack-bitmap.c | 1 +
>  pack-bitmap.h | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/midx.c b/midx.c
> index ca98bfd7c6..67e0d64004 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -496,6 +496,7 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
>  				 MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id +
>  				 sizeof(uint32_t));
>  	bp->pack_int_id = pack_int_id;
> +	bp->from_midx = m;

Do multi_pack_index objects live as long as bitmapped_pack objects
that point at them live?  If m later goes away without letting the
bitmapped_pack know about it, the borrowed pointer in from_midx
would become dangling, which is not what we want to see.

"None of these objects are released or relocated while we are
running pack-objects, so once the .from_midx member is assigned
here, it will always be pointing at a valid multi_pack_index object"
is a satisfactory answer, I guess.
