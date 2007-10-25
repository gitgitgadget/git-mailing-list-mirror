From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 5/7] chdir() into list_commands() dir instead of building paths for stat()
Date: Wed, 24 Oct 2007 23:32:36 -0700
Message-ID: <1193293956-3759-1-git-send-email-srp@srparish.net>
References: <1193293802-3732-1-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 08:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkwH6-00019C-Df
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 08:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbXJYGci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 02:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbXJYGci
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 02:32:38 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:36023 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbXJYGch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 02:32:37 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtp (MailAnyone extSMTP quinn@srparish.net)
	id 1IkwGi-0004E7-T7; Thu, 25 Oct 2007 01:32:37 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 85AC74EDF74; Wed, 24 Oct 2007 23:32:36 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11178.g9a1bf-dirty
In-Reply-To: <1193293802-3732-1-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62279>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/help.c b/help.c
index d6dfdff..322ddaa 100644
--- a/help.c
+++ b/help.c
@@ -96,36 +96,24 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 static void list_commands(const char *exec_path)
 {
 	unsigned int longest = 0;
-	char path[PATH_MAX];
 	const char *prefix = "git-";
 	int prefix_len = strlen(prefix);
-	int dirlen;
 	DIR *dir = opendir(exec_path);
 	struct dirent *de;
 
-	if (!dir) {
+	if (!dir || chdir(exec_path)) {
 		fprintf(stderr, "git: '%s': %s\n", exec_path, strerror(errno));
 		exit(1);
 	}
 
-	dirlen = strlen(exec_path);
-	if (PATH_MAX - 20 < dirlen) {
-		fprintf(stderr, "git: insanely long exec-path '%s'\n",
-			exec_path);
-		exit(1);
-	}
-
-	memcpy(path, exec_path, dirlen);
-	path[dirlen++] = '/';
-
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st;
 		int entlen;
 
 		if (prefixcmp(de->d_name, prefix))
 			continue;
-		strcpy(path+dirlen, de->d_name);
-		if (stat(path, &st) || /* stat, not lstat */
+
+		if (stat(de->d_name, &st) || /* stat, not lstat */
 		    !S_ISREG(st.st_mode) ||
 		    !(st.st_mode & S_IXUSR))
 			continue;
-- 
gitgui.0.8.4.11178.g9a1bf-dirty
