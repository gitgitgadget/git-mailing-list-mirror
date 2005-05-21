From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Diff overhaul, adding half of copy detection.
Date: Sat, 21 May 2005 02:39:09 -0700
Message-ID: <7vu0kwkjeq.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 11:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZQUW-0004TU-Te
	for gcvg-git@gmane.org; Sat, 21 May 2005 11:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVEUJmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 05:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVEUJmt
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 05:42:49 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56507 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261712AbVEUJjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 05:39:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521093910.BMVV12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 05:39:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 02:37:31 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This introduces the diff-core, the layer between the diff-tree
family and the external diff interface engine.  The calls to the
interface diff-tree family uses (diff_change and diff_addremove)
have not changed and will not change.  The purpose of the
diff-core layer is to provide an infrastructure to transform the
set of differences sent from the applications, before sending
them to the external diff interface.

The recently introduced rename detection code has been rewritten
to use the diff-core facility.  When applications send in
separate creates and deletes, matching ones are transformed into
a single rename-and-edit diff, and sent out to the external diff
interface as such.

This patch also enhances the rename detection code further to be
able to detect copies.  Currently this happens only as long as
copy sources appear as part of the modified files, but there
already is enough provision for callers to report unmodified
files to diff-core, so that they can be also used as copy source
candidates.  Extending the callers this way will be done in a
separate patch.

Please see and marvel at how well this works by trying out the
newly added t/t4003-diff-rename-1.sh test script.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-cache.txt  |    5 
Documentation/git-diff-files.txt  |    5 
Documentation/git-diff-helper.txt |    4 
Documentation/git-diff-tree.txt   |    6 
Makefile                          |    5 
diff-cache.c                      |    8 
diff-files.c                      |    7 
diff-helper.c                     |   25 +
diff-tree.c                       |    8 
diff.c                            |  703 +++++++++++++++-----------------------
diffcore-rename.c                 |  443 +++++++++++++++++++++++
diffcore.h                        |   60 +++
git-apply-patch-script            |    2 
t/t0000-basic.sh                  |    2 
t/t4001-diff-rename.sh            |    4 
t/t4003-diff-rename-1.sh          |   93 +++++
16 files changed, 946 insertions(+), 434 deletions(-)
new file (100644): diffcore-rename.c
new file (100644): diffcore.h
new file (100755): t/t4003-diff-rename-1.sh

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [--cached] <tree-ish>
+'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [--cached] <tree-ish>
 
 DESCRIPTION
 -----------
@@ -36,6 +36,9 @@ OPTIONS
 -M::
 	Detect renames; implies -p.
 
+-C::
+	Detect copies as well as renames; implies -p.
+
 -R::
 	Output diff in reverse.
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the w
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-R] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -32,6 +32,9 @@ OPTIONS
 -M::
 	Detect renames; implies -p.
 
+-C::
+	Detect copies as well as renames; implies -p.
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
-'git-diff-helper' [-z] [-R] [-M]
+'git-diff-helper' [-z] [-R] [-M] [-C]
 
 DESCRIPTION
 -----------
@@ -34,6 +34,8 @@ OPTIONS
 -M::
 	Detect renames.
 
+-C::
+	Detect copies as well as renames.
 
 See Also
 --------
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -36,6 +36,10 @@ OPTIONS
 -M::
 	Detect renames; implies -p, in turn implying also '-r'.
 
+-C::
+	Detect copies as well as renames; implies -p, in turn
+	implying also '-r'.
+
 -R::
 	Output diff in reverse.
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
 
 LIB_H += diff.h
-LIB_OBJS += diff.o
+LIB_OBJS += diff.o diffcore-rename.o
 
 LIB_OBJS += gitenv.o
 
@@ -121,9 +121,10 @@ object.o: $(LIB_H)
 read-cache.o: $(LIB_H)
 sha1_file.o: $(LIB_H)
 usage.o: $(LIB_H)
-diff.o: $(LIB_H)
 strbuf.o: $(LIB_H)
 gitenv.o: $(LIB_H)
+diff.o: $(LIB_H)
+diffcore-rename.o : $(LIB_H)
 
 test: all
 	make -C t/ all
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -153,7 +153,7 @@ static void mark_merge_entries(void)
 }
 
 static char *diff_cache_usage =
-"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-R] [--cached] <tree-ish>";
+"git-diff-cache [-p] [-r] [-z] [-m] [-M] [-C] [-R] [--cached] <tree-ish>";
 
 int main(int argc, char **argv)
 {
@@ -180,6 +180,12 @@ int main(int argc, char **argv)
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
+		if (!strncmp(arg, "-C", 2)) {
+			generate_patch = 1;
+			detect_rename = 2;
+			diff_score_opt = diff_scoreopt_parse(arg);
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = '\0';
 			continue;
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -7,7 +7,7 @@
 #include "diff.h"
 
 static const char *diff_files_usage =
-"git-diff-files [-p] [-q] [-r] [-z] [-M] [-R] [paths...]";
+"git-diff-files [-p] [-q] [-r] [-z] [-M] [-C] [-R] [paths...]";
 
 static int generate_patch = 0;
 static int line_termination = '\n';
@@ -71,6 +71,11 @@ int main(int argc, char **argv)
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
 			detect_rename = generate_patch = 1;
 		}
+		else if (!strncmp(argv[1], "-C", 2)) {
+			diff_score_opt = diff_scoreopt_parse(argv[1]);
+			detect_rename = 2;
+			generate_patch = 1;
+		}
 		else
 			usage(diff_files_usage);
 		argv++; argc--;
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -8,6 +8,7 @@
 
 static int detect_rename = 0;
 static int diff_score_opt = 0;
+static int generate_patch = 1;
 
 static int parse_oneside_change(const char *cp, int *mode,
 				unsigned char *sha1, char *path)
@@ -20,7 +21,8 @@ static int parse_oneside_change(const ch
 		cp++;
 	}
 	*mode = m;
-	if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6))
+	if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6) &&
+	    strncmp(cp, "\ttree\t", 6) && strncmp(cp, " tree ", 6))
 		return -1;
 	cp += 6;
 	if (get_sha1_hex(cp, sha1))
@@ -44,11 +46,13 @@ static int parse_diff_raw_output(const c
 		diff_unmerge(cp + 1);
 		break;
 	case '+':
-		parse_oneside_change(cp, &new_mode, new_sha1, path);
+		if (parse_oneside_change(cp, &new_mode, new_sha1, path))
+			return -1;
 		diff_addremove('+', new_mode, new_sha1, path, NULL);
 		break;
 	case '-':
-		parse_oneside_change(cp, &old_mode, old_sha1, path);
+		if (parse_oneside_change(cp, &old_mode, old_sha1, path))
+			return -1;
 		diff_addremove('-', old_mode, old_sha1, path, NULL);
 		break;
 	case '*':
@@ -64,7 +68,8 @@ static int parse_diff_raw_output(const c
 			new_mode = (new_mode << 3) | (ch - '0');
 			cp++;
 		}
-		if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6))
+		if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6) &&
+		    strncmp(cp, "\ttree\t", 6) && strncmp(cp, " tree ", 6))
 			return -1;
 		cp += 6;
 		if (get_sha1_hex(cp, old_sha1))
@@ -88,7 +93,7 @@ static int parse_diff_raw_output(const c
 }
 
 static const char *diff_helper_usage =
