Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFB81F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfHZSqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:46:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:56252 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727559AbfHZSqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:46:23 -0400
Received: (qmail 6777 invoked by uid 109); 26 Aug 2019 18:46:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 18:46:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22671 invoked by uid 111); 26 Aug 2019 18:47:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 14:47:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 14:46:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log-tree: always use return value of strbuf_detach()
Message-ID: <20190826184621.GE23399@sigill.intra.peff.net>
References: <dc471768-7f42-3e51-6397-1c40466d3726@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc471768-7f42-3e51-6397-1c40466d3726@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 02:53:26PM +0200, René Scharfe wrote:

> strbuf_detach() has been returning a pointer to a buffer even for empty
> strbufs since 08ad56f3f0 ("strbuf: always return a non-NULL value from
> strbuf_detach", 2012-10-18).  Use that feature in show_log() instead of
> having it handle empty strbufs specially.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> The patched code was added one day earlier, by ddf333f66c ("pretty:
> prepare notes message at a centralized place", 2012-10-17).

Bad timing, I guess. :)

> diff --git a/log-tree.c b/log-tree.c
> index 1e56df62a7..109c212224 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -677,9 +677,7 @@ void show_log(struct rev_info *opt)
>  		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
>  		format_display_notes(&commit->object.oid, &notebuf,
>  				     get_log_output_encoding(), raw);
> -		ctx.notes_message = notebuf.len
> -			? strbuf_detach(&notebuf, NULL)
> -			: xcalloc(1, 1);
> +		ctx.notes_message = strbuf_detach(&notebuf, NULL);
>  	}

Yeah, this is definitely the right thing to do.

-Peff
