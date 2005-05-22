From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Diffcore updates.
Date: Sun, 22 May 2005 02:41:31 -0700
Message-ID: <7vbr73ha2c.fsf@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 11:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZmxk-0003oz-QX
	for gcvg-git@gmane.org; Sun, 22 May 2005 11:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVEVJmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 05:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVEVJmm
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 05:42:42 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60661 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261786AbVEVJle (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 05:41:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522094132.ONIN16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 05:41:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, this truly makes diff-tree with the pickaxe very pleasant to
use.  Please give it a try.

------------
This patch moves the path selection logic from individual
programs to a new diffcore transformer (diff-tree still needs
to have its own for performance reasons).  Also the header
printing code in diff-tree was tweaked not to produce anything
when pickaxe is in effect and there is nothing interesting to
report.  An interesting example is the following in the GIT
archive itself:

    $ git-whatchanged -p -C -S'or something in a real script'

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Makefile           |    9 +--
diff-cache.c       |   26 ++++++----
diff-files.c       |   37 +++-----------
diff-helper.c      |   16 +++---
diff-tree.c        |   43 ++++++++--------
diff.c             |  137 +++++++++++++++++++++--------------------------------
diff.h             |   20 ++++---
diffcore-pickaxe.c |   15 ++---
diffcore-rename.c  |   23 ++++++++
diffcore.h         |    4 +
10 files changed, 162 insertions(+), 168 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
 
 LIB_H += diff.h
-LIB_OBJS += diff.o diffcore-rename.o diffcore-pickaxe.o
+LIB_OBJS += diff.o diffcore-rename.o diffcore-pickaxe.o diffcore-pathspec.o
 
 LIB_OBJS += gitenv.o
 
@@ -123,9 +123,10 @@ sha1_file.o: $(LIB_H)
 usage.o: $(LIB_H)
 strbuf.o: $(LIB_H)
 gitenv.o: $(LIB_H)
-diff.o: $(LIB_H)
-diffcore-rename.o : $(LIB_H)
-diffcore-pickaxe.o : $(LIB_H)
+diff.o: $(LIB_H) diffcore.h
+diffcore-rename.o : $(LIB_H) diffcore.h
+diffcore-pathspec.o : $(LIB_H) diffcore.h
+diffcore-pickaxe.o : $(LIB_H) diffcore.h
 
 test: all
 	make -C t/ all
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -71,7 +71,7 @@ static int show_modified(struct cache_en
 
 	oldmode = old->ce_mode;
 	if (mode == oldmode && !memcmp(sha1, old->sha1, 20) &&
-	    detect_rename < 2)
+	    detect_rename < DIFF_DETECT_COPY)
 		return 0;
 
 	mode = ntohl(mode);
@@ -156,7 +156,7 @@ static void mark_merge_entries(void)
 static char *diff_cache_usage =
 "git-diff-cache [-p] [-r] [-z] [-m] [-M] [-C] [-R] [-S<string>] [--cached] <tree-ish>";
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	unsigned char tree_sha1[20];
 	void *tree;
@@ -165,7 +165,7 @@ int main(int argc, char **argv)
 
 	read_cache();
 	while (argc > 2) {
-		char *arg = argv[1];
+		const char *arg = argv[1];
 		argv++;
 		argc--;
 		if (!strcmp(arg, "-r")) {
@@ -177,12 +177,12 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strncmp(arg, "-M", 2)) {
-			detect_rename = 1;
+			detect_rename = DIFF_DETECT_RENAME;
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
 		if (!strncmp(arg, "-C", 2)) {
-			detect_rename = 2;
+			detect_rename = DIFF_DETECT_COPY;
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
@@ -209,10 +209,14 @@ int main(int argc, char **argv)
 		usage(diff_cache_usage);
 	}
 
-	if (argc != 2 || get_sha1(argv[1], tree_sha1))
+	if (argc < 2 || get_sha1(argv[1], tree_sha1))
 		usage(diff_cache_usage);
+	argv++;
+	argc--;
 
-	diff_setup(reverse_diff, diff_output_format);
+	/* The rest is for paths restriction. */
+
+	diff_setup(reverse_diff);
 
 	mark_merge_entries();
 
@@ -224,9 +228,11 @@ int main(int argc, char **argv)
 
 	ret = diff_cache(active_cache, active_nr);
 	if (detect_rename)
-		diff_detect_rename(detect_rename, diff_score_opt);
+		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diff_pickaxe(pickaxe);
-	diff_flush(NULL, 0);
+		diffcore_pickaxe(pickaxe);
+	if (2 <= argc)
+		diffcore_pathspec(argv + 1);
+	diff_flush(diff_output_format);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -16,21 +16,6 @@ static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int silent = 0;
 
-static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
-{
-	int i;
-	int namelen = ce_namelen(ce);
-	for (i = 0; i < cnt; i++) {
-		int speclen = strlen(spec[i]);
-		if (! strncmp(spec[i], ce->name, speclen) &&
-		    speclen <= namelen &&
-		    (ce->name[speclen] == 0 ||
-		     ce->name[speclen] == '/'))
-			return 1;
-	}
-	return 0;
-}
-
 static void show_unmerge(const char *path)
 {
 	diff_unmerge(path);
@@ -48,7 +33,7 @@ static void show_modified(int oldmode, i
 	diff_change(oldmode, mode, old_sha1, sha1, path, NULL);
 }
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	static const unsigned char null_sha1[20] = { 0, };
 	int entries = read_cache();
@@ -71,11 +56,11 @@ int main(int argc, char **argv)
 			pickaxe = argv[1] + 2;
 		else if (!strncmp(argv[1], "-M", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
-			detect_rename = 1;
+			detect_rename = DIFF_DETECT_RENAME;
 		}
 		else if (!strncmp(argv[1], "-C", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
-			detect_rename = 2;
+			detect_rename = DIFF_DETECT_COPY;
 		}
 		else
 			usage(diff_files_usage);
@@ -90,7 +75,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	diff_setup(reverse_diff, diff_output_format);
+	diff_setup(reverse_diff);
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
@@ -98,10 +83,6 @@ int main(int argc, char **argv)
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 
-		if (1 < argc &&
-		    ! matches_pathspec(ce, argv+1, argc-1))
-			continue;
-
 		if (ce_stage(ce)) {
 			show_unmerge(ce->name);
 			while (i < entries &&
@@ -122,7 +103,7 @@ int main(int argc, char **argv)
 			continue;
 		}
 		changed = ce_match_stat(ce, &st);
-		if (!changed && detect_rename < 2)
+		if (!changed && detect_rename < DIFF_DETECT_COPY)
 			continue;
 
 		oldmode = ntohl(ce->ce_mode);
@@ -133,9 +114,11 @@ int main(int argc, char **argv)
 			      ce->name);
 	}
 	if (detect_rename)
-		diff_detect_rename(detect_rename, diff_score_opt);
+		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diff_pickaxe(pickaxe);
-	diff_flush(NULL, 0);
+		diffcore_pickaxe(pickaxe);
+	if (1 < argc)
+		diffcore_pathspec(argv + 1);
+	diff_flush(diff_output_format);
 	return 0;
 }
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -77,11 +77,11 @@ int main(int ac, const char **av) {
 		else if (av[1][1] == 'P') /* hidden from the help */
 			diff_output_style = DIFF_FORMAT_MACHINE;
 		else if (av[1][1] == 'M') {
-			detect_rename = 1;
+			detect_rename = DIFF_DETECT_RENAME;
 			diff_score_opt = diff_scoreopt_parse(av[1]);
 		}
 		else if (av[1][1] == 'C') {
-			detect_rename = 2;
+			detect_rename = DIFF_DETECT_COPY;
 			diff_score_opt = diff_scoreopt_parse(av[1]);
 		}
 		else if (av[1][1] == 'S') {
@@ -93,7 +93,7 @@ int main(int ac, const char **av) {
 	}
 	/* the remaining parameters are paths patterns */
 
-	diff_setup(reverse_diff, diff_output_style);
+	diff_setup(reverse_diff);
 	while (1) {
 		int status;
 		read_line(&sb1, stdin, line_termination);
@@ -121,14 +121,16 @@ int main(int ac, const char **av) {
 			status = parse_diff_raw(sb1.buf+1, NULL, NULL);
 		if (status) {
 		unrecognized:
-			diff_flush(av+1, ac-1);
+			diff_flush(diff_output_style);
 			printf("%s%c", sb1.buf, line_termination);
 		}
 	}
 	if (detect_rename)
-		diff_detect_rename(detect_rename, diff_score_opt);
+		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diff_pickaxe(pickaxe);
-	diff_flush(av+1, ac-1);
+		diffcore_pickaxe(pickaxe);
+	if (ac)
+		diffcore_pathspec(av + 1);
+	diff_flush(diff_output_style);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -18,7 +18,7 @@ static const char *header_prefix = "";
 
 // What paths are we interested in?
 static int nr_paths = 0;
-static char **paths = NULL;
+static const char **paths = NULL;
 static int *pathlens = NULL;
 
 static int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base);
@@ -67,11 +67,6 @@ static void show_file(const char *prefix
 	const char *path;
 	const unsigned char *sha1 = extract(tree, size, &path, &mode);
 
-	if (header) {
-		printf("%s", header);
-		header = NULL;
-	}
-
 	if (silent)
 		return;
 
@@ -137,10 +132,6 @@ static int compare_tree_entry(void *tree
 		return retval;
 	}
 
-	if (header) {
-		printf("%s", header);
-		header = NULL;
-	}
 	if (silent)
 		return 0;
 
@@ -268,16 +259,28 @@ static int diff_tree_sha1(const unsigned
 
 static void call_diff_setup(void)
 {
-	diff_setup(reverse_diff, diff_output_format);
+	diff_setup(reverse_diff);
 }
 
-static void call_diff_flush(void)
+static int call_diff_flush()
 {
 	if (detect_rename)
-		diff_detect_rename(detect_rename, diff_score_opt);
-	if (pickaxe)
-		diff_pickaxe(pickaxe);
-	diff_flush(NULL, 0);
+		diffcore_rename(detect_rename, diff_score_opt);
+	if (pickaxe) {
+		diffcore_pickaxe(pickaxe);
+		if (diff_queue_is_empty()) {
+			diff_flush(DIFF_FORMAT_NO_OUTPUT);
+			return 0;
+		}
+	}
+	if (nr_paths)
+		diffcore_pathspec(paths);
+	if (header) {
+		printf("%s", header);
+		header = NULL;
+	}
+	diff_flush(diff_output_format);
+	return 1;
 }
 
 static int diff_tree_sha1_top(const unsigned char *old,
@@ -462,7 +465,7 @@ static int diff_tree_stdin(char *line)
 static char *diff_tree_usage =
 "git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-m] [-s] [-v] <tree-ish> <tree-ish>";
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	int nr_sha1;
 	char line[1000];
@@ -470,7 +473,7 @@ int main(int argc, char **argv)
 
 	nr_sha1 = 0;
 	for (;;) {
-		char *arg;
+		const char *arg;
 
 		argv++;
 		argc--;
@@ -509,12 +512,12 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strncmp(arg, "-M", 2)) {
-			detect_rename = 1;
+			detect_rename = DIFF_DETECT_RENAME;
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
 		if (!strncmp(arg, "-C", 2)) {
-			detect_rename = 2;
+			detect_rename = DIFF_DETECT_COPY;
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -16,8 +16,6 @@ static int reverse_diff;
 static int generate_patch;
 static int line_termination = '\n';
 static int inter_name_termination = '\t';
-static const char **pathspec;
-static int speccnt;
 
 static const char *external_diff(void)
 {
@@ -286,6 +284,12 @@ int diff_populate_filespec(struct diff_f
 	return 0;
 }
 
+void diff_free_filepair(struct diff_filepair *p)
+{
+	free(p->xfrm_msg);
+	free(p);
+}
+
 void diff_free_filespec_data(struct diff_filespec *s)
 {
 	if (s->should_free)
@@ -390,25 +394,6 @@ static void remove_tempfile_on_signal(in
 	remove_tempfile();
 }
 
-static int matches_pathspec(const char *name)
-{
-	int i;
-	int namelen;
-
-	if (speccnt == 0)
-		return 1;
-
-	namelen = strlen(name);
-	for (i = 0; i < speccnt; i++) {
-		int speclen = strlen(pathspec[i]);
-		if (! strncmp(pathspec[i], name, speclen) &&
-		    speclen <= namelen &&
-		    (name[speclen] == 0 || name[speclen] == '/'))
-			return 1;
-	}
-	return 0;
-}
-
 /* An external diff command takes:
  *
  * diff-cmd name infile1 infile1-sha1 infile1-mode \
@@ -426,9 +411,6 @@ static void run_external_diff(const char
 	int status;
 	static int atexit_asked = 0;
 
-	if (!matches_pathspec(name) && (!other || !matches_pathspec(other)))
-		return;
-
 	if (one && two) {
 		prepare_temp_file(name, &temp[0], one);
 		prepare_temp_file(other ? : name, &temp[1], two);
@@ -496,47 +478,26 @@ static void run_external_diff(const char
 	remove_tempfile();
 }
 
-int diff_scoreopt_parse(const char *opt)
+void diff_setup(int reverse_diff_)
 {
-	int diglen, num, scale, i;
-	if (opt[0] != '-' || (opt[1] != 'M' && opt[1] != 'C'))
-		return -1; /* that is not a -M nor -C option */
-	diglen = strspn(opt+2, "0123456789");
-	if (diglen == 0 || strlen(opt+2) != diglen)
-		return 0; /* use default */
-	sscanf(opt+2, "%d", &num);
-	for (i = 0, scale = 1; i < diglen; i++)
-		scale *= 10;
-
-	/* user says num divided by scale and we say internally that
-	 * is MAX_SCORE * num / scale.
-	 */
-	return MAX_SCORE * num / scale;
+	reverse_diff = reverse_diff_;
 }
 
-void diff_setup(int reverse_diff_, int diff_output_style)
+struct diff_queue_struct diff_queued_diff;
+
+void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
 {
-	reverse_diff = reverse_diff_;
-	generate_patch = 0;
-	switch (diff_output_style) {
-	case DIFF_FORMAT_HUMAN:
-		line_termination = '\n';
-		inter_name_termination = '\t';
-		break;
-	case DIFF_FORMAT_MACHINE:
-		line_termination = inter_name_termination = 0;
-		break;
-	case DIFF_FORMAT_PATCH:
-		generate_patch = 1;
-		break;
+	if (queue->alloc <= queue->nr) {
+		queue->alloc = alloc_nr(queue->alloc);
+		queue->queue = xrealloc(queue->queue,
+					sizeof(dp) * queue->alloc);
 	}
+	queue->queue[queue->nr++] = dp;
 }
 
-struct diff_queue_struct diff_queued_diff;
-
 struct diff_filepair *diff_queue(struct diff_queue_struct *queue,
-				  struct diff_filespec *one,
-				  struct diff_filespec *two)
+				 struct diff_filespec *one,
+				 struct diff_filespec *two)
 {
 	struct diff_filepair *dp = xmalloc(sizeof(*dp));
 	dp->one = one;
@@ -544,20 +505,16 @@ struct diff_filepair *diff_queue(struct 
 	dp->xfrm_msg = 0;
 	dp->orig_order = queue->nr;
 	dp->xfrm_work = 0;
-	if (queue->alloc <= queue->nr) {
-		queue->alloc = alloc_nr(queue->alloc);
-		queue->queue = xrealloc(queue->queue,
-				       sizeof(dp) * queue->alloc);
-	}
-	queue->queue[queue->nr++] = dp;
+	diff_q(queue, dp);
 	return dp;
 }
 
 static void diff_flush_raw(struct diff_filepair *p)
 {
-	/*
-	 * We used to reject rename/copy but new diff-raw can express them.
-	 */
+	if (DIFF_PAIR_UNMERGED(p)) {
+		printf("U %s%c", p->one->path, line_termination);
+		return;
+	}
 	printf(":%06o %06o %s ",
 	       p->one->mode, p->two->mode, sha1_to_hex(p->one->sha1));
 	printf("%s%c%s%c%s%c",
@@ -576,19 +533,26 @@ static void diff_flush_patch(struct diff
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
 		return; /* no tree diffs in patch format */ 
 
-	run_external_diff(name, other, p->one, p->two, p->xfrm_msg);
+	if (DIFF_PAIR_UNMERGED(p))
+		run_external_diff(name, NULL, NULL, NULL, NULL);
+	else
+		run_external_diff(name, other, p->one, p->two, p->xfrm_msg);
 }
 
-static int identical(struct diff_filespec *one, struct diff_filespec *two)
+static int interesting(struct diff_filepair *p)
 {
 	/* This function is written stricter than necessary to support
 	 * the currently implemented transformers, but the idea is to
 	 * let transformers to produce diff_filepairs any way they want,
 	 * and filter and clean them up here before producing the output.
 	 */
+	struct diff_filespec *one, *two;
+
+	if (DIFF_PAIR_UNMERGED(p))
+		return 0; /* unmerged is interesting */
 
-	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two))
-		return 1; /* not interesting */
+	one = p->one;
+	two = p->two;
 
 	/* deletion, addition, mode change and renames are all interesting. */
 	if (DIFF_FILE_VALID(one) != DIFF_FILE_VALID(two) ||
@@ -609,7 +573,7 @@ static int identical(struct diff_filespe
 
 static void diff_flush_one(struct diff_filepair *p)
 {
-	if (identical(p->one, p->two))
+	if (interesting(p))
 		return;
 	if (generate_patch)
 		diff_flush_patch(p);
@@ -624,23 +588,32 @@ int diff_queue_is_empty(void)
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (!identical(p->one, p->two))
+		if (!interesting(p))
 			return 0;
 	}
 	return 1;
 }
 
-void diff_flush(const char **pathspec_, int speccnt_)
+void diff_flush(int diff_output_style)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
 
-	pathspec = pathspec_;
-	speccnt = speccnt_;
-
+	generate_patch = 0;
+	switch (diff_output_style) {
+	case DIFF_FORMAT_HUMAN:
+		line_termination = '\n';
+		inter_name_termination = '\t';
+		break;
+	case DIFF_FORMAT_MACHINE:
+		line_termination = inter_name_termination = 0;
+		break;
+	case DIFF_FORMAT_PATCH:
+		generate_patch = 1;
+		break;
+	}
 	for (i = 0; i < q->nr; i++)
 		diff_flush_one(q->queue[i]);
-
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		diff_free_filespec_data(p->one);
@@ -669,7 +642,7 @@ void diff_addremove(int addremove, unsig
 	 * which but should not make any difference).
 	 * Feeding the same new and old to diff_change() should
 	 * also have the same effect.  diff_flush() should
-	 * filter the identical ones out at the final output
+	 * filter uninteresting ones out at the final output
 	 * stage.
 	 */
 	if (reverse_diff)
@@ -739,8 +712,8 @@ void diff_change(unsigned old_mode, unsi
 
 void diff_unmerge(const char *path)
 {
-	if (generate_patch)
-		run_external_diff(path, NULL, NULL, NULL, NULL);
-	else
-		printf("U %s%c", path, line_termination);
+	struct diff_filespec *one, *two;
+	one = alloc_filespec(path);
+	two = alloc_filespec(path);
+	diff_queue(&diff_queued_diff, one, two);
 }
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -26,16 +26,20 @@ extern void diff_unmerge(const char *pat
 
 extern int diff_scoreopt_parse(const char *opt);
 
-#define DIFF_FORMAT_HUMAN   0
-#define DIFF_FORMAT_MACHINE 1
-#define DIFF_FORMAT_PATCH   2
-extern void diff_setup(int reverse, int diff_output_style);
-
-extern void diff_detect_rename(int, int);
-extern void diff_pickaxe(const char *);
+#define DIFF_FORMAT_HUMAN	0
+#define DIFF_FORMAT_MACHINE	1
+#define DIFF_FORMAT_PATCH	2
+#define DIFF_FORMAT_NO_OUTPUT	3
+extern void diff_setup(int reverse);
+
+#define DIFF_DETECT_RENAME	1
+#define DIFF_DETECT_COPY	2
+extern void diffcore_rename(int rename_copy, int minimum_score);
+extern void diffcore_pickaxe(const char *needle);
+extern void diffcore_pathspec(const char **pathspec);
 
 extern int diff_queue_is_empty(void);
 
-extern void diff_flush(const char **, int);
+extern void diff_flush(int output_style);
 
 #endif /* DIFF_H */
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -21,7 +21,7 @@ static int contains(struct diff_filespec
 	return 0;
 }
 
-void diff_pickaxe(const char *needle)
+void diffcore_pickaxe(const char *needle)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
@@ -32,24 +32,23 @@ void diff_pickaxe(const char *needle)
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
+		int onum = outq.nr;
 		if (!DIFF_FILE_VALID(p->one)) {
 			if (!DIFF_FILE_VALID(p->two))
 				continue; /* ignore nonsense */
 			/* created */
 			if (contains(p->two, needle, len))
-				diff_queue(&outq, p->one, p->two);
+				diff_q(&outq, p);
 		}
 		else if (!DIFF_FILE_VALID(p->two)) {
 			if (contains(p->one, needle, len))
-				diff_queue(&outq, p->one, p->two);
+				diff_q(&outq, p);
 		}
 		else if (contains(p->one, needle, len) !=
 			 contains(p->two, needle, len))
-			diff_queue(&outq, p->one, p->two);
-	}
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		free(p);
+			diff_q(&outq, p);
+		if (onum == outq.nr)
+			diff_free_filepair(p);
 	}
 	free(q->queue);
 	*q = outq;
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -224,8 +224,25 @@ static int needs_to_stay(struct diff_que
 	return 0;
 }
 
-void diff_detect_rename(int detect_rename,
-			int minimum_score)
+int diff_scoreopt_parse(const char *opt)
+{
+	int diglen, num, scale, i;
+	if (opt[0] != '-' || (opt[1] != 'M' && opt[1] != 'C'))
+		return -1; /* that is not a -M nor -C option */
+	diglen = strspn(opt+2, "0123456789");
+	if (diglen == 0 || strlen(opt+2) != diglen)
+		return 0; /* use default */
+	sscanf(opt+2, "%d", &num);
+	for (i = 0, scale = 1; i < diglen; i++)
+		scale *= 10;
+
+	/* user says num divided by scale and we say internally that
+	 * is MAX_SCORE * num / scale.
+	 */
+	return MAX_SCORE * num / scale;
+}
+
+void diffcore_rename(int detect_rename, int minimum_score)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
@@ -235,6 +252,8 @@ void diff_detect_rename(int detect_renam
 	int h, i, j;
 	int num_create, num_src, dst_cnt, src_cnt;
 
+	if (!minimum_score)
+		minimum_score = DEFAULT_MINIMUM_SCORE;
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
 
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -45,6 +45,8 @@ struct diff_filepair {
 	int orig_order; /* the original order of insertion into the queue */
 	int xfrm_work; /* for use by tramsformers, not by diffcore */
 };
+#define DIFF_PAIR_UNMERGED(p) \
+	(!DIFF_FILE_VALID((p)->one) && !DIFF_FILE_VALID((p)->two))
 
 struct diff_queue_struct {
 	struct diff_filepair **queue;
@@ -56,5 +58,7 @@ extern struct diff_queue_struct diff_que
 extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *,
 					struct diff_filespec *);
+extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
+extern void diff_free_filepair(struct diff_filepair *);
 
 #endif
------------------------------------------------

