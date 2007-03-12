From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/7] Use run_command within merge-index
Date: Mon, 12 Mar 2007 19:00:21 -0400
Message-ID: <20070312230021.GE16840@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:00:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQtVe-0006JJ-7K
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbXCLXA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbXCLXA1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:00:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58235 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbXCLXAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:00:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQtUz-0004Q3-4V; Mon, 12 Mar 2007 19:00:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0657D20FBAE; Mon, 12 Mar 2007 19:00:22 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42091>

Maybe unnecessary as the merge-index utility may go away in the
future, but its currently here, its shorter to use run_command,
and probably will help the MinGW port out.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-index.c |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/merge-index.c b/merge-index.c
index 7027d78..6df4394 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "run-command.h"
 
 static const char *pgm;
 static const char *arguments[8];
@@ -7,24 +8,10 @@ static int err;
 
 static void run_program(void)
 {
-	pid_t pid = fork();
-	int status;
-
-	if (pid < 0)
-		die("unable to fork");
-	if (!pid) {
-		execlp(pgm, arguments[0],
-			    arguments[1],
-			    arguments[2],
-			    arguments[3],
-			    arguments[4],
-			    arguments[5],
-			    arguments[6],
-			    arguments[7],
-			    NULL);
-		die("unable to execute '%s'", pgm);
-	}
-	if (waitpid(pid, &status, 0) < 0 || !WIFEXITED(status) || WEXITSTATUS(status)) {
+	struct child_process child;
+	memset(&child, 0, sizeof(child));
+	child.argv = arguments;
+	if (run_command(&child)) {
 		if (one_shot) {
 			err++;
 		} else {
-- 
1.5.0.3.985.gcf0b4
