From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Perform minimal stat comparison when some stat fields are not set
Date: Wed,  5 Dec 2012 22:20:25 +0100
Message-ID: <1354742425-71417-1-git-send-email-robin.rosenberg@dewire.com>
Cc: gitster@pobox.com, spearce@spearce.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 22:27:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgMVD-00017y-RC
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 22:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab2LEV1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 16:27:19 -0500
Received: from smtp-gw11.han.skanova.net ([81.236.55.20]:41727 "EHLO
	smtp-gw11.han.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2LEV1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 16:27:19 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2012 16:27:18 EST
Received: from localhost.localdomain (213.67.12.15) by smtp-gw11.han.skanova.net (8.5.133)
        id 506BA90A018B489E; Wed, 5 Dec 2012 22:20:56 +0100
X-Mailer: git-send-email 1.8.0.msysgit.0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211138>

At least JGit does sets uid, gid, ctime, ino and dev fields to zero
on update. To Git this looks like the stat data does not match and
a full file compare will be forced even it size and mtime match. This
is in practice unnecessary. Sense JGit's presence by checking if ino
and dev is zero.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 read-cache.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index fda78bc..6f13a22 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -197,21 +197,26 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
+
+	int minimal_stat = (ce->ce_ino == 0 && ce->ce_dev == 0);
+
+	if (trust_ctime && !minimal_stat && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
 	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
+	if (trust_ctime && !minimal_stat && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
 
-	if (ce->ce_uid != (unsigned int) st->st_uid ||
-	    ce->ce_gid != (unsigned int) st->st_gid)
-		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != (unsigned int) st->st_ino)
-		changed |= INODE_CHANGED;
+	if (!minimal_stat) {
+		if (ce->ce_uid != (unsigned int) st->st_uid ||
+			ce->ce_gid != (unsigned int) st->st_gid)
+			changed |= OWNER_CHANGED;
+		if (ce->ce_ino != 0 && ce->ce_ino != (unsigned int) st->st_ino)
+			changed |= INODE_CHANGED;
+	}
 
 #ifdef USE_STDEV
 	/*
@@ -219,7 +224,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	 * clients will have different views of what "device"
 	 * the filesystem is on
 	 */
-	if (ce->ce_dev != (unsigned int) st->st_dev)
+	if (!minimal_stat && ce->ce_dev != (unsigned int) st->st_dev)
 		changed |= INODE_CHANGED;
 #endif
 
-- 
1.8.0.msysgit.0.dirty
