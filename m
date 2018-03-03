Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07DB1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 04:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCCEdm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 23:33:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:45242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751617AbeCCEdl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 23:33:41 -0500
Received: (qmail 3519 invoked by uid 109); 3 Mar 2018 04:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 04:33:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2925 invoked by uid 111); 3 Mar 2018 04:34:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 23:34:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 23:33:39 -0500
Date:   Fri, 2 Mar 2018 23:33:39 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180303043338.GC27689@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180222093327.GA12442@sigill.intra.peff.net>
 <20180223214557.GF234838@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223214557.GF234838@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 01:45:57PM -0800, Brandon Williams wrote:

> I think this is the price of extending the protocol in a backward
> compatible way.  If we don't want to be backwards compatible (allowing
> for graceful fallback to v1) then we could design this differently.
> Even so we're not completely out of luck just yet.
> 
> Back when I introduced the GIT_PROTOCOL side-channel I was able to
> demonstrate that arbitrary data could be sent to the server and it would
> only respect the stuff it knows about.  This means that we can do a
> follow up to v2 at some point to introduce an optimization where we can
> stuff a request into GIT_PROTOCOL and short-circuit the first round-trip
> if the server supports it.

If that's our end-game, it does make me wonder if we'd be happier just
jumping to that at first. Before you started the v2 protocol work, I had
a rough patch series passing what I called "early capabilities". The
idea was to let the client speak a few optional capabilities before the
ref advertisement, and be ready for the server to ignore them
completely. That doesn't clean up all the warts with the v0 protocol,
but it handles the major one (allowing more efficient ref
advertisements).

I dunno. There's a lot more going on here in v2 and I'm not sure I've
fully digested it.

> The great thing about this is that from the POV of the git-client, it
> doesn't care if its speaking using the git://, ssh://, file://, or
> http:// transport; it's all the same protocol.  In my next re-roll I'll
> even drop the "# service" bit from the http server response and then the
> responses will truly be identical in all cases.

This part has me a little confused still. The big difference between
http and the other protocols is that the other ones are full-duplex, and
http is a series of stateless request/response pairs.

Are the other protocols becoming stateless request/response pairs, too?
Or will they be "the same protocol" only in the sense of using the same
transport?

(There are a lot of reasons not to like the stateless pair thing; it has
some horrid corner cases during want/have negotiation).

-Peff
