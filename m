From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 2/5] Server-side support for user-relative paths.
Date: Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Message-ID: <20051117193714.35B275BF8E@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 20:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpZm-0000lW-K3
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVKQThX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVKQThX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:37:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36826 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964821AbVKQThP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:37:15 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 6CC2E6BD10
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 35B275BF8E; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12143>


This patch basically just removes the redundant code from
{receive,upload}-pack.c in favour of the library code in path.c.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 receive-pack.c |   17 ++++-------------
 upload-pack.c  |   15 +++------------
 2 files changed, 7 insertions(+), 25 deletions(-)

applies-to: b08588da04c14104d2e158d26881062c8f21598a
03ddd42c1ad92bafbb536e9b50368a57013fdba2
diff --git a/receive-pack.c b/receive-pack.c
index 8f157bc..1873506 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -248,11 +248,11 @@ static void unpack(void)
 int main(int argc, char **argv)
 {
 	int i;
-	const char *dir = NULL;
+	char *dir = NULL;
 
 	argv++;
 	for (i = 1; i < argc; i++) {
-		const char *arg = *argv++;
+		char *arg = *argv++;
 
 		if (*arg == '-') {
 			/* Do flag handling here */
@@ -265,18 +265,9 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
-	/* chdir to the directory. If that fails, try appending ".git" */
-	if (chdir(dir) < 0) {
-		if (chdir(mkpath("%s.git", dir)) < 0)
-			die("unable to cd to %s", dir);
-	}
-
-	/* If we have a ".git" directory, chdir to it */
-	chdir(".git");
-	putenv("GIT_DIR=.");
+	if(!enter_repo(dir, 0))
+		die("'%s': unable to chdir or not a git archive", dir);
 
-	if (access("objects", X_OK) < 0 || access("refs/heads", X_OK) < 0)
-		die("%s doesn't appear to be a git directory", dir);
 	write_head_info();
 
 	/* EOF */
diff --git a/upload-pack.c b/upload-pack.c
index be63132..1834b6b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -248,7 +248,7 @@ static int upload_pack(void)
 
 int main(int argc, char **argv)
 {
-	const char *dir;
+	char *dir;
 	int i;
 	int strict = 0;
 
@@ -275,18 +275,9 @@ int main(int argc, char **argv)
 		usage(upload_pack_usage);
 	dir = argv[i];
 
-	/* chdir to the directory. If that fails, try appending ".git" */
-	if (chdir(dir) < 0) {
-		if (strict || chdir(mkpath("%s.git", dir)) < 0)
-			die("git-upload-pack unable to chdir to %s", dir);
-	}
-	if (!strict)
-		chdir(".git");
-
-	if (access("objects", X_OK) || access("refs", X_OK))
-		die("git-upload-pack: %s doesn't seem to be a git archive", dir);
+	if (!enter_repo(dir, strict))
+		die("'%s': unable to chdir or not a git archive", dir);
 
-	putenv("GIT_DIR=.");
 	upload_pack();
 	return 0;
 }
---
0.99.9.GIT
