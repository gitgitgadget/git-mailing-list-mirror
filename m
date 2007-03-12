From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/7] Use run_command for proxy connections
Date: Mon, 12 Mar 2007 19:00:19 -0400
Message-ID: <20070312230019.GD16840@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQtVd-0006JJ-M3
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbXCLXAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbXCLXAY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:00:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58230 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbXCLXAW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:00:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQtUw-0004Pv-Bi; Mon, 12 Mar 2007 19:00:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3D51020FBAE; Mon, 12 Mar 2007 19:00:19 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42089>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 connect.c |   36 +++++++++++++++---------------------
 1 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/connect.c b/connect.c
index 8a8a13b..5048653 100644
--- a/connect.c
+++ b/connect.c
@@ -3,6 +3,7 @@
 #include "pkt-line.h"
 #include "quote.h"
 #include "refs.h"
+#include "run-command.h"
 
 static char *server_capabilities;
 
@@ -598,8 +599,8 @@ static void git_proxy_connect(int fd[2], char *host)
 {
 	const char *port = STR(DEFAULT_GIT_PORT);
 	char *colon, *end;
-	int pipefd[2][2];
-	pid_t pid;
+	const char *argv[4];
+	struct child_process proxy;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -618,25 +619,18 @@ static void git_proxy_connect(int fd[2], char *host)
 		port = colon + 1;
 	}
 
-	if (pipe(pipefd[0]) < 0 || pipe(pipefd[1]) < 0)
-		die("unable to create pipe pair for communication");
-	pid = fork();
-	if (!pid) {
-		dup2(pipefd[1][0], 0);
-		dup2(pipefd[0][1], 1);
-		close(pipefd[0][0]);
-		close(pipefd[0][1]);
-		close(pipefd[1][0]);
-		close(pipefd[1][1]);
-		execlp(git_proxy_command, git_proxy_command, host, port, NULL);
-		die("exec failed");
-	}
-	if (pid < 0)
-		die("fork failed");
-	fd[0] = pipefd[0][0];
-	fd[1] = pipefd[1][1];
-	close(pipefd[0][1]);
-	close(pipefd[1][0]);
+	argv[0] = git_proxy_command;
+	argv[1] = host;
+	argv[2] = port;
+	argv[3] = NULL;
+	memset(&proxy, 0, sizeof(proxy));
+	proxy.argv = argv;
+	proxy.in = -1;
+	proxy.out = -1;
+	if (start_command(&proxy))
+		die("cannot start proxy %s", argv[0]);
+	fd[0] = proxy.out; /* read from proxy stdout */
+	fd[1] = proxy.in;  /* write to proxy stdin */
 }
 
 #define MAX_CMD_LEN 1024
-- 
1.5.0.3.985.gcf0b4
