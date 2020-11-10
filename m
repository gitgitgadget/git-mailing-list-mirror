Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA9C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FD020809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgKJVjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:39:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:53560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732052AbgKJViE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:38:04 -0500
Received: (qmail 9495 invoked by uid 109); 10 Nov 2020 21:38:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 21:38:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6085 invoked by uid 111); 10 Nov 2020 21:38:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 16:38:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 16:38:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Demi M. Obenour" <athena@invisiblethingslab.com>,
        Git <git@vger.kernel.org>
Subject: [PATCH 2/3] rev-parse: put all options under the "-" check
Message-ID: <20201110213803.GB788740@coredump.intra.peff.net>
References: <20201110213544.GA3263091@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110213544.GA3263091@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option-parsing loop of rev-parse checks whether the first character
of an arg is "-". If so, then it enters a series of conditionals
checking for individual options. But some options are inexplicably
outside of that outer conditional.

This doesn't produce the wrong behavior; the conditional is actually
redundant with the individual option checks, and it's really only its
fallback "continue" that we care about. But we should at least be
consistent.

One obvious alternative is that we could get rid of the conditional
entirely. But we'll be using the extra block it provides in the next
patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c | 47 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 293428fa0d..79689286d8 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -652,30 +652,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			did_repo_setup = 1;
 		}
 
-		if (!strcmp(arg, "--git-path")) {
-			if (!argv[i + 1])
-				die("--git-path requires an argument");
-			strbuf_reset(&buf);
-			puts(relative_path(git_path("%s", argv[i + 1]),
-					   prefix, &buf));
-			i++;
-			continue;
-		}
-		if (!strcmp(arg,"-n")) {
-			if (++i >= argc)
-				die("-n requires an argument");
-			if ((filter & DO_FLAGS) && (filter & DO_REVS)) {
-				show(arg);
-				show(argv[i]);
-			}
-			continue;
-		}
-		if (starts_with(arg, "-n")) {
-			if ((filter & DO_FLAGS) && (filter & DO_REVS))
-				show(arg);
-			continue;
-		}
-
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
 				as_is = 2;
@@ -684,6 +660,29 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					show_file(arg, 0);
 				continue;
 			}
+			if (!strcmp(arg, "--git-path")) {
+				if (!argv[i + 1])
+					die("--git-path requires an argument");
+				strbuf_reset(&buf);
+				puts(relative_path(git_path("%s", argv[i + 1]),
+						   prefix, &buf));
+				i++;
+				continue;
+			}
+			if (!strcmp(arg,"-n")) {
+				if (++i >= argc)
+					die("-n requires an argument");
+				if ((filter & DO_FLAGS) && (filter & DO_REVS)) {
+					show(arg);
+					show(argv[i]);
+				}
+				continue;
+			}
+			if (starts_with(arg, "-n")) {
+				if ((filter & DO_FLAGS) && (filter & DO_REVS))
+					show(arg);
+				continue;
+			}
 			if (!strcmp(arg, "--default")) {
 				def = argv[++i];
 				if (!def)
-- 
2.29.2.640.g9e24689a4c

