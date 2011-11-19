From: Jeff King <peff@peff.net>
Subject: [PATCH] upload-archive: use start_command instead of fork
Date: Sat, 19 Nov 2011 02:40:04 -0500
Message-ID: <20111119074004.GA658@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 08:40:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRfX5-0003Hv-On
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 08:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab1KSHkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 02:40:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47650
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab1KSHkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 02:40:07 -0500
Received: (qmail 5746 invoked by uid 107); 19 Nov 2011 07:40:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Nov 2011 02:40:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Nov 2011 02:40:04 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185690>

The POSIX-function fork is not supported on Windows. Use our
start_command API instead, respawning ourselves in a special
"writer" mode to follow the alternate code path.

Remove the NOT_MINGW-prereq for t5000, as git-archive --remote
now works.

Signed-off-by: Jeff King <peff@peff.net>
---
Now that Junio has reverted the original implementation, I took a closer
look at how this ought to be done.

I looked briefly into doing the writing in-process, or using
start_async.  But the code relies too heavily on being able to die(),
and having the parent process grab stderr and the exit code to send to
the client. So going that direction would involve a lot of changes
either to the async code, or to the archive code.

We really do want a separate process, as it fits in with our usual die()
mentality for errors.  But fortunately looking into the async stuff made
me realize another issue with the original patch. Originally we forked
as the first thing. Thus any error messages or die()s (e.g., because we
couldn't enter_repo, or got bogus input from the client) would be in the
child process, and the parent sideband muxer would relay the errors
properly.  But in your original patch, we do quite a bit of processing
before spawning; those errors would go to git-daemon's stderr, and the
client would just see an unexpected hangup.

So we really do want to just switch the "fork immediately" to "spawn
immediately". Which fortunately means the change ends up being even
smaller, and I'm way more confident that there won't be side effects;
it's almost nothing but converting pipe/fork code into start_command
code.

And as an added bonus, the diffstat hopefully speaks for itself. :)

 builtin.h                |    1 +
 builtin/upload-archive.c |   43 ++++++++++++-------------------------------
 git.c                    |    1 +
 t/t5000-tar-tree.sh      |   10 +++++-----
 4 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/builtin.h b/builtin.h
index 0e9da90..f2357a9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -133,6 +133,7 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
+extern int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
 extern int cmd_var(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 2d0b383..b928beb 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -6,6 +6,7 @@
 #include "archive.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "run-command.h"
 
 static const char upload_archive_usage[] =
 	"git upload-archive <repo>";
@@ -13,12 +14,9 @@
 static const char deadchild[] =
 "git upload-archive: archiver died with error";
 
-static const char lostchild[] =
-"git upload-archive: archiver process was lost";
-
 #define MAX_ARGS (64)
 
-static int run_upload_archive(int argc, const char **argv, const char *prefix)
+int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 {
 	const char *sent_argv[MAX_ARGS];
 	const char *arg_cmd = "argument ";
@@ -96,8 +94,8 @@ static ssize_t process_input(int child_fd, int band)
 
 int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
-	pid_t writer;
-	int fd1[2], fd2[2];
+	struct child_process writer = { argv };
+
 	/*
 	 * Set up sideband subprocess.
 	 *
@@ -105,39 +103,24 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	 * multiplexed out to our fd#1.  If the child dies, we tell the other
 	 * end over channel #3.
 	 */
-	if (pipe(fd1) < 0 || pipe(fd2) < 0) {
-		int err = errno;
-		packet_write(1, "NACK pipe failed on the remote side\n");
-		die("upload-archive: %s", strerror(err));
-	}
-	writer = fork();
-	if (writer < 0) {
+	argv[0] = "upload-archive--writer";
+	writer.out = writer.err = -1;
+	writer.git_cmd = 1;
+	if (start_command(&writer)) {
 		int err = errno;
-		packet_write(1, "NACK fork failed on the remote side\n");
+		packet_write(1, "NACK unable to spawn subprocess\n");
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
 
-	/* parent - read from child, multiplex and send out to fd#1 */
-	close(fd1[1]); close(fd2[1]); /* we do not write to pipe */
 	packet_write(1, "ACK\n");
 	packet_flush(1);
 
 	while (1) {
 		struct pollfd pfd[2];
-		int status;
 
-		pfd[0].fd = fd1[0];
+		pfd[0].fd = writer.out;
 		pfd[0].events = POLLIN;
-		pfd[1].fd = fd2[0];
+		pfd[1].fd = writer.err;
 		pfd[1].events = POLLIN;
 		if (poll(pfd, 2, -1) < 0) {
 			if (errno != EINTR) {
@@ -156,9 +139,7 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 			if (process_input(pfd[0].fd, 1))
 				continue;
 
-		if (waitpid(writer, &status, 0) < 0)
-			error_clnt("%s", lostchild);
-		else if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+		if (finish_command(&writer))
 			error_clnt("%s", deadchild);
 		packet_flush(1);
 		break;
diff --git a/git.c b/git.c
index 8e34903..250f448 100644
--- a/git.c
+++ b/git.c
@@ -434,6 +434,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
+		{ "upload-archive--writer", cmd_upload_archive_writer },
 		{ "var", cmd_var, RUN_SETUP_GENTLY },
 		{ "verify-pack", cmd_verify_pack },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
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
1.7.7.3.8.g38efa
