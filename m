Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD81C8FC0
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197989; cv=none; b=cqkVur2xh4ctSXMGqBmnVEWchbPGRFeTDncqHYqtWCob6gQlfdusflyzOga3SJb9uGlpJSK52P7A9782/oJIBJ5DtsITG9ef/2KozUnhb4CQV2M+EYOmB1k3su/zgl/zsdvPZsy8ffjrAihrT525stFF258nj4oErdaemgGhafk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197989; c=relaxed/simple;
	bh=xEu8mThWYz/L6Ucy9vTg/ZUYApCahlDn+25UXFM/7oI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzP3n8zqhaO4S91hm4WFLxxPpGPmiQ/FhKb+zv+SsfU0Lu2MRcAoamki5b/IPAka3+15mxMIY3DDj01wd710MV5VYG6yT7FbUw51U1xi4y2nixDBZz5cxvXbOUmrXBcuwIXJ9iJB1OdsUh+bk3bKSZoj5gEypcLfvgWxGH4cpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hpzurx4w; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hpzurx4w"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B6C6928358;
	Tue, 20 Aug 2024 19:53:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xEu8mThWYz/L6Ucy9vTg/ZUYApCahlDn+25UXF
	M/7oI=; b=hpzurx4wycO9XyPjFGAvoPgPmuyb9gzsdgZStpHSTCfDEtNhmvAKZp
	rL6DftwaRgpbS/hX9ErMct6AhbWchL8XIAL/WJeHDbchO04IsbxicjhcdkgQ1nSH
	pMkQY47tGLlS/lKbm7d8UCy8cU0u8JNnvE8gJta96ChBikMxTtQvY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9804828357;
	Tue, 20 Aug 2024 19:53:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8BF0A28355;
	Tue, 20 Aug 2024 19:53:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 13/20] sideband: fix leaks when configuring sideband colors
In-Reply-To: <5d09959b6426e53a68e1bce547f9507bdf21bcde.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:41 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<5d09959b6426e53a68e1bce547f9507bdf21bcde.1724159575.git.ps@pks.im>
Date: Tue, 20 Aug 2024 16:52:59 -0700
Message-ID: <xmqqv7zu3g6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 55A78650-5F4F-11EF-A909-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We read a bunch of configs in `use_sideband_colors()` to configure the
> colors that Git should use. We never free the strings read from the
> config though, causing memory leaks. Fix those.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  sideband.c                          | 8 +++++---
>  t/t5409-colorize-remote-messages.sh | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/sideband.c b/sideband.c
> index 5d8907151fe..deb6ec0a8b7 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -30,7 +30,7 @@ static int use_sideband_colors(void)
>  
>  	const char *key = "color.remote";
>  	struct strbuf sb = STRBUF_INIT;
> -	char *value;
> +	char *value = NULL;

Hmph, this is a bit unfortunate.  If there is no configuration
variable, on the first call to this function, we come to the end of
if/else cascade and we need to free.

Another possibility to convey the intention better may be to assign
NULL to value after the "we already know the value, so return early"
took place.

> @@ -43,15 +43,17 @@ static int use_sideband_colors(void)
>  	} else {
>  		use_sideband_colors_cached = GIT_COLOR_AUTO;
>  	}
> +	FREE_AND_NULL(value);

This can be a simple "free(value)"; I do not see the need to clear
the variable at this point.

>  	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
>  		strbuf_reset(&sb);
>  		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
>  		if (git_config_get_string(sb.buf, &value))
>  			continue;
> -		if (color_parse(value, keywords[i].color))
> -			continue;
> +		color_parse(value, keywords[i].color);
> +		FREE_AND_NULL(value);

Likewise.  I do not see the need to clear.  We only come here after
we got something from gti_config_get_string().  That value may or
may not fail color_parse(), but when we reach this point, value
always has something we need to free, not some leftover value from
the previous iteration.

The patch is _not_ wrong per-se, though.

Thanks.


