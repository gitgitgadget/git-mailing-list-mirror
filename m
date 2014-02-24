From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH v2 16/19] tree-diff: reuse base str(buf) memory on sub-tree recursion
Date: Mon, 24 Feb 2014 20:21:48 +0400
Message-ID: <301eb2377e0c5f670ffc26bda085d14dbee4f431.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:22:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyI7-00048s-9i
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbaBXQVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:21:55 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34260 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbaBXQVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:53 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyHv-000410-TU; Mon, 24 Feb 2014 20:21:52 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyJb-0007AD-2o; Mon, 24 Feb 2014 20:23:35 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242604>

instead of allocating it all the time for every subtree in
__diff_tree_sha1, let's allocate it once in diff_tree_sha1, and then all
callee just use it in stacking style, without memory allocations.

This should be faster, and for me this change gives the following
slight speedups for

    git log --raw --no-abbrev --no-renames --format='%H'

                navy.git    linux.git v3.10..v3.11

    before      0.618s      1.903s
    after       0.611s      1.889s
    speedup     1.1%        0.7%

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

Changes since v1:

 - don't need to touch diff.h, as the function we are changing became static.

 tree-diff.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index aea0297..c76821d 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -115,7 +115,7 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
 	if (recurse) {
 		strbuf_addch(base, '/');
 		__diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
-				 t2 ? t2->entry.sha1 : NULL, base->buf, opt);
+				 t2 ? t2->entry.sha1 : NULL, base, opt);
 	}
 
 	strbuf_setlen(base, old_baselen);
@@ -138,12 +138,10 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 }
 
 static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
-			    const char *base_str, struct diff_options *opt)
+			    struct strbuf *base, struct diff_options *opt)
 {
 	struct tree_desc t1, t2;
 	void *t1tree, *t2tree;
-	struct strbuf base;
-	int baselen = strlen(base_str);
 
 	t1tree = fill_tree_descriptor(&t1, old);
 	t2tree = fill_tree_descriptor(&t2, new);
@@ -151,17 +149,14 @@ static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
 
-	strbuf_init(&base, PATH_MAX);
-	strbuf_add(&base, base_str, baselen);
-
 	for (;;) {
 		int cmp;
 
 		if (diff_can_quit_early(opt))
 			break;
 		if (opt->pathspec.nr) {
-			skip_uninteresting(&t1, &base, opt);
-			skip_uninteresting(&t2, &base, opt);
+			skip_uninteresting(&t1, base, opt);
+			skip_uninteresting(&t2, base, opt);
 		}
 		if (!t1.size && !t2.size)
 			break;
@@ -173,7 +168,7 @@ static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
 			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
 			    (t1.entry.mode != t2.entry.mode))
-				show_path(&base, opt, &t1, &t2);
+				show_path(base, opt, &t1, &t2);
 
 			update_tree_entry(&t1);
 			update_tree_entry(&t2);
@@ -181,18 +176,17 @@ static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 
 		/* t1 < t2 */
 		else if (cmp < 0) {
-			show_path(&base, opt, &t1, /*t2=*/NULL);
+			show_path(base, opt, &t1, /*t2=*/NULL);
 			update_tree_entry(&t1);
 		}
 
 		/* t1 > t2 */
 		else {
-			show_path(&base, opt, /*t1=*/NULL, &t2);
+			show_path(base, opt, /*t1=*/NULL, &t2);
 			update_tree_entry(&t2);
 		}
 	}
 
-	strbuf_release(&base);
 	free(t2tree);
 	free(t1tree);
 	return 0;
@@ -209,7 +203,7 @@ static inline int diff_might_be_rename(void)
 		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
 }
 
-static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
+static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, struct strbuf *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -306,13 +300,19 @@ static void try_to_follow_renames(const unsigned char *old, const unsigned char
 	q->nr = 1;
 }
 
-int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
+int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base_str, struct diff_options *opt)
 {
+	struct strbuf base;
 	int retval;
 
-	retval = __diff_tree_sha1(old, new, base, opt);
-	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
-		try_to_follow_renames(old, new, base, opt);
+	strbuf_init(&base, PATH_MAX);
+	strbuf_addstr(&base, base_str);
+
+	retval = __diff_tree_sha1(old, new, &base, opt);
+	if (!*base_str && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
+		try_to_follow_renames(old, new, &base, opt);
+
+	strbuf_release(&base);
 
 	return retval;
 }
-- 
1.9.rc1.181.g641f458
