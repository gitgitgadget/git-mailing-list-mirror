Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183681F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 12:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753690AbdIFMcP (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 08:32:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:58494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753674AbdIFMcM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 08:32:12 -0400
Received: (qmail 15566 invoked by uid 109); 6 Sep 2017 12:32:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 12:32:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21458 invoked by uid 111); 6 Sep 2017 12:32:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 08:32:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 08:32:10 -0400
Date:   Wed, 6 Sep 2017 08:32:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] git_extract_argv0_path: do nothing without RUNTIME_PREFIX
Message-ID: <20170906123209.5fjexq72qz77unfr@sigill.intra.peff.net>
References: <20170906122834.s7a6je4b7casdfxx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170906122834.s7a6je4b7casdfxx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the RUNTIME_PREFIX compile-time knob isn't set, we
never look at the argv0_path we extract. We can push its
declaration inside the #ifdef to make it more clear that the
extract code is effectively a noop.

This also un-confuses leak-checking of the argv0_path
variable when RUNTIME_PREFIX isn't set. The compiler is free
to drop this static variable that we set but never look at
(and "gcc -O2" does so).  But the compiler still must call
strbuf_detach(), since it doesn't know whether that function
has side effects; it just throws away the result rather than
putting it into the global.

Leak-checkers which work by scanning the data segment for
pointers to heap blocks would normally consider the block
as reachable at program end. But if the compiler removes the
variable entirely, there's nothing to find.

Signed-off-by: Jeff King <peff@peff.net>
---
 exec_cmd.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 61092e9715..ce192a2d64 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -5,9 +5,9 @@
 #define MAX_ARGS	32
 
 static const char *argv_exec_path;
-static const char *argv0_path;
 
 #ifdef RUNTIME_PREFIX
+static const char *argv0_path;
 
 static const char *system_prefix(void)
 {
@@ -27,6 +27,20 @@ static const char *system_prefix(void)
 	}
 	return prefix;
 }
+
+void git_extract_argv0_path(const char *argv0)
+{
+	const char *slash;
+
+	if (!argv0 || !*argv0)
+		return;
+
+	slash = find_last_dir_sep(argv0);
+
+	if (slash)
+		argv0_path = xstrndup(argv0, slash - argv0);
+}
+
 #else
 
 static const char *system_prefix(void)
@@ -34,6 +48,10 @@ static const char *system_prefix(void)
 	return PREFIX;
 }
 
+void git_extract_argv0_path(const char *argv0)
+{
+}
+
 #endif /* RUNTIME_PREFIX */
 
 char *system_path(const char *path)
@@ -47,19 +65,6 @@ char *system_path(const char *path)
 	return strbuf_detach(&d, NULL);
 }
 
-void git_extract_argv0_path(const char *argv0)
-{
-	const char *slash;
-
-	if (!argv0 || !*argv0)
-		return;
-
-	slash = find_last_dir_sep(argv0);
-
-	if (slash)
-		argv0_path = xstrndup(argv0, slash - argv0);
-}
-
 void git_set_argv_exec_path(const char *exec_path)
 {
 	argv_exec_path = exec_path;
-- 
2.14.1.757.g8fad538cea
