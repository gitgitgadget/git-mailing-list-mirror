Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D7620281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdI0GR0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:17:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750703AbdI0GRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:17:25 -0400
Received: (qmail 25947 invoked by uid 109); 27 Sep 2017 06:17:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:17:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11618 invoked by uid 111); 27 Sep 2017 06:18:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:18:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:17:23 -0400
Date:   Wed, 27 Sep 2017 02:17:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] validate_headref: NUL-terminate HEAD buffer
Message-ID: <20170927061722.7ubswfgykxiawzh3@sigill.intra.peff.net>
References: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are checking to see if we have a git repo, we peek
into the HEAD file and see if it's a plausible symlink,
symref, or detached HEAD.

For the latter two, we read the contents with read_in_full(),
which means they aren't NUL-terminated. The symref check is
careful to respect the length we got, but the sha1 check
will happily parse up to 40 bytes, even if we read fewer.

E.g.,:

  echo 1234 >.git/HEAD
  git rev-parse

will parse 36 uninitialized bytes from our stack buffer.

This isn't a big deal in practice. Our buffer is 256 bytes,
so we know we'll never read outside of it. The worst case is
that the uninitialized bytes look like valid hex, and we
claim a bogus HEAD file is valid. The chances of this
happening randomly are quite slim, but let's be careful.

One option would be to check that "len == 41" before feeding
the buffer to get_sha1_hex(). But we'd like to eventually
prepare for a world with variable-length hashes. Let's
NUL-terminate as soon as we've read the buffer (we already
even leave a spare byte to do so!). That fixes this problem
without depending on the size of an object id.

Signed-off-by: Jeff King <peff@peff.net>
---
 path.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/path.c b/path.c
index b533ec938d..3e4d7505ef 100644
--- a/path.c
+++ b/path.c
@@ -662,6 +662,10 @@ int validate_headref(const char *path)
 	len = read_in_full(fd, buffer, sizeof(buffer)-1);
 	close(fd);
 
+	if (len < 0)
+		return -1;
+	buffer[len] = '\0';
+
 	/*
 	 * Is it a symbolic ref?
 	 */
-- 
2.14.2.988.g01c8b37dde

