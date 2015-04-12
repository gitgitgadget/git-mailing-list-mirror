From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/7] path.c: implement xdg_config_home()
Date: Sun, 12 Apr 2015 15:46:06 +0800
Message-ID: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 09:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhCbl-0004kk-As
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 09:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbbDLHrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 03:47:04 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36107 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbDLHrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 03:47:03 -0400
Received: by pabsx10 with SMTP id sx10so68408829pab.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=giqcso9NsbYx6Z0zO9x3KOgAv45Q2UA95KHkmVwoh9A=;
        b=U+Fios+1MS5+kz13jGSDR33wVEY3pCjJ5aGBWayu8s3Eyc7JTRKe8fGpvqK+hVrAq9
         CqwuZF/+J6QOB4LunSttE5D3l/Rmeop9zHV5IiJP1zhB9cG/p51QXlMndWHIJ3MpVnrc
         cA0+/id6P8ldD/cp3Pw7s+dmBNEDdf2Uu9QcNOlHG0zLSos82cRAZyCxXCyhWOKraWQ/
         h+MaVxBaotMR2Ux7YGzEyCy4GPDTVymCcRJz6aVjtBknREE9EPXNRHLzA8Hnv2qcvr3h
         TL3AT1jEjBUAKkPy0z/XllXJwhD4MQrCSAcgZSYr3pnCt2BOegJVNA+oIVCLK5ZRe8OY
         F41A==
X-Received: by 10.70.94.67 with SMTP id da3mr16601814pdb.158.1428824822766;
        Sun, 12 Apr 2015 00:47:02 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id ei17sm3783153pac.20.2015.04.12.00.47.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Apr 2015 00:47:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267042>

The XDG base dir spec[1] specifies that configuration files be stored in
a subdirectory in $XDG_CONFIG_HOME. To construct such a configuration
file path, home_config_paths() can be used. However, home_config_paths()
combines distinct functionality:

1. Retrieve the home git config file path ~/.gitconfig

2. Construct the XDG config path of the file specified by `file`.

This function was introduced in commit 21cf3227 ("read (but not write)
from $XDG_CONFIG_HOME/git/config file").  While the intention of the
function was to allow the home directory configuration file path and the
xdg directory configuration file path to be retrieved with one function
call, the hard-coding of the path ~/.gitconfig prevents it from being
used for other configuration files. Furthermore, retrieving a file path
relative to the user's home directory can be done with
expand_user_path(). Hence, it can be seen that home_config_paths()
introduces unnecessary complexity, especially if a user just wants to
retrieve the xdg config file path.

As such, implement a simpler function xdg_config_home() for constructing
the XDG base dir spec configuration file path. This function, together
with expand_user_path(), can replace all uses of home_config_paths().

[1] http://standards.freedesktop.org/basedir-spec/basedir-spec-0.7.html

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 cache.h |  7 +++++++
 path.c  | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/cache.h b/cache.h
index 3d3244b..7f9bab0 100644
--- a/cache.h
+++ b/cache.h
@@ -836,6 +836,13 @@ char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 extern int is_ntfs_dotgit(const char *name);
 
+/**
+ * Returns the newly allocated string "$XDG_CONFIG_HOME/git/%s".  If
+ * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
+ * "$HOME/.config/git/%s". Returns NULL if an error occurred.
+ */
+extern char *xdg_config_home(const char *fn);
+
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
diff --git a/path.c b/path.c
index e608993..4c32d16 100644
--- a/path.c
+++ b/path.c
@@ -856,3 +856,19 @@ int is_ntfs_dotgit(const char *name)
 			len = -1;
 		}
 }
+
+char *xdg_config_home(const char *fn)
+{
+	const char *config_home = getenv("XDG_CONFIG_HOME");
+
+	if (!fn)
+		fn = "";
+	if (!config_home || !config_home[0]) {
+		const char *home = getenv("HOME");
+
+		if (!home)
+			return NULL;
+		return mkpathdup("%s/.config/git/%s", home, fn);
+	} else
+		return mkpathdup("%s/git/%s", config_home, fn);
+}
-- 
2.1.4
