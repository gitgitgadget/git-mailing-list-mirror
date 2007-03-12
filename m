From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/7] Use run_command within receive-pack to invoke index-pack
Date: Mon, 12 Mar 2007 19:00:26 -0400
Message-ID: <20070312230026.GF16840@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQtVe-0006JJ-Ow
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbXCLXAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbXCLXAb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:00:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58244 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbXCLXAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:00:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQtV4-0004Qc-3u; Mon, 12 Mar 2007 19:00:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EEC2F20FBAE; Mon, 12 Mar 2007 19:00:26 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42090>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |   35 ++++++++++-------------------------
 1 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index 7cf5878..26aa26b 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -382,10 +382,10 @@ static const char *unpack(void)
 		}
 	} else {
 		const char *keeper[6];
-		int fd[2], s, len, status;
-		pid_t pid;
+		int s, len, status;
 		char keep_arg[256];
 		char packname[46];
+		struct child_process ip;
 
 		s = sprintf(keep_arg, "--keep=receive-pack %i on ", getpid());
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
@@ -397,20 +397,12 @@ static const char *unpack(void)
 		keeper[3] = hdr_arg;
 		keeper[4] = keep_arg;
 		keeper[5] = NULL;
-
-		if (pipe(fd) < 0)
-			return "index-pack pipe failed";
-		pid = fork();
-		if (pid < 0)
+		memset(&ip, 0, sizeof(ip));
+		ip.argv = keeper;
+		ip.out = -1;
+		ip.git_cmd = 1;
+		if (start_command(&ip))
 			return "index-pack fork failed";
-		if (!pid) {
-			dup2(fd[1], 1);
-			close(fd[1]);
-			close(fd[0]);
-			execv_git_cmd(keeper);
-			die("execv of index-pack failed");
-		}
-		close(fd[1]);
 
 		/*
 		 * The first thing we expects from index-pack's output
@@ -420,9 +412,8 @@ static const char *unpack(void)
 		 * later on.  If we don't get that then tough luck with it.
 		 */
 		for (len = 0;
-		     len < 46 && (s = xread(fd[0], packname+len, 46-len)) > 0;
+		     len < 46 && (s = xread(ip.out, packname+len, 46-len)) > 0;
 		     len += s);
-		close(fd[0]);
 		if (len == 46 && packname[45] == '\n' &&
 		    memcmp(packname, "keep\t", 5) == 0) {
 			char path[PATH_MAX];
@@ -432,14 +423,8 @@ static const char *unpack(void)
 			pack_lockfile = xstrdup(path);
 		}
 
-		/* Then wrap our index-pack process. */
-		while (waitpid(pid, &status, 0) < 0)
-			if (errno != EINTR)
-				return "waitpid failed";
-		if (WIFEXITED(status)) {
-			int code = WEXITSTATUS(status);
-			if (code)
-				return "index-pack exited with error code";
+		status = finish_command(&ip);
+		if (!status) {
 			reprepare_packed_git();
 			return NULL;
 		}
-- 
1.5.0.3.985.gcf0b4
