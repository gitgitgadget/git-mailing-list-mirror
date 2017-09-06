Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5D31F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 12:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbdIFMaa (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 08:30:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:58488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752766AbdIFMaa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 08:30:30 -0400
Received: (qmail 15503 invoked by uid 109); 6 Sep 2017 12:30:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 12:30:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21440 invoked by uid 111); 6 Sep 2017 12:31:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 08:31:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 08:30:28 -0400
Date:   Wed, 6 Sep 2017 08:30:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] system_path: move RUNTIME_PREFIX to a sub-function
Message-ID: <20170906123027.w5y7s33p5p2kfzia@sigill.intra.peff.net>
References: <20170906122834.s7a6je4b7casdfxx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170906122834.s7a6je4b7casdfxx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The system_path() function has an #ifdef in the middle of
it. Let's move the conditional logic into a sub-function.
This isolates it more, which will make it easier to change
and add to.

Signed-off-by: Jeff King <peff@peff.net>
---
I find the diff hard to read because it shows the opposite of what I did
(moving the big block to its own function, rather than moving the little
bits to a new copy of the function).

 exec_cmd.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index fb94aeba9c..61092e9715 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -7,19 +7,12 @@
 static const char *argv_exec_path;
 static const char *argv0_path;
 
-char *system_path(const char *path)
-{
 #ifdef RUNTIME_PREFIX
-	static const char *prefix;
-#else
-	static const char *prefix = PREFIX;
-#endif
-	struct strbuf d = STRBUF_INIT;
 
-	if (is_absolute_path(path))
-		return xstrdup(path);
+static const char *system_prefix(void)
+{
+	static const char *prefix;
 
-#ifdef RUNTIME_PREFIX
 	assert(argv0_path);
 	assert(is_absolute_path(argv0_path));
 
@@ -32,9 +25,25 @@ char *system_path(const char *path)
 				"but prefix computation failed.  "
 				"Using static fallback '%s'.\n", prefix);
 	}
-#endif
+	return prefix;
+}
+#else
+
+static const char *system_prefix(void)
+{
+	return PREFIX;
+}
+
+#endif /* RUNTIME_PREFIX */
+
+char *system_path(const char *path)
+{
+	struct strbuf d = STRBUF_INIT;
+
+	if (is_absolute_path(path))
+		return xstrdup(path);
 
-	strbuf_addf(&d, "%s/%s", prefix, path);
+	strbuf_addf(&d, "%s/%s", system_prefix(), path);
 	return strbuf_detach(&d, NULL);
 }
 
-- 
2.14.1.757.g8fad538cea

