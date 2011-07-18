From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 18 Jul 2011 20:08:36 +0200
Message-ID: <1311012516-4836-5-git-send-email-kusmabite@gmail.com>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 20:09:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QisFb-0006Ch-5S
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 20:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab1GRSI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 14:08:56 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:35701 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232Ab1GRSIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:08:55 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so7013726fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=irkecwpdnyAseflmAg9sbXOFypDKn3A9Qij687CW830=;
        b=ggC3ELW95fkKK9PhNtLUZtF8NANCxSSUUw0RVMiTlfuSOCtk0IjDn1CeErFvpbwaIJ
         tyl/Nh3KFdnIOd9t7w17m5l29jEzdM8FBcJoZIsv2DlRP3XQVObt4x6vZIfsFngfs80b
         FzRpkqP/Iy1k5GBMfYXgE3TZiFLQkoCJXdB7g=
Received: by 10.223.120.134 with SMTP id d6mr4625936far.112.1311012534907;
        Mon, 18 Jul 2011 11:08:54 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id n27sm3114213faa.4.2011.07.18.11.08.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 11:08:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.4055.gbf1a7
In-Reply-To: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177391>

The POSIX-function fork is not supported on Windows. Use our
start_command API instead.

As this is the last call-site that depends on the fork-stub in
compat/mingw.h, remove that as well.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin/upload-archive.c |   65 +++++++++++++--------------------------------
 compat/mingw.h           |    2 -
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 73f788e..0c192b5 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -6,6 +6,7 @@
 #include "archive.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "run-command.h"
 
 static const char upload_archive_usage[] =
 	"git upload-archive <repo>";
@@ -18,28 +19,16 @@ static const char lostchild[] =
 
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
 	sent_argc = 1;
-	sent_argv[0] = "git-upload-archive";
+	sent_argv[0] = "archive";
 	for (p = buf;;) {
 		/* This will die if not enough free space in buf */
 		len = packet_read_line(0, p, (buf + sizeof buf) - p);
@@ -62,9 +51,6 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 		*p++ = 0;
 	}
 	sent_argv[sent_argc] = NULL;
-
-	/* parse all options sent by the client */
-	return write_archive(sent_argc, sent_argv, prefix, 0);
 }
 
 __attribute__((format (printf, 1, 2)))
@@ -96,38 +82,25 @@ static ssize_t process_input(int child_fd, int band)
 
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
 
@@ -135,9 +108,9 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
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
@@ -156,7 +129,7 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
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
-- 
1.7.6.135.g378e9
