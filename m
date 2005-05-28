From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add -B flag to diff-* brothers.
Date: Sat, 28 May 2005 12:33:44 -0700
Message-ID: <7vbr6vrvqf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 21:31:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dc72K-0000VI-P2
	for gcvg-git@gmane.org; Sat, 28 May 2005 21:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVE1TeD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 15:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVE1TeD
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 15:34:03 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54192 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261191AbVE1Tdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 15:33:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528193345.ILTO20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 15:33:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This introduces diffcore-break.c, a new diffcore
transformation.

When the -B flag is given, a patch that represents a complete
rewrite is broken into a deletion followed by a creation.  This
makes it easier to review such a complete rewrite patch.

The -B flag takes the same syntax as the -M and -C flags to
specify the maximum amount of source material the resulting file
can still have to be considered a complete rewrite, and defaults
to 15% if not specified.  For example, this detects the complete
rewrite of ls-tree.c I sent earlier.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Makefile          |    3 -
diff-cache.c      |    7 +++
diff-files.c      |    5 ++
diff-tree.c       |    7 +++
diff.h            |    2 
diffcore-break.c  |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
diffcore-rename.c |    4 -
diffcore.h        |    3 -
8 files changed, 137 insertions(+), 4 deletions(-)
new file (100644): diffcore-break.c

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -48,7 +48,7 @@ LIB_OBJS += strbuf.o
 
 LIB_H += diff.h count-delta.h
 LIB_OBJS += diff.o diffcore-rename.o diffcore-pickaxe.o diffcore-pathspec.o \
-	count-delta.o diffcore-order.o
+	count-delta.o diffcore-order.o diffcore-break.o
 
 LIB_OBJS += gitenv.o
 
@@ -131,6 +131,7 @@ diffcore-rename.o : $(LIB_H) diffcore.h
 diffcore-pathspec.o : $(LIB_H) diffcore.h
 diffcore-pickaxe.o : $(LIB_H) diffcore.h
 diffcore-order.o : $(LIB_H) diffcore.h
+diffcore-break.o : $(LIB_H) diffcore.h
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -9,6 +9,7 @@ static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static int diff_break_opt = -1;
 static const char *orderfile = NULL;
 
 /* A file entry went away or appeared */
@@ -189,6 +190,10 @@ int main(int argc, const char **argv)
 			diff_output_format = DIFF_FORMAT_PATCH;
 			continue;
 		}
