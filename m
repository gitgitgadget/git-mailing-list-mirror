From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 03:32:35 -0700
Message-ID: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 12:36:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYiNn-00048U-PH
	for gcvg-git@gmane.org; Thu, 19 May 2005 12:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVESKgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 06:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVESKgr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 06:36:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:13285 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261768AbVESKch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 06:32:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519103236.GUGN1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 06:32:36 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch rips out the rename detection engine from diff-helper
and moves it to the diff core, and updates the internal calling
convention used by diff-tree family into the diff core.  In
order to give the same option name to diff-tree family as well
as to diff-helper, I've changed the earlier diff-helper '-r'
option to '-M' (stands for Move; sorry but the natural
abbreviation 'r' for 'rename' is already taken for 'recursive').

Although I did a fair amount of test with the git-diff-tree with
existing rename commits in the core GIT repository, this should
still be considered beta (preview) release.  This patch depends
on the diff-delta patch I stole from Nico.  Please give it a
good beating.

Special request for Linus is to check if I did not screw up the
various calls into the diff core from diff-tree.  Essentially
the idea is to start one patchset session with diff_setup() and
close it with diff_flush() before you start another patchset
session.

This implements almost everything I wanted to see in this series
of patch, except a few minor cleanups in the calling convention
into diff core, but that will be a separate cleanup patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-cache.txt  |    5 
Documentation/git-diff-files.txt  |    5 
Documentation/git-diff-helper.txt |    4 
Documentation/git-diff-tree.txt   |    5 
diff-cache.c                      |   16 +
diff-files.c                      |   11 -
diff-helper.c                     |  209 ++-----------------
diff-tree.c                       |   25 +-
diff.c                            |  410 +++++++++++++++++++++++++++++++++++---
diff.h                            |   19 -
git-apply-patch-script            |    3 
t/t4001-diff-rename.sh            |   60 +++++
12 files changed, 533 insertions(+), 239 deletions(-)
t/t4001-diff-rename.sh (. --> 100644)

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [--cached] <tree-ish>
+'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [--cached] <tree-ish>
 
 DESCRIPTION
 -----------
@@ -33,6 +33,9 @@
 -z::
 	\0 line termination on output
 
+-M::
+	Detect renames; implies -p.
+
 --cached::
 	do not consider the on-disk file at all
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-M] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -26,6 +26,9 @@
 -q::
 	Remain silent even on nonexisting files
 
+-M::
+	Detect renames; implies -p.
+
 -r::
 	This flag does not mean anything.  It is there only to match
 	git-diff-tree.  Unlike git-diff-tree, git-diff-files always looks
diff --git a/Documentation/git-diff-helper.txt b/Documentation/git-diff-helper.txt
--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-diff-helper' [-z] [-R] [-r]
+'git-diff-helper' [-z] [-R] [-M]
 
 DESCRIPTION
 -----------
@@ -31,7 +31,7 @@
 	would show a diff to bring the working file back to what
 	is in the <tree>.
 
--r::
+-M::
 	Detect renames.
 
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -33,6 +33,9 @@
 	generate patch (see section on generating patches).  For
 	git-diff-tree, this flag implies '-r' as well.
 
+-M::
+	Detect renames; implies -p, in turn implying also '-r'.
+
 -r::
 	recurse
 
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -5,6 +5,7 @@
 static int generate_patch = 0;
 static int match_nonexisting = 0;
 static int line_termination = '\n';
+static int detect_rename = 0;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
@@ -165,13 +166,14 @@
 }
 
 static char *diff_cache_usage =
