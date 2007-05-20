From: skimo@liacs.nl
Subject: [PATCH 05/15] unpack-trees.c: pass cache_entry * to verify_absent rather than just the name
Date: Sun, 20 May 2007 20:04:38 +0200
Message-ID: <11796842892135-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppms-0007La-DT
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163AbXETSFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756963AbXETSFQ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:16 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37217 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756977AbXETSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:04 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4r3w007811;
	Sun, 20 May 2007 20:04:58 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 20D267DDA4; Sun, 20 May 2007 20:04:49 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47869>

From: Sven Verdoolaege <skimo@kotnet.org>

We will need the full cache_entry later to figure out if we are dealing
with a submodule.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 unpack-trees.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 906ce69..317f656 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -491,7 +491,7 @@ static int verify_clean_subdirectory(const char *path, const char *action,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static void verify_absent(const char *path, const char *action,
+static void verify_absent(struct cache_entry *ce, const char *action,
 		struct unpack_trees_options *o)
 {
 	struct stat st;
@@ -499,12 +499,12 @@ static void verify_absent(const char *path, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return;
 
-	if (!lstat(path, &st)) {
+	if (!lstat(ce->name, &st)) {
 		int cnt;
 
-		if (o->dir && excluded(o->dir, path))
+		if (o->dir && excluded(o->dir, ce->name))
 			/*
-			 * path is explicitly excluded, so it is Ok to
+			 * ce->name is explicitly excluded, so it is Ok to
 			 * overwrite it.
 			 */
 			return;
@@ -516,7 +516,7 @@ static void verify_absent(const char *path, const char *action,
 			 * files that are in "foo/" we would lose
 			 * it.
 			 */
-			cnt = verify_clean_subdirectory(path, action, o);
+			cnt = verify_clean_subdirectory(ce->name, action, o);
 
 			/*
 			 * If this removed entries from the index,
@@ -544,7 +544,7 @@ static void verify_absent(const char *path, const char *action,
 		 * delete this path, which is in a subdirectory that
 		 * is being replaced with a blob.
 		 */
-		cnt = cache_name_pos(path, strlen(path));
+		cnt = cache_name_pos(ce->name, strlen(ce->name));
 		if (0 <= cnt) {
 			struct cache_entry *ce = active_cache[cnt];
 			if (!ce_stage(ce) && !ce->ce_mode)
@@ -552,7 +552,7 @@ static void verify_absent(const char *path, const char *action,
 		}
 
 		die("Untracked working tree file '%s' "
-		    "would be %s by merge.", path, action);
+		    "would be %s by merge.", ce->name, action);
 	}
 }
 
@@ -576,7 +576,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		}
 	}
 	else {
-		verify_absent(merge->name, "overwritten", o);
+		verify_absent(merge, "overwritten", o);
 		invalidate_ce_path(merge);
 	}
 
@@ -591,7 +591,7 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 	if (old)
 		verify_uptodate(old, o);
 	else
-		verify_absent(ce->name, "removed", o);
+		verify_absent(ce, "removed", o);
 	ce->ce_mode = 0;
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	invalidate_ce_path(ce);
@@ -708,18 +708,18 @@ int threeway_merge(struct cache_entry **stages,
 	if (o->aggressive) {
 		int head_deleted = !head && !df_conflict_head;
 		int remote_deleted = !remote && !df_conflict_remote;
-		const char *path = NULL;
+		struct cache_entry *ce = NULL;
 
 		if (index)
-			path = index->name;
+			ce = index;
 		else if (head)
-			path = head->name;
+			ce = head;
 		else if (remote)
-			path = remote->name;
+			ce = remote;
 		else {
 			for (i = 1; i < o->head_idx; i++) {
 				if (stages[i] && stages[i] != o->df_conflict_entry) {
-					path = stages[i]->name;
+					ce = stages[i];
 					break;
 				}
 			}
@@ -734,8 +734,8 @@ int threeway_merge(struct cache_entry **stages,
 		    (remote_deleted && head && head_match)) {
 			if (index)
 				return deleted_entry(index, index, o);
-			else if (path && !head_deleted)
-				verify_absent(path, "removed", o);
+			else if (ce && !head_deleted)
+				verify_absent(ce, "removed", o);
 			return 0;
 		}
 		/*
-- 
1.5.2.rc3.815.g8fc2
