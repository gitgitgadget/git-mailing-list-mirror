Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8A26B971
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764363325; cv=none; b=UYU0I4Y5YNczOpy7aRg4Nqn8UWSJFkY4XMCaVpCyx/kLAorCxWFfBTMd4a6Y/LM0M3p5gPCeR3gNoST/+mS94r1IBzCwDjhEFgGu+h6c1vvoFfPEuBshuvB4H+OhEAWvmgQTKN6lGRkh0hQ0GEZoJZzdYngPyS0o4tOmlXGa5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764363325; c=relaxed/simple;
	bh=6rLRYlWmd+5L21ZmMA/GitkF3+BsedpOgtNyFOrbCk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq2XMBlWrYzxsPxYT5J6fH+IwczT3Fy2greNHugm98UKcY7rJ8Q+wRdA3RVLS0fOgiDzAqX49PzNHxghEP9Rdna6vu8RfNK0SNn7a9kPIXmXk5rH4j0b87Nag6K2Hm8WcQZ2FYtcDfhT5PNBbYZT6JQ3eB7YK1/gW349MTzWB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Yv9YH48r; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Yv9YH48r"
Received: (qmail 134358 invoked by uid 109); 28 Nov 2025 20:55:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6rLRYlWmd+5L21ZmMA/GitkF3+BsedpOgtNyFOrbCk8=; b=Yv9YH48r4OfBhYEjhIvEm0rzO1YrKF6/eYFiUfUrTfa2SeIEnGiEQdhOZwrO7pUSL7TGoxFdbjzcLFKj2Pu8dw/98YBpPcaG3HlHYghy8EdwSlg8okRjl9rQmgCVdSNRJr8xce+VLfipcsKKMR30xLgyfwFkG6Zy87LVMpvk7HjFQdC/BGfFCYKJwacvJZV9MUMM05IcAhqOsR4tBeFVSaHGm+PHDAz4ffmCzyK3cYlXY9BnynTcZavOKOZDEwatmKdlQVxzt0taXD4qJJ7tOTYhw4fjIuCs0ggmqX1Re1/wOdcieD/Y4Pejz82Wcxxat7JDc6/CGnHQvN1i7HvT/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Nov 2025 20:55:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 227124 invoked by uid 111); 28 Nov 2025 20:55:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Nov 2025 15:55:16 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 28 Nov 2025 15:55:14 -0500
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Anders Kaseorg <andersk@mit.edu>
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
Message-ID: <20251128205514.GA605489@coredump.intra.peff.net>
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>

On Fri, Nov 28, 2025 at 05:37:13PM +0100, Toon Claes wrote:

> git-last-modified(1) uses a scratch bitmap to keep track of paths that
> have been changed between commits. To avoid reallocating a bitmap on
> each call of process_parent(), the scratch bitmap is kept and reused.
> Although, it seems an incorrect length is passed to memset(3).
> 
> `struct bitmap` uses `eword_t` to for internal storage. This type is
> typedef'd to uint64_t. To fully zero the memory used by the bitmap,
> multiply the length (saved in `struct bitmap::word_alloc`) by the size
> of `eword_t`.

Good catch! When I was looking for casts that could be the culprit, I
didn't think about the implicit one we get through the void pointer of
memset().

> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index b0ecbdc540..cc5fd2e795 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -327,7 +327,7 @@ static void process_parent(struct last_modified *lm,
>  	if (!(parent->object.flags & PARENT1))
>  		active_paths_free(lm, parent);
>  
> -	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
> +	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc * sizeof(eword_t));
>  	diff_queue_clear(&diff_queued_diff);
>  }

I think this patch makes sense as the most obvious and immediate fix.
But thinking on how we might have avoided this bug:

  - We have macros like ALLOC_ARRAY() and COPY_ARRAY() that
    automatically multiply the array length by the size of each element
    (by looking at the type of the array). We could in theory have a
    helper like:

      MEMSET_ARRAY(lm->scratch->words, 0x0, lm->scratch->word_alloc);

    that would have made this hard to get wrong. But that's actually a
    bit of a funny interface, because memset is inherently byte-oriented
    under the hood. So we are not setting each element to 0x0, but
    rather each byte. For a value of 0x0, that is the same thing. But if
    you chose, say "0x1", it is not.

    So it would probably have to be limited to something like:

      CLEAR_ARRAY(lm->scratch->words, lm->scratch->word_alloc);

    which I'd guess would cover most memset cases. But this is getting
    specific enough that maybe the macro is making things more confusing
    rather than less.

  - It's a little gross that we are reaching inside a "struct bitmap" in
    the first place, as it's a mostly opaque type. And the code here has
    to know that the alloc field is sized in eword_t's, not in bytes.

    It feels like there should be a bitmap_clear() function. Its
    implementation would also have to remember to multiply by
    sizeof(eword_t), but at least it would be encapsulated.

    I doubt the leaky abstraction matters that much, though. It seems
    unlikely that we would change it (and if we did, we'd perhaps give
    the field a new name).

    In the same vein, probably using "sizeof(lm->scratch->words)" is
    better than "sizeof(eword_t)". But again, I find it an unlikely
    detail for us to catch under the hood.

-Peff
