From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 5/7] chdir() into list_commands() dir instead of building paths for stat()
Date: Wed, 24 Oct 2007 20:37:15 -0700
Message-ID: <1193283437-1706-5-git-send-email-srp@srparish.net>
References: <1193283437-1706-1-git-send-email-srp@srparish.net>
 <1193283437-1706-2-git-send-email-srp@srparish.net>
 <1193283437-1706-3-git-send-email-srp@srparish.net>
 <1193283437-1706-4-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 05:38:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IktXs-0003gd-36
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 05:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbXJYDh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 23:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbXJYDh3
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 23:37:29 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:51579 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbXJYDhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 23:37:19 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtp (MailAnyone extSMTP quinn@srparish.net)
	id 1IktX4-0003Tk-0k; Wed, 24 Oct 2007 22:37:18 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 4C48F4EA8C4; Wed, 24 Oct 2007 20:37:17 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11178.g9a1bf-dirty
In-Reply-To: <1193283437-1706-4-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62265>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/help.c b/help.c
index 950f62d..906f8f6 100644
--- a/help.c
+++ b/help.c
@@ -96,35 +96,23 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 static void list_commands(const char *exec_path, const char *prefix)
 {
 	unsigned int longest = 0;
-	char path[PATH_MAX];
-	int dirlen;
 	int prefix_len = strlen(prefix);
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
gitgui.0.8.4.11176.gd9205-dirty
