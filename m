From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 4/4] upload-archive: use start_command instead of fork
Date: Thu, 29 Sep 2011 22:59:23 +0200
Message-ID: <1317329963-6656-5-git-send-email-kusmabite@gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org, gitster@pobox.com,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 22:59:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Nhu-00023q-8N
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757777Ab1I2U7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 16:59:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39978 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757761Ab1I2U7n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 16:59:43 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1097794bkb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MBmQ8LZJvFmijtjeCCatkpdq7GlihcSPvstce9CMqQM=;
        b=FRVOrKAW/CW4VvqUtUymdA/ky6rlQSvUNM2ln78y+s7JQEsOkdPCC50gf/VeReOzEC
         8dxx12cbGgAf4/Zo5ZIDB6YEt9+DAETB9yKNURoNw+WDZF421S7JPmsrtKSBZcm+L0pm
         mzZPpXYO0nGDjX+nWW6opsmZwfKkUrbxHOX40=
Received: by 10.204.130.11 with SMTP id q11mr6984322bks.91.1317329982526;
        Thu, 29 Sep 2011 13:59:42 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no. [84.215.188.225])
        by mx.google.com with ESMTPS id v16sm2853474bkd.6.2011.09.29.13.59.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 13:59:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.355.g842ba.dirty
In-Reply-To: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182438>

The POSIX-function fork is not supported on Windows. Use our
start_command API instead.

As this is the last call-site that depends on the fork-stub in
compat/mingw.h, remove that as well.

Add an undocumented flag to git-archive that tells it that the
action originated from a remote, so features can be disabled.
Thanks to Jeff King for work on this part.

Remove the NOT_MINGW-prereq for t5000, as git-archive --remote
now works.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
 builtin/archive.c        |    6 +++-
 builtin/upload-archive.c |   68 ++++++++++++++-------------------------------
 compat/mingw.h           |    2 -
 t/t5000-tar-tree.sh      |   10 +++---
 4 files changed, 31 insertions(+), 55 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 883c009..6668340 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -85,6 +85,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *exec = "git-upload-archive";
 	const char *output = NULL;
 	const char *remote = NULL;
+	int is_remote = 0;
 	struct option local_opts[] = {
 		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
@@ -92,6 +93,9 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 			"retrieve the archive from remote repository <repo>"),
 		OPT_STRING(0, "exec", &exec, "cmd",
 			"path to the remote git-upload-archive command"),
+		{ OPTION_BOOLEAN, 0, "remote-request", &is_remote, NULL,
+			"indicate we are serving a remote request",
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_END()
 	};
 
@@ -106,5 +110,5 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	return write_archive(argc, argv, prefix, 1, output, 0);
+	return write_archive(argc, argv, prefix, 1, output, is_remote);
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 2d0b383..c57e8bd 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -6,6 +6,7 @@
 #include "archive.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "run-command.h"
 
 static const char upload_archive_usage[] =
 	"git upload-archive <repo>";
@@ -18,28 +19,17 @@ static const char lostchild[] =
 
 #define MAX_ARGS (64)
 
-static int run_upload_archive(int argc, const char **argv, const char *prefix)
+static void prepare_argv(const char **sent_argv, const char **argv)
 {
-	const char *sent_argv[MAX_ARGS];
 	const char *arg_cmd = "argument ";
 	char *p, buf[4096];
 	int sent_argc;
 	int len;
 
-	if (argc != 2)
-		usage(upload_archive_usage);
-
-	if (strlen(argv[1]) + 1 > sizeof(buf))
-		die("insanely long repository name");
-
-	strcpy(buf, argv[1]); /* enter-repo smudges its argument */
-
-	if (!enter_repo(buf, 0))
-		die("'%s' does not appear to be a git repository", buf);
-
 	/* put received options in sent_argv[] */
-	sent_argc = 1;
-	sent_argv[0] = "git-upload-archive";
+	sent_argc = 2;
+	sent_argv[0] = "archive";
+	sent_argv[1] = "--remote-request";
 	for (p = buf;;) {
 		/* This will die if not enough free space in buf */
 		len = packet_read_line(0, p, (buf + sizeof buf) - p);
@@ -62,9 +52,6 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 		*p++ = 0;
 	}
 	sent_argv[sent_argc] = NULL;
-
-	/* parse all options sent by the client */
-	return write_archive(sent_argc, sent_argv, prefix, 0, NULL, 1);
 }
 
 __attribute__((format (printf, 1, 2)))
