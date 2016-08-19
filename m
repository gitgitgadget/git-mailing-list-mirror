Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7500C1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754982AbcHSB5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:57:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:23223 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753822AbcHSBzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:55:01 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP; 18 Aug 2016 17:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,542,1464678000"; 
   d="scan'208";a="867906881"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2016 17:00:40 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v8 6/8] submodule: refactor show_submodule_summary with helper function
Date:   Thu, 18 Aug 2016 17:00:29 -0700
Message-Id: <20160819000031.24854-7-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
In-Reply-To: <20160819000031.24854-1-jacob.e.keller@intel.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

A future patch is going to add a new submodule diff format which
displays an inline diff of the submodule changes. To make this easier,
and to ensure that both submodule diff formats use the same initial
header, factor out show_submodule_header() function which will print the
current submodule header line, and then leave the show_submodule_summary
function to lookup and print the submodule log format.

This does create one format change in that "(revision walker failed)"
will now be displayed on its own line rather than as part of the message
because we no longer perform this step directly in the header display
flow. However, this is a rare case as most causes of the failure will be
due to a missing commit which we already check for and avoid previously.
flow. However, this is a rare case and shouldn't impact much.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 submodule.c | 108 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 76 insertions(+), 32 deletions(-)

diff --git a/submodule.c b/submodule.c
index 422353ccf6cc..7108b4786bc1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -277,8 +277,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 }
 
 static int prepare_submodule_summary(struct rev_info *rev, const char *path,
-		struct commit *left, struct commit *right,
-		int *fast_forward, int *fast_backward)
+		struct commit *left, struct commit *right)
 {
 	struct commit_list *merge_bases, *list;
 
@@ -290,12 +289,6 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	add_pending_object(rev, &left->object, path);
 	add_pending_object(rev, &right->object, path);
 	merge_bases = get_merge_bases(left, right);
-	if (merge_bases) {
-		if (merge_bases->item == left)
-			*fast_forward = 1;
-		else if (merge_bases->item == right)
-			*fast_backward = 1;
-	}
 	for (list = merge_bases; list; list = list->next) {
 		list->item->object.flags |= UNINTERESTING;
 		add_pending_object(rev, &list->item->object,
@@ -333,31 +326,23 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
-void show_submodule_summary(FILE *f, const char *path,
+/* Helper function to display the submodule header line prior to the full
+ * summary output. If it can locate the submodule objects directory it will
+ * attempt to lookup both the left and right commits and put them into the
+ * left and right pointers.
+ */
+static void show_submodule_header(FILE *f, const char *path,
 		const char *line_prefix,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset)
+		const char *reset,
+		struct commit **left, struct commit **right)
 {
-	struct rev_info rev;
-	struct commit *left = NULL, *right = NULL;
+	struct commit_list *merge_bases;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	int fast_forward = 0, fast_backward = 0;
 
-	if (is_null_oid(two))
-		message = "(submodule deleted)";
-	else if (add_submodule_odb(path))
-		message = "(not initialized)";
-	else if (is_null_oid(one))
-		message = "(new submodule)";
-	else if (!(left = lookup_commit_reference(one->hash)) ||
-		 !(right = lookup_commit_reference(two->hash)))
-		message = "(commits not present)";
-	else if (prepare_submodule_summary(&rev, path, left, right,
-					   &fast_forward, &fast_backward))
-		message = "(revision walker failed)";
-
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
 		fprintf(f, "%sSubmodule %s contains untracked content\n",
 			line_prefix, path);
@@ -365,11 +350,46 @@ void show_submodule_summary(FILE *f, const char *path,
 		fprintf(f, "%sSubmodule %s contains modified content\n",
 			line_prefix, path);
 
+	if (is_null_oid(one))
+		message = "(new submodule)";
+	else if (is_null_oid(two))
+		message = "(submodule deleted)";
+
+	if (add_submodule_odb(path)) {
+		if (!message)
+			message = "(not initialized)";
+		goto output_header;
+	}
+
+	/*
+	 * Attempt to lookup the commit references, and determine if this is
+	 * a fast forward or fast backwards update.
+	 */
+	*left = lookup_commit_reference(one->hash);
+	*right = lookup_commit_reference(two->hash);
+
+	/*
+	 * Warn about missing commits in the submodule project, but only if
+	 * they aren't null.
+	 */
+	if ((!is_null_oid(one) && !*left) ||
+	     (!is_null_oid(two) && !*right))
+		message = "(commits not present)";
+
+	merge_bases = get_merge_bases(*left, *right);
+	if (merge_bases) {
+		if (merge_bases->item == *left)
+			fast_forward = 1;
+		else if (merge_bases->item == *right)
+			fast_backward = 1;
+	}
+
 	if (!oidcmp(one, two)) {
 		strbuf_release(&sb);
 		return;
 	}
 
+output_header:
 	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
 			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
@@ -381,16 +401,40 @@ void show_submodule_summary(FILE *f, const char *path,
 		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
 	fwrite(sb.buf, sb.len, 1, f);
 
-	if (!message) /* only NULL if we succeeded in setting up the walk */
-		print_submodule_summary(&rev, f, line_prefix, del, add, reset);
-	if (left)
-		clear_commit_marks(left, ~0);
-	if (right)
-		clear_commit_marks(right, ~0);
-
 	strbuf_release(&sb);
 }
 
+void show_submodule_summary(FILE *f, const char *path,
+		const char *line_prefix,
+		struct object_id *one, struct object_id *two,
+		unsigned dirty_submodule, const char *meta,
+		const char *del, const char *add, const char *reset)
+{
+	struct rev_info rev;
+	struct commit *left = NULL, *right = NULL;
+
+	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
+			      meta, reset, &left, &right);
+
+	/*
+	 * If we don't have both a left and a right pointer, there is no
+	 * reason to try and display a summary. The header line should contain
+	 * all the information the user needs.
+	 */
+	if (!left || !right)
+		return;
+
+	/* Treat revision walker failure the same as missing commits */
+	if (prepare_submodule_summary(&rev, path, left, right)) {
+		fprintf(f, "%s(revision walker failed)\n", line_prefix);
+		return;
+	}
+
+	print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+	clear_commit_marks(left, ~0);
+	clear_commit_marks(right, ~0);
+}
+
 void set_config_fetch_recurse_submodules(int value)
 {
 	config_fetch_recurse_submodules = value;
-- 
2.10.0.rc0.217.g609f9e8.dirty

