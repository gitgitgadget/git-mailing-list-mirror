From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 11/11] tree-diff: reuse base str(buf) memory on sub-tree recursion
Date: Fri,  7 Feb 2014 21:48:52 +0400
Message-ID: <645beb40c13912e87f6fe67d46af2b5e81dcaaca.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 18:47:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpWt-0000ne-KB
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 18:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbaBGRrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 12:47:43 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33806 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbaBGRrf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 12:47:35 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBpWX-0002Lr-QM; Fri, 07 Feb 2014 21:47:33 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBpYJ-0004AW-Jq; Fri, 07 Feb 2014 21:49:23 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241786>

instead of allocating it all the time for every subtree in
__diff_tree_sha1, let's allocate it once in diff_tree_sha1, and then all
callee just use it in stacking style, without memory allocations.

This should be faster, and for me this change gives the following
slight speedups for `git log --raw --no-abbrev --no-renames`

                navy.git    linux.git v3.10..v3.11

    before      0.547s      1.791s
    after       0.541s      1.777s
    speedup     1.1%        0.8%

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 diff.h      |  2 +-
 tree-diff.c | 36 ++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/diff.h b/diff.h
index 4994d15..14016ce 100644
--- a/diff.h
+++ b/diff.h
@@ -190,7 +190,7 @@ const char *diff_line_prefix(struct diff_options *);
 extern const char mime_boundary_leader[];
 
 extern int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
-			    const char *base, struct diff_options *opt);
+			    struct strbuf *base, struct diff_options *opt);
 extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			  const char *base, struct diff_options *opt);
 extern int diff_root_tree_sha1(const unsigned char *new, const char *base,
diff --git a/tree-diff.c b/tree-diff.c
index e385ed4..2adda04 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -117,7 +117,7 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
 	if (recurse) {
 		strbuf_addch(base, '/');
 		__diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
-				 t2 ? t2->entry.sha1 : NULL, base->buf, opt);
+				 t2 ? t2->entry.sha1 : NULL, base, opt);
 	}
 
 	strbuf_setlen(base, old_baselen);
@@ -140,12 +140,10 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 }
 
 int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
-		     const char *base_str, struct diff_options *opt)
+		     struct strbuf *base, struct diff_options *opt)
 {
 	struct tree_desc t1, t2;
 	void *t1tree, *t2tree;
-	struct strbuf base;
-	int baselen = strlen(base_str);
 
 	t1tree = fill_tree_descriptor(&t1, old);
 	t2tree = fill_tree_descriptor(&t2, new);
@@ -153,17 +151,14 @@ int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
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
@@ -175,7 +170,7 @@ int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
 			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
 			    (t1.entry.mode != t2.entry.mode))
-				show_path(&base, opt, &t1, &t2);
+				show_path(base, opt, &t1, &t2);
 
 			update_tree_entry(&t1);
 			update_tree_entry(&t2);
@@ -183,18 +178,17 @@ int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 
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
@@ -211,7 +205,7 @@ static inline int diff_might_be_rename(void)
 		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
 }
 
-static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
+static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, struct strbuf *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -308,13 +302,19 @@ static void try_to_follow_renames(const unsigned char *old, const unsigned char
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
