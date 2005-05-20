From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff overhaul
Date: Thu, 19 May 2005 19:00:36 -0700
Message-ID: <7vll6awta3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 04:01:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYwpI-0002vr-QK
	for gcvg-git@gmane.org; Fri, 20 May 2005 04:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVETCCO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 22:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVETCCO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 22:02:14 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19427 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261314AbVETCAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 22:00:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520020038.DEDH7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 22:00:38 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Diff overhaul.

This patch cleans up the way calls are made into the diff core
from diff-tree family and diff-helper.  Earlier, these programs
had "if (generating_patch)" sprinkled all over the place, but
those ugliness are gone and handled uniformly from the diff
core, even when not generating patch format.

This also allowed diff-cache and diff-files to acquire -R
(reverse) option to generate diff in reverse.  Users of
diff-tree can swap two trees easily so I did not add -R there.

Also -M<digits-as-mantissa> suggestion made by Linus has been
implemented.

It also fixes minor permission problems with some of the test
scripts (although it should not matter since they are explicitly
run by being the first argument to "sh"), but this being a patch
that may not convey well.

Documentation updates are also included.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-cache.txt |    5 +
Documentation/git-diff-files.txt |    5 +
diff-cache.c                     |   42 ++++-------
diff-files.c                     |   44 ++++--------
diff-helper.c                    |   19 +++--
diff-tree.c                      |   46 ++++--------
diff.c                           |  142 +++++++++++++++++++++++++++++++--------
diff.h                           |    4 -
t/t0000-basic.sh                 |    2 
t/t2002-checkout-cache-u.sh      |    2 
t/t4001-diff-rename.sh           |    6 +
11 files changed, 192 insertions(+), 125 deletions(-)
mode changed (100644 --> 100755): t/t0110-environment-names-old.sh
mode changed (100644 --> 100755): t/t1000-read-tree-m-3way.sh
mode changed (100644 --> 100755): t/t2002-checkout-cache-u.sh
mode changed (100644 --> 100755): t/t4000-diff-format.sh
mode changed (100644 --> 100755): t/t4001-diff-rename.sh

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [--cached] <tree-ish>
+'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [--cached] <tree-ish>
 
 DESCRIPTION
 -----------
@@ -36,6 +36,9 @@ OPTIONS
 -M::
 	Detect renames; implies -p.
 
+-R::
+	Output diff in reverse.
+
 --cached::
 	do not consider the on-disk file at all
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the w
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [-M] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-R] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -26,6 +26,9 @@ OPTIONS
 -q::
 	Remain silent even on nonexisting files
 
+-R::
+	Output diff in reverse.
+
 -M::
 	Detect renames; implies -p.
 
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -6,15 +6,13 @@ static int generate_patch = 0;
 static int match_nonexisting = 0;
 static int line_termination = '\n';
 static int detect_rename = 0;
+static int reverse_diff = 0;
+static int diff_score_opt = 0;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
 {
-	if (generate_patch)
-		diff_addremove(prefix[0], ntohl(mode), sha1, ce->name, NULL);
-	else
-		printf("%s%06o\tblob\t%s\t%s%c", prefix, ntohl(mode),
-		       sha1_to_hex(sha1), ce->name, line_termination);
+	diff_addremove(prefix[0], ntohl(mode), sha1, ce->name, NULL);
 }
 
 static int get_stat_data(struct cache_entry *ce, unsigned char **sha1p, unsigned int *modep)
