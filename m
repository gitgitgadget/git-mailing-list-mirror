Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89AAE1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933079AbcHCXIE (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:08:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54440 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933024AbcHCXID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:08:03 -0400
Received: (qmail 22813 invoked by uid 102); 3 Aug 2016 23:00:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:00:36 -0400
Received: (qmail 8010 invoked by uid 107); 3 Aug 2016 23:01:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 19:01:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 19:00:32 -0400
Date:	Wed, 3 Aug 2016 19:00:32 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: [PATCH 5/7] trace: correct variable name in write() error message
Message-ID: <20160803230032.hgbq4kdd6jiwcxb7@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Our error message for write() always mentions GIT_TRACE,
even though we may be writing for a different variable
entirely. It's also not quite accurate to say "fd given by
GIT_TRACE environment variable", as we may hit this error
based on a filename the user put in the variable (we do
complain and switch to stderr if the file cannot be opened,
but it's still possible to hit a write() error on the
descriptor later).

So let's fix those things, and switch to our more usual
"unable to do X: Y" format for the error.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/trace.c b/trace.c
index 4d68eb5..4efb256 100644
--- a/trace.c
+++ b/trace.c
@@ -93,9 +93,6 @@ void trace_disable(struct trace_key *key)
 	key->need_close = 0;
 }
 
-static const char err_msg[] = "could not trace into fd given by "
-	"GIT_TRACE environment variable";
-
 static int prepare_trace_line(const char *file, int line,
 			      struct trace_key *key, struct strbuf *buf)
 {
@@ -133,8 +130,11 @@ static int prepare_trace_line(const char *file, int line,
 
 static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 {
-	if (write_in_full(get_trace_fd(key), buf, len) < 0)
-		warning("%s: write error (%s)", err_msg, strerror(errno));
+	if (write_in_full(get_trace_fd(key), buf, len) < 0) {
+		normalize_trace_key(&key);
+		warning("unable to write trace for %s: %s",
+			key->key, strerror(errno));
+	}
 }
 
 void trace_verbatim(struct trace_key *key, const void *buf, unsigned len)
-- 
2.9.2.670.g42e63de

