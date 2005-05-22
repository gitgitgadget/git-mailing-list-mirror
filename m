From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Prepare diffcore interface for diff-tree header supression.
Date: Sat, 21 May 2005 19:40:36 -0700
Message-ID: <7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 04:40:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZgNv-0001NK-QH
	for gcvg-git@gmane.org; Sun, 22 May 2005 04:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVEVClR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 22:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEVClR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 22:41:17 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43945 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261711AbVEVCki (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 22:40:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522024036.MGJW550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 22:40:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 16:12:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This does not actually supress the extra headers when pickaxe is
used, but prepares enough support for diff-tree to implement it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c       |   10 ++++++----
diff-files.c       |   10 ++++++----
diff-helper.c      |   13 +++++++------
diff-tree.c        |   26 ++++++++++++++++++--------
diff.c             |   43 ++++++++++++++++++++++---------------------
diff.h             |   12 +++++++-----
diffcore-pickaxe.c |    3 ++-
diffcore-rename.c  |    4 ++--
diffcore.h         |    3 +--
9 files changed, 71 insertions(+), 53 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -214,9 +214,7 @@ int main(int argc, char **argv)
 	if (argc != 2 || get_sha1(argv[1], tree_sha1))
 		usage(diff_cache_usage);
 
-	diff_setup(detect_rename, diff_score_opt, pickaxe,
-		   reverse_diff, (generate_patch ? -1 : line_termination),
-		   NULL, 0);
+	diff_setup(reverse_diff, (generate_patch ? -1 : line_termination));
 
 	mark_merge_entries();
 
@@ -227,6 +225,10 @@ int main(int argc, char **argv)
 		die("unable to read tree object %s", argv[1]);
 
 	ret = diff_cache(active_cache, active_nr);
-	diff_flush();
+	if (detect_rename)
+		diff_detect_rename(detect_rename, diff_score_opt);
+	if (pickaxe)
+		diff_pickaxe(pickaxe);
+	diff_flush(NULL, 0);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -92,9 +92,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	diff_setup(detect_rename, diff_score_opt, pickaxe,
-		   reverse_diff, (generate_patch ? -1 : line_termination),
-		   NULL, 0);
+	diff_setup(reverse_diff, (generate_patch ? -1 : line_termination));
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
@@ -136,6 +134,10 @@ int main(int argc, char **argv)
 		show_modified(oldmode, mode, ce->sha1, null_sha1,
 			      ce->name);
 	}
-	diff_flush();
+	if (detect_rename)
+		diff_detect_rename(detect_rename, diff_score_opt);
+	if (pickaxe)
+		diff_pickaxe(pickaxe);
+	diff_flush(NULL, 0);
 	return 0;
 }
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -127,10 +127,7 @@ int main(int ac, const char **av) {
 	}
 	/* the remaining parameters are paths patterns */
 
