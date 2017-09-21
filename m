Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C4F20281
	for <e@80x24.org>; Thu, 21 Sep 2017 06:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdIUGWq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 02:22:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:45712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751485AbdIUGWp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 02:22:45 -0400
Received: (qmail 5994 invoked by uid 109); 21 Sep 2017 06:22:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 06:22:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20041 invoked by uid 111); 21 Sep 2017 06:23:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 02:23:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 02:22:43 -0400
Date:   Thu, 21 Sep 2017 02:22:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] test-line-buffer: simplify command parsing
Message-ID: <20170921062242.t63u2gvpysrrmijs@sigill.intra.peff.net>
References: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The handle_command() function matches an incoming command
string with a sequence of starts_with() checks. But it also
surrounds these with a switch on the first character of the
command, which lets us jump to the right block of
starts_with() without going linearly through the list.

However, each case arm of the switch falls through to the
one below it. This is pointless (we know that a command
starting with 'b' does not need to check any of the commands
in the 'c' block), and it makes gcc's -Wimplicit-fallthrough
complain.

We could solve this by adding a break at the end of each
block. However, this optimization isn't helping anything.
Even if it does make matching faster (which is debatable),
this is code that is run only in the test suite, and each
run receives at most two of these "commands". We should
favor simplicity and readability over micro-optimizing.

Instead, let's drop the switch statement completely and
replace it with an if/else cascade.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-line-buffer.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/t/helper/test-line-buffer.c b/t/helper/test-line-buffer.c
index 81575fe2ab..078dd7e29d 100644
--- a/t/helper/test-line-buffer.c
+++ b/t/helper/test-line-buffer.c
@@ -17,27 +17,17 @@ static uint32_t strtouint32(const char *s)
 
 static void handle_command(const char *command, const char *arg, struct line_buffer *buf)
 {
-	switch (*command) {
-	case 'b':
-		if (starts_with(command, "binary ")) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addch(&sb, '>');
-			buffer_read_binary(buf, &sb, strtouint32(arg));
-			fwrite(sb.buf, 1, sb.len, stdout);
-			strbuf_release(&sb);
-			return;
-		}
-	case 'c':
-		if (starts_with(command, "copy ")) {
-			buffer_copy_bytes(buf, strtouint32(arg));
-			return;
-		}
-	case 's':
-		if (starts_with(command, "skip ")) {
-			buffer_skip_bytes(buf, strtouint32(arg));
-			return;
-		}
-	default:
+	if (starts_with(command, "binary ")) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addch(&sb, '>');
+		buffer_read_binary(buf, &sb, strtouint32(arg));
+		fwrite(sb.buf, 1, sb.len, stdout);
+		strbuf_release(&sb);
+	} else if (starts_with(command, "copy ")) {
+		buffer_copy_bytes(buf, strtouint32(arg));
+	} else if (starts_with(command, "skip ")) {
+		buffer_skip_bytes(buf, strtouint32(arg));
+	} else {
 		die("unrecognized command: %s", command);
 	}
 }
-- 
2.14.1.1051.g8c9143ec35

