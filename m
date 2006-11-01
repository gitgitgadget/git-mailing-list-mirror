X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/6] improve fetch-pack's handling of kept packs
Date: Wed, 01 Nov 2006 17:06:23 -0500
Message-ID: <1162418786390-git-send-email-nico@cam.org>
References: <11624187853116-git-send-email-nico@cam.org>
 <11624187853865-git-send-email-nico@cam.org>
 <1162418786895-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 1 Nov 2006 22:07:11 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <1162418786895-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.4.3.3.g87b2-dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30667>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOER-0005ag-LC for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752513AbWKAWGc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbWKAWGb
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:06:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63137 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752513AbWKAWG2
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:06:28 -0500
Received: from localhost.localdomain ([74.56.106.175]) by
 VL-MH-MR002.ip.videotron.ca (Sun Java System Messaging Server 6.2-2.05 (built
 Apr 28 2005)) with ESMTP id <0J8200BN9O2PMF20@VL-MH-MR002.ip.videotron.ca>
 for git@vger.kernel.org; Wed, 01 Nov 2006 17:06:27 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Since functions in fetch-clone.c were only used from fetch-pack.c,
its content has been merged with fetch-pack.c.  This allows for better
coupling of features with much simpler implementations.

One new thing is that the (abscence of) --thin also enforce it on
index-pack now, such that index-pack will abort if a thin pack was
_not_ asked for.

The -k or --keep, when provided twice, now causes the fetched pack
to be left as a kept pack just like receive-pack currently does.
Eventually this will be used to close a race against concurrent
repacking.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/git-fetch-pack.txt |    3 +-
 Makefile                         |    2 +-
 cache.h                          |    4 --
 fetch-clone.c                    |   87 ------------------------------
 fetch-pack.c                     |  110 +++++++++++++++++++++++++++++++++++---
 5 files changed, 106 insertions(+), 100 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index bff9aa6..3e6cd88 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -32,7 +32,8 @@ OPTIONS
 -k::
 	Do not invoke 'git-unpack-objects' on received data, but
 	create a single packfile out of it instead, and store it
-	in the object database.
+	in the object database. If provided twice then the pack is
+	locked against repacking.
 
 --exec=<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
diff --git a/Makefile b/Makefile
index 28a5d91..80d4a4e 100644
--- a/Makefile
+++ b/Makefile
@@ -260,7 +260,7 @@ LIB_OBJS = \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
-	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
+	revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o
diff --git a/cache.h b/cache.h
index 6cb7e1d..f2ec5c8 100644
--- a/cache.h
+++ b/cache.h
@@ -416,10 +416,6 @@ extern int copy_fd(int ifd, int ofd);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 
-/* Finish off pack transfer receiving end */
-extern int receive_unpack_pack(int fd[2], const char *me, int quiet, int);
-extern int receive_keep_pack(int fd[2], const char *me, int quiet, int);
-
 /* pager.c */
 extern void setup_pager(void);
 extern int pager_in_use;
diff --git a/fetch-clone.c b/fetch-clone.c
deleted file mode 100644
index f629d8d..0000000
--- a/fetch-clone.c
+++ /dev/null
@@ -1,87 +0,0 @@
-#include "cache.h"
-#include "exec_cmd.h"
-#include "pkt-line.h"
-#include "sideband.h"
-#include <sys/wait.h>
-
-static pid_t setup_sideband(int sideband, const char *me, int fd[2], int xd[2])
-{
-	pid_t side_pid;
-
-	if (!sideband) {
-		fd[0] = xd[0];
-		fd[1] = xd[1];
-		return 0;
-	}
-	/* xd[] is talking with upload-pack; subprocess reads from
-	 * xd[0], spits out band#2 to stderr, and feeds us band#1
-	 * through our fd[0].
-	 */
-	if (pipe(fd) < 0)
-		die("%s: unable to set up pipe", me);
-	side_pid = fork();
-	if (side_pid < 0)
-		die("%s: unable to fork off sideband demultiplexer", me);
-	if (!side_pid) {
-		/* subprocess */
-		close(fd[0]);
-		if (xd[0] != xd[1])
-			close(xd[1]);
-		if (recv_sideband(me, xd[0], fd[1], 2))
-			exit(1);
-		exit(0);
-	}
-	close(xd[0]);
-	close(fd[1]);
-	fd[1] = xd[1];
-	return side_pid;
-}
-
-static int get_pack(int xd[2], const char *me, int sideband, const char **argv)
-{
-	int status;
-	pid_t pid, side_pid;
-	int fd[2];
-
-	side_pid = setup_sideband(sideband, me, fd, xd);
-	pid = fork();
-	if (pid < 0)
-		die("%s: unable to fork off %s", me, argv[0]);
-	if (!pid) {
-		dup2(fd[0], 0);
-		close(fd[0]);
-		close(fd[1]);
-		execv_git_cmd(argv);
-		die("%s exec failed", argv[0]);
-	}
-	close(fd[0]);
-	close(fd[1]);
-	while (waitpid(pid, &status, 0) < 0) {
-		if (errno != EINTR)
-			die("waiting for %s: %s", argv[0], strerror(errno));
-	}
-	if (WIFEXITED(status)) {
-		int code = WEXITSTATUS(status);
-		if (code)
-			die("%s died with error code %d", argv[0], code);
-		return 0;
-	}
-	if (WIFSIGNALED(status)) {
-		int sig = WTERMSIG(status);
-		die("%s died of signal %d", argv[0], sig);
-	}
-	die("%s died of unnatural causes %d", argv[0], status);
-}
-
-int receive_unpack_pack(int xd[2], const char *me, int quiet, int sideband)
-{
-	const char *argv[3] = { "unpack-objects", quiet ? "-q" : NULL, NULL };
-	return get_pack(xd, me, sideband, argv);
-}
-
-int receive_keep_pack(int xd[2], const char *me, int quiet, int sideband)
-{
-	const char *argv[5] = { "index-pack", "--stdin", "--fix-thin",
-				quiet ? NULL : "-v", NULL };
-	return get_pack(xd, me, sideband, argv);
-}
diff --git a/fetch-pack.c b/fetch-pack.c
index 36ea092..0a169dc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -3,6 +3,9 @@
 #include "pkt-line.h"
 #include "commit.h"
 #include "tag.h"
