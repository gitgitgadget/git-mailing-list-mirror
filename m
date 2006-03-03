From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Add --temp and --stage=all options to checkout-index.
Date: Thu, 2 Mar 2006 20:20:32 -0500
Message-ID: <20060303012032.GC6321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 03 02:20:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEyyG-0004oQ-HK
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 02:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbWCCBUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 20:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWCCBUi
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 20:20:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:25520 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752116AbWCCBUh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 20:20:37 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FEyy0-0000SG-Ua
	for git@vger.kernel.org; Thu, 02 Mar 2006 20:20:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C3FF820FBBF; Thu,  2 Mar 2006 20:20:32 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17132>

Sometimes it is convient for a Porcelain to be able to checkout all
unmerged files in all stages so that an external merge tool can be
executed by the Porcelain or the end-user.  Using git-unpack-file
on each stage individually incurs a rather high penalty due to the
need to fork for each file version obtained.  git-checkout-index -a
--stage=all will now do the same thing, but faster.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---
 This spawned out of the discussion of my prior --suffix patch
 and replaces it entirely.

 The output format is Junio's idea, which I happened to like a lot.
 I think I have faithfully implemented it here, but added a case
 where you can obtain temporary files for only a specific stage
 without needing to read the 'wider' 3-stage format.

 Unfortunately this change lead me down a path which changed the core
 checkout code also used by apply and read-tree.  So those commands
 could now checkout to temporary files if they wanted to.  :-)

 It currently passes all test cases, including the new one provided
 by this patch.

 Documentation/git-checkout-index.txt |   51 ++++++++
 apply.c                              |    3 
 cache.h                              |    5 -
 checkout-index.c                     |   84 ++++++++++++-
 entry.c                              |   92 +++++++++------
 read-tree.c                          |    3 
 t/t2004-checkout-cache-temp.sh       |  212 ++++++++++++++++++++++++++++++++++
 7 files changed, 396 insertions(+), 54 deletions(-)
 create mode 100755 t/t2004-checkout-cache-temp.sh

base c6b84bc40310f8e0cf2fe290b5f291e31cf688ef
last 022659f9b239fd5513a883e09ac0e0688b69dbe1
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index b0b6588..09bd6a5 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git-checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
-		   [--stage=<number>]
+		   [--stage=<number>|all]
+		   [--temp]
 		   [-z] [--stdin]
 		   [--] [<file>]\*
 
@@ -43,9 +44,15 @@ OPTIONS
 	When creating files, prepend <string> (usually a directory
 	including a trailing /)
 
---stage=<number>::
+--stage=<number>|all::
 	Instead of checking out unmerged entries, copy out the
 	files from named stage.  <number> must be between 1 and 3.
+	Note: --stage=all automatically implies --temp.
+
+--temp::
+	Instead of copying the files to the working directory
+	write the content to temporary files.  The temporary name
+	associations will be written to stdout.
 
 --stdin::
 	Instead of taking list of paths from the command line,
@@ -87,6 +94,46 @@ it will prevent problems with a filename
 Using `--` is probably a good policy in scripts.
 
 
+Using --temp or --stage=all
+---------------------------
+When `--temp` is used (or implied by `--stage=all`)
+`git-checkout-index` will create a temporary file for each index
+entry being checked out.  The index will not be updated with stat
+information.  These options can be useful if the caller needs all
+stages of all unmerged entries so that the unmerged files can be
+processed by an external merge tool.
+
+A listing will be written to stdout providing the association of
+temporary file names to tracked path names.  The listing format
+has two variations:
+
+    . tempname TAB path RS
++
+The first format is what gets used when `--stage` is omitted or
+is not `--stage=all`. The field tempname is the temporary file
+name holding the file content and path is the tracked path name in
+the index.  Only the requested entries are output.
+
+    . stage1temp SP stage2temp SP stage3tmp TAB path RS
++
+The second format is what gets used when `--stage=all`.  The three
+stage temporary fields (stage1temp, stage2temp, stage3temp) list the
+name of the temporary file if there is a stage entry in the index
+or `.` if there is no stage entry.  Paths which only have a stage 0
+entry will always be omitted from the output.
+
+In both formats RS (the record separator) is newline by default
+but will be the null byte if -z was passed on the command line.
+The temporary file names are always safe strings; they will never
+contain directory separators or whitespace characters.  The path
+field is always relative to the current directory and the temporary
+file names are always relative to the top level directory.
+
+If the object being copied out to a temporary file is a symbolic
+link the content of the link will be written to a normal file.  It is
+up to the end-user or the Porcelain to make use of this information.
+
+
 EXAMPLES
 --------
 To update and refresh only the files already checked out::
