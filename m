Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6F81F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbcHCXDm (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:03:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:54428 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932974AbcHCXDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:03:41 -0400
Received: (qmail 22648 invoked by uid 102); 3 Aug 2016 22:57:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 18:57:01 -0400
Received: (qmail 7898 invoked by uid 107); 3 Aug 2016 22:57:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 18:57:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 18:56:57 -0400
Date:	Wed, 3 Aug 2016 18:56:57 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: [PATCH 1/7] trace: handle NULL argument in trace_disable()
Message-ID: <20160803225657.vdjih5mzvdmilx4d@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

All of the trace functions treat a NULL key as a synonym for
the default GIT_TRACE key. Except for trace_disable(), which
will segfault.

Fortunately, this can't cause any bugs, as the function has
no callers. But rather than drop it, let's fix the bug, as I
plan to add a caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/trace.c b/trace.c
index 4aeea60..f204a7d 100644
--- a/trace.c
+++ b/trace.c
@@ -25,15 +25,25 @@
 #include "cache.h"
 #include "quote.h"
 
+/*
+ * "Normalize" a key argument by converting NULL to our trace_default,
+ * and otherwise passing through the value. All caller-facing functions
+ * should normalize their inputs in this way, though most get it
+ * for free by calling get_trace_fd() (directly or indirectly).
+ */
+static void normalize_trace_key(struct trace_key **key)
+{
+	static struct trace_key trace_default = { "GIT_TRACE" };
+	if (!*key)
+		*key = &trace_default;
+}
+
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
 {
-	static struct trace_key trace_default = { "GIT_TRACE" };
 	const char *trace;
 
-	/* use default "GIT_TRACE" if NULL */
-	if (!key)
-		key = &trace_default;
+	normalize_trace_key(&key);
 
 	/* don't open twice */
 	if (key->initialized)
@@ -75,6 +85,8 @@ static int get_trace_fd(struct trace_key *key)
 
 void trace_disable(struct trace_key *key)
 {
+	normalize_trace_key(&key);
+
 	if (key->need_close)
 		close(key->fd);
 	key->fd = 0;
-- 
2.9.2.670.g42e63de

