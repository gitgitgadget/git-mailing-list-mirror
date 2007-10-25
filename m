From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 2/7] s/pattern/prefix/ in help's list_commands
Date: Wed, 24 Oct 2007 20:37:12 -0700
Message-ID: <1193283437-1706-2-git-send-email-srp@srparish.net>
References: <1193283437-1706-1-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 05:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IktXL-0003WC-FR
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 05:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbXJYDhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 23:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756487AbXJYDhY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 23:37:24 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:51538 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbXJYDhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 23:37:18 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtp (MailAnyone extSMTP quinn@srparish.net)
	id 1IktX3-0003T2-GN; Wed, 24 Oct 2007 22:37:17 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 275554EA8C1; Wed, 24 Oct 2007 20:37:17 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11178.g9a1bf-dirty
In-Reply-To: <1193283437-1706-1-git-send-email-srp@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62262>

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
gitgui.0.8.4.11176.gd9205-dirty
