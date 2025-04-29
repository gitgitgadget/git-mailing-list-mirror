Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF741238D49
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963931; cv=none; b=ot103IErqIpQgWGQ/SVsX1w6nzHy1qCL1nntdHsAIhgmz+gFVAvOuoDOgfHQYCtpzJ7dl2IO0UwPQI8VFKy1GJgsCav9fcBNio4H1KAHhy5W0E20Z1t3KxGUEEci076b6jMRWBqKwuF2YSG9TraxCMGV2ay5OgEs0Divzyk6Rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963931; c=relaxed/simple;
	bh=jMYcNfnxmOYfgnk0vfFRVFTW22JlcKPShgiz5/0mGFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEdTmVX0YaaBag7CaelZWy6ff76d1DmonLFsVRrv0ymfRY/rTAkK6q6WW5ZfOZcwXHYGmDIGrOzpmkHA8ZrgvTZLHcuvB6/rPkzGlqxqe8anP0ufRg4/XFk51hTw276E33VjEpsFUf1Yz4xb7Ot2VpjfPqOExElVpVL3gnjNoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IBw70c3L; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IBw70c3L"
Received: (qmail 8642 invoked by uid 109); 29 Apr 2025 21:58:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jMYcNfnxmOYfgnk0vfFRVFTW22JlcKPShgiz5/0mGFY=; b=IBw70c3Ld3q6Y9PaT/3Va5Vg8HVT2TKdjpNMLUOhng6ikEVsa7HN1ZryTuJ+vuD3Ly2dgXwIyn5/pVFCWRMn5Qh+fxBwcoSPbsrau26m1g2ehRcvAehnw8XzYDwYqWXwzNtK+r+ShE6KByfTHIpdeHUHHDGs9HkIxs4J7A8wEK9Wwat7fjgwuZla44N9QYhE1XMNxr5vRk47cPe1y2cGsQMVEQptNu1dQMUI09anyvFctCMeeahx3S3DhZt7vLFm5TmjZoemN8TKs2sF/uh+rl5Kz+54VWMWqSY9+c9ose1wnFJnNRpIAA+HtFYBpPHQ30Ie48UUGaRqXcoWfjVimw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Apr 2025 21:58:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13617 invoked by uid 111); 29 Apr 2025 21:58:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Apr 2025 17:58:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Apr 2025 17:58:47 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] diff: check range before dereferencing an array
 element
Message-ID: <20250429215847.GB36727@coredump.intra.peff.net>
References: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
 <pull.1887.v3.git.1745926679028.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1887.v3.git.1745926679028.gitgitgadget@gmail.com>

On Tue, Apr 29, 2025 at 11:37:58AM +0000, Johannes Schindelin via GitGitGadget wrote:

> This CodeQL rule unfortunately is also triggered by the
> `fill_es_indent_data()` code, even though the condition `off < len - 1`
> does not even need to guarantee that the offset is in bounds (`s` points
> to a NUL-terminated string, for which `s[off] == '\r'` would fail before
> running out of bounds).
> 
> Let's work around this rare false positive to help us use an otherwise
> mostly useful tool is a worthy thing to do.

Since this is marked as fixing a false positive, and since it presumably
_does_ fix the false positive in practice, this is OK with me.

But...

> --- a/diff.c
> +++ b/diff.c
> @@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
>  
>  	/* skip any \v \f \r at start of indentation */
>  	while (s[off] == '\f' || s[off] == '\v' ||
> -	       (s[off] == '\r' && off < len - 1))
> +	       (off < len - 1 && s[off] == '\r'))
>  		off++;

...since the same pattern exists for the other s[off] checks, is it
worth future-proofing this like:

  while (off < len - 1 &&
         (s[off] == '\f' || s[off] == '\v' || s[off] == '\r')

?

I say "future proofing" because we don't know whether future versions of
CodeQL might complain about them. Presumably it does not yet because it
isn't smart enough to look outside the parenthesized &&-condition. But
if reading s[len] would be a problem for the '\r' check, it would be for
the others as well.

-Peff