-"git-diff-cache [-p] [-r] [-z] [-m] [--cached] <tree sha1>";
+"git-diff-cache [-p] [-r] [-z] [-m] [-M] [--cached] <tree-ish>";
 
 int main(int argc, char **argv)
 {
 	unsigned char tree_sha1[20];
 	void *tree;
 	unsigned long size;
+	int ret;
 
 	read_cache();
 	while (argc > 2) {
@@ -186,6 +188,10 @@
 			generate_patch = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-M")) {
+			generate_patch = detect_rename = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = '\0';
 			continue;
@@ -204,6 +210,9 @@
 	if (argc != 2 || get_sha1(argv[1], tree_sha1))
 		usage(diff_cache_usage);
 
+	if (generate_patch)
+		diff_setup(detect_rename, 0, 0, 0, 0);
+
 	mark_merge_entries();
 
 	tree = read_object_with_reference(tree_sha1, "tree", &size, 0);
@@ -212,5 +221,8 @@
 	if (read_tree(tree, size, 1))
 		die("unable to read tree object %s", argv[1]);
 
-	return diff_cache(active_cache, active_nr);
+	ret = diff_cache(active_cache, active_nr);
+	if (generate_patch)
+		diff_flush();
+	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -7,10 +7,11 @@
 #include "diff.h"
 
 static const char *diff_files_usage =
-"diff-files [-p] [-q] [-r] [-z] [paths...]";
+"diff-files [-p] [-q] [-r] [-z] [-M] [paths...]";
 
 static int generate_patch = 0;
 static int line_termination = '\n';
+static int detect_rename = 0;
 static int silent = 0;
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
@@ -79,6 +80,9 @@
 			; /* no-op */
 		else if (!strcmp(argv[1], "-z"))
 			line_termination = 0;
+		else if (!strcmp(argv[1], "-M")) {
+			detect_rename = generate_patch = 1;
+		}
 		else
 			usage(diff_files_usage);
 		argv++; argc--;
@@ -92,6 +96,9 @@
 		exit(1);
 	}
 
+	if (generate_patch)
+		diff_setup(detect_rename, 0, 0, 0, 0);		
+
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		unsigned int oldmode, mode;
@@ -132,5 +139,7 @@
 		show_modified(oldmode, mode, ce->sha1, null_sha1,
 			      ce->name);
 	}
+	if (generate_patch)
+		diff_flush();
 	return 0;
 }
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -6,160 +6,23 @@
 #include "strbuf.h"
 #include "diff.h"
 
-static int matches_pathspec(const char *name, const char **spec, int cnt)
-{
-	int i;
-	int namelen = strlen(name);
-	for (i = 0; i < cnt; i++) {
-		int speclen = strlen(spec[i]);
-		if (! strncmp(spec[i], name, speclen) &&
-		    speclen <= namelen &&
-		    (name[speclen] == 0 ||
-		     name[speclen] == '/'))
-			return 1;
-	}
-	return 0;
-}
-
 static int detect_rename = 0;
 
-/*
- * We do not detect circular renames.  Just hold created and deleted
- * entries and later attempt to match them up.  If they do not match,
- * then spit them out as deletes or creates as original.
- */
-
-static struct diff_spec_hold {
-	struct diff_spec_hold *next;
-	struct diff_spec_hold *matched;
-	struct diff_spec old, new;
-	char path[1];
-} *createdfile, *deletedfile;
-
-static void hold_spec(const char *path,
-		      struct diff_spec *old, struct diff_spec *new)
-{
-	struct diff_spec_hold **list, *elem;
-	list = (! old->file_valid) ? &createdfile : &deletedfile;
-	elem = xmalloc(sizeof(*elem) + strlen(path));
-	strcpy(elem->path, path);
-	elem->next = *list;
-	*list = elem;
-	elem->old = *old;
-	elem->new = *new;
-	elem->matched = 0;
-}
-
-#define MINIMUM_SCORE 7000
-int estimate_similarity(struct diff_spec *one, struct diff_spec *two)
-{
-	/* Return how similar they are, representing the score as an
-	 * integer between 0 and 10000.
-	 *
-	 * This version is very dumb and detects exact matches only.
-	 * Wnen Nico's delta stuff gets in, I'll use the delta
-	 * algorithm to estimate the similarity score in core.
-	 */
-
-	if (one->sha1_valid && two->sha1_valid &&
-	    !memcmp(one->blob_sha1, two->blob_sha1, 20))
-		return 10000;
-	return 0;
-}
-
-static void flush_renames(const char **spec, int cnt, int reverse)
-{
-	struct diff_spec_hold *rename_src, *rename_dst, *elem;
-	struct diff_spec_hold *leftover = NULL;
-	int score, best_score;
-
-	while (createdfile) {
-		rename_dst = createdfile;
-		createdfile = rename_dst->next;
-		best_score = MINIMUM_SCORE;
-		rename_src = NULL;
-		for (elem = deletedfile;
-		     elem;
-		     elem = elem->next) {
-			if (elem->matched)
-				continue;
-			score = estimate_similarity(&elem->old,
-						    &rename_dst->new);
-			if (best_score < score) {
-				rename_src = elem;
-				best_score = score;
-			}
-		}
-		if (rename_src) {
-			rename_src->matched = rename_dst;
-			rename_dst->matched = rename_src;
-
-			if (!cnt ||
-			    matches_pathspec(rename_src->path, spec, cnt) ||
-			    matches_pathspec(rename_dst->path, spec, cnt)) {
-				if (reverse)
-					run_external_diff(rename_dst->path,
-							  rename_src->path,
-							  &rename_dst->new,
-							  &rename_src->old);
-				else
-					run_external_diff(rename_src->path,
-							  rename_dst->path,
-							  &rename_src->old,
-							  &rename_dst->new);
-			}
-		}
-		else {
-			rename_dst->next = leftover;
-			leftover = rename_dst;
-		}
-	}
-
-	/* unmatched deletes */
-	for (elem = deletedfile; elem; elem = elem->next) {
-		if (elem->matched)
-			continue;
-		if (!cnt ||
-		    matches_pathspec(elem->path, spec, cnt)) {
-			if (reverse)
-				run_external_diff(elem->path, NULL,
-						  &elem->new, &elem->old);
-			else
-				run_external_diff(elem->path, NULL,
-						  &elem->old, &elem->new);
-		}
-	}
-
-	/* unmatched creates */
-	for (elem = leftover; elem; elem = elem->next) {
-		if (!cnt ||
-		    matches_pathspec(elem->path, spec, cnt)) {
-			if (reverse)
-				run_external_diff(elem->path, NULL,
-						  &elem->new, &elem->old);
-			else
-				run_external_diff(elem->path, NULL,
-						  &elem->old, &elem->new);
-		}
-	}
-}
-
-static int parse_oneside_change(const char *cp, struct diff_spec *one,
-				char *path)
+static int parse_oneside_change(const char *cp, int *mode,
+				unsigned char *sha1, char *path)
 {
-	int ch;
+	int ch, m;
 
-	one->file_valid = one->sha1_valid = 1;
-	one->mode = 0;
+	m = 0;
 	while ((ch = *cp) && '0' <= ch && ch <= '7') {
-		one->mode = (one->mode << 3) | (ch - '0');
+		m = (m << 3) | (ch - '0');
 		cp++;
 	}
-
+	*mode = m;
 	if (strncmp(cp, "\tblob\t", 6))
 		return -1;
 	cp += 6;
-	if (get_sha1_hex(cp, one->blob_sha1))
+	if (get_sha1_hex(cp, sha1))
 		return -1;
 	cp += 40;
 	if (*cp++ != '\t')
@@ -168,79 +31,63 @@
 	return 0;
 }
 
