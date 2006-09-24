From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-tar-tree: Move code for git-archive --format=tar to archive-tar.c
Date: Sun, 24 Sep 2006 14:41:23 -0700
Message-ID: <7vr6y16iyk.fsf@assigned-by-dhcp.cox.net>
References: <4516A4BE.9090406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 23:41:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRbj6-0007hM-RV
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 23:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWIXVlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 17:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWIXVlZ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 17:41:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38577 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751557AbWIXVlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 17:41:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924214124.QJY12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 17:41:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id SMhR1V00o1kojtg0000000
	Sun, 24 Sep 2006 17:41:26 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4516A4BE.9090406@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sun, 24 Sep 2006 17:31:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27699>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> This patch doesn't change any functionality, it only moves code around.  It
> makes seeing the few remaining lines of git-tar-tree code easier. ;-)
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Thanks.  And here is an obvious follow-up to it.

-- >8 --
[PATCH] Remove upload-tar and make git-tar-tree a thin wrapper to git-archive

---
diff --git a/.gitignore b/.gitignore
index 3ca66e4..284db5d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -122,7 +122,6 @@ git-update-ref
 git-update-server-info
 git-upload-archive
 git-upload-pack
-git-upload-tar
 git-var
 git-verify-pack
 git-verify-tag
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 1e1c7fa..74a6fdd 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -12,6 +12,9 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+THIS COMMAND IS DEPRECATED.  Use `git-archive` with `--format=tar`
+option instead.
+
 Creates a tar archive containing the tree structure for the named tree.
 When <base> is specified it is added as a leading path to the files in the
 generated tar archive.
diff --git a/Documentation/git-upload-tar.txt b/Documentation/git-upload-tar.txt
deleted file mode 100644
index 394af62..0000000
--- a/Documentation/git-upload-tar.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-git-upload-tar(1)
-=================
-
-NAME
-----
-git-upload-tar - Send tar archive
-
-
-SYNOPSIS
---------
-'git-upload-tar' <directory>
-
-DESCRIPTION
------------
-Invoked by 'git-tar-tree --remote' and sends a generated tar archive
-to the other end over the git protocol.
-
-This command is usually not invoked directly by the end user.
-The UI for the protocol is on the 'git-tar-tree' side, and the
-program pair is meant to be used to get a tar archive from a
-remote repository.
-
-
-OPTIONS
--------
-<directory>::
-	The repository to get a tar archive from.
-
-Author
-------
-Written by Junio C Hamano <junio@kernel.org>
-
-Documentation
---------------
-Documentation by Junio C Hamano.
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 744c38d..1bf5ef5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -247,10 +247,6 @@ gitlink:git-upload-pack[1]::
 	Invoked by 'git-fetch-pack' to push
 	what are asked for.
 
-gitlink:git-upload-tar[1]::
-	Invoked by 'git-tar-tree --remote' to return the tar
-	archive the other end asked for.
-
 
 High-level commands (porcelain)
 -------------------------------
diff --git a/Makefile b/Makefile
index d4f6e01..35de011 100644
--- a/Makefile
+++ b/Makefile
@@ -298,7 +298,6 @@ BUILTIN_OBJS = \
 	builtin-update-index.o \
 	builtin-update-ref.o \
 	builtin-upload-archive.o \
-	builtin-upload-tar.o \
 	builtin-verify-pack.o \
 	builtin-write-tree.o
 
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index aa370e3..5d2bec0 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -8,94 +8,66 @@ #include "tar.h"
 #include "builtin.h"
 #include "pkt-line.h"
 #include "archive.h"
-
-#define RECORDSIZE	(512)
-#define BLOCKSIZE	(RECORDSIZE * 20)
+#include "quote.h"
 
 static const char tar_tree_usage[] =
-"git-tar-tree [--remote=<repo>] <tree-ish> [basedir]";
+"git-tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
+"*** Note that this command is now deprecated; use git-archive instead.";
 
