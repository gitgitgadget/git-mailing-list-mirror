From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 5/5] do not overwrite files in leading path
Date: Sat,  9 Oct 2010 15:53:00 +0200
Message-ID: <1286632380-7002-6-git-send-email-drizzd@aon.at>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 15:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Zs0-0003Wg-9W
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 15:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760277Ab0JINxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 09:53:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36689 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab0JINxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 09:53:05 -0400
Received: by bwz15 with SMTP id 15so854494bwz.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w+ioLSnViNgBsKt4YCqKYJOyj9lVghtqZNhL1Y6KRa4=;
        b=rxGTvPIuNCKrlrFn3sNQ+cHEoIcOiajorhPlElepXMOfsU4JtWBXZ9R9cbAA7e5b2X
         YqkHbc4evwthFfe+Z5koZACFq0N6wI+xtzC6DkrXFfCBsJpfwHnC9L3ACX/+QvL1QHjK
         JdnL6fysqsw9IXIY7h/96sIXSjaJRz+Ui1ZYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=hOW1R+JUHZJTrGBQmzn2IAc9+xIoFGKFMIjESo+/LbP2F4w3O8i75PMS6dnH+fgO02
         +uUoHG6+GHEAtKKKEnlYJvFvy8vwsC1snkjBw2j5i85Sv38DXsR0h7PD+LSuwZUJ0jAO
         Vf80m+RWXRTu37Ar9uv0rnrZo5DQMl4gUUkBI=
Received: by 10.204.112.129 with SMTP id w1mr3193017bkp.204.1286632384075;
        Sat, 09 Oct 2010 06:53:04 -0700 (PDT)
Received: from darc.lan (p549A51C3.dip.t-dialin.net [84.154.81.195])
        by mx.google.com with ESMTPS id a25sm1731921bks.20.2010.10.09.06.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 06:53:02 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4ZrN-0001si-9A; Sat, 09 Oct 2010 15:53:13 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158591>

If the work tree contains an untracked file x, and
unpack-trees wants to checkout a path x/*, the
file x is removed unconditionally.

Instead, apply the same checks that are normally
used for untracked files, and abort if the file
cannot be removed.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

It's not exactly pretty. But it's the best solution I could find
without major refactoring.

Clemens

 cache.h                    |    2 +-
 symlinks.c                 |   21 ++++++++++++++++-----
 t/t7607-merge-overwrite.sh |    2 +-
 unpack-trees.c             |   16 +++++++++++++---
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 2ef2fa3..f65d6f9 100644
--- a/cache.h
+++ b/cache.h
@@ -852,7 +852,7 @@ struct cache_def {
 
 extern int has_symlink_leading_path(const char *name, int len);
 extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
-extern int has_symlink_or_noent_leading_path(const char *name, int len);
+extern int check_leading_path(const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
diff --git a/symlinks.c b/symlinks.c
index b7343eb..3cacebd 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -209,15 +209,26 @@ int has_symlink_leading_path(const char *name, int len)
 }
 
 /*
- * Return non-zero if path 'name' has a leading symlink component or
+ * Return zero if path 'name' has a leading symlink component or
  * if some leading path component does not exists.
+ *
+ * Return -1 if leading path exists and is a directory.
+ *
+ * Return path length if leading path exists and is neither a
+ * directory nor a symlink.
  */
-int has_symlink_or_noent_leading_path(const char *name, int len)
+int check_leading_path(const char *name, int len)
 {
 	struct cache_def *cache = &default_cache;	/* FIXME */
-	return lstat_cache(cache, name, len,
-			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT) &
-		(FL_SYMLINK|FL_NOENT);
+	int flags;
+	int match_len = lstat_cache_matchlen(cache, name, len, &flags,
+			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
+	if (flags & (FL_SYMLINK|FL_NOENT))
+		return 0;
+	else if (flags & FL_DIR)
+		return -1;
+	else
+		return match_len;
 }
 
 /*
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 01b070b..412db15 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -100,7 +100,7 @@ test_expect_success 'will not overwrite untracked subtree' '
 	test_cmp important sub/f/important
 '
 
-test_expect_failure 'will not overwrite untracked file in leading path' '
+test_expect_success 'will not overwrite untracked file in leading path' '
 	git reset --hard c0 &&
 	rm -rf sub &&
 	cp important sub &&
diff --git a/unpack-trees.c b/unpack-trees.c
index df1c920..6816113 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -182,7 +182,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
  */
 static void unlink_entry(struct cache_entry *ce)
 {
-	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
+	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
 		return;
@@ -1194,18 +1194,28 @@ static int verify_absent_1(struct cache_entry *ce,
 				 enum unpack_trees_error_types error_type,
 				 struct unpack_trees_options *o)
 {
+	int len;
 	struct stat st;
 
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
+	len = check_leading_path(ce->name, ce_namelen(ce));
+	if (!len)
 		return 0;
+	else if (len > 0) {
+		char path[PATH_MAX + 1];
+		memcpy(path, ce->name, len);
+		path[len] = 0;
+		lstat(path, &st);
 
-	if (!lstat(ce->name, &st))
+		return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
+				error_type, o);
+	} else if (!lstat(ce->name, &st))
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 				ce_to_dtype(ce), ce, &st,
 				error_type, o);
+
 	return 0;
 }
 
-- 
1.7.1.571.gba4d01
