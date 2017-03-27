Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3BA720958
	for <e@80x24.org>; Mon, 27 Mar 2017 03:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbdC0DMV (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 23:12:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:52205 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbdC0DMV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 23:12:21 -0400
Received: (qmail 5317 invoked by uid 109); 27 Mar 2017 03:12:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 03:12:19 +0000
Received: (qmail 29710 invoked by uid 111); 27 Mar 2017 03:12:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Mar 2017 23:12:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Mar 2017 23:12:16 -0400
Date:   Sun, 26 Mar 2017 23:12:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: add extra headers and MIME boundary directly
Message-ID: <20170327031216.pbxbmgnekt5zgxri@sigill.intra.peff.net>
References: <6f3d0b54-7a9f-8088-3675-bd2980f69735@web.de>
 <20170325161705.wh4zueasik6iwktv@sigill.intra.peff.net>
 <c5591beb-8cb2-dc19-7820-c8b9c68aad15@web.de>
 <20170325211149.yyvocmdfw4zbjyoi@sigill.intra.peff.net>
 <9d31c27b-fecb-ac1d-2b3f-8227c93862c2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d31c27b-fecb-ac1d-2b3f-8227c93862c2@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 03:41:14PM +0200, René Scharfe wrote:

> Am 25.03.2017 um 22:11 schrieb Jeff King:
> > The most correct way is that the caller of log_write_email_headers() and
> > diff_flush() should have a function-local strbuf which holds the data,
> > gets passed to diff_flush() as some kind opaque context, and then is
> > freed afterwards. We don't have such a context, but if we were to abuse
> > diff_options.stat_sep _temporarily_, that would still be a lot cleaner.
> > I.e., something like this:
> > 
> >   struct strbuf stat_sep = STRBUF_INIT;
> > 
> >   /* may write into stat_sep, depending on options */
> >   log_write_email_headers(..., &stat_sep);
> >   opt->diffopt.stat_sep = stat_sep.buf;
> > 
> >   diff_flush(&opt->diffopt);
> >   opt->diffopt.stat_sep = NULL;
> >   strbuf_release(&stat_sep);
> > 
> > But it's a bit tricky because those two hunks happen in separate
> > functions, which means passing the strbuf around.
> 
> You could have a destructor callback, called at the end of diff_flush().

Yeah, though now we have lifetime rules around stat_sep. How long does
it stay good? Which functions decide it's now done? Are we sure they
alweays get called? We're just tacking that onto the end of diff_flush()
because the caller responsibilities are so unclear, but that's making an
assumption that it always gets called.

This case might be simple enough that it's true, but it feels like a
leaky module boundary.

> Hmm.  I'm a fan of callbacks, but using them can make the code a bit
> hard to follow.  And void context pointers add a type safety hazard.
> Do we need to be this generic?  How about switching stat_sep to strbuf?
> fmt_output_commit() requires an allocation anyway, so why not allocate
> stat_sep as well?

Right, I think that is the simplest thing, but it falls afoul of the
lifetime rules above.

If the rule is "the stat_sep gets printed once and then freed", that's
pretty reasonable. But I wonder if there are cases where we might not
print stat_sep (or call diff_flush at all for that matter). I'm not sure
if that's possible with --attach, though, which constrains us to
format-patch.

>  	if (opt->mime_boundary) {
> -		static char buffer[1024];
>  		struct strbuf filename =  STRBUF_INIT;

Actually, I guess the absolute simplest thing would be swap this out for
a static strbuf, and leave the ownership with the function. That's ugly,
but it's how it works now, and lets us drop the fixed buffer.

Another option is to put it in rev_info, and make the rev_info owner
free it (which we know is restricted to cmd_format_patch(), as it is the
only one who uses mime_boundary).

-Peff
