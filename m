From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-diff-tree -R A B == git-diff-tree B A"?
Date: Fri, 20 May 2005 08:32:07 -0700
Message-ID: <7vzmupud54.fsf@assigned-by-dhcp.cox.net>
References: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 17:34:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ9Ur-000307-7b
	for gcvg-git@gmane.org; Fri, 20 May 2005 17:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVETPeD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 11:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVETPeD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 11:34:03 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61423 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261411AbVETPcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 11:32:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520153208.IPWF19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 11:32:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 20 May 2005 08:20:21 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Keep git-diff-tree output sorted in cache order on dir/file swap.

When one tree has a tree where the other has a blob, diff-tree
always outputs delete/create pair for that entry; deletion of
the entry in the first tree is output first and then creation in
the second tree.  This order results in entries in the
subdirectories from the first tree reported before the plain
blob is shown from the second tree, i.e. not in the cache order.

This inconsistency may break downstream tools that expect the
entries are sorted, since the git-* tools that output paths in
all other cases do so in the cache order.  Also this is needed
to make "diff-tree A B" === "diff-tree -R B A".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree.c                 |   16 +++
t/lib-read-tree-m-3way.sh   |  144 +++++++++++++++++++++++++++++++++
t/t1000-read-tree-m-3way.sh |  171 ----------------------------------------
t/t4002-diff-basic.sh       |  187 ++++++++++++++++++++++++++++++++++++++++++++
4 files changed, 347 insertions(+), 171 deletions(-)
new file (100755): t/lib-read-tree-m-3way.sh
new file (100755): t/t4002-diff-basic.sh

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -124,8 +124,22 @@ static int compare_tree_entry(void *tree
 	 * file, we need to consider it a remove and an add.
 	 */
 	if (S_ISDIR(mode1) != S_ISDIR(mode2)) {
-		show_file("-", tree1, size1, base);
+		/*
+		 * This "one_first" is needed for keeping the output in
+		 * the cache entry order.  Otherwise, "diff A B" becomes
+		 * different from "diff -R B A".
+		 *
+		 * It may look counterintuitive that one_first is not
+		 * defined as (!recursive || S_ISDIR(mode2)), but this
+		 * is deliberate; again otherwise, "diff A B" becomes
+		 * different from "diff -R B A".
+		 */
+		int one_first = S_ISDIR(mode2);
+		if (one_first)
+			show_file("-", tree1, size1, base);
 		show_file("+", tree2, size2, base);
+		if (!one_first)
+			show_file("-", tree1, size1, base);
 		return 0;
 	}
 
diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
new file mode 100755
--- /dev/null
+++ b/t/lib-read-tree-m-3way.sh
@@ -0,0 +1,144 @@
+: Included from t1000-read-tree-m-3way.sh and others
+# Original tree.
+mkdir Z
+for a in N D M
+do
+    for b in N D M
+    do
+        p=$a$b
+	echo This is $p from the original tree. >$p
+	echo This is Z/$p from the original tree. >Z/$p
+	test_expect_success \
+	    "adding test file $p and Z/$p" \
+	    'git-update-cache --add $p &&
+	    git-update-cache --add Z/$p'
+    done
+done
+echo This is SS from the original tree. >SS
+test_expect_success \
+    'adding test file SS' \
+    'git-update-cache --add SS'
+cat >TT <<\EOF
+This is a trivial merge sample text.
+Branch A is expected to upcase this word, here.
+There are some filler lines to avoid diff context
+conflicts here,
+like this one,
+and this one,
+and this one is yet another one of them.
+At the very end, here comes another line, that is
+the word, expected to be upcased by Branch B.
+This concludes the trivial merge sample file.
+EOF
+test_expect_success \
+    'adding test file TT' \
+    'git-update-cache --add TT'
+test_expect_success \
+    'prepare initial tree' \
+    'tree_O=$(git-write-tree)'
+
+################################################################
+# Branch A and B makes the changes according to the above matrix.
+
+################################################################
+# Branch A
+
+to_remove=$(echo D? Z/D?)
+rm -f $to_remove
+test_expect_success \
+    'change in branch A (removal)' \
+    'git-update-cache --remove $to_remove'
+
+for p in M? Z/M?
+do
+    echo This is modified $p in the branch A. >$p
+    test_expect_success \
+	'change in branch A (modification)' \
+        "git-update-cache $p"
+done
+
+for p in AN AA Z/AN Z/AA
+do
+    echo This is added $p in the branch A. >$p
+    test_expect_success \
+	'change in branch A (addition)' \
+	"git-update-cache --add $p"
+done
+
+echo This is SS from the modified tree. >SS
+echo This is LL from the modified tree. >LL
+test_expect_success \
+    'change in branch A (addition)' \
+    'git-update-cache --add LL &&
+     git-update-cache SS'
+mv TT TT-
+sed -e '/Branch A/s/word/WORD/g' <TT- >TT
+rm -f TT-
+test_expect_success \
+    'change in branch A (edit)' \
+    'git-update-cache TT'
+
+mkdir DF
+echo Branch A makes a file at DF/DF, creating a directory DF. >DF/DF
+test_expect_success \
+    'change in branch A (change file to directory)' \
+    'git-update-cache --add DF/DF'
+
+test_expect_success \
+    'recording branch A tree' \
+    'tree_A=$(git-write-tree)'
+	   
+################################################################
+# Branch B
+# Start from O
+
+rm -rf [NDMASLT][NDMASLT] Z DF
+mkdir Z
+test_expect_success \
+    'reading original tree and checking out' \
+    'git-read-tree $tree_O &&
+     git-checkout-cache -a'
+
+to_remove=$(echo ?D Z/?D)
+rm -f $to_remove
+test_expect_success \
+    'change in branch B (removal)' \
+    "git-update-cache --remove $to_remove"
+
+for p in ?M Z/?M
+do
+    echo This is modified $p in the branch B. >$p
+    test_expect_success \
+	'change in branch B (modification)' \
+	"git-update-cache $p"
+done
+
+for p in NA AA Z/NA Z/AA
+do
+    echo This is added $p in the branch B. >$p
+    test_expect_success \
+	'change in branch B (addition)' \
+	"git-update-cache --add $p"
+done
+echo This is SS from the modified tree. >SS
+echo This is LL from the modified tree. >LL
+test_expect_success \
+    'change in branch B (addition and modification)' \
+    'git-update-cache --add LL &&
+     git-update-cache SS'
+mv TT TT-
+sed -e '/Branch B/s/word/WORD/g' <TT- >TT
+rm -f TT-
+test_expect_success \
+    'change in branch B (modification)' \
+    'git-update-cache TT'
+
+echo Branch B makes a file at DF. >DF
+test_expect_success \
+    'change in branch B (addition of a file to conflict with directory)' \
+    'git-update-cache --add DF'
+
+test_expect_success \
+    'recording branch B tree' \
+    'tree_B=$(git-write-tree)'
+
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -71,177 +71,8 @@ In addition:
  DF: a special case, where A makes a directory and B makes a file.
 
 '
-
 . ./test-lib.sh
-
-# Original tree.
-mkdir Z
-for a in N D M
-do
-    for b in N D M
-    do
-        p=$a$b
-	echo This is $p from the original tree. >$p
-	echo This is Z/$p from the original tree. >Z/$p
-	test_expect_success \
-	    "adding test file $p and Z/$p" \
-	    'git-update-cache --add $p &&
-	    git-update-cache --add Z/$p'
-    done
-done
-echo This is SS from the original tree. >SS
-test_expect_success \
-    'adding test file SS' \
-    'git-update-cache --add SS'
-cat >TT <<\EOF
-This is a trivial merge sample text.
-Branch A is expected to upcase this word, here.
-There are some filler lines to avoid diff context
-conflicts here,
-like this one,
-and this one,
-and this one is yet another one of them.
-At the very end, here comes another line, that is
-the word, expected to be upcased by Branch B.
-This concludes the trivial merge sample file.
-EOF
-test_expect_success \
-    'adding test file TT' \
-    'git-update-cache --add TT'
-test_expect_success \
-    'prepare initial tree' \
-    'tree_O=$(git-write-tree)'
-
-test_expect_success \
-    'commit initial tree' \
-    'commit_O=$(echo "Original tree for the merge test." |
-     git-commit-tree $tree_O)'
-echo $commit_O >.git/HEAD-O
-
-################################################################
-# Branch A and B makes the changes according to the above matrix.
-
-################################################################
-# Branch A
-
-to_remove=$(echo D? Z/D?)
-rm -f $to_remove
-test_expect_success \
-    'change in branch A (removal)' \
-    'git-update-cache --remove $to_remove'
-
-for p in M? Z/M?
-do
-    echo This is modified $p in the branch A. >$p
-    test_expect_success \
-	'change in branch A (modification)' \
-        "git-update-cache $p"
-done
-
-for p in AN AA Z/AN Z/AA
-do
-    echo This is added $p in the branch A. >$p
-    test_expect_success \
-	'change in branch A (addition)' \
-	"git-update-cache --add $p"
-done
-
-echo This is SS from the modified tree. >SS
-echo This is LL from the modified tree. >LL
-test_expect_success \
-    'change in branch A (addition)' \
-    'git-update-cache --add LL &&
-     git-update-cache SS'
-mv TT TT-
-sed -e '/Branch A/s/word/WORD/g' <TT- >TT
-rm -f TT-
-test_expect_success \
-    'change in branch A (edit)' \
-    'git-update-cache TT'
-
-mkdir DF
-echo Branch A makes a file at DF/DF, creating a directory DF. >DF/DF
-test_expect_success \
-    'change in branch A (change file to directory)' \
-    'git-update-cache --add DF/DF'
-
-test_expect_success \
-    'recording branch A tree' \
-    'tree_A=$(git-write-tree)'
-test_expect_success \
-    'committing branch A changes' \
-    'commit_A=$(echo "Branch A for the merge test." |
-           git-commit-tree $tree_A -p $commit_O)'
-echo $commit_A >.git/HEAD-A
-	   
-################################################################
-# Branch B
-# Start from O
-
-rm -rf [NDMASLT][NDMASLT] Z DF
-mkdir Z
-test_expect_success \
-    'reading original tree and checking out' \
-    'git-read-tree $tree_O &&
-     git-checkout-cache -a'
-
-to_remove=$(echo ?D Z/?D)
-rm -f $to_remove
-test_expect_success \
-    'change in branch B (removal)' \
-    "git-update-cache --remove $to_remove"
-
-for p in ?M Z/?M
-do
-    echo This is modified $p in the branch B. >$p
-    test_expect_success \
-	'change in branch B (modification)' \
-	"git-update-cache $p"
-done
-
-for p in NA AA Z/NA Z/AA
-do
-    echo This is added $p in the branch B. >$p
-    test_expect_success \
-	'change in branch B (addition)' \
-	"git-update-cache --add $p"
-done
-echo This is SS from the modified tree. >SS
-echo This is LL from the modified tree. >LL
-test_expect_success \
-    'change in branch B (addition and modification)' \
-    'git-update-cache --add LL &&
-     git-update-cache SS'
-mv TT TT-
-sed -e '/Branch B/s/word/WORD/g' <TT- >TT
-rm -f TT-
-test_expect_success \
-    'change in branch B (modification)' \
-    'git-update-cache TT'
-
-echo Branch B makes a file at DF. >DF
-test_expect_success \
-    'change in branch B (addition of a file to conflict with directory)' \
-    'git-update-cache --add DF'
-
-test_expect_success \
-    'recording branch B tree' \
-    'tree_B=$(git-write-tree)'
-test_expect_success \
-    'committing branch B changes' \
-    'commit_B=$(echo "Branch B for the merge test." |
-           git-commit-tree $tree_B -p $commit_O)'
-echo $commit_B >.git/HEAD-B
-
-################################################################
-# Done preparation.
-
-test_debug '
-    for T in O A B
-    do
-	echo "# $T $(eval git-cat-file commit \$commit_$T | sed -e 1q)"
-    done
-'
+. ../lib-read-tree-m-3way.sh
 
 ################################################################
 # Try merging and showing the various diffs
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
new file mode 100755
--- /dev/null
+++ b/t/t4002-diff-basic.sh
@@ -0,0 +1,187 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Test diff raw-output.
+
+'
+. ./test-lib.sh
+. ../lib-read-tree-m-3way.sh
+
+cat >.test-plain-OA <<\EOF
++100644 blob ccba72ad3888a3520b39efcf780b9ee64167535d AA
++100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
+-100644 blob bcc68ef997017466d5c9094bcf7692295f588c9a DD
++040000 tree 6d50f65d3bdab91c63444294d38f08aeff328e42 DF
+-100644 blob 141c1f1642328e4bc46a7d801a71da392e66791e DM
+-100644 blob 35abde1506ddf806572ff4d407bd06885d0f8ee9 DN
++100644 blob 1d41122ebdd7a640f29d3c9cc4f9d70094374762 LL
+*100644->100644 blob 03f24c8c4700babccfd28b654e7e8eac402ad6cd->103d9f89b50b9aad03054b579be5e7aa665f2d57 MD
+*100644->100644 blob b258508afb7ceb449981bd9d63d2d3e971bf8d34->b431b272d829ff3aa4d1a5085f4394ab4d3305b6 MM
+*100644->100644 blob bd084b0c27c7b6cc34f11d6d0509a29be3caf970->a716d58de4a570e0038f5c307bd8db34daea021f MN
+*100644->100644 blob 40c959f984c8b89a2b02520d17f00d717f024397->2ac547ae9614a00d1b28275de608131f7a0e259f SS
+*100644->100644 blob 4ac13458899ab908ef3b1128fa378daefc88d356->4c86f9a85fbc5e6804ee2e17a797538fbe785bca TT
+*040000->040000 tree 7d670fdcdb9929f6c7dac196ff78689cd1c566a1->5e5f22072bb39f6e12cf663a57cb634c76eefb49 Z
+EOF
+
+cat >.test-recursive-OA <<\EOF
++100644 blob ccba72ad3888a3520b39efcf780b9ee64167535d AA
++100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
+-100644 blob bcc68ef997017466d5c9094bcf7692295f588c9a DD
++100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
+-100644 blob 141c1f1642328e4bc46a7d801a71da392e66791e DM
+-100644 blob 35abde1506ddf806572ff4d407bd06885d0f8ee9 DN
++100644 blob 1d41122ebdd7a640f29d3c9cc4f9d70094374762 LL
+*100644->100644 blob 03f24c8c4700babccfd28b654e7e8eac402ad6cd->103d9f89b50b9aad03054b579be5e7aa665f2d57 MD
+*100644->100644 blob b258508afb7ceb449981bd9d63d2d3e971bf8d34->b431b272d829ff3aa4d1a5085f4394ab4d3305b6 MM
+*100644->100644 blob bd084b0c27c7b6cc34f11d6d0509a29be3caf970->a716d58de4a570e0038f5c307bd8db34daea021f MN
+*100644->100644 blob 40c959f984c8b89a2b02520d17f00d717f024397->2ac547ae9614a00d1b28275de608131f7a0e259f SS
+*100644->100644 blob 4ac13458899ab908ef3b1128fa378daefc88d356->4c86f9a85fbc5e6804ee2e17a797538fbe785bca TT
++100644 blob 8acb8e9750e3f644bf323fcf3d338849db106c77 Z/AA
++100644 blob 087494262084cefee7ed484d20c8dc0580791272 Z/AN
+-100644 blob 879007efae624d2b1307214b24a956f0a8d686a8 Z/DD
+-100644 blob 9b541b2275c06e3a7b13f28badf5294e2ae63df4 Z/DM
+-100644 blob beb5d38c55283d280685ea21a0e50cfcc0ca064a Z/DN
+*100644->100644 blob d41fda41b7ec4de46b43cb7ea42a45001ae393d5->a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9 Z/MD
+*100644->100644 blob 4ca22bae2527d3d9e1676498a0fba3b355bd1278->61422ba9c2c873416061a88cd40a59a35b576474 Z/MM
+*100644->100644 blob b16d7b25b869f2beb124efa53467d8a1550ad694->a5c544c21cfcb07eb80a4d89a5b7d1570002edfd Z/MN
+EOF
+cat >.test-plain-OB <<\EOF
++100644 blob 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 AA
+-100644 blob bcc68ef997017466d5c9094bcf7692295f588c9a DD
++100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
+*100644->100644 blob 141c1f1642328e4bc46a7d801a71da392e66791e->3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
++100644 blob 1d41122ebdd7a640f29d3c9cc4f9d70094374762 LL
+-100644 blob 03f24c8c4700babccfd28b654e7e8eac402ad6cd MD
+*100644->100644 blob b258508afb7ceb449981bd9d63d2d3e971bf8d34->19989d4559aae417fedee240ccf2ba315ea4dc2b MM
++100644 blob 15885881ea69115351c09b38371f0348a3fb8c67 NA
+-100644 blob a4e179e4291e5536a5e1c82e091052772d2c5a93 ND
+*100644->100644 blob c8f25781e8f1792e3e40b74225e20553041b5226->cdb9a8c3da571502ac30225e9c17beccb8387983 NM
+*100644->100644 blob 40c959f984c8b89a2b02520d17f00d717f024397->2ac547ae9614a00d1b28275de608131f7a0e259f SS
+*100644->100644 blob 4ac13458899ab908ef3b1128fa378daefc88d356->c4e4a12231b9fa79a0053cb6077fcb21bb5b135a TT
+*040000->040000 tree 7d670fdcdb9929f6c7dac196ff78689cd1c566a1->1ba523955d5160681af65cb776411f574c1e8155 Z
+EOF
+cat >.test-recursive-OB <<\EOF
++100644 blob 6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 AA
+-100644 blob bcc68ef997017466d5c9094bcf7692295f588c9a DD
++100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
+*100644->100644 blob 141c1f1642328e4bc46a7d801a71da392e66791e->3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
++100644 blob 1d41122ebdd7a640f29d3c9cc4f9d70094374762 LL
+-100644 blob 03f24c8c4700babccfd28b654e7e8eac402ad6cd MD
+*100644->100644 blob b258508afb7ceb449981bd9d63d2d3e971bf8d34->19989d4559aae417fedee240ccf2ba315ea4dc2b MM
++100644 blob 15885881ea69115351c09b38371f0348a3fb8c67 NA
+-100644 blob a4e179e4291e5536a5e1c82e091052772d2c5a93 ND
+*100644->100644 blob c8f25781e8f1792e3e40b74225e20553041b5226->cdb9a8c3da571502ac30225e9c17beccb8387983 NM
+*100644->100644 blob 40c959f984c8b89a2b02520d17f00d717f024397->2ac547ae9614a00d1b28275de608131f7a0e259f SS
+*100644->100644 blob 4ac13458899ab908ef3b1128fa378daefc88d356->c4e4a12231b9fa79a0053cb6077fcb21bb5b135a TT
++100644 blob 6c0b99286d0bce551ac4a7b3dff8b706edff3715 Z/AA
+-100644 blob 879007efae624d2b1307214b24a956f0a8d686a8 Z/DD
+*100644->100644 blob 9b541b2275c06e3a7b13f28badf5294e2ae63df4->d77371d15817fcaa57eeec27f770c505ba974ec1 Z/DM
+-100644 blob d41fda41b7ec4de46b43cb7ea42a45001ae393d5 Z/MD
+*100644->100644 blob 4ca22bae2527d3d9e1676498a0fba3b355bd1278->697aad7715a1e7306ca76290a3dd4208fbaeddfa Z/MM
++100644 blob d12979c22fff69c59ca9409e7a8fe3ee25eaee80 Z/NA
+-100644 blob a18393c636b98e9bd7296b8b437ea4992b72440c Z/ND
+*100644->100644 blob 3fdbe17fd013303a2e981e1ca1c6cd6e72789087->7e09d6a3a14bd630913e8c75693cea32157b606d Z/NM
+EOF
+cat >.test-plain-AB <<\EOF
+*100644->100644 blob ccba72ad3888a3520b39efcf780b9ee64167535d->6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 AA
+-100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
++100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
+-040000 tree 6d50f65d3bdab91c63444294d38f08aeff328e42 DF
++100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
++100644 blob 35abde1506ddf806572ff4d407bd06885d0f8ee9 DN
+-100644 blob 103d9f89b50b9aad03054b579be5e7aa665f2d57 MD
+*100644->100644 blob b431b272d829ff3aa4d1a5085f4394ab4d3305b6->19989d4559aae417fedee240ccf2ba315ea4dc2b MM
+*100644->100644 blob a716d58de4a570e0038f5c307bd8db34daea021f->bd084b0c27c7b6cc34f11d6d0509a29be3caf970 MN
++100644 blob 15885881ea69115351c09b38371f0348a3fb8c67 NA
+-100644 blob a4e179e4291e5536a5e1c82e091052772d2c5a93 ND
+*100644->100644 blob c8f25781e8f1792e3e40b74225e20553041b5226->cdb9a8c3da571502ac30225e9c17beccb8387983 NM
+*100644->100644 blob 4c86f9a85fbc5e6804ee2e17a797538fbe785bca->c4e4a12231b9fa79a0053cb6077fcb21bb5b135a TT
+*040000->040000 tree 5e5f22072bb39f6e12cf663a57cb634c76eefb49->1ba523955d5160681af65cb776411f574c1e8155 Z
+EOF
+cat >.test-recursive-AB <<\EOF
+*100644->100644 blob ccba72ad3888a3520b39efcf780b9ee64167535d->6aa2b5335b16431a0ef71e5c0a28be69183cf6a2 AA
+-100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
++100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
+-100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
++100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM
++100644 blob 35abde1506ddf806572ff4d407bd06885d0f8ee9 DN
+-100644 blob 103d9f89b50b9aad03054b579be5e7aa665f2d57 MD
+*100644->100644 blob b431b272d829ff3aa4d1a5085f4394ab4d3305b6->19989d4559aae417fedee240ccf2ba315ea4dc2b MM
+*100644->100644 blob a716d58de4a570e0038f5c307bd8db34daea021f->bd084b0c27c7b6cc34f11d6d0509a29be3caf970 MN
++100644 blob 15885881ea69115351c09b38371f0348a3fb8c67 NA
+-100644 blob a4e179e4291e5536a5e1c82e091052772d2c5a93 ND
+*100644->100644 blob c8f25781e8f1792e3e40b74225e20553041b5226->cdb9a8c3da571502ac30225e9c17beccb8387983 NM
+*100644->100644 blob 4c86f9a85fbc5e6804ee2e17a797538fbe785bca->c4e4a12231b9fa79a0053cb6077fcb21bb5b135a TT
+*100644->100644 blob 8acb8e9750e3f644bf323fcf3d338849db106c77->6c0b99286d0bce551ac4a7b3dff8b706edff3715 Z/AA
+-100644 blob 087494262084cefee7ed484d20c8dc0580791272 Z/AN
++100644 blob d77371d15817fcaa57eeec27f770c505ba974ec1 Z/DM
++100644 blob beb5d38c55283d280685ea21a0e50cfcc0ca064a Z/DN
+-100644 blob a79ac3be9377639e1c7d1edf1ae1b3a5f0ccd8a9 Z/MD
+*100644->100644 blob 61422ba9c2c873416061a88cd40a59a35b576474->697aad7715a1e7306ca76290a3dd4208fbaeddfa Z/MM
+*100644->100644 blob a5c544c21cfcb07eb80a4d89a5b7d1570002edfd->b16d7b25b869f2beb124efa53467d8a1550ad694 Z/MN
++100644 blob d12979c22fff69c59ca9409e7a8fe3ee25eaee80 Z/NA
+-100644 blob a18393c636b98e9bd7296b8b437ea4992b72440c Z/ND
+*100644->100644 blob 3fdbe17fd013303a2e981e1ca1c6cd6e72789087->7e09d6a3a14bd630913e8c75693cea32157b606d Z/NM
+EOF
+
+test_expect_success \
+    'diff-tree of known trees.' \
+    'git-diff-tree $tree_O $tree_A >.test-a &&
+     cmp -s .test-a .test-plain-OA'
+
+test_expect_success \
+    'diff-tree of known trees.' \
+    'git-diff-tree -r $tree_O $tree_A >.test-a &&
+     cmp -s .test-a .test-recursive-OA'
+
+test_expect_success \
+    'diff-tree of known trees.' \
+    'git-diff-tree $tree_O $tree_B >.test-a &&
+     cmp -s .test-a .test-plain-OB'
+
+test_expect_success \
+    'diff-tree of known trees.' \
+    'git-diff-tree -r $tree_O $tree_B >.test-a &&
+     cmp -s .test-a .test-recursive-OB'
+
+test_expect_success \
+    'diff-tree of known trees.' \
+    'git-diff-tree $tree_A $tree_B >.test-a &&
+     cmp -s .test-a .test-plain-AB'
+
+test_expect_success \
+    'diff-tree of known trees.' \
+    'git-diff-tree -r $tree_A $tree_B >.test-a &&
+     cmp -s .test-a .test-recursive-AB'
+
+################################################################
+# Now we have established the baseline, we do not have to
+# rely on individual object ID values that much.
+
+test_expect_success \
+    'diff-tree O A == diff-tree -R A O' \
+    'git-diff-tree $tree_O $tree_A >.test-a &&
+    git-diff-tree -R $tree_A $tree_O >.test-b &&
+    cmp -s .test-a .test-b'
+
+test_expect_success \
+    'diff-tree -r O A == diff-tree -r -R A O' \
+    'git-diff-tree -r $tree_O $tree_A >.test-a &&
+    git-diff-tree -r -R $tree_A $tree_O >.test-b &&
+    cmp -s .test-a .test-b'
+
+test_expect_success \
+    'diff-tree B A == diff-tree -R A B' \
+    'git-diff-tree $tree_B $tree_A >.test-a &&
+    git-diff-tree -R $tree_A $tree_B >.test-b &&
+    cmp -s .test-a .test-b'
+
+test_expect_success \
+    'diff-tree -r B A == diff-tree -r -R A B' \
+    'git-diff-tree -r $tree_B $tree_A >.test-a &&
+    git-diff-tree -r -R $tree_A $tree_B >.test-b &&
+    cmp -s .test-a .test-b'
+
+test_done
------------------------------------------------

