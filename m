From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH v3] Make git selectively and conditionally ignore certain stat fields
Date: Tue, 15 Jan 2013 00:51:56 +0100
Message-ID: <1358207516-49199-1-git-send-email-robin.rosenberg@dewire.com>
References: <7vmwwb8m25.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, j.sixt@viscovery.net,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 00:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TutpT-0006XL-3d
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 00:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180Ab3ANXwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 18:52:14 -0500
Received: from smtp-gw11.han.skanova.net ([81.236.55.20]:50738 "EHLO
	smtp-gw11.han.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab3ANXwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 18:52:13 -0500
Received: from localhost.localdomain (213.67.12.15) by smtp-gw11.han.skanova.net (8.5.133)
        id 506BA90A0253ADD0; Tue, 15 Jan 2013 00:52:11 +0100
X-Mailer: git-send-email 1.8.1.337.gc903ef9.dirty
In-Reply-To: <7vmwwb8m25.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213545>

Specifically the fields uid, gid, ctime, ino and dev are set to zero
by JGit. Any stat checking by git will then need to check content,
which may be very slow, particularly on Windows. Since mtime and size
is typically enough we should allow the user to tell git to avoid
checking these fields if they are set to zero in the index.

This change introduces a core.ignorezerostat config option where the
user can list the fields to ignore using the names above.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/config.txt |  9 +++++++++
 cache.h                  |  8 ++++++++
 config.c                 | 26 ++++++++++++++++++++++++++
 environment.c            |  1 +
 read-cache.c             | 29 ++++++++++++++++++-----------
 5 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5809e0..7f34c94 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -235,6 +235,15 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.ignorezerostat::
+	Affects the interpretation of some fields in the index. If
+	unset has no effect. When set to a comma separated list of fields,
+	each of the fields in the index will be excluded from comparison with
+	working tree if the index value is zero. The following fields
+	are recognzed: `uid', `gid', `ctime', `ino' and `dev'. When ctime is ignored
+	the setting of 'core.trustctime' is overridden by by this config
+	value.
+
 core.quotepath::
 	The commands that output paths (e.g. 'ls-files',
 	'diff'), when not given the `-z` option, will quote
diff --git a/cache.h b/cache.h
index c257953..524e49a 100644
--- a/cache.h
+++ b/cache.h
@@ -536,6 +536,14 @@ extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
+extern int check_nonzero_stat;
+#define CHECK_NONZERO_STAT_UID (1<<0)
+#define CHECK_NONZERO_STAT_GID (1<<1)
+#define CHECK_NONZERO_STAT_CTIME (1<<2)
+#define CHECK_NONZERO_STAT_INO (1<<3)
+#define CHECK_NONZERO_STAT_DEV (1<<4)
+#define CHECK_NONZERO_STAT_MASK ((1<<5)-1)
+
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
diff --git a/config.c b/config.c
index 7b444b6..6b617bc 100644
--- a/config.c
+++ b/config.c
@@ -566,6 +566,32 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.ignorezerostat")) {
+		const char *copy;
+		const char *tok;
+		git_config_string(&copy, "core.ignorezerostat", value);
+		check_nonzero_stat = CHECK_NONZERO_STAT_MASK;
+		tok = strtok((char*)copy, ",");
+		while (tok) {
+			if (strcasecmp(tok, "uid") == 0)
+				check_nonzero_stat &= ~CHECK_NONZERO_STAT_UID;
+			else if (strcasecmp(tok, "gid") == 0)
+				check_nonzero_stat &= ~CHECK_NONZERO_STAT_GID;
+			else if (strcasecmp(tok, "ctime") == 0) {
+				check_nonzero_stat &= ~CHECK_NONZERO_STAT_CTIME;
+				trust_ctime = 0;
+			} else if (strcasecmp(tok, "ino") == 0)
+				check_nonzero_stat &= ~CHECK_NONZERO_STAT_INO;
+			else if (strcasecmp(tok, "dev") == 0)
+				check_nonzero_stat &= ~CHECK_NONZERO_STAT_DEV;
+			else
+				die_bad_config(var);
+			tok = strtok(NULL, ",");
+		}
+		if (check_nonzero_stat >= CHECK_NONZERO_STAT_MASK)
+			die_bad_config(var);
+		free((char*)copy);
+	}
 
 	if (!strcmp(var, "core.quotepath")) {
 		quote_path_fully = git_config_bool(var, value);
diff --git a/environment.c b/environment.c
index 85edd7f..e90b52f 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
+int check_nonzero_stat = CHECK_NONZERO_STAT_MASK;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
 int ignore_case;
diff --git a/read-cache.c b/read-cache.c
index fda78bc..c4226ee 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -197,21 +197,27 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
-		changed |= CTIME_CHANGED;
+	if ((trust_ctime || ((check_nonzero_stat & CHECK_NONZERO_STAT_CTIME) && ce->ce_ctime.sec)))
+		if (ce->ce_ctime.sec != (unsigned int)st->st_ctime)
+			changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
 	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
+	if ((trust_ctime || ((check_nonzero_stat & CHECK_NONZERO_STAT_CTIME) && ce->ce_ctime.nsec))
+		if (ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
+			changed |= CTIME_CHANGED;
 #endif
 
-	if (ce->ce_uid != (unsigned int) st->st_uid ||
-	    ce->ce_gid != (unsigned int) st->st_gid)
-		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != (unsigned int) st->st_ino)
-		changed |= INODE_CHANGED;
+	if ((check_nonzero_stat & CHECK_NONZERO_STAT_UID) || ce->ce_uid)
+		if (ce->ce_uid != (unsigned int) st->st_uid)
+			changed |= OWNER_CHANGED;
+	if ((check_nonzero_stat & CHECK_NONZERO_STAT_GID) || ce->ce_gid)
+		if (ce->ce_gid != (unsigned int) st->st_gid)
+			changed |= OWNER_CHANGED;
+	if ((check_nonzero_stat & CHECK_NONZERO_STAT_INO) || ce->ce_ino)
+		if (ce->ce_ino != (unsigned int) st->st_ino)
+			changed |= INODE_CHANGED;
 
 #ifdef USE_STDEV
 	/*
@@ -219,8 +225,9 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	 * clients will have different views of what "device"
 	 * the filesystem is on
 	 */
-	if (ce->ce_dev != (unsigned int) st->st_dev)
-		changed |= INODE_CHANGED;
+	if ((check_nonzero_stat & CHECK_NONZERO_STAT_DEV) || ce->ce_dev)
+		if (ce->ce_dev != (unsigned int) st->st_dev)
+			changed |= INODE_CHANGED;
 #endif
 
 	if (ce->ce_size != (unsigned int) st->st_size)
-- 
1.8.1.337.gc903ef9.dirty