-	diff_setup(detect_rename, diff_score_opt, pickaxe,
-		   reverse, (generate_patch ? -1 : line_termination),
-		   av+1, ac-1);
-
+	diff_setup(reverse, (generate_patch ? -1 : line_termination));
 	while (1) {
 		int status;
 		read_line(&sb, stdin, line_termination);
@@ -138,11 +135,15 @@ int main(int ac, const char **av) {
 			break;
 		status = parse_diff_raw_output(sb.buf);
 		if (status) {
-			diff_flush();
+			diff_flush(av+1, ac-1);
 			printf("%s%c", sb.buf, line_termination);
 		}
 	}
 
-	diff_flush();
+	if (detect_rename)
+		diff_detect_rename(detect_rename, diff_score_opt);
+	if (pickaxe)
+		diff_pickaxe(pickaxe);
+	diff_flush(av+1, ac-1);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -267,16 +267,28 @@ static int diff_tree_sha1(const unsigned
 	return retval;
 }
 
+static void call_diff_setup(void)
+{
+	diff_setup(reverse_diff, (generate_patch ? -1 : line_termination));
+}
+
+static void call_diff_flush(void)
+{
+	if (detect_rename)
+		diff_detect_rename(detect_rename, diff_score_opt);
+	if (pickaxe)
+		diff_pickaxe(pickaxe);
+	diff_flush(NULL, 0);
+}
+
 static int diff_tree_sha1_top(const unsigned char *old,
 			      const unsigned char *new, const char *base)
 {
 	int ret;
 
-	diff_setup(detect_rename, diff_score_opt, pickaxe,
-		   reverse_diff, (generate_patch ? -1 : line_termination),
-		   NULL, 0);
+	call_diff_setup();
 	ret = diff_tree_sha1(old, new, base);
-	diff_flush();
+	call_diff_flush();
 	return ret;
 }
 
@@ -286,15 +298,13 @@ static int diff_root_tree(const unsigned
 	void *tree;
 	unsigned long size;
 
-	diff_setup(detect_rename, diff_score_opt, pickaxe,
-		   reverse_diff, (generate_patch ? -1 : line_termination),
-		   NULL, 0);
+	call_diff_setup();
 	tree = read_object_with_reference(new, "tree", &size, NULL);
 	if (!tree)
 		die("unable to read root tree (%s)", sha1_to_hex(new));
 	retval = diff_tree("", 0, tree, size, base);
 	free(tree);
-	diff_flush();
+	call_diff_flush();
 	return retval;
 }
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -12,13 +12,10 @@
 static const char *diff_opts = "-pu";
 static unsigned char null_sha1[20] = { 0, };
 
-static int detect_rename;
 static int reverse_diff;
 static int diff_raw_output = -1;
 static const char **pathspec;
 static int speccnt;
-static const char *pickaxe;
-static int minimum_score;
 
 static const char *external_diff(void)
 {
@@ -512,21 +509,13 @@ int diff_scoreopt_parse(const char *opt)
 	return MAX_SCORE * num / scale;
 }
 
-void diff_setup(int detect_rename_, int minimum_score_,
-		const char *pickaxe_,
-		int reverse_diff_, int diff_raw_output_,
-		const char **pathspec_, int speccnt_)
+void diff_setup(int reverse_diff_, int diff_raw_output_)
 {
-	detect_rename = detect_rename_;
 	reverse_diff = reverse_diff_;
-	pathspec = pathspec_;
 	diff_raw_output = diff_raw_output_;
-	speccnt = speccnt_;
-	minimum_score = minimum_score_ ? : DEFAULT_MINIMUM_SCORE;
-	pickaxe = pickaxe_;
 }
 
-static struct diff_queue_struct queued_diff;
+struct diff_queue_struct diff_queued_diff;
 
 struct diff_filepair *diff_queue(struct diff_queue_struct *queue,
 				  struct diff_filespec *one,
@@ -636,15 +625,27 @@ static void diff_flush_one(struct diff_f
 		diff_flush_patch(p);
 }
 
-void diff_flush(void)
+int diff_queue_is_empty(void)
 {
-	struct diff_queue_struct *q = &queued_diff;
+	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
 
-	if (detect_rename)
-		diff_detect_rename(q, detect_rename, minimum_score);
-	if (pickaxe)
-		diff_pickaxe(q, pickaxe);
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (!identical(p->one, p->two))
+			return 0;
+	}
+	return 1;
+}
+
+void diff_flush(const char **pathspec_, int speccnt_)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	int i;
+
+	pathspec = pathspec_;
+	speccnt = speccnt_;
+
 	for (i = 0; i < q->nr; i++)
 		diff_flush_one(q->queue[i]);
 
@@ -693,7 +694,7 @@ void diff_addremove(int addremove, unsig
 	if (addremove != '-')
 		fill_filespec(two, sha1, mode);
 
-	diff_queue(&queued_diff, one, two);
+	diff_queue(&diff_queued_diff, one, two);
 }
 
 void diff_change(unsigned old_mode, unsigned new_mode,
@@ -716,7 +717,7 @@ void diff_change(unsigned old_mode, unsi
 	fill_filespec(one, old_sha1, old_mode);
 	fill_filespec(two, new_sha1, new_mode);
 
-	diff_queue(&queued_diff, one, two);
+	diff_queue(&diff_queued_diff, one, two);
 }
 
 void diff_unmerge(const char *path)
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -19,11 +19,13 @@ extern void diff_unmerge(const char *pat
 
 extern int diff_scoreopt_parse(const char *opt);
 
-extern void diff_setup(int detect_rename, int minimum_score,
-		       const char *pickaxe,
-		       int reverse, int raw_output,
-		       const char **spec, int cnt);
+extern void diff_setup(int reverse, int diff_raw_output);
 
-extern void diff_flush(void);
+extern void diff_detect_rename(int, int);
+extern void diff_pickaxe(const char *);
+
+extern int diff_queue_is_empty(void);
+
+extern void diff_flush(const char **, int);
 
 #endif /* DIFF_H */
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -21,8 +21,9 @@ static int contains(struct diff_filespec
 	return 0;
 }
 
-void diff_pickaxe(struct diff_queue_struct *q, const char *needle)
+void diff_pickaxe(const char *needle)
 {
+	struct diff_queue_struct *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
 	int i;
 	struct diff_queue_struct outq;
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -224,10 +224,10 @@ static int needs_to_stay(struct diff_que
 	return 0;
 }
 
-void diff_detect_rename(struct diff_queue_struct *q,
-			int detect_rename,
+void diff_detect_rename(int detect_rename,
 			int minimum_score)
 {
+	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
 	struct diff_rename_pool created, deleted, stay;
 	struct diff_rename_pool *(srcs[2]);
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -52,10 +52,9 @@ struct diff_queue_struct {
 	int nr;
 };
 
+extern struct diff_queue_struct diff_queued_diff;
 extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *,
 					struct diff_filespec *);
-extern void diff_detect_rename(struct diff_queue_struct *, int, int);
-extern void diff_pickaxe(struct diff_queue_struct *, const char *);
 
 #endif
------------------------------------------------

