Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF2A202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 20:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966248AbdIYU3T (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 16:29:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:49598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966245AbdIYU3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 16:29:18 -0400
Received: (qmail 2423 invoked by uid 109); 25 Sep 2017 20:29:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:29:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28510 invoked by uid 111); 25 Sep 2017 20:29:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 16:29:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 16:29:16 -0400
Date:   Mon, 25 Sep 2017 16:29:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many callers of read_in_full() complain when we do not read
their full byte-count. But a check like:

  if (read_in_full(fd, buf, len) != len)
	  return error_errno("unable to read");

conflates two problem conditions:

  1. A real error from read().

  2. There were fewer than "len" bytes available.

In the first case, showing the user strerror(errno) is
useful. But in the second, we may see a random errno that
was set by some previous system call.

In an ideal world, callers would always distinguish between
these cases and give a useful message for each. But as an
easy way to make our imperfect world better, let's reset
errno to a known value. The best we can do is "0", which
will yield something like:

  unable to read: Success

That's not great, but at least it's deterministic and makes
it clear that we didn't see an error from read().

Signed-off-by: Jeff King <peff@peff.net>
---
 wrapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wrapper.c b/wrapper.c
index 61aba0b5c1..f55debc92d 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -314,6 +314,7 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 	char *p = buf;
 	ssize_t total = 0;
 
+	errno = 0;
 	while (count > 0) {
 		ssize_t loaded = xread(fd, p, count);
 		if (loaded < 0)
-- 
2.14.1.1148.ga2561536a1