-static int generate_tar(int argc, const char **argv, const char *prefix)
+int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 {
-	struct archiver_args args;
-	int result;
-	char *base = NULL;
-
-	memset(&args, 0, sizeof(args));
-	if (argc != 2 && argc != 3)
-		usage(tar_tree_usage);
-	if (argc == 3) {
-		int baselen = strlen(argv[2]);
-		base = xmalloc(baselen + 2);
-		memcpy(base, argv[2], baselen);
-		base[baselen] = '/';
-		base[baselen + 1] = '\0';
+	/*
+	 * git-tar-tree is now a wrapper around git-archive --format=tar
+	 *
+	 * $0 --remote=<repo> arg... ==>
+	 *	git-archive --format=tar --remote=<repo> arg...
+	 * $0 tree-ish ==>
+	 *	git-archive --format=tar tree-ish
+	 * $0 tree-ish basedir ==>
+	 * 	git-archive --format-tar --prefix=basedir tree-ish
+	 */ 
+	int i;
+	const char **nargv = xcalloc(sizeof(*nargv), argc + 2);
+	char *basedir_arg;
+	int nargc = 0;
+
+	nargv[nargc++] = "git-archive";
+	nargv[nargc++] = "--format=tar";
+
+	if (2 <= argc && !strncmp("--remote=", argv[1], 9)) {
+		nargv[nargc++] = argv[1];
+		argv++;
+		argc--;
 	}
-	args.base = base;
-	parse_treeish_arg(argv + 1, &args, NULL);
-
-	result = write_tar_archive(&args);
-	free(base);
-
-	return result;
-}
-
-static const char *exec = "git-upload-tar";
-
-static int remote_tar(int argc, const char **argv)
-{
-	int fd[2], ret, len;
-	pid_t pid;
-	char buf[1024];
-	char *url;
-
-	if (argc < 3 || 4 < argc)
+	switch (argc) {
+	default:
 		usage(tar_tree_usage);
-
-	/* --remote=<repo> */
-	url = xstrdup(argv[1]+9);
-	pid = git_connect(fd, url, exec);
-	if (pid < 0)
-		return 1;
-
-	packet_write(fd[1], "want %s\n", argv[2]);
-	if (argv[3])
-		packet_write(fd[1], "base %s\n", argv[3]);
-	packet_flush(fd[1]);
-
-	len = packet_read_line(fd[0], buf, sizeof(buf));
-	if (!len)
-		die("git-tar-tree: expected ACK/NAK, got EOF");
-	if (buf[len-1] == '\n')
-		buf[--len] = 0;
-	if (strcmp(buf, "ACK")) {
-		if (5 < len && !strncmp(buf, "NACK ", 5))
-			die("git-tar-tree: NACK %s", buf + 5);
-		die("git-tar-tree: protocol error");
+		break;
+	case 3:
+		/* base-path */ 
+		basedir_arg = xmalloc(strlen(argv[2]) + 10);
+		sprintf(basedir_arg, "--prefix=%s", argv[2]);
+		nargv[nargc++] = basedir_arg;
+		/* fallthru */
+	case 2:
+		/* tree-ish */
+		nargv[nargc++] = argv[1];
 	}
-	/* expect a flush */
-	len = packet_read_line(fd[0], buf, sizeof(buf));
-	if (len)
-		die("git-tar-tree: expected a flush");
-
-	/* Now, start reading from fd[0] and spit it out to stdout */
-	ret = copy_fd(fd[0], 1);
-	close(fd[0]);
-
-	ret |= finish_connect(pid);
-	return !!ret;
-}
-
-int cmd_tar_tree(int argc, const char **argv, const char *prefix)
-{
-	if (argc < 2)
-		usage(tar_tree_usage);
-	if (!strncmp("--remote=", argv[1], 9))
-		return remote_tar(argc, argv);
-	return generate_tar(argc, argv, prefix);
+	nargv[nargc] = NULL;
+	
+	fprintf(stderr,
+		"*** git-tar-tree is now deprecated.\n"
+		"*** Running git-archive instead.\n***");
+	for (i = 0; i < nargc; i++) {
+		fputc(' ', stderr);
+		sq_quote_print(stderr, nargv[i]);
+	}
+	fputc('\n', stderr);
+	return cmd_archive(nargc, nargv, prefix);
 }
 
 /* ustar header + extended global header content */
+#define RECORDSIZE	(512)
 #define HEADERSIZE (2 * RECORDSIZE)
 
 int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
diff --git a/builtin-upload-tar.c b/builtin-upload-tar.c
deleted file mode 100644
index 06a945a..0000000
--- a/builtin-upload-tar.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Copyright (c) 2006 Junio C Hamano
- */
-#include "cache.h"
-#include "pkt-line.h"
-#include "exec_cmd.h"
-#include "builtin.h"
-
-static const char upload_tar_usage[] = "git-upload-tar <repo>";
-
-static int nak(const char *reason)
-{
-	packet_write(1, "NACK %s\n", reason);
-	packet_flush(1);
-	return 1;
-}
-
-int cmd_upload_tar(int argc, const char **argv, const char *prefix)
-{
-	int len;
-	const char *dir = argv[1];
-	char buf[8192];
-	unsigned char sha1[20];
-	char *base = NULL;
-	char hex[41];
-	int ac;
-	const char *av[4];
-
-	if (argc != 2)
-		usage(upload_tar_usage);
-	if (strlen(dir) < sizeof(buf)-1)
-		strcpy(buf, dir); /* enter-repo smudges its argument */
-	else
-		packet_write(1, "NACK insanely long repository name %s\n", dir);
-	if (!enter_repo(buf, 0)) {
-		packet_write(1, "NACK not a git archive %s\n", dir);
-		packet_flush(1);
-		return 1;
-	}
-
-	len = packet_read_line(0, buf, sizeof(buf));
-	if (len < 5 || strncmp("want ", buf, 5))
-		return nak("expected want");
-	if (buf[len-1] == '\n')
-		buf[--len] = 0;
-	if (get_sha1(buf + 5, sha1))
-		return nak("expected sha1");
-        strcpy(hex, sha1_to_hex(sha1));
-
-	len = packet_read_line(0, buf, sizeof(buf));
-	if (len) {
-		if (len < 5 || strncmp("base ", buf, 5))
-			return nak("expected (optional) base");
-		if (buf[len-1] == '\n')
-			buf[--len] = 0;
-		base = xstrdup(buf + 5);
-		len = packet_read_line(0, buf, sizeof(buf));
-	}
-	if (len)
-		return nak("expected flush");
-
-	packet_write(1, "ACK\n");
-	packet_flush(1);
-
-	ac = 0;
-	av[ac++] = "tar-tree";
-	av[ac++] = hex;
-	if (base)
-		av[ac++] = base;
-	av[ac++] = NULL;
-	execv_git_cmd(av);
-	/* should it return that is an error */
-	return 1;
-}
diff --git a/git.c b/git.c
index 1686220..ae80e78 100644
--- a/git.c
+++ b/git.c
@@ -263,7 +263,6 @@ static void handle_internal_command(int 
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
-		{ "upload-tar", cmd_upload_tar },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
