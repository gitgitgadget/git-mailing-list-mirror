From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/7] Use run_command within send-pack
Date: Mon, 12 Mar 2007 19:00:29 -0400
Message-ID: <20070312230029.GG16840@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQtVf-0006JJ-AC
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXCLXAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbXCLXAe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:00:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58246 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXCLXAc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:00:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQtV6-0004Qe-9T; Mon, 12 Mar 2007 19:00:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 213FA20FB65; Mon, 12 Mar 2007 19:00:29 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42092>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 send-pack.c |   86 ++++++++++++++++++++--------------------------------------
 1 files changed, 30 insertions(+), 56 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 512b660..d5b5162 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -3,7 +3,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "pkt-line.h"
-#include "exec_cmd.h"
+#include "run-command.h"
 
 static const char send_pack_usage[] =
 "git-send-pack [--all] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -19,46 +19,35 @@ static int use_thin_pack;
  */
 static int pack_objects(int fd, struct ref *refs)
 {
-	int pipe_fd[2];
-	pid_t pid;
-
-	if (pipe(pipe_fd) < 0)
-		return error("send-pack: pipe failed");
-	pid = fork();
-	if (pid < 0)
-		return error("send-pack: unable to fork git-pack-objects");
-	if (!pid) {
-		/*
-		 * The child becomes pack-objects --revs; we feed
-		 * the revision parameters to it via its stdin and
-		 * let its stdout go back to the other end.
-		 */
-		static const char *args[] = {
-			"pack-objects",
-			"--all-progress",
-			"--revs",
-			"--stdout",
-			NULL,
-			NULL,
-		};
-		if (use_thin_pack)
-			args[4] = "--thin";
-		dup2(pipe_fd[0], 0);
-		dup2(fd, 1);
-		close(pipe_fd[0]);
-		close(pipe_fd[1]);
-		close(fd);
-		execv_git_cmd(args);
-		die("git-pack-objects exec failed (%s)", strerror(errno));
-	}
+	/*
+	 * The child becomes pack-objects --revs; we feed
+	 * the revision parameters to it via its stdin and
+	 * let its stdout go back to the other end.
+	 */
+	const char *args[] = {
+		"pack-objects",
+		"--all-progress",
+		"--revs",
+		"--stdout",
+		NULL,
+		NULL,
+	};
+	struct child_process po;
+
+	if (use_thin_pack)
+		args[4] = "--thin";
+	memset(&po, 0, sizeof(po));
+	po.argv = args;
+	po.in = -1;
+	po.out = fd;
+	po.git_cmd = 1;
+	if (start_command(&po))
+		die("git-pack-objects failed (%s)", strerror(errno));
 
 	/*
 	 * We feed the pack-objects we just spawned with revision
 	 * parameters by writing to the pipe.
 	 */
-	close(pipe_fd[0]);
-	close(fd);
-
 	while (refs) {
 		char buf[42];
 
@@ -67,38 +56,23 @@ static int pack_objects(int fd, struct ref *refs)
 			memcpy(buf + 1, sha1_to_hex(refs->old_sha1), 40);
 			buf[0] = '^';
 			buf[41] = '\n';
-			if (!write_or_whine(pipe_fd[1], buf, 42,
+			if (!write_or_whine(po.in, buf, 42,
 						"send-pack: send refs"))
 				break;
 		}
 		if (!is_null_sha1(refs->new_sha1)) {
 			memcpy(buf, sha1_to_hex(refs->new_sha1), 40);
 			buf[40] = '\n';
-			if (!write_or_whine(pipe_fd[1], buf, 41,
+			if (!write_or_whine(po.in, buf, 41,
 						"send-pack: send refs"))
 				break;
 		}
 		refs = refs->next;
 	}
-	close(pipe_fd[1]);
-
-	for (;;) {
-		int status, code;
-		pid_t waiting = waitpid(pid, &status, 0);
 
-		if (waiting < 0) {
-			if (errno == EINTR)
-				continue;
-			return error("waitpid failed (%s)", strerror(errno));
-		}
-		if ((waiting != pid) || WIFSIGNALED(status) ||
-		    !WIFEXITED(status))
-			return error("pack-objects died with strange error");
-		code = WEXITSTATUS(status);
-		if (code)
-			return -code;
-		return 0;
-	}
+	if (finish_command(&po))
+		return error("pack-objects died with strange error");
+	return 0;
 }
 
 static void unmark_and_free(struct commit_list *list, unsigned int mark)
-- 
1.5.0.3.985.gcf0b4
