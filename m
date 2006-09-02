From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH][RFC] Add git-archive-tree
Date: Sat, 02 Sep 2006 14:23:28 +0200
Message-ID: <44F977C0.4060901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 02 14:24:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJUXQ-0005Fc-56
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 14:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWIBMXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 08:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWIBMXg
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 08:23:36 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:25757
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751046AbWIBMXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 08:23:35 -0400
Received: from [10.0.1.3] (p508E733A.dip.t-dialin.net [80.142.115.58])
	by neapel230.server4you.de (Postfix) with ESMTP id 36C3A20045;
	Sat,  2 Sep 2006 14:23:33 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26332>

git-archive-tree is a command to make tar and ZIP archives of a git tree.
It helps prevent a proliferation of git-{format}-tree commands.  This is
useful e.g. for remote archive fetching because we only need to write a
single upload and a single download program that simply pass on the
format option to git-archive-tree.

Speaking of remote, please note the absence of the --remote option of
git-tar-tree.  This is intentional; remote operations are special enough
to deserve a separate (yet to be written) command.

Currently git-archive-tree -f tar is slower than git-tar-tree.  This is
because it is welded to the side of the existing code to minimize patch
size, and I also suspect read_tree_recursive() to be quite a bit slower
than builtin-tar-tree.c::traverse_tree().


 Documentation/git-archive-tree.txt |   99 +++++++++++++++++++++++++++++++++++++
 Makefile                           |    3 -
 archive.h                          |    6 ++
 builtin-archive-tree.c             |   92 ++++++++++++++++++++++++++++++++++
 builtin-tar-tree.c                 |   66 ++++++++++++++++++++++++
 builtin-zip-tree.c                 |   28 ++++++++++
 builtin.h                          |    1 
 git.c                              |    1 
 8 files changed, 295 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-archive-tree.txt b/Documentation/git-archive-tree.txt
new file mode 100644
index 0000000..122c482
--- /dev/null
+++ b/Documentation/git-archive-tree.txt
@@ -0,0 +1,99 @@
+git-archive-tree(1)
+===============
+
+NAME
+----
+git-archive-tree - Creates a archive of the files in the named tree
+
+
+SYNOPSIS
+--------
+'git-archive-tree' -f {tar|zip} [--prefix=<prefix>/] [-0|...|-9]
+	    <tree-ish> [path...]
+
+DESCRIPTION
+-----------
+Creates an archive of the specified format containing the tree structure
+for the named tree.  If <prefix> is specified it is prepended to the
+filenames in the archive.
+
+git-archive-tree behaves differently when given a tree ID versus when
+given a commit ID or tag ID.  In the first case the current time is used
+as modification time of each file in the archive.  In the latter case the
+commit time as recorded in the referenced commit object is used instead.
+Additionally the commit ID is stored in a global extended pax header if
+the tar format is used; it can be extracted using git-get-tar-commit-id.
+In ZIP files it is stored as a file comment.
+
+OPTIONS
+-------
+
+-f::
+	Format of the resulting archive, can be either 'tar' or 'zip'.
+
+<tree-ish>::
+	The tree or commit to produce an archive for.
+
+path::
+	If one or more paths are specified, include only these in the
+	archive, otherwise include all files and subdirectories.
+
+--prefix=<prefix>/::
+	Prepend <prefix>/ to each filename in the archive.
+
+-0::
+	Store files in the archive instead of compressing them.  This
+	option has no effect when the tar format is used.
+
+-9::
+        Highest and slowest compression level.  You can specify any
+        number from 1 to 9 to adjust compression speed and ratio.  This
+	option has no effect when the tar format is used.
+
+CONFIGURATION
+-------------
+By default, file and directories modes are set to 0666 or 0777 in tar
+archives.  It is possible to change this by setting the "umask" variable
+in the repository configuration as follows :
+
+[tar]
+        umask = 002	;# group friendly
+
+The special umask value "user" indicates that the user's current umask
+will be used instead. The default value remains 0, which means world
+readable/writable files and directories.
+
+EXAMPLES
+--------
+git archive -f tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)::
+
+	Create a tar archive that contains the contents of the
+	latest commit on the current branch, and extracts it in
+	`/var/tmp/junk` directory.
+
+git archive -f tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz::
+
+	Create a compressed tarball for v1.4.0 release.
+
+git archive -f tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz::
+
+	Create a compressed tarball for v1.4.0 release, but without a
+	global extended pax header.
+
+git archive -f zip --prefix=git-docs/ HEAD:Documentation/ > git-1.4.0-docs.zip::
+
+	Put everything in the current head's Documentation/ directory
+	into 'git-1.4.0-docs.zip', with the prefix 'git-docs/'.
+
+Author
+------
+Written by Rene Scharfe.
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index 05bd77f..d0a1055 100644
--- a/Makefile
+++ b/Makefile
@@ -231,7 +231,7 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 
 LIB_H = \
