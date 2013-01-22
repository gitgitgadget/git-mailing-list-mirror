From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH v3] Enable minimal stat checking
Date: Tue, 22 Jan 2013 08:49:22 +0100
Message-ID: <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
Cc: j sixt <j.sixt@viscovery.net>, Shawn Pearce <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 08:50:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxYcS-0003fu-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 08:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab3AVHtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 02:49:49 -0500
Received: from smtp-gw21.han.skanova.net ([81.236.55.21]:49349 "EHLO
	smtp-gw21.han.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab3AVHts (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 02:49:48 -0500
Received: from localhost.localdomain (213.67.12.15) by smtp-gw21.han.skanova.net (8.5.133)
        id 506A33EC028464AB; Tue, 22 Jan 2013 08:49:45 +0100
X-Mailer: git-send-email 1.8.1.337.g6672977.dirty
In-Reply-To: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214208>

Specifically the fields uid, gid, ctime, ino and dev are set to zero
by JGit. Other implementations, eg. Git in cygwin are allegedly also
somewhat incompatible with Git For Windows and on *nix platforms
the resolution of the timestamps may differ.

Any stat checking by git will then need to check content, which may
be very slow, particularly on Windows. Since mtime and size
is typically enough we should allow the user to tell git to avoid
checking these fields if they are set to zero in the index.

This change introduces a core.checkstat config option where the
the user can select to check all fields (default), or just size
and the whole second part of mtime (minimal).

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/config.txt |  6 ++++++
 cache.h                  |  1 +
 config.c                 |  8 ++++++++
 environment.c            |  1 +
 read-cache.c             | 28 ++++++++++++++++------------
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5809e0..47c213d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -235,6 +235,12 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.checkstat::
+	Determines which stat fields to match between the index
+	and work tree. The user can set this to 'default' or
+	'minimal'. Default (or explicitly 'default'), is to check
+	all fields, including the sub-second part of mtime and ctime.
+
 core.quotepath::
 	The commands that output paths (e.g. 'ls-files',
 	'diff'), when not given the `-z` option, will quote
diff --git a/cache.h b/cache.h
index c257953..ab20c4d 100644
--- a/cache.h
+++ b/cache.h
@@ -536,6 +536,7 @@ extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
+extern int check_stat;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
diff --git a/config.c b/config.c
index 7b444b6..2b58c75 100644
--- a/config.c
+++ b/config.c
@@ -566,6 +566,14 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.statinfo")) {
+		if (!strcasecmp(value, "default"))
+			check_stat = 1;
+		else if (!strcasecmp(value, "minimal"))
+			check_stat = 0;
+		else
+			die_bad_config(var);
+	}
 
 	if (!strcmp(var, "core.quotepath")) {
 		quote_path_fully = git_config_bool(var, value);
diff --git a/environment.c b/environment.c
index 85edd7f..e828b37 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
+int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = 7;
 int ignore_case;
diff --git a/read-cache.c b/read-cache.c
index fda78bc..23db681 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -197,21 +197,25 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
-		changed |= CTIME_CHANGED;
+	if (trust_ctime ? check_stat : trust_ctime/*false*/)
+		if (ce->ce_ctime.sec != (unsigned int)st->st_ctime)
+			changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
-	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
+	if (check_stat && ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
+	if (trust_ctime ? check_stat : trust_ctime/*false*/)
+		if (ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
+			changed |= CTIME_CHANGED;
 #endif
 
-	if (ce->ce_uid != (unsigned int) st->st_uid ||
-	    ce->ce_gid != (unsigned int) st->st_gid)
-		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != (unsigned int) st->st_ino)
-		changed |= INODE_CHANGED;
+	if (check_stat) {
+		if (ce->ce_uid != (unsigned int) st->st_uid ||
+			ce->ce_gid != (unsigned int) st->st_gid)
+			changed |= OWNER_CHANGED;
+		if (ce->ce_ino != (unsigned int) st->st_ino)
+			changed |= INODE_CHANGED;
+	}
 
 #ifdef USE_STDEV
 	/*
@@ -219,8 +223,8 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	 * clients will have different views of what "device"
 	 * the filesystem is on
 	 */
-	if (ce->ce_dev != (unsigned int) st->st_dev)
-		changed |= INODE_CHANGED;
+	if (check_stat && ce->ce_dev != (unsigned int) st->st_dev)
+			changed |= INODE_CHANGED;
 #endif
 
 	if (ce->ce_size != (unsigned int) st->st_size)
-- 
1.8.1.337.g6672977.dirty
