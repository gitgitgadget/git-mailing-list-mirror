Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5398E202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdB1WSU (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:18:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:36107 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbdB1WSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:18:16 -0500
Received: (qmail 12542 invoked by uid 109); 28 Feb 2017 18:17:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 18:17:21 +0000
Received: (qmail 28268 invoked by uid 111); 28 Feb 2017 18:17:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 13:17:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 13:17:19 -0500
Date:   Tue, 28 Feb 2017 13:17:19 -0500
From:   Jeff King <peff@peff.net>
To:     Adrian Dudau <Adrian.Dudau@enea.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: format-patch subject-prefix gets truncated when using the
 --numbered flag
Message-ID: <20170228181719.t67abnnnsdcx2xfd@sigill.intra.peff.net>
References: <1488297556.2955.11.camel@enea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1488297556.2955.11.camel@enea.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 03:59:16PM +0000, Adrian Dudau wrote:

> This is happening on the latest master branch, so I dug through the
> code and tracked the issue to this piece of code in log-tree.c:
> 
>         if (opt->total > 0) {
>                 static char buffer[64];
>                 snprintf(buffer, sizeof(buffer),
>                          "Subject: [%s%s%0*d/%d] ",
>                          opt->subject_prefix,
>                          *opt->subject_prefix ? " " : "",
>                          digits_in_number(opt->total),
>                          opt->nr, opt->total);
>                 subject = buffer;
>         } else if (opt->total == 0 && opt->subject_prefix && *opt-
> >subject_prefix) {
>                 static char buffer[256];
>                 snprintf(buffer, sizeof(buffer),
>                          "Subject: [%s] ",
>                          opt->subject_prefix);
>                 subject = buffer;
>         } else {
>                 subject = "Subject: ";
>         }
> 
> Apparently the size of the "buffer" var is different in the two
> situations. Anybody knows if this is by design or just an old
> oversight?

I think it's just an old oversight. There are some other fixed-size
buffers later, too, which could similarly truncate.

I think these should all be "static strbuf", and entering the function
they should get strbuf_reset(), followed by a strbuf_addf(). The static
strbufs will be the owners of the allocated heap memory, and it will get
reused from call to call.

That stops the immediate problem. As a function interface, it's pretty
ugly. It would probably make more sense for the caller to pass in a
strbuf rather than have us pass out pointers to static storage. For the
call in make_cover_letter(), that would be fine. For show_log(), it's
less clear. That's called for every commit in "git log", which might be
a little sensitive to allocations.

The only persistent storage it has is via the rev_info. Perhaps it could
hold some scratch buffers for the traversal (though I don't think we
currently do any resource-freeing when done with a rev_info, so it
effectively becomes a leak).

-Peff
