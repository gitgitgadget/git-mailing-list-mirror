Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE671F855
	for <e@80x24.org>; Mon,  1 Aug 2016 18:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbcHASOH (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:14:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:52668 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751546AbcHASNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 14:13:37 -0400
Received: (qmail 9717 invoked by uid 102); 1 Aug 2016 18:12:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 14:12:37 -0400
Received: (qmail 15647 invoked by uid 107); 1 Aug 2016 18:13:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 14:13:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 14:12:34 -0400
Date:	Mon, 1 Aug 2016 14:12:34 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
Message-ID: <20160801181233.wycskha3mrribx7s@sigill.intra.peff.net>
References: <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net>
 <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net>
 <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
 <CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
 <20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
 <xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
 <xmqq7fc0l6aw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7fc0l6aw.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 10:58:47AM -0700, Junio C Hamano wrote:

> diff --git a/commit.c b/commit.c
> index b02f3c4..db24013 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1543,7 +1543,6 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  	}
>  
>  	/* Person/date information */
> -	reset_ident_date();
>  	if (!author)
>  		author = git_author_info(IDENT_STRICT);
>  	strbuf_addf(&buffer, "author %s\n", author);
> @@ -1564,11 +1563,21 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  	if (encoding_is_utf8 && !verify_utf8(&buffer))
>  		fprintf(stderr, commit_utf8_warn);
>  
> -	if (sign_commit && do_sign_commit(&buffer, sign_commit))
> -		return -1;
> +	if (sign_commit && do_sign_commit(&buffer, sign_commit)) {
> +		result = -1;
> +		goto out;
> +	}
>  
>  	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
> +
> +out:
>  	strbuf_release(&buffer);
> +
> +	/*
> +	 * Reset the default timestamp for the next call to create tag/commit
> +	 * object, so that they get their own fresh timestamp.
> +	 */
> +	reset_ident_date();
>  	return result;
>  }

Before I switched to "reset at the beginning" in my original patch, I
also noticed this issue, but decided the other way: to only reset after
a successful creation.

I think in most cases it wouldn't matter anyway, because the caller will
generally abort as soon as this returns failure anyway. But I wondered
about something like:

  author = prepare_author_info();
  if (commit_tree_extended(..., author, ...) < 0) {
	/* oops, we failed. Do a thing and try again. */
	possible_fix();
	if (commit_tree_extended(..., author, ...) < 0)
		die("giving up");
  }

In the second call (but only the second call!) the committer and author
can diverge.

-Peff