@@ -64,7 +62,6 @@ static int show_modified(struct cache_en
 {
 	unsigned int mode, oldmode;
 	unsigned char *sha1;
-	char old_sha1_hex[60];
 
 	if (get_stat_data(new, &sha1, &mode) < 0) {
 		if (report_missing)
@@ -79,15 +76,8 @@ static int show_modified(struct cache_en
 	mode = ntohl(mode);
 	oldmode = ntohl(oldmode);
 
-	if (generate_patch)
-		diff_change(oldmode, mode,
-			    old->sha1, sha1, old->name, NULL);
-	else {
-		strcpy(old_sha1_hex, sha1_to_hex(old->sha1));
-		printf("*%06o->%06o\tblob\t%s->%s\t%s%c", oldmode, mode,
-		       old_sha1_hex, sha1_to_hex(sha1),
-		       old->name, line_termination);
-	}
+	diff_change(oldmode, mode,
+		    old->sha1, sha1, old->name, NULL);
 	return 0;
 }
 
@@ -127,10 +117,7 @@ static int diff_cache(struct cache_entry
 				break;
 			/* fallthru */
 		case 3:
-			if (generate_patch)
-				diff_unmerge(ce->name);
-			else
-				printf("U %s%c", ce->name, line_termination);
+			diff_unmerge(ce->name);
 			break;
 
 		default:
@@ -166,7 +153,7 @@ static void mark_merge_entries(void)
 }
 
 static char *diff_cache_usage =
-"git-diff-cache [-p] [-r] [-z] [-m] [-M] [--cached] <tree-ish>";
+"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-R] [--cached] <tree-ish>";
 
 int main(int argc, char **argv)
 {
@@ -188,14 +175,19 @@ int main(int argc, char **argv)
 			generate_patch = 1;
 			continue;
 		}
-		if (!strcmp(arg, "-M")) {
+		if (!strncmp(arg, "-M", 2)) {
 			generate_patch = detect_rename = 1;
+			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = '\0';
 			continue;
 		}
+		if (!strcmp(arg, "-R")) {
+			reverse_diff = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-m")) {
 			match_nonexisting = 1;
 			continue;
@@ -210,8 +202,9 @@ int main(int argc, char **argv)
 	if (argc != 2 || get_sha1(argv[1], tree_sha1))
 		usage(diff_cache_usage);
 
-	if (generate_patch)
-		diff_setup(detect_rename, 0, 0, 0, 0);
+	diff_setup(detect_rename, diff_score_opt, reverse_diff,
+		   (generate_patch ? -1 : line_termination),
+		   0, 0);
 
 	mark_merge_entries();
 
@@ -222,7 +215,6 @@ int main(int argc, char **argv)
 		die("unable to read tree object %s", argv[1]);
 
 	ret = diff_cache(active_cache, active_nr);
-	if (generate_patch)
-		diff_flush();
+	diff_flush();
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -7,11 +7,13 @@
 #include "diff.h"
 
 static const char *diff_files_usage =
-"git-diff-files [-p] [-q] [-r] [-z] [-M] [paths...]";
+"git-diff-files [-p] [-q] [-r] [-z] [-M] [-R] [paths...]";
 
 static int generate_patch = 0;
 static int line_termination = '\n';
 static int detect_rename = 0;
+static int reverse_diff = 0;
+static int diff_score_opt = 0;
 static int silent = 0;
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
@@ -31,36 +33,19 @@ static int matches_pathspec(struct cache
 
 static void show_unmerge(const char *path)
 {
-	if (generate_patch)
-		diff_unmerge(path);
-	else
-		printf("U %s%c", path, line_termination);
+	diff_unmerge(path);
 }
 
 static void show_file(int pfx, struct cache_entry *ce)
 {
-	if (generate_patch)
-		diff_addremove(pfx, ntohl(ce->ce_mode), ce->sha1,
-			       ce->name, NULL);
-	else
-		printf("%c%06o\t%s\t%s\t%s%c",
-		       pfx, ntohl(ce->ce_mode), "blob",
-		       sha1_to_hex(ce->sha1), ce->name, line_termination);
+	diff_addremove(pfx, ntohl(ce->ce_mode), ce->sha1, ce->name, NULL);
 }
 
 static void show_modified(int oldmode, int mode,
 			  const unsigned char *old_sha1, const unsigned char *sha1,
 			  char *path)
 {
-	char old_sha1_hex[41];
-	strcpy(old_sha1_hex, sha1_to_hex(old_sha1));
-
-	if (generate_patch)
-		diff_change(oldmode, mode, old_sha1, sha1, path, NULL);
-	else
-		printf("*%06o->%06o\tblob\t%s->%s\t%s%c",
-		       oldmode, mode, old_sha1_hex, sha1_to_hex(sha1), path,
-		       line_termination);
+	diff_change(oldmode, mode, old_sha1, sha1, path, NULL);
 }
 
 int main(int argc, char **argv)
@@ -80,7 +65,10 @@ int main(int argc, char **argv)
 			; /* no-op */
 		else if (!strcmp(argv[1], "-z"))
 			line_termination = 0;
-		else if (!strcmp(argv[1], "-M")) {
+		else if (!strcmp(argv[1], "-R"))
+			reverse_diff = 1;
+		else if (!strncmp(argv[1], "-M", 2)) {
+			diff_score_opt = diff_scoreopt_parse(argv[1]);
 			detect_rename = generate_patch = 1;
 		}
 		else
@@ -96,8 +84,9 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	if (generate_patch)
-		diff_setup(detect_rename, 0, 0, 0, 0);		
+	diff_setup(detect_rename, diff_score_opt, reverse_diff,
+		   (generate_patch ? -1 : line_termination),
+		   0, 0);
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
@@ -117,12 +106,12 @@ int main(int argc, char **argv)
 			i--; /* compensate for loop control increments */
 			continue;
 		}
- 
+
 		if (lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT) {
 				perror(ce->name);
 				continue;
-			}	
+			}
 			if (silent)
 				continue;
 			show_file('-', ce);
@@ -139,7 +128,6 @@ int main(int argc, char **argv)
 		show_modified(oldmode, mode, ce->sha1, null_sha1,
 			      ce->name);
 	}
-	if (generate_patch)
-		diff_flush();
+	diff_flush();
 	return 0;
 }
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 
 static int detect_rename = 0;
+static int diff_score_opt = 0;
 
 static int parse_oneside_change(const char *cp, int *mode,
 				unsigned char *sha1, char *path)
@@ -19,15 +20,15 @@ static int parse_oneside_change(const ch
 		cp++;
 	}
 	*mode = m;
-	if (strncmp(cp, "\tblob\t", 6))
+	if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6))
 		return -1;
 	cp += 6;
 	if (get_sha1_hex(cp, sha1))
 		return -1;
 	cp += 40;
-	if (*cp++ != '\t')
+	if ((*cp != '\t') && *cp != ' ')
 		return -1;
-	strcpy(path, cp);
+	strcpy(path, ++cp);
 	return 0;
 }
 
