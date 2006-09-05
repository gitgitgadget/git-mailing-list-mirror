From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: [PATCH 1/2] Add git-archive
Date: Tue, 5 Sep 2006 14:16:59 +0200
Message-ID: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 14:17:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKZrZ-0005x4-7u
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 14:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWIEMRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 08:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWIEMRF
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 08:17:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52493 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751394AbWIEMRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 08:17:01 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1917843ugc
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 05:17:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E8ujkc0jGOmtvoz6O8X2sNpNpgF1s6nPZBJ7TnNkbFOrnbAybwX/isvhwvQufuc1phA0Jc+4fEO+UeOchKrPxPmzXMjyw/A2DxOSxo7JB9rqtiKwhETh+OoTcZo2gMKVbQyPHLZuSHyKkSeJApnbGj/5d5NbyWh9MT2cxmzXrUU=
Received: by 10.67.93.7 with SMTP id v7mr3573768ugl;
        Tue, 05 Sep 2006 05:16:59 -0700 (PDT)
Received: by 10.67.95.4 with HTTP; Tue, 5 Sep 2006 05:16:59 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26472>

git-archive is a command to make TAR and ZIP archives of a git tree.
It helps prevent a proliferation of git-{format}-tree commands.

Instead of directly calling git-{tar,zip}-tree command, it defines
a very simple API, that archiver should implement and register in
"git-archive.c". This API is made up by 2 functions whose prototype
is defined in "archive.h" file.

 - The first one is used to parse 'extra' parameters which have
   signification only for the specific archiver. That would allow
   different archive backends to have different kind of options.

 - The second one is used to ask to an archive backend to build
   the archive given some already resolved parameters.

The main reason for making this API is to avoid using
git-{tar,zip}-tree commands, hence making them useless. Maybe it's
time for them to die ?

