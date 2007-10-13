From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 09/14] Use the asyncronous function infrastructure in builtin-fetch-pack.c.
Date: Sat, 13 Oct 2007 22:06:19 +0200
Message-ID: <1192305984-22594-10-git-send-email-johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-5-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-6-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-7-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-8-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-9-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:08:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnH1-0008Ve-TT
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758256AbXJMUGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758198AbXJMUGs
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:48 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52590 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757413AbXJMUG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:29 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id E339613A77A;
	Sat, 13 Oct 2007 22:06:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-9-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60768>

We run the sideband demultiplexer in an asynchronous function.

Note that earlier there was a check in the child process that closed
xd[1] only if it was different from xd[0]; this test is no longer needed
because git_connect() always returns two different file descriptors
(see ec587fde0a76780931c7ac32474c8c000aa45134).

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-fetch-pack.c |   39 ++++++++++++++++++---------------------
 1 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 871b704..51d8a32 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -457,42 +457,37 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 	return retval;
 }
 
-static pid_t setup_sideband(int fd[2], int xd[2])
+static int sideband_demux(int fd, void *data)
 {
-	pid_t side_pid;
+	int *xd = data;
 
+	close(xd[1]);
+	return recv_sideband("fetch-pack", xd[0], fd, 2);
+}
+
+static void setup_sideband(int fd[2], int xd[2], struct async *demux)
+{
 	if (!use_sideband) {
 		fd[0] = xd[0];
 		fd[1] = xd[1];
-		return 0;
+		return;
 	}
 	/* xd[] is talking with upload-pack; subprocess reads from
 	 * xd[0], spits out band#2 to stderr, and feeds us band#1
-	 * through our fd[0].
+	 * through demux->out.
 	 */
-	if (pipe(fd) < 0)
-		die("fetch-pack: unable to set up pipe");
-	side_pid = fork();
-	if (side_pid < 0)
+	demux->proc = sideband_demux;
+	demux->data = xd;
+	if (start_async(demux))
 		die("fetch-pack: unable to fork off sideband demultiplexer");
-	if (!side_pid) {
-		/* subprocess */
-		close(fd[0]);
-		if (xd[0] != xd[1])
-			close(xd[1]);
-		if (recv_sideband("fetch-pack", xd[0], fd[1], 2))
-			exit(1);
-		exit(0);
-	}
 	close(xd[0]);
-	close(fd[1]);
+	fd[0] = demux->out;
 	fd[1] = xd[1];
-	return side_pid;
 }
 
 static int get_pack(int xd[2], char **pack_lockfile)
 {
-	pid_t side_pid;
+	struct async demux;
 	int fd[2];
 	const char *argv[20];
 	char keep_arg[256];
@@ -501,7 +496,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	int do_keep = args.keep_pack;
 	struct child_process cmd;
 
-	side_pid = setup_sideband(fd, xd);
+	setup_sideband(fd, xd, &demux);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.argv = argv;
@@ -556,6 +551,8 @@ static int get_pack(int xd[2], char **pack_lockfile)
 
 	if (finish_command(&cmd))
 		die("%s failed", argv[0]);
+	if (use_sideband && finish_async(&demux))
+		die("error in sideband demultiplexer");
 	return 0;
 }
 
-- 
1.5.3.3.1134.gee562
