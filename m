Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5602120A21
	for <e@80x24.org>; Wed, 13 Sep 2017 17:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdIMRRi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:17:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:37224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751279AbdIMRRe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:17:34 -0400
Received: (qmail 23064 invoked by uid 109); 13 Sep 2017 17:17:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 17:17:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17538 invoked by uid 111); 13 Sep 2017 17:18:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:18:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 13:17:30 -0400
Date:   Wed, 13 Sep 2017 13:17:30 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 5/7] pkt-line: check write_in_full() errors against "< 0"
Message-ID: <20170913171730.ckcebchjhhvtwcsj@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the previous two commits, we prefer to check
write_in_full()'s return value to see if it is negative,
rather than comparing it to the input length.

These cases actually flip the logic to check for success,
making conversion a little different than in other cases. We
could of course write:

  if (write_in_full(...) >= 0)
          return 0;
  return error(...);

But our usual method of spelling write() error checks is
just "< 0". So let's flip the logic for each of these
conditionals to our usual style.

Signed-off-by: Jeff King <peff@peff.net>
---
This will have a minor textual conflict with ma/pkt-line-leakfix which
hasn't quite made it into master yet. The resolution should be
straight-forward, though.

 pkt-line.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 7db9119573..4823d3bb9d 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -94,9 +94,9 @@ void packet_flush(int fd)
 int packet_flush_gently(int fd)
 {
 	packet_trace("0000", 4, 1);
-	if (write_in_full(fd, "0000", 4) == 4)
-		return 0;
-	return error("flush packet write failed");
+	if (write_in_full(fd, "0000", 4) < 0)
+		return error("flush packet write failed");
+	return 0;
 }
 
 void packet_buf_flush(struct strbuf *buf)
@@ -137,18 +137,17 @@ static int packet_write_fmt_1(int fd, int gently,
 			      const char *fmt, va_list args)
 {
 	struct strbuf buf = STRBUF_INIT;
-	ssize_t count;
 
 	format_packet(&buf, fmt, args);
-	count = write_in_full(fd, buf.buf, buf.len);
-	if (count == buf.len)
-		return 0;
-
-	if (!gently) {
-		check_pipe(errno);
-		die_errno("packet write with format failed");
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		if (!gently) {
+			check_pipe(errno);
+			die_errno("packet write with format failed");
+		}
+		return error("packet write with format failed");
 	}
-	return error("packet write with format failed");
+
+	return 0;
 }
 
 void packet_write_fmt(int fd, const char *fmt, ...)
@@ -183,9 +182,9 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	packet_size = size + 4;
 	set_packet_header(packet_write_buffer, packet_size);
 	memcpy(packet_write_buffer + 4, buf, size);
-	if (write_in_full(fd_out, packet_write_buffer, packet_size) == packet_size)
-		return 0;
-	return error("packet write failed");
+	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
+		return error("packet write failed");
+	return 0;
 }
 
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
-- 
2.14.1.874.ge7b2e05270

