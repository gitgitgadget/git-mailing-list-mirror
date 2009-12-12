From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/7] reset: use "unpack_trees()" directly instead of "git
	read-tree"
Date: Sat, 12 Dec 2009 05:32:54 +0100
Message-ID: <20091212043259.3930.82570.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sat Dec 12 05:31:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJdn-0000Ke-Mt
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760982AbZLLEbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760852AbZLLEbD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:31:03 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36829 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756101AbZLLEav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:30:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 311A1818068;
	Sat, 12 Dec 2009 05:30:47 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D8AFD81805F;
	Sat, 12 Dec 2009 05:30:44 +0100 (CET)
X-git-sha1: 574f7335f4780f2ab976c3916a2842a9a0aa952f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135119>

From: Stephan Beyer <s-beyer@gmx.net>

This patch makes "reset_index_file()" call "unpack_trees()" directly
instead of forking and execing "git read-tree". So the code is more
efficient.

And it's also easier to see which unpack_tree() options will be used,
as we don't need to follow "git read-tree"'s command line parsing
which is quite complex.

As Daniel Barkalow found, there is a difference between this new
version and the old one. The old version gives an error for
"git reset --merge" with unmerged entries and the new version does
not. But this can be seen as a bug fix, because "--merge" was the
only "git reset" option with this behavior and this behavior was
not documented.

In fact there is still an error with unmerge entries if we reset
the unmerge entries to the same state as HEAD. So the bug is not
completely fixed.

The code comes from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c        |   41 ++++++++++++++++++++++++++++++-----------
 t/t7110-reset-merge.sh |    8 +++++---
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 14bdb03..ac38aaa 100644
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
index 8190da1..6afaf73 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -79,10 +79,12 @@ test_expect_success 'setup 2 different branches' '
      git commit -a -m "change in branch2"
 '
 
-test_expect_success '"reset --merge HEAD^" fails with pending merge' '
+test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
      test_must_fail git merge branch1 &&
-     test_must_fail git reset --merge HEAD^ &&
-     git reset --hard HEAD
+     git reset --merge HEAD^ &&
+     test -z "$(git diff --cached)" &&
+     test -n "$(git diff)" &&
+     git reset --hard HEAD@{1}
 '
 
 test_expect_success '"reset --merge HEAD" fails with pending merge' '
-- 
1.6.6.rc1.8.gd33ec
