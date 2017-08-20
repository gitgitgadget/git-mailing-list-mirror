Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2ADF208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 10:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbdHTKGg (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 06:06:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:44002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751088AbdHTKGg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 06:06:36 -0400
Received: (qmail 29067 invoked by uid 109); 20 Aug 2017 10:06:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 10:06:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13429 invoked by uid 111); 20 Aug 2017 10:07:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 06:07:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 06:06:34 -0400
Date:   Sun, 20 Aug 2017 06:06:34 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC 0/5] Some ThreadSanitizer-results
Message-ID: <20170820100633.ehn2sc7gwmm6lftd@sigill.intra.peff.net>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 02:53:00PM +0200, Martin Ågren wrote:

> I tried running the test suite on Git compiled with ThreadSanitizer
> (SANITIZE=thread). Maybe this series could be useful for someone else
> trying to do the same. I needed the first patch to avoid warnings when
> compiling, although it actually has nothing to do with threads.
> 
> The last four patches are about avoiding some issues where
> ThreadSanitizer complains for reasonable reasons, but which to the best
> of my understanding are not real problems. These patches could be useful
> to make "actual" problems stand out more. Of course, if no-one ever runs
> ThreadSanitizer, they are of little to no (or even negative) value...

I think it's a chicken-and-egg. I'd love to run the test suite with tsan
from time to time, but there's no point if it turns up a bunch of false
positives.

The general direction here looks good to me (and I agree with the
comments made so far, especially that we should stop writing to
strbuf_slopbuf entirely).

>   ThreadSanitizer: add suppressions

This one is the most interesting because it really is just papering over
the issues. I "solved" the transfer_debug one with actual code in:

  https://public-inbox.org/git/20170710133040.yom65mjol3nmf2it@sigill.intra.peff.net/

but it just feels really dirty. I'd be inclined to go with suppressions
for now until somebody can demonstrate or argue for an actual breakage
(just because it makes the tool more useful for finding _real_
problems).

-Peff
