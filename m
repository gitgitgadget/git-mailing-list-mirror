Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75BF1F51C
	for <e@80x24.org>; Fri, 18 May 2018 21:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeERVdk (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 17:33:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:45962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752193AbeERVdh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 17:33:37 -0400
Received: (qmail 28510 invoked by uid 109); 18 May 2018 21:33:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 May 2018 21:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14488 invoked by uid 111); 18 May 2018 21:33:44 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 17:33:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 14:33:33 -0700
Date:   Fri, 18 May 2018 14:33:33 -0700
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] unpack_trees_options: free messages when done
Message-ID: <20180518213333.GB21797@sigill.intra.peff.net>
References: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com>
 <cover.1526677881.git.martin.agren@gmail.com>
 <f4e7822ebe8fcab8243ae3931084e10f3b199788.1526677881.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4e7822ebe8fcab8243ae3931084e10f3b199788.1526677881.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 11:23:27PM +0200, Martin Ågren wrote:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 79fd97074e..60293ff536 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -103,6 +103,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  	const char **msgs = opts->msgs;
>  	const char *msg;
>  
> +	opts->msgs_to_free.strdup_strings = 0;
> +
> [...]
> +void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
> +{
> +	opts->msgs_to_free.strdup_strings = 1;
> +	string_list_clear(&opts->msgs_to_free, 0);

I like this string_list approach much better, but it's too bad we have
to go through these contortions with the strdup flag to get the memory
ownership right.

If we had a string_list_appendf(), then we could just leave that flag
alone and this:

> @@ -118,8 +120,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  		      ? _("Your local changes to the following files would be overwritten by %s:\n%%s"
>  			  "Please commit your changes or stash them before you %s.")
>  		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
> -	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
> -		xstrfmt(msg, cmd, cmd);
> +	msg = xstrfmt(msg, cmd, cmd);
> +	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] = msg;
> +	string_list_append(&opts->msgs_to_free, msg);

would become:

  msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOUPTODATE_FILE] =
	string_list_appendf(&opts->msgs_to_free, msg, cmd, cmd)->string;

I don't know if that's worth it or not (I suspect that there are other
places where appendf would be handy, but I didn't poke around).

-Peff
