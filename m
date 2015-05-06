From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 7/7] path.c: remove home_config_paths()
Date: Wed,  6 May 2015 16:01:04 +0800
Message-ID: <1430899264-18447-6-git-send-email-pyokagan@gmail.com>
References: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 10:02:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpuHe-00083k-BY
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 10:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbbEFICS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 04:02:18 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35679 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbbEFICL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 04:02:11 -0400
Received: by pdbqd1 with SMTP id qd1so2524864pdb.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+OMZT9zELnBmPmSJRXUeDkobqIujqdJiw5SExLE+mow=;
        b=AIjU/Fyp/YmRzUjFKQb5d0bbdlDfba3/TOiAhj/ENt5QX6Pd5WlEkb8HBbs2SWPFXk
         QFa9MomlImdLAlrGf0R7MskiauKAw/Bk5cRyJKvMzlkUjNMUS3JOfWv9Ry+Gan8t2noh
         jL3U+3eGoCfmWChyDSE1xPvV1iVQLJhbt68yiunlv/g64oyUj3I4e5KaGGbKPx+/oGLV
         qOjiEXB+8Wfb5/i7UHHfjcIHbSLEMCNZVhVcvDk4ytau1/90cj5onXAbEGK7dxrpK8r6
         OFHiyKn9AkJsZz+J4FyQUeZcvXi2w2UwXBpicmgPLETROV9t+mEW/C+2Aw61z+EbyjTb
         EDRQ==
X-Received: by 10.70.51.67 with SMTP id i3mr59064714pdo.145.1430899330494;
        Wed, 06 May 2015 01:02:10 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id cy5sm1074571pdb.85.2015.05.06.01.02.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 May 2015 01:02:09 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
In-Reply-To: <20150421040627.GA5415@yoshi.chippynet.com>
References: <20150421040627.GA5415@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268461>

home_config_paths() combines distinct functionality already implemented
by expand_user_path() and xdg_config_home(), and it also hard-codes the
path ~/.gitconfig, which makes it unsuitable to use for other home
config file paths. Since its use will just add unnecessary complexity to
the code, remove it.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Re-sending the patch series. There are no changes.

 cache.h |  1 -
 path.c  | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/cache.h b/cache.h
index 3512d32..f6970bb 100644
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
index c28b8f5..6b537cc 100644
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
