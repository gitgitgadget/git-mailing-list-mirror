From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2 04/11] Discard "deleted" cache entries after using them
 to update the working tree
Date: Thu, 7 Feb 2008 11:39:59 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802071128030.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 17:41:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9og-0007U1-I0
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 17:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbYBGQkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbYBGQkF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 11:40:05 -0500
Received: from iabervon.org ([66.92.72.58]:39482 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371AbYBGQkB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 11:40:01 -0500
Received: (qmail 29731 invoked by uid 1000); 7 Feb 2008 16:39:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Feb 2008 16:39:59 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72969>

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

While we're at it, simplify the loop in check_updates(), and avoid
passing global variables as parameters to check_updates(): there is
only one call site anyway.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 unpack-trees.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index c82a979..99aa45f 100644
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
