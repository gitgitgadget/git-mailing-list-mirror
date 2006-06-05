From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] builtin-push: don't pass --thin to HTTP transport
Date: Mon, 5 Jun 2006 13:02:29 -0700
Message-ID: <20060605200229.GA3938@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 05 22:02:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnLHV-0002Ct-Jq
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 22:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWFEUCa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 16:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWFEUCa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 16:02:30 -0400
Received: from 241.37.26.69.virtela.net ([69.26.37.241]:27409 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751382AbWFEUCa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 16:02:30 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k55K2TmZ009367
	for <git@vger.kernel.org>; Mon, 5 Jun 2006 13:02:29 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k55K2TcF009365
	for git@vger.kernel.org; Mon, 5 Jun 2006 13:02:29 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21334>

git-http-push does not currently use packs to transfer objects.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>
---
 builtin-push.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index e530022..66b9407 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -214,7 +214,7 @@ static int do_push(const char *repo)
 {
 	const char *uri[MAX_URI];
 	int i, n;
-	int remote;
+	int common_argc;
 	const char **argv;
 	int argc;
 
@@ -231,23 +231,25 @@ static int do_push(const char *repo)
 		argv[argc++] = "--force";
 	if (execute)
 		argv[argc++] = execute;
-	if (thin)
-		argv[argc++] = "--thin";
-	remote = argc;
-	argv[argc++] = "dummy-remote";
-	while (refspec_nr--)
-		argv[argc++] = *refspec++;
-	argv[argc] = NULL;
+	common_argc = argc;
 
 	for (i = 0; i < n; i++) {
 		int error;
+		int dest_argc = common_argc;
+		int dest_refspec_nr = refspec_nr;
+		const char **dest_refspec = refspec;
 		const char *dest = uri[i];
 		const char *sender = "git-send-pack";
 		if (!strncmp(dest, "http://", 7) ||
 		    !strncmp(dest, "https://", 8))
 			sender = "git-http-push";
+		else if (thin)
+			argv[dest_argc++] = "--thin";
 		argv[0] = sender;
-		argv[remote] = dest;
+		argv[dest_argc++] = dest;
+		while (dest_refspec_nr--)
+			argv[dest_argc++] = *dest_refspec++;
+		argv[dest_argc] = NULL;
 		error = run_command_v(argc, argv);
 		if (!error)
 			continue;
-- 
1.3.3.g423a-dirty
