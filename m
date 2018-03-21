Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C72E1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 05:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeCUFrV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:47:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:36954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751505AbeCUFrV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:47:21 -0400
Received: (qmail 29021 invoked by uid 109); 21 Mar 2018 05:47:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:47:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6870 invoked by uid 111); 21 Mar 2018 05:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 01:48:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:47:19 -0400
Date:   Wed, 21 Mar 2018 01:47:19 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] log --graph corrupts patch
Message-ID: <20180321054718.GA13936@sigill.intra.peff.net>
References: <897b7471-037a-78d9-fc11-0624ef657b4d@talktalk.net>
 <20180320060931.GE15813@sigill.intra.peff.net>
 <1e686ea0-90ac-f3f4-7bcf-6951c9253598@talktalk.net>
 <20180320155814.GA32366@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180320155814.GA32366@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 11:58:14AM -0400, Jeff King wrote:

> The issue bisects to 7e4ffb4c17 (diff-highlight: add support for --graph
> output, 2016-08-29). I think the problem is the "\s+" at the end of the
> $GRAPH regex, which soaks up the space for the context, and accidentally
> treats the "-" line as a preimage removal.
> 
> But just switching that to "\s" doesn't quite work. We may have an
> arbitrary number of spaces between the graph ascii-art and the diff.
> E.g., if you have a commit at the base of a branch (the test in
> contrib/diff-highlight shows this case).
> 
> So I think you'd have to record the indent of the previous hunk header,
> and then make sure that the indent matched that. But even there, I think
> we're subject to false positives if a commit message contains a hunk
> header (it's indented an extra 4 characters, but we'd accidentally soak
> that up thinking it was graph indentation).
> 
> To make it bullet-proof, I think we'd have to actually parse the graph
> structure, finding a "*" line and then accepting only an indent that
> matched it.

Wow. Nerd snipe successful. This turned out to be quite tricky, but also
kind of interesting.

Here's a series which fixes it. The meaty bits are in the final commit;
the rest is just preparatory cleanup, and adding some tests (all are
cases which I managed to break while fixing this).

  [1/7]: diff-highlight: correct test graph diagram
  [2/7]: diff-highlight: use test_tick in graph test
  [3/7]: diff-highlight: prefer "echo" to "cat" in tests
  [4/7]: diff-highlight: test interleaved parallel lines of history
  [5/7]: diff-highlight: test graphs with --color
  [6/7]: diff-highlight: factor out flush_hunk() helper
  [7/7]: diff-highlight: detect --graph by indent

 contrib/diff-highlight/DiffHighlight.pm       | 89 +++++++++++++++----
 .../diff-highlight/t/t9400-diff-highlight.sh  | 81 +++++++++++++----
 2 files changed, 133 insertions(+), 37 deletions(-)

-Peff
