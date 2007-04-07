From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-push to multiple locations does not stop at the first failure
Date: Fri, 06 Apr 2007 23:04:53 -0700
Message-ID: <7vhcrsg1oa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 08:04:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha42k-0000JK-IH
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 08:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbXDGGEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 02:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbXDGGEz
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 02:04:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47062 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbXDGGEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 02:04:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407060453.MTJB25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 02:04:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id k64t1W0061kojtg0000000; Sat, 07 Apr 2007 02:04:54 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43961>

When pushing into multiple repositories with git push, via
multiple URL in .git/remotes/$shorthand or multiple url
variables in [remote "$shorthand"] section, we used to stop upon
the first failure.  Continue the operation and report the
failure at the end.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This matters a bit to me, as I have 'builders' shorthand that
   pushes into two bochs images (one for FC5, another for
   OpenBSD) I installed on my wife's machine, so that I can cut
   a release and run portability testing.  Usually however I do
   not start the OpenBSD image automatically there.

 builtin-push.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 23143be..cb78401 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -297,7 +297,7 @@ static int read_config(const char *repo, const char *uri[MAX_URI])
 static int do_push(const char *repo)
 {
 	const char *uri[MAX_URI];
-	int i, n;
+	int i, n, errs;
 	int common_argc;
 	const char **argv;
 	int argc;
@@ -317,6 +317,7 @@ static int do_push(const char *repo)
 		argv[argc++] = receivepack;
 	common_argc = argc;
 
+	errs = 0;
 	for (i = 0; i < n; i++) {
 		int err;
 		int dest_argc = common_argc;
@@ -343,19 +344,19 @@ static int do_push(const char *repo)
 		error("failed to push to '%s'", uri[i]);
 		switch (err) {
 		case -ERR_RUN_COMMAND_FORK:
-			die("unable to fork for %s", sender);
+			error("unable to fork for %s", sender);
 		case -ERR_RUN_COMMAND_EXEC:
-			die("unable to exec %s", sender);
+			error("unable to exec %s", sender);
+			break;
 		case -ERR_RUN_COMMAND_WAITPID:
 		case -ERR_RUN_COMMAND_WAITPID_WRONG_PID:
 		case -ERR_RUN_COMMAND_WAITPID_SIGNAL:
 		case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
-			die("%s died with strange error", sender);
-		default:
-			return -err;
+			error("%s died with strange error", sender);
 		}
+		errs++;
 	}
-	return 0;
+	return !!errs;
 }
 
 int cmd_push(int argc, const char **argv, const char *prefix)
