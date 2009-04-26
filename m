From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 1/2] Silence diffs due to use by non-C code.
Date: Sun, 26 Apr 2009 14:06:19 +0200
Message-ID: <1240747579-13843-1-git-send-email-robin.rosenberg@dewire.com>
References: <200904261306.15448.robin.rosenberg.lists@dewire.com>
Cc: git@vger.kernel.org, spearce@spearce.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Apr 27 12:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly39H-0006Z6-R3
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 14:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbZDZMGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 08:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbZDZMGW
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 08:06:22 -0400
Received: from mail.dewire.com ([83.140.172.130]:14074 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010AbZDZMGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 08:06:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1DB6B8030D6;
	Sun, 26 Apr 2009 14:06:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AcubagyYySzl; Sun, 26 Apr 2009 14:06:20 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 78676800253;
	Sun, 26 Apr 2009 14:06:20 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.1.g4f9e8.dirty
In-Reply-To: <200904261306.15448.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117644>

In particular, some of the stat info, is not available to Java programs.
JGit sets the uid, gid, dev and ino to all ones to indicate this. Recognose
this special value and ignore changes in those values when the on-disk
value has all bits set.
---
 read-cache.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

This patch is needed for previous one to apply. This approach to silencing
index stats diff when JGit has been used does not require special options and
one could perhaps argue that any other language without portable access to
these fields should set the fields just like JGit does.

The the flag approach is selected, then these patches should be squashed
together.

diff --git a/read-cache.c b/read-cache.c
index 3f58711..45083ab 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -210,10 +210,10 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		changed |= CTIME_CHANGED;
 #endif
 
-	if (ce->ce_uid != (unsigned int) st->st_uid ||
-	    ce->ce_gid != (unsigned int) st->st_gid)
+	if ((ce->ce_uid != ~0u && ce->ce_uid != (unsigned int) st->st_uid) ||
+	    (ce->ce_gid != ~0u && ce->ce_gid != (unsigned int) st->st_gid))
 		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != (unsigned int) st->st_ino)
+	if (ce->ce_ino != ~0u && ce->ce_ino != (unsigned int) st->st_ino)
 		changed |= INODE_CHANGED;
 
 #ifdef USE_STDEV
@@ -222,7 +222,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	 * clients will have different views of what "device"
 	 * the filesystem is on
 	 */
-	if (ce->ce_dev != (unsigned int) st->st_dev)
+	if (ce->ce_dev != ~0u && ce->ce_dev != (unsigned int) st->st_dev)
 		changed |= INODE_CHANGED;
 #endif
 
-- 
1.6.3.rc2.1.g4f9e8.dirty
