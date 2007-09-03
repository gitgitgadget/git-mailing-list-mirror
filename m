From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] archive: specfile support (--pretty=format: in archive
 files)
Date: Mon, 03 Sep 2007 20:07:01 +0200
Message-ID: <46DC4D45.4030208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 20:07:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISGKP-00004x-7W
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 20:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbXICSHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 14:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbXICSHH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 14:07:07 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54594
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752301AbXICSHF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 14:07:05 -0400
Received: from [10.0.1.201] (p508EFD82.dip.t-dialin.net [80.142.253.130])
	by neapel230.server4you.de (Postfix) with ESMTP id 3E427873B6;
	Mon,  3 Sep 2007 20:07:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57498>

Add support for a new attribute, specfile.  Files marked as being
specfiles are expanded by git-archive when they are written to an
archive.  It has no effect on worktree files.  The same placeholders
as those for the option --pretty=format: of git-log et al. can be
used.

The attribute is useful for creating auto-updating specfiles.  It is
limited by the underlying function format_commit_message(), though.
E.g. currently there is no placeholder for git-describe like output,
and expanded specfiles can't contain NUL bytes.  That can be fixed
in format_commit_message() later and will then benefit users of
git-log, too.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/gitattributes.txt |   14 ++++++++++
 archive-tar.c                   |    5 +++-
 archive-zip.c                   |    5 +++-
 archive.h                       |    3 ++
 builtin-archive.c               |   55 ++++++++++++++++++++++++++++++++++++++-
 t/t5000-tar-tree.sh             |   19 +++++++++++++
 6 files changed, 98 insertions(+), 3 deletions(-)

This should already be sufficient for the use case which Michael and
Thomas described a while ago, viz. adding a commit ID file to
generated archives.

Why did it take me that long to come up with such a simple patch?
There was a vacation and a feature freeze in between, but above all
I was only recently able to convince myself (using ugly code) that
format_commit_message() can indeed be made to expand placeholders
to git-describe strings..

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 46f9d59..47a621b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -421,6 +421,20 @@ frotz	unspecified
 ----------------------------------------------------------------
 
 
+Creating an archive
+~~~~~~~~~~~~~~~~~~~
+
+`specfile`
+^^^^^^^^^^
+
+If the attribute `specfile` is set for a file then git will expand
+several placeholders when adding this file to an archive.  The
+expansion depends on the availability of a commit ID, i.e. if
+gitlink:git-archive[1] has been given a tree instead of a commit or a
+tag then no replacement will be done.  The placeholders are the same
+as those for the option `--pretty=format:` of gitlink:git-log[1].
+
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/archive-tar.c b/archive-tar.c
index 66fe3e3..c0d95da 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -17,6 +17,7 @@ static unsigned long offset;
 static time_t archive_time;
 static int tar_umask = 002;
 static int verbose;
+static const struct commit *commit;
 
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
@@ -285,7 +286,8 @@ static int write_tar_entry(const unsigned char *sha1,
 		buffer = NULL;
 		size = 0;
 	} else {
-		buffer = convert_sha1_file(path.buf, sha1, mode, &type, &size);
+		buffer = sha1_file_to_archive(path.buf, sha1, mode, &type,
+		                              &size, commit);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 	}
@@ -304,6 +306,7 @@ int write_tar_archive(struct archiver_args *args)
 
 	archive_time = args->time;
 	verbose = args->verbose;
+	commit = args->commit;
 
 	if (args->commit_sha1)
 		write_global_extended_header(args->commit_sha1);
diff --git a/archive-zip.c b/archive-zip.c
index 444e162..f63dff3 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -12,6 +12,7 @@
 static int verbose;
 static int zip_date;
 static int zip_time;
+static const struct commit *commit;
 
 static unsigned char *zip_dir;
 static unsigned int zip_dir_size;
