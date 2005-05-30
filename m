From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] Add -B flag to diff-* brothers.
Date: Mon, 30 May 2005 00:08:37 -0700
Message-ID: <7vy89x6vii.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
	<7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net>
	<7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 09:07:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DceMq-0000wL-OF
	for gcvg-git@gmane.org; Mon, 30 May 2005 09:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVE3HJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 03:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVE3HJs
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 03:09:48 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52925 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261535AbVE3HIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 03:08:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530070837.DRQW12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 03:08:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 23:58:37 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A new diffcore transformation, diffcore-break.c, is introduced.

When the -B flag is given, a patch that represents a complete
rewrite is broken into a deletion followed by a creation.  This
makes it easier to review such a complete rewrite patch.

The -B flag takes the same syntax as the -M and -C flags to
specify the minimum amount of non-source material the resulting
file needs to have to be considered a complete rewrite, and
defaults to 99% if not specified.

As the new test t4008-diff-break-rewrite.sh demonstrates, if a
file is a complete rewrite, it is broken into a delete/create
pair, which can further be subjected to the usual rename
detection if -M or -C is used.  For example, if file0 gets
completely rewritten to make it as if it were rather based on
file1 which itself disappeared, the following happens:

    The original change looks like this:

	file0     --> file0' (quite different from file0)
	file1     --> /dev/null

    After diffcore-break runs, it would become this:

	file0     --> /dev/null
	/dev/null --> file0'
	file1     --> /dev/null

    Then diffcore-rename matches them up:

	file1     --> file0'

The internal score values are finer grained now.  Earlier
maximum of 10000 has been raised to 60000; there is no user
visible changes but there is no reason to waste available bits.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-diff-cache.txt |    5 
 Documentation/git-diff-files.txt |    5 
 Documentation/git-diff-tree.txt  |    5 
 Makefile                         |    3 
 diff-cache.c                     |   11 +-
 diff-files.c                     |    8 +
 diff-tree.c                      |    8 +
 diff.c                           |   21 +++
 diff.h                           |    5 
 diffcore-break.c                 |  127 +++++++++++++++++++++++
 diffcore-rename.c                |   45 ++++++--
 diffcore.h                       |   12 +-
 t/t4008-diff-break-rewrite.sh    |  207 +++++++++++++++++++++++++++++++++++++++
 13 files changed, 433 insertions(+), 29 deletions(-)

96c0ba825059e65743bfce718e54413c4583ff35 (from 3fde726e95a828e680c95297f185d6d25fcf853a)
diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
+'git-diff-cache' [-p] [-r] [-z] [-m] [-B] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,9 @@ OPTIONS
 -z::
 	\0 line termination on output
 
+-B::
+	Break complete rewrite changes into pairs of delete and create.
+
 -M::
 	Detect renames.
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the w
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [--pickaxe-all] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-B] [-M] [-C] [-R] [-S<string>] [--pickaxe-all] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,9 @@ OPTIONS
 -R::
 	Output diff in reverse.
 
+-B::
+	Break complete rewrite changes into pairs of delete and create.
+
 -M::
 	Detect renames.
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-B] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -33,6 +33,9 @@ OPTIONS
 	generate patch (see section on generating patches).  For
 	git-diff-tree, this flag implies '-r' as well.
 
+-B::
+	Break complete rewrite changes into pairs of delete and create.
+
 -M::
 	Detect renames.
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -48,7 +48,7 @@ LIB_OBJS += strbuf.o
 
 LIB_H += diff.h count-delta.h
 LIB_OBJS += diff.o diffcore-rename.o diffcore-pickaxe.o diffcore-pathspec.o \
-	count-delta.o
+	count-delta.o diffcore-break.o
 
 LIB_OBJS += gitenv.o
 
@@ -130,6 +130,7 @@ diff.o: $(LIB_H) diffcore.h
 diffcore-rename.o : $(LIB_H) diffcore.h
 diffcore-pathspec.o : $(LIB_H) diffcore.h
 diffcore-pickaxe.o : $(LIB_H) diffcore.h
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
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
@@ -188,6 +189,10 @@ int main(int argc, const char **argv)
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
@@ -240,9 +245,11 @@ int main(int argc, const char **argv)
 		die("unable to read tree object %s", tree_name);
 
 	ret = diff_cache(active_cache, active_nr);
