From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Make builtin-branch.c handle the git config file
Date: Fri,  6 Apr 2007 14:13:00 +0200
Message-ID: <11758615802537-git-send-email-hjemli@gmail.com>
Cc: Geert Bosch <bosch@gnat.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 14:19:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZnIe-0007uN-9w
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 14:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767596AbXDFMLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 08:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767598AbXDFMLx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 08:11:53 -0400
Received: from mail42.e.nsc.no ([193.213.115.42]:48345 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767596AbXDFMLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 08:11:52 -0400
Received: from localhost.localdomain (ti231210a080-10075.bb.online.no [80.212.183.97])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id l36CBdo0002029;
	Fri, 6 Apr 2007 14:11:39 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.53.g77e6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43910>

This moves the knowledge about .git/config usage out of refs.c and into
builtin-branch.c instead, which allows git-branch to update HEAD to point
at the moved branch before attempting to update the config file. It also
allows git-branch to exit with an error code if updating the config file
should fail.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 builtin-branch.c |    6 ++++++
 refs.c           |   10 ----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index a4494ee..7408285 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -493,6 +493,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 {
 	char oldref[PATH_MAX], newref[PATH_MAX], logmsg[PATH_MAX*2 + 100];
 	unsigned char sha1[20];
+	char oldsection[PATH_MAX], newsection[PATH_MAX];
 
 	if (!oldname)
 		die("cannot rename the current branch while not on any.");
@@ -521,6 +522,11 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	/* no need to pass logmsg here as HEAD didn't really move */
 	if (!strcmp(oldname, head) && create_symref("HEAD", newref, NULL))
 		die("Branch renamed to %s, but HEAD is not updated!", newname);
+
+	snprintf(oldsection, sizeof(oldsection), "branch.%s", oldref + 11);
+	snprintf(newsection, sizeof(newsection), "branch.%s", newref + 11);
+	if (git_config_rename_section(oldsection, newsection) < 0)
+		die("Branch is renamed, but update of config-file failed");
 }
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
diff --git a/refs.c b/refs.c
index 2ac6384..d2b7b7f 100644
--- a/refs.c
+++ b/refs.c
@@ -828,16 +828,6 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		goto rollback;
 	}
 
-	if (!prefixcmp(oldref, "refs/heads/") &&
-			!prefixcmp(newref, "refs/heads/")) {
-		char oldsection[1024], newsection[1024];
-
-		snprintf(oldsection, 1024, "branch.%s", oldref + 11);
-		snprintf(newsection, 1024, "branch.%s", newref + 11);
-		if (git_config_rename_section(oldsection, newsection) < 0)
-			error("unable to update config-file");
-	}
-
 	return 0;
 
  rollback:
-- 
1.5.1.53.g77e6f