-	blob.h cache.h commit.h csum-file.h delta.h \
+	archive.h blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
@@ -255,6 +255,7 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-add.o \
 	builtin-apply.o \
+	builtin-archive-tree.o \
 	builtin-cat-file.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
diff --git a/archive.h b/archive.h
new file mode 100644
index 0000000..7813962
--- /dev/null
+++ b/archive.h
@@ -0,0 +1,6 @@
+#include "tree.h"
+
+typedef int (*write_archive_fn_t)(struct tree *tree, const unsigned char *commit_sha1, const char *prefix, time_t time, const char **pathspec);
+
+int write_tar_archive(struct tree *tree, const unsigned char *commit_sha1, const char *prefix, time_t time, const char **pathspec);
+int write_zip_archive(struct tree *tree, const unsigned char *commit_sha1, const char *prefix, time_t time, const char **pathspec);
diff --git a/builtin-archive-tree.c b/builtin-archive-tree.c
new file mode 100644
index 0000000..2c6ee60
--- /dev/null
+++ b/builtin-archive-tree.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright (c) 2006 Rene Scharfe
+ */
+#include <time.h>
+#include "cache.h"
+#include "builtin.h"
+#include "commit.h"
+#include "tree-walk.h"
+#include "archive.h"
+
+static const char archive_usage[] =
+"git-archive-tree -f {tar|zip} [--prefix=<prefix>/] [-0|...|-9] <tree-ish> [path...]";
+
+static write_archive_fn_t parse_archive_format(const char *format)
+{
+	if (!strcmp(format, "tar"))
+		return write_tar_archive;
+	if (!strcmp(format, "zip"))
+		return write_zip_archive;
+	return NULL;
+}
+
+int cmd_archive_tree(int argc, const char **argv, const char *prefix)
+{
+	int more_args = 1;
+	const char *archive_prefix = "";
+	unsigned char sha1[20];
+	struct commit *commit;
+	time_t archive_time;
+	const char **pathspec;
+	const unsigned char *commit_sha1 = NULL;
+	write_archive_fn_t write_archive = NULL;
+	struct tree *tree;
+	int result;
+
+	while (argc > 2 && more_args) {
+		const char *arg = argv[1];
+		if (!strcmp(arg, "-f")) {
+			write_archive = parse_archive_format(argv[2]);
+			argv++;
+			argc--;
+		} else if (!strncmp(arg, "-f", 2))
+			write_archive = parse_archive_format(arg + 2);
+		else if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0')
+			zlib_compression_level = arg[1] - '0';
+		else if (!strcmp(arg, "--"))
+			more_args = 0;
+		else if (!strncmp(arg, "--prefix=", 9))
+			archive_prefix = arg + 9;
+		else if (arg[0] == '-')
+			usage(archive_usage);
+		else
+			break;
+		argv++;
+		argc--;
+	}
+
+	if (!write_archive)
+		usage(archive_usage);
+	if (argc < 2)
+		usage(archive_usage);
+	if (get_sha1(argv[1], sha1))
+		die("Not a valid object name %s", argv[1]);
+
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (commit)
+		commit_sha1 = commit->object.sha1;
+
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
+		die("not a tree object");
+
+	if (prefix) {
+		unsigned char tree_sha1[20];
+		unsigned int mode;
+		int err = get_tree_entry(tree->object.sha1, prefix,
+		                         tree_sha1, &mode);
+		if (err || !S_ISDIR(mode))
+			die("current working directory is untracked");
+		free(tree);
+		tree = parse_tree_indirect(tree_sha1);
+	}
+
+	archive_time = commit ? commit->date : time(NULL);
+	pathspec = get_pathspec(archive_prefix, argv + 2);
+
+	result = write_archive(tree, commit_sha1, archive_prefix,
+	                       archive_time, pathspec);
+	free(tree);
+
+	return result;
+}
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 61a4135..e0da01e 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -9,6 +9,7 @@ #include "strbuf.h"
 #include "tar.h"
 #include "builtin.h"
 #include "pkt-line.h"
