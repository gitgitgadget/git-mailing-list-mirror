From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/5] reset: make "reset --merge" discard work tree changes
	on unmerged entries
Date: Sat, 02 Jan 2010 06:39:29 +0100
Message-ID: <20100102053934.30066.95746.chriscool@tuxfamily.org>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 06:40:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQwim-00023x-JB
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 06:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab0ABFj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 00:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112Ab0ABFjz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 00:39:55 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53968 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab0ABFjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 00:39:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 82F5081806D;
	Sat,  2 Jan 2010 06:39:40 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2A73D81801B;
	Sat,  2 Jan 2010 06:39:38 +0100 (CET)
X-git-sha1: 56b1487fa9c795957adef1b139d28140a4140fef 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100102053303.30066.26391.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136018>

From: Junio C Hamano <gitster@pobox.com>

Commit 9e8ecea (Add 'merge' mode to 'git reset', 2008-12-01) disallowed
"git reset --merge" when there was unmerged entries. It acknowledged
that this is not the best possible behavior, and that it would be better
if unmerged entries were reset as if --hard (instead of --merge) has
been used.

Recently another commit (reset: use "unpack_trees()" directly instead of
"git read-tree", 2009-12-30) changed the behavior of --merge to accept
resetting unmerged entries if they are reset to a different state than
HEAD, but it did not reset the changes in the work tree. So the behavior
was kind of improved, but it was not yet as if --hard has been used.

This patch finally makes "git reset --merge" behaves like
"git reset --hard" on unmerged entries.

To do that it does three things:

 - Updates the documentation to match the wish of original "reset
   --merge" better, namely, "An unmerged entry is a sign that the path
   didn't have any local modification and can be safely resetted to
   whatever the new HEAD records";

 - Updates read_index_unmerged(), which reads the index file into the
   cache while dropping any higher-stage entries down to stage #0, not
   to copy the object name recorded in the cache entry.  The code used to
   take the object name from the highest stage entry ("theirs" if you
   happened to have stage #3, or "ours" if they removed while you kept),
   which essentially meant that you are getting random results and
   didn't make sense.

   The _only_ reason we want to keep a previously unmerged entry in the
   index at stage #0 is so that we don't forget the fact that we have
   corresponding file in the work tree in order to be able to remove it
   when the tree we are resetting to does not have the path.  In order
   to differentiate such an entry from ordinary cache entry, the cache
   entry added by read_index_unmerged() records null sha1.

 - Updates merged_entry() and deleted_entry() so that they pay attention
   to cache entries with null sha1 (note that we _might_ want to use a
   new in-core ce->ce_flags instead of using the null-sha1 hack).  They
   are previously unmerged entries, and the files in the work tree that
   correspond to them are resetted away by oneway_merge() to the version
   from the tree we are resetting to.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |    4 ++--
 read-cache.c                |    2 +-
 t/t7110-reset-merge.sh      |   14 +++++++-------
 unpack-trees.c              |   19 ++++++++++++-------
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 2480be5..b78e2e1 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -123,14 +123,14 @@ entries:
        X       U     A    B     --soft  (disallowed)
 				--mixed  X       B     B
 				--hard   B       B     B
-				--merge  X       B     B
+				--merge  B       B     B
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
        X       U     A    A     --soft  (disallowed)
 				--mixed  X       A     A
 				--hard   A       A     A
-				--merge (disallowed)
+				--merge  A       A     A
 
 X means any state and U means an unmerged index.
 
diff --git a/read-cache.c b/read-cache.c
index 94b92d3..e07a6df 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1635,7 +1635,7 @@ int read_index_unmerged(struct index_state *istate)
 		len = strlen(ce->name);
 		size = cache_entry_size(len);
 		new_ce = xcalloc(1, size);
-		hashcpy(new_ce->sha1, ce->sha1);
+		/* don't copy sha1; this should not match anything */
 		memcpy(new_ce->name, ce->name, len);
 		new_ce->ce_flags = create_ce_flags(len, 0);
 		new_ce->ce_mode = ce->ce_mode;
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index ff2875c..249df7c 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -135,27 +135,27 @@ test_expect_success 'setup 2 different branches' '
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
-# file1:     X       U     B    C     --merge  X       C     C
+# file1:     X       U     B    C     --merge  C       C     C
 test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
     test_must_fail git merge branch1 &&
-    cat file1 >orig_file1 &&
     git reset --merge HEAD^ &&
     test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
     test -z "$(git diff --cached)" &&
-    test_cmp file1 orig_file1
+    test -z "$(git diff)"
 '
 
 # The next test will test the following:
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
-# file1:     X       U     B    B     --merge  (disallowed)
-test_expect_success '"reset --merge HEAD" fails with pending merge' '
+# file1:     X       U     B    B     --merge  B       B     B
+test_expect_success '"reset --merge HEAD" is ok with pending merge' '
     git reset --hard third &&
     test_must_fail git merge branch1 &&
-    test_must_fail git reset --merge HEAD &&
+    git reset --merge HEAD &&
     test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
-    test -n "$(git diff --cached)"
+    test -z "$(git diff --cached)" &&
+    test -z "$(git diff)"
 '
 
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570475..87f95a1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -809,7 +809,11 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 {
 	int update = CE_UPDATE;
 
-	if (old) {
+	if (!old) {
+		if (verify_absent(merge, "overwritten", o))
+			return -1;
+		invalidate_ce_path(merge, o);
+	} else if (!is_null_sha1(old->sha1)) {
 		/*
 		 * See if we can re-use the old CE directly?
 		 * That way we get the uptodate stat info.
@@ -827,11 +831,12 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 				update |= CE_SKIP_WORKTREE;
 			invalidate_ce_path(old, o);
 		}
-	}
-	else {
-		if (verify_absent(merge, "overwritten", o))
-			return -1;
-		invalidate_ce_path(merge, o);
+	} else {
+		/*
+		 * Previously unmerged entry left as an existence
+		 * marker by read_index_unmerged();
+		 */
+		invalidate_ce_path(old, o);
 	}
 
 	add_entry(o, merge, update, CE_STAGEMASK);
@@ -847,7 +852,7 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 			return -1;
 		return 0;
 	}
-	if (verify_uptodate(old, o))
+	if (!is_null_sha1(old->sha1) && verify_uptodate(old, o))
 		return -1;
 	add_entry(o, ce, CE_REMOVE, 0);
 	invalidate_ce_path(ce, o);
-- 
1.6.6.rc2.5.g49666
