From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 06/19] tree-diff: consolidate code for emitting diffs and recursion in one place
Date: Mon, 24 Feb 2014 20:21:38 +0400
Message-ID: <696b8f0956f5d7699911a3bb56d66602301ee36c.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHG-0003Pq-Gy
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbaBXQVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:21:03 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34164 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbaBXQVC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:02 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyH5-0003zz-S6; Mon, 24 Feb 2014 20:20:59 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyIk-00079i-UC; Mon, 24 Feb 2014 20:22:42 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242595>

Currently both compare_tree_entry() and show_path() invoke opt diff
callbacks (opt->add_remove() and opt->change()), and also they both have
code which decides whether to recurse into sub-tree, and whether to emit
a tree as separate entry if DIFF_OPT_TREE_IN_RECURSIVE is set.

I.e. we have code duplication and logic scattered on two places.

Let's consolidate it - all diff emmiting code and recurion logic moves
to show_entry, which is now named as show_path, because it shows diff
for a path, based on up to two tree entries, with actual diff emitting
code being kept in new helper emit_diff() for clarity.

What we have as the result, is that compare_tree_entry is now free from
code with logic for diff generation, and also performance is not
affected as timings for

    `git log --raw --no-abbrev --no-renames`

for navy.git and `linux.git v3.10..v3.11`, just like in previous patch,
stay the same.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 115 ++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 31 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 2ad7788..a5b9ff9 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,8 +6,8 @@
 #include "diffcore.h"
 #include "tree.h"
 
-static void show_entry(struct diff_options *opt, const char *prefix,
-		       struct tree_desc *desc, struct strbuf *base);
+static void show_path(struct strbuf *base, struct diff_options *opt,
+		      struct tree_desc *t1, struct tree_desc *t2);
 
 static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 			      struct strbuf *base, struct diff_options *opt)
@@ -16,7 +16,6 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 	const char *path1, *path2;
 	const unsigned char *sha1, *sha2;
 	int cmp, pathlen1, pathlen2;
-	int old_baselen = base->len;
 
 	sha1 = tree_entry_extract(t1, &path1, &mode1);
 	sha2 = tree_entry_extract(t2, &path2, &mode2);
@@ -30,51 +29,105 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 	 */
 	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
 	if (cmp < 0) {
-		show_entry(opt, "-", t1, base);
+		show_path(base, opt, t1, /*t2=*/NULL);
 		return -1;
 	}
 	if (cmp > 0) {
-		show_entry(opt, "+", t2, base);
+		show_path(base, opt, /*t1=*/NULL, t2);
 		return 1;
 	}
 	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
 		return 0;
 
-	strbuf_add(base, path1, pathlen1);
-	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode1)) {
-		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
-			opt->change(opt, mode1, mode2,
-				    sha1, sha2, 1, 1, base->buf, 0, 0);
-		}
-		strbuf_addch(base, '/');
-		diff_tree_sha1(sha1, sha2, base->buf, opt);
-	} else {
-		opt->change(opt, mode1, mode2, sha1, sha2, 1, 1, base->buf, 0, 0);
-	}
-	strbuf_setlen(base, old_baselen);
+	show_path(base, opt, t1, t2);
 	return 0;
 }
 
-/* An entry went away or appeared */
-static void show_entry(struct diff_options *opt, const char *prefix,
-		       struct tree_desc *desc, struct strbuf *base)
+
+/* convert path, t1/t2 -> opt->diff_*() callbacks */
+static void emit_diff(struct diff_options *opt, struct strbuf *path,
+		      struct tree_desc *t1, struct tree_desc *t2)
+{
+	unsigned int mode1 = t1 ? t1->entry.mode : 0;
+	unsigned int mode2 = t2 ? t2->entry.mode : 0;
+
+	if (mode1 && mode2) {
+		opt->change(opt, mode1, mode2, t1->entry.sha1, t2->entry.sha1,
+			1, 1, path->buf, 0, 0);
+	}
+	else {
+		const unsigned char *sha1;
+		unsigned int mode;
+		int addremove;
+
+		if (mode2) {
+			addremove = '+';
+			sha1 = t2->entry.sha1;
+			mode = mode2;
+		}
+		else {
+			addremove = '-';
+			sha1 = t1->entry.sha1;
+			mode = mode1;
+		}
+
+		opt->add_remove(opt, addremove, mode, sha1, 1, path->buf, 0);
+	}
+}
+
+
+/* new path should be added to diff
+ *
+ * 3 cases on how/when it should be called and behaves:
+ *
+ *	!t1,  t2	-> path added, parent lacks it
+ *	 t1, !t2	-> path removed from parent
+ *	 t1,  t2	-> path modified
+ */
+static void show_path(struct strbuf *base, struct diff_options *opt,
+		      struct tree_desc *t1, struct tree_desc *t2)
 {
 	unsigned mode;
 	const char *path;
-	const unsigned char *sha1 = tree_entry_extract(desc, &path, &mode);
-	int pathlen = tree_entry_len(&desc->entry);
+	int pathlen;
 	int old_baselen = base->len;
+	int isdir, recurse = 0, emitthis = 1;
+
+	/* at least something has to be valid */
+	assert(t1 || t2);
+
+	if (t2) {
+		/* path present in resulting tree */
+		tree_entry_extract(t2, &path, &mode);
+		pathlen = tree_entry_len(&t2->entry);
+		isdir = S_ISDIR(mode);
+	}
+	else {
+		/* a path was removed - take path from parent. Also take
+		 * mode from parent, to decide on recursion.
+		 */
+		tree_entry_extract(t1, &path, &mode);
+		pathlen = tree_entry_len(&t1->entry);
+
+		isdir = S_ISDIR(mode);
+		mode = 0;
+	}
+
+	if (DIFF_OPT_TST(opt, RECURSIVE) && isdir) {
+		recurse = 1;
+		emitthis = DIFF_OPT_TST(opt, TREE_IN_RECURSIVE);
+	}
 
 	strbuf_add(base, path, pathlen);
-	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode)) {
-		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE))
-			opt->add_remove(opt, *prefix, mode, sha1, 1, base->buf, 0);
 
+	if (emitthis)
+		emit_diff(opt, base, t1, t2);
+
+	if (recurse) {
 		strbuf_addch(base, '/');
-		diff_tree_sha1(*prefix == '-' ? sha1 : NULL,
-			       *prefix == '+' ? sha1 : NULL, base->buf, opt);
-	} else
-		opt->add_remove(opt, prefix[0], mode, sha1, 1, base->buf, 0);
+		diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
+			       t2 ? t2->entry.sha1 : NULL, base->buf, opt);
+	}
 
 	strbuf_setlen(base, old_baselen);
 }
@@ -117,12 +170,12 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 		if (!t1->size) {
 			if (!t2->size)
 				break;
-			show_entry(opt, "+", t2, &base);
+			show_path(&base, opt, /*t1=*/NULL, t2);
 			update_tree_entry(t2);
 			continue;
 		}
 		if (!t2->size) {
-			show_entry(opt, "-", t1, &base);
+			show_path(&base, opt, t1, /*t2=*/NULL);
 			update_tree_entry(t1);
 			continue;
 		}
-- 
1.9.rc1.181.g641f458
