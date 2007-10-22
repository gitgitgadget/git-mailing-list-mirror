From: Scott R Parish <srp@srparish.net>
Subject: [PATCH] s/pattern/prefix/ in help's list_commands
Date: Mon, 22 Oct 2007 01:51:41 -0700
Message-ID: <20071022085141.GA9654@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 10:52:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijt0z-0001Wt-Dc
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 10:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbXJVIvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 04:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbXJVIvo
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 04:51:44 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:49022 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbXJVIvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 04:51:43 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Ijt0f-00050T-UX
	for git@vger.kernel.org; Mon, 22 Oct 2007 03:51:42 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Mon, 22 Oct 2007 01:51:42 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61973>

list_commands() currently accepts and ignores a "pattern" argument,
and then hard codes a prefix as well as some magic numbers. This
renames the arg from pattern to prefix and uses that instead of the
hardcoded stuff.

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 help.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index b0d2dd4..950f62d 100644
--- a/help.c
+++ b/help.c
@@ -93,11 +93,12 @@ static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 	}
 }
 
-static void list_commands(const char *exec_path, const char *pattern)
+static void list_commands(const char *exec_path, const char *prefix)
 {
 	unsigned int longest = 0;
 	char path[PATH_MAX];
 	int dirlen;
+	int prefix_len = strlen(prefix);
 	DIR *dir = opendir(exec_path);
 	struct dirent *de;
 
@@ -120,7 +121,7 @@ static void list_commands(const char *exec_path, const char *pattern)
 		struct stat st;
 		int entlen;
 
-		if (prefixcmp(de->d_name, "git-"))
+		if (prefixcmp(de->d_name, prefix))
 			continue;
 		strcpy(path+dirlen, de->d_name);
 		if (stat(path, &st) || /* stat, not lstat */
@@ -128,14 +129,14 @@ static void list_commands(const char *exec_path, const char *pattern)
 		    !(st.st_mode & S_IXUSR))
 			continue;
 
-		entlen = strlen(de->d_name);
+		entlen = strlen(de->d_name) - prefix_len;
 		if (has_extension(de->d_name, ".exe"))
 			entlen -= 4;
 
 		if (longest < entlen)
 			longest = entlen;
 
-		add_cmdname(de->d_name + 4, entlen-4);
+		add_cmdname(de->d_name + prefix_len, entlen);
 	}
 	closedir(dir);
 
@@ -143,7 +144,7 @@ static void list_commands(const char *exec_path, const char *pattern)
 	printf("----------------------------");
 	mput_char('-', strlen(exec_path));
 	putchar('\n');
-	pretty_print_string_list(cmdname, longest - 4);
+	pretty_print_string_list(cmdname, longest);
 	putchar('\n');
 }
 
@@ -210,7 +211,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		if(exec_path)
-			list_commands(exec_path, "git-*");
+			list_commands(exec_path, "git-");
 		exit(0);
 	}
 
-- 
1.5.3.4.209.g5d1ce-dirty