-static int parse_diff_raw_output(const char *buf,
-				 const char **spec, int cnt, int reverse)
+static int parse_diff_raw_output(const char *buf)
 {
-	struct diff_spec old, new;
 	char path[PATH_MAX];
+	unsigned char old_sha1[20], new_sha1[20];
 	const char *cp = buf;
-	int ch;
+	int ch, old_mode, new_mode;
 
 	switch (*cp++) {
 	case 'U':
-		if (!cnt || matches_pathspec(cp + 1, spec, cnt))
-			diff_unmerge(cp + 1);
-		return 0;
+		diff_unmerge(cp + 1);
+		break;
 	case '+':
-		old.file_valid = 0;
-		parse_oneside_change(cp, &new, path);
+		parse_oneside_change(cp, &new_mode, new_sha1, path);
+		diff_addremove('+', new_mode, new_sha1, path, NULL);
 		break;
 	case '-':
-		new.file_valid = 0;
-		parse_oneside_change(cp, &old, path);
+		parse_oneside_change(cp, &old_mode, old_sha1, path);
+		diff_addremove('-', old_mode, old_sha1, path, NULL);
 		break;
 	case '*':
-		old.file_valid = old.sha1_valid =
-			new.file_valid = new.sha1_valid = 1;
-		old.mode = new.mode = 0;
+		old_mode = new_mode = 0;
 		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-			old.mode = (old.mode << 3) | (ch - '0');
+			old_mode = (old_mode << 3) | (ch - '0');
 			cp++;
 		}
 		if (strncmp(cp, "->", 2))
 			return -1;
 		cp += 2;
 		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-			new.mode = (new.mode << 3) | (ch - '0');
+			new_mode = (new_mode << 3) | (ch - '0');
 			cp++;
 		}
 		if (strncmp(cp, "\tblob\t", 6))
 			return -1;
 		cp += 6;
-		if (get_sha1_hex(cp, old.blob_sha1))
+		if (get_sha1_hex(cp, old_sha1))
 			return -1;
 		cp += 40;
 		if (strncmp(cp, "->", 2))
 			return -1;
 		cp += 2;
-		if (get_sha1_hex(cp, new.blob_sha1))
+		if (get_sha1_hex(cp, new_sha1))
 			return -1;
 		cp += 40;
 		if (*cp++ != '\t')
 			return -1;
 		strcpy(path, cp);
+		diff_change(old_mode, new_mode, old_sha1, new_sha1, path, 0);
 		break;
 	default:
 		return -1;
 	}
