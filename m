Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF0A201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdEPDCF (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:02:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:52352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbdEPDCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:02:05 -0400
Received: (qmail 24835 invoked by uid 109); 16 May 2017 03:02:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 03:02:03 +0000
Received: (qmail 23900 invoked by uid 111); 16 May 2017 03:02:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 23:02:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 23:02:00 -0400
Date:   Mon, 15 May 2017 23:02:00 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] usage: fix a sparse 'redeclared with different type'
 error
Message-ID: <20170516030200.fivl7p5iukfxk2jb@sigill.intra.peff.net>
References: <52ef158a-0719-c71a-b72b-4961cf8f96d5@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52ef158a-0719-c71a-b72b-4961cf8f96d5@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 02:11:40AM +0100, Ramsay Jones wrote:

> 
> If you need to re-roll your 'jk/bug-to-abort' branch, could you please
> squash this into the relevant patch (commit d8193743e0 "usage.c: add
> BUG() function", 12-05-2017).
> 
> [Just FYI, sparse complains thus:
>   usage.c:212:6: error: symbol 'BUG_fl' redeclared with different type
>   (originally declared at git-compat-util.h:1076) - different modifiers
> ]

Hmm. Our model here is the die() function, which gets noreturn and
format attributes in the declaration, but only noreturn at the
definition.

Your patch here adds both attributes to the definition:

> +__attribute__((format (printf, 3, 4))) NORETURN
>  void BUG_fl(const char *file, int line, const char *fmt, ...)

Another possible model is trace_printf_key_fl(), which just has a format
attribute at the declaration, and nothing at all in the definition.

So it seems like this doesn't matter for the format attribute, but does
for NORETURN. Weird. I wonder if it's specific to the attribute, or
something about the way we hide it behind a macro.

There probably isn't a downside to repeating the format attribute, I
guess. Except that I'm not sure what happens if the two ever got out of
sync (gcc doesn't seem to complain, though in practice you'd probably
change the order or number of arguments at the same time, which is
likely to cause a mismatch).

-Peff
