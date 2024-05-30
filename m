Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FCD143727
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052743; cv=none; b=Q+QhJJuhbc6v3s2tCCqnCs66RpA9fOCVaBNS+1xGHZOpeXhgsZLaWFOlrair0MsabnykZQbds5eQlG/6YqxqkH8NNYL0PggtgAPJBJZNs8RJ8dibItQWQcCGWSfJM0Chb6F/n2zVjPI626HiNTJyA4Yqhq+J9+juQDLfmr2brcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052743; c=relaxed/simple;
	bh=QI8HoFIHWd/ZzPphTLkdGLEx+KqhME/A9oS015xY15Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJIv9dMqxidmfVCYeXIFon9ynYYWtY45bpDVKQyrsRUn3nyEeLoEnhjv+hT0omMEashbWeSph6rHBXpBUf9kRrOhOwOflh9UIv4V9Om1MIsEs7k6u8qcl126bWxIV6CJiNgsGXjnMR9snrQt7ChvTsasyAwYJhvdRmdvX7F0mrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16899 invoked by uid 109); 30 May 2024 07:05:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 07:05:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27945 invoked by uid 111); 30 May 2024 07:05:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 03:05:38 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 03:05:40 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] midx-write.c: support reading an existing MIDX
 with `packs_to_include`
Message-ID: <20240530070540.GB1949834@coredump.intra.peff.net>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
 <fe187b1939d9c74782306cd3e4fcd2f25451ad69.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe187b1939d9c74782306cd3e4fcd2f25451ad69.1717023301.git.me@ttaylorr.com>

On Wed, May 29, 2024 at 06:55:39PM -0400, Taylor Blau wrote:

>  static int should_include_pack(const struct write_midx_context *ctx,
> -			       const char *file_name)
> +			       const char *file_name,
> +			       int exclude_from_midx)

Hmm, so we grow a new flag...

>  {
> -	/*
> -	 * Note that at most one of ctx->m and ctx->to_include are set,
> -	 * so we are testing midx_contains_pack() and
> -	 * string_list_has_string() independently (guarded by the
> -	 * appropriate NULL checks).
> -	 *
> -	 * We could support passing to_include while reusing an existing
> -	 * MIDX, but don't currently since the reuse process drags
> -	 * forward all packs from an existing MIDX (without checking
> -	 * whether or not they appear in the to_include list).
> -	 *
> -	 * If we added support for that, these next two conditional
> -	 * should be performed independently (likely checking
> -	 * to_include before the existing MIDX).
> -	 */
> -	if (ctx->m && midx_contains_pack(ctx->m, file_name))
> +	if (exclude_from_midx && ctx->m && midx_contains_pack(ctx->m, file_name))
>  		return 0;
> -	else if (ctx->to_include &&
> -		 !string_list_has_string(ctx->to_include, file_name))
> +	if (ctx->to_include && !string_list_has_string(ctx->to_include,
> +						       file_name))
>  		return 0;

...that disables half of what the function is checking.

It makes me wonder if it should just be two functions (or if the callers
should just inline them, since they are themselves basically
one-liners). But I think this is getting into bike-shedding territory.
I'm OK with it as-is.

-Peff
