From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v2/GSoC 2/4] path.c: implement xdg_runtime_dir()
Date: Fri, 18 Mar 2016 00:48:44 +0800
Message-ID: <1458233326-7735-2-git-send-email-huiyiqun@gmail.com>
References: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 17:49:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agb74-0007tk-H5
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 17:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935758AbcCQQt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 12:49:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33636 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbcCQQtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 12:49:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id x3so11831826pfb.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ts5EGes7via+TbDH59Wed49dIliKMfmmR5ncqvjjLUg=;
        b=Leks0NUMtCvlKIGiyrD1lxBnr3DalPstXiDL6YsPSbbc8PH395SS/FpMkx51qE9rAS
         jviUWQBaXUCjlt4eaFFb13eBowoOa2r2uEEMyLqmuvCfeBD4+8B2wh2R9uZdow4WVFeT
         wewDgxi+7LrTpLLepwmBwe4JE2JA78CWAzYSabDJpdCurFMIwirnhZSezav4Y8UuJaxU
         9ChUq+KNokotqDkQT6sXHAV/lctvwVetysYXAdSkHzi9MJYC3AHDadmBPiQBcArsMT+3
         NytGMGkuf8S9BMp3R6sElybed8/xJE8yKxQdxskkgo0KM4VbbJsQL4HYSo/u0RsAxHQm
         gAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ts5EGes7via+TbDH59Wed49dIliKMfmmR5ncqvjjLUg=;
        b=MY6FNb+5qd17inSu7YvuSvuh/xfFdJH5YXTjxY1bRH4h9XHf1KUaGJav+sRe+nLoAj
         pIqjlyV1UvBdZ63JhOJDRwSg0ay0nCJmW8Dvxj2bHh2z/uq67WkOFT7N9DoQEHnmF1EE
         Y/00ddtFPJEinwdHqJRYkTREv5tgUWxj2alJMVDW+7h3Cxb3McO8N4XLBiyG2PYu4fvL
         eQgb2Di2a3mj6OXo9wTzbP7CfGS0k5cHZJiSPKKtrVDauUbCGfunFtyDQN7SrOEgXB3Y
         +OHOOZaqayAuif0WYHm3iIJBhlC5JPcyJLm/FOFNK1wDsvAst5re1eNdbKy7MO9D9MAa
         fnLg==
X-Gm-Message-State: AD7BkJL4XRQYZfyesPc7UMWr8YfrsjkT0tb2Tt5fik4wxLStNUT9PKu3rFBMXeHJLx/kRQ==
X-Received: by 10.66.123.17 with SMTP id lw17mr16580541pab.108.1458233364756;
        Thu, 17 Mar 2016 09:49:24 -0700 (PDT)
Received: from localhost.localdomain (hashi.inv.dotkrnl.com. [133.130.122.94])
        by smtp.gmail.com with ESMTPSA id kw10sm14643290pab.0.2016.03.17.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 09:49:24 -0700 (PDT)
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289124>

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
 path.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/cache.h b/cache.h
index ef843c1..f8b649b 100644
--- a/cache.h
+++ b/cache.h
@@ -1001,6 +1001,29 @@ extern int is_ntfs_dotgit(const char *name);
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
index 699af68..2886e59 100644
--- a/path.c
+++ b/path.c
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
+#include "git-compat-util.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -1206,6 +1207,61 @@ char *xdg_config_home(const char *filename)
 	return NULL;
 }
 
+char *xdg_runtime_dir(const char *filename)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char *runtime_dir;
+	struct stat st;
+	uid_t uid = getuid();
+
+	assert(filename);
+	runtime_dir = getenv("XDG_RUNTIME_DIR");
+	if (runtime_dir && *runtime_dir)
+		strbuf_mkpath(&sb, "%s/git/", runtime_dir);
+	else
+		strbuf_mkpath(&sb, "/tmp/git-%d", uid);
+
+	if (!lstat(sb.buf, &st)) {
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
+			warning("permission of runtime directory '%s' "
+					"MUST be 0700 instead of 0%o\n",
+					sb.buf, (st.st_mode & 0777));
+			return NULL;
+		} else if (st.st_uid != uid) {
+			warning("owner of runtime directory '%s' "
+					"MUST be %d instead of %d\n",
+					sb.buf, uid, st.st_uid);
+			return NULL;
+		}
+		/* TODO: check whether st.buf is an directory */
+	} else {
+		if (safe_create_leading_directories_const(sb.buf) < 0) {
+			warning("unable to create directories for '%s'\n",
+					sb.buf);
+			return NULL;
+		}
+		if (mkdir(sb.buf, 0700) < 0) {
+			warning("unable to mkdir '%s'\n", sb.buf);
+			return NULL;
+		}
+	}
+	strbuf_addf(&sb, "/%s", filename);
+	return strbuf_detach(&sb, NULL);
+}
+
 GIT_PATH_FUNC(git_path_cherry_pick_head, "CHERRY_PICK_HEAD")
 GIT_PATH_FUNC(git_path_revert_head, "REVERT_HEAD")
 GIT_PATH_FUNC(git_path_squash_msg, "SQUASH_MSG")
-- 
2.7.3
