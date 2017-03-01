Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79AF2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 20:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbdCAUBy (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 15:01:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:36615 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdCAUBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 15:01:31 -0500
Received: (qmail 8511 invoked by uid 109); 1 Mar 2017 19:53:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 19:53:05 +0000
Received: (qmail 7507 invoked by uid 111); 1 Mar 2017 19:53:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 14:53:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 14:53:02 -0500
Date:   Wed, 1 Mar 2017 14:53:02 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
 <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 10:49:55AM -0800, Linus Torvalds wrote:

> That said, I think that it would be lovely to just default to
> USE_SHA1DC and just put the whole attack behind us. Yes, it's slower.
> No, it doesn't really seem to matter that much in practice.

My biggest concern is the index-pack operation. Try this:

  time git clone --no-local --bare linux tmp.git

with and without USE_SHA1DC. I get:

  [w/ openssl]
  real	1m52.307s
  user	2m47.928s
  sys	0m14.992s

  [w/ sha1dc]
  real	3m4.043s
  user	6m16.412s
  sys	0m13.772s

That's real latency the user will see. It's hard to break it down,
though. The actual "receiving" phase is generally going to be network
bound. The delta-resolution that happens afterwards is totally local and
CPU-bound (but does run in parallel).

And of course this repository tends to the larger side (though certainly
there are bigger ones), and you only feel the pain on clone or when
doing an initial push, not day-to-day.

So maybe we just suck it up and accept that it's a bit slower.

-Peff
