From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v3 3/4] enter_repo: do not modify input
Date: Tue, 4 Oct 2011 14:00:29 -0400
Message-ID: <CABURp0raR6dkBJUJOzWvpTcrKobs_kX1e+cM_xJX7qTXVnRjeA@mail.gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
 <1317329963-6656-4-git-send-email-kusmabite@gmail.com> <CABURp0qDsxHwsuyvB6-KvKPrKuUT0-Fpr730TD_TxxFY7fotpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
	gitster@pobox.com, rene.scharfe@lsrfire.ath.cx
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 20:00:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB9IW-0005oi-Aa
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 20:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246Ab1JDSAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 14:00:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41236 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab1JDSAu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 14:00:50 -0400
Received: by wyg34 with SMTP id 34so836390wyg.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eETdNkAOk4bFqhrnwwaPxLispiAMihTieeMHgFPXY8A=;
        b=OtqjyidxOsweP86NEwSFPhZuaSgjZN870OSwLSbnYj3bl03QjMzhFitg4eRSh7E/a1
         +6gaSOA9uTqt1M8zY2k0MEV6Gu98oaVjabOEokLt567Eox6hudXRfLQm1effJdj53p6S
         ur87F/HzIIxPmUpDO1OEcY/osbSWCgaDcfWG8=
Received: by 10.216.157.131 with SMTP id o3mr5317650wek.48.1317751249644; Tue,
 04 Oct 2011 11:00:49 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 11:00:29 -0700 (PDT)
In-Reply-To: <CABURp0qDsxHwsuyvB6-KvKPrKuUT0-Fpr730TD_TxxFY7fotpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182783>

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
 cache.h  |    2 +-
 daemon.c |    4 ++--
 path.c   |   28 ++++++++++++----------------
 3 files changed, 15 insertions(+), 19 deletions(-)

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