-	"git-diff-helper [-z] [-R] [-M] paths...";
+	"git-diff-helper [-z] [-R] [-M] [-C] paths...";
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
@@ -102,17 +107,25 @@ int main(int ac, const char **av) {
 			reverse = 1;
 		else if (av[1][1] == 'z')
 			line_termination = 0;
+		else if (av[1][1] == 'p') /* hidden from the help */
+			generate_patch = 0;
 		else if (av[1][1] == 'M') {
 			detect_rename = 1;
 			diff_score_opt = diff_scoreopt_parse(av[1]);
 		}
+		else if (av[1][1] == 'C') {
+			detect_rename = 2;
+			diff_score_opt = diff_scoreopt_parse(av[1]);
+		}
 		else
 			usage(diff_helper_usage);
 		ac--; av++;
 	}
 	/* the remaining parameters are paths patterns */
 
-	diff_setup(detect_rename, diff_score_opt, reverse, -1, av+1, ac-1);
+	diff_setup(detect_rename, diff_score_opt, reverse,
+		   (generate_patch ? -1 : line_termination),
+		   av+1, ac-1);
 
 	while (1) {
 		int status;
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -430,7 +430,7 @@ static int diff_tree_stdin(char *line)
 }
 
 static char *diff_tree_usage =
-"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-R] [-m] [-s] [-v] <tree-ish> <tree-ish>";
+"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-m] [-s] [-v] <tree-ish> <tree-ish>";
 
 int main(int argc, char **argv)
 {
@@ -478,6 +478,12 @@ int main(int argc, char **argv)
 			diff_score_opt = diff_scoreopt_parse(arg);
 			continue;
 		}
+		if (!strncmp(arg, "-C", 2)) {
+			detect_rename = 2;
+			recursive = generate_patch = 1;
+			diff_score_opt = diff_scoreopt_parse(arg);
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = '\0';
 			continue;
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -7,12 +7,17 @@
 #include <limits.h>
 #include "cache.h"
 #include "diff.h"
-#include "delta.h"
+#include "diffcore.h"
 
 static const char *diff_opts = "-pu";
 static unsigned char null_sha1[20] = { 0, };
-#define MAX_SCORE 10000
-#define DEFAULT_MINIMUM_SCORE 5000
+
+static int detect_rename;
+static int reverse_diff;
+static int diff_raw_output = -1;
+static const char **pathspec;
+static int speccnt;
+static int minimum_score;
 
 static const char *external_diff(void)
 {
@@ -77,26 +82,16 @@ static char *sq_expand(const char *src)
 }
 
 static struct diff_tempfile {
-	const char *name;
+	const char *name; /* filename external diff should read from */
 	char hex[41];
 	char mode[10];
 	char tmp_path[50];
 } diff_temp[2];
 
-struct diff_spec {
-	unsigned char blob_sha1[20];
-	unsigned short mode;	 /* file mode */
-	unsigned sha1_valid : 1; /* if true, use blob_sha1 and trust mode;
-				  * if false, use the name and read from
-				  * the filesystem.
-				  */
-	unsigned file_valid : 1; /* if false the file does not exist */
-};
-
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_tempfile *temp,
-			 int rename_score)
+			 const char *xfrm_msg)
 {
 	int i, next_at, cmd_size;
 	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
@@ -151,14 +146,9 @@ static void builtin_diff(const char *nam
 			printf("old mode %s\n", temp[0].mode);
 			printf("new mode %s\n", temp[1].mode);
 		}
-		if (strcmp(name_a, name_b)) {
-			if (0 < rename_score)
-				printf("rename similarity index %d%%\n",
-				       (int)(0.5+
-					     rename_score*100.0/MAX_SCORE));
-			printf("rename old %s\n", name_a);
-			printf("rename new %s\n", name_b);
-		}
+		if (xfrm_msg && xfrm_msg[0])
+			fputs(xfrm_msg, stdout);
+
 		if (strncmp(temp[0].mode, temp[1].mode, 3))
 			/* we do not run diff between different kind
 			 * of objects.
@@ -169,6 +159,28 @@ static void builtin_diff(const char *nam
 	execlp("/bin/sh","sh", "-c", cmd, NULL);
 }
 
+struct diff_filespec *alloc_filespec(const char *path)
+{
+	int namelen = strlen(path);
+	struct diff_filespec *spec = xmalloc(sizeof(*spec) + namelen + 1);
+	spec->path = (char *)(spec + 1);
+	strcpy(spec->path, path);
+	spec->should_free = spec->should_munmap = spec->file_valid = 0;
+	spec->xfrm_flags = 0;
+	spec->size = 0;
+	spec->data = 0;
+	return spec;
+}
+
+void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
+		   unsigned short mode)
+{
+	spec->mode = mode;
+	memcpy(spec->sha1, sha1, 20);
+	spec->sha1_valid = !!memcmp(sha1, null_sha1, 20);
+	spec->file_valid = 1;
+}
+
 /*
  * Given a name and sha1 pair, if the dircache tells us the file in
  * the work tree has that object contents, return true, so that
@@ -201,13 +213,86 @@ static int work_tree_matches(const char 
 		return 0;
 	ce = active_cache[pos];
 	if ((lstat(name, &st) < 0) ||
-	    !S_ISREG(st.st_mode) ||
+	    !S_ISREG(st.st_mode) || /* careful! */
 	    ce_match_stat(ce, &st) ||
 	    memcmp(sha1, ce->sha1, 20))
 		return 0;
+	/* we return 1 only when we can stat, it is a regular file,
+	 * stat information matches, and sha1 recorded in the cache
+	 * matches.  I.e. we know the file in the work tree really is
+	 * the same as the <name, sha1> pair.
+	 */
 	return 1;
 }
 
