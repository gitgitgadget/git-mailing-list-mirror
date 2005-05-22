From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] The diff-raw format updates.
Date: Sat, 21 May 2005 19:42:18 -0700
Message-ID: <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
	<7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 04:43:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZgQX-0001Uz-1k
	for gcvg-git@gmane.org; Sun, 22 May 2005 04:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVEVCn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 22:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEVCn6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 22:43:58 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:46835 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261720AbVEVCmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 22:42:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522024217.PEFP7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 22:42:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v1x80dluj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 19:40:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update the diff-raw format as Linus and I discussed, except that
it does not use sequence of underscore '_' letters to express
nonexistence.  All '0' mode is used for that purpose instead.

The new diff-raw format can express rename/copy, and the earlier
restriction that -M and -C _must_ be used with the patch format
output is no longer necessary.  The patch makes -M and -C flags
independent of -p flag, so you need to say git-whatchanged -M -p
to get the diff/patch format.

Updated are both documentations and tests.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/diff-format.txt    |   29 +++--
Documentation/git-diff-cache.txt |    4 
Documentation/git-diff-files.txt |    4 
Documentation/git-diff-tree.txt  |    5 
diff-cache.c                     |   12 --
diff-files.c                     |   12 --
diff-helper.c                    |  153 ++++++++++++----------------
diff-tree.c                      |   13 +-
diff.c                           |  132 +++++++++++++-----------
diff.h                           |   12 ++
diffcore-pickaxe.c               |    6 -
diffcore-rename.c                |   20 +--
diffcore.h                       |    2 
t/t0000-basic.sh                 |   16 +-
t/t4002-diff-basic.sh            |  209 +++++++++++++++++++--------------------
t/t4003-diff-rename-1.sh         |    6 -
16 files changed, 322 insertions(+), 313 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -16,25 +16,30 @@ git-diff-tree [-r] <tree-ish-1> <tree-is
 git-diff-files [<pattern>...]::
         compares the cache and the files on the filesystem.
 
-The following desription uses "old" and "new" to mean those
-compared entities.
 
-For files in old but not in new (i.e. removed):
+An output line is formatted this way:
 
-    -<mode> \t <type> \t <object> \t <path>
+  ':' <mode> ' ' <mode> ' ' <sha1> ' ' <sha1> I <path> I <path> L
 
-For files not in old but in new (i.e. added):
+By default, I and L are '\t' and '\n' respectively.  When '-z'
+flag is in effect, both I and L are '\0'.
 
-    +<mode> \t <type> \t <object> \t <path>
+In each <mode>, <sha1> and <path> pair, left hand side describes
+the left hand side of what is being compared (<tree-ish> in
+git-diff-cache, <tree-ish-1> in git-diff-tree, cache contents in
+git-diff-files).  Non-existence is shown by having 000000 in the
+<mode> column.  That is, 000000 appears as the first <mode> for
+newly created files, and as the second <mode> for deleted files.
 
-For files that differ:
+Usually two <path> are the same.  When rename/copy detection is
+used, however, an "create" and another "delete" records can be
+merged into a single record that has two <path>, old name and
+new name.
 
-    *<old-mode>-><new-mode> \t <type> \t <old-sha1>-><new-sha1> \t <path>
+<sha1> is shown as all 0's if new is a file on the filesystem
+and it is out of sync with the cache.  Example:
 
-<new-sha1> is shown as all 0's if new is a file on the
-filesystem and it is out of sync with the cache.  Example:
-
-  *100644->100644 blob    5be4a4.......->000000.......      file.c
+  :100644 100644 5be4a4...... 000000......    file.c    file.c
 
 
 Generating patches with -p
diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -34,10 +34,10 @@ OPTIONS
 	\0 line termination on output
 
 -M::
-	Detect renames; implies -p.
+	Detect renames.
 
 -C::
-	Detect copies as well as renames; implies -p.
+	Detect copies as well as renames.
 
 -S<string>::
 	Look for differences that contains the change in <string>.
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -30,10 +30,10 @@ OPTIONS
 	Output diff in reverse.
 
 -M::
-	Detect renames; implies -p.
+	Detect renames.
 
 -C::
-	Detect copies as well as renames; implies -p.
+	Detect copies as well as renames.
 
 -S<string>::
 	Look for differences that contains the change in <string>.
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -34,11 +34,10 @@ OPTIONS
 	git-diff-tree, this flag implies '-r' as well.
 
 -M::
-	Detect renames; implies -p, in turn implying also '-r'.
+	Detect renames.
 
 -C::
-	Detect copies as well as renames; implies -p, in turn
-	implying also '-r'.
+	Detect copies as well as renames.
 
 -R::
 	Output diff in reverse.
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -2,9 +2,8 @@
 #include "diff.h"
 
 static int cached_only = 0;
