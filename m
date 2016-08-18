Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3422018E
	for <e@80x24.org>; Thu, 18 Aug 2016 00:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbcHRAvn (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 20:51:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:55933 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943AbcHRAvh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 20:51:37 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 17 Aug 2016 17:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,536,1464678000"; 
   d="scan'208";a="157475898"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2016 17:51:33 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v7 6/7] submodule: refactor show_submodule_summary with helper function
Date:	Wed, 17 Aug 2016 17:51:30 -0700
Message-Id: <20160818005131.31600-7-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
In-Reply-To: <20160818005131.31600-1-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
flow. However, this is a rare case and shouldn't impact much. In
addition, since we no longer need to run prepare_submodule_summary to
get the fast_backward and fast_forward variables, these have been
removed from that call, and the show_submodule_header() function does
its own mergebase lookup.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 submodule.c | 103 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 29 deletions(-)

diff --git a/submodule.c b/submodule.c
index e1a51b7506ff..e341ca7ffefd 100644
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
 		unsigned char one[20], unsigned char two[20],
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
 
-	if (is_null_sha1(two))
-		message = "(submodule deleted)";
-	else if (add_submodule_odb(path))
-		message = "(not initialized)";
-	else if (is_null_sha1(one))
-		message = "(new submodule)";
-	else if (!(left = lookup_commit_reference(one)) ||
-		 !(right = lookup_commit_reference(two)))
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
 
+	if (is_null_sha1(one))
+		message = "(new submodule)";
+	else if (is_null_sha1(two))
+		message = "(submodule deleted)";
+
+	if (add_submodule_odb(path)) {
+		if (!message)
+			message = "(submodule not initialized)";
+		goto output_header;
+	}
+
+	/*
+	 * Attempt to lookup the commit references, and determine if this is
+	 * a fast forward or fast backwards update
+	 */
+	*left = lookup_commit_reference(one);
+	*right = lookup_commit_reference(two);
+
+	/*
+	 * Warn about missing commits in the submodule project, but only if
+	 * they aren't null
+	 */
+	if ((!is_null_sha1(one) && !*left) ||
+	     (!is_null_sha1(two) && !*right))
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
 	if (!hashcmp(one, two)) {
 		strbuf_release(&sb);
 		return;
 	}
 
+output_header:
 	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
 			find_unique_abbrev(one, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
@@ -381,14 +401,39 @@ void show_submodule_summary(FILE *f, const char *path,
 		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
 	fwrite(sb.buf, sb.len, 1, f);
 
-	if (!message) /* only NULL if we succeeded in setting up the walk */
-		print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+	strbuf_release(&sb);
+}
+
+void show_submodule_summary(FILE *f, const char *path,
+		const char *line_prefix,
+		unsigned char one[20], unsigned char two[20],
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
+	 * if we don't have both a left and a right pointer, then we can't
+	 * display a summary
+	 */
+	if (!left || !right)
+		return;
+
+	if (prepare_submodule_summary(&rev, path, left, right)) {
+		fprintf(f, "%s(revision walker failed)\n", line_prefix);
+		return;
+	}
+
+	print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+
 	if (left)
 		clear_commit_marks(left, ~0);
 	if (right)
 		clear_commit_marks(right, ~0);
-
-	strbuf_release(&sb);
 }
 
 void set_config_fetch_recurse_submodules(int value)
-- 
2.10.0.rc0.217.g609f9e8.dirty

