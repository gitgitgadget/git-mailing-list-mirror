From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/2] archive.c: add support for --submodules[=(all|checkedout)]
Date: Sun, 25 Jan 2009 01:52:06 +0100
Message-ID: <1232844726-14902-3-git-send-email-hjemli@gmail.com>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
 <1232844726-14902-2-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 01:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQtGD-0004nS-7N
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 01:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbZAYAwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 19:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbZAYAwT
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 19:52:19 -0500
Received: from mail49.e.nsc.no ([193.213.115.49]:53689 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755915AbZAYAwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 19:52:14 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id n0P0q7Jv014475;
	Sun, 25 Jan 2009 01:52:09 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
In-Reply-To: <1232844726-14902-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107031>

The --submodules option uses the enhanced read_tree_recursive() to
enable inclusion of submodules in the generated archive.

When invoked with `--submodules=all` all gitlink entries will be
traversed, and when invoked with --submodules=checkedout (the default
option) only gitlink entries with a git repo (i.e. checked out sub-
modules) will be traversed.

When a gitlink has been selected for traversal, it is required that all
objects necessary to perform this traversal are available in either the
primary odb or through an alternate odb. To this end, git archive will
insert the object database of the selected gitlink (when checked out)
as an alternate odb, using the new function add_alt_odb(). And since
alternates now can be added after parsing of objects/info/alternates,
the error message in link_alt_odb_entry() has been updated to not
mention this file.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-archive.txt |    5 ++
 archive.c                     |   81 +++++++++++++++++++++++++-
 archive.h                     |    4 +
 cache.h                       |    1 +
 sha1_file.c                   |   11 +++-
 t/t5001-archive-submodules.sh |  129 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 228 insertions(+), 3 deletions(-)
 create mode 100755 t/t5001-archive-submodules.sh

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 41cbf9c..6068302 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -47,6 +47,11 @@ OPTIONS
 --prefix=<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
 
+--submodules[=<spec>]::
+	Include the content of submodules in the archive. The specification
+	of which submodules to include can be either 'checkedout' (default)
+	or 'all'.
+
 <extra>::
 	This can be any options that the archiver backend understand.
 	See next section.
diff --git a/archive.c b/archive.c
index e6de039..bb0c5c8 100644
--- a/archive.c
+++ b/archive.c
@@ -4,6 +4,7 @@
 #include "attr.h"
 #include "archive.h"
 #include "parse-options.h"
+#include "refs.h"
 
 static char const * const archive_usage[] = {
 	"git archive [options] <tree-ish> [path...]",
@@ -91,6 +92,70 @@ static void setup_archive_check(struct git_attr_check *check)
 	check[1].attr = attr_export_subst;
 }
 
+static int include_repository(const char *path)
+{
+	struct stat st;
+	const char *tmp;
+
+	/* Return early if the path does not exist since it is OK to not
+	 * checkout submodules.
+	 */
+	if (stat(path, &st) && errno == ENOENT)
+		return 1;
+
+	tmp = read_gitfile_gently(path);
+	if (tmp) {
+		path = tmp;
+		if (stat(path, &st))
+			die("Unable to stat submodule gitdir %s: %s (%d)",
+			    path, strerror(errno), errno);
+	}
+
+	if (!S_ISDIR(st.st_mode))
+		die("Submodule gitdir %s is not a directory", path);
+
+	if (add_alt_odb(mkpath("%s/objects", path)))
+		die("submodule odb %s could not be added as an alternate",
+		    path);
+
+	return 0;
+}
+
+static int check_gitlink(struct archiver_args *args, const unsigned char *sha1,
+			 const char *path)
+{
+	switch (args->submodules) {
+	case 0:
+		return 0;
+
+	case SUBMODULES_ALL:
+		/* When all submodules are requested, we try to add any
+		 * checked out submodules as alternate odbs. But we don't
+		 * really care whether any particular submodule is checked
+		 * out or not, we are going to try to traverse it anyways.
+		 */
+		include_repository(mkpath("%s.git", path));
+		return READ_TREE_RECURSIVE;
+
+	case SUBMODULES_CHECKEDOUT:
+		/* If a repo is checked out at the gitlink path, we want to
+		 * traverse into the submodule. But we ignore the current
+		 * HEAD of the checked out submodule and always uses the SHA1
+		 * recorded in the gitlink entry since we want the content
+		 * of the archive to match the content of the <tree-ish>
+		 * specified on the command line.
+		 */
+		if (!include_repository(mkpath("%s.git", path)))
+			return READ_TREE_RECURSIVE;
+		else
+			return 0;
+
+	default:
+		die("archive.c: invalid value for args->submodules: %d",
+		    args->submodules);
+	}
+}
+
 struct archiver_context {
 	struct archiver_args *args;
 	write_archive_entry_fn_t write_entry;
@@ -132,7 +197,8 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		err = write_entry(args, sha1, path.buf, path.len, mode, NULL, 0);
 		if (err)
 			return err;
-		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE :
+			check_gitlink(args, sha1, path.buf));
 	}
 
 	buffer = sha1_file_to_archive(path_without_prefix, sha1, mode,
@@ -253,6 +319,7 @@ static int parse_archive_args(int argc, const char **argv,
 	const char *base = NULL;
 	const char *remote = NULL;
 	const char *exec = NULL;
+	const char *submodules = NULL;
 	int compression_level = -1;
 	int verbose = 0;
 	int i;
@@ -262,6 +329,9 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_STRING(0, "prefix", &base, "prefix",
 			"prepend prefix to each pathname in the archive"),
+		{OPTION_STRING, 0, "submodules", &submodules, "kind",
+			"include submodule content in the archive",
+			PARSE_OPT_OPTARG, NULL, (intptr_t)"checkedout"},
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -316,6 +386,15 @@ static int parse_archive_args(int argc, const char **argv,
 					format, compression_level);
 		}
 	}