@@ -195,7 +196,8 @@ static int write_zip_entry(const unsigned char *sha1,
 		if (S_ISREG(mode) && zlib_compression_level != 0)
 			method = 8;
 		result = 0;
-		buffer = convert_sha1_file(path, sha1, mode, &type, &size);
+		buffer = sha1_file_to_archive(path, sha1, mode, &type, &size,
+		                              commit);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 		crc = crc32(crc, buffer, size);
@@ -316,6 +318,7 @@ int write_zip_archive(struct archiver_args *args)
 	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
 	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
 	verbose = args->verbose;
+	commit = args->commit;
 
 	if (args->base && plen > 0 && args->base[plen - 1] == '/') {
 		char *base = xstrdup(args->base);
diff --git a/archive.h b/archive.h
index 6838dc7..5791e65 100644
--- a/archive.h
+++ b/archive.h
@@ -8,6 +8,7 @@ struct archiver_args {
 	const char *base;
 	struct tree *tree;
 	const unsigned char *commit_sha1;
+	const struct commit *commit;
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
@@ -42,4 +43,6 @@ extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
 extern void *parse_extra_zip_args(int argc, const char **argv);
 
+extern void *sha1_file_to_archive(const char *path, const unsigned char *sha1, unsigned int mode, enum object_type *type, unsigned long *size, const struct commit *commit);
+
 #endif	/* ARCHIVE_H */
diff --git a/builtin-archive.c b/builtin-archive.c
index 187491b..faccce3 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -10,6 +10,7 @@
 #include "exec_cmd.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "attr.h"
 
 static const char archive_usage[] = \
 "git-archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
@@ -80,6 +81,57 @@ static int run_remote_archiver(const char *remote, int argc,
 	return !!rv;
 }
 
+static void *convert_to_archive(const char *path,
+                                const void *src, unsigned long *sizep,
+                                const struct commit *commit)
+{
+	static struct git_attr *attr_specfile;
+	struct git_attr_check check[1];
+	char *interpolated = NULL;
+	unsigned long allocated = 0;
+
+	if (!commit)
+		return NULL;
+
+        if (!attr_specfile)
+                attr_specfile = git_attr("specfile", 8);
+
+	check[0].attr = attr_specfile;
+	if (git_checkattr(path, ARRAY_SIZE(check), check))
+		return NULL;
+	if (!ATTR_TRUE(check[0].value))
+		return NULL;
+
+	*sizep = format_commit_message(commit, src, &interpolated, &allocated);
+
+	return interpolated;
+}
+
+void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
+                           unsigned int mode, enum object_type *type,
+                           unsigned long *size,
+                           const struct commit *commit)
+{
+	void *buffer, *converted;
+
+	buffer = read_sha1_file(sha1, type, size);
+	if (buffer && S_ISREG(mode)) {
+		converted = convert_to_working_tree(path, buffer, size);
+		if (converted) {
+			free(buffer);
+			buffer = converted;
+		}
+
+		converted = convert_to_archive(path, buffer, size, commit);
+		if (converted) {
+			free(buffer);
+			buffer = converted;
+		}
+	}
+
+	return buffer;
+}
+
 static int init_archiver(const char *name, struct archiver *ar)
 {
 	int rv = -1, i;
@@ -109,7 +161,7 @@ void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
 	const unsigned char *commit_sha1;
 	time_t archive_time;
 	struct tree *tree;
-	struct commit *commit;
+	const struct commit *commit;
 	unsigned char sha1[20];
 
 	if (get_sha1(name, sha1))
@@ -142,6 +194,7 @@ void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
 	}
 	ar_args->tree = tree;
 	ar_args->commit_sha1 = commit_sha1;
+	ar_args->commit = commit;
 	ar_args->time = archive_time;
 }
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 1a4c53a..3d5d01b 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -28,12 +28,15 @@ commit id embedding:
 TAR=${TAR:-tar}
 UNZIP=${UNZIP:-unzip}
 
+SPECFILEFORMAT=%H%n
+
 test_expect_success \
     'populate workdir' \
     'mkdir a b c &&
      echo simple textfile >a/a &&
      mkdir a/bin &&
      cp /bin/sh a/bin &&
+     printf "%s" "$SPECFILEFORMAT" >a/specfile &&
      ln -s a a/l1 &&
      (p=long_path_to_a_file && cd a &&
       for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
@@ -105,6 +108,22 @@ test_expect_success \
     'diff -r a c/prefix/a'
 
 test_expect_success \
+    'create an archive with a specfile' \
+    'echo specfile specfile >a/.gitattributes &&
+     git archive HEAD >f.tar &&
+     rm a/.gitattributes'
+
+test_expect_success \
+    'extract specfile' \
+    '(mkdir f && cd f && $TAR xf -) <f.tar'
+
+test_expect_success \
+     'validate specfile contents' \
+     'git log --max-count=1 "--pretty=format:$SPECFILEFORMAT" HEAD \
+      >f/a/specfile.expected &&
+      diff f/a/specfile.expected f/a/specfile'
+
+test_expect_success \
     'git archive --format=zip' \
     'git archive --format=zip HEAD >d.zip'
 
-- 
1.5.3