diff --git a/apply.c b/apply.c
index c369966..5583a80 100644
--- a/apply.c
+++ b/apply.c
@@ -1376,6 +1376,7 @@ static int apply_data(struct patch *patc
 static int check_patch(struct patch *patch)
 {
 	struct stat st;
+	static char topath[MAXPATHLEN+1];
 	const char *old_name = patch->old_name;
 	const char *new_name = patch->new_name;
 	const char *name = old_name ? old_name : new_name;
@@ -1402,7 +1403,7 @@ static int check_patch(struct patch *pat
 				costate.not_new = 0;
 				costate.refresh_cache = 1;
 				if (checkout_entry(active_cache[pos],
-						   &costate) ||
+						   &costate, topath) ||
 				    lstat(old_name, &st))
 					return -1;
 			}
diff --git a/cache.h b/cache.h
index 0d3b244..f87744c 100644
--- a/cache.h
+++ b/cache.h
@@ -259,10 +259,11 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
-		 refresh_cache:1;
+		 refresh_cache:1,
+		 to_tempfile:1;
 };
 
-extern int checkout_entry(struct cache_entry *ce, struct checkout *state);
+extern int checkout_entry(struct cache_entry *ce, struct checkout *state, char *topath);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/checkout-index.c b/checkout-index.c
index f54c606..24845c3 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -40,9 +40,12 @@
 #include "strbuf.h"
 #include "quote.h"
 
+#define CHECKOUT_ALL 4
 static const char *prefix;
 static int prefix_length;
+static int line_termination = '\n';
 static int checkout_stage; /* default to checkout stage0 */
