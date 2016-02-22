From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Mon, 22 Feb 2016 10:58:58 +0800
Message-ID: <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 04:01:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXgkP-0003Pa-Km
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 04:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbcBVDBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 22:01:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:37629 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbcBVDBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 22:01:13 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP; 21 Feb 2016 19:01:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; 
   d="scan'208";a="920908278"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2016 19:01:13 -0800
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286874>

It would be helpful for maintainers or reviewers to know the base tree
info of the patches created by git format-patch. Teach git format-patch
a --base-tree-info option to record these info.

Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 builtin/log.c | 18 ++++++++++++++++++
 diff.c        |  4 ++++
 diff.h        |  3 ++-
 revision.h    |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0d738d6..bec7aee 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1189,6 +1189,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
 	struct commit **list = NULL;
+	struct commit_list *parents = NULL;
 	struct rev_info rev;
 	struct setup_revision_opt s_r_opt;
 	int nr = 0, total, i;
@@ -1200,6 +1201,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	int zero_commit = 0;
+	int base_tree_info = 0;
 	struct commit *origin = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
@@ -1242,6 +1244,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			 N_("don't output binary diffs")),
 		OPT_BOOL(0, "zero-commit", &zero_commit,
 			 N_("output all-zero hash in From header")),
+		OPT_BOOL(0, "base-tree-info", &base_tree_info,
+			 N_("Add base tree info")),
 		OPT_BOOL(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
 			 N_("don't include a patch matching a commit upstream")),
 		{ OPTION_SET_INT, 'p', "no-stat", &use_patch_format, NULL,
@@ -1387,6 +1391,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
 	rev.zero_commit = zero_commit;
+	rev.base_tree_info = base_tree_info;
 
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
@@ -1484,6 +1489,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		/* nothing to do */
 		return 0;
 	total = nr;
+	parents = get_saved_parents(&rev, list[nr-1]);
+	if (rev.base_tree_info && parents) {
+		struct commit *base_commit = parents->item;
+		sha1_to_hex_r(rev.diffopt.base_commit_id, base_commit->object.oid.hash);
+	}
+
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
 	if (numbered)
@@ -1516,6 +1527,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.numbered_files = just_numbers;
 	rev.patch_suffix = fmt_patch_suffix;
 	if (cover_letter) {
+		if (rev.base_tree_info)
+			DIFF_OPT_SET(&rev.diffopt, BASE_TREE_INFO);
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
@@ -1528,6 +1541,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		int shown;
 		commit = list[nr];
 		rev.nr = total - nr + (start_number - 1);
+		if (!cover_letter && rev.nr == 1 && rev.base_tree_info)
+			DIFF_OPT_SET(&rev.diffopt, BASE_TREE_INFO);
+		else
+			DIFF_OPT_CLR(&rev.diffopt, BASE_TREE_INFO);
+
 		/* Make the second and subsequent mails replies to the first */
 		if (thread) {
 			/* Have we already had a message ID? */
diff --git a/diff.c b/diff.c
index 2136b69..a23d5a5 100644
--- a/diff.c
+++ b/diff.c
@@ -4650,6 +4650,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
+
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
 	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
 	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
@@ -4673,6 +4674,9 @@ void diff_flush(struct diff_options *options)
 		}
 	}
 
+	if (DIFF_OPT_TST(options, BASE_TREE_INFO))
+		fprintf(options->file, "\nbase commit: %s\n", options->base_commit_id);
+
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
 			fprintf(options->file, "%s%c",
diff --git a/diff.h b/diff.h
index 70b2d70..0e62f63 100644
--- a/diff.h
+++ b/diff.h
@@ -69,7 +69,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
-/* (1 <<  9) unused */
+#define DIFF_OPT_BASE_TREE_INFO      (1 <<  9)
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
 #define DIFF_OPT_NO_INDEX            (1 << 12)
@@ -176,6 +176,7 @@ struct diff_options {
 	diff_prefix_fn_t output_prefix;
 	int output_prefix_length;
 	void *output_prefix_data;
+	char base_commit_id[GIT_SHA1_HEXSZ + 1];
 
 	int diff_path_counter;
 };
diff --git a/revision.h b/revision.h
index 23857c0..28c259b 100644
--- a/revision.h
+++ b/revision.h
@@ -136,6 +136,7 @@ struct rev_info {
 			abbrev_commit:1,
 			abbrev_commit_given:1,
 			zero_commit:1,
+			base_tree_info:1,
 			use_terminator:1,
 			missing_newline:1,
 			date_mode_explicit:1,
-- 
2.7.1.340.gf1cebb4
