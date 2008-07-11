From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/3] Move code interpreting path relative to exec-dir to new function system_path()
Date: Fri, 11 Jul 2008 09:28:04 +0200
Message-ID: <1215761286-2489-1-git-send-email-prohaska@zib.de>
References: <4668B2FF-2B2B-4221-8151-F0AEA681983C@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 11 09:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHD4P-00033Y-8H
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 09:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbYGKH2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 03:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbYGKH2a
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 03:28:30 -0400
Received: from mailer.zib.de ([130.73.108.11]:49553 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853AbYGKH23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 03:28:29 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6B7S759014453;
	Fri, 11 Jul 2008 09:28:12 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6B7S6CT029856;
	Fri, 11 Jul 2008 09:28:06 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <4668B2FF-2B2B-4221-8151-F0AEA681983C@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88089>

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

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-init-db.c |   14 ++------------
 cache.h           |    1 +
 config.c          |   11 ++---------
 path.c            |   11 +++++++++++
 4 files changed, 16 insertions(+), 21 deletions(-)

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
diff --git a/cache.h b/cache.h
index 0d8edda..dafa265 100644
--- a/cache.h
+++ b/cache.h
@@ -529,6 +529,7 @@ const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
 int normalize_absolute_path(char *buf, const char *path);
 int longest_ancestor_length(const char *path, const char *prefix_list);
+extern const char *system_path(const char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
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
 
diff --git a/path.c b/path.c
index 5983255..141496e 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include "exec_cmd.h"
 
 static char bad_path[] = "/bad-path/";
 
@@ -439,3 +440,13 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 
 	return max_len;
 }
+
+const char *system_path(const char *path)
+{
+	if (!is_absolute_path(path)) {
+		struct strbuf d = STRBUF_INIT;
+		strbuf_addf(&d, "%s/%s", git_exec_path(), path);
+		path = strbuf_detach(&d, NULL);
+	}
+	return path;
+}
-- 
1.5.6.1.282.gd8a0d