-
-	if (detect_rename && old.file_valid != new.file_valid) {
-		/* hold these */
-		hold_spec(path, &old, &new);
-		return 0;
-	}
-
-	if (!cnt || matches_pathspec(path, spec, cnt)) {
-		if (reverse)
-			run_external_diff(path, NULL, &new, &old);
-		else
-			run_external_diff(path, NULL, &old, &new);
-	}
 	return 0;
 }
 
 static const char *diff_helper_usage =
-	"git-diff-helper [-r] [-R] [-z] paths...";
+	"git-diff-helper [-z] [-R] [-M] paths...";
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
@@ -254,7 +101,7 @@
 			reverse = 1;
 		else if (av[1][1] == 'z')
 			line_termination = 0;
-		else if (av[1][1] == 'r')
+		else if (av[1][1] == 'M')
 			detect_rename = 1;
 		else
 			usage(diff_helper_usage);
@@ -262,18 +109,20 @@
 	}
 	/* the remaining parameters are paths patterns */
 
+	diff_setup(detect_rename, 0, reverse, av+1, ac-1);
+
 	while (1) {
 		int status;
 		read_line(&sb, stdin, line_termination);
 		if (sb.eof)
 			break;
-		status = parse_diff_raw_output(sb.buf, av+1, ac-1, reverse);
+		status = parse_diff_raw_output(sb.buf);
 		if (status) {
-			flush_renames(av+1, ac-1, reverse);
+			diff_flush();
 			printf("%s%c", sb.buf, line_termination);
 		}
 	}
 
-	flush_renames(av+1, ac-1, reverse);
+	diff_flush();
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -9,6 +9,7 @@
 static int read_stdin = 0;
 static int line_termination = '\n';
 static int generate_patch = 0;
+static int detect_rename = 0;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
@@ -281,6 +282,18 @@
 	return retval;
 }
 
+static int diff_tree_sha1_top(const unsigned char *old,
+			      const unsigned char *new, const char *base)
+{
+	int ret;
+	if (generate_patch)
+		diff_setup(detect_rename, 0, 0, 0, 0);
+	ret = diff_tree_sha1(old, new, base);
+	if (generate_patch)
+		diff_flush();
+	return ret;
+}
+
 static int get_one_line(const char *msg, unsigned long len)
 {
 	int ret = 0;
@@ -377,7 +390,7 @@
 		if (get_sha1_hex(buf + offset + 7, parent))
 			return -1;
 		header = generate_header(name, sha1_to_hex(parent), buf, size);
-		diff_tree_sha1(parent, commit, "");
+		diff_tree_sha1_top(parent, commit, "");
 		if (!header && verbose_header)
 			header_prefix = "\ndiff-tree ";
 		offset += 48;
@@ -401,14 +414,14 @@
 		line[81] = 0;
 		sprintf(this_header, "%s (from %s)\n", line, line+41);
 		header = this_header;
-		return diff_tree_sha1(parent, commit, "");
+		return diff_tree_sha1_top(parent, commit, "");
 	}
 	line[40] = 0;
 	return diff_tree_commit(commit, line);
 }
 
 static char *diff_tree_usage =
-"diff-tree [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] <tree sha1> <tree sha1>";
+"diff-tree [-p] [-r] [-z] [--stdin] [-M] [-m] [-s] [-v] <tree-ish> <tree-ish>";
 
 int main(int argc, char **argv)
 {
@@ -447,6 +460,10 @@
 			recursive = generate_patch = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-M")) {
+			detect_rename = recursive = generate_patch = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = '\0';
 			continue;
@@ -490,7 +507,7 @@
 		diff_tree_commit(sha1[0], NULL);
 		break;
 	case 2:
-		diff_tree_sha1(sha1[0], sha1[1], "");
+		diff_tree_sha1_top(sha1[0], sha1[1], "");
 		break;
 	}
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -7,8 +7,10 @@
 #include <limits.h>
 #include "cache.h"
 #include "diff.h"
+#include "delta.h"
 
 static const char *diff_opts = "-pu";
+static unsigned char null_sha1[20] = { 0, };
 
 static const char *external_diff(void)
 {
@@ -79,6 +81,18 @@
 	char tmp_path[50];
 } diff_temp[2];
 
+struct diff_spec {
+	unsigned char blob_sha1[20];
+	unsigned short mode;	 /* file mode */
+	unsigned sha1_valid : 1; /* if true, use blob_sha1 and trust mode;
+				  * however with a NULL SHA1, read them
+				  * from the file system.
+				  * if false, use the name and read mode from
+				  * the filesystem.
+				  */
+	unsigned file_valid : 1; /* if false the file does not even exist */
+};
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_tempfile *temp)
@@ -160,7 +174,7 @@
 	struct cache_entry *ce;
 	struct stat st;
 	int pos, len;
