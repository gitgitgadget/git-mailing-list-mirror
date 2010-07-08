From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] fix read-tree storing wrong tree reference with modified
	index
Date: Fri, 9 Jul 2010 00:46:53 +0200
Message-ID: <20100708224653.GB50404@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 00:47:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWzry-0005FI-Rr
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 00:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758676Ab0GHWq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 18:46:57 -0400
Received: from darksea.de ([83.133.111.250]:48401 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757703Ab0GHWq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 18:46:56 -0400
Received: (qmail 23983 invoked from network); 9 Jul 2010 00:46:53 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 9 Jul 2010 00:46:53 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150616>

In 456156d a shortcut to priming the index tree reference was
introduced.

When read-tree is called with -m one would expect it to merge the
tree read and the existing one stored in the index. It did that
correctly but the index referenced the wrong tree. This sometimes lead
to a situation that the diff of

  index <-> HEAD       (git diff)
  index <-> worktree   (git diff --cached)

was empty but

  HEAD <-> worktree    (git diff HEAD)

did show changes because the SHA1 of the worktree files were still in
the index but the referenced tree came from HEAD. The test demonstrates
how to create such a situation.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

I stumbled upon this bug when using git gui. For some reason it does not
always result in the situation described above. I am not sure whether
this is the correct fix or if we expect a different behavior from
read-tree. So another set of eyes is appreciated.

 builtin/read-tree.c         |    6 ++++--
 t/t1001-read-tree-m-2way.sh |   16 ++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8bdcab1..3cb6cdd 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -221,11 +221,13 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 * what came from the tree.
 	 *
 	 * The same holds true if we are switching between two trees
-	 * using read-tree -m A B.  The index must match B after that.
+	 * using read-tree A B (without -m). The index must match B
+	 * after that. With given -m it can be a mix of the old index
+	 * and the read one.
 	 */
 	if (nr_trees == 1 && !opts.prefix)
 		prime_cache_tree(&active_cache_tree, trees[0]);
-	else if (nr_trees == 2 && opts.merge)
+	else if (nr_trees == 2 && !opts.merge)
 		prime_cache_tree(&active_cache_tree, trees[1]);
 
 	if (write_cache(newfd, active_cache, active_nr) ||
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 6327d20..a5ad3c1 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -390,4 +390,20 @@ test_expect_success \
      git ls-files --stage | tee >treeMcheck.out &&
      test_cmp treeM.out treeMcheck.out'
 
+test_expect_success '-m references the correct modified tree' '
+	echo > file-a &&
+	echo > file-b &&
+	git add file-a file-b &&
+	git commit -a -m "test for correct modified tree"
+	git branch initial-mod &&
+	echo b > file-b &&
+	git commit -a -m "B" &&
+	echo a > file-a &&
+	git add file-a &&
+	git ls-tree $(git write-tree) file-a > expect &&
+	git read-tree -m HEAD initial-mod &&
+	git ls-tree $(git write-tree) file-a > actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.2.rc2.1.g8c934
