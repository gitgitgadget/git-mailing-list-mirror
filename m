From: Lars Hjemli <hjemli@gmail.com>
Subject: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Thu, 22 Jan 2009 22:17:51 +0100
Message-ID: <1232659071-14401-4-git-send-email-hjemli@gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 22:20:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ6y2-000087-L4
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 22:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbZAVVSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 16:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757914AbZAVVSL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 16:18:11 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:54178 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758081AbZAVVSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 16:18:06 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id n0MLHvZn012659;
	Thu, 22 Jan 2009 22:17:58 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
In-Reply-To: <1232659071-14401-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106787>

The new --submodules option is used to trigger inclusion of checked
out submodules in the archive.

The implementation currently does not verify that the submodule has
been registered as 'interesting' in .git/config, neither does it resolve
the currently checked out submodule HEAD but instead uses the commit SHA1
recorded in the gitlink entry to identify the submodule root tree.

The plan is to fix these limitations by extending --submodules to allow
certain flags/options:
  a|c|r     include any|checked out|registered submodules
  H         resolve submodule HEAD to decide which tree to include
  g:<name>  only include submodules in group <name>

The syntax would then become '--submodules[=[a|c|r][H][g:<name>]]' and
group membership could be specified in .git/config and/or .gitmodules.
The current behavior would then match '--submodules=c' (which might be a
sensible default when only --submodules is specified).

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-archive.txt |    3 +
 archive.c                     |   53 ++++++++++++++++++-
 archive.h                     |    1 +
 t/t5001-archive-submodules.sh |  121 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+), 1 deletions(-)
 create mode 100755 t/t5001-archive-submodules.sh

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 41cbf9c..ddfa343 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -51,6 +51,9 @@ OPTIONS
 	This can be any options that the archiver backend understand.
 	See next section.
 
+--submodules::
+	Include all checked out submodules in the archive.
+
 --remote=<repo>::
 	Instead of making a tar archive from local repository,
 	retrieve a tar archive from a remote repository.
diff --git a/archive.c b/archive.c
index e6de039..1709a01 100644
--- a/archive.c
+++ b/archive.c
@@ -96,6 +96,52 @@ struct archiver_context {
 	write_archive_entry_fn_t write_entry;
 };
 
+/* Given the root directory of a non-bare repository, return the path
+ * to the corresponding GITDIR, or NULL if not found. The return-value
+ * is malloc'd by this function and should be free'd by the caller.
+ */
+static char *get_gitdir(const char *root)
+{
+	const char *path, *tmp;
+	struct stat st;
+
+	if (!root)
+		return NULL;
+
+	if (root[strlen(root) - 1] == '/')
+		path = mkpath("%s.git", root);
+	else
+		path = mkpath("%s/.git", root);
+
+	tmp = read_gitfile_gently(path);
+	if (tmp)
+		path = tmp;
+
+	if (stat(path, &st) || !S_ISDIR(st.st_mode))
+		return NULL;
+	return xstrdup(path);
+}
+
+/* Return READ_TREE_RECURSIVE if we should recurse into the gitlinked
+ * repository or 0 if it should be skipped.
+ */
+static int recurse_gitlink(struct archiver_args *args, const char *path)
+{
+	char *gitdir;
+	char *objdir;
+
+	if (!args->submodules)
+		return 0;
+	gitdir = get_gitdir(path);
+	if (!gitdir)
+		return 0;
+	objdir = mkpath("%s/objects", gitdir);
+	free(gitdir);
+	if (add_alt_odb(objdir, 0))
+		return -1;
+	return READ_TREE_RECURSIVE;
+}
+
 static int write_archive_entry(const unsigned char *sha1, const char *base,
 		int baselen, const char *filename, unsigned mode, int stage,
 		void *context)
@@ -132,7 +178,8 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		err = write_entry(args, sha1, path.buf, path.len, mode, NULL, 0);
 		if (err)
 			return err;
-		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE :
+					recurse_gitlink(args, path.buf));
 	}
 
 	buffer = sha1_file_to_archive(path_without_prefix, sha1, mode,
@@ -255,6 +302,7 @@ static int parse_archive_args(int argc, const char **argv,
 	const char *exec = NULL;
 	int compression_level = -1;
 	int verbose = 0;
+	int submodules = 0;
 	int i;
 	int list = 0;
 	struct option opts[] = {
@@ -262,6 +310,8 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_STRING(0, "prefix", &base, "prefix",
 			"prepend prefix to each pathname in the archive"),
+		OPT_BOOLEAN(0, "submodules", &submodules,
+			"include checked out submodules in the archive"),
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -319,6 +369,7 @@ static int parse_archive_args(int argc, const char **argv,
 	args->verbose = verbose;
 	args->base = base;
 	args->baselen = strlen(base);
+	args->submodules = submodules;
 
 	return argc;
 }
diff --git a/archive.h b/archive.h
index 0b15b35..aff3fcd 100644
--- a/archive.h
+++ b/archive.h
@@ -11,6 +11,7 @@ struct archiver_args {
 	const char **pathspec;
 	unsigned int verbose : 1;
 	int compression_level;
+	int submodules;
 };
 
 typedef int (*write_archive_fn_t)(struct archiver_args *);
diff --git a/t/t5001-archive-submodules.sh b/t/t5001-archive-submodules.sh
new file mode 100755
index 0000000..6471984
--- /dev/null
+++ b/t/t5001-archive-submodules.sh
@@ -0,0 +1,121 @@
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
+test_expect_success 'by default, all submodules are ignored' '
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
+test_debug 'tar -tf normal.tar'
+
+test_expect_success 'with --submodules, checked-out submodules are included' '
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
+test_debug 'tar -tf full.tar'
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
+test_debug 'tar -tf recursive.tar'
+
+test_expect_success 'packed submodules are supported' '
+	cat <<EOF >expected &&
+1
+2/
+2/3
+4/
+4/5
+4/6/
+4/6/7
+EOF
+	msg=$(cd 2 && git repack -ad && git count-objects) &&
+	test "$msg" = "0 objects, 0 kilobytes" &&
+	git archive --submodules HEAD >packed.tar &&
+	tar -tf packed.tar >actual &&
+	test_cmp expected actual
+'
+
+test_debug 'tar -tf packed.tar'
+
+test_expect_success 'a missing submodule pack triggers an error' '
+	find 2/.git/objects/pack -type f | xargs rm &&
+	test_must_fail git archive --submodules HEAD
+'
+
+test_expect_success 'non-checked out submodules are ignored' '
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
+test_debug 'tar -tf partial.tar'
+
+test_expect_success 'missing objects in a submodule triggers an error' '
+	find 4/.git/objects -type f | xargs rm &&
+	test_must_fail git archive --submodules HEAD
+'
+
+test_done
-- 
1.6.1.150.g5e733b
