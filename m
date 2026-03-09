Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964134CB5B
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083306; cv=none; b=GkayZZAaURBSB9hp5081Re1lxHfAaueg/WUTRJ7FSFb0pceZhU5CCuEA2MYsLT8ROQoGKTNI+jaCB7m5ZFoGcKfNOXQoQUoOimHL0dgqD726yINtj+bmbWVpw8Ad2WsLne1vzeb7v06sidJ81SXUzqBUN+nKLydsftut/4NNiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083306; c=relaxed/simple;
	bh=MNfGV6C6EFzJW1xzt0MupOnPdCAGCKbzi8HN3+ZRJsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyR2SDdR/3ONYmxo67yYF8gspoXPnmC1uixYvAC1M3CzddVTo8gWgMyLe0Kk7orEfDX2P71a4/nB+E5unjInG6fdf+oI2d7uZuKCt/RLHhA/v1yqXe/X0K7SLAg7swWFF2d9gYGjPOWoSqdjYxfmAf8l7XvX4ZN4fYS4BjWMAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QwORIXV3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QwORIXV3"
Received: (qmail 49690 invoked by uid 106); 9 Mar 2026 19:08:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MNfGV6C6EFzJW1xzt0MupOnPdCAGCKbzi8HN3+ZRJsw=; b=QwORIXV3+6G+X7JCjYj5lsEHnGIjzrysIuruWKeB/Iug8IsYlpu00Uy0qDtnR1XZ+d5KyV7RrFR+syjnwpL3g/5peaLhf7izDa/j3YLEin27Y3eQbmPY4crRLySejj82MNRo7y/fTXOWc+MEK882G+5RKWD82dV/vlY2WCSGu5ZDfOWAEnzm1uEOMQsef4AztlAi+l+gDnS8TwKP1gozSvHAZFsx8Hg7TniKjYXbym/BexBhiSIAtB90+0UVz5wyGMQabj2FYt4FOhxHIW2gHAmR7dqgx+POo2hczeuflDczToUxQRI0zmBacfAIQz5hlOMIkYyPtSrN5uE1zWnAVQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Mar 2026 19:08:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 458127 invoked by uid 111); 9 Mar 2026 19:08:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Mar 2026 15:08:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Mar 2026 15:08:23 -0400
From: Jeff King <peff@peff.net>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 2/2] list-objects-filter-options: avoid
 strbuf_split_str()
Message-ID: <20260309190823.GB309867@coredump.intra.peff.net>
References: <20260308180359.31188-1-deveshigurgaon@gmail.com>
 <20260308180359.31188-3-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260308180359.31188-3-deveshigurgaon@gmail.com>

On Sun, Mar 08, 2026 at 06:03:59PM +0000, Deveshi Dwivedi wrote:

> +	while (*p && !result) {
> +		const char *sep = strchr(p, '+');
> +		size_t len = sep ? (size_t)(sep - p + 1) : strlen(p);
> +		char *sub = xmemdupz(p, len);

The cast to size_t made me look twice to see if something tricky was
going on. We don't usually bother explicitly casting from a ptrdiff_t
into a size_t.

However, might this all be simpler with strchrnul? Something like:

  const char *end = strchrnul(p, '+');
  char *sub = xmemdupz(p, end - p);

  ...parse sub...

  if (!*end)
	break; /* found NUL at end of string */
  p = end + 1;

Notice I cut off the "+" when we find it, because I think...

> +		/* strip '+' separator, but only when more sub-specs follow */
> +		if (sep && *(sep + 1))
> +			sub[len - 1] = '\0';

...this is wrong. I know you are matching what the current code does,
but it does not match the documentation, and does not actually make any
sense in practice.


Other than that, this looks nice, and I am happy to see more
strbuf_split() calls going away.

I think you could in theory drop the xmemdupz() here, too, and feed the
ptr/len combo into parse_combine_subfilter(), which then percent-decodes
into a newly allocated buffer. But it is probably not worth trying to
squeeze out one extra allocation here. It is not like people have huge
lists of combined filters; we'd expect to see a couple at most.

-Peff