@@ -63,7 +64,7 @@ static int parse_diff_raw_output(const c
 			new_mode = (new_mode << 3) | (ch - '0');
 			cp++;
 		}
-		if (strncmp(cp, "\tblob\t", 6))
+		if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6))
 			return -1;
 		cp += 6;
 		if (get_sha1_hex(cp, old_sha1))
@@ -75,9 +76,9 @@ static int parse_diff_raw_output(const c
 		if (get_sha1_hex(cp, new_sha1))
 			return -1;
 		cp += 40;
-		if (*cp++ != '\t')
+		if ((*cp != '\t') && *cp != ' ')
 			return -1;
-		strcpy(path, cp);
+		strcpy(path, ++cp);
 		diff_change(old_mode, new_mode, old_sha1, new_sha1, path, 0);
 		break;
 	default:
@@ -101,15 +102,17 @@ int main(int ac, const char **av) {
 			reverse = 1;
 		else if (av[1][1] == 'z')
 			line_termination = 0;
-		else if (av[1][1] == 'M')
+		else if (av[1][1] == 'M') {
 			detect_rename = 1;
+			diff_score_opt = diff_scoreopt_parse(av[1]);
+		}
 		else
 			usage(diff_helper_usage);
 		ac--; av++;
 	}
 	/* the remaining parameters are paths patterns */
 
-	diff_setup(detect_rename, 0, reverse, av+1, ac-1);
+	diff_setup(detect_rename, diff_score_opt, reverse, -1, av+1, ac-1);
 
 	while (1) {
 		int status;
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -11,6 +11,7 @@ static int read_stdin = 0;
 static int line_termination = '\n';
 static int generate_patch = 0;
 static int detect_rename = 0;
+static int diff_score_opt = 0;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
@@ -84,21 +85,13 @@ static void show_file(const char *prefix
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
 
 		show_tree(prefix, tree, size, newbase);
-		
+
 		free(tree);
 		free(newbase);
 		return;
 	}
 
-	if (generate_patch) {
-		if (!S_ISDIR(mode))
-			diff_addremove(prefix[0], mode, sha1, base, path);
-	}
-	else
-		printf("%s%06o\t%s\t%s\t%s%s%c", prefix, mode,
-		       S_ISDIR(mode) ? "tree" : "blob",
-		       sha1_to_hex(sha1), base, path,
-		       line_termination);
+	diff_addremove(prefix[0], mode, sha1, base, path);
 }
 
 static int compare_tree_entry(void *tree1, unsigned long size1, void *tree2, unsigned long size2, const char *base)
@@ -107,7 +100,6 @@ static int compare_tree_entry(void *tree
 	const char *path1, *path2;
 	const unsigned char *sha1, *sha2;
 	int cmp, pathlen1, pathlen2;
-	char old_sha1_hex[50];
 
 	sha1 = extract(tree1, size1, &path1, &mode1);
 	sha2 = extract(tree2, size2, &path2, &mode2);
@@ -151,17 +143,7 @@ static int compare_tree_entry(void *tree
 	if (silent)
 		return 0;
 
-	if (generate_patch) {
-		if (!S_ISDIR(mode1))
-			diff_change(mode1, mode2, sha1, sha2, base, path1);
-	}
-	else {
-		strcpy(old_sha1_hex, sha1_to_hex(sha1));
-		printf("*%06o->%06o\t%s\t%s->%s\t%s%s%c", mode1, mode2,
-		       S_ISDIR(mode1) ? "tree" : "blob",
-		       old_sha1_hex, sha1_to_hex(sha2), base, path1,
-		       line_termination);
-	}
+	diff_change(mode1, mode2, sha1, sha2, base, path1);
 	return 0;
 }
 
@@ -287,11 +269,12 @@ static int diff_tree_sha1_top(const unsi
 			      const unsigned char *new, const char *base)
 {
 	int ret;
-	if (generate_patch)
-		diff_setup(detect_rename, 0, 0, 0, 0);
+
+	diff_setup(detect_rename, diff_score_opt, 0,
+		   (generate_patch ? -1 : line_termination),
+		   0, 0);
 	ret = diff_tree_sha1(old, new, base);
-	if (generate_patch)
-		diff_flush();
+	diff_flush();
 	return ret;
 }
 
@@ -301,15 +284,15 @@ static int diff_root_tree(const unsigned
 	void *tree;
 	unsigned long size;
 
-	if (generate_patch)
-		diff_setup(detect_rename, 0, 0, 0, 0);
+	diff_setup(detect_rename, diff_score_opt, 0,
+		   (generate_patch ? -1 : line_termination),
+		   0, 0);
 	tree = read_object_with_reference(new, "tree", &size, 0);
 	if (!tree)
 		die("unable to read root tree (%s)", sha1_to_hex(new));
 	retval = diff_tree("", 0, tree, size, base);
 	free(tree);
-	if (generate_patch)
-		diff_flush();
+	diff_flush();
 	return retval;
 }
 
@@ -485,8 +468,9 @@ int main(int argc, char **argv)
 			recursive = generate_patch = 1;
 			continue;
 		}
-		if (!strcmp(arg, "-M")) {
+		if (!strncmp(arg, "-M", 2)) {
 			detect_rename = recursive = generate_patch = 1;
+			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -11,6 +11,8 @@
 
 static const char *diff_opts = "-pu";
 static unsigned char null_sha1[20] = { 0, };
+#define MAX_SCORE 10000
+#define DEFAULT_MINIMUM_SCORE 5000
 
 static const char *external_diff(void)
 {
@@ -55,7 +57,7 @@ static char *sq_expand(const char *src)
 	const char *cp;
 	char *bp;
 
-	/* count bytes needed to store the quoted string. */ 
+	/* count bytes needed to store the quoted string. */
 	for (cnt = 1, cp = src; *cp; cnt++, cp++)
 		if (*cp == '\'')
 			cnt += 3;
@@ -93,7 +95,8 @@ struct diff_spec {
 
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
-			 struct diff_tempfile *temp)
+			 struct diff_tempfile *temp,
+			 int rename_score)
 {
 	int i, next_at, cmd_size;
 	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
@@ -149,6 +152,10 @@ static void builtin_diff(const char *nam
 			printf("new mode %s\n", temp[1].mode);
 		}
 		if (strcmp(name_a, name_b)) {
+			if (0 < rename_score)
+				printf("rename similarity index %d%%\n",
+				       (int)(0.5+
+					     rename_score*100.0/MAX_SCORE));
 			printf("rename old %s\n", name_a);
 			printf("rename new %s\n", name_b);
 		}
@@ -184,7 +191,7 @@ static int work_tree_matches(const char 
 	 * file.  Practically, this code only helps when we are used
 	 * by diff-cache --cached, which does read the cache before
 	 * calling us.
-	 */ 
+	 */
 	if (!active_cache)
 		return 0;
 
@@ -302,9 +309,10 @@ static void remove_tempfile_on_signal(in
 
 static int detect_rename;
 static int reverse_diff;
+static int diff_raw_output = -1;
 static const char **pathspec;
 static int speccnt;
-static int diff_rename_minimum_score;
+static int minimum_score;
 
 static int matches_pathspec(const char *name)
 {
@@ -334,7 +342,8 @@ static int matches_pathspec(const char *
 static void run_external_diff(const char *name,
 			      const char *other,
 			      struct diff_spec *one,
-			      struct diff_spec *two)
+			      struct diff_spec *two,
+			      int rename_score)
 {
 	struct diff_tempfile *temp = diff_temp;
 	pid_t pid;
@@ -395,7 +404,7 @@ static void run_external_diff(const char
 		 * otherwise we use the built-in one.
 		 */
 		if (one && two)
-			builtin_diff(name, other ? : name, temp);
+			builtin_diff(name, other ? : name, temp, rename_score);
 		else
 			printf("* Unmerged path %s\n", name);
 		exit(0);
@@ -446,7 +455,7 @@ static void hold_diff(const char *name,
 		die("internal error");
 
 	if (!detect_rename) {
-		run_external_diff(name, NULL, one, two);
+		run_external_diff(name, NULL, one, two, -1);
 		return;
 	}
 	elem = xmalloc(sizeof(*elem) + strlen(name));
@@ -519,10 +528,10 @@ static void flush_remaining_diff(struct 
 			continue;
 		if (on_created_list)
 			run_external_diff(elem->path, NULL,
-					  &null_file_spec, &elem->it);
+					  &null_file_spec, &elem->it, -1);
 		else
 			run_external_diff(elem->path, NULL,
-					  &elem->it, &null_file_spec);
+					  &elem->it, &null_file_spec, -1);
 	}
 }
 
@@ -541,7 +550,6 @@ static int is_exact_match(struct diff_sp
 	return 0;
 }
 
-#define MINIMUM_SCORE 5000
 int estimate_similarity(struct diff_spec_hold *src, struct diff_spec_hold *dst)
 {
 	/* src points at a deleted file and dst points at a created
@@ -549,20 +557,24 @@ int estimate_similarity(struct diff_spec
 	 * say src is renamed to dst.
 	 *
 	 * Compare them and return how similar they are, representing
-	 * the score as an integer between 0 and 10000.  10000 is
-	 * reserved for the case where they match exactly.
+	 * the score as an integer between 0 and 10000, except
+	 * where they match exactly it is considered better than anything
+	 * else.
 	 */
 	void *delta;
 	unsigned long delta_size;
+	int score;
 
 	delta_size = ((src->size < dst->size) ?
 		      (dst->size - src->size) : (src->size - dst->size));
 
 	/* We would not consider rename followed by more than
-	 * 20% edits; that is, delta_size must be smaller than
-	 * (src->size + dst->size)/2 * 0.2, which means...
+	 * minimum_score/MAX_SCORE edits; that is, delta_size must be smaller
+	 * than (src->size + dst->size)/2 * minimum_score/MAX_SCORE,
+	 * which means...
 	 */
-	if ((src->size + dst->size) < delta_size * 10)
+
+	if ((src->size+dst->size)*minimum_score < delta_size*MAX_SCORE*2)
 		return 0;
 
 	delta = diff_delta(src->data, src->size,
@@ -573,14 +585,17 @@ int estimate_similarity(struct diff_spec
 	/* This "delta" is really xdiff with adler32 and all the
 	 * overheads but it is a quick and dirty approximation.
 	 *
-	 * Now we will give some score to it.  Let's say 20% edit gets
-	 * 5000 points and 0% edit gets 9000 points.  That is, every
-	 * 1/20000 edit gets 1 point penalty.  The amount of penalty is:
+	 * Now we will give some score to it.  100% edit gets
+	 * 0 points and 0% edit gets MAX_SCORE points.  That is, every
+	 * 1/MAX_SCORE edit gets 1 point penalty.  The amount of penalty is:
 	 *
-	 * (delta_size * 2 / (src->size + dst->size)) * 20000
+	 * (delta_size * 2 / (src->size + dst->size)) * MAX_SCORE
 	 *
 	 */
-	return 9000 - (40000 * delta_size / (src->size+dst->size));
+	score = MAX_SCORE-(MAX_SCORE*2*delta_size/(src->size+dst->size));
+	if (score < 0) return 0;
+	if (MAX_SCORE < score) return MAX_SCORE;
+	return score;
 }
 
 struct diff_score {
@@ -596,14 +611,15 @@ static int score_compare(const void *a_,
 }
 
 static void flush_rename_pair(struct diff_spec_hold *src,
-			      struct diff_spec_hold *dst)
+			      struct diff_spec_hold *dst,
+			      int rename_score)
 {
 	src->flags |= MATCHED;
 	dst->flags |= MATCHED;
 	free_data(src);
 	free_data(dst);
 	run_external_diff(src->path, dst->path,
-			  &src->it, &dst->it);
+			  &src->it, &dst->it, rename_score);
 }
 
 static void free_held_diff(struct diff_spec_hold *list)
@@ -637,7 +653,7 @@ void diff_flush(void)
 				continue;
 			if (! is_exact_match(src, dst))
 				continue;
-			flush_rename_pair(src, dst);
+			flush_rename_pair(src, dst, MAX_SCORE);
 			break;
 		}
 	}
@@ -670,7 +686,7 @@ void diff_flush(void)
 		}
 		c++;
 	}
-	qsort(mx, num_create*num_delete, sizeof(*mx), score_compare); 
+	qsort(mx, num_create*num_delete, sizeof(*mx), score_compare);
 
 #if 0
  	for (c = 0; c < num_create * num_delete; c++) {
@@ -689,9 +705,9 @@ void diff_flush(void)
 		dst = mx[c].dst;
 		if ((src->flags & MATCHED) || (dst->flags & MATCHED))
 			continue;
-		if (mx[c].score < diff_rename_minimum_score)
+		if (mx[c].score < minimum_score)
 			break;
-		flush_rename_pair(src, dst);
+		flush_rename_pair(src, dst, mx[c].score);
 	}
 	free(mx);
 
@@ -703,7 +719,26 @@ void diff_flush(void)
 	createdfile = deletedfile = NULL;
 }
 
+int diff_scoreopt_parse(const char *opt)
+{
+	int diglen, num, scale, i;
+	if (opt[0] != '-' || opt[1] != 'M')
+		return -1; /* that is not -M option */
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
 void diff_setup(int detect_rename_, int minimum_score_, int reverse_diff_,
+		int diff_raw_output_,
 		const char **pathspec_, int speccnt_)
 {
 	free_held_diff(createdfile);
@@ -713,8 +748,14 @@ void diff_setup(int detect_rename_, int 
 	detect_rename = detect_rename_;
 	reverse_diff = reverse_diff_;
 	pathspec = pathspec_;
+	diff_raw_output = diff_raw_output_;
 	speccnt = speccnt_;
-	diff_rename_minimum_score = minimum_score_ ? : MINIMUM_SCORE;
+	minimum_score = minimum_score_ ? : DEFAULT_MINIMUM_SCORE;
+}
+
+static const char *git_object_type(unsigned mode)
+{
+	return S_ISDIR(mode) ? "tree" : "blob";
 }
 
 void diff_addremove(int addremove, unsigned mode,
@@ -724,6 +765,21 @@ void diff_addremove(int addremove, unsig
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2], *one, *two;
 
+	if (0 <= diff_raw_output) {
+		if (!path)
+			path = "";
+		if (reverse_diff)
+			addremove = (addremove == '+' ? '-' : '+');
+		printf("%c%06o %s %s %s%s%c",
+		       addremove,
+		       mode,
+		       git_object_type(mode), sha1_to_hex(sha1),
+		       base, path, diff_raw_output);
+		return;
+	}
+	if (S_ISDIR(mode))
+		return;
+
 	memcpy(spec[0].blob_sha1, sha1, 20);
 	spec[0].mode = mode;
 	spec[0].sha1_valid = !!memcmp(sha1, null_sha1, 20);
@@ -750,6 +806,29 @@ void diff_change(unsigned old_mode, unsi
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2];
 
+	if (0 <= diff_raw_output) {
+		char old_hex[41];
+		strcpy(old_hex, sha1_to_hex(old_sha1));
+
+		if (!path)
+			path = "";
+		if (reverse_diff)
+			printf("*%06o->%06o %s %s->%s %s%s%c",
+			       new_mode, old_mode,
+			       git_object_type(new_mode),
+			       sha1_to_hex(new_sha1), old_hex,
+			       base, path, diff_raw_output);
+		else
+			printf("*%06o->%06o %s %s->%s %s%s%c",
+			       old_mode, new_mode,
+			       git_object_type(new_mode),
+			       old_hex, sha1_to_hex(new_sha1),
+			       base, path, diff_raw_output);
+		return;
+	}
+	if (S_ISDIR(new_mode))
+		return;
+
 	if (path) {
 		strcpy(concatpath, base);
 		strcat(concatpath, path);
@@ -766,10 +845,15 @@ void diff_change(unsigned old_mode, unsi
 	/* We do not look at changed files as candidate for
 	 * rename detection ever.
 	 */
-	run_external_diff(path ? concatpath : base, NULL, &spec[0], &spec[1]);
+	run_external_diff(path ? concatpath : base, NULL,
+			  &spec[0], &spec[1], -1);
 }
 
 void diff_unmerge(const char *path)
 {
-	run_external_diff(path, NULL, NULL, NULL);
+	if (0 <= diff_raw_output) {
+		printf("U %s%c", path, diff_raw_output);
+		return;
+	}
+	run_external_diff(path, NULL, NULL, NULL, -1);
 }
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -17,8 +17,10 @@ extern void diff_change(unsigned mode1, 
 
 extern void diff_unmerge(const char *path);
 
+extern int diff_scoreopt_parse(const char *opt);
+
 extern void diff_setup(int detect_rename, int minimum_score,
-		       int reverse,
+		       int reverse, int raw_output,
 		       const char **spec, int cnt);
 
 extern void diff_flush(void);
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -166,7 +166,7 @@ cat >expected <<\EOF
 EOF
 test_expect_success \
     'validate git-diff-files output for a know cache/work tree state.' \
-    'git-diff-files >current && cmp -s current expected'
+    'git-diff-files >current && diff >/dev/null -b current expected'
 
 test_expect_success \
     'git-update-cache --refresh should succeed.' \
diff --git a/t/t0110-environment-names-old.sh b/t/t0110-environment-names-old.sh
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
diff --git a/t/t2002-checkout-cache-u.sh b/t/t2002-checkout-cache-u.sh
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -29,3 +29,5 @@ rm -f path0 &&
 git-read-tree $t &&
 git-checkout-cache -u -f -a &&
 git-diff-files | diff - /dev/null'
+
+test_done
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -58,3 +58,9 @@ rename new path1
  Line 13
  Line 14
 EOF
+
+test_expect_success \
+    'validate the output.' \
+    'diff -I "rename similarity.*" >/dev/null current expected'
+
+test_done
------------------------------------------------

