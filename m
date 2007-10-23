From: Scott R Parish <srp@srparish.net>
Subject: [PATCH] chdir() into list_commands() dir instead of building paths for stat()
Date: Tue, 23 Oct 2007 08:40:22 -0700
Message-ID: <20071023154021.GA26587@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 17:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkLry-0007fQ-MP
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 17:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbXJWPk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 11:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbXJWPk0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 11:40:26 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:59534 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbXJWPkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 11:40:25 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1IkLrj-0000ln-TP
	for git@vger.kernel.org; Tue, 23 Oct 2007 10:40:25 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 501
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Tue, 23 Oct 2007 08:40:23 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62131>

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
gitgui.0.8.4.11178.g9a1bf-dirty
