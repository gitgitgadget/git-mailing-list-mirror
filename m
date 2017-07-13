Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98303202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbdGMRgG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:36:06 -0400
Received: from siwi.pair.com ([209.68.5.199]:11037 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752525AbdGMRfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:37 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 56B50844E3;
        Thu, 13 Jul 2017 13:35:36 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A8D9B844E5;
        Thu, 13 Jul 2017 13:35:35 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 08/19] rev-list: add object filtering support
Date:   Thu, 13 Jul 2017 17:34:48 +0000
Message-Id: <20170713173459.3559-9-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach rev-list to use the filtering provided by the
traverse_commit_list_filtered() interface to omit
unwanted objects from the result.

This feature is only enabled when one of the "--objects*"
options are used.

When the "--filter-print-manifest" option is used, the
omitted objects and their sizes are printed at the end.
These are marked with a "~".  This can be combined with
"--quiet" to get a list of just the omitted objects.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/rev-list.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bcf77f0..fd9a7e5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -3,6 +3,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "list-objects-filters.h"
+#include "object-filter.h"
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "builtin.h"
@@ -52,6 +54,7 @@ static const char rev_list_usage[] =
 
 static struct progress *progress;
 static unsigned progress_counter;
+static struct object_filter_options filter_options;
 
 static void finish_commit(struct commit *commit, void *data);
 static void show_commit(struct commit *commit, void *data)
@@ -178,8 +181,20 @@ static void finish_commit(struct commit *commit, void *data)
 static void finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
+	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
+		if (filter_options.relax) {
+			/*
+			 * Relax consistency checks to not complain about
+			 * omitted objects (presumably caused by use of
+			 * the previous use of the 'filter-objects' feature).
+			 *
+			 * Note that this is independent of any filtering that
+			 * we are doing in this run.
+			 */
+			return;
+		}
 		die("missing blob object '%s'", oid_to_hex(&obj->oid));
+	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
 		parse_object(obj->oid.hash);
 }
@@ -199,6 +214,16 @@ static void show_edge(struct commit *commit)
 	printf("-%s\n", oid_to_hex(&commit->object.oid));
 }
 
+static void print_omitted_object(int i, int i_limit, struct oidset2_entry *e, void *cb_data)
+{
+	/* struct rev_list_info *info = cb_data; */
+
+	if (e->object_length == -1)
+		printf("~%s\n", oid_to_hex(&e->oid));
+	else
+		printf("~%s %"PRIuMAX"\n", oid_to_hex(&e->oid), e->object_length);
+}
+
 static void print_var_str(const char *var, const char *val)
 {
 	printf("%s='%s'\n", var, val);
@@ -276,6 +301,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
 	const char *show_progress = NULL;
+	oidset2_foreach_cb fn_filter_print = NULL;
 
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
@@ -329,6 +355,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
+		if (object_filter_hand_parse_arg(&filter_options, arg, 1, 1)) {
+			if (!revs.blob_objects)
+				die(_("object filtering requires --objects"));
+			if (filter_options.use_sparse &&
+			    !oidcmp(&filter_options.sparse_oid, &null_oid))
+				die(_("invalid sparse value"));
+			continue;
+		}
 		usage(rev_list_usage);
 
 	}
@@ -353,6 +387,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.show_notes)
 		die(_("rev-list does not support display of notes"));
 
+	if (object_filter_enabled(&filter_options)) {
+		if (use_bitmap_index)
+			die(_("cannot combine --use-bitmap-index with object filtering"));
+	}
+
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
 			      revs.grep_filter.header_list);
@@ -397,7 +436,22 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
 
-	traverse_commit_list(&revs, show_commit, show_object, &info);
+	if (filter_options.print_manifest)
+		fn_filter_print = print_omitted_object;
+
+	if (filter_options.omit_all_blobs)
+		traverse_commit_list_omit_all_blobs(
+			&revs, show_commit, show_object, fn_filter_print, &info);
+	else if (filter_options.omit_large_blobs)
+		traverse_commit_list_omit_large_blobs(
+			&revs, show_commit, show_object, fn_filter_print, &info,
+			(int64_t)(uint64_t)filter_options.large_byte_limit);
+	else if (filter_options.use_sparse)
+		traverse_commit_list_use_sparse(
+			&revs, show_commit, show_object, fn_filter_print, &info,
+			&filter_options.sparse_oid);
+	else
+		traverse_commit_list(&revs, show_commit, show_object, &info);
 
 	stop_progress(&progress);
 
-- 
2.9.3

