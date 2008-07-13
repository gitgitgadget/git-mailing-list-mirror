From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Move code interpreting path relative to exec-dir to new function system_path()
Date: Sun, 13 Jul 2008 22:31:18 +0200
Message-ID: <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8FB-0005Rf-2t
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbYGMUba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755350AbYGMUb2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:31:28 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:37002 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbYGMUb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:31:27 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id E8E8534AA3;
	Sun, 13 Jul 2008 22:31:23 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.300.ga3a9
In-Reply-To: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88330>

From: Steffen Prohaska <prohaska@zib.de>

Expanding system paths relative to git_exec_path can be used for
creating an installation that can be moved to a different directory
without re-compiling.  We use this approach for template_dir and the
system wide gitconfig.  The Windows installer (msysgit) is an example
for such a setup.

This commit moves common code to a new function system_path().  System
paths that are to be interpreted relative to git_exec_path are passed to
system_path() and the return value is used instead of the original path.
system_path() prefixes a relative path with git_exec_path and leaves
absolute paths unmodified.  For example, we now write

    template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);

[j6t: moved from path.c to exec_cmd.c]

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-init-db.c |   14 ++------------
 config.c          |   11 ++---------
 exec_cmd.c        |   10 ++++++++++
 exec_cmd.h        |    2 +-
 4 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index e23b843..5ba213a 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -115,18 +115,8 @@ static void copy_templates(const char *template_dir)
 
 	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
-	if (!template_dir) {
-		/*
-		 * if the hard-coded template is relative, it is
-		 * interpreted relative to the exec_dir
-		 */
-		template_dir = DEFAULT_GIT_TEMPLATE_DIR;
-		if (!is_absolute_path(template_dir)) {
-			struct strbuf d = STRBUF_INIT;
-			strbuf_addf(&d, "%s/%s", git_exec_path(), template_dir);
-			template_dir = strbuf_detach(&d, NULL);
-		}
-	}
+	if (!template_dir)
+		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
 	strcpy(template_path, template_dir);
 	template_len = strlen(template_path);
 	if (template_path[template_len-1] != '/') {
diff --git a/config.c b/config.c
index 2862cc4..1e066c7 100644
--- a/config.c
+++ b/config.c
@@ -581,15 +581,8 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
-	if (!system_wide) {
-		system_wide = ETC_GITCONFIG;
-		if (!is_absolute_path(system_wide)) {
-			/* interpret path relative to exec-dir */
-			struct strbuf d = STRBUF_INIT;
-			strbuf_addf(&d, "%s/%s", git_exec_path(), system_wide);
-			system_wide = strbuf_detach(&d, NULL);
-		}
-	}
+	if (!system_wide)
+		system_wide = system_path(ETC_GITCONFIG);
 	return system_wide;
 }
 
diff --git a/exec_cmd.c b/exec_cmd.c
index da04efe..8899e31 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -40,6 +40,16 @@ static const char *builtin_exec_path(void)
 #endif
 }
 
+const char *system_path(const char *path)
+{
+	if (!is_absolute_path(path)) {
+		struct strbuf d = STRBUF_INIT;
+		strbuf_addf(&d, "%s/%s", git_exec_path(), path);
+		path = strbuf_detach(&d, NULL);
+	}
+	return path;
+}
+
 void git_set_argv_exec_path(const char *exec_path)
 {
 	argv_exec_path = exec_path;
diff --git a/exec_cmd.h b/exec_cmd.h
index a892355..7eb94e5 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -6,6 +6,6 @@ extern const char* git_exec_path(void);
 extern void setup_path(const char *);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
-
+extern const char *system_path(const char *path);
 
 #endif /* GIT_EXEC_CMD_H */
-- 
1.5.6.2.300.ga3a9
