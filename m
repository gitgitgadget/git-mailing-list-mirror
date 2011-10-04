From: Phil Hord <phil.hord@gmail.com>
Subject: [PATCH 1/4] enter_repo: do not modify input
Date: Tue, 4 Oct 2011 16:02:00 -0400
Message-ID: <CABURp0rKRb+fZG5erKz08Dz+4d7mjoL842zbcA7uzZ8N5Qtn1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:02:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBCC-0004wA-8X
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933597Ab1JDUCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:02:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65058 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933524Ab1JDUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:02:21 -0400
Received: by wwf22 with SMTP id 22so1373977wwf.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=VnQpAGWdI9bfgAyJT6CtdIVknzVxqS9p5JrR3ee0gl8=;
        b=Zji3idi0am6CiGvLLwU5Z2LMd/RM7lwxt3nAibOb7N4nfsk/uYcfvbv6rjTwBI3ydC
         9d71kZUhMjK5d93aGcSJgSOXuzzeysfD13I8Zgnn77upS6LffPG0yDtE6Cfghh0xLMqG
         4Zut/TuqYNR7XjWqjxEJL5ewm+vKNU3m9Fi9g=
Received: by 10.216.138.221 with SMTP id a71mr2031645wej.102.1317758540081;
 Tue, 04 Oct 2011 13:02:20 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 13:02:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182791>

From: Erik Faye-Lund <kusmabite@gmail.com>

entr_repo(..., 0) currently modifies the input to strip away
trailing slashes. This means that we some times need to copy the
input to keep the original.

Change it to unconditionally copy it into the used_path buffer so
we can safely use the input without having to copy it. Also store
a working copy in validated_path up-front before we start
resolving anything.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Phil Hord <hordp@cisco.com>
---
This is Erik Faye-Lund's patch with some minor cleanup by me.  I sent
this to the list earlier today for Erik, but I'm including it here
again as part of this series.  Not sure what the etiquette is on this,
but this way seemed safest.

diff --git a/cache.h b/cache.h
index 9994a3c..7eeb8cf 100644
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
@@ -108,11 +108,11 @@ static void NORETURN daemon_die(const char *err,
va_list params)
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
index 6f3f5d5..01028f2 100644
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
@@ -297,14 +297,16 @@ char *enter_repo(char *path, int strict)
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
+		strncpy(used_path, path, len); used_path[len] = 0 ;
+		strcpy(validated_path, used_path);
+
+		if (used_path[0] == '~') {
+			char *newpath = expand_user_path(used_path);
 			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
 				free(newpath);
 				return NULL;
@@ -316,24 +318,18 @@ char *enter_repo(char *path, int strict)
 			 * anyway.
 			 */
 			strcpy(used_path, newpath); free(newpath);
-			strcpy(validated_path, path);
-			path = used_path;
 		}
 		else if (PATH_MAX - 10 < len)
 			return NULL;
-		else {
-			path = strcpy(used_path, path);
-			strcpy(validated_path, path);
-		}
-		len = strlen(path);
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
1.7.7.503.g26392.dirty
