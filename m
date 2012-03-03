From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v2 3/3] Add threaded versions of functions in symlinks.c.
Date: Sat,  3 Mar 2012 09:40:30 -0500
Message-ID: <e86eea36804fcf764ba9c3940a3cceb13b5a2c4b.1330785363.git.jaredhance@gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com>
Cc: gitster@pobox.com, Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 15:41:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3q9D-0000Yu-OO
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 15:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735Ab2CCOlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 09:41:15 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38321 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab2CCOlN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 09:41:13 -0500
Received: by mail-iy0-f174.google.com with SMTP id z16so3544384iag.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 06:41:13 -0800 (PST)
Received-SPF: pass (google.com: domain of jaredhance@gmail.com designates 10.50.11.200 as permitted sender) client-ip=10.50.11.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jaredhance@gmail.com designates 10.50.11.200 as permitted sender) smtp.mail=jaredhance@gmail.com; dkim=pass header.i=jaredhance@gmail.com
Received: from mr.google.com ([10.50.11.200])
        by 10.50.11.200 with SMTP id s8mr1797890igb.42.1330785673482 (num_hops = 1);
        Sat, 03 Mar 2012 06:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=6Jo/sxolC2tZF3M0J5rZtW0TnbVhWpAz0+RQVvZ2E9Y=;
        b=H1Rv+X7zRj7XSP2twbUdSrvRj3ny0QqH41yE+qvQEe12Df+520agcdhSwzNReHeCZc
         uPbOSVCl2XG3V6RHGNvv38hTPq7rBi0NhHriCrxXhDjjGOZQAGeyibmgnuHhtJYmLDRW
         Dmt1yuQ5P4Ze5s7TQ2Bfy4RsjAbYkFidPRdXSm86jMp4Tib7YYInkg/Q1NeLJTHc/Z1b
         NTWiGUVa7VX9hRagP6IWaa5EttWNlASEoo5tSK/MLsclWRIf7X4Gj57J+uSDdsUSraJA
         swMQg+5wEHUFgXWzx6pYfjRu5MNxIsVPIqlxfpQyQwpuRtkCqbUyL0QvbMZ9epnnsyyC
         hvyw==
Received: by 10.50.11.200 with SMTP id s8mr1494284igb.42.1330785673447;
        Sat, 03 Mar 2012 06:41:13 -0800 (PST)
Received: from localhost.localdomain (cpe-174-101-220-163.cinci.res.rr.com. [174.101.220.163])
        by mx.google.com with ESMTPS id b6sm5212250igj.7.2012.03.03.06.41.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 06:41:12 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1330740964.git.jaredhance@gmail.com>
In-Reply-To: <cover.1330785363.git.jaredhance@gmail.com>
References: <cover.1330785363.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192113>

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
index baa8852..1113296 100644
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
