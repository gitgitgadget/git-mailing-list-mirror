Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CDE2095E
	for <e@80x24.org>; Sat, 25 Mar 2017 16:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdCYQXu (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 12:23:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:51628 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdCYQXu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 12:23:50 -0400
Received: (qmail 24608 invoked by uid 109); 25 Mar 2017 16:17:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Mar 2017 16:17:08 +0000
Received: (qmail 1092 invoked by uid 111); 25 Mar 2017 16:17:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Mar 2017 12:17:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Mar 2017 12:17:06 -0400
Date:   Sat, 25 Mar 2017 12:17:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: add extra headers and MIME boundary directly
Message-ID: <20170325161705.wh4zueasik6iwktv@sigill.intra.peff.net>
References: <6f3d0b54-7a9f-8088-3675-bd2980f69735@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f3d0b54-7a9f-8088-3675-bd2980f69735@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 01:16:42PM +0100, René Scharfe wrote:

> Use the after_subject member of struct pretty_print_context to pass the
> extra_headers unchanged, and construct and add the MIME boundary headers
> directly in pretty.c::pp_title_line() instead of writing both to a
> static buffer in log-tree.c::log_write_email_headers() first.  That's
> easier, quicker and gets rid of said static buffer.

I'm definitely pleased with the direction. A few comments:

> @@ -374,26 +372,9 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
>  		graph_show_oneline(opt->graph);
>  	}
>  	if (opt->mime_boundary) {
> -		static char subject_buffer[1024];
>  		static char buffer[1024];

We still have this other buffer, which ends up in stat_sep. It should
probably get the same treatment, though I think the module boundaries
make it a little more awkward. We look at it in diff_flush(), which
otherwise doesn't need to know much about the pretty-printing.

Perhaps stat_sep should be a callback?

> diff --git a/pretty.c b/pretty.c
> index d0f86f5d85..56e668781a 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1641,6 +1641,21 @@ void pp_title_line(struct pretty_print_context *pp,
>  	if (pp->after_subject) {
>  		strbuf_addstr(sb, pp->after_subject);
>  	}
> +	if (pp->print_email_subject && pp->rev && pp->rev->mime_boundary) {
> +		strbuf_addf(sb,
> +			    "MIME-Version: 1.0\n"

In the original, this would have been in "after_subject". Which means we
would print it even if print_email_subject is not true. Why do we need
to check it in the new conditional?

Not that I expect the behavior to be wrong either way; why would we have
a mime boundary without setting print_email_subject? But I would think
that "do we have a mime boundary" would be the right conditional to
trigger printing it.

-Peff
