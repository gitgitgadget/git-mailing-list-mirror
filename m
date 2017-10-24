Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82DC11FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdJXSyU (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:54:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:42899 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdJXSyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:54:05 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C78D7845A3;
        Tue, 24 Oct 2017 14:54:04 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 353B284597;
        Tue, 24 Oct 2017 14:54:04 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 10/13] rev-list: add list-objects filtering support
Date:   Tue, 24 Oct 2017 18:53:29 +0000
Message-Id: <20171024185332.57261-11-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171024185332.57261-1-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
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

Furthermore, when the "--filter-print-omitted" option is
used, the omitted objects are printed at the end.  These
are marked with a "~".  This option can be combined with
"--quiet" to get a list of just the omitted objects.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-rev-list.txt     |  5 ++-
 Documentation/rev-list-options.txt | 30 ++++++++++++++
 builtin/rev-list.c                 | 84 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ef22f17..6d2e60d 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -47,7 +47,10 @@ SYNOPSIS
 	     [ --fixed-strings | -F ]
 	     [ --date=<format>]
 	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
-	       [ --unpacked ] ]
+	       [ --unpacked ]
+	       [ --filter=<filter-spec> ] ]
+	     [ --filter-print-missing ]
+	     [ --filter-print-omitted ]
 	     [ --pretty | --header ]
 	     [ --bisect ]
 	     [ --bisect-vars ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7d860bf..88f8878 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -706,6 +706,36 @@ ifdef::git-rev-list[]
 --unpacked::
 	Only useful with `--objects`; print the object IDs that are not
 	in packs.
+
+--filter=<filter-spec>::
+	Only useful with one of the `--objects*`; omits objects (usually
+	blobs) from the list of printed objects.  The '<filter-spec>'
+	may be one of the following:
++
+The form '--filter=blob:none' omits all blobs.
++
+The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
+or units.  The value may be zero.  Special files matching '.git*' are
+alwayse included, regardless of size.
++
+The form '--filter=sparse:oid=<oid-ish>' uses a sparse-checkout
+specification contained in the object (or the object that the expression
+evaluates to) to omit blobs not required by the corresponding sparse
+checkout.
++
+The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
+specification contained in <path>.
+
+--filter-print-missing::
+	Prints a list of the missing objects for the requested traversal.
+	Object IDs are prefixed with a ``?'' character.  The object type
+	is printed after the ID.  This may be used with or without any of
+	the above filtering options.
+
+--filter-print-omitted::
+	Only useful with one of the above `--filter*`; prints a list
+	of the omitted objects.  Object IDs are prefixed with a ``~''
+	character.
 endif::git-rev-list[]
 
 --no-walk[=(sorted|unsorted)]::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c1c74d4..7a0353f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -12,6 +12,7 @@
 #include "bisect.h"
 #include "progress.h"
 #include "reflog-walk.h"
+#include "partial-clone-utils.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -54,6 +55,11 @@ static const char rev_list_usage[] =
 
 static struct progress *progress;
 static unsigned progress_counter;
+static struct list_objects_filter_options filter_options;
+static struct oidmap missing_objects;
+static int arg_print_missing;
+static int arg_print_omitted;
+#define DEFAULT_MAP_SIZE (16*1024)
 
 static void finish_commit(struct commit *commit, void *data);
 static void show_commit(struct commit *commit, void *data)
@@ -181,8 +187,26 @@ static void finish_commit(struct commit *commit, void *data)
 static void finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
-	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
+	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
+		if (arg_print_missing) {
+			list_objects_filter_map_insert(
+				&missing_objects, &obj->oid, name, obj->type);
+			return;
+		}
+
+		/*
+		 * Relax consistency checks when we expect missing
+		 * objects because of partial-clone or a previous
+		 * partial-fetch.
+		 *
+		 * Note that this is independent of any filtering that
+		 * we are doing in this run.
+		 */
+		if (is_partial_clone_registered())
+			return;
+
 		die("missing blob object '%s'", oid_to_hex(&obj->oid));
+	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
 		parse_object(&obj->oid);
 }
@@ -202,6 +226,22 @@ static void show_edge(struct commit *commit)
 	printf("-%s\n", oid_to_hex(&commit->object.oid));
 }
 
+static void print_omitted_object(int i, int i_limit, struct list_objects_filter_map_entry *e, void *cb_data)
+{
+	/* struct rev_list_info *info = cb_data; */
+	const char *tn = typename(e->type);
+
+	printf("~%s %s\n", oid_to_hex(&e->entry.oid), tn);
+}
+
+static void print_missing_object(int i, int i_limit, struct list_objects_filter_map_entry *e, void *cb_data)
+{
+	/* struct rev_list_info *info = cb_data; */
+	const char *tn = typename(e->type);
+
+	printf("?%s %s\n", oid_to_hex(&e->entry.oid), tn);
+}
+
 static void print_var_str(const char *var, const char *val)
 {
 	printf("%s='%s'\n", var, val);
@@ -335,6 +375,26 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
+
+		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+			parse_list_objects_filter(&filter_options, arg);
+			if (filter_options.choice && !revs.blob_objects)
+				die(_("object filtering requires --objects"));
+			if (filter_options.choice == LOFC_SPARSE_OID &&
+			    !filter_options.sparse_oid_value)
+				die(_("invalid sparse value '%s'"),
+				    filter_options.raw_value);
+			continue;
+		}
+		if (!strcmp(arg, "--filter-print-missing")) {
+			arg_print_missing = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--filter-print-omitted")) {
+			arg_print_omitted = 1;
+			continue;
+		}
+		
 		usage(rev_list_usage);
 
 	}
@@ -360,6 +420,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.show_notes)
 		die(_("rev-list does not support display of notes"));
 
+	if (filter_options.choice && use_bitmap_index)
+		die(_("cannot combine --use-bitmap-index with object filtering"));
+
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
 			      revs.grep_filter.header_list);
@@ -404,7 +467,24 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
 
-	traverse_commit_list(&revs, show_commit, show_object, &info);
+	if (arg_print_missing) {
+		memset(&missing_objects, 0, sizeof(missing_objects));
+		oidmap_init(&missing_objects, DEFAULT_MAP_SIZE);
+	}
+
+	if (filter_options.choice)
+		traverse_commit_list_filtered(&filter_options, &revs,
+			show_commit, show_object,
+			(arg_print_omitted ? print_omitted_object : NULL),
+			&info);
+	else
+		traverse_commit_list(&revs, show_commit, show_object, &info);
+
+	if (arg_print_missing) {
+		list_objects_filter_map_foreach(&missing_objects,
+						print_missing_object, &info);
+		oidmap_free(&missing_objects, 1);
+	}
 
 	stop_progress(&progress);
 
-- 
2.9.3

