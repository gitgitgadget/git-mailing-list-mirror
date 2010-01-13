From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH 1/2] Add `init-db.templatedir` configuration variable.
Date: Wed, 13 Jan 2010 17:19:36 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001131719050.22639@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 05:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUuqR-0006K2-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 05:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab0AME0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 23:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560Ab0AME0A
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 23:26:00 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:34513 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab0AME0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 23:26:00 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 7272D170FE3
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:25:57 +1300 (NZDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136766>

Include `init.templatedir` as an alias for `init-db.templatedir`.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 builtin-init-db.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..d56b3a4 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -20,6 +20,7 @@
 
 static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
+static const char *init_db_template_dir;
 
 static void safe_create_dir(const char *dir, int share)
 {
@@ -121,6 +122,8 @@ static void copy_templates(const char *template_dir)
 	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
+		template_dir = init_db_template_dir;
+	if (!template_dir)
 		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
 	if (!template_dir[0])
 		return;
@@ -165,6 +168,15 @@ static void copy_templates(const char *template_dir)
 	closedir(dir);
 }
 
+static int git_init_db_config(const char *k, const char *v, void *cb)
+{
+	/* we will accept "init-db.templatedir" or "init.templatedir" */
+	if (!strcmp(k, "init-db.templatedir") || !strcmp(k, "init.templatedir"))
+		return git_config_pathname(&init_db_template_dir, k, v);
+
+	return 0;
+}
+
 static int create_default_files(const char *template_path)
 {
 	const char *git_dir = get_git_dir();
@@ -190,6 +202,9 @@ static int create_default_files(const char *template_path)
 	safe_create_dir(git_path("refs/heads"), 1);
 	safe_create_dir(git_path("refs/tags"), 1);
 
+	/* Just look for `init-db.templatedir` */
+	git_config(git_init_db_config, NULL);
+
 	/* First copy the templates -- we might have the default
 	 * config file there, in which case we would want to read
 	 * from it after installing.
-- 
1.6.4
