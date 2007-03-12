From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 12:53:50 +0100
Message-ID: <20070312115350.GA15179@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 12:54:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQj6G-0005BK-Vl
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 12:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965713AbXCLLx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 07:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965726AbXCLLx5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 07:53:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:55505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965713AbXCLLx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 07:53:56 -0400
Received: (qmail invoked by alias); 12 Mar 2007 11:53:55 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp019) with SMTP; 12 Mar 2007 12:53:55 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19xQ5h+juFxo1usBlDgD2hzLG1xgji64Tn8qMITLR
	Du1o2tx5n2P7tt
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070311043250.GA21331@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42020>

git-init will always put an absolute path in
GIT_DIR/workdir, relative paths are resolved from the
directory git-init was called from.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
I found this static char path[PATH_MAX] even though path is neither
reused nor returned.  If there is any reason to have this as a static
buffer please change this back to 'static char'
---
 builtin-init-db.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4df9fd0..f0b4444 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -176,12 +176,13 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 static int create_default_files(const char *git_dir, const char *template_path)
 {
 	unsigned len = strlen(git_dir);
-	static char path[PATH_MAX];
+	char path[PATH_MAX], workdir[PATH_MAX];
 	unsigned char sha1[20];
 	struct stat st1;
 	char repo_version_string[10];
 	int reinit;
 	int filemode;
+	const char *gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
 
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
@@ -252,7 +253,42 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository()) {
+	/* make gitwd an absolute path */
+	if (gitwd && gitwd[0] != '/') {
+		char cwd[PATH_MAX];
+
+		if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		if (chdir(gitwd)) {
+			fprintf(stderr, "warning: chdir to specified relative "
+				"working directory failed, ignoring\n");
+			gitwd = NULL;
+		}
+		else if (!getcwd(workdir, sizeof(workdir)) || workdir[0] != '/')
+			die("Unable to read current working directory");
+		else {
+			gitwd = workdir;
+			if (chdir(cwd))
+				die("Cannot come back to cwd");
+		}
+	}
+
+	if (gitwd) {
+		FILE *fp = NULL;
+
+		path[len] = 0;
+		strcpy(path + len, "workdir");
+		if (!(fp = fopen(path, "w")))
+			die("Cannot open GIT_DIR/workdir");
+		fprintf(fp, "%s\n", gitwd);
+		fclose(fp);
+
+		git_config_set("core.bare", "false");
+		/* allow template config file to override the default */
+		if (log_all_ref_updates == -1)
+		    git_config_set("core.logallrefupdates", "true");
+	}
+	else if (is_bare_repository()) {
 		git_config_set("core.bare", "true");
 	}
 	else {
-- 
1.5.0.3.1006.gd633
