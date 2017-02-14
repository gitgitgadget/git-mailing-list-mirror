Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C0B1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbdBNGCl (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:02:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:54872 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbdBNGCk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:02:40 -0500
Received: (qmail 11502 invoked by uid 109); 14 Feb 2017 06:02:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:02:40 +0000
Received: (qmail 660 invoked by uid 111); 14 Feb 2017 06:02:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:02:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:02:38 -0500
Date:   Tue, 14 Feb 2017 01:02:38 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 1/7] grep: move thread initialization a little lower
Message-ID: <20170214060237.gvzzbmjzerlqnzjv@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, we set up the threads for grep before parsing
the non-option arguments. In 53b8d931b (grep: disable
threading in non-worktree case, 2011-12-12), the thread code
got bumped lower in the function because it now needed to
know whether we got any revision arguments.

That put a big block of code in between the parsing of revs
and the parsing of pathspecs, both of which share some loop
variables. That makes it harder to read the code than the
original, where the shared loops were right next to each
other.

Let's bump the thread initialization until after all of the
parsing is done.

Signed-off-by: Jeff King <peff@peff.net>
---
I double-checked to make sure no other code was relying on
the thread setup having happened. I think we could actually
bump it quite a bit lower (to right before we actually start
grepping), but I doubt it matters much in practice.

 builtin/grep.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef49..5a282c4d0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1169,6 +1169,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
+	/* The rest are paths */
+	if (!seen_dashdash) {
+		int j;
+		for (j = i; j < argc; j++)
+			verify_filename(prefix, argv[j], j == i);
+	}
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD |
+		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
+		       prefix, argv + i);
+	pathspec.max_depth = opt.max_depth;
+	pathspec.recursive = 1;
+
 #ifndef NO_PTHREADS
 	if (list.nr || cached || show_in_pager)
 		num_threads = 0;
@@ -1190,20 +1204,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 #endif
 
-	/* The rest are paths */
-	if (!seen_dashdash) {
-		int j;
-		for (j = i; j < argc; j++)
-			verify_filename(prefix, argv[j], j == i);
-	}
-
-	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD |
-		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
-		       prefix, argv + i);
-	pathspec.max_depth = opt.max_depth;
-	pathspec.recursive = 1;
-
 	if (recurse_submodules) {
 		gitmodules_config();
 		compile_submodule_options(&opt, &pathspec, cached, untracked,
-- 
2.12.0.rc1.471.ga79ec8999

