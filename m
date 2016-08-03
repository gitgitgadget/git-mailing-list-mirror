Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3141F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbcHCW7O (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:59:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:54402 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932949AbcHCW7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:59:12 -0400
Received: (qmail 22701 invoked by uid 102); 3 Aug 2016 22:58:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 18:58:04 -0400
Received: (qmail 7903 invoked by uid 107); 3 Aug 2016 22:58:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 18:58:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 18:58:00 -0400
Date:	Wed, 3 Aug 2016 18:58:00 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: [PATCH 2/7] trace: stop using write_or_whine_pipe()
Message-ID: <20160803225800.mwwznno7tiujycgt@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The write_or_whine_pipe function does two things:

  1. it checks for EPIPE and converts it into a signal death

  2. it prints a message to stderr on error

The first thing does not help us, and actively hurts.
Generally we would simply die from SIGPIPE in this case,
unless somebody has taken the time to ignore SIGPIPE for the
whole process.  And if they _did_ do that, it seems rather
silly for the trace code, which otherwise takes pains to
continue even in the face of errors (e.g., by not using
write_or_die!), to take down the whole process for one
specific type of error.

Nor does the second thing help us; it just makes it harder
to write our error message, because we have to feed bits of
it as an argument to write_or_whine_pipe(). Translators
never get to see the full message, and it's hard for us to
customize it.

Let's switch to just using write_in_full() and writing our
own error string. For now, the error is identical to what
write_or_whine_pipe() would say, but now that it's more
under our control, we can improve it in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/trace.c b/trace.c
index f204a7d..bdbe149 100644
--- a/trace.c
+++ b/trace.c
@@ -132,18 +132,23 @@ static int prepare_trace_line(const char *file, int line,
 	return 1;
 }
 
+static void trace_write(struct trace_key *key, const void *buf, unsigned len)
+{
+	if (write_in_full(get_trace_fd(key), buf, len) < 0)
+		fprintf(stderr, "%s: write error (%s)\n", err_msg, strerror(errno));
+}
+
 void trace_verbatim(struct trace_key *key, const void *buf, unsigned len)
 {
 	if (!trace_want(key))
 		return;
-	write_or_whine_pipe(get_trace_fd(key), buf, len, err_msg);
+	trace_write(key, buf, len);
 }
 
 static void print_trace_line(struct trace_key *key, struct strbuf *buf)
 {
 	strbuf_complete_line(buf);
-
-	write_or_whine_pipe(get_trace_fd(key), buf->buf, buf->len, err_msg);
+	trace_write(key, buf->buf, buf->len);
 	strbuf_release(buf);
 }
 
-- 
2.9.2.670.g42e63de

