From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/9] Discard "deleted" cache entries after using them to
 update the working tree
Date: Mon, 4 Feb 2008 13:35:49 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802041335470.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:36:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM6BT-0006Qr-UV
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYBDSfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754172AbYBDSfv
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:35:51 -0500
Received: from iabervon.org ([66.92.72.58]:51150 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754123AbYBDSfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:35:50 -0500
Received: (qmail 5002 invoked by uid 1000); 4 Feb 2008 18:35:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Feb 2008 18:35:49 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72545>

Way back in read-tree.c, we used a mode 0 cache entry to indicate that
an entry had been deleted, so that the update code would remove the
working tree file, and we would just skip it when writing out the
index file afterward.

These days, unpack_trees is a library function, and it is still
leaving these entries in the active cache. Furthermore, unpack_trees
doesn't correctly ignore those entries, and who knows what other code
wouldn't expect them to be there, but just isn't yet called after a
call to unpack_trees. To avoid having other code trip over these
entries, have check_updates() remove them after it removes the working
tree files.

While we're at it, make the loop more obvious and skip passing in
globals to a static function with only one caller.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 unpack-trees.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f462a56..40d4130 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -288,16 +288,16 @@ static void unlink_entry(char *name, char *last_symlink)
 }
 
 static struct checkout state;
-static void check_updates(struct cache_entry **src, int nr,
-			struct unpack_trees_options *o)
+static void check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
 	char last_symlink[PATH_MAX];
+	int i;
 
 	if (o->update && o->verbose_update) {
-		for (total = cnt = 0; cnt < nr; cnt++) {
-			struct cache_entry *ce = src[cnt];
+		for (total = cnt = 0; cnt < active_nr; cnt++) {
+			struct cache_entry *ce = active_cache[cnt];
 			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 				total++;
 		}
@@ -308,14 +308,16 @@ static void check_updates(struct cache_entry **src, int nr,
 	}
 
 	*last_symlink = '\0';
-	while (nr--) {
-		struct cache_entry *ce = *src++;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
 
 		if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 			display_progress(progress, ++cnt);
 		if (ce->ce_flags & CE_REMOVE) {
 			if (o->update)
 				unlink_entry(ce->name, last_symlink);
+			remove_cache_entry_at(i);
+			i--;
 			continue;
 		}
 		if (ce->ce_flags & CE_UPDATE) {
@@ -374,7 +376,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			error("Merge requires file-level merging");
 	}
 
-	check_updates(active_cache, active_nr, o);
+	check_updates(o);
 	return 0;
 }
 
-- 
1.5.4
