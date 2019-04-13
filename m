Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E7020248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDMFyE (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:54:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbfDMFyE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:54:04 -0400
Received: (qmail 27743 invoked by uid 109); 13 Apr 2019 05:54:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 05:54:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12619 invoked by uid 111); 13 Apr 2019 05:54:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Apr 2019 01:54:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2019 01:54:02 -0400
Date:   Sat, 13 Apr 2019 01:54:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: [PATCH 4/7] pkt-line: prepare buffer before handling ERR packets
Message-ID: <20190413055401.GD19495@sigill.intra.peff.net>
References: <20190413055127.GA32340@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413055127.GA32340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 2d103c31c2 (pack-protocol.txt: accept error packets in any
context, 2018-12-29), the pktline code will detect an ERR packet and die
automatically, saving the caller from dealing with it. But we do so too
early in the function, before we have terminated the buffer with a NUL.

As a result, passing the ERR message to die() may result in us printing
random cruft from a previous packet. This doesn't trigger memory tools
like ASan because we reuse the same buffer over and over (so the
contents are valid and initialized; they're just stale).

We can see demonstrate this by tightening the regex we use to match the
error message in t5516; without this patch, git-fetch will accidentally
print the capabilities from the (much longer) initial packet we
received.

By moving the ERR code later in the function we get a few other
benefits, too:

  - we'll now chomp any newline sent by the other side (which is what we
    want, since die() will add its own newline)

  - we'll now mention the ERR packet with GIT_TRACE_PACKET

Signed-off-by: Jeff King <peff@peff.net>
---
 pkt-line.c            | 9 +++++----
 t/t5516-fetch-push.sh | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index ffd7220544..c9ed780d0b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -350,16 +350,17 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		return PACKET_READ_EOF;
 	}
 
-	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
-	    starts_with(buffer, "ERR "))
-		die(_("remote error: %s"), buffer + 4);
-
 	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
 	    len && buffer[len-1] == '\n')
 		len--;
 
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
+
+	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
+	    starts_with(buffer, "ERR "))
+		die(_("remote error: %s"), buffer + 4);
+
 	*pktlen = len;
 	return PACKET_READ_NORMAL;
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 747dc4c31d..98ef71b48c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1241,7 +1241,7 @@ do
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
 			test_must_fail git fetch ../testrepo/.git $SHA1_3 2>err &&
-			test_i18ngrep "remote error:.*not our ref" err
+			test_i18ngrep "remote error:.*not our ref.*$SHA1_3\$" err
 		)
 	'
 done
-- 
2.21.0.931.gd0bc72a411

