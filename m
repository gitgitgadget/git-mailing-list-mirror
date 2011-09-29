From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 3/4] enter_repo: do not modify input
Date: Thu, 29 Sep 2011 22:59:22 +0200
Message-ID: <1317329963-6656-4-git-send-email-kusmabite@gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org, gitster@pobox.com,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 22:59:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Nht-00023q-MK
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757Ab1I2U7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 16:59:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39978 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757731Ab1I2U7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 16:59:39 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1097794bkb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6AM5Qp8QVhiSfRY2X5znOpgT70uAnFbTdiquyptiXo4=;
        b=GQfmcvkOx0fAKp9x7Wk2jeuIoPKv0oZeIoZnAdM53CTSqE3UxCMIYZmeNyQJn5Oa2v
         iZZUDkI1j0GU3LFyXsBtMVKUxloii0niD+ZvYqifecy+obfrncP+HFUUp6oYHPOwPjGZ
         UJo4H8kZYUQ5auwEj8Ty5RpCR056hf3y5uqaA=
Received: by 10.204.154.150 with SMTP id o22mr7206299bkw.363.1317329978777;
        Thu, 29 Sep 2011 13:59:38 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no. [84.215.188.225])
        by mx.google.com with ESMTPS id w3sm2842878bkp.10.2011.09.29.13.59.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 13:59:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.355.g842ba.dirty
In-Reply-To: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182437>

entr_repo(..., 0) currently modifies the input to strip away
trailing slashes. This means that we some times need to copy the
input to keep the original.

Change it to unconditionally copy it into the used_path buffer so
we can safely use the input without having to copy it.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 cache.h  |    2 +-
 daemon.c |    4 ++--
 path.c   |   30 ++++++++++++++----------------
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index 607c2ea..a7e4de1 100644
--- a/cache.h
+++ b/cache.h
@@ -734,7 +734,7 @@ int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
 int mkdir_in_gitdir(const char *path);
 extern char *expand_user_path(const char *path);
-char *enter_repo(char *path, int strict);
+const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
diff --git a/daemon.c b/daemon.c
index 4c8346d..9253192 100644
--- a/daemon.c
+++ b/daemon.c
@@ -108,11 +108,11 @@ static void NORETURN daemon_die(const char *err, va_list params)
 	exit(1);
 }
 
-static char *path_ok(char *directory)
+static const char *path_ok(char *directory)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
-	char *path;
+	const char *path;
 	char *dir;
 
 	dir = directory;
diff --git a/path.c b/path.c
index 6f3f5d5..f7dfd0b 100644
--- a/path.c
+++ b/path.c
@@ -283,7 +283,7 @@ return_null:
  * links.  User relative paths are also returned as they are given,
  * except DWIM suffixing.
  */
-char *enter_repo(char *path, int strict)
+const char *enter_repo(const char *path, int strict)
 {
 	static char used_path[PATH_MAX];
 	static char validated_path[PATH_MAX];
@@ -297,14 +297,15 @@ char *enter_repo(char *path, int strict)
 		};
 		int len = strlen(path);
 		int i;
-		while ((1 < len) && (path[len-1] == '/')) {
-			path[len-1] = 0;
+		while ((1 < len) && (path[len-1] == '/'))
 			len--;
-		}
+
 		if (PATH_MAX <= len)
 			return NULL;
-		if (path[0] == '~') {
-			char *newpath = expand_user_path(path);
+		strncpy(used_path, path, len);
+
+		if (used_path[0] == '~') {
+			char *newpath = expand_user_path(used_path);
 			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
 				free(newpath);
 				return NULL;
@@ -316,24 +317,21 @@ char *enter_repo(char *path, int strict)
 			 * anyway.
 			 */
 			strcpy(used_path, newpath); free(newpath);
-			strcpy(validated_path, path);
-			path = used_path;
+			strcpy(validated_path, used_path);
 		}
 		else if (PATH_MAX - 10 < len)
 			return NULL;
-		else {
-			path = strcpy(used_path, path);
-			strcpy(validated_path, path);
-		}
-		len = strlen(path);
+		else
+			strcpy(validated_path, used_path);
+		len = strlen(used_path);
 		for (i = 0; suffix[i]; i++) {
-			strcpy(path + len, suffix[i]);
-			if (!access(path, F_OK)) {
+			strcpy(used_path + len, suffix[i]);
+			if (!access(used_path, F_OK)) {
 				strcat(validated_path, suffix[i]);
 				break;
 			}
 		}
-		if (!suffix[i] || chdir(path))
+		if (!suffix[i] || chdir(used_path))
 			return NULL;
 		path = validated_path;
 	}
-- 
1.7.6.355.g842ba.dirty
