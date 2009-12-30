From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 4/4] reset: use "unpack_trees()" directly instead of "git
	read-tree"
Date: Wed, 30 Dec 2009 06:54:47 +0100
Message-ID: <20091230055448.4475.64716.chriscool@tuxfamily.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Dec 30 06:53:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPrUN-0005vC-GM
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 06:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbZL3Fwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 00:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZL3Fwr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 00:52:47 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55903 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbZL3Fwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 00:52:46 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9D09C818080;
	Wed, 30 Dec 2009 06:52:36 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7E723818079;
	Wed, 30 Dec 2009 06:52:33 +0100 (CET)
X-git-sha1: 8e1972d0577b865a223844579025a067215e06b4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091230055008.4475.95755.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135858>

From: Stephan Beyer <s-beyer@gmx.net>

This patch makes "reset_index_file()" call "unpack_trees()" directly
instead of forking and execing "git read-tree". So the code is more
efficient.

And it's also easier to see which unpack_tree() options will be used,
as we don't need to follow "git read-tree"'s command line parsing
which is quite complex.

As Daniel Barkalow found, there is a difference between this new
version and the old one. The old version gives an error for
"git reset --merge" with unmerged entries, and the new version does
not when we reset the entries to some states that differ from HEAD.

But in 9e8ecea (Add 'merge' mode to 'git reset', 2008-12-01) there is
the following:

"
     - if the index has unmerged entries, "--merge" will currently
       simply refuse to reset ("you need to resolve your current index
       first"). You'll need to use "--hard" or similar in this case.

       This is sad, because normally a unmerged index means that the
       working tree file should have matched the source tree, so the
       correct action is likely to make --merge reset such a path to
       the target (like --hard), regardless of dirty state in-tree or
       in-index. But that's not how read-tree has ever worked, so..
"

So the new behavior looks better according to the original
implementation of "git reset --merge".

The code comes from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |    2 +-
 builtin-reset.c             |   41 ++++++++++++++++++++++++++++++-----------
 t/t7110-reset-merge.sh      |   12 +++++++-----
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index c9044c9..b40999f 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -122,7 +122,7 @@ entries:
        X       U     A    B     --soft  (disallowed)
                                 --mixed  X       B     B
                                 --hard   B       B     B
-                                --merge (disallowed)
+                                --merge  X       B     B
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
diff --git a/builtin-reset.c b/builtin-reset.c
index 3180c2b..2c880a7 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -18,6 +18,8 @@
 #include "tree.h"
 #include "branch.h"
 #include "parse-options.h"
+#include "unpack-trees.h"
+#include "cache-tree.h"
 
 static const char * const git_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
@@ -54,27 +56,44 @@ static inline int is_merge(void)
 
 static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet)
 {
-	int i = 0;
-	const char *args[6];
+	int nr = 1;
+	int newfd;
+	struct tree_desc desc[2];
+	struct unpack_trees_options opts;
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 
-	args[i++] = "read-tree";
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.fn = oneway_merge;
+	opts.merge = 1;
 	if (!quiet)
-		args[i++] = "-v";
+		opts.verbose_update = 1;
 	switch (reset_type) {
 	case MERGE:
-		args[i++] = "-u";
-		args[i++] = "-m";
+		opts.update = 1;
 		break;
 	case HARD:
-		args[i++] = "-u";
+		opts.update = 1;
 		/* fallthrough */
 	default:
-		args[i++] = "--reset";
+		opts.reset = 1;
 	}
-	args[i++] = sha1_to_hex(sha1);
-	args[i] = NULL;
 
-	return run_command_v_opt(args, RUN_GIT_CMD);
+	newfd = hold_locked_index(lock, 1);
+
+	read_cache_unmerged();
+
+	if (!fill_tree_descriptor(desc + nr - 1, sha1))
+		return error("Failed to find tree of %s.", sha1_to_hex(sha1));
+	if (unpack_trees(nr, desc, &opts))
+		return -1;
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_locked_index(lock))
+		return error("Could not write new index file.");
+
+	return 0;
 }
 
 static void print_new_head_line(struct commit *commit)
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 4c46083..ff2875c 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -135,12 +135,14 @@ test_expect_success 'setup 2 different branches' '
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
-# file1:     X       U     B    C     --merge  (disallowed)
-test_expect_success '"reset --merge HEAD^" fails with pending merge' '
+# file1:     X       U     B    C     --merge  X       C     C
+test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
     test_must_fail git merge branch1 &&
-    test_must_fail git reset --merge HEAD^ &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
-    test -n "$(git diff --cached)"
+    cat file1 >orig_file1 &&
+    git reset --merge HEAD^ &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+    test -z "$(git diff --cached)" &&
+    test_cmp file1 orig_file1
 '
 
 # The next test will test the following:
-- 
1.6.6.rc2.5.g49666
