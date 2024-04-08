Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E4146D7A
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609715; cv=none; b=gQgThEnHz/07Azpx01JF3qginGDqMwSgMOZojP1HwTarXLqxYzjoYoTmCigfiRTObSbRAlcR1Bd9W6Qgwq0e9UZMjzb0d0rYRplJ/TSgLZH1SQRzsl9LXI7BccxxoyCpB0o301adEZ9s4n5egzwEGr67Lbhkta/ToA6thKKekV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609715; c=relaxed/simple;
	bh=1m+TEqOWvfgR2ep5A1GLs+BKhhcZgeuB04DDtjdbKf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEY4pQBgU/ygFTrJtZB9dWW8kgtaXYbPXmH+Q6JEnXLolglW6cbVKiRN0uj2pjXe9CzwW9tYlFdCXk2uOmpGowb86vRaf54yVCn6MUfKgNLTHkcvwLLwLLnO+Kxvt1sRKxBmytnXgocOkN7SpIC75fWxglIIdjGPS0zwqAIpxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31431 invoked by uid 109); 8 Apr 2024 20:55:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Apr 2024 20:55:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29045 invoked by uid 111); 8 Apr 2024 20:55:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Apr 2024 16:55:14 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Apr 2024 16:55:11 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/12] git_config_string() considered harmful
Message-ID: <20240408205511.GB1639295@coredump.intra.peff.net>
References: <xmqqttkeicov.fsf@gitster.g>
 <20240407005656.GA436890@coredump.intra.peff.net>
 <ef8e5f43-5f27-4f0a-acf5-cf4f8281a8f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef8e5f43-5f27-4f0a-acf5-cf4f8281a8f8@gmail.com>

On Sun, Apr 07, 2024 at 07:58:02PM +0200, Rubén Justo wrote:

> After Junio's series and yours, I'm on the fence now, but my envision was
> to introduce:
> 
> --- >8 ---
> diff --git a/config.c b/config.c
> index eebce8c7e0..7322bdfb94 100644
> --- a/config.c
> +++ b/config.c
> @@ -1345,6 +1345,15 @@ int git_config_string(const char **dest, const char *var, const char *value)
>  	return 0;
>  }
>  
> +int git_config_strbuf(struct strbuf *dest, const char *var, const char *value)
> +{
> +	if (!value)
> +		return config_error_nonbool(var);
> +	strbuf_reset(dest);
> +	strbuf_addstr(dest, value);
> +	return 0;
> +}
> +
>  int git_config_pathname(const char **dest, const char *var, const char *value)
>  {
>  	if (!value)

Hmm. I think that is nice in some ways, because it is a much bigger
signal about memory ownership than just dropping "const" from the
pointer.

But it is less nice in other ways. Every _user_ of the value now needs
to care that it is a strbuf, and use foo.buf consistently (which you
obviously noticed). Likewise, any downstream writers of the variable
need to treat it like a strbuf, too. So the parse-options OPT_FILENAME()
macro, for example, needs to be replaced with a strbuf-aware variant
(though arguably that is an improvement, as using the wrong one would
fail catastrophically, whereas using a non-const pointer with
OPT_FILENAME() creates a subtle bug).

I'm also not sure what the solution is for setting default values, like:

  const char *my_config = "default";

Of course that is a problem with my solution, too. Perhaps in the long
run we need to accept that they should always default to NULL, and
readers of the variable need to fill in the default when they look at it
(possibly with an accessor function).

Or I guess the alternative is to stop using bare pointers, and carry a
bit which tells us if something is heap-allocated. Which starts to look
an awful lot like a strbuf. ;)

I think in the past we've talked about being able to initialize a strbuf
like:

  struct strbuf foo = STRBUF_INIT_VAL("bar");

That would use "bar" instead of the usual slopbuf, but we can still tell
it's not a heap buffer by the fact that foo.alloc is 0.

-Peff
