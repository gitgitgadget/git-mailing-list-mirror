From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 7/7] path.c: remove home_config_paths()
Date: Sun, 12 Apr 2015 15:46:12 +0800
Message-ID: <1428824772-8736-7-git-send-email-pyokagan@gmail.com>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 09:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhCc2-0004v8-0k
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 09:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbbDLHrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 03:47:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36331 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbDLHrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 03:47:18 -0400
Received: by pabsx10 with SMTP id sx10so68412709pab.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 00:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l3c3VafqqmxVD25i5reBBcHKmtIm8i4HHUr9A4acam8=;
        b=uNKYhX7YM8Xy3G6bjneh9drfnhChYFwMPQKqK+LrZJ9sq72ItLtV7pAqU7E5OuZI+r
         bTN9n4i3WY8QrR8P5rXBT88FeK/DzI9kacGvhaHkXLqwMCBSDaw6Ef4INrX4YgWM03ux
         2GA58+u7hzhUKC3URcfy+yR8PoWeg24rvZ0y/hmZW4Y2kvTQ8AJrUJ3f7FL1vLoWR6iV
         w7+bWP/FcuUfFjoLNlZckguzo3k7HQssRXv1BKQUDBh0dl40jjvH2aHTW4u5Wz+FTl1S
         IgCiU8PUFO4iqaIjzXphFPjjiU9d10zh2efbWsfGKOtUFUrcrGsDd1EI50QiC1Bwpe31
         zd9A==
X-Received: by 10.70.138.105 with SMTP id qp9mr16425435pdb.67.1428824837757;
        Sun, 12 Apr 2015 00:47:17 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id ei17sm3783153pac.20.2015.04.12.00.47.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Apr 2015 00:47:16 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267044>

home_config_paths() combines distinct functionality already implemented
by expand_user_path() and xdg_config_home(), and it also hard-codes the
path ~/.gitconfig, which makes it unsuitable to use for other home
config file paths. Since its use will just add unnecessary complexity to
the code, remove it.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 cache.h |  1 -
 path.c  | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/cache.h b/cache.h
index 7f9bab0..19d75ef 100644
--- a/cache.h
+++ b/cache.h
@@ -816,7 +816,6 @@ enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
 
 int mkdir_in_gitdir(const char *path);
-extern void home_config_paths(char **global, char **xdg, char *file);
 extern char *expand_user_path(const char *path);
 const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
diff --git a/path.c b/path.c
index 4c32d16..84ec589 100644
--- a/path.c
+++ b/path.c
@@ -130,34 +130,6 @@ char *git_path(const char *fmt, ...)
 	return ret;
 }
 
-void home_config_paths(char **global, char **xdg, char *file)
-{
-	char *xdg_home = getenv("XDG_CONFIG_HOME");
-	char *home = getenv("HOME");
-	char *to_free = NULL;
-
-	if (!home) {
-		if (global)
-			*global = NULL;
-	} else {
-		if (!xdg_home) {
-			to_free = mkpathdup("%s/.config", home);
-			xdg_home = to_free;
-		}
-		if (global)
-			*global = mkpathdup("%s/.gitconfig", home);
-	}
-
-	if (xdg) {
-		if (!xdg_home)
-			*xdg = NULL;
-		else
-			*xdg = mkpathdup("%s/git/%s", xdg_home, file);
-	}
-
-	free(to_free);
-}
-
 char *git_path_submodule(const char *path, const char *fmt, ...)
 {
 	char *pathname = get_pathname();
-- 
2.1.4
