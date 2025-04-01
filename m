Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741D1FBEB0
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507983; cv=none; b=PkAARny80d+1m+U3+LhMLFqtudpu8Knnd1rN18cevRcbh9UOGBi21FoyjJm53NxzE/GAFewQxpMp7UjEG+S3P2GAMZLewdQoUjr7QlifaDutWI9aunR/HXhqxI9EPK2FzcD7imSzpxnNXs3/HH4QCoFfCOzfHU+nrkfmeogcxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507983; c=relaxed/simple;
	bh=E1Exsmd8ZUCSPCosN5BDrCJKycWr9lbHLVYQfrGGfHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z0ICvGlgg350/QxR6G6s/u+M9VP4U2jcsDj0WWJ+DbnKSTFT/pqXEGJrwwYwyrd/8pIhT2EBqzKA2MF4PBdplf+S/Xk/Abm8K1qSw/6XgYH3JBQUOJ2xH6IAi5KPXvQ4fw3GgkpuMKEVEKCF3+WPYXUA549QV86keROy38vy4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=6RgarBuJ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="6RgarBuJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743507978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3eKJdy1ALtnXuO78z63uCPImmuD+11d2p2y0agAEgg=;
	b=6RgarBuJ6JdpPQwF6Ak+HICMMqp46Tdbl1UqkRZHBUQxUnzmijQpSFKiBgiaauTbb3Vj2f
	3yOSZyIbOii7F4TaC4CUBA6umtYBVc71dBsqOQR3xMr0Hv6bMxSLE6l0ernb81LKL+p7fE
	L7VzTli5pIGKDzAy4O4oF9QjaOyeVBU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/10] pack-bitmap: introduce function to check
 whether a pack is bitmapped
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-8-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-8-4bbc7085d7c5@pks.im>
Date: Tue, 01 Apr 2025 13:46:09 +0200
Message-ID: <87plhwf6ke.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a function that allows us to verify whether a pack is
> bitmapped or not. This functionality will be used in a subsequent
> commit.
>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pack-bitmap.c | 15 +++++++++++++++
>  pack-bitmap.h |  7 +++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 6adb8aaa1c2..edc8f42122d 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -745,6 +745,21 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
>  	return NULL;
>  }
>  
> +int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
> +{
> +	for (; bitmap; bitmap = bitmap->base) {
> +		if (bitmap_is_midx(bitmap)) {
> +			for (size_t i = 0; i < bitmap->midx->num_packs; i++)
> +				if (bitmap->midx->packs[i] == pack)
> +					return 1;
> +		} else if (bitmap->pack == pack) {

Here, and two lines above, we compare packs by their pointer address,
this doesn't seem to be common practice to me. Or is it in the Git
codebase? Do we expect any problems with this, for example when we stop
using `the_repository`?

-- 
Toon
