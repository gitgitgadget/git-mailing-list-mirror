Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0BE1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 14:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754853AbcHSOoJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 10:44:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58131 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754639AbcHSOoI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 10:44:08 -0400
Received: (qmail 1708 invoked by uid 109); 19 Aug 2016 14:37:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 14:37:27 +0000
Received: (qmail 26041 invoked by uid 111); 19 Aug 2016 14:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 10:37:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 10:37:25 -0400
Date:   Fri, 19 Aug 2016 10:37:25 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH v2 3/3] diff-highlight: add support for --graph output.
Message-ID: <20160819143725.eex2fcmbhn3s77or@sigill.intra.peff.net>
References: <20160810085635.GA1672@starla>
 <20160817153124.7770-4-henderson.bj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160817153124.7770-4-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2016 at 08:31:24AM -0700, Brian Henderson wrote:

>  contrib/diff-highlight/diff-highlight | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Junio already commented on the tests, and I think everything he said in
his review is sensible.

As for the code itself, this looks much simpler than some of the things
we discussed off-list, which is good. There is one place that you did
not touch that I think is interesting: split_line.

It splits on $COLOR to mark those bits in their own list elements (so they
can be skipped). But we don't do anything special for $GRAPH there.

Obviously it would be wrong to find $GRAPH in the middle of the line.
But I think we end up in highlight_pair() with a sequence like this for
each line:

  [
    color-graph,
    "|"
    color-reset,
    " ",
    ... possibly more graph pipes ...
    "-" (or "+")
    ... actual line data ...
  ]

We ignore "$COLOR" in the middle of that list, but not the other
syntactic bits. I think this just works because we have to skip forward
to the "-" or "+" element, and that happens to skip over all of the
graph cruft, as well.

In a more general sense, it might have been better for split_line() to
return a list of records, with each one containing a bit for "am I
interesting?" along with the actual token data. But I think because the
graph data cannot contain "-" or "+", it's acceptable to simply leave
this as it is. It might be worth a comment (either in-code, or
describing the strategy in the commit message).

-Peff
