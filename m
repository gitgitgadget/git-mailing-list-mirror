From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH(amend)] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 20:23:01 +0100
Message-ID: <20070312192301.GB29327@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQq8M-0004R5-1W
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbXCLTXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXCLTXF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:23:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:33202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752470AbXCLTXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:23:03 -0400
Received: (qmail invoked by alias); 12 Mar 2007 19:23:02 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp036) with SMTP; 12 Mar 2007 20:23:02 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/A0q9P7YHA1ihWPWVMH/dlOLlJxQSuZcfMcTkkd2
	Y0umE3NprhyR9e
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070312115350.GA15179@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42064>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
It's much easier when $GIT_WORK_DIR is always interpreted relative to
$GIT_DIR.
---
 builtin-init-db.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4df9fd0..8d0065c 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -182,6 +182,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	char repo_version_string[10];
 	int reinit;
 	int filemode;
+	const char *gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
 
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
@@ -252,10 +253,21 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository()) {
+	if (is_bare_repository() && !gitwd) {
 		git_config_set("core.bare", "true");
 	}
 	else {
+		if (gitwd) {
+			FILE *fp = NULL;
+
+			path[len] = 0;
+			strcpy(path + len, "workdir");
+			if (!(fp = fopen(path, "w")))
+				die("Cannot open GIT_DIR/workdir");
+			fprintf(fp, "%s\n", gitwd);
+			fclose(fp);
+		}
+
 		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
-- 
1.5.0.3.1007.g7ff7