+#include "archive.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
@@ -338,6 +339,71 @@ static int generate_tar(int argc, const 
 	return 0;
 }
 
+static int write_tar_entry(const unsigned char *sha1,
+                           const char *base, int baselen,
+                           const char *filename, unsigned mode, int stage)
+{
+	static struct strbuf path;
+	int filenamelen = strlen(filename);
+	void *buffer;
+	char type[20];
+	unsigned long size;
+
+	if (!path.alloc) {
+		path.buf = xmalloc(PATH_MAX);
+		path.alloc = PATH_MAX;
+		path.len = path.eof = 0;
+	}
+	if (path.alloc < baselen + filenamelen) {
+		free(path.buf);
+		path.buf = xmalloc(baselen + filenamelen);
+		path.alloc = baselen + filenamelen;
+	}
+	memcpy(path.buf, base, baselen);
+	memcpy(path.buf + baselen, filename, filenamelen);
+	path.len = baselen + filenamelen;
+	if (S_ISDIR(mode)) {
+		strbuf_append_string(&path, "/");
+		buffer = NULL;
+		size = 0;
+	} else {
+		buffer = read_sha1_file(sha1, type, &size);
+		if (!buffer)
+			die("cannot read %s", sha1_to_hex(sha1));
+	}
+
+	write_entry(sha1, &path, mode, buffer, size);
+
+	return READ_TREE_RECURSIVE;
+}
+
+int write_tar_archive(struct tree *tree, const unsigned char *commit_sha1,
+                      const char *prefix, time_t time, const char **pathspec)
+{
+	int plen = strlen(prefix);
+
+	git_config(git_tar_config);
+
+	archive_time = time;
+
+	if (commit_sha1)
+		write_global_extended_header(commit_sha1);
+
+	if (prefix && plen > 0 && prefix[plen - 1] == '/') {
+		char *base = strdup(prefix);
+		int baselen = strlen(base);
+
+		while (baselen > 0 && base[baselen - 1] == '/')
+			base[--baselen] = '\0';
+		write_tar_entry(tree->object.sha1, "", 0, base, 040777, 0);
+		free(base);
+	}
+	read_tree_recursive(tree, prefix, plen, 0, pathspec, write_tar_entry);
+	write_trailer();
+
+	return 0;
+}
+
 static const char *exec = "git-upload-tar";
 
 static int remote_tar(int argc, const char **argv)
diff --git a/builtin-zip-tree.c b/builtin-zip-tree.c
index a5b834d..b142771 100644
--- a/builtin-zip-tree.c
+++ b/builtin-zip-tree.c
@@ -8,6 +8,7 @@ #include "blob.h"
 #include "tree.h"
 #include "quote.h"
 #include "builtin.h"
+#include "archive.h"
 
 static const char zip_tree_usage[] =
 "git-zip-tree [-0|...|-9] <tree-ish> [ <base> ]";
@@ -351,3 +352,30 @@ int cmd_zip_tree(int argc, const char **
 
 	return 0;
 }
+
+int write_zip_archive(struct tree *tree, const unsigned char *commit_sha1,
+                      const char *prefix, time_t time, const char **pathspec)
+{
+	int plen = strlen(prefix);
+
+	dos_time(&time, &zip_date, &zip_time);
+
+	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
+	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
+
+	if (prefix && plen > 0 && prefix[plen - 1] == '/') {
+		char *base = strdup(prefix);
+		int baselen = strlen(base);
+
+		while (baselen > 0 && base[baselen - 1] == '/')
+			base[--baselen] = '\0';
+		write_zip_entry(tree->object.sha1, "", 0, base, 040777, 0);
+		free(base);
+	}
+	read_tree_recursive(tree, prefix, plen, 0, pathspec, write_zip_entry);
+	write_zip_trailer(commit_sha1);
+
+	free(zip_dir);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 25431d7..febb9d0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -53,6 +53,7 @@ extern int cmd_stripspace(int argc, cons
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_zip_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_archive_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 05871ad..937b7f7 100644
--- a/git.c
+++ b/git.c
@@ -264,6 +264,7 @@ static void handle_internal_command(int 
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree, RUN_SETUP },
 		{ "zip-tree", cmd_zip_tree, RUN_SETUP },
+		{ "archive-tree", cmd_archive_tree, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },

-- 
VGER BF report: U 0.5
