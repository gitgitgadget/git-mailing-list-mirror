From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be sha1 based
Date: Mon, 24 Feb 2014 20:21:46 +0400
Message-ID: <0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHt-0003yX-33
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbaBXQVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:21:44 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34250 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbaBXQVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:43 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyHl-00040m-N3; Mon, 24 Feb 2014 20:21:41 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyJQ-0007A6-SM; Mon, 24 Feb 2014 20:23:24 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242603>

In the next commit this will allow to reduce intermediate calls, when
recursing into subtrees - at that stage we know only subtree sha1, and
it is natural for tree walker to start from that phase. For now we do

    diff_tree
        show_path
            diff_tree_sha1
                diff_tree
                    ...

and the change will allow to reduce it to

    diff_tree
        show_path
            diff_tree

Also, it will allow to omit allocating strbuf for each subtree, and just
reuse the common strbuf via playing with its len.

The above-mentioned improvements go in the next 2 patches.

The downside is that try_to_follow_renames(), if active, we cause
re-reading of 2 initial trees, which was negligible based on my timings,
and which is outweighed cogently by the upsides.

NOTE To keep with the current interface and semantics, I needed to
rename the function from diff_tree() to diff_tree_sha1(). As
diff_tree_sha1() was already used, and the function we are talking here
is its more low-level helper, let's use Linux convention for prefixing
such helpers with double underscore. So the final renaming is

    diff_tree() -> __diff_tree_sha1()

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

Changes since v1:

 - don't need to touch diff.h, as diff_tree() became static.

 tree-diff.c | 60 ++++++++++++++++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index b99622c..f90acf5 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -137,12 +137,17 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 	}
 }
 
-static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
-		     const char *base_str, struct diff_options *opt)
+static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
+			    const char *base_str, struct diff_options *opt)
 {
+	struct tree_desc t1, t2;
+	void *t1tree, *t2tree;
 	struct strbuf base;
 	int baselen = strlen(base_str);
 
+	t1tree = fill_tree_descriptor(&t1, old);
+	t2tree = fill_tree_descriptor(&t2, new);
+
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
 
@@ -155,39 +160,41 @@ static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		if (diff_can_quit_early(opt))
 			break;
 		if (opt->pathspec.nr) {
-			skip_uninteresting(t1, &base, opt);
-			skip_uninteresting(t2, &base, opt);
+			skip_uninteresting(&t1, &base, opt);
+			skip_uninteresting(&t2, &base, opt);
 		}
-		if (!t1->size && !t2->size)
+		if (!t1.size && !t2.size)
 			break;
 
-		cmp = tree_entry_pathcmp(t1, t2);
+		cmp = tree_entry_pathcmp(&t1, &t2);
 
 		/* t1 = t2 */
 		if (cmp == 0) {
 			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
-			    hashcmp(t1->entry.sha1, t2->entry.sha1) ||
-			    (t1->entry.mode != t2->entry.mode))
-				show_path(&base, opt, t1, t2);
+			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
+			    (t1.entry.mode != t2.entry.mode))
+				show_path(&base, opt, &t1, &t2);
 
-			update_tree_entry(t1);
-			update_tree_entry(t2);
+			update_tree_entry(&t1);
+			update_tree_entry(&t2);
 		}
 
 		/* t1 < t2 */
 		else if (cmp < 0) {
-			show_path(&base, opt, t1, /*t2=*/NULL);
-			update_tree_entry(t1);
+			show_path(&base, opt, &t1, /*t2=*/NULL);
+			update_tree_entry(&t1);
 		}
 
 		/* t1 > t2 */
 		else {
-			show_path(&base, opt, /*t1=*/NULL, t2);
-			update_tree_entry(t2);
+			show_path(&base, opt, /*t1=*/NULL, &t2);
+			update_tree_entry(&t2);
 		}
 	}
 
 	strbuf_release(&base);
+	free(t2tree);
+	free(t1tree);
 	return 0;
 }
 
@@ -202,7 +209,7 @@ static inline int diff_might_be_rename(void)
 		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
 }
 
-static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
+static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -240,7 +247,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_opts.break_opt = opt->break_opt;
 	diff_opts.rename_score = opt->rename_score;
 	diff_setup_done(&diff_opts);
-	diff_tree(t1, t2, base, &diff_opts);
+	__diff_tree_sha1(old, new, base, &diff_opts);
 	diffcore_std(&diff_opts);
 	free_pathspec(&diff_opts.pathspec);
 
@@ -301,23 +308,12 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
-	void *tree1, *tree2;
-	struct tree_desc t1, t2;
-	unsigned long size1, size2;
 	int retval;
 
-	tree1 = fill_tree_descriptor(&t1, old);
-	tree2 = fill_tree_descriptor(&t2, new);
-	size1 = t1.size;
-	size2 = t2.size;
-	retval = diff_tree(&t1, &t2, base, opt);
-	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
-		init_tree_desc(&t1, tree1, size1);
-		init_tree_desc(&t2, tree2, size2);
-		try_to_follow_renames(&t1, &t2, base, opt);
-	}
-	free(tree1);
-	free(tree2);
+	retval = __diff_tree_sha1(old, new, base, opt);
+	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
+		try_to_follow_renames(old, new, base, opt);
+
 	return retval;
 }
 
-- 
1.9.rc1.181.g641f458
