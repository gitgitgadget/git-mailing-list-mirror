Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58DC33FE
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741911; cv=none; b=LRMOa2DgYmxwtf2ecljXzKvAFV3LipNEsdfR/OVIt2yY+Vc+br3RAAYUodbhZejp8b8tNkzeA0vkYuMo026OWqW+4dTMlbk3R/aR9kijcXGUIzCWqgZW9gJUY/1COcE53unvZKNNUhrqv7Qt4yu9jUUVmJZih1agLMCrg7KRg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741911; c=relaxed/simple;
	bh=lYfj3YEQWqE9/e0U3gm+GjEWW++fiDfOeExExxyIbec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYjJ4FVMpqZi3H4NH4mMUhiIkadDWfMBalTQ3VzvZvdg6F3WQ8UTPpL7T3zbPo++bbAyn9KmrSmetGQ7F4WzIL1Va0XEe7FMjZlXek5CG2fUrgSzEHqu41ifEh8huQmbbKzvawwiLPhye5BqIABkQAd/2ySjQGjPMJydeJ2XZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I/F3AGxZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I/F3AGxZ"
Received: (qmail 12803 invoked by uid 109); 4 Nov 2024 17:38:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lYfj3YEQWqE9/e0U3gm+GjEWW++fiDfOeExExxyIbec=; b=I/F3AGxZJ/nuWgJczvVTEOhCzZ1ST/o0b7jNSXq7Uev/vn5qVSxnS795RgGWlTpEFPkn86ABRB/x3oNdRljnbEUbr4ee7gm8gZZ0O0EDdWAKsXC8lCpX6Ffqsgl/cLyfuq1nhk/v4UJ8n+lUdqefL0Q4FL1mwCXgCd3qUormTmmx1tdqNGJR9U5hGOuODpX0Tp3I5stw1J9wBduRHRF6d4B9bzeDf2YA8B8QX73ke6z/2krY5iSAdk2ZrgXVyFOyQLVslsOde5Gx5heeCRfmw0zi6nVuBVood9/GA/GAbXMLMWysy4oHbqccxuhdnGVIwmeLZHRe5DCb7PhFAI5hSg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Nov 2024 17:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14659 invoked by uid 111); 4 Nov 2024 17:38:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2024 12:38:28 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Nov 2024 12:38:28 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v5 8/9] config: make `packed_git_(limit|window_size)`
 non-global variables
Message-ID: <20241104173828.GC2989472@coredump.intra.peff.net>
References: <cover.1730714298.git.karthik.188@gmail.com>
 <2730aacd8e5add0918d806131d0f31a0b2474915.1730714298.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2730aacd8e5add0918d806131d0f31a0b2474915.1730714298.git.karthik.188@gmail.com>

On Mon, Nov 04, 2024 at 12:41:46PM +0100, Karthik Nayak wrote:

> @@ -652,8 +651,11 @@ unsigned char *use_pack(struct packed_git *p,
>  				break;
>  		}
>  		if (!win) {
> -			size_t window_align = packed_git_window_size / 2;
> +			size_t window_align;
>  			off_t len;
> +			struct repo_settings *settings = &p->repo->settings;
> +
> +			window_align = settings->packed_git_window_size / 2;
>  
>  			if (p->pack_fd == -1 && open_packed_git(p))
>  				die("packfile %s cannot be accessed", p->pack_name);
> @@ -661,11 +663,12 @@ unsigned char *use_pack(struct packed_git *p,
>  			CALLOC_ARRAY(win, 1);
>  			win->offset = (offset / window_align) * window_align;
>  			len = p->pack_size - win->offset;
> -			if (len > packed_git_window_size)
> -				len = packed_git_window_size;
> +			if (len > settings->packed_git_window_size)
> +				len = settings->packed_git_window_size;
>  			win->len = (size_t)len;
>  			pack_mapped += win->len;
> -			while (packed_git_limit < pack_mapped
> +
> +			while (settings->packed_git_limit < pack_mapped
>  				&& unuse_one_window(p))
>  				; /* nothing */

Much nicer than the earlier version of the patch.

Do we need to call prepare_repo_settings() here? It looks like the
intent is that it would be lazy-loaded, and I don't think there's any
guarantee that somebody else would have done so.

> @@ -123,6 +124,19 @@ void prepare_repo_settings(struct repository *r)
>  	 * removed.
>  	 */
>  	r->settings.command_requires_full_index = 1;
> +
> +	if (!repo_config_get_ulong(r, "core.packedgitwindowsize", &longval)) {
> +		int pgsz_x2 = getpagesize() * 2;
> +
> +		/* This value must be multiple of (pagesize * 2) */
> +		longval /= pgsz_x2;
> +		if (longval < 1)
> +			longval = 1;
> +		r->settings.packed_git_window_size = longval * pgsz_x2;
> +	}
> +
> +	if (!repo_config_get_ulong(r, "core.packedgitlimit", &longval))
> +		r->settings.packed_git_limit = longval;

And this looks like a faithful conversion of the existing parsing. Since
we're switching from git_config_ulong() to repo_config_get_ulong(), we
could take the opportunity to swap out for the size_t parser, but:

  1. I'm just as happy for that to happen separately, and leave this as
     a patch which should not have any behavior change.

  2. It looks like we do not yet have a size_t variant for the configset
     accessors. :)

-Peff
