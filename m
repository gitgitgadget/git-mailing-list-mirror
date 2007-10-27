From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 4/7] list_commands(): simplify code by using chdir()
Date: Sat, 27 Oct 2007 01:36:52 -0700
Message-ID: <1193474215-6728-4-git-send-email-srp@srparish.net>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
 <1193474215-6728-2-git-send-email-srp@srparish.net>
 <1193474215-6728-3-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 10:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlhAQ-00083R-Nw
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbXJ0IhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 04:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbXJ0IhA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:37:00 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:45254 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbXJ0Ig7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:36:59 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtp (MailAnyone extSMTP srp)
	id 1IlhA9-00056Y-Tl; Sat, 27 Oct 2007 03:36:58 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id A140F4F21CE; Sat, 27 Oct 2007 01:36:56 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11179.g60ba
In-Reply-To: <1193474215-6728-3-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62471>

The current code builds absolute path strings for each file to
stat(), this can easily be avoided by chdir()ing into the directory.

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/help.c b/help.c
index b636774..ce3d795 100644
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
