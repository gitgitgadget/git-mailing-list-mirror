From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/6] config: add 'git_config_string' to refactor string
 config variables.
Date: Sat, 16 Feb 2008 06:00:24 +0100
Message-ID: <20080216060024.385fa360.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 05:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQF4o-0003re-Sj
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbYBPEy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbYBPEy2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:54:28 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34723 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695AbYBPEy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:54:28 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B6F9F1AB2B5;
	Sat, 16 Feb 2008 05:54:26 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 5A8181AB2A9;
	Sat, 16 Feb 2008 05:54:26 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74010>

In many places we just check if a value from the config file is not
NULL, then we duplicate it and return 0. This patch introduces the new
'git_config_string' function to do that.

This function is also used to refactor some code in 'config.c'.
Refactoring other files is left for other patches.

Also not all the code in "config.c" is refactored, because the function
takes a "const char **" as its first parameter, but in many places a
"char *" is used instead of a "const char *". (And C does not allow
using a "char **" instead of a "const char **" without a warning.)

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |    1 +
 config.c |   25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 3867ba7..cef058d 100644
--- a/cache.h
+++ b/cache.h
@@ -625,6 +625,7 @@ extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
+extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 3e72778..ca6af2d 100644
--- a/config.c
+++ b/config.c
@@ -309,6 +309,14 @@ int git_config_bool(const char *name, const char *value)
 	return git_config_int(name, value) != 0;
 }
 
+int git_config_string(const char **dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	*dest = xstrdup(value);
+	return 0;
+}
+
 int git_default_config(const char *var, const char *value)
 {
 	/* This needs a better name */
@@ -421,20 +429,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "i18n.commitencoding")) {
-		if (!value)
-			return config_error_nonbool(var);
-		git_commit_encoding = xstrdup(value);
-		return 0;
-	}
-
-	if (!strcmp(var, "i18n.logoutputencoding")) {
-		if (!value)
-			return config_error_nonbool(var);
-		git_log_output_encoding = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "i18n.commitencoding"))
+		return git_config_string(&git_commit_encoding, var, value);
 
+	if (!strcmp(var, "i18n.logoutputencoding"))
+		return git_config_string(&git_log_output_encoding, var, value);
 
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
-- 
1.5.4.1.129.gf12af-dirty