-	
+
 	/* We do not read the cache ourselves here, because the
 	 * benchmark with my previous version that always reads cache
 	 * shows that it makes things worse for diff-tree comparing
@@ -214,9 +228,6 @@
 			      struct diff_tempfile *temp,
 			      struct diff_spec *one)
 {
-	static unsigned char null_sha1[20] = { 0, };
-	int use_work_tree = 0;
-
 	if (!one->file_valid) {
 	not_a_valid_file:
 		/* A '-' entry produces this for file-2, and
@@ -228,12 +239,8 @@
 		return;
 	}
 
-	if (one->sha1_valid &&
-	    (!memcmp(one->blob_sha1, null_sha1, sizeof(null_sha1)) ||
-	     work_tree_matches(name, one->blob_sha1)))
-		use_work_tree = 1;
-
-	if (!one->sha1_valid || use_work_tree) {
+	if (!one->sha1_valid ||
+	    work_tree_matches(name, one->blob_sha1)) {
 		struct stat st;
 		temp->name = name;
 		if (lstat(temp->name, &st) < 0) {
@@ -295,22 +302,59 @@
 	remove_tempfile();
 }
 
+static int detect_rename;
+static int reverse_diff;
+static const char **pathspec;
+static int speccnt;
+static int diff_rename_minimum_score;
+
+static int matches_pathspec(const char *name)
+{
+	int i;
+	int namelen;
+
+	if (speccnt == 0)
+		return 1;
+
+	namelen = strlen(name);
+	for (i = 0; i < speccnt; i++) {
+		int speclen = strlen(pathspec[i]);
+		if (! strncmp(pathspec[i], name, speclen) &&
+		    speclen <= namelen &&
+		    (name[speclen] == 0 || name[speclen] == '/'))
+			return 1;
+	}
+	return 0;
+}
+
 /* An external diff command takes:
  *
  * diff-cmd name infile1 infile1-sha1 infile1-mode \
- *               infile2 infile2-sha1 infile2-mode.
+ *               infile2 infile2-sha1 infile2-mode [ rename-to ]
  *
  */
