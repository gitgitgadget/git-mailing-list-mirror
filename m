From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 07/14] upload-pack: Use start_command() to run pack-objects in create_pack_file().
Date: Fri, 19 Oct 2007 21:47:59 +0200
Message-ID: <1192823286-9654-8-git-send-email-johannes.sixt@telecom.at>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-2-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-3-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-4-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-5-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-6-git-send-email-johannes.sixt@telecom.at>
 <1192823286-9654-7-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:49:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iixqg-0002t3-Nu
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbXJSTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933149AbXJSTs1
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:27 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44510 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765900AbXJSTsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:10 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 9F05B97D5D;
	Fri, 19 Oct 2007 21:48:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-7-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61748>

This gets rid of an explicit fork/exec.

Since upload-pack has to coordinate two processes (rev-list and
pack-objects), we cannot use the normal finish_command(), but have to
monitor the processes explicitly. Hence, the waitpid() call remains.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 upload-pack.c |  105 ++++++++++++++++++++++++---------------------------------
 1 files changed, 44 insertions(+), 61 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index fe96ef1..5c0c0cc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -9,6 +9,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "run-command.h"
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
@@ -98,16 +99,18 @@ static void show_edge(struct commit *commit)
 
 static void create_pack_file(void)
 {
-	/* Pipes between rev-list to pack-objects, pack-objects to us
-	 * and pack-objects error stream for progress bar.
+	/* Pipe from rev-list to pack-objects
 	 */
-	int lp_pipe[2], pu_pipe[2], pe_pipe[2];
-	pid_t pid_rev_list, pid_pack_objects;
+	int lp_pipe[2];
+	pid_t pid_rev_list;
+	struct child_process pack_objects;
 	int create_full_pack = (nr_our_refs == want_obj.nr && !have_obj.nr);
 	char data[8193], progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
 	int buffered = -1;
+	const char *argv[10];
+	int arg = 0;
 
 	if (pipe(lp_pipe) < 0)
 		die("git-upload-pack: unable to create pipe");
@@ -154,52 +157,32 @@ static void create_pack_file(void)
 		exit(0);
 	}
 
