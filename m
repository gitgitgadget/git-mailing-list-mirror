From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 3/3] Add threaded versions of functions in symlinks.c.
Date: Fri,  2 Mar 2012 21:31:15 -0500
Message-ID: <1dcc783012d179f91c606204bffea9ff8cf2c803.1330740964.git.jaredhance@gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:31:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3elB-0000AS-17
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab2CCCbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:31:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43617 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab2CCCbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:31:37 -0500
Received: by mail-iy0-f174.google.com with SMTP id z16so3102984iag.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:31:37 -0800 (PST)
Received-SPF: pass (google.com: domain of jaredhance@gmail.com designates 10.50.185.138 as permitted sender) client-ip=10.50.185.138;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jaredhance@gmail.com designates 10.50.185.138 as permitted sender) smtp.mail=jaredhance@gmail.com; dkim=pass header.i=jaredhance@gmail.com
Received: from mr.google.com ([10.50.185.138])
        by 10.50.185.138 with SMTP id fc10mr517744igc.48.1330741897193 (num_hops = 1);
        Fri, 02 Mar 2012 18:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=y8k47ZcRIavtDyusDD/rlLS5oxokxxs0i3TUI8iEv8g=;
        b=qagX8kp7HIU0qucf9JfiPzo+j3roqCUieraPXZSLspgi3SR53NZiDBNCiPnlWSrsu5
         Nt76icHozCBSPFDhIAsnh4OwqD1gnLO6z2EZtmKfrqSP8KsLcK2Nvl1N9UlQ8tepVC6b
         Ct/BCT2wmPLsV7c6NlSdq2328oJEWiqOVKDWCwojq+4MnJtBI7Xtrd5ILxixiSUMXK8P
         /m2kvshg9zDQNrjC0tDg1EHm6HxziKmzWRxxvgxjd40Hjer+rkPrcJeET6zR295e0KTN
         X7EnO7DpGd1P9cK1UfTjJJZSyjNVncrLo5YLh+2Biddnqdz9AuDX8kYowaO3aacE+LNL
         cEYg==
Received: by 10.50.185.138 with SMTP id fc10mr433893igc.48.1330741897154;
        Fri, 02 Mar 2012 18:31:37 -0800 (PST)
Received: from localhost.localdomain (cpe-174-101-220-163.cinci.res.rr.com. [174.101.220.163])
        by mx.google.com with ESMTPS id v3sm2578583igw.6.2012.03.02.18.31.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:31:36 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1330740964.git.jaredhance@gmail.com>
In-Reply-To: <cover.1330740964.git.jaredhance@gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192092>

check_leading_patch and has_dirs_only_path both always use the default
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
