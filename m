Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B121F453
	for <e@80x24.org>; Wed, 31 Oct 2018 16:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbeKABCc (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 21:02:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:34478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729642AbeKABCc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 21:02:32 -0400
Received: (qmail 6360 invoked by uid 109); 31 Oct 2018 16:03:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 16:03:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11349 invoked by uid 111); 31 Oct 2018 16:03:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 12:03:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 12:03:53 -0400
Date:   Wed, 31 Oct 2018 12:03:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jon Simons <jon@jonsimons.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [BUG?] protocol.version=2 sends HTTP "Expect" headers
Message-ID: <20181031160353.GA17267@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 959dfcf42f (smart-http: Really never use Expect: 100-continue,
2011-03-14), we try to avoid sending "Expect" headers, since some
proxies apparently don't handle them well. There we have to explicitly
tell curl not to use them.

The exception is large requests with GSSAPI, as explained in c80d96ca0c
(remote-curl: fix large pushes with GSSAPI, 2013-10-31).

However, Jon Simons noticed that when using protocol.version=2, we've
started sending Expect headers again. That's because rather than going
through post_rpc(), we push the stateless data through a proxy_state
struct. And in proxy_state_init(), when we set up the headers, we do not
disable curl's Expect handling.

So a few questions:

  - is this a bug or not? I.e., do we still need to care about proxies
    that can't handle Expect? The original commit was from 2011. Maybe
    things are better now. Or maybe that's blind optimism.

    Nobody has complained yet, but that's probably just because v2 isn't
    widely deployed yet.

  - if it is a bug, how can we handle it like the v0 code? There we
    enable it only for GSSAPI on large requests. But I'm not sure we can
    know here whether the request is large, since we're inherently just
    streaming through chunked data. It looks like post_rpc tries to read
    a single packet first, and considers anything over 64k to be large.

  - alternatively, should we just leave it on for v2, and provide a
    config switch to disable it if you have a crappy proxy? I don't know
    how widespread the problem is, but I can imagine that the issue is
    subtle enough that most users wouldn't even know.

I think I've convinced myself that we probably do need to do the "peek
at the first packet" thing like post_rpc() does, but I think it might be
tricky with the way the proxy_state code is structured.

Thoughts from people with more HTTP knowledge/experience?

-Peff
