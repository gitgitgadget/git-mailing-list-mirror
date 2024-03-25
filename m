Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612495B669
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399015; cv=none; b=GpvzSjFQiGdyhrQ8+W6652yllEU9nZ3atSRKW3Cf7VzraUCT/hwgaE8vcNRz8tuXy0XivAiGTBB8lWoXKSf4EJcwYO8giB7L/QVFfADZPBxtnofBsuGllgv6Glo8bowAFL7/mWTYqTTBFgs8y28AW/NvkJI7hDWx6vnh8q5oPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399015; c=relaxed/simple;
	bh=9L4sZ0l6FBqwGmVYa02z5FvgnvakqZyBvxH0sYxIc3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P6LP622BELoCtafrUoxeYbAlmauVPWmE//0bFT7E7QbS8I/va3VjlTcj31R6g3F+ZmkY30uYWXp7ovXZE3LX8lmegfGIgn3fndLaAytOh1lF4WNj78HThjmrIByCuy3+cj/zTElqH1Lph/KkJLIxUugZJzxHsH5wgWnFkEEeY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EhV5dKcx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EhV5dKcx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CDDF430C6B;
	Mon, 25 Mar 2024 16:36:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9L4sZ0l6FBqwGmVYa02z5FvgnvakqZyBvxH0sY
	xIc3A=; b=EhV5dKcx5aPwank0pEoswD2yQsXQdOmBtWdnPdD+SQ/fkP79Ua3gAZ
	3x1un6A4VcwmSavMRaLEGHSwIlGecAjxwTJudKsuOKvUhjqGsbFPW1/8hr/p1jcc
	BrSHqjQKSb02YFsGpTBD1tVlph3sB82vZdnQ9lSLdLSP3Z42U9Uyc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C0D7230C6A;
	Mon, 25 Mar 2024 16:36:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2646E30C68;
	Mon, 25 Mar 2024 16:36:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/11] midx-write.c: factor out common
 want_included_pack() routine
In-Reply-To: <5475b09a7afc4d55a8e1a1a72f20fa9109447cec.1711387439.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 25 Mar 2024 13:24:44 -0400")
References: <cover.1711387439.git.me@ttaylorr.com>
	<5475b09a7afc4d55a8e1a1a72f20fa9109447cec.1711387439.git.me@ttaylorr.com>
Date: Mon, 25 Mar 2024 13:36:48 -0700
Message-ID: <xmqqo7b2hwv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6834E600-EAE7-11EE-9E72-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/midx-write.c b/midx-write.c
> index 89e325d08e..2f0f5d133f 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1349,6 +1349,24 @@ static int compare_by_mtime(const void *a_, const void *b_)
>  	return 0;
>  }
>  
> +static int want_included_pack(struct repository *r,
> +			      struct multi_pack_index *m,
> +			      int pack_kept_objects,
> +			      uint32_t pack_int_id)
> +{
> +	struct packed_git *p;
> +	if (prepare_midx_pack(r, m, pack_int_id))
> +		return 0;
> +	p = m->packs[pack_int_id];
> +	if (!pack_kept_objects && p->pack_keep)
> +		return 0;
> +	if (p->is_cruft)
> +		return 0;
> +	if (open_pack_index(p) || !p->num_objects)
> +		return 0;
> +	return 1;
> +}

OK, makes sense to return false when we do not want the caller
proceed with the pack for a function whose name is want_*_pack().