-void run_external_diff(const char *name,
-		       const char *other,
-		       struct diff_spec *one,
-		       struct diff_spec *two)
+static void run_external_diff(const char *name,
+			      const char *other,
+			      struct diff_spec *one,
+			      struct diff_spec *two)
 {
 	struct diff_tempfile *temp = diff_temp;
 	pid_t pid;
 	int status;
 	static int atexit_asked = 0;
 
+	if (reverse_diff) {
+		struct diff_spec *tmp_spec;
+		tmp_spec = one; one = two; two = tmp_spec;
+		if (other) {
+			const char *tmp;
+			tmp = name; name = other; other = tmp;
+		}
+	}
+
+	if (!matches_pathspec(name) && (!other || !matches_pathspec(other)))
+		return;
+
 	if (one && two) {
 		prepare_temp_file(name, &temp[0], one);
 		prepare_temp_file(other ? : name, &temp[1], two);
@@ -329,14 +373,23 @@
 		die("unable to fork");
 	if (!pid) {
 		const char *pgm = external_diff();
-		/* not passing rename patch to external ones */
-		if (!other && pgm) {
-			if (one && two)
-				execlp(pgm, pgm,
-				       name,
-				       temp[0].name, temp[0].hex, temp[0].mode,
-				       temp[1].name, temp[1].hex, temp[1].mode,
-				       NULL);
+		if (pgm) {
+			if (one && two) {
+				const char *exec_arg[9];
+				const char **arg = &exec_arg[0];
+				*arg++ = pgm;
+				*arg++ = name;
+				*arg++ = temp[0].name;
+				*arg++ = temp[0].hex;
+				*arg++ = temp[0].mode;
+				*arg++ = temp[1].name;
+				*arg++ = temp[1].hex;
+				*arg++ = temp[1].mode;
+				if (other)
+					*arg++ = other;
+				*arg = 0;
+				execvp(pgm, (char *const*) exec_arg);
+			}
 			else
 				execlp(pgm, pgm, name, NULL);
 		}
@@ -367,6 +420,293 @@
 	remove_tempfile();
 }
 
+/*
+ * We do not detect circular renames.  Just hold created and deleted
+ * entries and later attempt to match them up.  If they do not match,
+ * then spit them out as deletes or creates as original.
+ */
+
+static struct diff_spec_hold {
+	struct diff_spec_hold *next;
+	struct diff_spec it;
+	unsigned long size;
+	int flags;
+#define MATCHED 1
+#define SHOULD_FREE 2
+#define SHOULD_MUNMAP 4
+	void *data;
+	char path[1];
+} *createdfile, *deletedfile;
+
+static void hold_diff(const char *name,
+		      struct diff_spec *one,
+		      struct diff_spec *two)
+{
+	struct diff_spec_hold **list, *elem;
+
+	if (one->file_valid && two->file_valid)
+		die("internal error");
+
+	if (!detect_rename) {
+		run_external_diff(name, NULL, one, two);
+		return;
+	}
+	elem = xmalloc(sizeof(*elem) + strlen(name));
+	strcpy(elem->path, name);
+	elem->size = 0;
+	elem->data = NULL;
+	elem->flags = 0;
+	if (one->file_valid) {
+		list = &deletedfile;
+		elem->it = *one;
+	}
+	else {
+		list = &createdfile;
+		elem->it = *two;
+	}
+	elem->next = *list;
+	*list = elem;
+}
+
+static int populate_data(struct diff_spec_hold *s)
+{
+	char type[20];
+
+	if (s->data)
+		return 0;
+	if (s->it.sha1_valid) {
+		s->data = read_sha1_file(s->it.blob_sha1, type, &s->size);
+		s->flags |= SHOULD_FREE;
+	}
+	else {
+		struct stat st;
+		int fd;
+		fd = open(s->path, O_RDONLY);
+		if (fd < 0)
+			return -1;
+		if (fstat(fd, &st)) {
+			close(fd);
+			return -1;
+		}
+		s->size = st.st_size;
+		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		close(fd);
+		if (!s->size)
+			s->data = "";
+		else
+			s->flags |= SHOULD_MUNMAP;
+	}
+	return 0;
+}
+
+static void free_data(struct diff_spec_hold *s)
+{
+	if (s->flags & SHOULD_FREE)
+		free(s->data);
+	else if (s->flags & SHOULD_MUNMAP)
+		munmap(s->data, s->size);
+	s->flags &= ~(SHOULD_FREE|SHOULD_MUNMAP);
+}
+
+static void flush_remaining_diff(struct diff_spec_hold *elem,
+				 int on_created_list)
+{
+	static struct diff_spec null_file_spec;
+
+	null_file_spec.file_valid = 0;
+	for ( ; elem ; elem = elem->next) {
+		free_data(elem);
+		if (elem->flags & MATCHED)
+			continue;
+		if (on_created_list)
+			run_external_diff(elem->path, NULL,
+					  &null_file_spec, &elem->it);
+		else
+			run_external_diff(elem->path, NULL,
+					  &elem->it, &null_file_spec);
+	}
+}
+
+static int is_exact_match(struct diff_spec_hold *src,
+			  struct diff_spec_hold *dst)
+{
+	if (src->it.sha1_valid && dst->it.sha1_valid &&
+	    !memcmp(src->it.blob_sha1, dst->it.blob_sha1, 20))
+		return 1;
+	if (populate_data(src) || populate_data(dst))
+		/* this is an error but will be caught downstream */
+		return 0;
+	if (src->size == dst->size &&
+	    !memcmp(src->data, dst->data, src->size))
+		return 1;
+	return 0;
+}
+
+#define MINIMUM_SCORE 5000
+int estimate_similarity(struct diff_spec_hold *src, struct diff_spec_hold *dst)
+{
+	/* src points at a deleted file and dst points at a created
+	 * file.  They may be quite similar, in which case we want to
+	 * say src is renamed to dst.
+	 *
+	 * Compare them and return how similar they are, representing
+	 * the score as an integer between 0 and 10000.  10000 is
+	 * reserved for the case where they match exactly.
+	 */
+	void *delta;
+	unsigned long delta_size;
+
+	delta_size = ((src->size < dst->size) ?
+		      (dst->size - src->size) : (src->size - dst->size));
+
+	/* We would not consider rename followed by more than
+	 * 20% edits; that is, delta_size must be smaller than
+	 * (src->size + dst->size)/2 * 0.2, which means...
+	 */
+	if ((src->size + dst->size) < delta_size * 10)
+		return 0;
+
+	delta = diff_delta(src->data, src->size,
+			   dst->data, dst->size,
+			   &delta_size);
+	free(delta);
+
+	/* This "delta" is really xdiff with adler32 and all the
+	 * overheads but it is a quick and dirty approximation.
+	 *
+	 * Now we will give some score to it.  Let's say 20% edit gets
+	 * 5000 points and 0% edit gets 9000 points.  That is, every
+	 * 1/20000 edit gets 1 point penalty.  The amount of penalty is:
+	 *
+	 * (delta_size * 2 / (src->size + dst->size)) * 20000
+	 *
+	 */
+	return 9000 - (40000 * delta_size / (src->size+dst->size));
+}
+
+struct diff_score {
+	struct diff_spec_hold *src;
+	struct diff_spec_hold *dst;
+	int score;
+};
+
+static int score_compare(const void *a_, const void *b_)
+{
+	const struct diff_score *a = a_, *b = b_;
+	return b->score - a->score;
+}
+
+static void flush_rename_pair(struct diff_spec_hold *src,
+			      struct diff_spec_hold *dst)
+{
+	src->flags |= MATCHED;
+	dst->flags |= MATCHED;
+	free_data(src);
+	free_data(dst);
+	run_external_diff(src->path, dst->path,
+			  &src->it, &dst->it);
+}
+
+static void free_held_diff(struct diff_spec_hold *list)
+{
+	struct diff_spec_hold *h;
+	for (h = list; list; list = h) {
+		h = list->next;
+		free_data(list);
+		free(list);
+	}
+}
+
+void diff_flush(void)
+{
+	int num_create, num_delete, c, d;
+	struct diff_spec_hold *elem, *src, *dst;
+	struct diff_score *mx;
+
+	/* We really want to cull the candidates list early
+	 * with cheap tests in order to avoid doing deltas.
+	 */
+	for (dst = createdfile; dst; dst = dst->next) {
+		for (src = deletedfile; src; src = src->next) {
+			if (! is_exact_match(src, dst))
+				continue;
+			flush_rename_pair(src, dst);
+			break;
+		}
+	}
+
+	/* Count surviving candidates */
+	for (num_create = 0, elem = createdfile; elem; elem = elem->next)
+		if (!(elem->flags & MATCHED))
+			num_create++;
+
+	for (num_delete = 0, elem = deletedfile; elem; elem = elem->next)
+		if (!(elem->flags & MATCHED))
+			num_delete++;
+
+	if (num_create == 0 ||  num_delete == 0)
+		goto exit_path;
+
+	mx = xmalloc(sizeof(*mx) * num_create * num_delete);
+	for (c = 0, dst = createdfile; dst; dst = dst->next) {
+		int base = c * num_delete;
+		if (dst->flags & MATCHED)
+			continue;
+		for (d = 0, src = deletedfile; src; src = src->next) {
+			struct diff_score *m = &mx[base+d];
+			if (src->flags & MATCHED)
+				continue;
+			m->src = src;
+			m->dst = dst;
+			m->score = estimate_similarity(src, dst);
+			d++;
+		}
+		c++;
+	}
+	qsort(mx, num_create*num_delete, sizeof(*mx), score_compare); 
+
+ 	for (c = 0; c < num_create * num_delete; c++) {
+		src = mx[c].src;
+		dst = mx[c].dst;
+		if ((src->flags & MATCHED) || (dst->flags & MATCHED))
+			continue;
+		fprintf(stderr,
+			"**score ** %d %s %s\n",
+			mx[c].score, src->path, dst->path);
+	}
+
+ 	for (c = 0; c < num_create * num_delete; c++) {
+		src = mx[c].src;
+		dst = mx[c].dst;
+		if ((src->flags & MATCHED) || (dst->flags & MATCHED))
+			continue;
+		if (mx[c].score < diff_rename_minimum_score)
+			break;
+		flush_rename_pair(src, dst);
+	}
+
+ exit_path:
+	flush_remaining_diff(createdfile, 1);
+	flush_remaining_diff(deletedfile, 0);
+	free_held_diff(createdfile);
+	free_held_diff(deletedfile);
+	createdfile = deletedfile = NULL;
+}
+
+void diff_setup(int detect_rename_, int minimum_score_, int reverse_diff_,
+		const char **pathspec_, int speccnt_)
+{
+	free_held_diff(createdfile);
+	free_held_diff(deletedfile);
+	createdfile = deletedfile = NULL;
+
+	detect_rename = detect_rename_;
+	reverse_diff = reverse_diff_;
+	pathspec = pathspec_;
+	speccnt = speccnt_;
+	diff_rename_minimum_score = minimum_score_ ? : MINIMUM_SCORE;
+}
+
 void diff_addremove(int addremove, unsigned mode,
 		    const unsigned char *sha1,
 		    const char *base, const char *path)
@@ -376,7 +716,8 @@
 
 	memcpy(spec[0].blob_sha1, sha1, 20);
 	spec[0].mode = mode;
-	spec[0].sha1_valid = spec[0].file_valid = 1;
+	spec[0].sha1_valid = !!memcmp(sha1, null_sha1, 20);
+	spec[0].file_valid = 1;
 	spec[1].file_valid = 0;
 
 	if (addremove == '+') {
@@ -384,12 +725,12 @@
 	} else {
 		one = spec; two = one + 1;
 	}
-	
+
 	if (path) {
 		strcpy(concatpath, base);
 		strcat(concatpath, path);
 	}
-	run_external_diff(path ? concatpath : base, NULL, one, two);
+	hold_diff(path ? concatpath : base, one, two);
 }
 
 void diff_change(unsigned old_mode, unsigned new_mode,
@@ -399,17 +740,22 @@
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2];
 
+	if (path) {
+		strcpy(concatpath, base);
+		strcat(concatpath, path);
+	}
+
 	memcpy(spec[0].blob_sha1, old_sha1, 20);
 	spec[0].mode = old_mode;
 	memcpy(spec[1].blob_sha1, new_sha1, 20);
 	spec[1].mode = new_mode;
-	spec[0].sha1_valid = spec[0].file_valid = 1;
-	spec[1].sha1_valid = spec[1].file_valid = 1;
+	spec[0].sha1_valid = !!memcmp(old_sha1, null_sha1, 20);
+	spec[1].sha1_valid = !!memcmp(new_sha1, null_sha1, 20);
+	spec[1].file_valid = spec[0].file_valid = 1;
 
-	if (path) {
-		strcpy(concatpath, base);
-		strcat(concatpath, path);
-	}
+	/* We do not look at changed files as candidate for
+	 * rename detection ever.
+	 */
 	run_external_diff(path ? concatpath : base, NULL, &spec[0], &spec[1]);
 }
 
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -17,21 +17,10 @@
 
 extern void diff_unmerge(const char *path);
 
-/* These are for diff-helper */
+extern void diff_setup(int detect_rename, int minimum_score,
+		       int reverse,
+		       const char **spec, int cnt);
 
-struct diff_spec {
-	unsigned char blob_sha1[20];
-	unsigned short mode;	 /* file mode */
-	unsigned sha1_valid : 1; /* if true, use blob_sha1 and trust mode;
-				  * however with a NULL SHA1, read them
-				  * from the file system.
-				  * if false, use the name and read mode from
-				  * the filesystem.
-				  */
-	unsigned file_valid : 1; /* if false the file does not even exist */
-};
-
-extern void run_external_diff(const char *name, const char *other,
-			      struct diff_spec *, struct diff_spec *);
+extern void diff_flush(void);
 
 #endif /* DIFF_H */
diff --git a/git-apply-patch-script b/git-apply-patch-script
--- a/git-apply-patch-script
+++ b/git-apply-patch-script
@@ -11,6 +11,9 @@
 1)
     echo >&2 "cannot handle unmerged diff on path $1."
     exit 1 ;;
