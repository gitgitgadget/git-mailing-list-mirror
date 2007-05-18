From: skimo@liacs.nl
Subject: [PATCH 06/16] unpack-trees.c: pass cache_entry * to verify_absent rather than just the name
Date: Fri, 18 May 2007 21:24:55 +0200
Message-ID: <11795163061763-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp857-0002MY-8u
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862AbXERTZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757828AbXERTZi
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:38 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55764 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757816AbXERTZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:24 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPDdA005199;
	Fri, 18 May 2007 21:25:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id AD84F7DDA5; Fri, 18 May 2007 21:25:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47647>

From: Sven Verdoolaege <skimo@kotnet.org>

We will need the full cache_entry later to figure out if we are dealing
with a submodule.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 unpack-trees.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cac2411..3dac150 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -487,7 +487,7 @@ static int verify_clean_subdirectory(const char *path, const char *action,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static void verify_absent(const char *path, const char *action,
+static void verify_absent(struct cache_entry *ce, const char *action,
 		struct unpack_trees_options *o)
 {
 	struct stat st;
@@ -495,12 +495,12 @@ static void verify_absent(const char *path, const char *action,
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
@@ -512,7 +512,7 @@ static void verify_absent(const char *path, const char *action,
 			 * files that are in "foo/" we would lose
 			 * it.
 			 */
-			cnt = verify_clean_subdirectory(path, action, o);
+			cnt = verify_clean_subdirectory(ce->name, action, o);
 
 			/*
 			 * If this removed entries from the index,
@@ -540,7 +540,7 @@ static void verify_absent(const char *path, const char *action,
 		 * delete this path, which is in a subdirectory that
 		 * is being replaced with a blob.
 		 */
-		cnt = cache_name_pos(path, strlen(path));
+		cnt = cache_name_pos(ce->name, strlen(ce->name));
 		if (0 <= cnt) {
 			struct cache_entry *ce = active_cache[cnt];
 			if (!ce_stage(ce) && !ce->ce_mode)
@@ -548,7 +548,7 @@ static void verify_absent(const char *path, const char *action,
 		}
 
 		die("Untracked working tree file '%s' "
-		    "would be %s by merge.", path, action);
+		    "would be %s by merge.", ce->name, action);
 	}
 }
 
@@ -572,7 +572,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		}
 	}
 	else {
-		verify_absent(merge->name, "overwritten", o);
+		verify_absent(merge, "overwritten", o);
 		invalidate_ce_path(merge);
 	}
 
@@ -587,7 +587,7 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 	if (old)
 		verify_uptodate(old, o);
 	else
-		verify_absent(ce->name, "removed", o);
+		verify_absent(ce, "removed", o);
 	ce->ce_mode = 0;
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	invalidate_ce_path(ce);
@@ -704,18 +704,18 @@ int threeway_merge(struct cache_entry **stages,
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
@@ -730,8 +730,8 @@ int threeway_merge(struct cache_entry **stages,
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
1.5.2.rc3.783.gc7476-dirty
