Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B924DFE6
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012149; cv=none; b=hHTLFXmv2wFKkFp35+K5LnZZ/CTkpRSp/7/DjpJMl3nDv2uKyCTBNPwzi5h0RE85UnDsUfrIOj8xXv8AmnMXfhRoFpT5a0gnStGKMFRJlUg+XSDHGz9LJC8kQLR0WeCvGf7J1oQgvor378lnLgnlG4FPedqwQcWun3BGOBS+5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012149; c=relaxed/simple;
	bh=ZMFLH760xFThhcxVF2oO5uyNXdC2ybkT3WP6AMOlQU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY+HBkaGvIiNZpnGq/L4Bc24GXfRmtpaWbd/+Hc5yWtvUb2q5Cu05QHyQ3+zmaaQy8o39BPfFPdIJ3JwsUv+H+MjF77RMS62MnRSwrAOw+ymm+epWbHmhwA36zoDDQam3NQ7QDe9On9c+yhj9krj8RbRpdhk00kxxcC1MqnnDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h/9JRl6e; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h/9JRl6e"
Received: (qmail 13805 invoked by uid 109); 26 Mar 2025 18:02:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZMFLH760xFThhcxVF2oO5uyNXdC2ybkT3WP6AMOlQU0=; b=h/9JRl6eG031+8FRPpR3383dpSUDsqAfm7Lntb2aAVGZenbvfMlKkTxMzKPqGT4QKMzewNkDovZUvVwTJ3+DH//WuqBfxCYp0EQ0Qo76x9lno/wgGyyDQVDwOjfPk25WMMG/i7Vt8gvUysPN3CNw7oG0dKj6ikoAT4Oglhf5YbkJBtJwQSOjxdY4KYcbuRMI6rB/vH5IYlc3zdkE81dK+rHM7bAycLinw8AJzqQlSOAmE+/pwVt0uWfVRa/eVBjzZvEcSW3+CElChSBN+1SCWYEqZ9Jm6TWpQpcm1lM1AVYR7MHmY3gu15lwP1MrQuniI0ZSHjJLm7PF3aDTr5uSjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Mar 2025 18:02:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18006 invoked by uid 111); 26 Mar 2025 18:02:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Mar 2025 14:02:25 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Mar 2025 14:02:25 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] read-cache: check range before dereferencing an
 array element
Message-ID: <20250326180225.GC2508080@coredump.intra.peff.net>
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
 <d4e94a243b0633ab18daa6ce0ae766d5bc33364e.1743010011.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4e94a243b0633ab18daa6ce0ae766d5bc33364e.1743010011.git.gitgitgadget@gmail.com>

On Wed, Mar 26, 2025 at 05:26:51PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Before accessing an array element at a given index, we should make sure
> that the index is within the desired bounds, not afterwards, otherwise
> it may not make sense to even access the array element in the first
> place.

Certainly we should, but...

> diff --git a/read-cache.c b/read-cache.c
> index e678c13e8f1..08ae66ad609 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2686,8 +2686,8 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
>  		int common, to_remove, prefix_size;
>  		unsigned char to_remove_vi[16];
>  		for (common = 0;
> -		     (ce->name[common] &&
> -		      common < previous_name->len &&
> +		     (common < previous_name->len &&
> +		      ce->name[common] &&
>  		      ce->name[common] == previous_name->buf[common]);
>  		     common++)

Is previous_name->len an actual bound for ce->name?

I think we are iterating through ce->name looking for either the
terminating NUL, or matching the prefix from previous_name. So the
length check is for the third condition:

  ce->name[common] == previous_name->buf[common]

and correctly comes before it.

So unless I'm mistaken, this is a false positive in CodeQL. I don't mind
re-ordering the condition to fix it, but the commit message should
probably say so.

Since previous_name is a strbuf, it is also NUL-terminated (and interior
NUL bytes cannot be important, because we are comparing against a
NUL-terminated ce->name). So I suspect that a simpler way to write it is
to remove the length check and rely on the NUL/not-NUL mismatch to
break, like:

  for (common = 0;
       ce->name[common] &&
       ce->name[common] == previous_name->buf[common];
       common++)

Which would also presumably remove the warning.

-Peff

PS I notice that "common" is an int, which always makes me wonder what
   would happen with a 2GB+1 filename. But I think that is nothing
   specific here, as there are ints all over the place for index name
   lengths. And anyway, one thing at a time, I suppose. :)
