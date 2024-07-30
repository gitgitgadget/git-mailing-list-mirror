Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E313B780
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324690; cv=none; b=QH3eF63k9oYogC2ttf8MSaEV2n+PQs+WvNzDcGQvsj7OH3Xr404RPUZSTmjl4AGrUc1SvyBQACJ9JEBYeWqpddZgdkcM3MxmnEfGzJsoKaITxe09eSzbbEhjWESbbh+zUuG84/KY9Wfi078YUuclVgVKyfSIAPBvSwRohnpf7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324690; c=relaxed/simple;
	bh=R/ir39uqtHkAlHdUqNaPpqY4cesuoFZEflW/Q4tPcRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbxhSq2parRN6UI4upL1DFr/Tv3UkDW5pOUb2mvp/J2VCyqpj57UR+Os6Wft6XMCc5u9WnChhyg6LyLY0fSF/wXFgs2YQQ9kbsHgwiA3XiZfirJUsXYYqvgNQFKE5q3IunCYqksWagjfk1ctyoD15JpCz49hHd81TKsif4A1cEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27701 invoked by uid 109); 30 Jul 2024 07:31:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jul 2024 07:31:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8506 invoked by uid 111); 30 Jul 2024 07:31:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2024 03:31:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jul 2024 03:31:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/3] safe.directory: normalize the configured path
Message-ID: <20240730073119.GA562212@coredump.intra.peff.net>
References: <20240723021900.388020-1-gitster@pobox.com>
 <20240720220915.2933266-1-gitster@pobox.com>
 <20240730011004.4030246-1-gitster@pobox.com>
 <20240730011004.4030246-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730011004.4030246-3-gitster@pobox.com>

On Mon, Jul 29, 2024 at 06:10:03PM -0700, Junio C Hamano wrote:

> Two and a half things to note, compared to the previous step to
> normalize the actual path of the suspected repository, are:
> 
>  - A configured safe.directory may be coming from .gitignore in the
>    home directory that may be shared across machines.  The path
>    meant to match with an entry may not necessarily exist on all of
>    such machines, so not being able to convert them to real path on
>    this machine is *not* a condition that is worthy of warning.
>    Hence, we ignore a path that cannot be converted to a real path.

Thanks, I think this addresses my concern. One small thing I noticed in
the patch:

> @@ -1236,14 +1236,43 @@ static int safe_directory_cb(const char *key, const char *value,
>  
>  		if (!git_config_pathname(&allowed, key, value)) {
>  			const char *check = allowed ? allowed : value;
> -			if (ends_with(check, "/*")) {
> -				size_t len = strlen(check);
> -				if (!fspathncmp(check, data->path, len - 1))
> +			char *to_free = NULL;
> +
> +			/*
> +			 * Setting safe.directory to a non-absolute path
> +			 * makes little sense---it won't be relative to
> +			 * the configuration file the item is defined in.
> +			 * Except for ".", which means "if we are at the top
> +			 * level of a repository, then it is OK", which is
> +			 * slightly tighter than "*" that allows discovery.
> +			 */
> +			if (!is_absolute_path(check) && strcmp(check, ".")) {
> +				warning(_("safe.directory '%s' not absolute"),
> +					check);
> +				goto next;
> +			}

This is_absolute_path() check is redundant, isn't it? If we are checking
for a literal ".", then we know the patch must be non-absolute.

-Peff
