From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] use struct sha1_array in diff_tree_combined()
Date: Sat, 17 Dec 2011 11:15:48 +0100
Message-ID: <4EEC6BD4.4040302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6?= =?ISO-8859-15?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 11:16:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrJG-0001QW-P1
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab1LQKQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:16:00 -0500
Received: from india601.server4you.de ([85.25.151.105]:40060 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1LQKP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:15:59 -0500
Received: from [192.168.2.105] (p579BE8BE.dip.t-dialin.net [87.155.232.190])
	by india601.server4you.de (Postfix) with ESMTPSA id 8AF0B2F8038;
	Sat, 17 Dec 2011 11:15:57 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187367>

Maintaining an array of hashes is easier using sha1_array than
open-coding it.  This patch also fixes a leak of the SHA1 array
in  diff_tree_combined_merge().

---
 builtin/diff.c |   12 ++++++------
 combine-diff.c |   34 +++++++++++++---------------------
 diff.h         |    3 ++-
 submodule.c    |   14 +++++---------
 4 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0fe638f..387afa7 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -14,6 +14,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "submodule.h"
+#include "sha1-array.h"
 
 struct blobinfo {
 	unsigned char sha1[20];
@@ -169,7 +170,7 @@ static int builtin_diff_combined(struct rev_info *revs,
 				 struct object_array_entry *ent,
 				 int ents)
 {
-	const unsigned char (*parent)[20];
+	struct sha1_array parents = SHA1_ARRAY_INIT;
 	int i;
 
 	if (argc > 1)
@@ -177,12 +178,11 @@ static int builtin_diff_combined(struct rev_info *revs,
 
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
-	parent = xmalloc(ents * sizeof(*parent));
-	for (i = 0; i < ents; i++)
-		hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
-	diff_tree_combined(parent[0], parent + 1, ents - 1,
+	for (i = 1; i < ents; i++)
+		sha1_array_append(&parents, ent[i].item->sha1);
+	diff_tree_combined(ent[0].item->sha1, &parents,
 			   revs->dense_combined_merges, revs);
-	free((void *)parent);
+	sha1_array_clear(&parents);
 	return 0;
 }
 
diff --git a/combine-diff.c b/combine-diff.c
index 214014d..cfe6230 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -8,6 +8,7 @@
 #include "log-tree.h"
 #include "refs.h"
 #include "userdiff.h"
+#include "sha1-array.h"
 
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
@@ -1116,15 +1117,14 @@ static void handle_combined_callback(struct diff_options *opt,
 }
 
 void diff_tree_combined(const unsigned char *sha1,
-			const unsigned char parent[][20],
-			int num_parent,
+			const struct sha1_array *parents,
 			int dense,
 			struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
 	struct diff_options diffopts;
 	struct combine_diff_path *p, *paths = NULL;
-	int i, num_paths, needsep, show_log_first;
+	int i, num_paths, needsep, show_log_first, num_parent = parents->nr;
 
 	diffopts = *opt;
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -1144,7 +1144,7 @@ void diff_tree_combined(const unsigned char *sha1,
 			diffopts.output_format = stat_opt;
 		else
 			diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
-		diff_tree_sha1(parent[i], sha1, "", &diffopts);
+		diff_tree_sha1(parents->sha1[i], sha1, "", &diffopts);
 		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
 
@@ -1199,22 +1199,14 @@ void diff_tree_combined(const unsigned char *sha1,
 void diff_tree_combined_merge(const unsigned char *sha1,
 			     int dense, struct rev_info *rev)
 {
-	int num_parent;
-	const unsigned char (*parent)[20];
 	struct commit *commit = lookup_commit(sha1);
-	struct commit_list *parents;
-
-	/* count parents */
-	for (parents = commit->parents, num_parent = 0;
-	     parents;
-	     parents = parents->next, num_parent++)
-		; /* nothing */
-
-	parent = xmalloc(num_parent * sizeof(*parent));
-	for (parents = commit->parents, num_parent = 0;
-	     parents;
-	     parents = parents->next, num_parent++)
-		hashcpy((unsigned char *)(parent + num_parent),
-			parents->item->object.sha1);
-	diff_tree_combined(sha1, parent, num_parent, dense, rev);
+	struct commit_list *parent = commit->parents;
+	struct sha1_array parents = SHA1_ARRAY_INIT;
+
+	while (parent) {
+		sha1_array_append(&parents, parent->item->object.sha1);
+		parent = parent->next;
+	}
+	diff_tree_combined(sha1, &parents, dense, rev);
+	sha1_array_clear(&parents);
 }
diff --git a/diff.h b/diff.h
index 0c51724..96085cb 100644
--- a/diff.h
+++ b/diff.h
@@ -12,6 +12,7 @@ struct diff_queue_struct;
 struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
+struct sha1_array;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -195,7 +196,7 @@ struct combine_diff_path {
 extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
 			      int dense, struct rev_info *);
 
-extern void diff_tree_combined(const unsigned char *sha1, const unsigned char parent[][20], int num_parent, int dense, struct rev_info *rev);
+extern void diff_tree_combined(const unsigned char *sha1, const struct sha1_array *parents, int dense, struct rev_info *rev);
 
 extern void diff_tree_combined_merge(const unsigned char *sha1, int, struct rev_info *);
 
diff --git a/submodule.c b/submodule.c
index 68c1ba9..788d532 100644
--- a/submodule.c
+++ b/submodule.c
@@ -373,15 +373,11 @@ static void collect_submodules_from_diff(struct diff_queue_struct *q,
 
 static void commit_need_pushing(struct commit *commit, struct commit_list *parent, int *needs_pushing)
 {
-	const unsigned char (*parents)[20];
-	unsigned int i, n;
+	struct sha1_array parents = SHA1_ARRAY_INIT;
 	struct rev_info rev;
 
-	n = commit_list_count(parent);
-	parents = xmalloc(n * sizeof(*parents));
-
-	for (i = 0; i < n; i++) {
-		hashcpy((unsigned char *)(parents + i), parent->item->object.sha1);
+	while (parent) {
+		sha1_array_append(&parents, parent->item->object.sha1);
 		parent = parent->next;
 	}
 
@@ -389,9 +385,9 @@ static void commit_need_pushing(struct commit *commit, struct commit_list *paren
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = collect_submodules_from_diff;
 	rev.diffopt.format_callback_data = needs_pushing;
-	diff_tree_combined(commit->object.sha1, parents, n, 1, &rev);
+	diff_tree_combined(commit->object.sha1, &parents, 1, &rev);
 
-	free((void *)parents);
+	sha1_array_clear(&parents);
 }
 
 int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
-- 
1.7.8