-static int generate_patch = 0;
+static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int match_nonexisting = 0;
-static int line_termination = '\n';
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
@@ -174,22 +173,21 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-p")) {
-			generate_patch = 1;
+			diff_output_format = DIFF_FORMAT_PATCH;
 			continue;
 		}
 		if (!strncmp(arg, "-M", 2)) {
-			generate_patch = detect_rename = 1;
+			detect_rename = 1;
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
 		if (!strncmp(arg, "-C", 2)) {
-			generate_patch = 1;
 			detect_rename = 2;
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
-			line_termination = '\0';
+			diff_output_format = DIFF_FORMAT_MACHINE;
 			continue;
 		}
 		if (!strcmp(arg, "-R")) {
@@ -214,7 +212,7 @@ int main(int argc, char **argv)
 	if (argc != 2 || get_sha1(argv[1], tree_sha1))
 		usage(diff_cache_usage);
 
-	diff_setup(reverse_diff, (generate_patch ? -1 : line_termination));
+	diff_setup(reverse_diff, diff_output_format);
 
 	mark_merge_entries();
 
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -9,8 +9,7 @@
 static const char *diff_files_usage =
 "git-diff-files [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [paths...]";
 
-static int generate_patch = 0;
-static int line_termination = '\n';
+static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
@@ -57,7 +56,7 @@ int main(int argc, char **argv)
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-p"))
-			generate_patch = 1;
+			diff_output_format = DIFF_FORMAT_PATCH;
 		else if (!strcmp(argv[1], "-q"))
 			silent = 1;
 		else if (!strcmp(argv[1], "-r"))
@@ -65,19 +64,18 @@ int main(int argc, char **argv)
 		else if (!strcmp(argv[1], "-s"))
 			; /* no-op */
 		else if (!strcmp(argv[1], "-z"))
-			line_termination = 0;
+			diff_output_format = DIFF_FORMAT_MACHINE;
 		else if (!strcmp(argv[1], "-R"))
 			reverse_diff = 1;
 		else if (!strcmp(argv[1], "-S"))
 			pickaxe = argv[1] + 2;
 		else if (!strncmp(argv[1], "-M", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
-			detect_rename = generate_patch = 1;
+			detect_rename = 1;
 		}
 		else if (!strncmp(argv[1], "-C", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
 			detect_rename = 2;
-			generate_patch = 1;
 		}
 		else
 			usage(diff_files_usage);
@@ -92,7 +90,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	diff_setup(reverse_diff, (generate_patch ? -1 : line_termination));
+	diff_setup(reverse_diff, diff_output_format);
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -8,88 +8,51 @@
 
 static int detect_rename = 0;
 static int diff_score_opt = 0;
-static int generate_patch = 1;
 static const char *pickaxe = NULL;
+static int diff_output_style = DIFF_FORMAT_PATCH;
+static int line_termination = '\n';
+static int inter_name_termination = '\t';
 
-static int parse_oneside_change(const char *cp, int *mode,
-				unsigned char *sha1, char *path)
+static int parse_diff_raw(char *buf1, char *buf2, char *buf3)
 {
-	int ch, m;
+	char old_path[PATH_MAX];
+	unsigned char old_sha1[20], new_sha1[20];
+	char *ep;
+	char *cp = buf1;
+	int ch, old_mode, new_mode;
 
-	m = 0;
-	while ((ch = *cp) && '0' <= ch && ch <= '7') {
-		m = (m << 3) | (ch - '0');
+	old_mode = new_mode = 0;
+	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+		old_mode = (old_mode << 3) | (ch - '0');
+		cp++;
+	}
+	if (*cp++ != ' ')
+		return -1;
+	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+		new_mode = (new_mode << 3) | (ch - '0');
 		cp++;
 	}
-	*mode = m;
-	if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6) &&
-	    strncmp(cp, "\ttree\t", 6) && strncmp(cp, " tree ", 6))
+	if (*cp++ != ' ')
 		return -1;
-	cp += 6;
-	if (get_sha1_hex(cp, sha1))
+	if (get_sha1_hex(cp, old_sha1))
 		return -1;
 	cp += 40;
-	if ((*cp != '\t') && *cp != ' ')
+	if (*cp++ != ' ')
 		return -1;
-	strcpy(path, ++cp);
-	return 0;
-}
-
-static int parse_diff_raw_output(const char *buf)
-{
-	char path[PATH_MAX];
-	unsigned char old_sha1[20], new_sha1[20];
-	const char *cp = buf;
-	int ch, old_mode, new_mode;
-
-	switch (*cp++) {
-	case 'U':
-		diff_unmerge(cp + 1);
-		break;
-	case '+':
-		if (parse_oneside_change(cp, &new_mode, new_sha1, path))
-			return -1;
-		diff_addremove('+', new_mode, new_sha1, path, NULL);
-		break;
-	case '-':
-		if (parse_oneside_change(cp, &old_mode, old_sha1, path))
-			return -1;
-		diff_addremove('-', old_mode, old_sha1, path, NULL);
-		break;
-	case '*':
-		old_mode = new_mode = 0;
-		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-			old_mode = (old_mode << 3) | (ch - '0');
-			cp++;
-		}
-		if (strncmp(cp, "->", 2))
-			return -1;
-		cp += 2;
-		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-			new_mode = (new_mode << 3) | (ch - '0');
-			cp++;
-		}
-		if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6) &&
-		    strncmp(cp, "\ttree\t", 6) && strncmp(cp, " tree ", 6))
-			return -1;
-		cp += 6;
-		if (get_sha1_hex(cp, old_sha1))
-			return -1;
-		cp += 40;
-		if (strncmp(cp, "->", 2))
-			return -1;
-		cp += 2;
-		if (get_sha1_hex(cp, new_sha1))
-			return -1;
-		cp += 40;
-		if ((*cp != '\t') && *cp != ' ')
-			return -1;
-		strcpy(path, ++cp);
-		diff_change(old_mode, new_mode, old_sha1, new_sha1, path, NULL);
-		break;
-	default:
+	if (get_sha1_hex(cp, new_sha1))
 		return -1;
-	}
+	cp += 40;
+	if (*cp++ != inter_name_termination)
+		return -1;
+	if (buf2)
+		cp = buf2;
+	ep = strchr(cp, inter_name_termination);
+	if (!ep)
+		return -1;
+	*ep++ = 0;
+	strcpy(old_path, cp);
+	diff_guif(old_mode, new_mode, old_sha1, new_sha1,
+		  old_path, buf3 ? buf3 : ep);
 	return 0;
 }
 