+/*
+ * While doing rename detection and pickaxe operation, we may need to
+ * grab the data for the blob (or file) for our own in-core comparison.
+ * diff_filespec has data and size fields for this purpose.
+ */
+int diff_populate_filespec(struct diff_filespec *s)
+{
+	int err = 0;
+	if (!s->file_valid)
+		die("internal error: asking to populate invalid file.");
+	if (S_ISDIR(s->mode))
+		return -1;
+
+	if (s->data)
+		return err;
+	if (!s->sha1_valid ||
+	    work_tree_matches(s->path, s->sha1)) {
+		struct stat st;
+		int fd;
+		if (lstat(s->path, &st) < 0) {
+			if (errno == ENOENT) {
+			err_empty:
+				err = -1;
+			empty:
+				s->data = "";
+				s->size = 0;
+				return err;
+			}
+		}
+		s->size = st.st_size;
+		if (!s->size)
+			goto empty;
+		if (S_ISLNK(st.st_mode)) {
+			int ret;
+			s->data = xmalloc(s->size);
+			s->should_free = 1;
+			ret = readlink(s->path, s->data, s->size);
+			if (ret < 0) {
+				free(s->data);
+				goto err_empty;
+			}
+			return 0;
+		}
+		fd = open(s->path, O_RDONLY);
+		if (fd < 0)
+			goto err_empty;
+		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		s->should_munmap = 1;
+		close(fd);
+	}
+	else {
+		char type[20];
+		s->data = read_sha1_file(s->sha1, type, &s->size);
+		s->should_free = 1;
+	}
+	return 0;
+}
+
+void diff_free_filespec_data(struct diff_filespec *s)
+{
+	if (s->should_free)
+		free(s->data);
+	else if (s->should_munmap)
+		munmap(s->data, s->size);
+	s->should_free = s->should_munmap = 0;
+	s->data = 0;
+}
+
 static void prep_temp_blob(struct diff_tempfile *temp,
 			   void *blob,
 			   unsigned long size,
@@ -231,7 +316,7 @@ static void prep_temp_blob(struct diff_t
 
 static void prepare_temp_file(const char *name,
 			      struct diff_tempfile *temp,
-			      struct diff_spec *one)
+			      struct diff_filespec *one)
 {
 	if (!one->file_valid) {
 	not_a_valid_file:
@@ -245,13 +330,12 @@ static void prepare_temp_file(const char
 	}
 
 	if (!one->sha1_valid ||
-	    work_tree_matches(name, one->blob_sha1)) {
+	    work_tree_matches(name, one->sha1)) {
 		struct stat st;
-		temp->name = name;
-		if (lstat(temp->name, &st) < 0) {
+		if (lstat(name, &st) < 0) {
 			if (errno == ENOENT)
 				goto not_a_valid_file;
-			die("stat(%s): %s", temp->name, strerror(errno));
+			die("stat(%s): %s", name, strerror(errno));
 		}
 		if (S_ISLNK(st.st_mode)) {
 			int ret;
@@ -263,31 +347,27 @@ static void prepare_temp_file(const char
 				die("readlink(%s)", name);
 			prep_temp_blob(temp, buf, st.st_size,
 				       (one->sha1_valid ?
-					one->blob_sha1 : null_sha1),
+					one->sha1 : null_sha1),
 				       (one->sha1_valid ?
 					one->mode : S_IFLNK));
 		}
 		else {
+			/* we can borrow from the file in the work tree */
+			temp->name = name;
 			if (!one->sha1_valid)
 				strcpy(temp->hex, sha1_to_hex(null_sha1));
 			else
-				strcpy(temp->hex, sha1_to_hex(one->blob_sha1));
+				strcpy(temp->hex, sha1_to_hex(one->sha1));
 			sprintf(temp->mode, "%06o",
 				S_IFREG |ce_permissions(st.st_mode));
 		}
 		return;
 	}
 	else {
-		void *blob;
-		char type[20];
-		unsigned long size;
-
-		blob = read_sha1_file(one->blob_sha1, type, &size);
-		if (!blob || strcmp(type, "blob"))
-			die("unable to read blob object for %s (%s)",
-			    name, sha1_to_hex(one->blob_sha1));
-		prep_temp_blob(temp, blob, size, one->blob_sha1, one->mode);
-		free(blob);
+		if (diff_populate_filespec(one))
+			die("cannot read data blob for %s", one->path);
+		prep_temp_blob(temp, one->data, one->size,
+			       one->sha1, one->mode);
 	}
 }
 
@@ -307,13 +387,6 @@ static void remove_tempfile_on_signal(in
 	remove_tempfile();
 }
 
-static int detect_rename;
-static int reverse_diff;
-static int diff_raw_output = -1;
-static const char **pathspec;
-static int speccnt;
-static int minimum_score;
-
 static int matches_pathspec(const char *name)
 {
 	int i;
@@ -341,9 +414,9 @@ static int matches_pathspec(const char *
  */
 static void run_external_diff(const char *name,
 			      const char *other,
-			      struct diff_spec *one,
-			      struct diff_spec *two,
-			      int rename_score)
+			      struct diff_filespec *one,
+			      struct diff_filespec *two,
+			      const char *xfrm_msg)
 {
 	struct diff_tempfile *temp = diff_temp;
 	pid_t pid;
@@ -373,7 +446,7 @@ static void run_external_diff(const char
 		const char *pgm = external_diff();
 		if (pgm) {
 			if (one && two) {
-				const char *exec_arg[9];
+				const char *exec_arg[10];
 				const char **arg = &exec_arg[0];
 				*arg++ = pgm;
 				*arg++ = name;
@@ -383,9 +456,11 @@ static void run_external_diff(const char
 				*arg++ = temp[1].name;
 				*arg++ = temp[1].hex;
 				*arg++ = temp[1].mode;
-				if (other)
+				if (other) {
 					*arg++ = other;
-				*arg = NULL;
+					*arg++ = xfrm_msg;
+				}
+				*arg = 0;
 				execvp(pgm, (char *const*) exec_arg);
 			}
 			else
@@ -395,7 +470,7 @@ static void run_external_diff(const char
 		 * otherwise we use the built-in one.
 		 */
 		if (one && two)
-			builtin_diff(name, other ? : name, temp, rename_score);
+			builtin_diff(name, other ? : name, temp, xfrm_msg);
 		else
 			printf("* Unmerged path %s\n", name);
 		exit(0);
@@ -418,335 +493,166 @@ static void run_external_diff(const char
 	remove_tempfile();
 }
 
-/*
- * We do not detect circular renames.  Just hold created and deleted
- * entries and later attempt to match them up.  If they do not match,
- * then spit them out as deletes or creates as original.
- */
-
-static struct diff_spec_hold {
-	struct diff_spec_hold *next;
-	struct diff_spec it;
-	unsigned long size;
-	int flags;
-#define MATCHED 1
-#define SHOULD_FREE 2
-#define SHOULD_MUNMAP 4
-	void *data;
-	char path[1];
-} *createdfile, *deletedfile;
-
-static void hold_diff(const char *name,
-		      struct diff_spec *one,
-		      struct diff_spec *two)
-{
-	struct diff_spec_hold **list, *elem;
-
-	if (one->file_valid && two->file_valid)
-		die("internal error");
-
-	if (!detect_rename) {
-		run_external_diff(name, NULL, one, two, -1);
-		return;
-	}
-	elem = xmalloc(sizeof(*elem) + strlen(name));
-	strcpy(elem->path, name);
-	elem->size = 0;
-	elem->data = NULL;
-	elem->flags = 0;
-	if (one->file_valid) {
-		list = &deletedfile;
-		elem->it = *one;
-	}
-	else {
-		list = &createdfile;
-		elem->it = *two;
-	}
-	elem->next = *list;
-	*list = elem;
-}
-
-static int populate_data(struct diff_spec_hold *s)
+int diff_scoreopt_parse(const char *opt)
 {
-	char type[20];
+	int diglen, num, scale, i;
+	if (opt[0] != '-' || (opt[1] != 'M' && opt[1] != 'C'))
+		return -1; /* that is not a -M nor -C option */
+	diglen = strspn(opt+2, "0123456789");
+	if (diglen == 0 || strlen(opt+2) != diglen)
+		return 0; /* use default */
+	sscanf(opt+2, "%d", &num);
+	for (i = 0, scale = 1; i < diglen; i++)
+		scale *= 10;
 
-	if (s->data)
-		return 0;
-	if (s->it.sha1_valid) {
-		s->data = read_sha1_file(s->it.blob_sha1, type, &s->size);
-		s->flags |= SHOULD_FREE;
-	}
-	else {
-		struct stat st;
-		int fd;
-		fd = open(s->path, O_RDONLY);
-		if (fd < 0)
-			return -1;
-		if (fstat(fd, &st)) {
-			close(fd);
-			return -1;
-		}
-		s->size = st.st_size;
-		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
-		close(fd);
-		if (!s->size)
-			s->data = "";
-		else
-			s->flags |= SHOULD_MUNMAP;
-	}
-	return 0;
+	/* user says num divided by scale and we say internally that
+	 * is MAX_SCORE * num / scale.
+	 */
+	return MAX_SCORE * num / scale;
 }
 
-static void free_data(struct diff_spec_hold *s)
+void diff_setup(int detect_rename_, int minimum_score_, int reverse_diff_,
+		int diff_raw_output_,
+		const char **pathspec_, int speccnt_)
 {
-	if (s->flags & SHOULD_FREE)
-		free(s->data);
-	else if (s->flags & SHOULD_MUNMAP)
-		munmap(s->data, s->size);
-	s->flags &= ~(SHOULD_FREE|SHOULD_MUNMAP);
-	s->data = NULL;
+	detect_rename = detect_rename_;
+	reverse_diff = reverse_diff_;
+	pathspec = pathspec_;
+	diff_raw_output = diff_raw_output_;
+	speccnt = speccnt_;
+	minimum_score = minimum_score_ ? : DEFAULT_MINIMUM_SCORE;
 }
 
-static void flush_remaining_diff(struct diff_spec_hold *elem,
-				 int on_created_list)
-{
-	static struct diff_spec null_file_spec;
+static struct diff_queue_struct queued_diff;
 
-	null_file_spec.file_valid = 0;
-	for ( ; elem ; elem = elem->next) {
-		free_data(elem);
-		if (elem->flags & MATCHED)
-			continue;
-		if (on_created_list)
-			run_external_diff(elem->path, NULL,
-					  &null_file_spec, &elem->it, -1);
-		else
-			run_external_diff(elem->path, NULL,
-					  &elem->it, &null_file_spec, -1);
+struct diff_file_pair *diff_queue(struct diff_queue_struct *queue,
+				  struct diff_filespec *one,
+				  struct diff_filespec *two)
+{
+	struct diff_file_pair *dp = xmalloc(sizeof(*dp));
+	dp->one = one;
+	dp->two = two;
+	dp->xfrm_msg = 0;
+	dp->orig_order = queue->nr;
+	dp->xfrm_work = 0;
+	if (queue->alloc <= queue->nr) {
+		queue->alloc = alloc_nr(queue->alloc);
+		queue->queue = xrealloc(queue->queue,
+				       sizeof(dp) * queue->alloc);
 	}
+	queue->queue[queue->nr++] = dp;
+	return dp;
 }
 
-static int is_exact_match(struct diff_spec_hold *src,
-			  struct diff_spec_hold *dst)
+static const char *git_object_type(unsigned mode)
 {
-	if (src->it.sha1_valid && dst->it.sha1_valid &&
-	    !memcmp(src->it.blob_sha1, dst->it.blob_sha1, 20))
-		return 1;
-	if (populate_data(src) || populate_data(dst))
-		/* this is an error but will be caught downstream */
-		return 0;
-	if (src->size == dst->size &&
-	    !memcmp(src->data, dst->data, src->size))
-		return 1;
-	return 0;
+	return S_ISDIR(mode) ? "tree" : "blob";
 }
 
-static int estimate_similarity(struct diff_spec_hold *src, struct diff_spec_hold *dst)
+static void diff_flush_raw(struct diff_file_pair *p)
 {
-	/* src points at a deleted file and dst points at a created
-	 * file.  They may be quite similar, in which case we want to
-	 * say src is renamed to dst.
-	 *
-	 * Compare them and return how similar they are, representing
-	 * the score as an integer between 0 and 10000, except
-	 * where they match exactly it is considered better than anything
-	 * else.
-	 */
-	void *delta;
-	unsigned long delta_size;
-	int score;
-
-	delta_size = ((src->size < dst->size) ?
-		      (dst->size - src->size) : (src->size - dst->size));
-
-	/* We would not consider rename followed by more than
-	 * minimum_score/MAX_SCORE edits; that is, delta_size must be smaller
-	 * than (src->size + dst->size)/2 * minimum_score/MAX_SCORE,
-	 * which means...
-	 */
-
-	if ((src->size+dst->size)*minimum_score < delta_size*MAX_SCORE*2)
-		return 0;
+	struct diff_filespec *it;
+	int addremove;
 
-	delta = diff_delta(src->data, src->size,
-			   dst->data, dst->size,
-			   &delta_size);
-	free(delta);
+	/* raw output does not have a way to express rename nor copy */
+	if (strcmp(p->one->path, p->two->path))
+		return;
 
-	/* This "delta" is really xdiff with adler32 and all the
-	 * overheads but it is a quick and dirty approximation.
-	 *
-	 * Now we will give some score to it.  100% edit gets
-	 * 0 points and 0% edit gets MAX_SCORE points.  That is, every
-	 * 1/MAX_SCORE edit gets 1 point penalty.  The amount of penalty is:
-	 *
-	 * (delta_size * 2 / (src->size + dst->size)) * MAX_SCORE
-	 *
-	 */
-	score = MAX_SCORE-(MAX_SCORE*2*delta_size/(src->size+dst->size));
-	if (score < 0) return 0;
-	if (MAX_SCORE < score) return MAX_SCORE;
-	return score;
-}
+	if (p->one->file_valid && p->two->file_valid) {
+		char hex[41];
+		strcpy(hex, sha1_to_hex(p->one->sha1));
+		printf("*%06o->%06o %s %s->%s %s%c",
+		       p->one->mode, p->two->mode,
+		       git_object_type(p->one->mode),
+		       hex, sha1_to_hex(p->two->sha1),
+		       p->one->path, diff_raw_output);
+		return;
+	}
 
-struct diff_score {
-	struct diff_spec_hold *src;
-	struct diff_spec_hold *dst;
-	int score;
-};
+	if (p->one->file_valid) {
+		it = p->one;
+		addremove = '-';
+	} else {
+		it = p->two;
+		addremove = '+';
+	}
 
-static int score_compare(const void *a_, const void *b_)
-{
-	const struct diff_score *a = a_, *b = b_;
-	return b->score - a->score;
+	printf("%c%06o %s %s %s%c",
+	       addremove,
+	       it->mode, git_object_type(it->mode),
+	       sha1_to_hex(it->sha1), it->path, diff_raw_output);
 }
 
-static void flush_rename_pair(struct diff_spec_hold *src,
-			      struct diff_spec_hold *dst,
-			      int rename_score)
+static void diff_flush_patch(struct diff_file_pair *p)
 {
-	src->flags |= MATCHED;
-	dst->flags |= MATCHED;
-	free_data(src);
-	free_data(dst);
-	run_external_diff(src->path, dst->path,
-			  &src->it, &dst->it, rename_score);
-}
+	const char *name, *other;
 
-static void free_held_diff(struct diff_spec_hold *list)
-{
-	struct diff_spec_hold *h;
-	for (h = list; list; list = h) {
-		h = list->next;
-		free_data(list);
-		free(list);
-	}
+	name = p->one->path;
+	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	if ((p->one->file_valid && S_ISDIR(p->one->mode)) ||
+	    (p->two->file_valid && S_ISDIR(p->two->mode)))
+		return; /* no tree diffs in patch format */ 
+
+	run_external_diff(name, other, p->one, p->two, p->xfrm_msg);
 }
 
-void diff_flush(void)
+static int identical(struct diff_filespec *one, struct diff_filespec *two)
 {
-	int num_create, num_delete, c, d;
-	struct diff_spec_hold *elem, *src, *dst;
-	struct diff_score *mx;
-
-	/* We really want to cull the candidates list early
-	 * with cheap tests in order to avoid doing deltas.
-	 *
-	 * With the current callers, we should not have already
-	 * matched entries at this point, but it is nonetheless
-	 * checked for sanity.
+	/* This function is written stricter than necessary to support
+	 * the currently implemented transformers, but the idea is to
+	 * let transformers to produce diff_file_pairs any way they want,
+	 * and filter and clean them up here before producing the output.
 	 */
-	for (dst = createdfile; dst; dst = dst->next) {
-		if (dst->flags & MATCHED)
-			continue;
-		for (src = deletedfile; src; src = src->next) {
-			if (src->flags & MATCHED)
-				continue;
-			if (! is_exact_match(src, dst))
-				continue;
-			flush_rename_pair(src, dst, MAX_SCORE);
-			break;
-		}
-	}
-
-	/* Count surviving candidates */
-	for (num_create = 0, elem = createdfile; elem; elem = elem->next)
-		if (!(elem->flags & MATCHED))
-			num_create++;
-
-	for (num_delete = 0, elem = deletedfile; elem; elem = elem->next)
-		if (!(elem->flags & MATCHED))
-			num_delete++;
-
-	if (num_create == 0 ||  num_delete == 0)
-		goto exit_path;
-
-	mx = xmalloc(sizeof(*mx) * num_create * num_delete);
-	for (c = 0, dst = createdfile; dst; dst = dst->next) {
-		int base = c * num_delete;
-		if (dst->flags & MATCHED)
-			continue;
-		for (d = 0, src = deletedfile; src; src = src->next) {
-			struct diff_score *m = &mx[base+d];
-			if (src->flags & MATCHED)
-				continue;
-			m->src = src;
-			m->dst = dst;
-			m->score = estimate_similarity(src, dst);
-			d++;
-		}
-		c++;
-	}
-	qsort(mx, num_create*num_delete, sizeof(*mx), score_compare);
-
-#if 0
- 	for (c = 0; c < num_create * num_delete; c++) {
-		src = mx[c].src;
-		dst = mx[c].dst;
-		if ((src->flags & MATCHED) || (dst->flags & MATCHED))
-			continue;
-		fprintf(stderr,
-			"**score ** %d %s %s\n",
-			mx[c].score, src->path, dst->path);
-	}
-#endif
-
- 	for (c = 0; c < num_create * num_delete; c++) {
-		src = mx[c].src;
-		dst = mx[c].dst;
-		if ((src->flags & MATCHED) || (dst->flags & MATCHED))
-			continue;
-		if (mx[c].score < minimum_score)
-			break;
-		flush_rename_pair(src, dst, mx[c].score);
-	}
-	free(mx);
-
- exit_path:
-	flush_remaining_diff(createdfile, 1);
-	flush_remaining_diff(deletedfile, 0);
-	free_held_diff(createdfile);
-	free_held_diff(deletedfile);
-	createdfile = deletedfile = NULL;
-}
 
-int diff_scoreopt_parse(const char *opt)
-{
-	int diglen, num, scale, i;
-	if (opt[0] != '-' || opt[1] != 'M')
-		return -1; /* that is not -M option */
-	diglen = strspn(opt+2, "0123456789");
-	if (diglen == 0 || strlen(opt+2) != diglen)
-		return 0; /* use default */
-	sscanf(opt+2, "%d", &num);
-	for (i = 0, scale = 1; i < diglen; i++)
-		scale *= 10;
+	if (!one->file_valid && !two->file_valid)
+		return 1; /* not interesting */
 
-	/* user says num divided by scale and we say internally that
-	 * is MAX_SCORE * num / scale.
+	/* deletion, addition, mode change and renames are all interesting. */
+	if ((one->file_valid != two->file_valid) || (one->mode != two->mode) ||
+	    strcmp(one->path, two->path))
+		return 0;
+
+	/* both are valid and point at the same path.  that is, we are
+	 * dealing with a change.
 	 */
-	return MAX_SCORE * num / scale;
+	if (one->sha1_valid && two->sha1_valid &&
+	    !memcmp(one->sha1, two->sha1, sizeof(one->sha1)))
+		return 1; /* no change */
+	if (!one->sha1_valid && !two->sha1_valid)
+		return 1; /* both look at the same file on the filesystem. */
+	return 0;
 }
 
-void diff_setup(int detect_rename_, int minimum_score_, int reverse_diff_,
-		int diff_raw_output_,
-		const char **pathspec_, int speccnt_)
+static void diff_flush_one(struct diff_file_pair *p)
 {
-	free_held_diff(createdfile);
-	free_held_diff(deletedfile);
-	createdfile = deletedfile = NULL;
-
-	detect_rename = detect_rename_;
-	reverse_diff = reverse_diff_;
-	pathspec = pathspec_;
-	diff_raw_output = diff_raw_output_;
-	speccnt = speccnt_;
-	minimum_score = minimum_score_ ? : DEFAULT_MINIMUM_SCORE;
+	if (identical(p->one, p->two))
+		return;
+	if (0 <= diff_raw_output)
+		diff_flush_raw(p);
+	else
+		diff_flush_patch(p);
 }
 
-static const char *git_object_type(unsigned mode)
+void diff_flush(void)
 {
-	return S_ISDIR(mode) ? "tree" : "blob";
+	struct diff_queue_struct *q = &queued_diff;
+	int i;
+
+	if (detect_rename)
+		diff_detect_rename(q, detect_rename, minimum_score);
+	for (i = 0; i < q->nr; i++)
+		diff_flush_one(q->queue[i]);
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_file_pair *p = q->queue[i];
+		diff_free_filespec_data(p->one);
+		diff_free_filespec_data(p->two);
+		free(p->xfrm_msg);
+		free(p);
+	}
+	free(q->queue);
+	q->queue = NULL;
+	q->nr = q->alloc = 0;
 }
 
 void diff_addremove(int addremove, unsigned mode,
@@ -754,41 +660,35 @@ void diff_addremove(int addremove, unsig
 		    const char *base, const char *path)
 {
 	char concatpath[PATH_MAX];
-	struct diff_spec spec[2], *one, *two;
+	struct diff_filespec *one, *two;
 
+	/* This may look odd, but it is a preparation for
+	 * feeding "there are unchanged files which should
+	 * not produce diffs, but when you are doing copy
+	 * detection you would need them, so here they are"
+	 * entries to the diff-core.  They will be prefixed
+	 * with something like '=' or '*' (I haven't decided
+	 * which but should not make any difference).
+	 * Feeding the same new and old to diff_change() should
+	 * also have the same effect.  diff_flush() should
+	 * filter the identical ones out at the final output
+	 * stage.
+	 */
 	if (reverse_diff)
-		addremove = (addremove == '+' ? '-' : '+');
-
-	if (0 <= diff_raw_output) {
-		if (!path)
-			path = "";
-		printf("%c%06o %s %s %s%s%c",
-		       addremove,
-		       mode,
-		       git_object_type(mode), sha1_to_hex(sha1),
-		       base, path, diff_raw_output);
-		return;
-	}
-	if (S_ISDIR(mode))
-		return;
+		addremove = (addremove == '+' ? '-' :
+			     addremove == '-' ? '+' : addremove);
 
-	memcpy(spec[0].blob_sha1, sha1, 20);
-	spec[0].mode = mode;
-	spec[0].sha1_valid = !!memcmp(sha1, null_sha1, 20);
-	spec[0].file_valid = 1;
-	spec[1].file_valid = 0;
-
-	if (addremove == '+') {
-		one = spec + 1; two = spec;
-	} else {
-		one = spec; two = one + 1;
-	}
+	if (!path) path = "";
+	sprintf(concatpath, "%s%s", base, path);
+	one = alloc_filespec(concatpath);
+	two = alloc_filespec(concatpath);
+
+	if (addremove != '+')
+		fill_filespec(one, sha1, mode);
+	if (addremove != '-')
+		fill_filespec(two, sha1, mode);
 
-	if (path) {
-		strcpy(concatpath, base);
-		strcat(concatpath, path);
-	}
-	hold_diff(path ? concatpath : base, one, two);
+	diff_queue(&queued_diff, one, two);
 }
 
 void diff_change(unsigned old_mode, unsigned new_mode,
@@ -796,7 +696,7 @@ void diff_change(unsigned old_mode, unsi
 		 const unsigned char *new_sha1,
 		 const char *base, const char *path) {
 	char concatpath[PATH_MAX];
-	struct diff_spec spec[2];
+	struct diff_filespec *one, *two;
 
 	if (reverse_diff) {
 		unsigned tmp;
@@ -804,41 +704,14 @@ void diff_change(unsigned old_mode, unsi
 		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
 		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
 	}
+	if (!path) path = "";
+	sprintf(concatpath, "%s%s", base, path);
+	one = alloc_filespec(concatpath);
+	two = alloc_filespec(concatpath);
+	fill_filespec(one, old_sha1, old_mode);
+	fill_filespec(two, new_sha1, new_mode);
 
-	if (0 <= diff_raw_output) {
-		char old_hex[41];
-		strcpy(old_hex, sha1_to_hex(old_sha1));
-
-		if (!path)
-			path = "";
-		printf("*%06o->%06o %s %s->%s %s%s%c",
-		       old_mode, new_mode,
-		       git_object_type(new_mode),
-		       old_hex, sha1_to_hex(new_sha1),
-		       base, path, diff_raw_output);
-		return;
-	}
-	if (S_ISDIR(new_mode))
-		return;
-
-	if (path) {
-		strcpy(concatpath, base);
-		strcat(concatpath, path);
-	}
-
-	memcpy(spec[0].blob_sha1, old_sha1, 20);
-	spec[0].mode = old_mode;
-	memcpy(spec[1].blob_sha1, new_sha1, 20);
-	spec[1].mode = new_mode;
-	spec[0].sha1_valid = !!memcmp(old_sha1, null_sha1, 20);
-	spec[1].sha1_valid = !!memcmp(new_sha1, null_sha1, 20);
-	spec[1].file_valid = spec[0].file_valid = 1;
-
-	/* We do not look at changed files as candidate for
-	 * rename detection ever.
-	 */
-	run_external_diff(path ? concatpath : base, NULL,
-			  &spec[0], &spec[1], -1);
+	diff_queue(&queued_diff, one, two);
 }
 
 void diff_unmerge(const char *path)
@@ -847,5 +720,5 @@ void diff_unmerge(const char *path)
 		printf("U %s%c", path, diff_raw_output);
 		return;
 	}
-	run_external_diff(path, NULL, NULL, NULL, -1);
+	run_external_diff(path, NULL, NULL, NULL, NULL);
 }
diff --git a/diffcore-rename.c b/diffcore-rename.c
new file mode 100644
--- /dev/null
+++ b/diffcore-rename.c
@@ -0,0 +1,443 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "delta.h"
+
+struct diff_rename_pool {
+	struct diff_filespec **s;
+	int nr, alloc;
+};
+
+static void diff_rename_pool_clear(struct diff_rename_pool *pool)
+{
+	pool->s = NULL; pool->nr = pool->alloc = 0;
+}
+
+static void diff_rename_pool_add(struct diff_rename_pool *pool,
+				 struct diff_filespec *s)
+{
+	if (S_ISDIR(s->mode))
+		return;  /* rename/copy patch for tree does not make sense. */
+
+	if (pool->alloc <= pool->nr) {
+		pool->alloc = alloc_nr(pool->alloc);
+		pool->s = xrealloc(pool->s,
+				   sizeof(*(pool->s)) * pool->alloc);
+	}
+	pool->s[pool->nr] = s;
+	pool->nr++;
+}
+
+static int is_exact_match(struct diff_filespec *src, struct diff_filespec *dst)
+{
+	if (src->sha1_valid && dst->sha1_valid &&
+	    !memcmp(src->sha1, dst->sha1, 20))
+		return 1;
+	if (diff_populate_filespec(src) || diff_populate_filespec(dst))
+		/* this is an error but will be caught downstream */
+		return 0;
+	if (src->size == dst->size &&
+	    !memcmp(src->data, dst->data, src->size))
+		return 1;
+	return 0;
+}
+
+struct diff_score {
+	struct diff_filespec *src;
+	struct diff_filespec *dst;
+	int score;
+	int rank;
+};
+
+static int estimate_similarity(struct diff_filespec *src,
+			       struct diff_filespec *dst,
+			       int minimum_score)
+{
+	/* src points at a file that existed in the original tree (or
+	 * optionally a file in the destination tree) and dst points
+	 * at a newly created file.  They may be quite similar, in which
+	 * case we want to say src is renamed to dst or src is copied into
+	 * dst, and then some edit has been applied to dst.
+	 *
+	 * Compare them and return how similar they are, representing
+	 * the score as an integer between 0 and 10000, except
+	 * where they match exactly it is considered better than anything
+	 * else.
+	 */
+	void *delta;
+	unsigned long delta_size;
+	int score;
+
+	delta_size = ((src->size < dst->size) ?
+		      (dst->size - src->size) : (src->size - dst->size));
+
+	/* We would not consider rename followed by more than
+	 * minimum_score/MAX_SCORE edits; that is, delta_size must be smaller
+	 * than (src->size + dst->size)/2 * minimum_score/MAX_SCORE,
+	 * which means...
+	 */
+
+	if ((src->size+dst->size)*minimum_score < delta_size*MAX_SCORE*2)
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
+	 * Now we will give some score to it.  100% edit gets
+	 * 0 points and 0% edit gets MAX_SCORE points.  That is, every
+	 * 1/MAX_SCORE edit gets 1 point penalty.  The amount of penalty is:
+	 *
+	 * (delta_size * 2 / (src->size + dst->size)) * MAX_SCORE
+	 *
+	 */
+	score = MAX_SCORE-(MAX_SCORE*2*delta_size/(src->size+dst->size));
+	if (score < 0) return 0;
+	if (MAX_SCORE < score) return MAX_SCORE;
+	return score;
+}
+
+static void record_rename_pair(struct diff_queue_struct *outq,
+			       struct diff_filespec *src,
+			       struct diff_filespec *dst,
+			       int rank,
+			       int score)
+{
+	/* The rank is used to sort the final output, because there
+	 * are certain dependencies.
+	 *
+	 *  - rank #0 depends on deleted ones.
+	 *  - rank #1 depends on kept files before they are modified.
+	 *  - rank #2 depends on kept files after they are modified;
+	 *    currently not used.
+	 *
+	 * Therefore, the final output order should be:
+	 *
+	 *  1. rank #0 rename/copy diffs.
+	 *  2. deletions in the original.
+	 *  3. rank #1 rename/copy diffs.
+	 *  4. additions and modifications in the original.
+	 *  5. rank #2 rename/copy diffs; currently not used.
+	 *
+	 * To achieve this sort order, we give xform_work the number
+	 * above.
+	 */
+	struct diff_file_pair *dp = diff_queue(outq, src, dst);
+	dp->xfrm_work = (rank * 2 + 1) | (score<<RENAME_SCORE_SHIFT);
+	dst->xfrm_flags |= RENAME_DST_MATCHED;
+}
+
+#if 0
+static void debug_filespec(struct diff_filespec *s, int x, const char *one)
+{
+	fprintf(stderr, "queue[%d] %s (%s) %s %06o %s\n",
+		x, one,
+		s->path,
+		s->file_valid ? "valid" : "invalid",
+		s->mode,
+		s->sha1_valid ? sha1_to_hex(s->sha1) : "");
+	fprintf(stderr, "queue[%d] %s size %lu flags %d\n",
+		x, one,
+		s->size, s->xfrm_flags);
+}
+
+static void debug_filepair(const struct diff_file_pair *p, int i)
+{
+	debug_filespec(p->one, i, "one");
+	debug_filespec(p->two, i, "two");
+	fprintf(stderr, "pair flags %d, orig order %d, score %d\n",
+		(p->xfrm_work & ((1<<RENAME_SCORE_SHIFT) - 1)),
+		p->orig_order,
+		(p->xfrm_work >> RENAME_SCORE_SHIFT));
+}
+
+static void debug_queue(const char *msg, struct diff_queue_struct *q)
+{
+	int i;
+	if (msg)
+		fprintf(stderr, "%s\n", msg);
+	fprintf(stderr, "q->nr = %d\n", q->nr);
+	for (i = 0; i < q->nr; i++) {
+		struct diff_file_pair *p = q->queue[i];
+		debug_filepair(p, i);
+	}
+}
+#else
+#define debug_queue(a,b) do { ; /*nothing*/ } while(0)
+#endif
+
+/*
+ * We sort the outstanding diff entries according to the rank (see
+ * comment at the beginning of record_rename_pair) and tiebreak with
+ * the order in the original input.
+ */
+static int rank_compare(const void *a_, const void *b_)
+{
+	const struct diff_file_pair *a = *(const struct diff_file_pair **)a_;
+	const struct diff_file_pair *b = *(const struct diff_file_pair **)b_;
+	int a_rank = a->xfrm_work & ((1<<RENAME_SCORE_SHIFT) - 1);
+	int b_rank = b->xfrm_work & ((1<<RENAME_SCORE_SHIFT) - 1);
+
+	if (a_rank != b_rank)
+		return a_rank - b_rank;
+	return a->orig_order - b->orig_order;
+}
+
+/*
+ * We sort the rename similarity matrix with the score, in descending
+ * order (more similar first).
+ */
+static int score_compare(const void *a_, const void *b_)
+{
+	const struct diff_score *a = a_, *b = b_;
+	return b->score - a->score;
+}
+
+static int needs_to_stay(struct diff_queue_struct *q, int i,
+			 struct diff_filespec *it)
+{
+	/* If it will be used in later entry (either stay or used
+	 * as the source of rename/copy), we need to copy, not rename.
+	 */
+	while (i < q->nr) {
+		struct diff_file_pair *p = q->queue[i++];
+		if (!p->two->file_valid)
+			continue; /* removed is fine */
+		if (strcmp(p->one->path, it->path))
+			continue; /* not relevant */
+
+		/* p has its src set to *it and it is not a delete;
+		 * it will be used for in-place change or rename/copy,
+		 * so we cannot rename it out.
+		 */
+		return 1;
+	}
+	return 0;
+}
+
+void diff_detect_rename(struct diff_queue_struct *q,
+			int detect_rename,
+			int minimum_score)
+{
+	struct diff_queue_struct outq;
+	struct diff_rename_pool created, deleted, stay;
+	struct diff_rename_pool *(srcs[2]);
+	struct diff_score *mx;
+	int h, i, j;
+	int num_create, num_src, dst_cnt, src_cnt;
+
+	outq.queue = NULL;
+	outq.nr = outq.alloc = 0;
+
+	diff_rename_pool_clear(&created);
+	diff_rename_pool_clear(&deleted);
+	diff_rename_pool_clear(&stay);
+
+	srcs[0] = &deleted;
+	srcs[1] = &stay;
+
+	/* NEEDSWORK:
+	 * (1) make sure we properly ignore but pass trees.
+	 *
+	 * (2) make sure we do right thing on the same path deleted
+	 *     and created in the same patch.
+	 */
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_file_pair *p = q->queue[i];
+		if (!p->one->file_valid)
+			if (!p->two->file_valid)
+				continue; /* ignore nonsense */
+			else
+				diff_rename_pool_add(&created, p->two);
+		else if (!p->two->file_valid)
+			diff_rename_pool_add(&deleted, p->one);
+		else if (1 < detect_rename) /* find copy, too */
+			diff_rename_pool_add(&stay, p->one);
+	}
+	if (created.nr == 0)
+		goto cleanup; /* nothing to do */
+
+	/* We really want to cull the candidates list early
+	 * with cheap tests in order to avoid doing deltas.
+	 *
+	 * With the current callers, we should not have already
+	 * matched entries at this point, but it is nonetheless
+	 * checked for sanity.
+	 */
+	for (i = 0; i < created.nr; i++) {
+		if (created.s[i]->xfrm_flags & RENAME_DST_MATCHED)
+			continue; /* we have matched exactly already */
+		for (h = 0; h < sizeof(srcs)/sizeof(srcs[0]); h++) {
+			struct diff_rename_pool *p = srcs[h];
+			for (j = 0; j < p->nr; j++) {
+				if (!is_exact_match(p->s[j], created.s[i]))
+					continue;
+				record_rename_pair(&outq,
+						   p->s[j], created.s[i], h,
+						   MAX_SCORE);
+				break; /* we are done with this entry */
+			}
+		}
+	}
+	debug_queue("done detecting exact", &outq);
+
+	/* Have we run out the created file pool?  If so we can avoid
+	 * doing the delta matrix altogether.
+	 */
+	if (outq.nr == created.nr)
+		goto flush_rest;
+
+	num_create = (created.nr - outq.nr);
+	num_src = deleted.nr + stay.nr;
+	mx = xmalloc(sizeof(*mx) * num_create * num_src);
+	for (dst_cnt = i = 0; i < created.nr; i++) {
+		int base = dst_cnt * num_src;
+		if (created.s[i]->xfrm_flags & RENAME_DST_MATCHED)
+			continue; /* dealt with exact match already. */
+		for (src_cnt = h = 0; h < sizeof(srcs)/sizeof(srcs[0]); h++) {
+			struct diff_rename_pool *p = srcs[h];
+			for (j = 0; j < p->nr; j++, src_cnt++) {
+				struct diff_score *m = &mx[base + src_cnt];
+				m->src = p->s[j];
+				m->dst = created.s[i];
+				m->score = estimate_similarity(m->src, m->dst,
+							       minimum_score);
+				m->rank = h;
+			}
+		}
+		dst_cnt++;
+	}
+	/* cost matrix sorted by most to least similar pair */
+	qsort(mx, num_create * num_src, sizeof(*mx), score_compare);
+	for (i = 0; i < num_create * num_src; i++) {
+		if (mx[i].dst->xfrm_flags & RENAME_DST_MATCHED)
+			continue; /* alreayd done, either exact or fuzzy. */
+		if (mx[i].score < minimum_score)
+			continue;
+		record_rename_pair(&outq,
+				  mx[i].src, mx[i].dst, mx[i].rank,
+				  mx[i].score);
+	}
+	free(mx);
+	debug_queue("done detecting fuzzy", &outq);
+
+ flush_rest:
+	/* At this point, we have found some renames and copies and they
+	 * are kept in outq.  The original list is still in *q.
+	 *
+	 * Scan the original list and move them into the outq; we will sort
+	 * outq and swap it into the queue supplied to pass that to
+	 * downstream, so we assign the sort keys in this loop.
+	 *
+	 * See comments at the top of record_rename_pair for numbers used
+	 * to assign xfrm_work.
+	 *
+	 * Note that we have not annotated the diff_file_pair with any comment
+	 * so there is nothing other than p to free.
+	 */
+	for (i = 0; i < q->nr; i++) {
+		struct diff_file_pair *dp, *p = q->queue[i];
+		if (!p->one->file_valid) {
+			if (p->two->file_valid) {
+				/* creation */
+				dp = diff_queue(&outq, p->one, p->two);
+				dp->xfrm_work = 4;
+			}
+			/* otherwise it is a nonsense; just ignore it */
+		}
+		else if (!p->two->file_valid) {
+			/* deletion */
+			dp = diff_queue(&outq, p->one, p->two);
+			dp->xfrm_work = 2;
+		}
+		else {
+			/* modification, or stay as is */
+			dp = diff_queue(&outq, p->one, p->two);
+			dp->xfrm_work = 4;
+		}
+		free(p);
+	}
+	debug_queue("done copying original", &outq);
+
+	/* Sort outq */
+	qsort(outq.queue, outq.nr, sizeof(outq.queue[0]), rank_compare);
+
+	debug_queue("done sorting", &outq);
+
+	free(q->queue);
+	q->nr = q->alloc = 0;
+	q->queue = NULL;
+
+	/* Copy it out to q, removing duplicates. */
+	for (i = 0; i < outq.nr; i++) {
+		struct diff_file_pair *p = outq.queue[i];
+		if (!p->one->file_valid) {
+			/* created */
+			if (p->two->xfrm_flags & RENAME_DST_MATCHED)
+				; /* rename/copy created it already */
+			else
+				diff_queue(q, p->one, p->two);
+		}
+		else if (!p->two->file_valid) {
+			/* deleted */
+			if (p->one->xfrm_flags & RENAME_SRC_GONE)
+				; /* rename/copy deleted it already */
+			else
+				diff_queue(q, p->one, p->two);
+		}
+		else if (strcmp(p->one->path, p->two->path)) {
+			/* rename or copy */
+			struct diff_file_pair *dp =
+				diff_queue(q, p->one, p->two);
+			int msglen = (strlen(p->one->path) +
+				      strlen(p->two->path) + 100);
+			int score = (p->xfrm_work >> RENAME_SCORE_SHIFT);
+			dp->xfrm_msg = xmalloc(msglen);
+
+			/* if we have a later entry that is a rename/copy
+			 * that depends on p->one, then we copy here.
+			 * otherwise we rename it.
+			 */
+			if (needs_to_stay(&outq, i+1, p->one)) {
+				/* copy it */
+				sprintf(dp->xfrm_msg,
+					"similarity index %d%%\n"
+					"copy from %s\n"
+					"copy to %s\n",
+					(int)(0.5 + score * 100 / MAX_SCORE),
+					p->one->path, p->two->path);
+			}
+			else {
+				/* rename it, and mark it as gone. */
+				p->one->xfrm_flags |= RENAME_SRC_GONE;
+				sprintf(dp->xfrm_msg,
+					"similarity index %d%%\n"
+					"rename old %s\n"
+					"rename new %s\n",
+					(int)(0.5 + score * 100 / MAX_SCORE),
+					p->one->path, p->two->path);
+			}
+		}
+		else
+			/* otherwise it is a modified (or stayed) entry */
+			diff_queue(q, p->one, p->two);
+		free(p);
+	}
+
+	free(outq.queue);
+	debug_queue("done collapsing", q);
+
+ cleanup:
+	free(created.s);
+	free(deleted.s);
+	free(stay.s);
+	return;
+}
diff --git a/diffcore.h b/diffcore.h
new file mode 100644
--- /dev/null
+++ b/diffcore.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
+#ifndef _DIFFCORE_H_
+#define _DIFFCORE_H_
+
+/* This header file is internal between diff.c and its diff transformers
+ * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
+ * in anything else.
+ */
+#define MAX_SCORE 10000
+#define DEFAULT_MINIMUM_SCORE 5000
+
+#define RENAME_DST_MATCHED 01
+#define RENAME_SRC_GONE    02
+#define RENAME_SCORE_SHIFT 8
+
+struct diff_filespec {
+	unsigned char sha1[20];
+	char *path;
+	void *data;
+	unsigned long size;
+	int xfrm_flags;		 /* for use by the xfrm */
+	unsigned short mode;	 /* file mode */
+	unsigned sha1_valid : 1; /* if true, use sha1 and trust mode;
+				  * if false, use the name and read from
+				  * the filesystem.
+				  */
+	unsigned file_valid : 1; /* if false the file does not exist */
+	unsigned should_free : 1; /* data should be free()'ed */
+	unsigned should_munmap : 1; /* data should be munmap()'ed */
+};
+
+extern struct diff_filespec *alloc_filespec(const char *);
+extern void fill_filespec(struct diff_filespec *, const unsigned char *,
+			  unsigned short);
+
+extern int diff_populate_filespec(struct diff_filespec *);
+extern void diff_free_filespec_data(struct diff_filespec *);
+
+struct diff_file_pair {
+	struct diff_filespec *one;
+	struct diff_filespec *two;
+	char *xfrm_msg;
+	int orig_order; /* the original order of insertion into the queue */
+	int xfrm_work; /* for use by tramsformers, not by diffcore */
+};
+
+struct diff_queue_struct {
+	struct diff_file_pair **queue;
+	int alloc;
+	int nr;
+};
+
+extern struct diff_file_pair *diff_queue(struct diff_queue_struct *,
+					 struct diff_filespec *,
+					 struct diff_filespec *);
+extern void diff_detect_rename(struct diff_queue_struct *, int, int);
+
+#endif
diff --git a/git-apply-patch-script b/git-apply-patch-script
--- a/git-apply-patch-script
+++ b/git-apply-patch-script
@@ -11,7 +11,7 @@ case "$#" in
 1)
     echo >&2 "cannot handle unmerged diff on path $1."
     exit 1 ;;
-8)
+8 | 9)
     echo >&2 "cannot handle rename diff between $1 and $8 yet."
     exit 1 ;;
 esac
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -32,7 +32,7 @@ test_expect_success \
 find .git/objects -type d -print >full-of-directories
 test_expect_success \
     '.git/objects should have 256 subdirectories.' \
-    'test "$(wc -l full-of-directories | sed -e "s/ .*//")" = 257'
+    'test $(cat full-of-directories | wc -l) = 257'
 
 ################################################################
 # Basics of the basics
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -31,7 +31,7 @@ test_expect_success \
 
 test_expect_success \
     'write that tree.' \
-    'tree=$(git-write-tree)'
+    'tree=$(git-write-tree) && echo $tree'
 
 sed -e 's/line/Line/' <path0 >path1
 rm -f path0
@@ -61,6 +61,6 @@ EOF
 
 test_expect_success \
     'validate the output.' \
-    'diff -I "rename similarity.*" >/dev/null current expected'
+    'diff -I "similarity.*" >/dev/null current expected'
 
 test_done
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
new file mode 100755
--- /dev/null
+++ b/t/t4003-diff-rename-1.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='More rename detection
+
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'prepare reference tree' \
+    'cat ../../COPYING >COPYING &&
+    git-update-cache --add COPYING &&
+    tree=$(git-write-tree) &&
+    echo $tree'
+
+test_expect_success \
+    'prepare work tree' \
+    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
+    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+    rm -f COPYING &&
+    git-update-cache --add --remove COPYING COPYING.?'
+
+GIT_DIFF_OPTS=-u0 git-diff-cache -M $tree |
+sed -e 's/\([0-9][0-9]*\)/#/g' >current &&
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.#
+similarity index #%
+copy from COPYING
+copy to COPYING.#
+--- a/COPYING
++++ b/COPYING.#
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ However, in order to allow a migration to GPLv# if that seems like
+diff --git a/COPYING b/COPYING.#
+similarity index #%
+rename old COPYING
+rename new COPYING.#
+--- a/COPYING
++++ b/COPYING.#
+@@ -# +# @@
+- Note that the only valid version of the GPL as far as this project
++ Note that the only valid version of the G.P.L as far as this project
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv# if that seems like
+@@ -# +# @@
+-	This file is licensed under the GPL v#, or a later version
++	This file is licensed under the G.P.L v#, or a later version
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection' \
+    'diff -u current expected'
+
+test_expect_success \
+    'prepare work tree again' \
+    'mv COPYING.2 COPYING &&
+     git-update-cache --add --remove COPYING COPYING.1'
+
+GIT_DIFF_OPTS=-u0 git-diff-cache -C $tree |
+sed -e 's/\([0-9][0-9]*\)/#/g' >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.#
+similarity index #%
+copy from COPYING
+copy to COPYING.#
+--- a/COPYING
++++ b/COPYING.#
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ However, in order to allow a migration to GPLv# if that seems like
+diff --git a/COPYING b/COPYING
+--- a/COPYING
++++ b/COPYING
+@@ -# +# @@
+- Note that the only valid version of the GPL as far as this project
++ Note that the only valid version of the G.P.L as far as this project
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv# if that seems like
+@@ -# +# @@
+-	This file is licensed under the GPL v#, or a later version
++	This file is licensed under the G.P.L v#, or a later version
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection' \
+    'diff -u current expected'
+
+test_done
------------------------------------------------