+static char topath[4][MAXPATHLEN+1];
 
 static struct checkout state = {
 	.base_dir = "",
@@ -51,13 +54,42 @@ static struct checkout state = {
 	.quiet = 0,
 	.not_new = 0,
 	.refresh_cache = 0,
+	.to_tempfile = 0,
 };
 
+static void write_tempfile_record (const char *name)
+{
+	int i;
+
+	if (CHECKOUT_ALL == checkout_stage) {
+		for (i = 1; i < 4; i++) {
+			if (i > 1)
+				putchar(' ');
+			if (topath[i][0])
+				fputs(topath[i], stdout);
+			else
+				putchar('.');
+		}
+	} else
+		fputs(topath[checkout_stage], stdout);
+
+	putchar('\t');
+	write_name_quoted("", 0, name + prefix_length,
+		line_termination, stdout);
+	putchar(line_termination);
+
+	for (i = 0; i < 4; i++) {
+		topath[i][0] = 0;
+	}
+}
+
 static int checkout_file(const char *name)
 {
 	int namelen = strlen(name);
 	int pos = cache_name_pos(name, namelen);
 	int has_same_name = 0;
+	int did_checkout = 0;
+	int errs = 0;
 
 	if (pos < 0)
 		pos = -pos - 1;
@@ -68,9 +100,19 @@ static int checkout_file(const char *nam
 		    memcmp(ce->name, name, namelen))
 			break;
 		has_same_name = 1;
-		if (checkout_stage == ce_stage(ce))
-			return checkout_entry(ce, &state);
 		pos++;
+		if (ce_stage(ce) != checkout_stage
+		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
+			continue;
+		did_checkout = 1;
+		if (checkout_entry(ce, &state, topath[ce_stage(ce)]) < 0)
+			errs++;
+	}
+
+	if (did_checkout) {
+		if (state.to_tempfile)
+			write_tempfile_record(name);
+		return errs > 0 ? -1 : 0;
 	}
 
 	if (!state.quiet) {
@@ -90,18 +132,28 @@ static int checkout_file(const char *nam
 static int checkout_all(void)
 {
 	int i, errs = 0;
+	struct cache_entry* last_ce = 0;
 
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce) != checkout_stage)
+		if (ce_stage(ce) != checkout_stage
+		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
 			continue;
 		if (prefix && *prefix &&
 		    (ce_namelen(ce) <= prefix_length ||
 		     memcmp(prefix, ce->name, prefix_length)))
 			continue;
-		if (checkout_entry(ce, &state) < 0)
+		if (last_ce && state.to_tempfile) {
+			if (ce_namelen(last_ce) != ce_namelen(ce)
+			    || memcmp(last_ce->name, ce->name, ce_namelen(ce)))
+				write_tempfile_record(last_ce->name);
+		}
+		if (checkout_entry(ce, &state, topath[ce_stage(ce)]) < 0)
 			errs++;
+		last_ce = ce;
 	}
+	if (last_ce && state.to_tempfile)
+		write_tempfile_record(last_ce->name);
 	if (errs)
 		/* we have already done our error reporting.
 		 * exit with the same code as die().
@@ -111,7 +163,7 @@ static int checkout_all(void)
 }
 
 static const char checkout_cache_usage[] =
-"git-checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=[123]] [--prefix=<string>] [--] <file>...";
+"git-checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=[123]|all] [--prefix=<string>] [--temp] [--] <file>...";
 
 static struct cache_file cache_file;
 
@@ -121,7 +173,6 @@ int main(int argc, char **argv)
 	int newfd = -1;
 	int all = 0;
 	int read_from_stdin = 0;
-	int line_termination = '\n';
 
 	prefix = setup_git_directory();
 	git_config(git_default_config);
@@ -175,17 +226,26 @@ int main(int argc, char **argv)
 			i++; /* do not consider arg as a file name */
 			break;
 		}
+		if (!strcmp(arg, "--temp")) {
+			state.to_tempfile = 1;
+			continue;
+		}
 		if (!strncmp(arg, "--prefix=", 9)) {
 			state.base_dir = arg+9;
 			state.base_dir_len = strlen(state.base_dir);
 			continue;
 		}
 		if (!strncmp(arg, "--stage=", 8)) {
-			int ch = arg[8];
-			if ('1' <= ch && ch <= '3')
-				checkout_stage = arg[8] - '0';
-			else
-				die("stage should be between 1 and 3");
+			if (!strcmp(arg + 8, "all")) {
+				state.to_tempfile = 1;
+				checkout_stage = CHECKOUT_ALL;
+			} else {
+				int ch = arg[8];
+				if ('1' <= ch && ch <= '3')
+					checkout_stage = arg[8] - '0';
+				else
+					die("stage should be between 1 and 3 or all");
+			}
 			continue;
 		}
 		if (arg[0] == '-')
@@ -193,7 +253,7 @@ int main(int argc, char **argv)
 		break;
 	}
 
-	if (state.base_dir_len) {
+	if (state.base_dir_len || state.to_tempfile) {
 		/* when --prefix is specified we do not
 		 * want to update cache.
 		 */
diff --git a/entry.c b/entry.c
index 8fb99bc..c33a35d 100644
--- a/entry.c
+++ b/entry.c
@@ -63,7 +63,7 @@ static int create_file(const char *path,
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
-static int write_entry(struct cache_entry *ce, const char *path, struct checkout *state)
+static int write_entry(struct cache_entry *ce, char *path, struct checkout *state)
 {
 	int fd;
 	void *new;
@@ -80,7 +80,11 @@ static int write_entry(struct cache_entr
 	}
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
 	case S_IFREG:
-		fd = create_file(path, ntohl(ce->ce_mode));
+		if (state->to_tempfile) {
+			strcpy(path, ".merge_file_XXXXXX");
+			fd = mkstemp(path);
+		} else 
+			fd = create_file(path, ntohl(ce->ce_mode));
 		if (fd < 0) {
 			free(new);
 			return error("git-checkout-index: unable to create file %s (%s)",
@@ -93,12 +97,27 @@ static int write_entry(struct cache_entr
 			return error("git-checkout-index: unable to write file %s", path);
 		break;
 	case S_IFLNK:
-		if (symlink(new, path)) {
+		if (state->to_tempfile) {
+			strcpy(path, ".merge_link_XXXXXX");
+			fd = mkstemp(path);
+			if (fd < 0) {
+				free(new);
+				return error("git-checkout-index: unable to create "
+						 "file %s (%s)", path, strerror(errno));
+			}
+			wrote = write(fd, new, size);
+			close(fd);
 			free(new);
-			return error("git-checkout-index: unable to create "
-				     "symlink %s (%s)", path, strerror(errno));
+			if (wrote != size)
+				return error("git-checkout-index: unable to write file %s",
+					path);
+		} else {
+			wrote = symlink(new, path);
+			free(new);
+			if (wrote)
+				return error("git-checkout-index: unable to create "
+						 "symlink %s (%s)", path, strerror(errno));
 		}
-		free(new);
 		break;
 	default:
 		free(new);
@@ -113,41 +132,42 @@ static int write_entry(struct cache_entr
 	return 0;
 }
 
-int checkout_entry(struct cache_entry *ce, struct checkout *state)
+int checkout_entry(struct cache_entry *ce, struct checkout *state, char *topath)
 {
 	struct stat st;
-	static char path[MAXPATHLEN+1];
 	int len = state->base_dir_len;
 
-	memcpy(path, state->base_dir, len);
-	strcpy(path + len, ce->name);
-
-	if (!lstat(path, &st)) {
-		unsigned changed = ce_match_stat(ce, &st, 1);
-		if (!changed)
+	if (!state->to_tempfile) {
+		memcpy(topath, state->base_dir, len);
+		strcpy(topath + len, ce->name);
+
+		if (!lstat(topath, &st)) {
+			unsigned changed = ce_match_stat(ce, &st, 1);
+			if (!changed)
+				return 0;
+			if (!state->force) {
+				if (!state->quiet)
+					fprintf(stderr, "git-checkout-index: %s already exists\n", topath);
+				return -1;
+			}
+
+			/*
+			 * We unlink the old file, to get the new one with the
+			 * right permissions (including umask, which is nasty
+			 * to emulate by hand - much easier to let the system
+			 * just do the right thing)
+			 */
+			unlink(topath);
+			if (S_ISDIR(st.st_mode)) {
+				if (!state->force)
+					return error("%s is a directory", topath);
+				remove_subtree(topath);
+			}
+		} else if (state->not_new) 
 			return 0;
-		if (!state->force) {
-			if (!state->quiet)
-				fprintf(stderr, "git-checkout-index: %s already exists\n", path);
-			return -1;
-		}
-
-		/*
-		 * We unlink the old file, to get the new one with the
-		 * right permissions (including umask, which is nasty
-		 * to emulate by hand - much easier to let the system
-		 * just do the right thing)
-		 */
-		unlink(path);
-		if (S_ISDIR(st.st_mode)) {
-			if (!state->force)
-				return error("%s is a directory", path);
-			remove_subtree(path);
-		}
-	} else if (state->not_new) 
-		return 0;
-	create_directories(path, state);
-	return write_entry(ce, path, state);
+		create_directories(topath, state);
+	}
+	return write_entry(ce, topath, state);
 }
 
 
diff --git a/read-tree.c b/read-tree.c
index be29b3f..e88d69e 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -279,6 +279,7 @@ static void progress_interval(int signum
 
 static void check_updates(struct cache_entry **src, int nr)
 {
+	static char topath[MAXPATHLEN+1];
 	static struct checkout state = {
 		.base_dir = "",
 		.force = 1,
@@ -337,7 +338,7 @@ static void check_updates(struct cache_e
 		if (ce->ce_flags & mask) {
 			ce->ce_flags &= ~mask;
 			if (update)
-				checkout_entry(ce, &state);
+				checkout_entry(ce, &state, topath);
 		}
 	}
 	if (total) {
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
new file mode 100755
index 0000000..c100959
--- /dev/null
+++ b/t/t2004-checkout-cache-temp.sh
@@ -0,0 +1,212 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Shawn Pearce
+#
+
+test_description='git-checkout-index --temp test.
+
+With --temp flag, git-checkout-index writes to temporary merge files
+rather than the tracked path.'
+
+. ./test-lib.sh
+
+test_expect_success \
+'preparation' '
+mkdir asubdir &&
+echo tree1path0 >path0 &&
+echo tree1path1 >path1 &&
+echo tree1path3 >path3 &&
+echo tree1path4 >path4 &&
+echo tree1asubdir/path5 >asubdir/path5 &&
+git-update-index --add path0 path1 path3 path4 asubdir/path5 &&
+t1=$(git-write-tree) &&
+rm -f path* .merge_* out .git/index &&
+echo tree2path0 >path0 &&
+echo tree2path1 >path1 &&
+echo tree2path2 >path2 &&
+echo tree2path4 >path4 &&
+git-update-index --add path0 path1 path2 path4 &&
+t2=$(git-write-tree) &&
+rm -f path* .merge_* out .git/index &&
+echo tree2path0 >path0 &&
+echo tree3path1 >path1 &&
+echo tree3path2 >path2 &&
+echo tree3path3 >path3 &&
+git-update-index --add path0 path1 path2 path3 &&
+t3=$(git-write-tree)'
+
+test_expect_success \
+'checkout one stage 0 to temporary file' '
+rm -f path* .merge_* out .git/index &&
+git-read-tree $t1 &&
+git-checkout-index --temp -- path1 >out &&
+test $(wc -l <out) = 1 &&
+test $(cut "-d	" -f2 out) = path1 &&
+p=$(cut "-d	" -f1 out) &&
+test -f $p &&
+test $(cat $p) = tree1path1'
+
+test_expect_success \
+'checkout all stage 0 to temporary files' '
+rm -f path* .merge_* out .git/index &&
+git-read-tree $t1 &&
+git-checkout-index -a --temp >out &&
+test $(wc -l <out) = 5 &&
+for f in path0 path1 path3 path4 asubdir/path5
+do
+	test $(grep $f out | cut "-d	" -f2) = $f &&
+	p=$(grep $f out | cut "-d	" -f1) &&
+	test -f $p &&
+	test $(cat $p) = tree1$f
+done'
+
+test_expect_success \
+'prepare 3-way merge' '
+rm -f path* .merge_* out .git/index &&
+git-read-tree -m $t1 $t2 $t3'
+
+test_expect_success \
+'checkout one stage 2 to temporary file' '
+rm -f path* .merge_* out &&
+git-checkout-index --stage=2 --temp -- path1 >out &&
+test $(wc -l <out) = 1 &&
+test $(cut "-d	" -f2 out) = path1 &&
+p=$(cut "-d	" -f1 out) &&
+test -f $p &&
+test $(cat $p) = tree2path1'
+
+test_expect_success \
+'checkout all stage 2 to temporary files' '
+rm -f path* .merge_* out &&
+git-checkout-index --all --stage=2 --temp >out &&
+test $(wc -l <out) = 3 &&
+for f in path1 path2 path4
+do
+	test $(grep $f out | cut "-d	" -f2) = $f &&
+	p=$(grep $f out | cut "-d	" -f1) &&
+	test -f $p &&
+	test $(cat $p) = tree2$f
+done'
+
+test_expect_success \
+'checkout all stages/one file to nothing' '
+rm -f path* .merge_* out &&
+git-checkout-index --stage=all --temp -- path0 >out &&
+test $(wc -l <out) = 0'
+
+test_expect_success \
+'checkout all stages/one file to temporary files' '
+rm -f path* .merge_* out &&
+git-checkout-index --stage=all --temp -- path1 >out &&
+test $(wc -l <out) = 1 &&
+test $(cut "-d	" -f2 out) = path1 &&
+cut "-d	" -f1 out | (read s1 s2 s3 &&
+test -f $s1 &&
+test -f $s2 &&
+test -f $s3 &&
+test $(cat $s1) = tree1path1 &&
+test $(cat $s2) = tree2path1 &&
+test $(cat $s3) = tree3path1)'
+
+test_expect_success \
+'checkout some stages/one file to temporary files' '
+rm -f path* .merge_* out &&
+git-checkout-index --stage=all --temp -- path2 >out &&
+test $(wc -l <out) = 1 &&
+test $(cut "-d	" -f2 out) = path2 &&
+cut "-d	" -f1 out | (read s1 s2 s3 &&
+test $s1 = . &&
+test -f $s2 &&
+test -f $s3 &&
+test $(cat $s2) = tree2path2 &&
+test $(cat $s3) = tree3path2)'
+
+test_expect_success \
+'checkout all stages/all files to temporary files' '
+rm -f path* .merge_* out &&
+git-checkout-index -a --stage=all --temp >out &&
+test $(wc -l <out) = 5'
+
+test_expect_success \
+'-- path0: no entry' '
+test x$(grep path0 out | cut "-d	" -f2) = x'
+
+test_expect_success \
+'-- path1: all 3 stages' '
+test $(grep path1 out | cut "-d	" -f2) = path1 &&
+grep path1 out | cut "-d	" -f1 | (read s1 s2 s3 &&
+test -f $s1 &&
+test -f $s2 &&
+test -f $s3 &&
+test $(cat $s1) = tree1path1 &&
+test $(cat $s2) = tree2path1 &&
+test $(cat $s3) = tree3path1)'
+
+test_expect_success \
+'-- path2: no stage 1, have stage 2 and 3' '
+test $(grep path2 out | cut "-d	" -f2) = path2 &&
+grep path2 out | cut "-d	" -f1 | (read s1 s2 s3 &&
+test $s1 = . &&
+test -f $s2 &&
+test -f $s3 &&
+test $(cat $s2) = tree2path2 &&
+test $(cat $s3) = tree3path2)'
+
+test_expect_success \
+'-- path3: no stage 2, have stage 1 and 3' '
+test $(grep path3 out | cut "-d	" -f2) = path3 &&
+grep path3 out | cut "-d	" -f1 | (read s1 s2 s3 &&
+test -f $s1 &&
+test $s2 = . &&
+test -f $s3 &&
+test $(cat $s1) = tree1path3 &&
+test $(cat $s3) = tree3path3)'
+
+test_expect_success \
+'-- path4: no stage 3, have stage 1 and 3' '
+test $(grep path4 out | cut "-d	" -f2) = path4 &&
+grep path4 out | cut "-d	" -f1 | (read s1 s2 s3 &&
+test -f $s1 &&
+test -f $s2 &&
+test $s3 = . &&
+test $(cat $s1) = tree1path4 &&
+test $(cat $s2) = tree2path4)'
+
+test_expect_success \
+'-- asubdir/path5: no stage 2 and 3 have stage 1' '
+test $(grep asubdir/path5 out | cut "-d	" -f2) = asubdir/path5 &&
+grep asubdir/path5 out | cut "-d	" -f1 | (read s1 s2 s3 &&
+test -f $s1 &&
+test $s2 = . &&
+test $s3 = . &&
+test $(cat $s1) = tree1asubdir/path5)'
+
+test_expect_success \
+'checkout --temp within subdir' '
+(cd asubdir &&
+ git-checkout-index -a --stage=all >out &&
+ test $(wc -l <out) = 1 &&
+ test $(grep path5 out | cut "-d	" -f2) = path5 &&
+ grep path5 out | cut "-d	" -f1 | (read s1 s2 s3 &&
+ test -f ../$s1 &&
+ test $s2 = . &&
+ test $s3 = . &&
+ test $(cat ../$s1) = tree1asubdir/path5)
+)'
+
+test_expect_success \
+'checkout --temp symlink' '
+rm -f path* .merge_* out .git/index &&
+ln -s b a &&
+git-update-index --add a &&
+t4=$(git-write-tree) &&
+rm -f .git/index &&
+git-read-tree $t4 &&
+git-checkout-index --temp -a >out &&
+test $(wc -l <out) = 1 &&
+test $(cut "-d	" -f2 out) = a &&
+p=$(cut "-d	" -f1 out) &&
+test -f $p &&
+test $(cat $p) = b'
+
+test_done
-- 
1.2.3.g5f0e