It also implements remote operations by defining a very simple
protocol: it first sends the name of the specific uploader followed
the repository name (git-upload-tar git://example.org/repo.git).
Then it sends "arguments" key word followed by all options given
when invoking 'git-archive'.

The remote protocol is implemented in "git-archive.c" for client
side and is triggered by "--remote=<repo>" option. For example,
to fetch a TAR archive in a remote repo, you can issue:

$ git archive --format=tar --remote=git://xxx/yyy/zzz.git HEAD

We choose to not make a new command "git-fetch-archive" for example,
avoind one more GIT command which should be nice for users (less
commands to remember, keeps existing --remote option).

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 .gitignore          |    1
 Makefile            |    3 -
 archive.h           |   43 ++++++++
 builtin-archive.c   |  262 +++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin-tar-tree.c  |   66 +++++++++++++
 builtin.h           |    1
 generate-cmdlist.sh |    1
 git.c               |    1
 8 files changed, 377 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 78cb671..a3e7ca1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,6 +8,7 @@ git-apply
 git-applymbox
 git-applypatch
 git-archimport
+git-archive
 git-bisect
 git-branch
 git-cat-file
diff --git a/Makefile b/Makefile
index 389daf7..51ed4dd 100644
--- a/Makefile
+++ b/Makefile
@@ -242,7 +242,7 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a

 LIB_H = \
-	blob.h cache.h commit.h csum-file.h delta.h \
+	archive.h blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h para-walk.h pkt-line.h quote.h refs.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h
@@ -267,6 +267,7 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-add.o \
 	builtin-apply.o \
+	builtin-archive.o \
 	builtin-cat-file.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
diff --git a/archive.h b/archive.h
new file mode 100644
index 0000000..6c69953
--- /dev/null
+++ b/archive.h
@@ -0,0 +1,43 @@
+#ifndef ARCHIVE_H
+#define ARCHIVE_H
+
+typedef int (*write_archive_fn_t)(struct tree *tree,
+				  const unsigned char *commit_sha1,
+				  const char *prefix,
+				  time_t time,
+				  const char **pathspec);
+
+typedef int (*parse_extra_args_fn_t)(int argc,
+				     const char **argv,
+				     const char **reason);
+
+struct archiver_struct {
+	const char *name;
+	write_archive_fn_t write_archive;
+	parse_extra_args_fn_t parse_extra;
+	const char *remote;
+	const char *prefix;
+};
+
+extern struct archiver_struct archivers[];
+
+extern int parse_archive_args(int argc, const char **argv,
+			      struct archiver_struct **ar,
+			      const char **reason);
+
+extern int parse_treeish_arg(const char **argv,
+			     struct tree **tree,
+			     const unsigned char **commit_sha1,
+			     time_t *archive_time,
+			     const char *prefix,
+			     const char **reason);
+/*
+ *
+ */
+extern int write_tar_archive(struct tree *tree,
+			     const unsigned char *commit_sha1,
+			     const char *prefix,
+			     time_t time,
+			     const char **pathspec);
+
+#endif	/* ARCHIVE_H */
diff --git a/builtin-archive.c b/builtin-archive.c
new file mode 100644
index 0000000..9341813
--- /dev/null
+++ b/builtin-archive.c
@@ -0,0 +1,262 @@
+/*
+ * Copyright (c) 2006 Franck Bui-Huu
+ * Copyright (c) 2006 Rene Scharfe
+ */
+#include <time.h>
+#include "cache.h"
+#include "builtin.h"
+#include "archive.h"
+#include "commit.h"
+#include "tree-walk.h"
+#include "exec_cmd.h"
+#include "pkt-line.h"
+
+static const char archive_usage[] = \
+"git-archive --format=<fmt> [--prefix=<prefix>/] [-0|...|-9]
<tree-ish> [path...]";
+
+struct archiver_struct archivers[] = {
+	{ "tar", write_tar_archive },
+};
+
+static void concat_argv(int argc, const char **argv, char line[], int size)
+{
+	char *p;
+	int len, i;
+
+	p = line;
+	for (i = 1; i < argc; i++) {
+		/* server needn't these options */
+		if (!strncmp(argv[i], "--format=", 9) ||
+		    !strncmp(argv[i], "--remote=", 9))
+			continue;
+
+		len = strlen(argv[i]);
+		if (p + len + 1> line + size)
+			die("too many options");
+
+		strcpy(p, argv[i]);
+		p += len;
+		*p++ = ' ';
+	}
+	if (p > line)
+		p--;
+	*p = '\0';
+}
+
+static int run_remote_archiver(struct archiver_struct *ar, int argc,
+			       const char **argv)
+{
+	char *url, buf[1024];
+	pid_t pid;
+	int fd[2];
+	int len, rv;
+
+	sprintf(buf, "git-upload-%s", ar->name);
+
+	url = strdup(ar->remote);
+	pid = git_connect(fd, url, buf);
+	if (pid < 0)
+		return pid;
+
+	concat_argv(argc, argv, buf, sizeof(buf));
+
+	packet_write(fd[1], "arguments %s\n", buf);
+	packet_flush(fd[1]);
+
+	len = packet_read_line(fd[0], buf, sizeof(buf));
+	if (!len)
+		die("git-archive: expected ACK/NAK, got EOF");
+	if (buf[len-1] == '\n')
+		buf[--len] = 0;
+	if (strcmp(buf, "ACK")) {
+		if (len > 5 && !strncmp(buf, "NACK ", 5))
+			die("git-archive: NACK %s", buf + 5);
+		die("git-archive: protocol error");
+	}
+
+	len = packet_read_line(fd[0], buf, sizeof(buf));
+	if (len)
+		die("git-archive: expected a flush");
+
+	/* Now, start reading from fd[0] and spit it out to stdout */
+	rv = copy_fd(fd[0], 1);
+
+	close(fd[0]);
+	rv |= finish_connect(pid);
+
+	return !!rv;
+}
+
+static struct archiver_struct *get_archiver(const char *name)
+{
+	struct archiver_struct *ar = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
+		if (!strcmp(name, archivers[i].name)) {
+			ar = &archivers[i];
+			break;
+		}
+	}
+	return ar;
+}
+
+int parse_treeish_arg(const char **argv, struct tree **tree,
+		      const unsigned char **commit_sha1,
+		      time_t *archive_time, const char *prefix,
+		      const char **reason)
+{
+	const char *name = argv[0];
+	struct commit *commit;
+	unsigned char sha1[20];
+	int rv = -1;
+
+	if (get_sha1(name, sha1)) {
+		*reason = "Not a valid object name";
+		goto out;
+	}
+
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (commit) {
+		*commit_sha1 = commit->object.sha1;
+		*archive_time = commit->date;
+	} else {
+		*archive_time = time(NULL);
+	}
+
+	*tree = parse_tree_indirect(sha1);
+	if (*tree == NULL) {
+		*reason = "not a tree object";
+		goto out;
+	}
+
+	if (prefix) {
+		unsigned char tree_sha1[20];
+		unsigned int mode;
+		int err;
+
+		err = get_tree_entry((*tree)->object.sha1, prefix,
+				     tree_sha1, &mode);
+		if (err || !S_ISDIR(mode)) {
+			*reason = "current working directory is untracked";
+			goto out;
+		}
+		free(*tree);
+		*tree = parse_tree_indirect(tree_sha1);
+	}
+	//free(*tree);
+	rv = 0;
+out:
+	return rv;
+}
+
+int parse_archive_args(int argc, const char **argv,
+		       struct archiver_struct **ar,
+		       const char **reason)
+{
+	const char *format = NULL;
+	const char *remote = NULL;
+	const char *prefix = NULL;
+	int list = 0;
+	int rv = -1, i;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--list") || !strcmp(arg, "-l")) {
+			list = 1;
+			continue;
+		}
+		if (!strncmp(arg, "--format=", 9)) {
+			format = arg + 9;
+			continue;
+		}
+		if (!strncmp(arg, "--prefix=", 9)) {
+			prefix = arg + 9;
+			continue;
+		}
+		if (!strncmp(arg, "--remote=", 9)) {
+			remote = arg + 9;
+			continue;
+		}
+		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0') {
+			zlib_compression_level = arg[1] - '0';
+			continue;
+		}
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (arg[0] == '-') {
+			*reason = archive_usage;
+			goto out;
+		}
+		break;
+	}
+	if (list) {
+		if (!remote) {
+			int i;
+
+			for (i = 0; i < ARRAY_SIZE(archivers); i++)
+				printf("%s\n", archivers[i].name);
+			exit(0);
+		}
+		*reason = "--list and --remote not supported together";
+		goto out;
+	}
+	if (argc - i < 1) {
+		*reason = archive_usage;
+		goto out;
+	}
+	if (!format){
+		*reason = "You must specify an archive format";
+		goto out;
+	}
+	*ar = get_archiver(format);
+	if (*ar == NULL) {
+		*reason = "Unknown archive format";
+		goto out;
+	}
+	if ((*ar)->parse_extra) {
+		if ((*ar)->parse_extra(argc, argv, reason) < 0)
+			goto out;
+	}
+	(*ar)->remote = remote;
+	(*ar)->prefix = prefix ? : "";
+	rv = i;
+out:
+	return rv;
+}
+
+int cmd_archive(int argc, const char **argv, const char *prefix)
+{
+	struct archiver_struct *ar;
+	const char *reason;
+	const char **pathspec;
+	struct tree *tree;
+	const unsigned char *commit_sha1;
+	time_t archive_time;
+	int rv;
+
+	rv = parse_archive_args(argc, argv, &ar, &reason);
+	if (rv < 0)
+		goto err;
+
+	if (ar->remote)
+		return run_remote_archiver(ar, argc, argv);
+
+	if (prefix == NULL)
+		prefix = setup_git_directory();
+
+	argv += rv;
+	if (parse_treeish_arg(argv, &tree, &commit_sha1,
+			      &archive_time, prefix, &reason) < 0)
+		goto err;
+
+	pathspec = get_pathspec(ar->prefix, argv + 1);
+
+	return ar->write_archive(tree, commit_sha1, ar->prefix,
+				 archive_time, pathspec);
+err:
+	return error("%s", reason);
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
diff --git a/builtin.h b/builtin.h
index 8472c79..2391afb 100644
--- a/builtin.h
+++ b/builtin.h
@@ -15,6 +15,7 @@ extern int write_tree(unsigned char *sha

 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
+extern int cmd_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const
char *prefix);
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index ec1eda2..5450918 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -12,6 +12,7 @@ struct cmdname_help common_cmds[] = {"
 sort <<\EOF |
 add
 apply
+archive
 bisect
 branch
 checkout
diff --git a/git.c b/git.c
index 82c8fee..c62c5cf 100644
--- a/git.c
+++ b/git.c
@@ -218,6 +218,7 @@ static void handle_internal_command(int
 	} commands[] = {
 		{ "add", cmd_add, RUN_SETUP },
 		{ "apply", cmd_apply },
+		{ "archive", cmd_archive },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
-- 
1.4.2.gbba4
