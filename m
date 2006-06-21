From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] upload-pack: avoid sending an incomplete pack upon failure
Date: Wed, 21 Jun 2006 01:12:00 -0700
Message-ID: <7vmzc73p2n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 21 10:12:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsxoo-0003sX-HU
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 10:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWFUIME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 04:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWFUIME
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 04:12:04 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64684 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751289AbWFUIMC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 04:12:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621081201.WUNH19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 04:12:01 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22238>

When the repository on the remote side is corrupted, rev-list
spawned from upload-pack would die with error, but pack-objects
that reads from the rev-list happily created a packfile that can
be unpacked by the downloader.  When this happens, the resulting
packfile is not corrupted and unpacks cleanly, but the list of
the objects contained in it is not what the protocol exchange
computed.

This update makes upload-pack to monitor its subprocesses, and
when either of them dies with error, sends an incomplete pack
data to the downloader to cause it to fail.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is about "upload-pack is unsafe in corrupt repository"
   message I sent about 20 hours ago.

 upload-pack.c |  177 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 163 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 979e583..a9a8f2e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -5,6 +5,9 @@ #include "tag.h"
 #include "object.h"
 #include "commit.h"
 #include "exec_cmd.h"
+#include <signal.h>
+#include <sys/poll.h>
+#include <sys/wait.h>
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
@@ -33,17 +36,20 @@ static int strip(char *line, int len)
 
 static void create_pack_file(void)
 {
-	int fd[2];
-	pid_t pid;
+	/* Pipes between rev-list to pack-objects and pack-objects to us. */
+	int lp_pipe[2], pu_pipe[2];
+	pid_t pid_rev_list, pid_pack_objects;
 	int create_full_pack = (nr_our_refs == nr_needs && !nr_has);
+	char data[8193];
+	int buffered = -1;
 
-	if (pipe(fd) < 0)
+	if (pipe(lp_pipe) < 0)
 		die("git-upload-pack: unable to create pipe");
-	pid = fork();
-	if (pid < 0)
+	pid_rev_list = fork();
+	if (pid_rev_list < 0)
 		die("git-upload-pack: unable to fork git-rev-list");
 
-	if (!pid) {
+	if (!pid_rev_list) {
 		int i;
 		int args;
 		const char **argv;
@@ -60,10 +66,10 @@ static void create_pack_file(void)
 		argv = (const char **) p;
 		buf = xmalloc(args * 45);
 
-		dup2(fd[1], 1);
+		dup2(lp_pipe[1], 1);
 		close(0);
-		close(fd[0]);
-		close(fd[1]);
+		close(lp_pipe[0]);
+		close(lp_pipe[1]);
 		*p++ = "rev-list";
 		*p++ = use_thin_pack ? "--objects-edge" : "--objects";
 		if (create_full_pack || MAX_NEEDS <= nr_needs)
@@ -86,11 +92,154 @@ static void create_pack_file(void)
 		execv_git_cmd(argv);
 		die("git-upload-pack: unable to exec git-rev-list");
 	}
-	dup2(fd[0], 0);
-	close(fd[0]);
-	close(fd[1]);
-	execl_git_cmd("pack-objects", "--stdout", NULL);
-	die("git-upload-pack: unable to exec git-pack-objects");
+
+	if (pipe(pu_pipe) < 0)
+		die("git-upload-pack: unable to create pipe");
+	pid_pack_objects = fork();
+	if (pid_pack_objects < 0) {
+		/* daemon sets things up to ignore TERM */
+		kill(pid_rev_list, SIGKILL);
+		die("git-upload-pack: unable to fork git-pack-objects");
+	}
+	if (!pid_pack_objects) {
+		dup2(lp_pipe[0], 0);
+		dup2(pu_pipe[1], 1);
+
+		close(lp_pipe[0]);
+		close(lp_pipe[1]);
+		close(pu_pipe[0]);
+		close(pu_pipe[1]);
+		execl_git_cmd("pack-objects", "--stdout", NULL);
+		kill(pid_rev_list, SIGKILL);
+		die("git-upload-pack: unable to exec git-pack-objects");
+	}
+
+	close(lp_pipe[0]);
+	close(lp_pipe[1]);
+
+	/* We read from pu_pipe[0] to capture the pack data.
+	 */
+	close(pu_pipe[1]);
+
+	while (1) {
+		const char *who;
+		struct pollfd pfd[2];
+		pid_t pid;
+		int status;
+		ssize_t sz;
+		int pu, pollsize;
+
+		pollsize = 0;
+		pu = -1;
+
+		if (0 <= pu_pipe[0]) {
+			pfd[pollsize].fd = pu_pipe[0];
+			pfd[pollsize].events = POLLIN;
+			pu = pollsize;
+			pollsize++;
+		}
+
+		if (pollsize) {
+			if (poll(pfd, pollsize, -1) < 0) {
+				if (errno != EINTR) {
+					error("poll failed, resuming: %s",
+					      strerror(errno));
+					sleep(1);
+				}
+				continue;
+			}
+			if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
+				/* Data ready; we keep the last byte
+				 * to ourselves in case we detect
+				 * broken rev-list, so that we can
+				 * leave the stream corrupted.  This
+				 * is unfortunate -- unpack-objects
+				 * would happily accept a valid pack
+				 * data with trailing garbage, so
+				 * appending garbage after we pass all
+				 * the pack data is not good enough to
+				 * signal breakage to downstream.
+				 */
+				char *cp = data;
+				ssize_t outsz = 0;
+				if (0 <= buffered) {
+					*cp++ = buffered;
+					outsz++;
+				}
+				sz = read(pu_pipe[0], cp,
+					  sizeof(data) - outsz);
+				if (0 < sz)
+						;
+				else if (sz == 0) {
+					close(pu_pipe[0]);
+					pu_pipe[0] = -1;
+				}
+				else
+					goto fail;
+				sz += outsz;
+				if (1 < sz) {
+					buffered = data[sz-1] & 0xFF;
+					sz--;
+				}
+				else
+					buffered = -1;
+				sz = xwrite(1, data, sz);
+				if (sz < 0)
+					goto fail;
+			}
+		}
+
+		/* See if the children are still there */
+		if (pid_rev_list || pid_pack_objects) {
+			pid = waitpid(-1, &status, WNOHANG);
+			if (!pid)
+				continue;
+			who = ((pid == pid_rev_list) ? "git-rev-list" :
+			       (pid == pid_pack_objects) ? "git-pack-objects" :
+			       NULL);
+			if (!who) {
+				if (pid < 0) {
+					error("git-upload-pack: %s",
+					      strerror(errno));
+					goto fail;
+				}
+				error("git-upload-pack: we weren't "
+				      "waiting for %d", pid);
+				continue;
+			}
+			if (!WIFEXITED(status) || WEXITSTATUS(status) > 0) {
+				error("git-upload-pack: %s died with error.",
+				      who);
+				goto fail;
+			}
+			if (pid == pid_rev_list)
+				pid_rev_list = 0;
+			if (pid == pid_pack_objects)
+				pid_pack_objects = 0;
+			if (pid_rev_list || pid_pack_objects)
+				continue;
+		}
+
+		/* both died happily */
+		if (pollsize)
+			continue;
+
+		/* flush the data */
+		if (0 <= buffered) {
+			data[0] = buffered;
+			sz = xwrite(1, data, 1);
+			if (sz < 0)
+				goto fail;
+			fprintf(stderr, "flushed.\n");
+		}
+		return;
+	}
+ fail:
+	if (pid_pack_objects)
+		kill(pid_pack_objects, SIGKILL);
+	if (pid_rev_list)
+		kill(pid_rev_list, SIGKILL);
+	die("git-upload-pack: aborting due to possible repository corruption on the remote side.");
 }
 
 static int got_sha1(char *hex, unsigned char *sha1)
-- 
1.4.0.gbb3f