+		if (!strncmp(arg, "-B", 2)) {
+			diff_break_opt = diff_scoreopt_parse(arg);
+			continue;
+		}
 		if (!strncmp(arg, "-M", 2)) {
 			detect_rename = DIFF_DETECT_RENAME;
 			diff_score_opt = diff_scoreopt_parse(arg);
@@ -251,6 +256,8 @@ int main(int argc, const char **argv)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	if (0 <= diff_break_opt)
+		diffcore_break(diff_break_opt);
 	if (orderfile)
 		diffcore_order(orderfile);
 	diff_flush(diff_output_format, 1);
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -15,6 +15,7 @@ static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static int diff_break_opt = -1;
 static const char *orderfile = NULL;
 static int silent = 0;
 
@@ -60,6 +61,8 @@ int main(int argc, const char **argv)
 			orderfile = argv[1] + 2;
 		else if (!strcmp(argv[1], "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
+		else if (!strncmp(argv[1], "-B", 2))
+			diff_break_opt = diff_scoreopt_parse(argv[1]);
 		else if (!strncmp(argv[1], "-M", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
 			detect_rename = DIFF_DETECT_RENAME;
@@ -125,6 +128,8 @@ int main(int argc, const char **argv)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	if (0 <= diff_break_opt)
+		diffcore_break(diff_break_opt);
 	if (orderfile)
 		diffcore_order(orderfile);
 	diff_flush(diff_output_format, 1);
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -14,6 +14,7 @@ static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static int diff_break_opt = -1;
 static const char *orderfile = NULL;
 static const char *header = NULL;
 static const char *header_prefix = "";
@@ -266,6 +267,8 @@ static int call_diff_flush(void)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	if (0 <= diff_break_opt)
+		diffcore_break(diff_break_opt);
 	if (diff_queue_is_empty()) {
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
@@ -531,6 +534,10 @@ int main(int argc, const char **argv)
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
+		if (!strncmp(arg, "-B", 2)) {
+			diff_break_opt = diff_scoreopt_parse(arg);
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			diff_output_format = DIFF_FORMAT_MACHINE;
 			continue;
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -45,6 +45,8 @@ extern void diffcore_pathspec(const char
 
 extern void diffcore_order(const char *orderfile);
 
+extern void diffcore_break(int max_score);
+
 extern int diff_queue_is_empty(void);
 
 #define DIFF_FORMAT_HUMAN	0
diff --git a/diffcore-break.c b/diffcore-break.c
new file mode 100644
--- /dev/null
+++ b/diffcore-break.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "delta.h"
+#include "count-delta.h"
+
+static int very_different(struct diff_filespec *src,
+			  struct diff_filespec *dst,
+			  int max_score)
+{
+	/* dst is recorded as a modification of src.  Are they so
+	 * different that we are better off recording this as a pair
+	 * of delete and create?  max_score is maximum size that is
+	 * common between src and dst for the pair to be still considered
+	 * a change (not delete and create), and typically set to 5-10%.
+	 */
+	void *delta;
+	unsigned long delta_size, base_size;
+
+	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
+		return 0; /* leave symlink rename alone */
+
+	if (diff_populate_filespec(src, 1) || diff_populate_filespec(dst, 1))
+		return 0; /* error but caught downstream */
+
+	delta_size = ((src->size < dst->size) ?
+		      (dst->size - src->size) : (src->size - dst->size));
+	base_size = ((src->size < dst->size) ? src->size : dst->size);
+
+	/*
+	 * If delta size is larger than
+	 * (MAX_SCORE-max_score)/MAX_SCORE * min(src->size, dst->size)
+	 * then we declare this is too big a change to be a patch.
+	 */
+	if (base_size * (MAX_SCORE-max_score) < delta_size * MAX_SCORE)
+		return 1;
+
+	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
+		return 0; /* error but caught downstream */
+
+	delta = diff_delta(src->data, src->size,
+			   dst->data, dst->size,
+			   &delta_size);
+
+	/* A delta that has a lot of literal additions would have
+	 * big delta_size no matter what else it does.
+	 */
+	if (base_size * (MAX_SCORE-max_score) < delta_size * MAX_SCORE)
+		return 1;
+
+	/* Estimate the edit size by interpreting delta. */
+	delta_size = count_delta(delta, delta_size);
+	free(delta);
+	if (delta_size == UINT_MAX)
+		return 0; /* error in delta computation */
+	/*
+	 * So how big is the edit?
+	 */
+	if (base_size * (MAX_SCORE-max_score) < delta_size * MAX_SCORE)
+		return 1;
+	return 0;
+}
+
+void diffcore_break(int max_score)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	int i;
+
+	if (!max_score)
+		max_score = DEFAULT_MAXIMUM_SCORE;
+
+	outq.nr = outq.alloc = 0;
+	outq.queue = NULL;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		/* We deal only with in-place edit of non directory */
+		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two) &&
+		    !S_ISDIR(p->one->mode) && !S_ISDIR(p->two->mode) &&
+		    !strcmp(p->one->path, p->two->path) &&
+		    very_different(p->one, p->two, max_score)) {
+			/* Split this into delete and create */
+			struct diff_filespec *one_pre, *one_post,
+				*two_pre, *two_post;
+
+			/* deletion of one */
+			one_pre = alloc_filespec(p->one->path);
+			fill_filespec(one_pre, p->one->sha1, p->one->mode);
+			one_post = alloc_filespec(p->one->path);
+			diff_queue(&outq, one_pre, one_post);
+
+			/* creation of two */
+			two_pre = alloc_filespec(p->two->path);
+			two_post = alloc_filespec(p->two->path);
+			fill_filespec(two_post, p->two->sha1, p->two->mode);
+			diff_queue(&outq, two_pre, two_post);
+			diff_free_filepair(p);
+		}
+		else
+			diff_q(&outq, p);
+	}
+	free(q->queue);
+	*q = outq;
+
+	return;
+}
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -208,8 +208,8 @@ static int score_compare(const void *a_,
 int diff_scoreopt_parse(const char *opt)
 {
 	int diglen, num, scale, i;
-	if (opt[0] != '-' || (opt[1] != 'M' && opt[1] != 'C'))
-		return -1; /* that is not a -M nor -C option */
+	if (opt[0] != '-' || (opt[1] != 'M' && opt[1] != 'C' && opt[1] != 'B'))
+		return -1; /* that is not a -M, -C nor -B option */
 	diglen = strspn(opt+2, "0123456789");
 	if (diglen == 0 || strlen(opt+2) != diglen)
 		return 0; /* use default */
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -9,7 +9,8 @@
  * in anything else.
  */
 #define MAX_SCORE 10000
-#define DEFAULT_MINIMUM_SCORE 5000
+#define DEFAULT_MINIMUM_SCORE 5000 /* rename/copy similarity minimum */
+#define DEFAULT_MAXIMUM_SCORE 1500 /* similarity maximum for break to happen */
 
 #define RENAME_DST_MATCHED 01
 
------------------------------------------------