+#include "exec_cmd.h"
+#include "sideband.h"
+#include <sys/wait.h>
 
 static int keep_pack;
 static int quiet;
@@ -416,6 +419,103 @@ static int everything_local(struct ref *
 	return retval;
 }
 
+static pid_t setup_sideband(int fd[2], int xd[2])
+{
+	pid_t side_pid;
+
+	if (!use_sideband) {
+		fd[0] = xd[0];
+		fd[1] = xd[1];
+		return 0;
+	}
+	/* xd[] is talking with upload-pack; subprocess reads from
+	 * xd[0], spits out band#2 to stderr, and feeds us band#1
+	 * through our fd[0].
+	 */
+	if (pipe(fd) < 0)
+		die("fetch-pack: unable to set up pipe");
+	side_pid = fork();
+	if (side_pid < 0)
+		die("fetch-pack: unable to fork off sideband demultiplexer");
+	if (!side_pid) {
+		/* subprocess */
+		close(fd[0]);
+		if (xd[0] != xd[1])
+			close(xd[1]);
+		if (recv_sideband("fetch-pack", xd[0], fd[1], 2))
+			exit(1);
+		exit(0);
+	}
+	close(xd[0]);
+	close(fd[1]);
+	fd[1] = xd[1];
+	return side_pid;
+}
+
+static int get_pack(int xd[2], const char **argv)
+{
+	int status;
+	pid_t pid, side_pid;
+	int fd[2];
+
+	side_pid = setup_sideband(fd, xd);
+	pid = fork();
+	if (pid < 0)
+		die("fetch-pack: unable to fork off %s", argv[0]);
+	if (!pid) {
+		dup2(fd[0], 0);
+		close(fd[0]);
+		close(fd[1]);
+		execv_git_cmd(argv);
+		die("%s exec failed", argv[0]);
+	}
+	close(fd[0]);
+	close(fd[1]);
+	while (waitpid(pid, &status, 0) < 0) {
+		if (errno != EINTR)
+			die("waiting for %s: %s", argv[0], strerror(errno));
+	}
+	if (WIFEXITED(status)) {
+		int code = WEXITSTATUS(status);
+		if (code)
+			die("%s died with error code %d", argv[0], code);
+		return 0;
+	}
+	if (WIFSIGNALED(status)) {
+		int sig = WTERMSIG(status);
+		die("%s died of signal %d", argv[0], sig);
+	}
+	die("%s died of unnatural causes %d", argv[0], status);
+}
+
+static int explode_rx_pack(int xd[2])
+{
+	const char *argv[3] = { "unpack-objects", quiet ? "-q" : NULL, NULL };
+	return get_pack(xd, argv);
+}
+
+static int keep_rx_pack(int xd[2])
+{
+	const char *argv[6];
+	char keep_arg[256];
+	int n = 0;
+
+	argv[n++] = "index-pack";
+	argv[n++] = "--stdin";
+	if (!quiet)
+		argv[n++] = "-v";
+	if (use_thin_pack)
+		argv[n++] = "--fix-thin";
+	if (keep_pack > 1) {
+		int s = sprintf(keep_arg, "--keep=fetch-pack %i on ", getpid());
+		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
+			strcpy(keep_arg + s, "localhost");
+		argv[n++] = keep_arg;
+	}
+	argv[n] = NULL;
+	return get_pack(xd, argv);
+}
+
 static int fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
@@ -447,17 +547,13 @@ static int fetch_pack(int fd[2], int nr_
 		goto all_done;
 	}
 	if (find_common(fd, sha1, ref) < 0)
-		if (!keep_pack)
+		if (keep_pack != 1)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
 			 */
 			fprintf(stderr, "warning: no common commits\n");
 
-	if (keep_pack)
-		status = receive_keep_pack(fd, "git-fetch-pack", quiet, use_sideband);
-	else
-		status = receive_unpack_pack(fd, "git-fetch-pack", quiet, use_sideband);
-
+	status = (keep_pack) ? keep_rx_pack(fd) : explode_rx_pack(fd);
 	if (status)
 		die("git-fetch-pack: fetch failed.");
 
@@ -494,7 +590,7 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
-				keep_pack = 1;
+				keep_pack++;
 				continue;
 			}
 			if (!strcmp("--thin", arg)) {
-- 
1.4.3.3.g87b2-dirty
