From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH/RFC/GSoC 1/3] path.c: implement xdg_runtime_dir()
Date: Wed, 16 Mar 2016 18:07:43 +0800
Message-ID: <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 11:08:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag8NV-0007Ey-79
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 11:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966017AbcCPKI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 06:08:28 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33227 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934654AbcCPKI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 06:08:26 -0400
Received: by mail-pf0-f170.google.com with SMTP id 124so69530002pfg.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uH37TmA4foMc70kCOWiW1Pnok3ZpdxXSnteRbWvWwQU=;
        b=ulk2Cd23C80MCWeEbI6oZYrnfqPZnBb4g1TIChM7+HXz0jQuIBX57Aes+M7CK4GuD9
         94pk3Mh5SXapIeOoppNRm5+6uwJprkahzyTmtf9Kdh66THOndqm0VJIHlofnBul6g6OM
         2KtIMqC6lamQbuF3MlTnti7Urw7g1VVk8XXPZ8IEu/FevtBWQf7GJouowqOEQ/SbvZir
         kXSymQe1irs+qqgg49RaI1WkOLhS/+JB4bs8643Y4mkBWhwz5EDeyDU4ayAfAJtt2U86
         wMS/16EKt2A5AEB/qIYQt+EfMVOKAWuDlwT7ilVyHPp34uJFCscH9JL873RvUnjiV6co
         9YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uH37TmA4foMc70kCOWiW1Pnok3ZpdxXSnteRbWvWwQU=;
        b=TTHrJlf9Rggiliu+mtg3AzpglOrpBlS+5bPUztrP0xVtkijH2W49nEXlpAG2+khyFv
         WItdvHgoblmmYtKWuocWX+nxWH9imBFq+Ayv+Lrky5zMcmE9LYV1TpFoA0bQZGW3CBat
         sW23odUcEAgwUtxTfgrAQeSHAQLoFMkLdfHnd9j0ix1jgd8u5prwgDF3EK6iWWbhrixJ
         aJxhLf779wRgk8bJjpJaT+60sFFTl5jKkTGEpwTN3y2dv1QDMZ+/M48FGC283ylTF4x/
         LbNTkxx4AtBfk7FvYXu+ZiHH0hoL160NDoJu1pe5u57EOFauRxRK1P5wtPogtU3Nz8/5
         mWOQ==
X-Gm-Message-State: AD7BkJKFdGMAYvgt7EYydiK6khuTE8PS8Ud1l7zIC3A+cfJWZwV3Lh92wpa/KNYiqeWT6A==
X-Received: by 10.66.55.70 with SMTP id q6mr4414388pap.126.1458122905789;
        Wed, 16 Mar 2016 03:08:25 -0700 (PDT)
Received: from Saturn.localdomain ([128.199.68.97])
        by smtp.gmail.com with ESMTPSA id n68sm4275755pfj.46.2016.03.16.03.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 03:08:25 -0700 (PDT)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288952>

this function does the following:

1. if $XDG_RUNTIME_DIR is non-empty, `$XDG_RUNTIME_DIR/git` is used in next
step, otherwise `/tmp/git-$uid` is taken.
2. ensure that above directory does exist. what's more, it must has correct
permission and ownership.
3. a newly allocated string consisting of the path of above directory and
$filename is returned.

Under following situation, NULL will be returned:
+ the directory mentioned in step 1 exists but have wrong permission or
ownership.
+ the directory or its parent cannot be created.

Notice:

+ the caller is responsible for deallocating the returned string.

Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 cache.h | 23 +++++++++++++++++++++++
 path.c  | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/cache.h b/cache.h
index b829410..e640a54 100644
--- a/cache.h
+++ b/cache.h
@@ -999,6 +999,29 @@ extern int is_ntfs_dotgit(const char *name);
  */
 extern char *xdg_config_home(const char *filename);
 
+/**
+ * this function does the following:
+ *
+ * 1. if $XDG_RUNTIME_DIR is non-empty, `$XDG_RUNTIME_DIR/git` is used in next
+ * step, otherwise `/tmp/git-$uid` is taken.
+ * 2. ensure that above directory does exist. what's more, it must has correct
+ * permission and ownership.
+ * 3. a newly allocated string consisting of the path of above directory and
+ * $filename is returned.
+ *
+ * Under following situation, NULL will be returned:
+ *
+ * + the directory mentioned in step 1 exists but have wrong permission or
+ * ownership.
+ * + the directory or its parent cannot be created.
+ *
+ * Notice:
+ *
+ * + the caller is responsible for deallocating the returned string.
+ *
+ */
+extern char *xdg_runtime_dir(const char *filename);
+
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
 #define LOOKUP_UNKNOWN_OBJECT 2
diff --git a/path.c b/path.c
index 8b7e168..2deecb3 100644
--- a/path.c
+++ b/path.c
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
+#include "git-compat-util.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -1193,6 +1194,64 @@ char *xdg_config_home(const char *filename)
 	return NULL;
 }
 
+char *xdg_runtime_dir(const char *filename)
+{
+	char *runtime_dir, *git_runtime_dir;
+	struct stat st;
+	uid_t uid = getuid();
+
+	assert(filename);
+	runtime_dir = getenv("XDG_RUNTIME_DIR");
+	if (runtime_dir && *runtime_dir)
+		git_runtime_dir = mkpathdup("%s/git/", runtime_dir);
+	else
+		git_runtime_dir = mkpathdup("/tmp/git-%d", uid);
+
+	if (!lstat(git_runtime_dir, &st)) {
+		/*
+		 * As described in XDG base dir spec[1], the subdirectory
+		 * under $XDG_RUNTIME_DIR or its fallback MUST be owned by
+		 * the user, and its unix access mode MUST be 0700.
+		 *
+		 * Calling chmod or chown silently may cause security
+		 * problem if somebody chdir to it, sleep, and then, try
+		 * to open our protected runtime cache or socket.
+		 * So we just put warning and left it to user to solve.
+		 *
+		 * [1]https://specifications.freedesktop.org/basedir-spec/
+		 * basedir-spec-latest.html
+		 */
+		if ((st.st_mode & 0777) != S_IRWXU) {
+			fprintf(stderr,
+					"permission of runtime directory '%s' "
+					"MUST be 0700 instead of 0%o\n",
+					git_runtime_dir, (st.st_mode & 0777));
+			return NULL;
+		} else if (st.st_uid != uid) {
+			fprintf(stderr,
+					"owner of runtime directory '%s' "
+					"MUST be %d instead of %d\n",
+					git_runtime_dir, uid, st.st_uid);
+			return NULL;
+		}
+		/* TODO: check whether git_runtime_dir is an directory */
+	} else {
+		if (safe_create_leading_directories_const(git_runtime_dir) < 0) {
+			fprintf(stderr,
+					"unable to create directories for '%s'\n",
+					git_runtime_dir);
+			return NULL;
+		}
+		if (mkdir(git_runtime_dir, 0700) < 0) {
+			fprintf(stderr,
+					"unable to mkdir '%s'\n", git_runtime_dir);
+			return NULL;
+		}
+	}
+	free(git_runtime_dir);
+	return mkpathdup("%s/%s", git_runtime_dir, filename);
+}
+
 GIT_PATH_FUNC(git_path_cherry_pick_head, "CHERRY_PICK_HEAD")
 GIT_PATH_FUNC(git_path_revert_head, "REVERT_HEAD")
 GIT_PATH_FUNC(git_path_squash_msg, "SQUASH_MSG")
-- 
2.7.2
