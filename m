From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] dir: remove dead code
Date: Sun,  8 Sep 2013 11:39:23 +0530
Message-ID: <1378620563-32709-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 08:15:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIYHW-0006PF-US
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 08:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab3IHGPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 02:15:31 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55773 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab3IHGPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 02:15:30 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so4907700pdj.11
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 23:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=wnzlsKmSsgwi6JhE7Y7XD8Arggqjv57xxHVsASqiNjA=;
        b=NQDPFjGZtOpm/wUM6QdxUjmW9/ZL1ig7h+DxhMVjwrrefZfR4TedDMAquD8TMSLs+I
         u55sOQ8r90cOuQCjg50sf5d7i1H5mk0JZ3oaQRZyG7Rqggza/q83OZrnb6dpopEb32Sg
         Oo4plhuS0jKtUmacNRrMIOG4HAlEi/lQkSCFIJTmII+MqwW6o6LjxHTrKVqNqYvAnCCJ
         PH/MdaWD3u45pd/+COw8dAEM1ltOOqmnv9OUV3gIXmbC4u6bRgCXYZwXh+Vh53vDELbI
         EWZYC5Hq26n4tsbAHS4ZIk9ejTlld8WOQFwOVr6UVAfTIIZn0IHfYT3SfXxCDD3zQk72
         s3EA==
X-Received: by 10.66.121.131 with SMTP id lk3mr13102018pab.61.1378620930341;
        Sat, 07 Sep 2013 23:15:30 -0700 (PDT)
Received: from localhost.localdomain ([122.164.84.79])
        by mx.google.com with ESMTPSA id j9sm8977474paj.18.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 23:15:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.100.gde18f6d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234188>

Remove dead code around remove_dir_recursively().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 dir.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index 910bfcd..2b31241 100644
--- a/dir.c
+++ b/dir.c
@@ -1464,11 +1464,11 @@ int is_empty_dir(const char *path)
 	return ret;
 }
 
-static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
+int remove_dir_recursively(struct strbuf *path, int flag)
 {
 	DIR *dir;
 	struct dirent *e;
-	int ret = 0, original_len = path->len, len, kept_down = 0;
+	int ret = 0, original_len = path->len, len;
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
 	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
 	unsigned char submodule_head[20];
@@ -1476,8 +1476,6 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
 	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
 		/* Do not descend and nuke a nested git work tree. */
-		if (kept_up)
-			*kept_up = 1;
 		return 0;
 	}
 
@@ -1504,7 +1502,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (!remove_dir_recurse(path, flag, &kept_down))
+			if (!remove_dir_recursively(path, flag))
 				continue; /* happy */
 		} else if (!only_empty && !unlink(path->buf))
 			continue; /* happy, too */
@@ -1516,22 +1514,11 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	closedir(dir);
 
 	strbuf_setlen(path, original_len);
-	if (!ret && !keep_toplevel && !kept_down)
+	if (!ret && !keep_toplevel)
 		ret = rmdir(path->buf);
-	else if (kept_up)
-		/*
-		 * report the uplevel that it is not an error that we
-		 * did not rmdir() our directory.
-		 */
-		*kept_up = !ret;
 	return ret;
 }
 
-int remove_dir_recursively(struct strbuf *path, int flag)
-{
-	return remove_dir_recurse(path, flag, NULL);
-}
-
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
-- 
1.8.4.100.gde18f6d.dirty
