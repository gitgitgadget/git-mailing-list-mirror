Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F4C54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjAGN0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAGN0q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:26:46 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716359F86
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:26:46 -0800 (PST)
Received: (qmail 23419 invoked by uid 109); 7 Jan 2023 13:26:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:26:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23624 invoked by uid 111); 7 Jan 2023 13:26:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:26:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:26:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] convert trivial uses of strncmp() to skip_prefix()
Message-ID: <Y7lzFG9gyDrOE4Xt@coredump.intra.peff.net>
References: <Y7lyga5g2leSmWQd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7lyga5g2leSmWQd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the previous patch, using skip_prefix() is more readable and
less error-prone than a raw strncmp(), because it avoids a
manually-computed length. These cases differ from the previous patch
that uses starts_with() because they care about the value after the
matched prefix.

We can convert these to use skip_prefix() by introducing an extra
variable to hold the out-pointer.

Note in the case in ws.c that to get rid of the magic number "9"
completely, we also switch out "len" for recomputing the pointer
difference. These are equivalent because "len" is always "ep - string".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote-ext.c | 6 ++++--
 ws.c                 | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index fd3538d4f0..ee338bf440 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -169,6 +169,8 @@ static int command_loop(const char *child)
 
 	while (1) {
 		size_t i;
+		const char *arg;
+
 		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
 			if (ferror(stdin))
 				die("Command input error");
@@ -182,10 +184,10 @@ static int command_loop(const char *child)
 		if (!strcmp(buffer, "capabilities")) {
 			printf("*connect\n\n");
 			fflush(stdout);
-		} else if (!strncmp(buffer, "connect ", 8)) {
+		} else if (skip_prefix(buffer, "connect ", &arg)) {
 			printf("\n");
 			fflush(stdout);
-			return run_child(child, buffer + 8);
+			return run_child(child, arg);
 		} else {
 			fprintf(stderr, "Bad command");
 			return 1;
diff --git a/ws.c b/ws.c
index 46a77bcad6..903bfcd53e 100644
--- a/ws.c
+++ b/ws.c
@@ -29,6 +29,7 @@ unsigned parse_whitespace_rule(const char *string)
 		int i;
 		size_t len;
 		const char *ep;
+		const char *arg;
 		int negated = 0;
 
 		string = string + strspn(string, ", \t\n\r");
@@ -52,15 +53,15 @@ unsigned parse_whitespace_rule(const char *string)
 				rule |= whitespace_rule_names[i].rule_bits;
 			break;
 		}
-		if (strncmp(string, "tabwidth=", 9) == 0) {
-			unsigned tabwidth = atoi(string + 9);
+		if (skip_prefix(string, "tabwidth=", &arg)) {
+			unsigned tabwidth = atoi(arg);
 			if (0 < tabwidth && tabwidth < 0100) {
 				rule &= ~WS_TAB_WIDTH_MASK;
 				rule |= tabwidth;
 			}
 			else
 				warning("tabwidth %.*s out of range",
-					(int)(len - 9), string + 9);
+					(int)(ep - arg), arg);
 		}
 		string = ep;
 	}
-- 
2.39.0.469.g9000b9c396
