Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA13C001B0
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 08:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjF0Iy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjF0IyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 04:54:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17405B8
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 01:54:23 -0700 (PDT)
Received: (qmail 3736 invoked by uid 109); 27 Jun 2023 08:54:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 08:54:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15206 invoked by uid 111); 27 Jun 2023 08:54:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 04:54:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 04:54:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] replace strbuf_expand() with strbuf_expand_step()
Message-ID: <20230627085422.GJ1226768@coredump.intra.peff.net>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <150df0b0-0548-f291-2b68-960841dd1c97@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150df0b0-0548-f291-2b68-960841dd1c97@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 10:43:17PM +0200, René Scharfe wrote:

> Avoid the overhead of passing context to a callback function of
> strbuf_expand() by using strbuf_expand_step() in a loop instead.  It
> requires explicit handling of %% and unrecognized placeholders, but is
> simpler, more direct and avoids void pointers.

I like this. I don't care that much about the runtime overhead of
passing the context around, but if you meant by "overhead" the
programmer time and confusion in stuffing everything into context
structs, then I agree this is much better. :)

It does still feel like we should be handling "%%" on behalf of the
callers.

>  builtin/cat-file.c |  35 +++++++--------
>  builtin/ls-files.c | 109 +++++++++++++++++++--------------------------
>  builtin/ls-tree.c  | 107 +++++++++++++++++---------------------------
>  daemon.c           |  61 ++++++++-----------------
>  pretty.c           |  72 ++++++++++++++++++------------
>  strbuf.c           |  20 ---------
>  strbuf.h           |  37 ++-------------
>  7 files changed, 169 insertions(+), 272 deletions(-)

The changes mostly looked OK to me (and the diffstat is certainly
pleasing). The old callbacks returned a "consumed" length, and we need
each "step" caller to now do "format += consumed" themselves. At first
glance I thought there were cases where you didn't, but then I realized
that you are relying on skip_prefix() to do that incrementing. Which
makes sense and the resulting code looks nice, but it took me a minute
to realize what was going on.

> @@ -1894,7 +1880,26 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
>  			return;
>  		fmt = user_format;
>  	}
> -	strbuf_expand(&dummy, fmt, userformat_want_item, w);
> +	while (strbuf_expand_step(&dummy, &fmt)) {
> +		if (skip_prefix(fmt, "%", &fmt))
> +			continue;
> +
> +		if (*fmt == '+' || *fmt == '-' || *fmt == ' ')
> +			fmt++;
> +
> +		switch (*fmt) {
> +		case 'N':
> +			w->notes = 1;
> +			break;
> +		case 'S':
> +			w->source = 1;
> +			break;
> +		case 'd':
> +		case 'D':
> +			w->decorate = 1;
> +			break;
> +		}
> +	}
>  	strbuf_release(&dummy);
>  }

This one actually doesn't increment the format (so we restart the
expansion on "N" or whatever). But neither did the original! It always
returned 0:

> -static size_t userformat_want_item(struct strbuf *sb UNUSED,
> -				   const char *placeholder,
> -				   void *context)
> -{
> -	struct userformat_want *w = context;
> -
> -	if (*placeholder == '+' || *placeholder == '-' || *placeholder == ' ')
> -		placeholder++;
> -
> -	switch (*placeholder) {
> -	case 'N':
> -		w->notes = 1;
> -		break;
> -	case 'S':
> -		w->source = 1;
> -		break;
> -	case 'd':
> -	case 'D':
> -		w->decorate = 1;
> -		break;
> -	}
> -	return 0;
> -}

So probably OK, though a little funny.

It also feels like this whole function would be just as happy using
"strchr()", since it throws away the expanded result anyway. But that
can be for another time. :)

> @@ -1912,7 +1917,16 @@ void repo_format_commit_message(struct repository *r,
>  	const char *output_enc = pretty_ctx->output_encoding;
>  	const char *utf8 = "UTF-8";
> 
> -	strbuf_expand(sb, format, format_commit_item, &context);
> +	while (strbuf_expand_step(sb, &format)) {
> +		size_t len;
> +
> +		if (skip_prefix(format, "%", &format))
> +			strbuf_addch(sb, '%');
> +		else if ((len = format_commit_item(sb, format, &context)))
> +			format += len;
> +		else
> +			strbuf_addch(sb, '%');
> +	}

This one doesn't advance the format for a not-understood placeholder.
But that's OK, because we know it isn't "%", so starting the search from
there again is correct.

> @@ -1842,7 +1852,7 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
>  	}
> 
>  	orig_len = sb->len;
> -	if (((struct format_commit_context *)context)->flush_type != no_flush)
> +	if ((context)->flush_type != no_flush)
>  		consumed = format_and_pad_commit(sb, placeholder, context);
>  	else
>  		consumed = format_commit_one(sb, placeholder, context);

Since we're no longer casting, the extra parentheses seem redundant now.
I.e., this can just be context->flush_type.

-Peff
