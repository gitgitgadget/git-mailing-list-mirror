Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018DFC677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBXGh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXGhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:37:25 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403511EB5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:37:23 -0800 (PST)
Received: (qmail 3654 invoked by uid 109); 24 Feb 2023 06:37:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:37:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31077 invoked by uid 111); 24 Feb 2023 06:37:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:37:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:37:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/21] ls-refs: drop config caching
Message-ID: <Y/hbIj9T61+UYKF5@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for the v2 ls-refs command has an ensure_config_read() function
that tries to read the lsrefs.unborn config only once and caches it in
some static global variables.

There's no real need for this caching. In any given process we'd only
need the value twice (once to decide whether to advertise, and once if
somebody runs the command). And since the config code already has its
own cache, each access is only incurring a hash lookup and string
comparison anyway.

Since the values we set are going to be specific to the_repository, the
globals we set are a mild anti-pattern. In practice it's not a bug (yet)
since the server-side v2 code only handles a single repository anyway.
But it doesn't hurt to take a small step in the right direction and
model a good approach.

Note that we currently set two booleans: advertise_unborn and
allow_unborn. But we can get away with a single value, since "advertise"
naturally implies "allow". That lets us just convert this to a function
with a return value.

Note that we still always read from the_repository; we'll deal with that
in a follow-on patch.

Signed-off-by: Jeff King <peff@peff.net>
---
Mostly done as prep for the next patch, but IMHO the simplification here
is nice in its own right.

 ls-refs.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 697d4beb8d..4863813655 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -8,38 +8,32 @@
 #include "config.h"
 #include "string-list.h"
 
-static int config_read;
-static int advertise_unborn;
-static int allow_unborn;
-
-static void ensure_config_read(void)
+static enum {
+	UNBORN_IGNORE = 0,
+	UNBORN_ALLOW,
+	UNBORN_ADVERTISE /* implies ALLOW */
+} unborn_config(void)
 {
 	const char *str = NULL;
 
-	if (config_read)
-		return;
-
 	if (repo_config_get_string_tmp(the_repository, "lsrefs.unborn", &str)) {
 		/*
 		 * If there is no such config, advertise and allow it by
 		 * default.
 		 */
-		advertise_unborn = 1;
-		allow_unborn = 1;
+		return UNBORN_ADVERTISE;
 	} else {
 		if (!strcmp(str, "advertise")) {
-			advertise_unborn = 1;
-			allow_unborn = 1;
+			return UNBORN_ADVERTISE;
 		} else if (!strcmp(str, "allow")) {
-			allow_unborn = 1;
+			return UNBORN_ALLOW;
 		} else if (!strcmp(str, "ignore")) {
-			/* do nothing */
+			return UNBORN_IGNORE;
 		} else {
 			die(_("invalid value for '%s': '%s'"),
 			    "lsrefs.unborn", str);
 		}
 	}
-	config_read = 1;
 }
 
 /*
@@ -159,7 +153,6 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	strbuf_init(&data.buf, 0);
 	string_list_init_dup(&data.hidden_refs);
 
-	ensure_config_read();
 	git_config(ls_refs_config, &data);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
@@ -175,7 +168,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 				strvec_push(&data.prefixes, out);
 		}
 		else if (!strcmp("unborn", arg))
-			data.unborn = allow_unborn;
+			data.unborn = !!unborn_config();
 		else
 			die(_("unexpected line: '%s'"), arg);
 	}
@@ -206,11 +199,8 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 
 int ls_refs_advertise(struct repository *r, struct strbuf *value)
 {
-	if (value) {
-		ensure_config_read();
-		if (advertise_unborn)
-			strbuf_addstr(value, "unborn");
-	}
+	if (value && unborn_config() == UNBORN_ADVERTISE)
+		strbuf_addstr(value, "unborn");
 
 	return 1;
 }
-- 
2.39.2.981.g6157336f25

