From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 3/4] enter_repo: do not modify input
Date: Mon, 18 Jul 2011 20:08:35 +0200
Message-ID: <1311012516-4836-4-git-send-email-kusmabite@gmail.com>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 20:09:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QisFa-0006Ch-LX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 20:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208Ab1GRSIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 14:08:53 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:35701 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1GRSIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:08:52 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so7013726fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=z3hwNX6z3lgpMkYcL6/lKoBX81qPbzLwfFfpbpA8Tf4=;
        b=Y/wnNsRqhRgblfSTwj+GcikjFScSe1PJTVFc57Uicv6Lzd65R28lBLsl+5IQMuyNp4
         13fFy9ArkEkXEiFAomguCcX3EL4sp1/bMy3+Bb2pwHB+ggoGRFTDF26CXn3MHU3W6Yj3
         d84VzXZWxa+Q2LlMisJhn3tlbuK1BVn3s3Pzg=
Received: by 10.223.97.131 with SMTP id l3mr10485142fan.43.1311012531448;
        Mon, 18 Jul 2011 11:08:51 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 9sm3086628far.13.2011.07.18.11.08.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 11:08:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.4055.gbf1a7
In-Reply-To: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177393>

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
index bc9e5eb..02386f1 100644
--- a/cache.h
+++ b/cache.h
@@ -716,7 +716,7 @@ int safe_create_leading_directories(char *path);
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
index 4d73cc9..2757d8b 100644
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
1.7.6.135.g378e9
