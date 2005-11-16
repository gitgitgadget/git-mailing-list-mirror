From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 3/3] git --help COMMAND brings up the git-COMMAND man-page., take two
Date: Wed, 16 Nov 2005 01:23:18 +0100 (CET)
Message-ID: <20051116002318.A46C55BF97@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 16 01:24:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcB59-0002St-BA
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 01:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVKPAXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 19:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVKPAXU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 19:23:20 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:59123 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965103AbVKPAXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 19:23:19 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA00077025 for git@vger.kernel.org; Wed, 16 Nov 2005 01:23:19 +0100
Received: from nox.op5.se (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAG0NIf24547
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 01:23:18 +0100
Received: by nox.op5.se (Postfix, from userid 500)
	id A46C55BF97; Wed, 16 Nov 2005 01:23:18 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11978>


It's by design a bit stupid (matching ^git rather than ^git-), so as
to work with 'gitk' and 'git' as well.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git.txt |    2 ++
 git.c                 |   26 ++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

applies-to: 8a47ae8a825ab0e68ac46392bccd1ec16df39456
53e2024f89514d31a45936e3596e3d285dfd1bfe
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 91e9f9f..7cbfaf8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -24,6 +24,8 @@ OPTIONS
 
 --help::
 	prints the synopsis and a list of available commands.
+	If a git command is named this option will bring up the
+	man-page for that command.
 
 --exec-path::
 	path to wherever your core git programs are installed.
diff --git a/git.c b/git.c
index d189801..4b7cbf6 100644
--- a/git.c
+++ b/git.c
@@ -160,6 +160,24 @@ static void prepend_to_path(const char *
 	setenv("PATH", path, 1);
 }
 
+static void show_man_page(char *git_cmd)
+{
+	char *page;
+
+	if (!strncmp(git_cmd, "git", 3))
+		page = git_cmd;
+	else {
+		int page_len = strlen(git_cmd) + 4;
+
+		page = malloc(page_len + 1);
+		strcpy(page, "git-");
+		strcpy(page + 4, git_cmd);
+		page[page_len] = 0;
+	}
+
+	execlp("man", "man", page, NULL);
+}
+
 int main(int argc, char **argv, char **envp)
 {
 	char git_command[PATH_MAX + 1];
@@ -199,8 +217,12 @@ int main(int argc, char **argv, char **e
 			usage(NULL, NULL);
 	}
 
-	if (i >= argc || show_help)
-		usage(exec_path, NULL);
+	if (i >= argc || show_help) {
+		if (i >= argc)
+			usage(exec_path, NULL);
+
+		show_man_page(argv[i]);
+	}
 
 	/* allow relative paths, but run with exact */
 	if (chdir(exec_path)) {
---
0.99.9.GIT
