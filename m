From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Wed, 23 Mar 2016 18:13:22 +0800
Message-ID: <1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Cc: peff@peff.net, pickfire@riseup.net, Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 11:16:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifnP-000210-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbcCWKNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:13:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35345 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbcCWKNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:13:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id u190so2389680pfb.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iNvfs/KzIFX4Fl3FCGsP+JDe9gRKKOcWmxsbe+qYDpU=;
        b=hEdFhRPjh6W1gzO4jWxr7MVq4cQtKVEKX768V6+DILySkl0zJ5K1hHFFuOrqsk5P75
         zDEM44gYgg/AatfWQ/Gu0O4LwYrmRlEtNk/vEXK6gKup7POhyul3xAg9lSDsV6twr0wJ
         gqyKPTVRWiCP+5d/5kiHYYUXIPtxFF5Ru8vpC2+5gCH4G5egfcwOQyiLO003L5sEZKRz
         PkYKXAHrIpHjNy27bNqhJJjLCmpZnTXgX9DVdGv/sLDqxQKaLJ+sVyOm2fgCaH37bI0o
         /mF8LkybMiVo6Hj+A+GLsBc/SK5Y3vsRtWPRMzg97XNMLKGccnxpypB+TmGPyfBtsA6D
         b/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iNvfs/KzIFX4Fl3FCGsP+JDe9gRKKOcWmxsbe+qYDpU=;
        b=CSDs0jXyZvMlMfAtGd492J8ZqG0fLoTjlG61EzB7FrjMzq24ia0ZFPTna2eAePz8pI
         U/xqBbbODCGBK/iBxvVOlNgBjZNuy6xOK9iiLUwwKtgsnT/IeAaguxh8v1mU31yF2Z0B
         MLhxgKeFUlT7Av8h3uVVP+Tnd8YNu5fTxWa6lvO0jNEnc8qLJl/GrTVCKL10zoRxvteG
         UUJw2JHsMsHe6cQODO/2n1d2qaYFH4nTWRIKIYLQeASxYePKya5jcEov3h/P3UzjfmmN
         aqUNyubsCbcRtMu9o6kfOCz4sU537zAwEioorQSySP+yMjd6b0unKwQNnxspLTm44jkk
         A/pA==
X-Gm-Message-State: AD7BkJKafHJ5in0zZi9F0loPX4tIC35NgHKJekYdvWmkLsUy/zB7qr9bGVo99Ut59c/BmQ==
X-Received: by 10.98.16.150 with SMTP id 22mr2887408pfq.128.1458728015059;
        Wed, 23 Mar 2016 03:13:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:ae9e:17ff:fe87:5adb])
        by smtp.gmail.com with ESMTPSA id x18sm3232325pfi.42.2016.03.23.03.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 03:13:34 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289628>

This function is aimed to provide an uniform location to put
runtime files according to the xdg base dir spec[1] and stop using
$HOME. On the other hand, the safety is considered(with directory
permission).

This function will use `$XDG_RUNTIME_DIR/git` if XDG_RUNTIME_DIR exists,
otherwise `/tmp/git-$uid`.

The existence and the permission of the directory is ensured. However,
if the directory or its parents cannot be created or the directory exists
but have wrong permission, this function will give a warning and return NULL
for security.

[1] https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

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
2.7.4
