Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F101F744
	for <e@80x24.org>; Wed, 20 Jul 2016 13:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbcGTNUb (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:20:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:47439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753805AbcGTNU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:20:29 -0400
Received: (qmail 8243 invoked by uid 102); 20 Jul 2016 13:20:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:20:28 -0400
Received: (qmail 20359 invoked by uid 107); 20 Jul 2016 13:20:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:20:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 07:20:25 -0600
Date:	Wed, 20 Jul 2016 07:20:25 -0600
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strbuf_addbuf() for appending a strbuf to another
Message-ID: <20160720132025.GD17469@sigill.intra.peff.net>
References: <578E732D.2090803@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578E732D.2090803@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 08:36:29PM +0200, René Scharfe wrote:

> Use strbuf_addbuf() where possible; it's shorter and more efficient.

After seeing "efficient", I was momentarily surprised by the first hunk:

> diff --git a/dir.c b/dir.c
> index 6172b34..0ea235f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2364,7 +2364,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
>  
>  	varint_len = encode_varint(untracked->ident.len, varbuf);
>  	strbuf_add(out, varbuf, varint_len);
> -	strbuf_add(out, untracked->ident.buf, untracked->ident.len);
> +	strbuf_addbuf(out, &untracked->ident);

This is actually slightly _less_ efficient, because we already are using
the precomputed len, and the new code will call an extra strbuf_grow()
to cover the case where the two arguments are the same.  See 81d2cae
(strbuf_addbuf(): allow passing the same buf to dst and src,
2010-01-12).

But it almost certainly doesn't matter, and it definitely _is_ an
improvement for the other "addstr" cases, which are doing an unncessary
strlen().

And anyway the readability improvement trumps all of that in my mind. So
I think overall it is a nice cleanup; I'm mostly just commenting for the
sake of other reviewers.

-Peff
