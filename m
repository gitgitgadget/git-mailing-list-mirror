Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D9E20281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbdI0GQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:16:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:51606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750753AbdI0GQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:16:47 -0400
Received: (qmail 25911 invoked by uid 109); 27 Sep 2017 06:16:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:16:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11568 invoked by uid 111); 27 Sep 2017 06:17:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:17:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:16:45 -0400
Date:   Wed, 27 Sep 2017 02:16:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] validate_headref: avoid reading uninitialized bytes
Message-ID: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at read_in_full() callers for a nearby patch series, I
noticed this fairly harmless bug. The first patch fixes it, and the
other two do some cleanups on top.

I'm tempted to say the whole thing ought to just use a strbuf. We
typically only call this function once per program, and git HEAD files
are small enough not to worry about. On the other hand, the point of the
function is to see if this is in fact a git repository. So in the rare
case that we see a file named ".git/HEAD" that's actually a 2GB video
file, we'd prefer to find out after reading only 256 bytes, not the
whole thing.

  [1/3]: validate_headref: NUL-terminate HEAD buffer
  [2/3]: validate_headref: use skip_prefix for symref parsing
  [3/3]: validate_headref: use get_oid_hex for detached HEADs

 path.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-Peff