-	if (pipe(pu_pipe) < 0)
-		die("git-upload-pack: unable to create pipe");
-	if (pipe(pe_pipe) < 0)
-		die("git-upload-pack: unable to create pipe");
-	pid_pack_objects = fork();
-	if (pid_pack_objects < 0) {
+	/* writable pipe end must not be inherited by pack_objects */
+	close(lp_pipe[1]);
+
+	argv[arg++] = "pack-objects";
+	argv[arg++] = "--stdout";
+	if (!no_progress)
+		argv[arg++] = "--progress";
+	if (use_ofs_delta)
+		argv[arg++] = "--delta-base-offset";
+	argv[arg++] = NULL;
+
+	memset(&pack_objects, 0, sizeof(pack_objects));
+	pack_objects.in = lp_pipe[0];	/* start_command closes it */
+	pack_objects.out = -1;
+	pack_objects.err = -1;
+	pack_objects.git_cmd = 1;
+	pack_objects.argv = argv;
+	if (start_command(&pack_objects)) {
 		/* daemon sets things up to ignore TERM */
 		kill(pid_rev_list, SIGKILL);
 		die("git-upload-pack: unable to fork git-pack-objects");
 	}
-	if (!pid_pack_objects) {
-		const char *argv[10];
-		int i = 0;
-
-		dup2(lp_pipe[0], 0);
-		dup2(pu_pipe[1], 1);
-		dup2(pe_pipe[1], 2);
-
-		close(lp_pipe[0]);
-		close(lp_pipe[1]);
-		close(pu_pipe[0]);
-		close(pu_pipe[1]);
-		close(pe_pipe[0]);
-		close(pe_pipe[1]);
-
-		argv[i++] = "pack-objects";
-		argv[i++] = "--stdout";
-		if (!no_progress)
-			argv[i++] = "--progress";
-		if (use_ofs_delta)
-			argv[i++] = "--delta-base-offset";
-		argv[i++] = NULL;
-
-		execv_git_cmd(argv);
-		kill(pid_rev_list, SIGKILL);
-		die("git-upload-pack: unable to exec git-pack-objects");
-	}
-
-	close(lp_pipe[0]);
-	close(lp_pipe[1]);
 
-	/* We read from pe_pipe[0] to capture stderr output for
-	 * progress bar, and pu_pipe[0] to capture the pack data.
+	/* We read from pack_objects.err to capture stderr output for
+	 * progress bar, and pack_objects.out to capture the pack data.
 	 */
-	close(pe_pipe[1]);
-	close(pu_pipe[1]);
 
 	while (1) {
 		const char *who;
@@ -214,14 +197,14 @@ static void create_pack_file(void)
 		pollsize = 0;
 		pe = pu = -1;
 
-		if (0 <= pu_pipe[0]) {
-			pfd[pollsize].fd = pu_pipe[0];
+		if (0 <= pack_objects.out) {
+			pfd[pollsize].fd = pack_objects.out;
 			pfd[pollsize].events = POLLIN;
 			pu = pollsize;
 			pollsize++;
 		}
-		if (0 <= pe_pipe[0]) {
-			pfd[pollsize].fd = pe_pipe[0];
+		if (0 <= pack_objects.err) {
+			pfd[pollsize].fd = pack_objects.err;
 			pfd[pollsize].events = POLLIN;
 			pe = pollsize;
 			pollsize++;
@@ -254,13 +237,13 @@ static void create_pack_file(void)
 					*cp++ = buffered;
 					outsz++;
 				}
-				sz = xread(pu_pipe[0], cp,
+				sz = xread(pack_objects.out, cp,
 					  sizeof(data) - outsz);
 				if (0 < sz)
 						;
 				else if (sz == 0) {
-					close(pu_pipe[0]);
-					pu_pipe[0] = -1;
+					close(pack_objects.out);
+					pack_objects.out = -1;
 				}
 				else
 					goto fail;
@@ -279,13 +262,13 @@ static void create_pack_file(void)
 				/* Status ready; we ship that in the side-band
 				 * or dump to the standard error.
 				 */
-				sz = xread(pe_pipe[0], progress,
+				sz = xread(pack_objects.err, progress,
 					  sizeof(progress));
 				if (0 < sz)
 					send_client_data(2, progress, sz);
 				else if (sz == 0) {
-					close(pe_pipe[0]);
-					pe_pipe[0] = -1;
+					close(pack_objects.err);
+					pack_objects.err = -1;
 				}
 				else
 					goto fail;
@@ -293,12 +276,12 @@ static void create_pack_file(void)
 		}
 
 		/* See if the children are still there */
-		if (pid_rev_list || pid_pack_objects) {
+		if (pid_rev_list || pack_objects.pid) {
 			pid = waitpid(-1, &status, WNOHANG);
 			if (!pid)
 				continue;
 			who = ((pid == pid_rev_list) ? "git-rev-list" :
-			       (pid == pid_pack_objects) ? "git-pack-objects" :
+			       (pid == pack_objects.pid) ? "git-pack-objects" :
 			       NULL);
 			if (!who) {
 				if (pid < 0) {
@@ -317,9 +300,9 @@ static void create_pack_file(void)
 			}
 			if (pid == pid_rev_list)
 				pid_rev_list = 0;
-			if (pid == pid_pack_objects)
-				pid_pack_objects = 0;
-			if (pid_rev_list || pid_pack_objects)
+			if (pid == pack_objects.pid)
+				pack_objects.pid = 0;
+			if (pid_rev_list || pack_objects.pid)
 				continue;
 		}
 
@@ -340,8 +323,8 @@ static void create_pack_file(void)
 		return;
 	}
  fail:
-	if (pid_pack_objects)
-		kill(pid_pack_objects, SIGKILL);
+	if (pack_objects.pid)
+		kill(pack_objects.pid, SIGKILL);
 	if (pid_rev_list)
 		kill(pid_rev_list, SIGKILL);
 	send_client_data(3, abort_msg, sizeof(abort_msg));
-- 
1.5.3.4.315.g2ce38
