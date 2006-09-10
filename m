From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Add sideband status report to git-archive protocol
Date: Sun, 10 Sep 2006 03:47:27 -0700
Message-ID: <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 12:46:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMMpw-0005ti-LS
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 12:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWIJKqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 06:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWIJKqu
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 06:46:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43176 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750732AbWIJKqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 06:46:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910104647.BYH2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Sep 2006 06:46:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lamo1V00a1kojtg0000000
	Sun, 10 Sep 2006 06:46:49 -0400
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <7vk64ctctv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 10 Sep 2006 00:12:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26793>

Using the refactored sideband code from existing upload-pack protocol,
this lets the error condition and status output sent from the remote
process to be shown locally.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This does it in a "stupid" way.  Ideally, write(2) to fd 1
   and 2 in each archiver backend could be wrapped with
   something like upload-pack.c::send_client_data() that does
   straight write(2) to the original destination when it is not
   driven by upload-pack, or use send_sideband() when it is, and
   that way we can lose two pipes and the multiplexer process.

   The sending side of the upload-pack protocol also does this
   in the stupid way, but it has an excuse.  It needs to set
   up a complex pipe and spawn a subprocess (pack-objects) that
   does not even want to know about send_client_data().

   What is driven by upload-archive() does not have to be a
   subprocess (it is just a single ar.write_archive() function
   call away), so having to do an extra fork for the multiplexer
   is a bit sad...

 builtin-archive.c        |   24 ++++++++++--
 builtin-upload-archive.c |   92 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index b78d6d8..0c2ad49 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -10,6 +10,7 @@ #include "commit.h"
 #include "tree-walk.h"
 #include "exec_cmd.h"
 #include "pkt-line.h"
+#include "sideband.h"
 
 static const char archive_usage[] = \
 "git-archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
@@ -32,16 +33,30 @@ static int run_remote_archiver(const cha
 	char *url, buf[1024];
 	int fd[2], i, len, rv;
 	pid_t pid;
+	const char *exec = "git-upload-archive";
+	int exec_at = 0;
 
-	sprintf(buf, "git-upload-archive");
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strncmp("--exec=", arg, 7)) {
+			if (exec_at)
+				die("multiple --exec specified");
+			exec = arg + 7;
+			exec_at = i;
+			break;
+		}
+	}
 
 	url = xstrdup(remote);
-	pid = git_connect(fd, url, buf);
+	pid = git_connect(fd, url, exec);
 	if (pid < 0)
 		return pid;
 
-	for (i = 1; i < argc; i++)
+	for (i = 1; i < argc; i++) {
+		if (i == exec_at)
+			continue;
 		packet_write(fd[1], "argument %s\n", argv[i]);
+	}
 	packet_flush(fd[1]);
 
 	len = packet_read_line(fd[0], buf, sizeof(buf));
@@ -60,8 +75,7 @@ static int run_remote_archiver(const cha
 		die("git-archive: expected a flush");
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
-	rv = copy_fd(fd[0], 1);
-
+	rv = recv_sideband("archive", fd[0], 1, 2, buf, sizeof(buf));
 	close(fd[0]);
 	rv |= finish_connect(pid);
 
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 3bdb607..96f96bd 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -6,12 +6,18 @@ #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
 #include "pkt-line.h"
+#include "sideband.h"
+#include <sys/wait.h>
+#include <sys/poll.h>
 
 static const char upload_archive_usage[] =
 	"git-upload-archive <repo>";
 
+static const char deadchild[] =
+"git-upload-archive: archiver died with error";
 
-int cmd_upload_archive(int argc, const char **argv, const char *prefix)
+
+static int run_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	struct archiver ar;
 	const char *sent_argv[MAX_ARGS];
@@ -64,9 +70,89 @@ int cmd_upload_archive(int argc, const c
 	parse_treeish_arg(sent_argv + treeish_idx, &ar.args, prefix);
 	parse_pathspec_arg(sent_argv + treeish_idx + 1, &ar.args);
 
+	return ar.write_archive(&ar.args);
+}
+
+int cmd_upload_archive(int argc, const char **argv, const char *prefix)
+{
+	pid_t writer;
+	int fd1[2], fd2[2];
+	/*
+	 * Set up sideband subprocess.
+	 *
+	 * We (parent) monitor and read from child, sending its fd#1 and fd#2
+	 * multiplexed out to our fd#1.  If the child dies, we tell the other
+	 * end over channel #3.
+	 */
+	if (pipe(fd1) < 0 || pipe(fd2) < 0) {
+		int err = errno;
+		packet_write(1, "NACK pipe failed on the remote side\n");
+		die("upload-archive: %s", strerror(err));
+	}
+	writer = fork();
+	if (writer < 0) {
+		int err = errno;
+		packet_write(1, "NACK fork failed on the remote side\n");
+		die("upload-archive: %s", strerror(err));
+	}
+	if (!writer) {
+		/* child - connect fd#1 and fd#2 to the pipe */
+		dup2(fd1[1], 1);
+		dup2(fd2[1], 2);
+		close(fd1[1]); close(fd2[1]);
+		close(fd1[0]); close(fd2[0]); /* we do not read from pipe */
+
+		exit(run_upload_archive(argc, argv, prefix));
+	}
+
+	/* parent - read from child, multiplex and send out to fd#1 */
+	close(fd1[1]); close(fd2[1]); /* we do not write to pipe */
 	packet_write(1, "ACK\n");
 	packet_flush(1);
 
-	return ar.write_archive(&ar.args);
-}
+	while (1) {
+		struct pollfd pfd[2];
+		char buf[16384];
+		ssize_t sz;
+		pid_t pid;
+		int status;
+
+		pfd[0].fd = fd1[0];
+		pfd[0].events = POLLIN;
+		pfd[1].fd = fd2[0];
+		pfd[1].events = POLLIN;
+		if (poll(pfd, 2, -1) < 0) {
+			if (errno != EINTR) {
+				error("poll failed resuming: %s",
+				      strerror(errno));
+				sleep(1);
+			}
+			continue;
+		}
+		if (pfd[0].revents & (POLLIN|POLLHUP)) {
+			/* Data stream ready */
+			sz = read(pfd[0].fd, buf, sizeof(buf));
+			send_sideband(1, 1, buf, sz, DEFAULT_PACKET_MAX);
+		}
+		if (pfd[1].revents & (POLLIN|POLLHUP)) {
+			/* Status stream ready */
+			sz = read(pfd[1].fd, buf, sizeof(buf));
+			send_sideband(1, 2, buf, sz, DEFAULT_PACKET_MAX);
+		}
 
+		if (((pfd[0].revents | pfd[1].revents) & POLLHUP) == 0)
+			continue;
+		/* did it die? */
+		pid = waitpid(writer, &status, WNOHANG);
+		if (!pid) {
+			fprintf(stderr, "Hmph, HUP?\n");
+			continue;
+		}
+		if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+			send_sideband(1, 3, deadchild, strlen(deadchild),
+				      DEFAULT_PACKET_MAX);
+		packet_flush(1);
+		break;
+	}
+	return 0;
+}
-- 
1.4.2.gc52f
