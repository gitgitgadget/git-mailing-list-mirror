From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] Introducing software archaeologist's tool "pickaxe".
Date: Sat, 21 May 2005 02:40:01 -0700
Message-ID: <7voeb4kjda.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 11:43:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZQVq-0004a6-QR
	for gcvg-git@gmane.org; Sat, 21 May 2005 11:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVEUJoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 05:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVEUJoS
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 05:44:18 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58555 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261713AbVEUJkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 05:40:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521094002.BMWV12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 05:40:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 02:37:31 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This steals the "pickaxe" feature from JIT and make it available
to the bare Plumbing layer.  From the command line, the user
gives a string he is intersted in.

Using the diff-core infrastructure previously introduced, it
filters the differences to limit the output only to the diffs
between <src> and <dst> where the string appears only in one but
not in the other.  For example:

 $ ./git-rev-list HEAD | ./git-diff-tree -Sdiff-tree-helper --stdin -M

would show the diffs that touch the string "diff-tree-helper".

In real software-archaeologist application, you would typically
look for a few to several lines of code and see where that code
came from.

The "pickaxe" module runs after "rename/copy detection" module,
so it even crosses the file rename boundary, as the above
example demonstrates.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-cache.txt  |    6 +++-
Documentation/git-diff-files.txt  |    6 +++-
Documentation/git-diff-helper.txt |    6 +++-
Documentation/git-diff-tree.txt   |    5 ++-
Makefile                          |    3 +-
diff-cache.c                      |   11 +++++--
diff-files.c                      |    9 ++++--
diff-helper.c                     |   10 ++++--
diff-tree.c                       |   15 ++++++----
diff.c                            |   23 +++++++++------
diff.h                            |    1 
diffcore-pickaxe.c                |   56 ++++++++++++++++++++++++++++++++++++++
diffcore-rename.c                 |   29 +++++++------------
diffcore.h                        |   11 ++++---
14 files changed, 140 insertions(+), 51 deletions(-)
new file (100644): diffcore-pickaxe.c

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [--cached] <tree-ish>
+'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-S<string>] [--cached] <tree-ish>
 
 DESCRIPTION
 -----------
@@ -39,6 +39,10 @@ OPTIONS
 -C::
 	Detect copies as well as renames; implies -p.
 
+-S<string>::
+	Look for differences that contains the change in <string>.
+
+
 -R::
 	Output diff in reverse.
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the w
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,10 @@ OPTIONS
 -C::
 	Detect copies as well as renames; implies -p.
 
+-S<string>::
+	Look for differences that contains the change in <string>.
+
+
 -r::
 	This flag does not mean anything.  It is there only to match
 	git-diff-tree.  Unlike git-diff-tree, git-diff-files always looks
diff --git a/Documentation/git-diff-helper.txt b/Documentation/git-diff-helper.txt
--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -9,7 +9,7 @@ git-diff-helper - Generates patch format
 
 SYNOPSIS
 --------
-'git-diff-helper' [-z] [-R] [-M] [-C]
+'git-diff-helper' [-z] [-R] [-M] [-C] [-S<string>]
 
 DESCRIPTION
 -----------
@@ -37,6 +37,10 @@ OPTIONS
 -C::
 	Detect copies as well as renames.
 
+-S<string>::
+	Look for differences that contains the change in <string>.
+
+
 See Also
 --------
 The section on generating patches in link:git-diff-cache.html[git-diff-cache]
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-S<string>] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -43,6 +43,9 @@ OPTIONS
 -R::
 	Output diff in reverse.
 
+-S<string>::
+	Look for differences that contains the change in <string>.
+
 -r::
 	recurse
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
 
 LIB_H += diff.h
-LIB_OBJS += diff.o diffcore-rename.o
+LIB_OBJS += diff.o diffcore-rename.o diffcore-pickaxe.o
 
 LIB_OBJS += gitenv.o
 
@@ -125,6 +125,7 @@ strbuf.o: $(LIB_H)
 gitenv.o: $(LIB_H)
 diff.o: $(LIB_H)
 diffcore-rename.o : $(LIB_H)
