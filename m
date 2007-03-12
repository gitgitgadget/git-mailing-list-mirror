From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] always interpret GIT_WORK_DIR relative to $GIT_DIR
Date: Mon, 12 Mar 2007 20:18:12 +0100
Message-ID: <20070312191812.GA29327@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx> <20070312121226.GB2268@always.joy.eth.net> <20070312131253.GA16452@moooo.ath.cx> <fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com> <20070312140808.GA17450@moooo.ath.cx> <7vabyitlld.fsf@assigned-by-dhcp.cox.net> <20070312180837.GA22701@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:18:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQq2G-0001Xd-87
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbXCLTSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbXCLTSR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:18:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:56267 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752366AbXCLTSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:18:16 -0400
Received: (qmail invoked by alias); 12 Mar 2007 19:18:14 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp053) with SMTP; 12 Mar 2007 20:18:14 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19MGSReTTZMSY6LO2Z0relmE0omc3CVkCV/AnZJcm
	9DVEoVoMn9FlPC
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070312180837.GA22701@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42063>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 setup.c |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/setup.c b/setup.c
index a8b9fae..f8c020e 100644
--- a/setup.c
+++ b/setup.c
@@ -192,16 +192,36 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
+static int stat_relative(const char *base, const char *path, struct stat *st)
+{
+	char cwd[PATH_MAX];
+	int ret;
+
+	if (path[0] != '/') {
+		if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		if (chdir(base))
+			die("Cannot change directory to '%s'", base);
+	}
+
+	ret = stat(path, st);
+
+	if (path[0] != '/' && chdir(cwd))
+		die("Cannot come back to cwd");
+
+	return ret;
+}
+
 static int stat_git_work_dir(struct stat *st)
 {
-	char workdir[PATH_MAX], cwd[PATH_MAX];
+	char workdir[PATH_MAX];
 	const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 	const char *gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
 	int offset;
 	FILE *fp;
 
 	if (gitwd) {
-		if (!stat(gitwd, st))
+		if (!stat_relative(gitdir, gitwd, st))
 			return 1;
 		die("Unable to stat git working directory '%s'", gitwd);
 	}
@@ -231,21 +251,8 @@ static int stat_git_work_dir(struct stat *st)
 		--offset;
 	workdir[offset+1] = '\0';
 
-	/* relative path: change to gitdir for stat */
-	if (workdir[0] != '/') {
-		if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
-			die("Unable to read current working directory");
-		if (chdir(gitdir))
-			die("Cannot change directory to '%s'", gitdir);
-	}
-
-	if (stat(workdir, st))
+	if (stat_relative(gitdir, workdir, st))
 		die("Unable to stat directory from GIT_DIR/workdir");
-	if (!(st->st_mode & S_IFDIR))
-		die("GIT_DIR/workdir does not point to a directory");
-
-	if (workdir[0] != '/' && chdir(cwd))
-		die("Cannot come back to cwd");
 
 	return 1;
 }
-- 
1.5.0.3.1007.g7ff7
