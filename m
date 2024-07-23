Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285414387B
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767956; cv=none; b=pXA096B8Og7L5vY7uMWjf8dTjDdyTCHdzGVLBHgOvZWyNGQe9Go4GISDYMqI6pPCv7ZRjz0Z9qUo30mX5IVpXtBSQRZ7MBAZwMGxzPAr6qYeh1gbmzY2pwzDY1WOlzslg2kkYxwy97D7jSMZjMEfeUK60lOz4RvvXYgaUlEYKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767956; c=relaxed/simple;
	bh=peRo3HVBhIMZM2qjnp5K8uRrstkXNllAStnrdAHw7g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNKw0/FF0CQl5oeqzYFyCAt65f5nP/5P5t6YoCT/AAkYuM5pfoa/tU/2UpaRvyRJRVq+wxvpu5dm/ajLsGGvE1QQJ3ANmGm+sfSmfCwA+Fu7IqO1LE8JCOPA1ipp7BMeHZobA1X2NoqeZrskU7cRsvvYMuOfslRNpCDKxXF15S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23294 invoked by uid 109); 23 Jul 2024 20:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jul 2024 20:52:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3173 invoked by uid 111); 23 Jul 2024 20:52:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jul 2024 16:52:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Jul 2024 16:52:32 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] refs: fix format migration on Cygwin
Message-ID: <20240723205232.GB6779@coredump.intra.peff.net>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <d031aef5552d894784650a8c6580925e877df794.1721731179.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d031aef5552d894784650a8c6580925e877df794.1721731179.git.ps@pks.im>

On Tue, Jul 23, 2024 at 02:31:28PM +0200, Patrick Steinhardt wrote:

> @@ -2874,10 +2882,14 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	 */
>  	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, 1);
>  
> -	free(new_refs->gitdir);
> -	new_refs->gitdir = xstrdup(old_refs->gitdir);
> -	repo->refs_private = new_refs;
> +	/*
> +	 * Unset the old ref store and release it. `get_main_ref_store()` will
> +	 * make sure to lazily re-initialize the repository's ref store with
> +	 * the new format.
> +	 */
>  	ref_store_release(old_refs);
> +	FREE_AND_NULL(old_refs);
> +	repo->refs_private = NULL;

I think this FREE_AND_NULL() is not technically part of the fix that the
commit message describes. It is fixing an existing leak that happens
when we overwrite repo->refs_private (whether with new_refs or with
NULL).

That said, I don't know that it's worth going back to split it out now.

The rest of the patch looks good to me, and the commit message nicely
describes the problem and solution.

-Peff
