Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EA720281
	for <e@80x24.org>; Wed, 20 Sep 2017 20:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdITUhC (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:37:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:45158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751228AbdITUhC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:37:02 -0400
Received: (qmail 12624 invoked by uid 109); 20 Sep 2017 20:37:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 20:37:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16156 invoked by uid 111); 20 Sep 2017 20:37:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 16:37:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 16:37:00 -0400
Date:   Wed, 20 Sep 2017 16:36:59 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] revision: replace "struct cmdline_pathspec" with argv_array
Message-ID: <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
 <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 04:25:52PM -0400, Jeff King wrote:

> Isn't this whole thing just an argv_array, and this is argv_array_pushv?
> We even NULL-terminate it manually later on!
> 
> So rather than increasing the line count by adding
> free_cmdline_pathspec, I think we could actually _reduce_ it by
> converting to an argv array, as below. And then adding in your free
> would be one extra line.

Here it is with a commit message, and that final free added.

Sorry for stealing your patch, but I didn't want to suggest "couldn't
you replace this with argv_array" without actually seeing if it was
possible. At which point the patch was pretty much done.

-- >8 --
Subject: [PATCH] revision: replace "struct cmdline_pathspec" with argv_array

We assemble an array of strings in a custom struct,
NULL-terminate the result, and then pass it to
parse_pathspec().

But then we never free the array or the individual strings
(nor can we do the latter, as they are heap-allocated when
they come from stdin but not when they come from the
passed-in argv).

Let's swap this out for an argv_array. It does the same
thing with fewer lines of code, and it's safe to call
argv_array_clear() at the end to avoid a memory leak.

Reported-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/revision.c b/revision.c
index f9a90d71d2..1520f69d93 100644
--- a/revision.c
+++ b/revision.c
@@ -21,6 +21,7 @@
 #include "bisect.h"
 #include "packfile.h"
 #include "worktree.h"
+#include "argv-array.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1672,31 +1673,15 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	return 0;
 }
 
-struct cmdline_pathspec {
-	int alloc;
-	int nr;
-	const char **path;
-};
-
-static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
-{
-	while (*av) {
-		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
-		prune->path[prune->nr++] = *(av++);
-	}
-}
-
 static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
-				     struct cmdline_pathspec *prune)
+				     struct argv_array *prune)
 {
-	while (strbuf_getline(sb, stdin) != EOF) {
-		ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
-		prune->path[prune->nr++] = xstrdup(sb->buf);
-	}
+	while (strbuf_getline(sb, stdin) != EOF)
+		argv_array_push(prune, sb->buf);
 }
 
 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct cmdline_pathspec *prune)
+				      struct argv_array *prune)
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
@@ -2286,10 +2271,9 @@ static void NORETURN diagnose_missing_default(const char *def)
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
 	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0, revarg_opt;
-	struct cmdline_pathspec prune_data;
+	struct argv_array prune_data = ARGV_ARRAY_INIT;
 	const char *submodule = NULL;
 
-	memset(&prune_data, 0, sizeof(prune_data));
 	if (opt)
 		submodule = opt->submodule;
 
@@ -2305,7 +2289,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			argv[i] = NULL;
 			argc = i;
 			if (argv[i + 1])
-				append_prune_data(&prune_data, argv + i + 1);
+				argv_array_pushv(&prune_data, argv + i + 1);
 			seen_dashdash = 1;
 			break;
 		}
@@ -2366,14 +2350,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j], j == i);
 
-			append_prune_data(&prune_data, argv + i);
+			argv_array_pushv(&prune_data, argv + i);
 			break;
 		}
 		else
 			got_rev_arg = 1;
 	}
 
-	if (prune_data.nr) {
+	if (prune_data.argc) {
 		/*
 		 * If we need to introduce the magic "a lone ':' means no
 		 * pathspec whatsoever", here is the place to do so.
@@ -2388,11 +2372,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		 *	call init_pathspec() to set revs->prune_data here.
 		 * }
 		 */
-		ALLOC_GROW(prune_data.path, prune_data.nr + 1, prune_data.alloc);
-		prune_data.path[prune_data.nr++] = NULL;
 		parse_pathspec(&revs->prune_data, 0, 0,
-			       revs->prefix, prune_data.path);
+			       revs->prefix, prune_data.argv);
 	}
+	argv_array_clear(&prune_data);
 
 	if (revs->def == NULL)
 		revs->def = opt ? opt->def : NULL;
-- 
2.14.1.1040.gcaf8795f39

