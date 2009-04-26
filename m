From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and gid
Date: Sun, 26 Apr 2009 12:55:17 +0200
Message-ID: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, spearce@spearce.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Apr 27 12:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly234-0004Ib-M0
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 12:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbZDZKz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 06:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbZDZKz1
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 06:55:27 -0400
Received: from mail.dewire.com ([83.140.172.130]:13321 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZDZKz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 06:55:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 61C238030D6;
	Sun, 26 Apr 2009 12:55:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9K4KASWnkNqp; Sun, 26 Apr 2009 12:55:20 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 47E96800253;
	Sun, 26 Apr 2009 12:55:20 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.1.g4f9e8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117649>

This reason we may want to ignore these fields is that the Java implementation 
of Git cannot set these fields properly. To mark this JGit sets these fields
to to UINT_MAX (all bits set).

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/config.txt |    7 +++++++
 cache.h                  |    1 +
 config.c                 |    4 ++++
 environment.c            |    1 +
 read-cache.c             |    8 ++++----
 5 files changed, 17 insertions(+), 4 deletions(-)

In addition to this you may want to set core.trustctime to false

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3188569..bdf05ba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -135,6 +135,13 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.trustlowlevelstat::
+    If false, differences in the index in the dev, ino, uid and gid
+    fields are ignored. Useful when using git implementations that
+    cannot set these fields correctly, such as Java programs like JGit
+    used by the EGit plugin for Eclipse.
+	See linkgit:git-update-index[1]. True by default.
+
 core.quotepath::
 	The commands that output paths (e.g. 'ls-files',
 	'diff'), when not given the `-z` option, will quote
diff --git a/cache.h b/cache.h
index ab1294d..194021c 100644
--- a/cache.h
+++ b/cache.h
@@ -500,6 +500,7 @@ extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
+extern int trust_lowlevelstat;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int ignore_case;
diff --git a/config.c b/config.c
index 8c1ae59..d8679e7 100644
--- a/config.c
+++ b/config.c
@@ -364,6 +364,10 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.trustlowlevelstat")) {
+		trust_lowlevelstat = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp(var, "core.quotepath")) {
 		quote_path_fully = git_config_bool(var, value);
diff --git a/environment.c b/environment.c
index 4696885..194a289 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@ char git_default_name[MAX_GITNAME];
 int user_ident_explicitly_given;
 int trust_executable_bit = 1;
 int trust_ctime = 1;
+int trust_lowlevelstat = 1;
 int has_symlinks = 1;
 int ignore_case;
 int assume_unchanged;
diff --git a/read-cache.c b/read-cache.c
index 45083ab..f8f497f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -210,10 +210,10 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		changed |= CTIME_CHANGED;
 #endif
 
-	if ((ce->ce_uid != ~0u && ce->ce_uid != (unsigned int) st->st_uid) ||
-	    (ce->ce_gid != ~0u && ce->ce_gid != (unsigned int) st->st_gid))
+	if ((trust_lowlevelstat && ce->ce_uid != (unsigned int) st->st_uid) ||
+	    (trust_lowlevelstat && ce->ce_gid != (unsigned int) st->st_gid))
 		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != ~0u && ce->ce_ino != (unsigned int) st->st_ino)
+	if (trust_lowlevelstat && ce->ce_ino != (unsigned int) st->st_ino)
 		changed |= INODE_CHANGED;
 
 #ifdef USE_STDEV
@@ -222,7 +222,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	 * clients will have different views of what "device"
 	 * the filesystem is on
 	 */
-	if (ce->ce_dev != ~0u && ce->ce_dev != (unsigned int) st->st_dev)
+	if (trust_lowlevelstat && ce->ce_dev != (unsigned int) st->st_dev)
 		changed |= INODE_CHANGED;
 #endif
 
-- 
1.6.3.rc2.1.g4f9e8.dirty
