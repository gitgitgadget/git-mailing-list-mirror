Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B059128386
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809693; cv=none; b=StukTGfd4dIq6IGiNRSP9WZAQe4CnySF8zLJhbqh9ZHn6+nAK0z8C3Wx1nYKMykeEPpo2KCGMD6TJuKxSrSj3yHyXp2rBgd2/yt4MxLmlef8ViQfgp9wxHlY4IR+76LvZklCZqFhTbA7EQ92Rv5yo61FQ71cZa46nrbwf5YnlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809693; c=relaxed/simple;
	bh=9EE2QODFdTHiVixL6QIaXjFXWmIEaPqbLWfWJAwUcI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNm7fCpJ+iryYDdWe0UppiQJjHcNiG5EOo3Tam9Zb2uJcWw8mBRXhAR9/HxAWpjhJg6LmpEsfNGWO7/hDhLVheqo3QKnAel737eZm180F1ZqN53uDVETe0LiodXv9ZMrdTD0lTpAwtgzxO8LTOSsLoBKY6Ud2Cnqzh9SMDRhgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7513 invoked by uid 109); 7 Mar 2024 11:08:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 11:08:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13493 invoked by uid 111); 7 Mar 2024 11:08:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 06:08:14 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 06:08:09 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
Message-ID: <20240307110809.GA3668372@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307092638.GK2080210@coredump.intra.peff.net>

On Thu, Mar 07, 2024 at 04:26:38AM -0500, Jeff King wrote:

> IMHO this is the trickiest commit of the whole series, as it would be
> easy to get the length computations subtly wrong.

And sure enough...

> diff --git a/trailer.c b/trailer.c
> index fe18faf6c5..f59c90b4b5 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -882,7 +882,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
>  
>  	/* The first paragraph is the title and cannot be trailers */
>  	for (s = buf; s < buf + len; s = next_line(s)) {
> -		if (s[0] == comment_line_char)
> +		if (starts_with_mem(s, buf + len - s, comment_line_str))
>  			continue;
>  		if (is_blank_line(s))
>  			break;
> @@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
>  		const char **p;
>  		ssize_t separator_pos;
>  
> -		if (bol[0] == comment_line_char) {
> +		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_str)) {
>  			non_trailer_lines += possible_continuation_lines;
>  			possible_continuation_lines = 0;
>  			continue;

This second hunk needs:

diff --git a/trailer.c b/trailer.c
index f59c90b4b5..fdb0b8137e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char *buf, size_t len)
 		const char **p;
 		ssize_t separator_pos;
 
-		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_str)) {
+		if (starts_with_mem(bol, buf + len - bol, comment_line_str)) {
 			non_trailer_lines += possible_continuation_lines;
 			possible_continuation_lines = 0;
 			continue;

I was trying to bound the size based on the loop, which is:

          for (l = last_line(buf, len);
               l >= end_of_title;
               l = last_line(buf, l)) {
                  const char *bol = buf + l;

but I misread "end_of_title" as an upper bound, not a lower one. Which
makes sense because we're iterating backwards over the lines. So I
suppose we could bound it by the previous "bol" value. But in practice,
your prefix won't cross such a boundary anyway, as it won't have a
newline in it (maybe that's something we should enforce? I guess you
could set core.commentChar to '\n' even before my series, which would be
slightly insane).

So just bounding ourselves to "buf + len" seems reasonable, as that
makes sure we don't step outside the buffer passed into the function.

Curiously, this was found by the sanitizer job in CI, where UBSan
complains of integer overflow in the pointer computation. I had run with
both ASan/UBSan locally, but just using gcc, which doesn't seem to find
it (the CI job uses clang). So I'll that to my mental tally of "clang
seems to be better with sanitizers".

-Peff
