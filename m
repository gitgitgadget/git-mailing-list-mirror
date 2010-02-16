From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH 1/2] Add `init.templatedir` configuration variable.
Date: Wed, 17 Feb 2010 12:42:31 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002171242150.2477@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXBR-0003FO-JK
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933627Ab0BPXuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:50:20 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:46851 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933399Ab0BPXuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:50:19 -0500
Received: from idran.drake.org.nz (ip-118-90-92-203.xdsl.xnet.co.nz [118.90.92.203])
	by ananke.wxnz.net (Postfix) with ESMTP id 55DBE170DD5
	for <git@vger.kernel.org>; Wed, 17 Feb 2010 12:50:18 +1300 (NZDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140180>

Rather than having to pass --template to git init and clone for a custom
setup, `init.templatedir` may be set in '~/.gitconfig'
(Eg.  git config --global --add init.templatedir ~/.gittemplate )

System administrators may prefer using this varialbe in the system-wide
config file rather than editing files under '/usr/share'.
(I.e. setting init.templatedir to $(prefix)/etc/gittempalte )

The environment variable GIT_TEMPLATE_DIR can already be used for this but
the '.gitconfig' file is a much better place for this type of setting.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 builtin-init-db.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..a54f489 100644
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
@@ -165,6 +168,14 @@ static void copy_templates(const char *template_dir)
 	closedir(dir);
 }
 
+static int git_init_db_config(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "init.templatedir"))
+		return git_config_pathname(&init_db_template_dir, k, v);
+
+	return 0;
+}
+
 static int create_default_files(const char *template_path)
 {
 	const char *git_dir = get_git_dir();
@@ -190,6 +201,9 @@ static int create_default_files(const char *template_path)
 	safe_create_dir(git_path("refs/heads"), 1);
 	safe_create_dir(git_path("refs/tags"), 1);
 
+	/* Just look for `init.templatedir` */
+	git_config(git_init_db_config, NULL);
+
 	/* First copy the templates -- we might have the default
 	 * config file there, in which case we would want to read
 	 * from it after installing.
-- 
1.6.6.208.gcaa4e.dirty