+diffcore-pickaxe.o : $(LIB_H)
 
 test: all
 	make -C t/ all
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -8,6 +8,7 @@ static int line_termination = '\n';
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
+static char *pickaxe = 0;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
@@ -153,7 +154,7 @@ static void mark_merge_entries(void)
 }
 
 static char *diff_cache_usage =
-"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-C] [-R] [--cached] <tree-ish>";
+"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-C] [-R] [-S<string>] [--cached] <tree-ish>";
 
 int main(int argc, char **argv)
 {
@@ -194,6 +195,10 @@ int main(int argc, char **argv)
 			reverse_diff = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-S")) {
+			pickaxe = arg + 2;
+			continue;
+		}
 		if (!strcmp(arg, "-m")) {
 			match_nonexisting = 1;
 			continue;
@@ -208,8 +213,8 @@ int main(int argc, char **argv)
 	if (argc != 2 || get_sha1(argv[1], tree_sha1))
 		usage(diff_cache_usage);
 
-	diff_setup(detect_rename, diff_score_opt, reverse_diff,
-		   (generate_patch ? -1 : line_termination),
+	diff_setup(detect_rename, diff_score_opt, pickaxe,
+		   reverse_diff, (generate_patch ? -1 : line_termination),
 		   NULL, 0);
 
 	mark_merge_entries();
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -7,13 +7,14 @@
 #include "diff.h"
 
 static const char *diff_files_usage =
-"git-diff-files [-p] [-q] [-r] [-z] [-M] [-C] [-R] [paths...]";
+"git-diff-files [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [paths...]";
 
 static int generate_patch = 0;
 static int line_termination = '\n';
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
+static char *pickaxe = 0;
 static int silent = 0;
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
@@ -67,6 +68,8 @@ int main(int argc, char **argv)
 			line_termination = 0;
 		else if (!strcmp(argv[1], "-R"))
 			reverse_diff = 1;
+		else if (!strcmp(argv[1], "-S"))
+			pickaxe = argv[1] + 2;
 		else if (!strncmp(argv[1], "-M", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
 			detect_rename = generate_patch = 1;
@@ -89,8 +92,8 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	diff_setup(detect_rename, diff_score_opt, reverse_diff,
-		   (generate_patch ? -1 : line_termination),
+	diff_setup(detect_rename, diff_score_opt, pickaxe,
+		   reverse_diff, (generate_patch ? -1 : line_termination),
 		   NULL, 0);
 
 	for (i = 0; i < entries; i++) {
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -9,6 +9,7 @@
 static int detect_rename = 0;
 static int diff_score_opt = 0;
 static int generate_patch = 1;
+static char *pickaxe = 0;
 
 static int parse_oneside_change(const char *cp, int *mode,
 				unsigned char *sha1, char *path)
@@ -93,7 +94,7 @@ static int parse_diff_raw_output(const c
 }
 
 static const char *diff_helper_usage =
-	"git-diff-helper [-z] [-R] [-M] [-C] paths...";
+	"git-diff-helper [-z] [-R] [-M] [-C] [-S<string>] paths...";
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
@@ -117,14 +118,17 @@ int main(int ac, const char **av) {
 			detect_rename = 2;
 			diff_score_opt = diff_scoreopt_parse(av[1]);
 		}
+		else if (av[1][1] == 'S') {
+			pickaxe = av[1] + 2;
+		}
 		else
 			usage(diff_helper_usage);
 		ac--; av++;
 	}
 	/* the remaining parameters are paths patterns */
 
-	diff_setup(detect_rename, diff_score_opt, reverse,
-		   (generate_patch ? -1 : line_termination),
+	diff_setup(detect_rename, diff_score_opt, pickaxe,
+		   reverse, (generate_patch ? -1 : line_termination),
 		   av+1, ac-1);
 
 	while (1) {
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -13,6 +13,7 @@ static int generate_patch = 0;
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
+static char *pickaxe = 0;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
@@ -271,8 +272,8 @@ static int diff_tree_sha1_top(const unsi
 {
 	int ret;
 
-	diff_setup(detect_rename, diff_score_opt, reverse_diff,
-		   (generate_patch ? -1 : line_termination),
+	diff_setup(detect_rename, diff_score_opt, pickaxe,
+		   reverse_diff, (generate_patch ? -1 : line_termination),
 		   NULL, 0);
 	ret = diff_tree_sha1(old, new, base);
 	diff_flush();
@@ -285,8 +286,8 @@ static int diff_root_tree(const unsigned
 	void *tree;
 	unsigned long size;
 
-	diff_setup(detect_rename, diff_score_opt, reverse_diff,
-		   (generate_patch ? -1 : line_termination),
+	diff_setup(detect_rename, diff_score_opt, pickaxe,
+		   reverse_diff, (generate_patch ? -1 : line_termination),
 		   NULL, 0);
 	tree = read_object_with_reference(new, "tree", &size, NULL);
 	if (!tree)
@@ -430,7 +431,7 @@ static int diff_tree_stdin(char *line)
 }
 
 static char *diff_tree_usage =
-"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-m] [-s] [-v] <tree-ish> <tree-ish>";
+"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-m] [-s] [-v] <tree-ish> <tree-ish>";
 
 int main(int argc, char **argv)
 {
@@ -473,6 +474,10 @@ int main(int argc, char **argv)
 			recursive = generate_patch = 1;
 			continue;
 		}
+		if (!strncmp(arg, "-S", 2)) {
+			pickaxe = arg + 2;
+			continue;
+		}
 		if (!strncmp(arg, "-M", 2)) {
 			detect_rename = recursive = generate_patch = 1;
 			diff_score_opt = diff_scoreopt_parse(arg);
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -17,6 +17,7 @@ static int reverse_diff;
 static int diff_raw_output = -1;
 static const char **pathspec;
 static int speccnt;
+static const char *pickaxe;
 static int minimum_score;
 
 static const char *external_diff(void)
@@ -511,8 +512,9 @@ int diff_scoreopt_parse(const char *opt)
 	return MAX_SCORE * num / scale;
 }
 
-void diff_setup(int detect_rename_, int minimum_score_, int reverse_diff_,
-		int diff_raw_output_,
+void diff_setup(int detect_rename_, int minimum_score_,
+		char *pickaxe_,
+		int reverse_diff_, int diff_raw_output_,
 		const char **pathspec_, int speccnt_)
 {
 	detect_rename = detect_rename_;
@@ -521,15 +523,16 @@ void diff_setup(int detect_rename_, int 
 	diff_raw_output = diff_raw_output_;
 	speccnt = speccnt_;
 	minimum_score = minimum_score_ ? : DEFAULT_MINIMUM_SCORE;
+	pickaxe = pickaxe_;
 }
 
 static struct diff_queue_struct queued_diff;
 
-struct diff_file_pair *diff_queue(struct diff_queue_struct *queue,
+struct diff_filepair *diff_queue(struct diff_queue_struct *queue,
 				  struct diff_filespec *one,
 				  struct diff_filespec *two)
 {
-	struct diff_file_pair *dp = xmalloc(sizeof(*dp));
+	struct diff_filepair *dp = xmalloc(sizeof(*dp));
 	dp->one = one;
 	dp->two = two;
 	dp->xfrm_msg = 0;
@@ -549,7 +552,7 @@ static const char *git_object_type(unsig
 	return S_ISDIR(mode) ? "tree" : "blob";
 }
 
-static void diff_flush_raw(struct diff_file_pair *p)
+static void diff_flush_raw(struct diff_filepair *p)
 {
 	struct diff_filespec *it;
 	int addremove;
@@ -583,7 +586,7 @@ static void diff_flush_raw(struct diff_f
 	       sha1_to_hex(it->sha1), it->path, diff_raw_output);
 }
 
-static void diff_flush_patch(struct diff_file_pair *p)
+static void diff_flush_patch(struct diff_filepair *p)
 {
 	const char *name, *other;
 
@@ -600,7 +603,7 @@ static int identical(struct diff_filespe
 {
 	/* This function is written stricter than necessary to support
 	 * the currently implemented transformers, but the idea is to
-	 * let transformers to produce diff_file_pairs any way they want,
+	 * let transformers to produce diff_filepairs any way they want,
 	 * and filter and clean them up here before producing the output.
 	 */
 
@@ -623,7 +626,7 @@ static int identical(struct diff_filespe
 	return 0;
 }
 
-static void diff_flush_one(struct diff_file_pair *p)
+static void diff_flush_one(struct diff_filepair *p)
 {
 	if (identical(p->one, p->two))
 		return;
@@ -640,11 +643,13 @@ void diff_flush(void)
 
 	if (detect_rename)
 		diff_detect_rename(q, detect_rename, minimum_score);
+	if (pickaxe)
+		diff_pickaxe(q, pickaxe);
 	for (i = 0; i < q->nr; i++)
 		diff_flush_one(q->queue[i]);
 
 	for (i = 0; i < q->nr; i++) {
-		struct diff_file_pair *p = q->queue[i];
+		struct diff_filepair *p = q->queue[i];
 		diff_free_filespec_data(p->one);
 		diff_free_filespec_data(p->two);
 		free(p->xfrm_msg);
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -20,6 +20,7 @@ extern void diff_unmerge(const char *pat
 extern int diff_scoreopt_parse(const char *opt);
 
 extern void diff_setup(int detect_rename, int minimum_score,
+		       char *pickaxe,
 		       int reverse, int raw_output,
 		       const char **spec, int cnt);
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
new file mode 100644
--- /dev/null
+++ b/diffcore-pickaxe.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "delta.h"
+
+static int contains(struct diff_filespec *one,
+		    const char *needle, unsigned long len)
+{
+	unsigned long offset, sz;
+	const char *data;
+	if (diff_populate_filespec(one))
+		return 0;
+	sz = one->size;
+	data = one->data;
+	for (offset = 0; offset + len <= sz; offset++)
+		     if (!strncmp(needle, data + offset, len))
+			     return 1;
+	return 0;
+}
+
+void diff_pickaxe(struct diff_queue_struct *q, const char *needle)
+{
+	unsigned long len = strlen(needle);
+	int i;
+	struct diff_queue_struct outq;
+	outq.queue = NULL;
+	outq.nr = outq.alloc = 0;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (!p->one->file_valid) {
+			if (!p->two->file_valid)
+				continue; /* ignore nonsense */
+			/* created */
+			if (contains(p->two, needle, len))
+				diff_queue(&outq, p->one, p->two);
+		}
+		else if (!p->two->file_valid) {
+			if (contains(p->one, needle, len))
+				diff_queue(&outq, p->one, p->two);
+		}
+		else if (contains(p->one, needle, len) !=
+			 contains(p->two, needle, len))
+			diff_queue(&outq, p->one, p->two);
+	}
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		free(p);
+	}
+	free(q->queue);
+	*q = outq;
+	return;
+}
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -129,7 +129,7 @@ static void record_rename_pair(struct di
 	 * To achieve this sort order, we give xform_work the number
 	 * above.
 	 */
-	struct diff_file_pair *dp = diff_queue(outq, src, dst);
+	struct diff_filepair *dp = diff_queue(outq, src, dst);
 	dp->xfrm_work = (rank * 2 + 1) | (score<<RENAME_SCORE_SHIFT);
 	dst->xfrm_flags |= RENAME_DST_MATCHED;
 }
@@ -148,7 +148,7 @@ static void debug_filespec(struct diff_f
 		s->size, s->xfrm_flags);
 }
 
-static void debug_filepair(const struct diff_file_pair *p, int i)
+static void debug_filepair(const struct diff_filepair *p, int i)
 {
 	debug_filespec(p->one, i, "one");
 	debug_filespec(p->two, i, "two");
@@ -165,7 +165,7 @@ static void debug_queue(const char *msg,
 		fprintf(stderr, "%s\n", msg);
 	fprintf(stderr, "q->nr = %d\n", q->nr);
 	for (i = 0; i < q->nr; i++) {
-		struct diff_file_pair *p = q->queue[i];
+		struct diff_filepair *p = q->queue[i];
 		debug_filepair(p, i);
 	}
 }
@@ -180,8 +180,8 @@ static void debug_queue(const char *msg,
  */
 static int rank_compare(const void *a_, const void *b_)
 {
-	const struct diff_file_pair *a = *(const struct diff_file_pair **)a_;
-	const struct diff_file_pair *b = *(const struct diff_file_pair **)b_;
+	const struct diff_filepair *a = *(const struct diff_filepair **)a_;
+	const struct diff_filepair *b = *(const struct diff_filepair **)b_;
 	int a_rank = a->xfrm_work & ((1<<RENAME_SCORE_SHIFT) - 1);
 	int b_rank = b->xfrm_work & ((1<<RENAME_SCORE_SHIFT) - 1);
 
@@ -207,7 +207,7 @@ static int needs_to_stay(struct diff_que
 	 * as the source of rename/copy), we need to copy, not rename.
 	 */
 	while (i < q->nr) {
-		struct diff_file_pair *p = q->queue[i++];
+		struct diff_filepair *p = q->queue[i++];
 		if (!p->two->file_valid)
 			continue; /* removed is fine */
 		if (strcmp(p->one->path, it->path))
@@ -243,15 +243,8 @@ void diff_detect_rename(struct diff_queu
 	srcs[0] = &deleted;
 	srcs[1] = &stay;
 
-	/* NEEDSWORK:
-	 * (1) make sure we properly ignore but pass trees.
-	 *
-	 * (2) make sure we do right thing on the same path deleted
-	 *     and created in the same patch.
-	 */
-
 	for (i = 0; i < q->nr; i++) {
-		struct diff_file_pair *p = q->queue[i];
+		struct diff_filepair *p = q->queue[i];
 		if (!p->one->file_valid)
 			if (!p->two->file_valid)
 				continue; /* ignore nonsense */
@@ -340,11 +333,11 @@ void diff_detect_rename(struct diff_queu
 	 * See comments at the top of record_rename_pair for numbers used
 	 * to assign xfrm_work.
 	 *
-	 * Note that we have not annotated the diff_file_pair with any comment
+	 * Note that we have not annotated the diff_filepair with any comment
 	 * so there is nothing other than p to free.
 	 */
 	for (i = 0; i < q->nr; i++) {
-		struct diff_file_pair *dp, *p = q->queue[i];
+		struct diff_filepair *dp, *p = q->queue[i];
 		if (!p->one->file_valid) {
 			if (p->two->file_valid) {
 				/* creation */
@@ -378,7 +371,7 @@ void diff_detect_rename(struct diff_queu
 
 	/* Copy it out to q, removing duplicates. */
 	for (i = 0; i < outq.nr; i++) {
-		struct diff_file_pair *p = outq.queue[i];
+		struct diff_filepair *p = outq.queue[i];
 		if (!p->one->file_valid) {
 			/* created */
 			if (p->two->xfrm_flags & RENAME_DST_MATCHED)
@@ -395,7 +388,7 @@ void diff_detect_rename(struct diff_queu
 		}
 		else if (strcmp(p->one->path, p->two->path)) {
 			/* rename or copy */
-			struct diff_file_pair *dp =
+			struct diff_filepair *dp =
 				diff_queue(q, p->one, p->two);
 			int msglen = (strlen(p->one->path) +
 				      strlen(p->two->path) + 100);
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -38,7 +38,7 @@ extern void fill_filespec(struct diff_fi
 extern int diff_populate_filespec(struct diff_filespec *);
 extern void diff_free_filespec_data(struct diff_filespec *);
 
-struct diff_file_pair {
+struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	char *xfrm_msg;
@@ -47,14 +47,15 @@ struct diff_file_pair {
 };
 
 struct diff_queue_struct {
-	struct diff_file_pair **queue;
+	struct diff_filepair **queue;
 	int alloc;
 	int nr;
 };
 
-extern struct diff_file_pair *diff_queue(struct diff_queue_struct *,
-					 struct diff_filespec *,
-					 struct diff_filespec *);
+extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
+					struct diff_filespec *,
+					struct diff_filespec *);
 extern void diff_detect_rename(struct diff_queue_struct *, int, int);
+extern void diff_pickaxe(struct diff_queue_struct *, const char *);
 
 #endif
------------------------------------------------

