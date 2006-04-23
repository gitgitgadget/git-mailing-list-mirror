From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] Invalidate cache-tree entries for touched paths in git-apply.
Date: Sun, 23 Apr 2006 16:52:52 -0700
Message-ID: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 01:53:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXoNu-0006KD-6a
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 01:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWDWXwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 19:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWDWXwz
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 19:52:55 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:46496 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751463AbWDWXwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 19:52:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060423235253.DCRC20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 19:52:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19077>

This updates git-apply to maintain cache-tree information.  With
this and the previous write-tree patch, repeated "apply --index"
followed by "write-tree" on a huge tree will hopefully become
faster.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * ... then the big rock falls.  With this, I tried to apply and
   then write-tree "diff-tree -p $commit^1 $commit" on top of
   "$commit^1" for the last 20 or so commits in the kernel tree.
   The "master" version takes 0.15 second per patch on my Duron
   750 with 700MB, while this one does that in 0.06 second.
   This also helps the memory pressure because we do not have to
   regenerate unchanged trees.  810 minor faults with the patch
   vs 2150 minor faults without.

 apply.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

94005d7bb4b55e9984f6505a8916d23d304ccc4d
diff --git a/apply.c b/apply.c
index 269210a..f7cdefa 100644
--- a/apply.c
+++ b/apply.c
@@ -8,9 +8,14 @@
  */
 #include <fnmatch.h>
 #include "cache.h"
+#include "cache-tree.h"
 #include "quote.h"
 #include "blob.h"
 
+static unsigned char active_cache_sha1[20];
+static struct cache_tree *active_cache_tree;
+
+
 //  --check turns on checking that the working tree matches the
 //    files that are being modified, but doesn't apply the patch
 //  --stat does just a diffstat, and doesn't actually apply
@@ -1717,6 +1722,7 @@ static void remove_file(struct patch *pa
 	if (write_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
 			die("unable to remove %s from index", patch->old_name);
+		cache_tree_invalidate_path(active_cache_tree, patch->old_name);
 	}
 	unlink(patch->old_name);
 }
@@ -1815,6 +1821,7 @@ static void create_file(struct patch *pa
 		mode = S_IFREG | 0644;
 	create_one_file(path, mode, buf, size);	
 	add_index_file(path, mode, buf, size);
+	cache_tree_invalidate_path(active_cache_tree, path);
 }
 
 static void write_out_one_result(struct patch *patch)
@@ -1912,8 +1919,9 @@ static int apply_patch(int fd, const cha
 	if (write_index)
 		newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (check_index) {
-		if (read_cache() < 0)
+		if (read_cache_1(active_cache_sha1) < 0)
 			die("unable to read index file");
+		active_cache_tree = read_cache_tree(active_cache_sha1);
 	}
 
 	if ((check || apply) && check_patch_list(list) < 0)
@@ -1923,9 +1931,13 @@ static int apply_patch(int fd, const cha
 		write_out_results(list, skipped_patch);
 
 	if (write_index) {
-		if (write_cache(newfd, active_cache, active_nr) ||
+		if (write_cache_1(newfd, active_cache, active_nr,
+				  active_cache_sha1) ||
 		    commit_index_file(&cache_file))
 			die("Unable to write new cachefile");
+		cache_tree_update(active_cache_tree,
+				  active_cache, active_nr, 1);
+		write_cache_tree(active_cache_sha1, active_cache_tree);
 	}
 
 	if (show_index_info)
-- 
1.3.0.g623a