@@ -96,38 +83,25 @@ static ssize_t process_input(int child_fd, int band)
 
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
-	pid_t writer;
-	int fd1[2], fd2[2];
-	/*
-	 * Set up sideband subprocess.
-	 *
-	 * We (parent) monitor and read from child, sending its fd#1 and fd#2
-	 * multiplexed out to our fd#1.  If the child dies, we tell the other
-	 * end over channel #3.
-	 */
-	if (pipe(fd1) < 0 || pipe(fd2) < 0) {
-		int err = errno;
-		packet_write(1, "NACK pipe failed on the remote side\n");
-		die("upload-archive: %s", strerror(err));
-	}
-	writer = fork();
-	if (writer < 0) {
+	const char *sent_argv[MAX_ARGS];
+	struct child_process cld = { sent_argv };
+	cld.out = cld.err = -1;
+	cld.git_cmd = 1;
+
+	if (argc != 2)
+		usage(upload_archive_usage);
+
+	if (!enter_repo(argv[1], 0))
+		die("'%s' does not appear to be a git repository", argv[1]);
+
+	prepare_argv(sent_argv, argv);
+	if (start_command(&cld)) {
 		int err = errno;
 		packet_write(1, "NACK fork failed on the remote side\n");
 		die("upload-archive: %s", strerror(err));
 	}
-	if (!writer) {
-		/* child - connect fd#1 and fd#2 to the pipe */
-		dup2(fd1[1], 1);
-		dup2(fd2[1], 2);
-		close(fd1[1]); close(fd2[1]);
-		close(fd1[0]); close(fd2[0]); /* we do not read from pipe */
-
-		exit(run_upload_archive(argc, argv, prefix));
-	}
 
 	/* parent - read from child, multiplex and send out to fd#1 */
-	close(fd1[1]); close(fd2[1]); /* we do not write to pipe */
 	packet_write(1, "ACK\n");
 	packet_flush(1);
 
@@ -135,9 +109,9 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 		struct pollfd pfd[2];
 		int status;
 
-		pfd[0].fd = fd1[0];
+		pfd[0].fd = cld.out;
 		pfd[0].events = POLLIN;
-		pfd[1].fd = fd2[0];
+		pfd[1].fd = cld.err;
 		pfd[1].events = POLLIN;
 		if (poll(pfd, 2, -1) < 0) {
 			if (errno != EINTR) {
@@ -156,7 +130,7 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 			if (process_input(pfd[0].fd, 1))
 				continue;
 
-		if (waitpid(writer, &status, 0) < 0)
+		if (waitpid(cld.pid, &status, 0) < 0)
 			error_clnt("%s", lostchild);
 		else if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
 			error_clnt("%s", deadchild);
diff --git a/compat/mingw.h b/compat/mingw.h
index ce9dd98..9cb6eb9 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -85,8 +85,6 @@ static inline int symlink(const char *oldpath, const char *newpath)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes, mode_t mode)
 { errno = ENOSYS; return -1; }
-static inline pid_t fork(void)
-{ errno = ENOSYS; return -1; }
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index d906898..889842e 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -96,7 +96,7 @@ test_expect_success 'git archive with --output' \
     'git archive --output=b4.tar HEAD &&
     test_cmp b.tar b4.tar'
 
-test_expect_success NOT_MINGW 'git archive --remote' \
+test_expect_success 'git archive --remote' \
     'git archive --remote=. HEAD >b5.tar &&
     test_cmp b.tar b5.tar'
 
@@ -266,7 +266,7 @@ test_expect_success 'archive --list mentions user filter' '
 	grep "^bar\$" output
 '
 
-test_expect_success NOT_MINGW 'archive --list shows only enabled remote filters' '
+test_expect_success 'archive --list shows only enabled remote filters' '
 	git archive --list --remote=. >output &&
 	! grep "^tar\.foo\$" output &&
 	grep "^bar\$" output
@@ -298,7 +298,7 @@ test_expect_success 'extension matching requires dot' '
 	test_cmp b.tar config-implicittar.foo
 '
 
-test_expect_success NOT_MINGW 'only enabled filters are available remotely' '
+test_expect_success 'only enabled filters are available remotely' '
 	test_must_fail git archive --remote=. --format=tar.foo HEAD \
 		>remote.tar.foo &&
 	git archive --remote=. --format=bar >remote.bar HEAD &&
@@ -341,12 +341,12 @@ test_expect_success GZIP,GUNZIP 'extract tgz file' '
 	test_cmp b.tar j.tar
 '
 
-test_expect_success GZIP,NOT_MINGW 'remote tar.gz is allowed by default' '
+test_expect_success GZIP 'remote tar.gz is allowed by default' '
 	git archive --remote=. --format=tar.gz HEAD >remote.tar.gz &&
 	test_cmp j.tgz remote.tar.gz
 '
 
-test_expect_success GZIP,NOT_MINGW 'remote tar.gz can be disabled' '
+test_expect_success GZIP 'remote tar.gz can be disabled' '
 	git config tar.tar.gz.remote false &&
 	test_must_fail git archive --remote=. --format=tar.gz HEAD \
 		>remote.tar.gz
-- 
1.7.6.355.g842ba.dirty
