Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FBE3202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbdIVUbc (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:31:32 -0400
Received: from siwi.pair.com ([209.68.5.199]:13690 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbdIVUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:31:31 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EA1758470B;
        Fri, 22 Sep 2017 16:31:30 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6FE008470A;
        Fri, 22 Sep 2017 16:31:30 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 09/13] rev-list: add object filtering support
Date:   Fri, 22 Sep 2017 20:30:13 +0000
Message-Id: <20170922203017.53986-10-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922203017.53986-6-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
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
 builtin/rev-list.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 95d84d5..5f54495 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -53,6 +53,8 @@ static const char rev_list_usage[] =
 
 static struct progress *progress;
 static unsigned progress_counter;
+static struct object_filter_options filter_options;
+static struct oidset2 missing_objects;
 
 static void finish_commit(struct commit *commit, void *data);
 static void show_commit(struct commit *commit, void *data)
@@ -179,8 +181,25 @@ static void finish_commit(struct commit *commit, void *data)
 static void finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
+	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
+		if (filter_options.print_missing) {
+			oidset2_insert(&missing_objects, &obj->oid, obj->type,
+				       -1, name);
+			return;
+		}
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
 		parse_object(&obj->oid);
 }
@@ -200,6 +219,25 @@ static void show_edge(struct commit *commit)
 	printf("-%s\n", oid_to_hex(&commit->object.oid));
 }
 
+static void print_omitted_object(int i, int i_limit, struct oidset2_entry *e, void *cb_data)
+{
+	/* struct rev_list_info *info = cb_data; */
+	const char *tn = typename(e->type);
+
+	if (e->object_length == -1)
+		printf("~%s %s\n", oid_to_hex(&e->oid), tn);
+	else
+		printf("~%s %s %"PRIuMAX"\n", oid_to_hex(&e->oid), tn, e->object_length);
+}
+
+static void print_missing_object(int i, int i_limit, struct oidset2_entry *e, void *cb_data)
+{
+	/* struct rev_list_info *info = cb_data; */
+	const char *tn = typename(e->type);
+
+	printf("?%s %s\n", oid_to_hex(&e->oid), tn);
+}
+
 static void print_var_str(const char *var, const char *val)
 {
 	printf("%s='%s'\n", var, val);
@@ -333,6 +371,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
+		if (object_filter_hand_parse_arg(
+			    &filter_options, arg, 1, 1, 1)) {
+			if (!revs.blob_objects)
+				die(_("object filtering requires --objects"));
+			if (filter_options.use_blob &&
+			    !oidcmp(&filter_options.sparse_oid, &null_oid))
+				die(_("invalid sparse value"));
+			continue;
+		}
 		usage(rev_list_usage);
 
 	}
@@ -357,6 +404,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
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
@@ -401,7 +453,24 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
 
-	traverse_commit_list(&revs, show_commit, show_object, &info);
+	if (filter_options.print_missing)
+		memset(&missing_objects, 0, sizeof(missing_objects));
+
+	if (object_filter_enabled(&filter_options))
+		traverse_commit_list_filtered(
+			&filter_options, &revs,
+			show_commit, show_object,
+			(filter_options.print_omitted
+			 ? print_omitted_object
+			 : NULL),
+			&info);
+	else
+		traverse_commit_list(&revs, show_commit, show_object, &info);
+
+	if (filter_options.print_missing) {
+		oidset2_foreach(&missing_objects, print_missing_object, &info);
+		oidset2_clear(&missing_objects);
+	}
 
 	stop_progress(&progress);
 
-- 
2.9.3