+8)
+    echo >&2 "cannot handle rename diff between $1 and $8 yet."
+    exit 1 ;;
 esac
 name="$1" tmp1="$2" hex1="$3" mode1="$4" tmp2="$5" hex2="$6" mode2="$7"
 
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
new file mode 100644
--- /dev/null
+++ b/t/t4001-diff-rename.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Test rename detection in diff engine.
+
+'
+. ./test-lib.sh
+
+echo >path0 'Line 1
+Line 2
+Line 3
+Line 4
+Line 5
+Line 6
+Line 7
+Line 8
+Line 9
+Line 10
+line 11
+Line 12
+Line 13
+Line 14
+Line 15
+'
+
+test_expect_success \
+    'update-cache --add a file.' \
+    'git-update-cache --add path0'
+
+test_expect_success \
+    'write that tree.' \
+    'tree=$(git-write-tree)'
+
+sed -e 's/line/Line/' <path0 >path1
+rm -f path0
+test_expect_success \
+    'renamed and edited the file.' \
+    'git-update-cache --add --remove path0 path1'
+
+test_expect_success \
+    'git-diff-cache -p -M after rename and editing.' \
+    'git-diff-cache -p -M $tree >current'
+cat >expected <<\EOF
+diff --git a/path0 b/path1
+rename old path0
+rename new path1
+--- a/path0
++++ b/path1
+@@ -8,7 +8,7 @@ Line 7
+ Line 8
+ Line 9
+ Line 10
+-line 11
++Line 11
+ Line 12
+ Line 13
+ Line 14
+EOF
------------------------------------------------

