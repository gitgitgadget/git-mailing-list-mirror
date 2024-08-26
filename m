Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1731450EE
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691320; cv=none; b=lHO7FwrI2PmHF+CkIlUrByOOck5FvMj4ZEM0Ew2NwnflXNYVavy1jekDN+y8+vNS8aL6mVkEEC68lrRLDs301PWPcnjZFTDbKqx5DaQgNtuXmDjOwUf56W2HpMI4hgLe0F87oKNfp+NZ+ghVyOYPj2pJGGaEZaak+juldBznAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691320; c=relaxed/simple;
	bh=2WWe/snhi7o3uel5tPvm3WXafRmVY6gaKwlJOX+VCeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XYUVOaTB+l4xUrf1leSM+ucqqZ2zBlMpeeC7++fljh26oh14K5iHFw7htcEOgJI6EiPDYDfEUd8LZe+d+CINcW3abcdeePznfdv5a1rvmJ50cV3TTmpP0Jt5Y0qiu2z+I84UkWZXSjPsGs+8eRTpeNA9bY0DR54Nn4w2ChGYSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W9wtmUvb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W9wtmUvb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 768CF27A40;
	Mon, 26 Aug 2024 12:55:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2WWe/snhi7o3uel5tPvm3WXafRmVY6gaKwlJOX
	+VCeM=; b=W9wtmUvbq7KhRfwT8Pfta80gZJiLE3MC9JQbp/Eksx54TnS3PdsmmW
	TussgMbgr2NtDTuvk+Bxr033NdKuZdIpaAmuXYp780Z2pEqTQaM8IMalu4XT2+vW
	xLYFYC6D4XqBMkjFj3IFhadkVixMTQF+DTzZ86faXRKj81XP1PGzw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F04D27A3F;
	Mon, 26 Aug 2024 12:55:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ECDC927A3D;
	Mon, 26 Aug 2024 12:55:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 03/10] packfile: fix off-by-one in content_limit
 comparison
In-Reply-To: <20240823224630.1180772-4-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:23 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-4-e@80x24.org>
Date: Mon, 26 Aug 2024 09:55:13 -0700
Message-ID: <xmqq1q2bmdfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F7465678-63CB-11EF-8473-BF444491E1BC-77302942!pb-smtp20.pobox.com

Eric Wong <e@80x24.org> writes:

> object-file.c::loose_object_info() accepts objects matching
> content_limit exactly, so it follows packfile handling allows
> slurping objects which match loose object handling and slurp
> objects with size matching the content_limit exactly.
>
> This change is merely for consistency with the majority of
> existing code and there is no user visible change in nearly all
> cases.  The only exception being the corner case when the object
> size matches content_limit exactly where users will see a
> speedup from avoiding an extra lookup.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---

I would have preferred to see this (and also "is oi->content_limit
zero?" check I mentioned earlier) as part of the previous step,
which added this comparison that is not consistent with the majority
of existing code.  It's not like importing from an external project
we communicate with only occasionally, in which case we may want to
import "pristine" source and fix it up separetly in order to make it
easier to re-import updated material.

>  packfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/packfile.c b/packfile.c
> index c12a0515b3..8ec86d2d69 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1557,7 +1557,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  		}
>  
>  		if (oi->contentp) {
> -			if (oi->sizep && *oi->sizep < oi->content_limit) {
> +			if (oi->sizep && *oi->sizep <= oi->content_limit) {
>  				*oi->contentp = cache_or_unpack_entry(r, p, obj_offset,
>  								      oi->sizep, &type);
>  				if (!*oi->contentp)