@@ -97,19 +60,22 @@ static const char *diff_helper_usage =
 	"git-diff-helper [-z] [-R] [-M] [-C] [-S<string>] paths...";
 
 int main(int ac, const char **av) {
-	struct strbuf sb;
-	int reverse = 0;
-	int line_termination = '\n';
+	struct strbuf sb1, sb2, sb3;
+	int reverse_diff = 0;
 
-	strbuf_init(&sb);
+	strbuf_init(&sb1);
+	strbuf_init(&sb2);
+	strbuf_init(&sb3);
 
 	while (1 < ac && av[1][0] == '-') {
 		if (av[1][1] == 'R')
-			reverse = 1;
+			reverse_diff = 1;
 		else if (av[1][1] == 'z')
-			line_termination = 0;
+			line_termination = inter_name_termination = 0;
 		else if (av[1][1] == 'p') /* hidden from the help */
-			generate_patch = 0;
+			diff_output_style = DIFF_FORMAT_HUMAN;
+		else if (av[1][1] == 'P') /* hidden from the help */
+			diff_output_style = DIFF_FORMAT_MACHINE;
 		else if (av[1][1] == 'M') {
 			detect_rename = 1;
 			diff_score_opt = diff_scoreopt_parse(av[1]);
@@ -127,19 +93,38 @@ int main(int ac, const char **av) {
 	}
 	/* the remaining parameters are paths patterns */
 
-	diff_setup(reverse, (generate_patch ? -1 : line_termination));
+	diff_setup(reverse_diff, diff_output_style);
 	while (1) {
 		int status;
-		read_line(&sb, stdin, line_termination);
-		if (sb.eof)
+		read_line(&sb1, stdin, line_termination);
+		if (sb1.eof)
 			break;
-		status = parse_diff_raw_output(sb.buf);
+		switch (sb1.buf[0]) {
+		case 'U':
+			diff_unmerge(sb1.buf + 2);
+			continue;
+		case ':':
+			break;
+		default:
+			goto unrecognized;
+		}
+		if (!line_termination) {
+			read_line(&sb2, stdin, line_termination);
+			if (sb2.eof)
+				break;
+			read_line(&sb3, stdin, line_termination);
+			if (sb3.eof)
+				break;
+			status = parse_diff_raw(sb1.buf+1, sb2.buf, sb3.buf);
+		}
+		else
+			status = parse_diff_raw(sb1.buf+1, NULL, NULL);
 		if (status) {
+		unrecognized:
 			diff_flush(av+1, ac-1);
-			printf("%s%c", sb.buf, line_termination);
+			printf("%s%c", sb1.buf, line_termination);
 		}
 	}
-
 	if (detect_rename)
 		diff_detect_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -8,8 +8,7 @@ static int verbose_header = 0;
 static int ignore_merges = 1;
 static int recursive = 0;
 static int read_stdin = 0;
-static int line_termination = '\n';
-static int generate_patch = 0;
+static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
@@ -269,7 +268,7 @@ static int diff_tree_sha1(const unsigned
 
 static void call_diff_setup(void)
 {
-	diff_setup(reverse_diff, (generate_patch ? -1 : line_termination));
+	diff_setup(reverse_diff, diff_output_format);
 }
 
 static void call_diff_flush(void)
@@ -501,7 +500,8 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-p")) {
-			recursive = generate_patch = 1;
+			diff_output_format = DIFF_FORMAT_PATCH;
+			recursive = 1;
 			continue;
 		}
 		if (!strncmp(arg, "-S", 2)) {
@@ -509,18 +509,17 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (!strncmp(arg, "-M", 2)) {
-			detect_rename = recursive = generate_patch = 1;
+			detect_rename = 1;
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
 		if (!strncmp(arg, "-C", 2)) {
 			detect_rename = 2;
-			recursive = generate_patch = 1;
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
 		if (!strcmp(arg, "-z")) {
-			line_termination = '\0';
+			diff_output_format = DIFF_FORMAT_MACHINE;
 			continue;
 		}
 		if (!strcmp(arg, "-m")) {
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -13,7 +13,9 @@ static const char *diff_opts = "-pu";
 static unsigned char null_sha1[20] = { 0, };
 
 static int reverse_diff;
-static int diff_raw_output = -1;
+static int generate_patch;
+static int line_termination = '\n';
+static int inter_name_termination = '\t';
 static const char **pathspec;
 static int speccnt;
 
@@ -163,20 +165,23 @@ struct diff_filespec *alloc_filespec(con
 	struct diff_filespec *spec = xmalloc(sizeof(*spec) + namelen + 1);
 	spec->path = (char *)(spec + 1);
 	strcpy(spec->path, path);
-	spec->should_free = spec->should_munmap = spec->file_valid = 0;
+	spec->should_free = spec->should_munmap = 0;
 	spec->xfrm_flags = 0;
 	spec->size = 0;
 	spec->data = 0;
+	spec->mode = 0;
+	memset(spec->sha1, 0, 20);
 	return spec;
 }
 
 void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
 		   unsigned short mode)
 {
-	spec->mode = mode;
-	memcpy(spec->sha1, sha1, 20);
-	spec->sha1_valid = !!memcmp(sha1, null_sha1, 20);
-	spec->file_valid = 1;
+	if (mode) { /* just playing defensive */
+		spec->mode = mode;
+		memcpy(spec->sha1, sha1, 20);
+		spec->sha1_valid = !!memcmp(sha1, null_sha1, 20);
+	}
 }
 
 /*
@@ -231,7 +236,7 @@ static int work_tree_matches(const char 
 int diff_populate_filespec(struct diff_filespec *s)
 {
 	int err = 0;
-	if (!s->file_valid)
+	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
 	if (S_ISDIR(s->mode))
 		return -1;
@@ -316,7 +321,7 @@ static void prepare_temp_file(const char
 			      struct diff_tempfile *temp,
 			      struct diff_filespec *one)
 {
-	if (!one->file_valid) {
+	if (!DIFF_FILE_VALID(one)) {
 	not_a_valid_file:
 		/* A '-' entry produces this for file-2, and
 		 * a '+' entry produces this for file-1.
@@ -509,10 +514,22 @@ int diff_scoreopt_parse(const char *opt)
 	return MAX_SCORE * num / scale;
 }
 
-void diff_setup(int reverse_diff_, int diff_raw_output_)
+void diff_setup(int reverse_diff_, int diff_output_style)
 {
 	reverse_diff = reverse_diff_;
-	diff_raw_output = diff_raw_output_;
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
 }
 
 struct diff_queue_struct diff_queued_diff;
@@ -536,43 +553,17 @@ struct diff_filepair *diff_queue(struct 
 	return dp;
 }
 
-static const char *git_object_type(unsigned mode)
-{
-	return S_ISDIR(mode) ? "tree" : "blob";
-}
-
 static void diff_flush_raw(struct diff_filepair *p)
 {
-	struct diff_filespec *it;
-	int addremove;
-
-	/* raw output does not have a way to express rename nor copy */
-	if (strcmp(p->one->path, p->two->path))
-		return;
-
-	if (p->one->file_valid && p->two->file_valid) {
-		char hex[41];
-		strcpy(hex, sha1_to_hex(p->one->sha1));
-		printf("*%06o->%06o %s %s->%s %s%c",
-		       p->one->mode, p->two->mode,
-		       git_object_type(p->one->mode),
-		       hex, sha1_to_hex(p->two->sha1),
-		       p->one->path, diff_raw_output);
-		return;
-	}
-
-	if (p->one->file_valid) {
-		it = p->one;
-		addremove = '-';
-	} else {
-		it = p->two;
-		addremove = '+';
-	}
-
-	printf("%c%06o %s %s %s%c",
-	       addremove,
-	       it->mode, git_object_type(it->mode),
-	       sha1_to_hex(it->sha1), it->path, diff_raw_output);
+	/*
+	 * We used to reject rename/copy but new diff-raw can express them.
+	 */
+	printf(":%06o %06o %s ",
+	       p->one->mode, p->two->mode, sha1_to_hex(p->one->sha1));
+	printf("%s%c%s%c%s%c",
+	       sha1_to_hex(p->two->sha1), inter_name_termination,
+	       p->one->path, inter_name_termination,
+	       p->two->path, line_termination);
 }
 
 static void diff_flush_patch(struct diff_filepair *p)
@@ -581,8 +572,8 @@ static void diff_flush_patch(struct diff
 
 	name = p->one->path;
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
-	if ((p->one->file_valid && S_ISDIR(p->one->mode)) ||
-	    (p->two->file_valid && S_ISDIR(p->two->mode)))
+	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
+	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
 		return; /* no tree diffs in patch format */ 
 
 	run_external_diff(name, other, p->one, p->two, p->xfrm_msg);
@@ -596,11 +587,12 @@ static int identical(struct diff_filespe
 	 * and filter and clean them up here before producing the output.
 	 */
 
-	if (!one->file_valid && !two->file_valid)
+	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two))
 		return 1; /* not interesting */
 
 	/* deletion, addition, mode change and renames are all interesting. */
-	if ((one->file_valid != two->file_valid) || (one->mode != two->mode) ||
+	if (DIFF_FILE_VALID(one) != DIFF_FILE_VALID(two) ||
+	    (one->mode != two->mode) ||
 	    strcmp(one->path, two->path))
 		return 0;
 
@@ -619,10 +611,10 @@ static void diff_flush_one(struct diff_f
 {
 	if (identical(p->one, p->two))
 		return;
-	if (0 <= diff_raw_output)
-		diff_flush_raw(p);
-	else
+	if (generate_patch)
 		diff_flush_patch(p);
+	else
+		diff_flush_raw(p);
 }
 
 int diff_queue_is_empty(void)
@@ -697,10 +689,35 @@ void diff_addremove(int addremove, unsig
 	diff_queue(&diff_queued_diff, one, two);
 }
 
+void diff_guif(unsigned old_mode,
+	       unsigned new_mode,
+	       const unsigned char *old_sha1,
+	       const unsigned char *new_sha1,
+	       const char *old_path,
+	       const char *new_path)
+{
+	struct diff_filespec *one, *two;
+
+	if (reverse_diff) {
+		unsigned tmp;
+		const unsigned char *tmp_c;
+		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
+		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
+	}
+	one = alloc_filespec(old_path);
+	two = alloc_filespec(new_path);
+	if (old_mode)
+		fill_filespec(one, old_sha1, old_mode);
+	if (new_mode)
+		fill_filespec(two, new_sha1, new_mode);
+	diff_queue(&diff_queued_diff, one, two);
+}
+
 void diff_change(unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *base, const char *path) {
+		 const char *base, const char *path) 
+{
 	char concatpath[PATH_MAX];
 	struct diff_filespec *one, *two;
 
@@ -722,9 +739,8 @@ void diff_change(unsigned old_mode, unsi
 
 void diff_unmerge(const char *path)
 {
-	if (0 <= diff_raw_output) {
-		printf("U %s%c", path, diff_raw_output);
-		return;
-	}
-	run_external_diff(path, NULL, NULL, NULL, NULL);
+	if (generate_patch)
+		run_external_diff(path, NULL, NULL, NULL, NULL);
+	else
+		printf("U %s%c", path, line_termination);
 }
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -15,11 +15,21 @@ extern void diff_change(unsigned mode1, 
 			     const unsigned char *sha2,
 			     const char *base, const char *path);
 
+extern void diff_guif(unsigned mode1,
+		      unsigned mode2,
+		      const unsigned char *sha1,
+		      const unsigned char *sha2,
+		      const char *path1,
+		      const char *path2);
+
 extern void diff_unmerge(const char *path);
 
 extern int diff_scoreopt_parse(const char *opt);
 
-extern void diff_setup(int reverse, int diff_raw_output);
+#define DIFF_FORMAT_HUMAN   0
+#define DIFF_FORMAT_MACHINE 1
+#define DIFF_FORMAT_PATCH   2
+extern void diff_setup(int reverse, int diff_output_style);
 
 extern void diff_detect_rename(int, int);
 extern void diff_pickaxe(const char *);
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -32,14 +32,14 @@ void diff_pickaxe(const char *needle)
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (!p->one->file_valid) {
-			if (!p->two->file_valid)
+		if (!DIFF_FILE_VALID(p->one)) {
+			if (!DIFF_FILE_VALID(p->two))
 				continue; /* ignore nonsense */
 			/* created */
 			if (contains(p->two, needle, len))
 				diff_queue(&outq, p->one, p->two);
 		}
-		else if (!p->two->file_valid) {
+		else if (!DIFF_FILE_VALID(p->two)) {
 			if (contains(p->one, needle, len))
 				diff_queue(&outq, p->one, p->two);
 		}
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -142,7 +142,7 @@ static void debug_filespec(struct diff_f
 	fprintf(stderr, "queue[%d] %s (%s) %s %06o %s\n",
 		x, one,
 		s->path,
-		s->file_valid ? "valid" : "invalid",
+		DIFF_FILE_VALID(s) ? "valid" : "invalid",
 		s->mode,
 		s->sha1_valid ? sha1_to_hex(s->sha1) : "");
 	fprintf(stderr, "queue[%d] %s size %lu flags %d\n",
@@ -210,7 +210,7 @@ static int needs_to_stay(struct diff_que
 	 */
 	while (i < q->nr) {
 		struct diff_filepair *p = q->queue[i++];
-		if (!p->two->file_valid)
+		if (!DIFF_FILE_VALID(p->two))
 			continue; /* removed is fine */
 		if (strcmp(p->one->path, it->path))
 			continue; /* not relevant */
@@ -247,12 +247,12 @@ void diff_detect_rename(int detect_renam
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		if (!p->one->file_valid)
-			if (!p->two->file_valid)
+		if (!DIFF_FILE_VALID(p->one))
+			if (!DIFF_FILE_VALID(p->two))
 				continue; /* ignore nonsense */
 			else
 				diff_rename_pool_add(&created, p->two);
-		else if (!p->two->file_valid)
+		else if (!DIFF_FILE_VALID(p->two))
 			diff_rename_pool_add(&deleted, p->one);
 		else if (1 < detect_rename) /* find copy, too */
 			diff_rename_pool_add(&stay, p->one);
@@ -340,15 +340,15 @@ void diff_detect_rename(int detect_renam
 	 */
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *dp, *p = q->queue[i];
-		if (!p->one->file_valid) {
-			if (p->two->file_valid) {
+		if (!DIFF_FILE_VALID(p->one)) {
+			if (DIFF_FILE_VALID(p->two)) {
 				/* creation */
 				dp = diff_queue(&outq, p->one, p->two);
 				dp->xfrm_work = 4;
 			}
 			/* otherwise it is a nonsense; just ignore it */
 		}
-		else if (!p->two->file_valid) {
+		else if (!DIFF_FILE_VALID(p->two)) {
 			/* deletion */
 			dp = diff_queue(&outq, p->one, p->two);
 			dp->xfrm_work = 2;
@@ -374,14 +374,14 @@ void diff_detect_rename(int detect_renam
 	/* Copy it out to q, removing duplicates. */
 	for (i = 0; i < outq.nr; i++) {
 		struct diff_filepair *p = outq.queue[i];
-		if (!p->one->file_valid) {
+		if (!DIFF_FILE_VALID(p->one)) {
 			/* created */
 			if (p->two->xfrm_flags & RENAME_DST_MATCHED)
 				; /* rename/copy created it already */
 			else
 				diff_queue(q, p->one, p->two);
 		}
-		else if (!p->two->file_valid) {
+		else if (!DIFF_FILE_VALID(p->two)) {
 			/* deleted */
 			if (p->one->xfrm_flags & RENAME_SRC_GONE)
 				; /* rename/copy deleted it already */
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -26,7 +26,7 @@ struct diff_filespec {
 				  * if false, use the name and read from
 				  * the filesystem.
 				  */
-	unsigned file_valid : 1; /* if false the file does not exist */
+#define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
 };
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -155,14 +155,14 @@ test_expect_success \
      test "$newtree" = "$tree"'
 
 cat >expected <<\EOF
-*100644->100644	blob	f87290f8eb2cbbea7857214459a0739927eab154->0000000000000000000000000000000000000000	path0
-*120000->120000	blob	15a98433ae33114b085f3eb3bb03b832b3180a01->0000000000000000000000000000000000000000	path0sym
-*100644->100644	blob	3feff949ed00a62d9f7af97c15cd8a30595e7ac7->0000000000000000000000000000000000000000	path2/file2
-*120000->120000	blob	d8ce161addc5173867a3c3c730924388daedbc38->0000000000000000000000000000000000000000	path2/file2sym
-*100644->100644	blob	0aa34cae68d0878578ad119c86ca2b5ed5b28376->0000000000000000000000000000000000000000	path3/file3
-*120000->120000	blob	8599103969b43aff7e430efea79ca4636466794f->0000000000000000000000000000000000000000	path3/file3sym
-*100644->100644	blob	00fb5908cb97c2564a9783c0c64087333b3b464f->0000000000000000000000000000000000000000	path3/subp3/file3
-*120000->120000	blob	6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c->0000000000000000000000000000000000000000	path3/subp3/file3sym
+:100644 100644 f87290f8eb2cbbea7857214459a0739927eab154 0000000000000000000000000000000000000000	path0	path0
+:120000 120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0000000000000000000000000000000000000000	path0sym	path0sym
+:100644 100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0000000000000000000000000000000000000000	path2/file2	path2/file2
+:120000 120000 d8ce161addc5173867a3c3c730924388daedbc38 0000000000000000000000000000000000000000	path2/file2sym	path2/file2sym
+:100644 100644 0aa34cae68d0878578ad119c86ca2b5ed5b28376 0000000000000000000000000000000000000000	path3/file3	path3/file3
+:120000 120000 8599103969b43aff7e430efea79ca4636466794f 0000000000000000000000000000000000000000	path3/file3sym	path3/file3sym
+:100644 100644 00fb5908cb97c2564a9783c0c64087333b3b464f 0000000000000000000000000000000000000000	path3/subp3/file3	path3/subp3/file3
+:120000 120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0000000000000000000000000000000000000000	path3/subp3/file3sym	path3/subp3/file3sym
 EOF
 test_expect_success \
     'validate git-diff-files output for a know cache/work tree state.' \
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -10,123 +10,122 @@ test_description='Test diff raw-output.
 . ../lib-read-tree-m-3way.sh
 
 cat >.test-plain-OA <<\EOF
-+100644 blob ccba72ad3888a3520b39efcf780b9ee64167535d AA
-+100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
--100644 blob bcc68ef997017466d5c9094bcf7692295f588c9a DD
-+040000 tree 6d50f65d3bdab91c63444294d38f08aeff328e42 DF
--100644 blob 141c1f1642328e4bc46a7d801a71da392e66791e DM
--100644 blob 35abde1506ddf806572ff4d407bd06885d0f8ee9 DN
-+100644 blob 1d41122ebdd7a640f29d3c9cc4f9d70094374762 LL
-*100644->100644 blob 03f24c8c4700babccfd28b654e7e8eac402ad6cd->103d9f89b50b9aad03054b579be5e7aa665f2d57 MD
-*100644->100644 blob b258508afb7ceb449981bd9d63d2d3e971bf8d34->b431b272d829ff3aa4d1a5085f4394ab4d3305b6 MM
-*100644->100644 blob bd084b0c27c7b6cc34f11d6d0509a29be3caf970->a716d58de4a570e0038f5c307bd8db34daea021f MN
-*100644->100644 blob 40c959f984c8b89a2b02520d17f00d717f024397->2ac547ae9614a00d1b28275de608131f7a0e259f SS
-*100644->100644 blob 4ac13458899ab908ef3b1128fa378daefc88d356->4c86f9a85fbc5e6804ee2e17a797538fbe785bca TT
-*040000->040000 tree 7d670fdcdb9929f6c7dac196ff78689cd1c566a1->5e5f22072bb39f6e12cf663a57cb634c76eefb49 Z
+:000000 100644 0000000000000000000000000000000000000000 ccba72ad3888a3520b39efcf780b9ee64167535d	AA	AA
+:000000 100644 0000000000000000000000000000000000000000 7e426fb079479fd67f6d81f984e4ec649a44bc25	AN	AN
+:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000	DD	DD
+:000000 040000 0000000000000000000000000000000000000000 6d50f65d3bdab91c63444294d38f08aeff328e42	DF	DF
+:100644 000000 141c1f1642328e4bc46a7d801a71da392e66791e 0000000000000000000000000000000000000000	DM	DM
+:100644 000000 35abde1506ddf806572ff4d407bd06885d0f8ee9 0000000000000000000000000000000000000000	DN	DN
+:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762	LL	LL
+:100644 100644 03f24c8c4700babccfd28b654e7e8eac402ad6cd 103d9f89b50b9aad03054b579be5e7aa665f2d57	MD	MD
+:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 b431b272d829ff3aa4d1a5085f4394ab4d3305b6	MM	MM
+:100644 100644 bd084b0c27c7b6cc34f11d6d0509a29be3caf970 a716d58de4a570e0038f5c307bd8db34daea021f	MN	MN
+:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f	SS	SS
+:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 4c86f9a85fbc5e6804ee2e17a797538fbe785bca	TT	TT
+:040000 040000 7d670fdcdb9929f6c7dac196ff78689cd1c566a1 5e5f22072bb39f6e12cf663a57cb634c76eefb49	Z	Z
 EOF
 
 cat >.test-recursive-OA <<\EOF
-+100644 blob ccba72ad3888a3520b39efcf780b9ee64167535d AA
-+100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
--100644 blob bcc68ef997017466d5c9094bcf7692295f588c9a DD
-+100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
--100644 blob 141c1f1642328e4bc46a7d801a71da392e66791e DM
--100644 blob 35abde1506ddf806572ff4d407bd06885d0f8ee9 DN
-+100644 blob 1d41122ebdd7a640f29d3c9cc4f9d70094374762 LL
-*100644->100644 blob 03f24c8c4700babccfd28b654e7e8eac402ad6cd->103d9f89b50b9aad03054b579be5e7aa665f2d57 MD
-*100644->100644 blob b258508afb7ceb449981bd9d63d2d3e971bf8d34->b431b272d829ff3aa4d1a5085f4394ab4d3305b6 MM
-*100644->100644 blob bd084b0c27c7b6cc34f11d6d0509a29be3caf970->a716d58de4a570e0038f5c307bd8db34daea021f MN
-*100644->100644 blob 40c959f984c8b89a2b02520d17f00d717f024397->2ac547ae9614a00d1b28275de608131f7a0e259f SS
-*100644->100644 blob 4ac13458899ab908ef3b1128fa378daefc88d356->4c86f9a85fbc5e6804ee2e17a797538fbe785bca TT
-+100644 blob 8acb8e9750e3f644bf323fcf3d338849db106c77 Z/AA
-+100644 blob 087494262084cefee7ed484d20c8dc0580791272 Z/AN
--100644 blob 879007efae624d2b1307214b24a956f0a8d686a8 Z/DD
--100644 blob 9b541b2275c06e3a7b13f28badf5294e2ae63df4 Z/DM
--100644 blob beb5d38c55283d280685ea21a0e50cfcc0ca064a Z/DN
-*100644->100644 blob d41fda41b7ec4de46b43cb7ea42a45001ae393d5->a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9 Z/MD
-*100644->100644 blob 4ca22bae2527d3d9e1676498a0fba3b355bd1278->61422ba9c2c873416061a88cd40a59a35b576474 Z/MM
-*100644->100644 blob b16d7b25b869f2beb124efa53467d8a1550ad694->a5c544c21cfcb07eb80a4d89a5b7d1570002edfd Z/MN
+:000000 100644 0000000000000000000000000000000000000000 ccba72ad3888a3520b39efcf780b9ee64167535d	AA	AA
+:000000 100644 0000000000000000000000000000000000000000 7e426fb079479fd67f6d81f984e4ec649a44bc25	AN	AN
+:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000	DD	DD
+:000000 100644 0000000000000000000000000000000000000000 68a6d8b91da11045cf4aa3a5ab9f2a781c701249	DF/DF	DF/DF
+:100644 000000 141c1f1642328e4bc46a7d801a71da392e66791e 0000000000000000000000000000000000000000	DM	DM
+:100644 000000 35abde1506ddf806572ff4d407bd06885d0f8ee9 0000000000000000000000000000000000000000	DN	DN
+:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762	LL	LL
+:100644 100644 03f24c8c4700babccfd28b654e7e8eac402ad6cd 103d9f89b50b9aad03054b579be5e7aa665f2d57	MD	MD
+:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 b431b272d829ff3aa4d1a5085f4394ab4d3305b6	MM	MM
+:100644 100644 bd084b0c27c7b6cc34f11d6d0509a29be3caf970 a716d58de4a570e0038f5c307bd8db34daea021f	MN	MN
+:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f	SS	SS
+:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 4c86f9a85fbc5e6804ee2e17a797538fbe785bca	TT	TT
+:000000 100644 0000000000000000000000000000000000000000 8acb8e9750e3f644bf323fcf3d338849db106c77	Z/AA	Z/AA
+:000000 100644 0000000000000000000000000000000000000000 087494262084cefee7ed484d20c8dc0580791272	Z/AN	Z/AN
+:100644 000000 879007efae624d2b1307214b24a956f0a8d686a8 0000000000000000000000000000000000000000	Z/DD	Z/DD
+:100644 000000 9b541b2275c06e3a7b13f28badf5294e2ae63df4 0000000000000000000000000000000000000000	Z/DM	Z/DM
+:100644 000000 beb5d38c55283d280685ea21a0e50cfcc0ca064a 0000000000000000000000000000000000000000	Z/DN	Z/DN
+:100644 100644 d41fda41b7ec4de46b43cb7ea42a45001ae393d5 a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9	Z/MD	Z/MD
+:100644 100644 4ca22bae2527d3d9e1676498a0fba3b355bd1278 61422ba9c2c873416061a88cd40a59a35b576474	Z/MM	Z/MM
+:100644 100644 b16d7b25b869f2beb124efa53467d8a1550ad694 a5c544c21cfcb07eb80a4d89a5b7d1570002edfd	Z/MN	Z/MN
 EOF
 cat >.test-plain-OB <<\EOF
-+100644 blob 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 AA
--100644 blob bcc68ef997017466d5c9094bcf7692295f588c9a DD
-+100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
-*100644->100644 blob 141c1f1642328e4bc46a7d801a71da392e66791e->3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
-+100644 blob 1d41122ebdd7a640f29d3c9cc4f9d70094374762 LL
--100644 blob 03f24c8c4700babccfd28b654e7e8eac402ad6cd MD
-*100644->100644 blob b258508afb7ceb449981bd9d63d2d3e971bf8d34->19989d4559aae417fedee240ccf2ba315ea4dc2b MM
-+100644 blob 15885881ea69115351c09b38371f0348a3fb8c67 NA
--100644 blob a4e179e4291e5536a5e1c82e091052772d2c5a93 ND
-*100644->100644 blob c8f25781e8f1792e3e40b74225e20553041b5226->cdb9a8c3da571502ac30225e9c17beccb8387983 NM
-*100644->100644 blob 40c959f984c8b89a2b02520d17f00d717f024397->2ac547ae9614a00d1b28275de608131f7a0e259f SS
-*100644->100644 blob 4ac13458899ab908ef3b1128fa378daefc88d356->c4e4a12231b9fa79a0053cb6077fcb21bb5b135a TT
-*040000->040000 tree 7d670fdcdb9929f6c7dac196ff78689cd1c566a1->1ba523955d5160681af65cb776411f574c1e8155 Z
+:000000 100644 0000000000000000000000000000000000000000 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2	AA	AA
+:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000	DD	DD
+:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787	DF	DF
+:100644 100644 141c1f1642328e4bc46a7d801a71da392e66791e 3c4d8de5fbad08572bab8e10eef8dbb264cf0231	DM	DM
+:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762	LL	LL
+:100644 000000 03f24c8c4700babccfd28b654e7e8eac402ad6cd 0000000000000000000000000000000000000000	MD	MD
+:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 19989d4559aae417fedee240ccf2ba315ea4dc2b	MM	MM
+:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67	NA	NA
+:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000	ND	ND
+:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983	NM	NM
+:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f	SS	SS
+:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 c4e4a12231b9fa79a0053cb6077fcb21bb5b135a	TT	TT
+:040000 040000 7d670fdcdb9929f6c7dac196ff78689cd1c566a1 1ba523955d5160681af65cb776411f574c1e8155	Z	Z
 EOF
 cat >.test-recursive-OB <<\EOF
-+100644 blob 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 AA
--100644 blob bcc68ef997017466d5c9094bcf7692295f588c9a DD
-+100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
-*100644->100644 blob 141c1f1642328e4bc46a7d801a71da392e66791e->3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
-+100644 blob 1d41122ebdd7a640f29d3c9cc4f9d70094374762 LL
--100644 blob 03f24c8c4700babccfd28b654e7e8eac402ad6cd MD
-*100644->100644 blob b258508afb7ceb449981bd9d63d2d3e971bf8d34->19989d4559aae417fedee240ccf2ba315ea4dc2b MM
-+100644 blob 15885881ea69115351c09b38371f0348a3fb8c67 NA
--100644 blob a4e179e4291e5536a5e1c82e091052772d2c5a93 ND
-*100644->100644 blob c8f25781e8f1792e3e40b74225e20553041b5226->cdb9a8c3da571502ac30225e9c17beccb8387983 NM
-*100644->100644 blob 40c959f984c8b89a2b02520d17f00d717f024397->2ac547ae9614a00d1b28275de608131f7a0e259f SS
-*100644->100644 blob 4ac13458899ab908ef3b1128fa378daefc88d356->c4e4a12231b9fa79a0053cb6077fcb21bb5b135a TT
-+100644 blob 6c0b99286d0bce551ac4a7b3dff8b706edff3715 Z/AA
--100644 blob 879007efae624d2b1307214b24a956f0a8d686a8 Z/DD
-*100644->100644 blob 9b541b2275c06e3a7b13f28badf5294e2ae63df4->d77371d15817fcaa57eeec27f770c505ba974ec1 Z/DM
--100644 blob d41fda41b7ec4de46b43cb7ea42a45001ae393d5 Z/MD
-*100644->100644 blob 4ca22bae2527d3d9e1676498a0fba3b355bd1278->697aad7715a1e7306ca76290a3dd4208fbaeddfa Z/MM
-+100644 blob d12979c22fff69c59ca9409e7a8fe3ee25eaee80 Z/NA
--100644 blob a18393c636b98e9bd7296b8b437ea4992b72440c Z/ND
-*100644->100644 blob 3fdbe17fd013303a2e981e1ca1c6cd6e72789087->7e09d6a3a14bd630913e8c75693cea32157b606d Z/NM
+:000000 100644 0000000000000000000000000000000000000000 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2	AA	AA
+:100644 000000 bcc68ef997017466d5c9094bcf7692295f588c9a 0000000000000000000000000000000000000000	DD	DD
+:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787	DF	DF
+:100644 100644 141c1f1642328e4bc46a7d801a71da392e66791e 3c4d8de5fbad08572bab8e10eef8dbb264cf0231	DM	DM
+:000000 100644 0000000000000000000000000000000000000000 1d41122ebdd7a640f29d3c9cc4f9d70094374762	LL	LL
+:100644 000000 03f24c8c4700babccfd28b654e7e8eac402ad6cd 0000000000000000000000000000000000000000	MD	MD
+:100644 100644 b258508afb7ceb449981bd9d63d2d3e971bf8d34 19989d4559aae417fedee240ccf2ba315ea4dc2b	MM	MM
+:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67	NA	NA
+:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000	ND	ND
+:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983	NM	NM
+:100644 100644 40c959f984c8b89a2b02520d17f00d717f024397 2ac547ae9614a00d1b28275de608131f7a0e259f	SS	SS
+:100644 100644 4ac13458899ab908ef3b1128fa378daefc88d356 c4e4a12231b9fa79a0053cb6077fcb21bb5b135a	TT	TT
+:000000 100644 0000000000000000000000000000000000000000 6c0b99286d0bce551ac4a7b3dff8b706edff3715	Z/AA	Z/AA
+:100644 000000 879007efae624d2b1307214b24a956f0a8d686a8 0000000000000000000000000000000000000000	Z/DD	Z/DD
+:100644 100644 9b541b2275c06e3a7b13f28badf5294e2ae63df4 d77371d15817fcaa57eeec27f770c505ba974ec1	Z/DM	Z/DM
+:100644 000000 d41fda41b7ec4de46b43cb7ea42a45001ae393d5 0000000000000000000000000000000000000000	Z/MD	Z/MD
+:100644 100644 4ca22bae2527d3d9e1676498a0fba3b355bd1278 697aad7715a1e7306ca76290a3dd4208fbaeddfa	Z/MM	Z/MM
+:000000 100644 0000000000000000000000000000000000000000 d12979c22fff69c59ca9409e7a8fe3ee25eaee80	Z/NA	Z/NA
+:100644 000000 a18393c636b98e9bd7296b8b437ea4992b72440c 0000000000000000000000000000000000000000	Z/ND	Z/ND
+:100644 100644 3fdbe17fd013303a2e981e1ca1c6cd6e72789087 7e09d6a3a14bd630913e8c75693cea32157b606d	Z/NM	Z/NM
 EOF
 cat >.test-plain-AB <<\EOF
-*100644->100644 blob ccba72ad3888a3520b39efcf780b9ee64167535d->6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 AA
--100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
-+100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
--040000 tree 6d50f65d3bdab91c63444294d38f08aeff328e42 DF
-+100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
-+100644 blob 35abde1506ddf806572ff4d407bd06885d0f8ee9 DN
--100644 blob 103d9f89b50b9aad03054b579be5e7aa665f2d57 MD
-*100644->100644 blob b431b272d829ff3aa4d1a5085f4394ab4d3305b6->19989d4559aae417fedee240ccf2ba315ea4dc2b MM
-*100644->100644 blob a716d58de4a570e0038f5c307bd8db34daea021f->bd084b0c27c7b6cc34f11d6d0509a29be3caf970 MN
-+100644 blob 15885881ea69115351c09b38371f0348a3fb8c67 NA
--100644 blob a4e179e4291e5536a5e1c82e091052772d2c5a93 ND
-*100644->100644 blob c8f25781e8f1792e3e40b74225e20553041b5226->cdb9a8c3da571502ac30225e9c17beccb8387983 NM
-*100644->100644 blob 4c86f9a85fbc5e6804ee2e17a797538fbe785bca->c4e4a12231b9fa79a0053cb6077fcb21bb5b135a TT
-*040000->040000 tree 5e5f22072bb39f6e12cf663a57cb634c76eefb49->1ba523955d5160681af65cb776411f574c1e8155 Z
+:100644 100644 ccba72ad3888a3520b39efcf780b9ee64167535d 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2	AA	AA
+:100644 000000 7e426fb079479fd67f6d81f984e4ec649a44bc25 0000000000000000000000000000000000000000	AN	AN
+:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787	DF	DF
+:040000 000000 6d50f65d3bdab91c63444294d38f08aeff328e42 0000000000000000000000000000000000000000	DF	DF
+:000000 100644 0000000000000000000000000000000000000000 3c4d8de5fbad08572bab8e10eef8dbb264cf0231	DM	DM
+:000000 100644 0000000000000000000000000000000000000000 35abde1506ddf806572ff4d407bd06885d0f8ee9	DN	DN
+:100644 000000 103d9f89b50b9aad03054b579be5e7aa665f2d57 0000000000000000000000000000000000000000	MD	MD
+:100644 100644 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 19989d4559aae417fedee240ccf2ba315ea4dc2b	MM	MM
+:100644 100644 a716d58de4a570e0038f5c307bd8db34daea021f bd084b0c27c7b6cc34f11d6d0509a29be3caf970	MN	MN
+:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67	NA	NA
+:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000	ND	ND
+:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983	NM	NM
+:100644 100644 4c86f9a85fbc5e6804ee2e17a797538fbe785bca c4e4a12231b9fa79a0053cb6077fcb21bb5b135a	TT	TT
+:040000 040000 5e5f22072bb39f6e12cf663a57cb634c76eefb49 1ba523955d5160681af65cb776411f574c1e8155	Z	Z
 EOF
 cat >.test-recursive-AB <<\EOF
-*100644->100644 blob ccba72ad3888a3520b39efcf780b9ee64167535d->6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 AA
--100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
-+100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
--100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
-+100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
-+100644 blob 35abde1506ddf806572ff4d407bd06885d0f8ee9 DN
--100644 blob 103d9f89b50b9aad03054b579be5e7aa665f2d57 MD
-*100644->100644 blob b431b272d829ff3aa4d1a5085f4394ab4d3305b6->19989d4559aae417fedee240ccf2ba315ea4dc2b MM
-*100644->100644 blob a716d58de4a570e0038f5c307bd8db34daea021f->bd084b0c27c7b6cc34f11d6d0509a29be3caf970 MN
-+100644 blob 15885881ea69115351c09b38371f0348a3fb8c67 NA
--100644 blob a4e179e4291e5536a5e1c82e091052772d2c5a93 ND
-*100644->100644 blob c8f25781e8f1792e3e40b74225e20553041b5226->cdb9a8c3da571502ac30225e9c17beccb8387983 NM
-*100644->100644 blob 4c86f9a85fbc5e6804ee2e17a797538fbe785bca->c4e4a12231b9fa79a0053cb6077fcb21bb5b135a TT
-*100644->100644 blob 8acb8e9750e3f644bf323fcf3d338849db106c77->6c0b99286d0bce551ac4a7b3dff8b706edff3715 Z/AA
--100644 blob 087494262084cefee7ed484d20c8dc0580791272 Z/AN
-+100644 blob d77371d15817fcaa57eeec27f770c505ba974ec1 Z/DM
-+100644 blob beb5d38c55283d280685ea21a0e50cfcc0ca064a Z/DN
--100644 blob a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9 Z/MD
-*100644->100644 blob 61422ba9c2c873416061a88cd40a59a35b576474->697aad7715a1e7306ca76290a3dd4208fbaeddfa Z/MM
-*100644->100644 blob a5c544c21cfcb07eb80a4d89a5b7d1570002edfd->b16d7b25b869f2beb124efa53467d8a1550ad694 Z/MN
-+100644 blob d12979c22fff69c59ca9409e7a8fe3ee25eaee80 Z/NA
--100644 blob a18393c636b98e9bd7296b8b437ea4992b72440c Z/ND
-*100644->100644 blob 3fdbe17fd013303a2e981e1ca1c6cd6e72789087->7e09d6a3a14bd630913e8c75693cea32157b606d Z/NM
+:100644 100644 ccba72ad3888a3520b39efcf780b9ee64167535d 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2	AA	AA
+:100644 000000 7e426fb079479fd67f6d81f984e4ec649a44bc25 0000000000000000000000000000000000000000	AN	AN
+:000000 100644 0000000000000000000000000000000000000000 71420ab81e254145d26d6fc0cddee64c1acd4787	DF	DF
+:100644 000000 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 0000000000000000000000000000000000000000	DF/DF	DF/DF
+:000000 100644 0000000000000000000000000000000000000000 3c4d8de5fbad08572bab8e10eef8dbb264cf0231	DM	DM
+:000000 100644 0000000000000000000000000000000000000000 35abde1506ddf806572ff4d407bd06885d0f8ee9	DN	DN
+:100644 000000 103d9f89b50b9aad03054b579be5e7aa665f2d57 0000000000000000000000000000000000000000	MD	MD
+:100644 100644 b431b272d829ff3aa4d1a5085f4394ab4d3305b6 19989d4559aae417fedee240ccf2ba315ea4dc2b	MM	MM
+:100644 100644 a716d58de4a570e0038f5c307bd8db34daea021f bd084b0c27c7b6cc34f11d6d0509a29be3caf970	MN	MN
+:000000 100644 0000000000000000000000000000000000000000 15885881ea69115351c09b38371f0348a3fb8c67	NA	NA
+:100644 000000 a4e179e4291e5536a5e1c82e091052772d2c5a93 0000000000000000000000000000000000000000	ND	ND
+:100644 100644 c8f25781e8f1792e3e40b74225e20553041b5226 cdb9a8c3da571502ac30225e9c17beccb8387983	NM	NM
+:100644 100644 4c86f9a85fbc5e6804ee2e17a797538fbe785bca c4e4a12231b9fa79a0053cb6077fcb21bb5b135a	TT	TT
+:100644 100644 8acb8e9750e3f644bf323fcf3d338849db106c77 6c0b99286d0bce551ac4a7b3dff8b706edff3715	Z/AA	Z/AA
+:100644 000000 087494262084cefee7ed484d20c8dc0580791272 0000000000000000000000000000000000000000	Z/AN	Z/AN
+:000000 100644 0000000000000000000000000000000000000000 d77371d15817fcaa57eeec27f770c505ba974ec1	Z/DM	Z/DM
+:000000 100644 0000000000000000000000000000000000000000 beb5d38c55283d280685ea21a0e50cfcc0ca064a	Z/DN	Z/DN
+:100644 000000 a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9 0000000000000000000000000000000000000000	Z/MD	Z/MD
+:100644 100644 61422ba9c2c873416061a88cd40a59a35b576474 697aad7715a1e7306ca76290a3dd4208fbaeddfa	Z/MM	Z/MM
+:100644 100644 a5c544c21cfcb07eb80a4d89a5b7d1570002edfd b16d7b25b869f2beb124efa53467d8a1550ad694	Z/MN	Z/MN
+:000000 100644 0000000000000000000000000000000000000000 d12979c22fff69c59ca9409e7a8fe3ee25eaee80	Z/NA	Z/NA
+:100644 000000 a18393c636b98e9bd7296b8b437ea4992b72440c 0000000000000000000000000000000000000000	Z/ND	Z/ND
+:100644 100644 3fdbe17fd013303a2e981e1ca1c6cd6e72789087 7e09d6a3a14bd630913e8c75693cea32157b606d	Z/NM	Z/NM
 EOF
 
-
 x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 x40="$x40$x40$x40$x40$x40$x40$x40$x40"
 z40='0000000000000000000000000000000000000000'
@@ -135,7 +134,7 @@ cmp_diff_files_output () {
     # object ID for the changed files because it wants you to look at the
     # filesystem.
     sed <"$2" >.test-tmp \
-	-e '/^+/d;/\^*/s/\( '$x40'->\)'$x40' /\1'$z40' /' &&
+	-e '/^:000000 /d;s/'$x40'	/'$z40'	/' &&
     diff "$1" .test-tmp
 }
 
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -26,7 +26,7 @@ test_expect_success \
 # both are slightly edited.  So we say you copy-and-edit one,
 # and rename-and-edit the other.
 
-GIT_DIFF_OPTS=--unified=0 git-diff-cache -M $tree |
+GIT_DIFF_OPTS=--unified=0 git-diff-cache -M -p $tree |
 sed -e 's/\([0-9][0-9]*\)/#/g' >current &&
 cat >expected <<\EOF
 diff --git a/COPYING b/COPYING.#
@@ -68,7 +68,7 @@ test_expect_success \
 # both are slightly edited.  So we say you edited one,
 # and copy-and-edit the other.
 
-GIT_DIFF_OPTS=--unified=0 git-diff-cache -C $tree |
+GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree |
 sed -e 's/\([0-9][0-9]*\)/#/g' >current
 cat >expected <<\EOF
 diff --git a/COPYING b/COPYING.#
@@ -108,7 +108,7 @@ test_expect_success \
 # this is only possible because -C mode now reports the unmodified
 # file to the diff-core.
 
-GIT_DIFF_OPTS=--unified=0 git-diff-cache -C $tree |
+GIT_DIFF_OPTS=--unified=0 git-diff-cache -C -p $tree |
 sed -e 's/\([0-9][0-9]*\)/#/g' >current
 cat >expected <<\EOF
 diff --git a/COPYING b/COPYING.#
------------------------------------------------