+
+	if (!submodules)
+		args->submodules = 0;
+	else if (!strcmp(submodules, "checkedout"))
+		args->submodules = SUBMODULES_CHECKEDOUT;
+	else if (!strcmp(submodules, "all"))
+		args->submodules = SUBMODULES_ALL;
+	else
+		die("Invalid submodule kind: %s", submodules);
 	args->verbose = verbose;
 	args->base = base;
 	args->baselen = strlen(base);
diff --git a/archive.h b/archive.h
index 0b15b35..2b078b6 100644
--- a/archive.h
+++ b/archive.h
@@ -11,8 +11,12 @@ struct archiver_args {
 	const char **pathspec;
 	unsigned int verbose : 1;
 	int compression_level;
+	int submodules;
 };
 
+#define SUBMODULES_CHECKEDOUT 1
+#define SUBMODULES_ALL 2
+
 typedef int (*write_archive_fn_t)(struct archiver_args *);
 
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsigned char *sha1, const char *path, size_t pathlen, unsigned int mode, void *buffer, unsigned long size);
diff --git a/cache.h b/cache.h
index 8d965b8..ea53e4b 100644
--- a/cache.h
+++ b/cache.h
@@ -728,6 +728,7 @@ extern struct alternate_object_database {
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern int add_alt_odb(const char *path);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern void foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index 360f7e5..53d8db7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -285,8 +285,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(ent->base)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
+		error("Alternate object directory %s does not exist",
 		      ent->base);
 		free(ent);
 		return -1;
@@ -2573,3 +2572,11 @@ int read_pack_header(int fd, struct pack_header *header)
 		return PH_ERROR_PROTOCOL;
 	return 0;
 }
+
+int add_alt_odb(const char *path)
+{
+	int err = link_alt_odb_entry(path, strlen(path), NULL, 0);
+	if (!err)
+		prepare_packed_git_one((char *)path, 0);
+	return err;
+}
diff --git a/t/t5001-archive-submodules.sh b/t/t5001-archive-submodules.sh
new file mode 100755
index 0000000..14383b3
--- /dev/null
+++ b/t/t5001-archive-submodules.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+test_description='git archive can include submodule content'
+
+. ./test-lib.sh
+
+add_file()
+{
+	git add $1 &&
+	git commit -m "added $1"
+}
+
+add_submodule()
+{
+	mkdir $1 && (
+		cd $1 &&
+		git init &&
+		echo "File $2" >$2 &&
+		add_file $2
+	) &&
+	add_file $1
+}
+
+test_expect_success 'by default, submodules are not included' '
+	echo "File 1" >1 &&
+	add_file 1 &&
+	add_submodule 2 3 &&
+	add_submodule 4 5 &&
+	cat <<EOF >expected &&
+1
+2/
+4/
+EOF
+	git archive HEAD >normal.tar &&
+	tar -tf normal.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with --submodules, checked out submodules are  included' '
+	cat <<EOF >expected &&
+1
+2/
+2/3
+4/
+4/5
+EOF
+	git archive --submodules HEAD >full.tar &&
+	tar -tf full.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with --submodules=all, all submodules are included' '
+	git archive --submodules=all HEAD >all.tar &&
+	tar -tf all.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'submodules in submodules are supported' '
+	(cd 4 && add_submodule 6 7) &&
+	add_file 4 &&
+	cat <<EOF >expected &&
+1
+2/
+2/3
+4/
+4/5
+4/6/
+4/6/7
+EOF
+	git archive --submodules HEAD >recursive.tar &&
+	tar -tf recursive.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'packed submodules are supported' '
+	msg=$(cd 2 && git repack -ad && git count-objects) &&
+	test "$msg" = "0 objects, 0 kilobytes" &&
+	git archive --submodules HEAD >packed.tar &&
+	tar -tf packed.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'missing submodule packs triggers an error' '
+	mv 2/.git/objects/pack .git/packdir2 &&
+	test_must_fail git archive --submodules HEAD
+'
+
+test_expect_success '--submodules skips non-checked out submodules' '
+	cat <<EOF >expected &&
+1
+2/
+4/
+4/5
+4/6/
+4/6/7
+EOF
+	rm -rf 2/.git &&
+	git archive --submodules HEAD >partial.tar &&
+	tar -tf partial.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--submodules=all fails if gitlinked objects are missing' '
+	test_must_fail git archive --submodules=all HEAD
+'
+
+test_expect_success \
+	'--submodules=all does not require submodules to be checked out' '
+	cat <<EOF >expected &&
+1
+2/
+2/3
+4/
+4/5
+4/6/
+4/6/7
+EOF
+	mv .git/packdir2/* .git/objects/pack/ &&
+	git archive --submodules=all HEAD >all2.tar &&
+	tar -tf all2.tar >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'missing objects in a submodule triggers an error' '
+	find 4/.git/objects -type f | xargs rm &&
+	test_must_fail git archive --submodules HEAD
+'
+
+test_done
-- 
1.6.1.150.g5e733b
