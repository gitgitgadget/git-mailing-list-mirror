From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] upload-pack: prepare for sideband message support.
Date: Wed, 21 Jun 2006 01:12:47 -0700
Message-ID: <7vlkrr3p1c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 21 10:13:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsxpU-0003y8-Fm
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 10:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWFUIMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 04:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWFUIMt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 04:12:49 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35992 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751146AbWFUIMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 04:12:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621081247.ZZKV27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 04:12:47 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22239>

This does not implement sideband for propagating the status to
the downloader yet, but add code to capture the standard error
output from the pack-objects process in preparation for sending
it off to the client when the protocol extension allows us to do
so.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 pack-objects.c |    4 ++++
 upload-pack.c  |   46 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/pack-objects.c b/pack-objects.c
index 179560f..7a8c16c 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1221,6 +1221,10 @@ int main(int argc, char **argv)
 				local = 1;
 				continue;
 			}
+			if (!strcmp("--progress", arg)) {
+				progress = 1;
+				continue;
+			}
 			if (!strcmp("--incremental", arg)) {
 				incremental = 1;
 				continue;
diff --git a/upload-pack.c b/upload-pack.c
index a9a8f2e..13eaa22 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -36,11 +36,13 @@ static int strip(char *line, int len)
 
 static void create_pack_file(void)
 {
-	/* Pipes between rev-list to pack-objects and pack-objects to us. */
-	int lp_pipe[2], pu_pipe[2];
+	/* Pipes between rev-list to pack-objects, pack-objects to us
+	 * and pack-objects error stream for progress bar.
+	 */
+	int lp_pipe[2], pu_pipe[2], pe_pipe[2];
 	pid_t pid_rev_list, pid_pack_objects;
 	int create_full_pack = (nr_our_refs == nr_needs && !nr_has);
-	char data[8193];
+	char data[8193], progress[128];
 	int buffered = -1;
 
 	if (pipe(lp_pipe) < 0)
@@ -95,6 +97,8 @@ static void create_pack_file(void)
 
 	if (pipe(pu_pipe) < 0)
 		die("git-upload-pack: unable to create pipe");
+	if (pipe(pe_pipe) < 0)
+		die("git-upload-pack: unable to create pipe");
 	pid_pack_objects = fork();
 	if (pid_pack_objects < 0) {
 		/* daemon sets things up to ignore TERM */
@@ -104,12 +108,15 @@ static void create_pack_file(void)
 	if (!pid_pack_objects) {
 		dup2(lp_pipe[0], 0);
 		dup2(pu_pipe[1], 1);
+		dup2(pe_pipe[1], 2);
 
 		close(lp_pipe[0]);
 		close(lp_pipe[1]);
 		close(pu_pipe[0]);
 		close(pu_pipe[1]);
-		execl_git_cmd("pack-objects", "--stdout", NULL);
+		close(pe_pipe[0]);
+		close(pe_pipe[1]);
+		execl_git_cmd("pack-objects", "--stdout", "--progress", NULL);
 		kill(pid_rev_list, SIGKILL);
 		die("git-upload-pack: unable to exec git-pack-objects");
 	}
@@ -117,20 +124,23 @@ static void create_pack_file(void)
 	close(lp_pipe[0]);
 	close(lp_pipe[1]);
 
-	/* We read from pu_pipe[0] to capture the pack data.
+	/* We read from pe_pipe[0] to capture stderr output for
+	 * progress bar, and pu_pipe[0] to capture the pack data.
 	 */
+	close(pe_pipe[1]);
 	close(pu_pipe[1]);
 
 	while (1) {
 		const char *who;
+		char *cp;
 		struct pollfd pfd[2];
 		pid_t pid;
 		int status;
 		ssize_t sz;
-		int pu, pollsize;
+		int pe, pu, pollsize;
 
 		pollsize = 0;
-		pu = -1;
+		pe = pu = -1;
 
 		if (0 <= pu_pipe[0]) {
 			pfd[pollsize].fd = pu_pipe[0];
@@ -138,6 +148,12 @@ static void create_pack_file(void)
 			pu = pollsize;
 			pollsize++;
 		}
+		if (0 <= pe_pipe[0]) {
+			pfd[pollsize].fd = pe_pipe[0];
+			pfd[pollsize].events = POLLIN;
+			pe = pollsize;
+			pollsize++;
+		}
 
 		if (pollsize) {
 			if (poll(pfd, pollsize, -1) < 0) {
@@ -187,6 +203,22 @@ static void create_pack_file(void)
 				if (sz < 0)
 					goto fail;
 			}
+			if (0 <= pe && (pfd[pe].revents & (POLLIN|POLLHUP))) {
+				/* Status ready; we do not use it for now,
+				 * but later we will add side-band to send it
+				 * to the other side.
+				 */
+				sz = read(pe_pipe[0], progress,
+					  sizeof(progress));
+				if (0 < sz)
+					write(2, progress, sz);
+				else if (sz == 0) {
+					close(pe_pipe[0]);
+					pe_pipe[0] = -1;
+				}
+				else
+					goto fail;
+			}
 		}
 
 		/* See if the children are still there */
-- 
1.4.0.gbb3f
