From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/9] Discard "deleted" cache entries after using them to
 update the working tree
Date: Fri, 25 Jan 2008 18:24:52 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251820330.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 26 00:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIXw2-0006nZ-AN
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 00:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYAYXY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 18:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbYAYXY4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 18:24:56 -0500
Received: from iabervon.org ([66.92.72.58]:45111 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbYAYXYz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 18:24:55 -0500
Received: (qmail 4440 invoked by uid 1000); 25 Jan 2008 23:24:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 23:24:52 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71747>

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
It's likely that this should get merged in some way with Linus's series to 
handle the in-core index differently in general. But this is a simple 
solution to the problem that's sufficient for this particular series.

 unpack-trees.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index d6bae1b..ac919c7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -288,17 +288,17 @@ static void unlink_entry(char *name, char *last_symlink)
 }
 
 static struct checkout state;
-static void check_updates(struct cache_entry **src, int nr,
-			struct unpack_trees_options *o)
+static void check_updates(struct unpack_trees_options *o)
 {
 	unsigned short mask = htons(CE_UPDATE);
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
 	char last_symlink[PATH_MAX];
+	int i;
 
 	if (o->update && o->verbose_update) {
-		for (total = cnt = 0; cnt < nr; cnt++) {
-			struct cache_entry *ce = src[cnt];
+		for (total = cnt = 0; cnt < active_nr; cnt++) {
+			struct cache_entry *ce = active_cache[cnt];
 			if (!ce->ce_mode || ce->ce_flags & mask)
 				total++;
 		}
@@ -309,14 +309,16 @@ static void check_updates(struct cache_entry **src, int nr,
 	}
 
 	*last_symlink = '\0';
-	while (nr--) {
-		struct cache_entry *ce = *src++;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
 
 		if (!ce->ce_mode || ce->ce_flags & mask)
 			display_progress(progress, ++cnt);
 		if (!ce->ce_mode) {
 			if (o->update)
 				unlink_entry(ce->name, last_symlink);
+			remove_cache_entry_at(i);
+			i--;
 			continue;
 		}
 		if (ce->ce_flags & mask) {
@@ -375,7 +377,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			error("Merge requires file-level merging");
 	}
 
-	check_updates(active_cache, active_nr, o);
+	check_updates(o);
 	return 0;
 }
 
-- 
1.5.4.rc3.4.g16335