-	diffcore_std(pathspec,
+
+	diffcore_std(pathspec ? : NULL,
 		     detect_rename, diff_score_opt,
-		     pickaxe, pickaxe_opts);
+		     pickaxe, pickaxe_opts,
+		     diff_break_opt);
 	diff_flush(diff_output_format, 1);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -15,6 +15,7 @@ static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static int diff_break_opt = -1;
 static int silent = 0;
 
 static void show_unmerge(const char *path)
@@ -57,6 +58,8 @@ int main(int argc, const char **argv)
 			pickaxe = argv[1] + 2;
 		else if (!strcmp(argv[1], "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
+		else if (!strncmp(argv[1], "-B", 2))
+			diff_break_opt = diff_scoreopt_parse(argv[1]);
 		else if (!strncmp(argv[1], "-M", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
 			detect_rename = DIFF_DETECT_RENAME;
@@ -116,9 +119,10 @@ int main(int argc, const char **argv)
 		show_modified(oldmode, mode, ce->sha1, null_sha1,
 			      ce->name);
 	}
-	diffcore_std(argv + 1,
+	diffcore_std((1 < argc) ? argv + 1 : NULL,
 		     detect_rename, diff_score_opt,
-		     pickaxe, pickaxe_opts);
+		     pickaxe, pickaxe_opts,
+		     diff_break_opt);
 	diff_flush(diff_output_format, 1);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -14,6 +14,7 @@ static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static int diff_break_opt = -1;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
@@ -263,7 +264,8 @@ static int call_diff_flush(void)
 {
 	diffcore_std(0,
 		     detect_rename, diff_score_opt,
-		     pickaxe, pickaxe_opts);
+		     pickaxe, pickaxe_opts,
+		     diff_break_opt);
 	if (diff_queue_is_empty()) {
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
@@ -523,6 +525,10 @@ int main(int argc, const char **argv)
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
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -603,6 +603,7 @@ struct diff_filepair *diff_queue(struct 
 	dp->two = two;
 	dp->score = 0;
 	dp->source_stays = 0;
+	dp->broken_pair = 0;
 	diff_q(queue, dp);
 	return dp;
 }
@@ -637,6 +638,16 @@ static void diff_flush_raw(struct diff_f
 		sprintf(status, "%c%03d", p->status,
 			(int)(0.5 + p->score * 100.0/MAX_SCORE));
 		break;
+	case 'N': case 'D':
+		two_paths = 0;
+		if (p->score)
+			sprintf(status, "%c%03d", p->status,
+				(int)(0.5 + p->score * 100.0/MAX_SCORE));
+		else {
+			status[0] = p->status;
+			status[1] = 0;
+		}
+		break;
 	default:
 		two_paths = 0;
 		status[0] = p->status;
@@ -760,8 +771,9 @@ void diff_debug_filepair(const struct di
 {
 	diff_debug_filespec(p->one, i, "one");
 	diff_debug_filespec(p->two, i, "two");
-	fprintf(stderr, "score %d, status %c source_stays %d\n",
-		p->score, p->status ? : '?', p->source_stays);
+	fprintf(stderr, "score %d, status %c stays %d broken %d\n",
+		p->score, p->status ? : '?',
+		p->source_stays, p->broken_pair);
 }
 
 void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
@@ -875,10 +887,13 @@ void diff_flush(int diff_output_style, i
 
 void diffcore_std(const char **paths,
 		  int detect_rename, int rename_score,
-		  const char *pickaxe, int pickaxe_opts)
+		  const char *pickaxe, int pickaxe_opts,
+		  int break_opt)
 {
 	if (paths && paths[0])
 		diffcore_pathspec(paths);
+	if (0 <= break_opt)
+		diffcore_break(break_opt);
 	if (detect_rename)
 		diffcore_rename(detect_rename, rename_score);
 	if (pickaxe)
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -43,9 +43,12 @@ extern void diffcore_pickaxe(const char 
 
 extern void diffcore_pathspec(const char **pathspec);
 
+extern void diffcore_break(int);
+
 extern void diffcore_std(const char **paths,
 			 int detect_rename, int rename_score,
-			 const char *pickaxe, int pickaxe_opts);
+			 const char *pickaxe, int pickaxe_opts,
+			 int break_opt);
 
 extern int diff_queue_is_empty(void);
 
diff --git a/diffcore-break.c b/diffcore-break.c
new file mode 100644
--- /dev/null
+++ b/diffcore-break.c
@@ -0,0 +1,127 @@
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
+			  int min_score)
+{
+	/* dst is recorded as a modification of src.  Are they so
+	 * different that we are better off recording this as a pair
+	 * of delete and create?  min_score is the minimum amount of
+	 * new material that must exist in the dst and not in src for
+	 * the pair to be considered a complete rewrite, and recommended
+	 * to be set to a very high value, 99% or so.
+	 *
+	 * The value we return represents the amount of new material
+	 * that is in dst and not in src.  We return 0 when we do not
+	 * want to get the filepair broken.
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
+
+	/* Notice that we use max of src and dst as the base size,
+	 * unlike rename similarity detection.  This is so that we do
+	 * not mistake a large addition as a complete rewrite.
+	 */
+	base_size = ((src->size < dst->size) ? dst->size : src->size);
+
+	/*
+	 * If file size difference is too big compared to the
+	 * base_size, we declare this a complete rewrite.
+	 */
+	if (base_size * min_score < delta_size * MAX_SCORE)
+		return MAX_SCORE;
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
+	if (base_size * min_score < delta_size * MAX_SCORE)
+		return MAX_SCORE;
+
+	/* Estimate the edit size by interpreting delta. */
+	delta_size = count_delta(delta, delta_size);
+	free(delta);
+	if (delta_size == UINT_MAX)
+		return 0; /* error in delta computation */
+
+	if (base_size < delta_size)
+		return MAX_SCORE;
+
+	return delta_size * MAX_SCORE / base_size; 
+}
+
+void diffcore_break(int min_score)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	int i;
+
+	if (!min_score)
+		min_score = DEFAULT_BREAK_SCORE;
+
+	outq.nr = outq.alloc = 0;
+	outq.queue = NULL;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		int score;
+
+		/* We deal only with in-place edit of non directory.
+		 * We do not break anything else.
+		 */
+		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two) &&
+		    !S_ISDIR(p->one->mode) && !S_ISDIR(p->two->mode) &&
+		    !strcmp(p->one->path, p->two->path)) {
+			score = very_different(p->one, p->two, min_score);
+			if (min_score <= score) {
+				/* Split this into delete and create */
+				struct diff_filespec *null_one, *null_two;
+				struct diff_filepair *dp;
+
+				/* deletion of one */
+				null_one = alloc_filespec(p->one->path);
+				dp = diff_queue(&outq, p->one, null_one);
+				dp->score = score;
+				dp->broken_pair = 1;
+
+				/* creation of two */
+				null_two = alloc_filespec(p->two->path);
+				dp = diff_queue(&outq, null_two, p->two);
+				dp->score = score;
+				dp->broken_pair = 1;
+
+				free(p); /* not diff_free_filepair(), we are
+					  * reusing one and two here.
+					  */
+				continue;
+			}
+		}
+		diff_q(&outq, p);
+	}
+	free(q->queue);
+	*q = outq;
+
+	return;
+}
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -225,8 +225,8 @@ static int score_compare(const void *a_,
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
@@ -249,7 +249,7 @@ void diffcore_rename(int detect_rename, 
 	int num_create, num_src, dst_cnt;
 
 	if (!minimum_score)
-		minimum_score = DEFAULT_MINIMUM_SCORE;
+		minimum_score = DEFAULT_RENAME_SCORE;
 	renq.queue = NULL;
 	renq.nr = renq.alloc = 0;
 
@@ -353,17 +353,36 @@ void diffcore_rename(int detect_rename, 
 			/*
 			 * Deletion
 			 *
-			 * We would output this delete record if renq
-			 * does not have a rename/copy to move
-			 * p->one->path out.
+			 * We would output this delete record if:
+			 *
+			 * (1) this is a broken delete and the counterpart
+			 *     broken create remains in the output; or
+			 * (2) this is not a broken delete, and renq does
+			 *     not have a rename/copy to move p->one->path
+			 *     out.
+			 *
+			 * Otherwise, the counterpart broken create
+			 * has been turned into a rename-edit; or
+			 * delete did not have a matching create to
+			 * begin with.
 			 */
-			for (j = 0; j < renq.nr; j++)
-				if (!strcmp(renq.queue[j]->one->path,
-					    p->one->path))
-					break;
-			if (j < renq.nr)
-				/* this path remains */
-				pair_to_free = p;
+			if (DIFF_PAIR_BROKEN(p)) {
+				/* broken delete */
+				struct diff_rename_dst *dst =
+					locate_rename_dst(p->one, 0);
+				if (dst && dst->pair)
+					/* counterpart is now rename/copy */
+					pair_to_free = p;
+			}
+			else {
+				for (j = 0; j < renq.nr; j++)
+					if (!strcmp(renq.queue[j]->one->path,
+						    p->one->path))
+						break;
+				if (j < renq.nr)
+					/* this path remains */
+					pair_to_free = p;
+			}
 
 			if (pair_to_free)
 				;
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -8,8 +8,9 @@
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
  */
-#define MAX_SCORE 10000
-#define DEFAULT_MINIMUM_SCORE 5000
+#define MAX_SCORE 60000
+#define DEFAULT_RENAME_SCORE 30000 /* rename/copy similarity minimum (50%) */
+#define DEFAULT_BREAK_SCORE  59400 /* minimum for break to happen (99%)*/
 
 #define RENAME_DST_MATCHED 01
 
@@ -40,14 +41,19 @@ struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	unsigned short int score;
-	char source_stays; /* all of R/C are copies */
 	char status; /* M C R N D U (see Documentation/diff-format.txt) */
+	unsigned source_stays : 1; /* all of R/C are copies */
+	unsigned broken_pair : 1;
 };
 #define DIFF_PAIR_UNMERGED(p) \
 	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
 
 #define DIFF_PAIR_RENAME(p) (strcmp((p)->one->path, (p)->two->path))
 
+#define DIFF_PAIR_BROKEN(p) \
+	( (!DIFF_FILE_VALID((p)->one) != !DIFF_FILE_VALID((p)->two)) && \
+	  ((p)->broken_pair != 0) )
+
 #define DIFF_PAIR_TYPE_CHANGED(p) \
 	((S_IFMT & (p)->one->mode) != (S_IFMT & (p)->two->mode))
 
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
new file mode 100755
--- /dev/null
+++ b/t/t4008-diff-break-rewrite.sh
@@ -0,0 +1,207 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Break and then rename
+
+We have two very different files, file0 and file1, registered in a tree.
+
+We update file1 so drastically that it is more similar to file0, and
+then remove file0.  With -B, changes to file1 should be broken into
+separate delete and create, resulting in removal of file0, removal of
+original file1 and creation of completely rewritten file1.
+
+Further, with -B and -M together, these three modifications should
+turn into rename-edit of file0 into file1.
+
+Starting from the same two files in the tree, we swap file0 and file1.
+With -B, this should be detected as two complete rewrites, resulting in
+four changes in total.
+
+Further, with -B and -M together, these should turn into two renames.
+'
+. ./test-lib.sh
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sanitize_diff_raw='s/ '"$_x40"' '"$_x40"' \([CDNR]\)[0-9]*	/ X X \1#	/'
+compare_diff_raw () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    # Also we do not check SHA1 hash generation in this test, which
+    # is a job for t0000-basic.sh
+
+    sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
+    sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+test_expect_success \
+    setup \
+    'cat ../../README >file0 &&
+     cat ../../COPYING >file1 &&
+    git-update-cache --add file0 file1 &&
+    tree=$(git-write-tree) &&
+    echo "$tree"'
+
+test_expect_success \
+    'change file1 with copy-edit of file0 and remove file0' \
+    'sed -e "s/git/GIT/" file0 >file1 &&
+     rm -f file0 &&
+    git-update-cache --remove file0 file1'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B --cached "$tree" >current'
+
+cat >expected <<\EOF
+:100644 000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 0000000000000000000000000000000000000000 D	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 11e331465a89c394dc25c780de230043750c1ec8 N100	file1
+EOF
+
+test_expect_success \
+    'validate result of -B (#1)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -B and -M' \
+    'git-diff-cache -B -M "$tree" >current'
+
+cat >expected <<\EOF
+:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 08bb2fb671deff4c03a4d4a0a1315dff98d5732c R100	file0	file1
+EOF
+
+test_expect_success \
+    'validate result of -B -M (#2)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'swap file0 and file1' \
+    'rm -f file0 file1 &&
+     git-read-tree -m $tree &&
+     git-checkout-cache -f -u -a &&
+     mv file0 tmp &&
+     mv file1 file0 &&
+     mv tmp file1 &&
+     git-update-cache file0 file1'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B "$tree" >current'
+
+cat >expected <<\EOF
+:100644 000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 0000000000000000000000000000000000000000 D100	file0
+:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 N100	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 N100	file1
+EOF
+
+test_expect_success \
+    'validate result of -B (#3)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -B and -M' \
+    'git-diff-cache -B -M "$tree" >current'
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	file1	file0
+:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 R100	file0	file1
+EOF
+
+test_expect_success \
+    'validate result of -B -M (#4)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'make file0 into something completely different' \
+    'rm -f file0 &&
+     ln -s frotz file0 &&
+     git-update-cache file0 file1'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B "$tree" >current'
+
+cat >expected <<\EOF
+:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 N100	file1
+EOF
+
+test_expect_success \
+    'validate result of -B (#5)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B -M "$tree" >current'
+
+# This should not mistake file0 as the copy source of new file1
+# due to type differences.
+cat >expected <<\EOF
+:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 N100	file1
+EOF
+
+test_expect_success \
+    'validate result of -B -M (#6)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -M' \
+    'git-diff-cache -M "$tree" >current'
+
+# This should not mistake file0 as the copy source of new file1
+# due to type differences.
+cat >expected <<\EOF
+:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M	file1
+EOF
+
+test_expect_success \
+    'validate result of -M (#7)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'file1 edited to look like file0 and file0 rename-edited to file2' \
+    'rm -f file0 file1 &&
+     git-read-tree -m $tree &&
+     git-checkout-cache -f -u -a &&
+     sed -e "s/git/GIT/" file0 >file1 &&
+     sed -e "s/git/GET/" file0 >file2 &&
+     rm -f file0
+     git-update-cache --add --remove file0 file1 file2'
+
+test_expect_success \
+    'run diff with -B' \
+    'git-diff-cache -B "$tree" >current'
+
+cat >expected <<\EOF
+:100644 000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 0000000000000000000000000000000000000000 D	file0
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D100	file1
+:000000 100644 0000000000000000000000000000000000000000 08bb2fb671deff4c03a4d4a0a1315dff98d5732c N100	file1
+:000000 100644 0000000000000000000000000000000000000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 N	file2
+EOF
+
+test_expect_success \
+    'validate result of -B (#8)' \
+    'compare_diff_raw current expected'
+
+test_expect_success \
+    'run diff with -B -M' \
+    'git-diff-cache -B -M "$tree" >current'
+
+cat >expected <<\EOF
+:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 08bb2fb671deff4c03a4d4a0a1315dff98d5732c C095	file0	file1
+:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 59f832e5c8b3f7e486be15ad0cd3e95ba9af8998 R095	file0	file2
+EOF
+
+test_expect_success \
+    'validate result of -B -M (#9)' \
+    'compare_diff_raw current expected'
+
+test_done

