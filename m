Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC882018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbcGOK2U (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:28:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:45299 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932082AbcGOK2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:28:19 -0400
Received: (qmail 17954 invoked by uid 102); 15 Jul 2016 10:28:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:28:18 -0400
Received: (qmail 14143 invoked by uid 107); 15 Jul 2016 10:28:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:28:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:28:07 -0400
Date:	Fri, 15 Jul 2016 06:28:07 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 02/12] rev-list: add optional progress reporting
Message-ID: <20160715102806.GB19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It's easy to ask rev-list to do a traversal that may take
many seconds (e.g., by calling "--objects --all"). In theory
you can monitor its progress by the output you get to
stdout, but this isn't always easy.

Some operations, like "--count", don't make any output until
the end.

And some callers, like check_everything_connected(), are
using it just for the error-checking of the traversal, and
throw away stdout entirely.

This patch adds a "--progress" option which can be used to
give some eye-candy for a user waiting for a long traversal.
This is just a rev-list option and not a regular traversal
option, because it needs cooperation from the callbacks in
builtin/rev-list.c to do the actual count.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt |  4 ++++
 builtin/rev-list.c                 | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index c5bd218..f39cb6d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -274,6 +274,10 @@ ifdef::git-rev-list[]
 	Try to speed up the traversal using the pack bitmap index (if
 	one is available). Note that when traversing with `--objects`,
 	trees and blobs will not have their associated path printed.
+
+--progress=<header>::
+	Show progress reports on stderr as objects are considered. The
+	`<header>` text will be printed with each progress update.
 endif::git-rev-list[]
 
 --
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b82bcc3..88d95a7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -9,6 +9,7 @@
 #include "log-tree.h"
 #include "graph.h"
 #include "bisect.h"
+#include "progress.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -49,12 +50,17 @@ static const char rev_list_usage[] =
 "    --bisect-all"
 ;
 
+struct progress *progress;
+unsigned progress_counter;
+
 static void finish_commit(struct commit *commit, void *data);
 static void show_commit(struct commit *commit, void *data)
 {
 	struct rev_list_info *info = data;
 	struct rev_info *revs = info->revs;
 
+	display_progress(progress, ++progress_counter);
+
 	if (info->flags & REV_LIST_QUIET) {
 		finish_commit(commit, data);
 		return;
@@ -190,6 +196,7 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
 	finish_object(obj, name, cb_data);
+	display_progress(progress, ++progress_counter);
 	if (info->flags & REV_LIST_QUIET)
 		return;
 	show_object_with_name(stdout, obj, name);
@@ -276,6 +283,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
+	const char *show_progress = NULL;
 
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
@@ -325,6 +333,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			test_bitmap_walk(&revs);
 			return 0;
 		}
+		if (skip_prefix(arg, "--progress=", &arg)) {
+			show_progress = arg;
+			continue;
+		}
 		usage(rev_list_usage);
 
 	}
@@ -355,6 +367,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list)
 		revs.limited = 1;
 
+	if (show_progress)
+		progress = start_progress_delay(show_progress, 0, 0, 2);
+
 	if (use_bitmap_index && !revs.prune) {
 		if (revs.count && !revs.left_right && !revs.cherry_mark) {
 			uint32_t commit_count;
@@ -392,6 +407,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	traverse_commit_list(&revs, show_commit, show_object, &info);
 
+	stop_progress(&progress);
+
 	if (revs.count) {
 		if (revs.left_right && revs.cherry_mark)
 			printf("%d\t%d\t%d\n", revs.count_left, revs.count_right, revs.count_same);
-- 
2.9.1.434.g748be50

