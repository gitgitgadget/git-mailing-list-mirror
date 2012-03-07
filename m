From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v3 2/3] Add threaded versions of functions in symlinks.c.
Date: Wed,  7 Mar 2012 17:21:26 -0500
Message-ID: <5acf65ff331b28196c9781c39d1d00c3f8a733a4.1331158240.git.jaredhance@gmail.com>
References: <cover.1331158240.git.jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 23:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5PEu-0004ug-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757654Ab2CGWVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 17:21:40 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37079 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755025Ab2CGWVj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 17:21:39 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id uo6so7476933obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 14:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=gyqfpbpmpleEgl1vXE1n6bWXobaW93XTrNK7/h1UWIc=;
        b=0an0u0t7+q6ySDv1K6GdHPyKVD6diFqcZHX7rfEi0AJQIE2nFnDcZQb8e+1XfWDG5n
         6ltCC4YhcE92baDRpddcLqT39fAsNMba7eHNRxqjNazdASrK6OovjuNBMb6NAIuQD0j3
         Nvg8K+n9pv2rastyW5i8xXcerMJnjUjqFig7XdUYzoHnJQ33dI4wkym2WhNuRtnhsWhR
         LH4UCN+Qn6YOhY9g/4jjtF+TxZ73pApJmNQ/aVoJaAV4j01E9+GPmaMAHpT/bUqtuq8n
         /jmuV0UwtDwbvkya6HdBfbl94yQu9sMlS01zZgUU/UeKF9pZpMGGkf4yntwsb1c6DuaV
         cI8w==
Received: by 10.182.147.106 with SMTP id tj10mr1408104obb.71.1331158899621;
        Wed, 07 Mar 2012 14:21:39 -0800 (PST)
Received: from localhost.localdomain (mail.middletownlibrary.org. [66.213.99.6])
        by mx.google.com with ESMTPS id gl4sm23853230obb.23.2012.03.07.14.21.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 14:21:38 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1331158240.git.jaredhance@gmail.com>
In-Reply-To: <cover.1331158240.git.jaredhance@gmail.com>
References: <cover.1331158240.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192494>

check_leading_path and has_dirs_only_path both always use the default
cache, which could be a caveat for adding parallelism (which is a
concern and even a GSoC proposal). This patch implements
threaded_check_leading_path and threading threaded_has_dirs_only_path
and then implements the nonthreaded functions in terms of their threaded
equivalents. No functional should be changed.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 cache.h    |    2 ++
 symlinks.c |   28 ++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index e12b15f..e5e1aa4 100644
--- a/cache.h
+++ b/cache.h
@@ -950,7 +950,9 @@ struct cache_def {
 extern int has_symlink_leading_path(const char *name, int len);
 extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
 extern int check_leading_path(const char *name, int len);
+extern int threaded_check_leading_path(struct cache_def *cache, const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
+extern int threaded_has_dirs_only_path(struct cache_def *cache, const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
diff --git a/symlinks.c b/symlinks.c
index 034943b..2900367 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -219,7 +219,20 @@ int has_symlink_leading_path(const char *name, int len)
  */
 int check_leading_path(const char *name, int len)
 {
-	struct cache_def *cache = &default_cache;	/* FIXME */
+    return threaded_check_leading_path(&default_cache, name, len);
+}
+
+/*
+ * Return zero if path 'name' has a leading symlink component or
+ * if some leading path component does not exists.
+ *
+ * Return -1 if leading path exists and is a directory.
+ *
+ * Return path length if leading path exists and is neither a
+ * directory nor a symlink.
+ */
+int threaded_check_leading_path(struct cache_def *cache, const char *name, int len)
+{
 	int flags;
 	int match_len = lstat_cache_matchlen(cache, name, len, &flags,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
@@ -240,7 +253,18 @@ int check_leading_path(const char *name, int len)
  */
 int has_dirs_only_path(const char *name, int len, int prefix_len)
 {
-	struct cache_def *cache = &default_cache;	/* FIXME */
+	return threaded_has_dirs_only_path(&default_cache, name, len, prefix_len);
+}
+
+/*
+ * Return non-zero if all path components of 'name' exists as a
+ * directory.  If prefix_len > 0, we will test with the stat()
+ * function instead of the lstat() function for a prefix length of
+ * 'prefix_len', thus we then allow for symlinks in the prefix part as
+ * long as those points to real existing directories.
+ */
+int threaded_has_dirs_only_path(struct cache_def *cache, const char *name, int len, int prefix_len)
+{
 	return lstat_cache(cache, name, len,
 			   FL_DIR|FL_FULLPATH, prefix_len) &
 		FL_DIR;
-- 
1.7.3.4
