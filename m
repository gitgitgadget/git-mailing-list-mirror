Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759722021E
	for <e@80x24.org>; Sun, 20 Nov 2016 20:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbcKTURr (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 15:17:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:45299 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbcKTURr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 15:17:47 -0500
Received: (qmail 4592 invoked by uid 109); 20 Nov 2016 20:17:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Nov 2016 20:17:46 +0000
Received: (qmail 14782 invoked by uid 111); 20 Nov 2016 20:18:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Nov 2016 15:18:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Nov 2016 15:17:44 -0500
Date:   Sun, 20 Nov 2016 15:17:44 -0500
From:   Jeff King <peff@peff.net>
To:     Matthieu S <matthieu.stigler@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: git diff with =?utf-8?B?4oCcLS13?=
 =?utf-8?Q?ord-diff-regex=E2=80=9D_extremely_slow_compared_to_=E2=80=9C--w?=
 =?utf-8?B?b3JkLWRpZmbigJ0/?=
Message-ID: <20161120201744.7ym4gsmjoijw6oow@sigill.intra.peff.net>
References: <CAEYvigJ14xYDmRG2N0yTgM4spaaB7s9923w0+e9+QQEeFz0NTQ@mail.gmail.com>
 <CAEYvigLz3muWD-QFjMZUn=H3RQoxhTYX9EwB6=aiMjWOEN3CBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEYvigLz3muWD-QFjMZUn=H3RQoxhTYX9EwB6=aiMjWOEN3CBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2016 at 03:40:22PM -0800, Matthieu S wrote:

> Why is the speed so different if one uses --word-diff instead of
> --word-diff-regex= ? Is it just because my expression is (slightly)
> more complex than the default one (split on period instead of only
> whitespace) ? Or is it that the default word-diff is implemented
> differently/more efficiently? How can I overcome this speed slowdown?

I think it's probably both.

See diff.c:find_word_boundaries(). If there's no regex, we use a simple
loop over isspace() to find the boundaries. I don't recall anybody
measuring the performance before, but I'm not surprised to hear that
matching a regex is slower.

If I look at the output of "perf", though, it looks like we also spend a
lot more time in xdl_clean_mmatch(). Which isn't surprising. Your regex
treats commas as boundaries, which is going to generate a lot more
matches for this particular data set (though the output is the same, I
think, because of the nature of the change).

I would have expected "--word-diff-regex=[^[:space:]]" to be faster than
your regex, though, and it does not seem to be.

-Peff
