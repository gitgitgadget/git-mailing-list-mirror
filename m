From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 2/2] Teach read-tree the -n|--dry-run option
Date: Wed, 25 May 2011 22:10:41 +0200
Message-ID: <4DDD6241.8070908@web.de>
References: <4DDC1DF9.9030109@web.de> <7v39k37kmo.fsf@alter.siamese.dyndns.org> <4DDD615E.7020809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 22:10:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPKPs-0002vu-W0
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 22:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab1EYUKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 16:10:46 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:50793 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab1EYUKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 16:10:45 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 24A5B18F6CAB7;
	Wed, 25 May 2011 22:10:43 +0200 (CEST)
Received: from [217.249.54.24] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QPKPi-0003FT-00; Wed, 25 May 2011 22:10:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DDD615E.7020809@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19DHjWf0S727ViRUvTYtA3noMF1q624airCWrtW
	goKONh2t+9sIMToXXU/sSjv0tdY2KzeQZM2wx7DyZaNJPbDdhI
	5f1OD2z+5mNHy2Na/hlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174459>

Using this option tells read-tree to not update the index. That makes it
possible to check if updating the index would be successful without
changing anything. Using this option will silently ignore -u but still
test if updating the work tree would succeed.

The relevant tests in the t10?? range were extended to do a read-tree -n
before the real read-tree to make sure neither the index nor any local
files were changed with -n and the same exit code as without -n is
returned. The helper functions added for that purpose reside in the new
t/lib-read-tree.sh file.

The only exception is #13 in t1004 ("unlinking an un-unlink-able
symlink"). As this is an issue of wrong directory permissions it is not
detected with -n.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-read-tree.txt      |    5 ++
 builtin/read-tree.c                  |    3 +-
 t/lib-read-tree.sh                   |   43 ++++++++++++++++++
 t/t1000-read-tree-m-3way.sh          |   81 +++++++++++++++++-----------------
 t/t1001-read-tree-m-2way.sh          |   45 ++++++++++---------
 t/t1002-read-tree-m-u-2way.sh        |   81 +++++++++++++++++-----------------
 t/t1004-read-tree-m-u-wf.sh          |   23 +++++-----
 t/t1005-read-tree-reset.sh           |   13 +++---
 t/t1008-read-tree-overlay.sh         |    3 +-
 t/t1011-read-tree-sparse-checkout.sh |   27 ++++++-----
 t/t1012-read-tree-df.sh              |    9 ++--
 t/t1020-subdirectory.sh              |    5 +-
 12 files changed, 198 insertions(+), 140 deletions(-)
 create mode 100644 t/lib-read-tree.sh

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 26fdadc..46a96f2 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -53,6 +53,11 @@ OPTIONS
 	trees that are not directly related to the current
 	working tree status into a temporary index file.

+-n::
+--dry-run::
+	Check if the command would error out, without updating the index
+	nor the files in the working tree for real.
+
 -v::
 	Show the progress of checking files out.

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 93c9281..df6c4c8 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -130,6 +130,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
 			    "don't check the working tree after merging", 1),
+		OPT__DRY_RUN(&opts.dry_run, "don't update the index or the work tree"),
 		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
 			    "skip applying sparse checkout filter", 1),
 		OPT_SET_INT(0, "debug-unpack", &opts.debug_unpack,
@@ -219,7 +220,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	if (unpack_trees(nr_trees, t, &opts))
 		return 128;

-	if (opts.debug_unpack)
+	if (opts.debug_unpack || opts.dry_run)
 		return 0; /* do not write the index out */

 	/*
diff --git a/t/lib-read-tree.sh b/t/lib-read-tree.sh
new file mode 100644
index 0000000..435d19c
--- /dev/null
+++ b/t/lib-read-tree.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# Helper functions to check if read-tree would succeed/fail as expected with
+# and without the dry-run option. They also test that the dry-run does not
+# write the index and that together with -u it doesn't touch the work tree.
+#
+read_tree_must_succeed () {
+    git ls-files -s >pre-dry-run &&
+    git read-tree -n "$@" &&
+    git ls-files -s >post-dry-run &&
+    test_cmp pre-dry-run post-dry-run &&
+    git read-tree "$@"
+}
+
+read_tree_must_fail () {
+    git ls-files -s >pre-dry-run &&
+    test_must_fail git read-tree -n "$@" &&
+    git ls-files -s >post-dry-run &&
+    test_cmp pre-dry-run post-dry-run &&
+    test_must_fail git read-tree "$@"
+}
+
+read_tree_u_must_succeed () {
+    git ls-files -s >pre-dry-run &&
+    git diff-files >pre-dry-run-wt &&
+    git read-tree -n "$@" &&
+    git ls-files -s >post-dry-run &&
+    git diff-files >post-dry-run-wt &&
+    test_cmp pre-dry-run post-dry-run &&
+    test_cmp pre-dry-run-wt post-dry-run-wt &&
+    git read-tree "$@"
+}
+
+read_tree_u_must_fail () {
+    git ls-files -s >pre-dry-run &&
+    git diff-files >pre-dry-run-wt &&
+    test_must_fail git read-tree -n "$@" &&
+    git ls-files -s >post-dry-run &&
+    git diff-files >post-dry-run-wt &&
+    test_cmp pre-dry-run post-dry-run &&
+    test_cmp pre-dry-run-wt post-dry-run-wt &&
+    test_must_fail git read-tree "$@"
+}
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index ca8a409..babcdd2 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -72,6 +72,7 @@ In addition:

 '
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh

 ################################################################
@@ -137,7 +138,7 @@ test_expect_success \
     '3-way merge with git read-tree -m, empty cache' \
     "rm -fr [NDMALTS][NDMALTSF] Z &&
      rm .git/index &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 # This starts out with the first head, which is the normal
@@ -146,9 +147,9 @@ test_expect_success \
     '3-way merge with git read-tree -m, match H' \
     "rm -fr [NDMALTS][NDMALTSF] Z &&
      rm .git/index &&
-     git read-tree $tree_A &&
+     read_tree_must_succeed $tree_A &&
      git checkout-index -f -u -a &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 : <<\END_OF_CASE_TABLE
@@ -211,7 +212,7 @@ test_expect_success '1 - must not have an entry not in A.' "
      rm -f .git/index XX &&
      echo XX >XX &&
      git update-index --add XX &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -219,7 +220,7 @@ test_expect_success \
     "rm -f .git/index NA &&
      cp .orig-B/NA NA &&
      git update-index --add NA &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B"

 test_expect_success \
     '2 - matching B alone is OK in !O && !A && B case.' \
@@ -227,14 +228,14 @@ test_expect_success \
      cp .orig-B/NA NA &&
      git update-index --add NA &&
      echo extra >>NA &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B"

 test_expect_success \
     '3 - must match A in !O && A && !B case.' \
     "rm -f .git/index AN &&
      cp .orig-A/AN AN &&
      git update-index --add AN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -243,7 +244,7 @@ test_expect_success \
      cp .orig-A/AN AN &&
      git update-index --add AN &&
      echo extra >>AN &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B"

 test_expect_success \
     '3 (fail) - must match A in !O && A && !B case.' "
@@ -251,7 +252,7 @@ test_expect_success \
      cp .orig-A/AN AN &&
      echo extra >>AN &&
      git update-index --add AN &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -259,7 +260,7 @@ test_expect_success \
     "rm -f .git/index AA &&
      cp .orig-A/AA AA &&
      git update-index --add AA &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -268,7 +269,7 @@ test_expect_success \
      cp .orig-A/AA AA &&
      git update-index --add AA &&
      echo extra >>AA &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -277,7 +278,7 @@ test_expect_success \
      cp .orig-A/AA AA &&
      echo extra >>AA &&
      git update-index --add AA &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -285,7 +286,7 @@ test_expect_success \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      git update-index --add LL &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -294,7 +295,7 @@ test_expect_success \
      cp .orig-A/LL LL &&
      git update-index --add LL &&
      echo extra >>LL &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -303,7 +304,7 @@ test_expect_success \
      cp .orig-A/LL LL &&
      echo extra >>LL &&
      git update-index --add LL &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -311,7 +312,7 @@ test_expect_success \
      rm -f .git/index DD &&
      echo DD >DD &&
      git update-index --add DD &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -319,7 +320,7 @@ test_expect_success \
      rm -f .git/index DM &&
      cp .orig-B/DM DM &&
      git update-index --add DM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -327,7 +328,7 @@ test_expect_success \
      rm -f .git/index DN &&
      cp .orig-B/DN DN &&
      git update-index --add DN &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -335,7 +336,7 @@ test_expect_success \
     "rm -f .git/index MD &&
      cp .orig-A/MD MD &&
      git update-index --add MD &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -344,7 +345,7 @@ test_expect_success \
      cp .orig-A/MD MD &&
      git update-index --add MD &&
      echo extra >>MD &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -353,7 +354,7 @@ test_expect_success \
      cp .orig-A/MD MD &&
      echo extra >>MD &&
      git update-index --add MD &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -361,7 +362,7 @@ test_expect_success \
     "rm -f .git/index ND &&
      cp .orig-A/ND ND &&
      git update-index --add ND &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -370,7 +371,7 @@ test_expect_success \
      cp .orig-A/ND ND &&
      git update-index --add ND &&
      echo extra >>ND &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -379,7 +380,7 @@ test_expect_success \
      cp .orig-A/ND ND &&
      echo extra >>ND &&
      git update-index --add ND &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -387,7 +388,7 @@ test_expect_success \
     "rm -f .git/index MM &&
      cp .orig-A/MM MM &&
      git update-index --add MM &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -396,7 +397,7 @@ test_expect_success \
      cp .orig-A/MM MM &&
      git update-index --add MM &&
      echo extra >>MM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -405,7 +406,7 @@ test_expect_success \
      cp .orig-A/MM MM &&
      echo extra >>MM &&
      git update-index --add MM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -413,7 +414,7 @@ test_expect_success \
     "rm -f .git/index SS &&
      cp .orig-A/SS SS &&
      git update-index --add SS &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -422,7 +423,7 @@ test_expect_success \
      cp .orig-A/SS SS &&
      git update-index --add SS &&
      echo extra >>SS &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -431,7 +432,7 @@ test_expect_success \
      cp .orig-A/SS SS &&
      echo extra >>SS &&
      git update-index --add SS &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -439,7 +440,7 @@ test_expect_success \
     "rm -f .git/index MN &&
      cp .orig-A/MN MN &&
      git update-index --add MN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -448,7 +449,7 @@ test_expect_success \
      cp .orig-A/MN MN &&
      git update-index --add MN &&
      echo extra >>MN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -456,7 +457,7 @@ test_expect_success \
     "rm -f .git/index NM &&
      cp .orig-A/NM NM &&
      git update-index --add NM &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -465,7 +466,7 @@ test_expect_success \
      cp .orig-B/NM NM &&
      git update-index --add NM &&
      echo extra >>NM &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -474,7 +475,7 @@ test_expect_success \
      cp .orig-A/NM NM &&
      git update-index --add NM &&
      echo extra >>NM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -483,7 +484,7 @@ test_expect_success \
      cp .orig-A/NM NM &&
      echo extra >>NM &&
      git update-index --add NM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -491,7 +492,7 @@ test_expect_success \
     "rm -f .git/index NN &&
      cp .orig-A/NN NN &&
      git update-index --add NN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -500,7 +501,7 @@ test_expect_success \
      cp .orig-A/NN NN &&
      git update-index --add NN &&
      echo extra >>NN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -509,7 +510,7 @@ test_expect_success \
      cp .orig-A/NN NN &&
      echo extra >>NN &&
      git update-index --add NN &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 # #16
@@ -522,7 +523,7 @@ test_expect_success \
     echo E16 >F16 &&
     git update-index F16 &&
     tree1=`git write-tree` &&
-    git read-tree -m $tree0 $tree1 $tree1 $tree0 &&
+    read_tree_must_succeed -m $tree0 $tree1 $tree1 $tree0 &&
     git ls-files --stage'

 test_done
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 680d992..acaab07 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -21,6 +21,7 @@ In the test, these paths are used:
         yomin   - not in H nor M
 '
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh

 read_tree_twoway () {
     git read-tree -m "$1" "$2" && git ls-files --stage
@@ -94,7 +95,7 @@ echo '+100644 X 0	yomin' >expected
 test_expect_success \
     '4 - carry forward local addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      git update-index --add yomin &&
      read_tree_twoway $treeH $treeM &&
@@ -106,7 +107,7 @@ test_expect_success \
 test_expect_success \
     '5 - carry forward local addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo yomin >yomin &&
      git update-index --add yomin &&
@@ -120,7 +121,7 @@ test_expect_success \
 test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      git update-index --add frotz &&
      read_tree_twoway $treeH $treeM &&
@@ -131,7 +132,7 @@ test_expect_success \
 test_expect_success \
     '7 - local addition already has the same.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz >frotz &&
      git update-index --add frotz &&
@@ -144,7 +145,7 @@ test_expect_success \
 test_expect_success \
     '8 - conflicting addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
@@ -153,7 +154,7 @@ test_expect_success \
 test_expect_success \
     '9 - conflicting addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
@@ -163,7 +164,7 @@ test_expect_success \
 test_expect_success \
     '10 - path removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -174,7 +175,7 @@ test_expect_success \
 test_expect_success \
     '11 - dirty path removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -184,7 +185,7 @@ test_expect_success \
 test_expect_success \
     '12 - unmatching local changes being removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -193,7 +194,7 @@ test_expect_success \
 test_expect_success \
     '13 - unmatching local changes being removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -208,7 +209,7 @@ EOF
 test_expect_success \
     '14 - unchanged in two heads.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
@@ -221,7 +222,7 @@ test_expect_success \
 test_expect_success \
     '15 - unchanged in two heads.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
@@ -235,7 +236,7 @@ test_expect_success \
 test_expect_success \
     '16 - conflicting local change.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
@@ -244,7 +245,7 @@ test_expect_success \
 test_expect_success \
     '17 - conflicting local change.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
@@ -254,7 +255,7 @@ test_expect_success \
 test_expect_success \
     '18 - local change already having a good result.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-new >bozbar &&
      git update-index --add bozbar &&
@@ -266,7 +267,7 @@ test_expect_success \
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-new >bozbar &&
      git update-index --add bozbar &&
@@ -279,7 +280,7 @@ test_expect_success \
 test_expect_success \
     '20 - no local change, use new tree.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -291,7 +292,7 @@ test_expect_success \
 test_expect_success \
     '21 - no local change, dirty cache.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -302,7 +303,7 @@ test_expect_success \
 test_expect_success \
     '22 - local change cache updated.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -359,7 +360,7 @@ test_expect_success \

 test_expect_success \
     'a/b (untracked) vs a, plus c/d case test.' \
-    'test_must_fail git read-tree -u -m "$treeH" "$treeM" &&
+    'read_tree_u_must_fail -u -m "$treeH" "$treeM" &&
      git ls-files --stage &&
      test -f a/b'

@@ -386,7 +387,7 @@ test_expect_success \

 test_expect_success \
     'a/b vs a, plus c/d case test.' \
-    'git read-tree -u -m "$treeH" "$treeM" &&
+    'read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
      git ls-files --stage | tee >treeMcheck.out &&
      test_cmp treeM.out treeMcheck.out'

@@ -401,7 +402,7 @@ test_expect_success '-m references the correct modified tree' '
 	echo a >file-a &&
 	git add file-a &&
 	git ls-tree $(git write-tree) file-a >expect &&
-	git read-tree -m HEAD initial-mod &&
+	read_tree_must_succeed -m HEAD initial-mod &&
 	git ls-tree $(git write-tree) file-a >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index a4a17e0..a847709 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -9,6 +9,7 @@ This is identical to t1001, but uses -u to update the work tree as well.

 '
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh

 compare_change () {
 	sed >current \
@@ -56,8 +57,8 @@ test_expect_success \
 test_expect_success \
     '1, 2, 3 - no carry forward' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed --reset -u $treeH &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >1-3.out &&
      cmp M.out 1-3.out &&
      sum bozbar frotz nitfol >actual3.sum &&
@@ -69,11 +70,11 @@ test_expect_success \
 test_expect_success \
     '4 - carry forward local addition.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo "+100644 X 0	yomin" >expected &&
      echo yomin >yomin &&
      git update-index --add yomin &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >4.out || return 1
      git diff -U0 --no-index M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
@@ -87,12 +88,12 @@ test_expect_success \
 test_expect_success \
     '5 - carry forward local addition.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
-     git read-tree -m -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
+     read_tree_u_must_succeed -m -u $treeH &&
      echo yomin >yomin &&
      git update-index --add yomin &&
      echo yomin yomin >yomin &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >5.out || return 1
      git diff -U0 --no-index M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
@@ -107,10 +108,10 @@ test_expect_success \
 test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo frotz >frotz &&
      git update-index --add frotz &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >6.out &&
      test_cmp M.out 6.out &&
      check_cache_at frotz clean &&
@@ -123,11 +124,11 @@ test_expect_success \
 test_expect_success \
     '7 - local addition already has the same.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo frotz >frotz &&
      git update-index --add frotz &&
      echo frotz frotz >frotz &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >7.out &&
      test_cmp M.out 7.out &&
      check_cache_at frotz dirty &&
@@ -141,27 +142,27 @@ test_expect_success \
 test_expect_success \
     '8 - conflicting addition.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
-     if git read-tree -m -u $treeH $treeM; then false; else :; fi'
+     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'

 test_expect_success \
     '9 - conflicting addition.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
      echo frotz >frotz &&
-     if git read-tree -m -u $treeH $treeM; then false; else :; fi'
+     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'

 test_expect_success \
     '10 - path removed.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >10.out &&
      cmp M.out 10.out &&
      sum bozbar frotz nitfol >actual10.sum &&
@@ -170,28 +171,28 @@ test_expect_success \
 test_expect_success \
     '11 - dirty path removed.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
      echo rezrov rezrov >rezrov &&
-     if git read-tree -m -u $treeH $treeM; then false; else :; fi'
+     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'

 test_expect_success \
     '12 - unmatching local changes being removed.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
-     if git read-tree -m -u $treeH $treeM; then false; else :; fi'
+     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'

 test_expect_success \
     '13 - unmatching local changes being removed.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
      echo rezrov >rezrov &&
-     if git read-tree -m -u $treeH $treeM; then false; else :; fi'
+     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'

 cat >expected <<EOF
 -100644 X 0	nitfol
@@ -201,10 +202,10 @@ EOF
 test_expect_success \
     '14 - unchanged in two heads.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >14.out &&
      test_must_fail git diff -U0 --no-index M.out 14.out >14diff.out &&
      compare_change 14diff.out expected &&
@@ -221,11 +222,11 @@ test_expect_success \
 test_expect_success \
     '15 - unchanged in two heads.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >15.out &&
      test_must_fail git diff -U0 --no-index M.out 15.out >15diff.out &&
      compare_change 15diff.out expected &&
@@ -242,27 +243,27 @@ test_expect_success \
 test_expect_success \
     '16 - conflicting local change.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
-     if git read-tree -m -u $treeH $treeM; then false; else :; fi'
+     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'

 test_expect_success \
     '17 - conflicting local change.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
      echo bozbar bozbar bozbar >bozbar &&
-     if git read-tree -m -u $treeH $treeM; then false; else :; fi'
+     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'

 test_expect_success \
     '18 - local change already having a good result.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo gnusto >bozbar &&
      git update-index --add bozbar &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >18.out &&
      test_cmp M.out 18.out &&
      check_cache_at bozbar clean &&
@@ -272,11 +273,11 @@ test_expect_success \
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo gnusto >bozbar &&
      git update-index --add bozbar &&
      echo gnusto gnusto >bozbar &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >19.out &&
      test_cmp M.out 19.out &&
      check_cache_at bozbar dirty &&
@@ -292,10 +293,10 @@ test_expect_success \
 test_expect_success \
     '20 - no local change, use new tree.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo bozbar >bozbar &&
      git update-index --add bozbar &&
-     git read-tree -m -u $treeH $treeM &&
+     read_tree_u_must_succeed -m -u $treeH $treeM &&
      git ls-files --stage >20.out &&
      test_cmp M.out 20.out &&
      check_cache_at bozbar clean &&
@@ -305,11 +306,11 @@ test_expect_success \
 test_expect_success \
     '21 - no local change, dirty cache.' \
     'rm -f .git/index nitfol bozbar rezrov frotz &&
-     git read-tree --reset -u $treeH &&
+     read_tree_u_must_succeed --reset -u $treeH &&
      echo bozbar >bozbar &&
      git update-index --add bozbar &&
      echo gnusto gnusto >bozbar &&
-     if git read-tree -m -u $treeH $treeM; then false; else :; fi'
+     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'

 # Also make sure we did not break DF vs DF/DF case.
 test_expect_success \
@@ -336,7 +337,7 @@ test_expect_success \
      rm -fr DF &&
      echo DF >DF &&
      git update-index --add DF &&
-     git read-tree -m -u $treeDF $treeDFDF &&
+     read_tree_u_must_succeed -m -u $treeDF $treeDFDF &&
      git ls-files --stage >DFDFcheck.out &&
      test_cmp DFDF.out DFDFcheck.out &&
      check_cache_at DF/DF clean'
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index eb8e3d4..b3ae7d5 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -3,6 +3,7 @@
 test_description='read-tree -m -u checks working tree files'

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh

 # two-tree test

@@ -29,7 +30,7 @@ test_expect_success 'two-way not clobbering' '

 	echo >file2 master creates untracked file2 &&
 	echo >subdir/file2 master creates untracked subdir/file2 &&
-	if err=`git read-tree -m -u master side 2>&1`
+	if err=`read_tree_u_must_succeed -m -u master side 2>&1`
 	then
 		echo should have complained
 		false
@@ -42,7 +43,7 @@ echo file2 >.gitignore

 test_expect_success 'two-way with incorrect --exclude-per-directory (1)' '

-	if err=`git read-tree -m --exclude-per-directory=.gitignore master side 2>&1`
+	if err=`read_tree_u_must_succeed -m --exclude-per-directory=.gitignore master side 2>&1`
 	then
 		echo should have complained
 		false
@@ -53,7 +54,7 @@ test_expect_success 'two-way with incorrect --exclude-per-directory (1)' '

 test_expect_success 'two-way with incorrect --exclude-per-directory (2)' '

-	if err=`git read-tree -m -u --exclude-per-directory=foo --exclude-per-directory=.gitignore master side 2>&1`
+	if err=`read_tree_u_must_succeed -m -u --exclude-per-directory=foo --exclude-per-directory=.gitignore master side 2>&1`
 	then
 		echo should have complained
 		false
@@ -64,7 +65,7 @@ test_expect_success 'two-way with incorrect --exclude-per-directory (2)' '

 test_expect_success 'two-way clobbering a ignored file' '

-	git read-tree -m -u --exclude-per-directory=.gitignore master side
+	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore master side
 '

 rm -f .gitignore
@@ -84,7 +85,7 @@ test_expect_success 'three-way not complaining on an untracked path in both' '
 	echo >file2 file two is untracked on the master side &&
 	echo >subdir/file2 file two is untracked on the master side &&

-	git read-tree -m -u branch-point master side
+	read_tree_u_must_succeed -m -u branch-point master side
 '

 test_expect_success 'three-way not clobbering a working tree file' '
@@ -94,7 +95,7 @@ test_expect_success 'three-way not clobbering a working tree file' '
 	git checkout master &&
 	echo >file3 file three created in master, untracked &&
 	echo >subdir/file3 file three created in master, untracked &&
-	if err=`git read-tree -m -u branch-point master side 2>&1`
+	if err=`read_tree_u_must_succeed -m -u branch-point master side 2>&1`
 	then
 		echo should have complained
 		false
@@ -113,7 +114,7 @@ test_expect_success 'three-way not complaining on an untracked file' '
 	echo >file3 file three created in master, untracked &&
 	echo >subdir/file3 file three created in master, untracked &&

-	git read-tree -m -u --exclude-per-directory=.gitignore branch-point master side
+	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore branch-point master side
 '

 test_expect_success '3-way not overwriting local changes (setup)' '
@@ -137,7 +138,7 @@ test_expect_success '3-way not overwriting local changes (our side)' '
 	git reset --hard &&

 	echo >>file1 "local changes" &&
-	git read-tree -m -u branch-point side-a side-b &&
+	read_tree_u_must_succeed -m -u branch-point side-a side-b &&
 	grep "new line to be kept" file1 &&
 	grep "local changes" file1

@@ -151,7 +152,7 @@ test_expect_success '3-way not overwriting local changes (their side)' '
 	git reset --hard &&

 	echo >>file2 "local changes" &&
-	test_must_fail git read-tree -m -u branch-point side-a side-b &&
+	read_tree_u_must_fail -m -u branch-point side-a side-b &&
 	! grep "new line to be kept" file2 &&
 	grep "local changes" file2

@@ -173,7 +174,7 @@ test_expect_success SYMLINKS 'funny symlink in work tree' '
 	git add a/b &&
 	git commit -m "we add a/b" &&

-	git read-tree -m -u sym-a sym-a sym-b
+	read_tree_u_must_succeed -m -u sym-a sym-a sym-b

 '

@@ -209,7 +210,7 @@ test_expect_success 'D/F setup' '
 test_expect_success 'D/F' '

 	git checkout side-b &&
-	git read-tree -m -u branch-point side-b side-a &&
+	read_tree_u_must_succeed -m -u branch-point side-b side-a &&
 	git ls-files -u >actual &&
 	(
 		a=$(git rev-parse branch-point:subdir/file2)
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 8499116..f53de79 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -3,6 +3,7 @@
 test_description='read-tree -u --reset'

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh

 # two-tree test

@@ -22,13 +23,13 @@ test_expect_success 'setup' '
 '

 test_expect_success 'reset should work' '
-  git read-tree -u --reset HEAD^ &&
+  read_tree_u_must_succeed -u --reset HEAD^ &&
   git ls-files >actual &&
   test_cmp expect actual
 '

 test_expect_success 'reset should remove remnants from a failed merge' '
-  git read-tree --reset -u HEAD &&
+  read_tree_u_must_succeed --reset -u HEAD &&
   git ls-files -s >expect &&
   sha1=$(git rev-parse :new) &&
   (
@@ -37,13 +38,13 @@ test_expect_success 'reset should remove remnants from a failed merge' '
   ) | git update-index --index-info &&
   >old &&
   git ls-files -s &&
-  git read-tree --reset -u HEAD &&
+  read_tree_u_must_succeed --reset -u HEAD &&
   git ls-files -s >actual &&
   ! test -f old
 '

 test_expect_success 'Porcelain reset should remove remnants too' '
-  git read-tree --reset -u HEAD &&
+  read_tree_u_must_succeed --reset -u HEAD &&
   git ls-files -s >expect &&
   sha1=$(git rev-parse :new) &&
   (
@@ -58,7 +59,7 @@ test_expect_success 'Porcelain reset should remove remnants too' '
 '

 test_expect_success 'Porcelain checkout -f should remove remnants too' '
-  git read-tree --reset -u HEAD &&
+  read_tree_u_must_succeed --reset -u HEAD &&
   git ls-files -s >expect &&
   sha1=$(git rev-parse :new) &&
   (
@@ -73,7 +74,7 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
 '

 test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
-  git read-tree --reset -u HEAD &&
+  read_tree_u_must_succeed --reset -u HEAD &&
   git ls-files -s >expect &&
   sha1=$(git rev-parse :new) &&
   (
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index f9e0028..4c50ed9 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -3,6 +3,7 @@
 test_description='test multi-tree read-tree without merging'

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh

 test_expect_success setup '
 	echo one >a &&
@@ -21,7 +22,7 @@ test_expect_success setup '
 '

 test_expect_success 'multi-read' '
-	git read-tree initial master side &&
+	read_tree_must_succeed initial master side &&
 	(echo a; echo b/c) >expect &&
 	git ls-files >actual &&
 	test_cmp expect actual
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 20a50eb..018c354 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -12,6 +12,7 @@ test_description='sparse checkout tests
 '

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh

 test_expect_success 'setup' '
 	cat >expected <<-\EOF &&
@@ -43,7 +44,7 @@ test_expect_success 'setup' '
 '

 test_expect_success 'read-tree without .git/info/sparse-checkout' '
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files --stage >result &&
 	test_cmp expected result &&
 	git ls-files -t >result &&
@@ -52,7 +53,7 @@ test_expect_success 'read-tree without .git/info/sparse-checkout' '

 test_expect_success 'read-tree with .git/info/sparse-checkout but disabled' '
 	echo >.git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
@@ -62,7 +63,7 @@ test_expect_success 'read-tree with .git/info/sparse-checkout but disabled' '
 test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-checkout and enabled' '
 	git config core.sparsecheckout true &&
 	echo >.git/info/sparse-checkout &&
-	git read-tree --no-sparse-checkout -m -u HEAD &&
+	read_tree_u_must_succeed --no-sparse-checkout -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
@@ -72,7 +73,7 @@ test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-
 test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
 	git config core.sparsecheckout true &&
 	echo >.git/info/sparse-checkout &&
-	test_must_fail git read-tree -m -u HEAD &&
+	read_tree_u_must_fail -m -u HEAD &&
 	git ls-files --stage >result &&
 	test_cmp expected result &&
 	git ls-files -t >result &&
@@ -90,7 +91,7 @@ test_expect_success 'match directories with trailing slash' '
 	EOF

 	echo sub/ > .git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t > result &&
 	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
@@ -99,7 +100,7 @@ test_expect_success 'match directories with trailing slash' '

 test_expect_success 'match directories without trailing slash' '
 	echo sub >.git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
@@ -149,7 +150,7 @@ EOF

 test_expect_success 'match directory pattern' '
 	echo "s?b" >.git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
@@ -165,7 +166,7 @@ test_expect_success 'checkout area changes' '
 	EOF

 	echo init.t >.git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-nosub result &&
 	test -f init.t &&
@@ -175,7 +176,7 @@ test_expect_success 'checkout area changes' '
 test_expect_success 'read-tree updates worktree, absent case' '
 	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
-	git read-tree -m -u HEAD^ &&
+	read_tree_u_must_succeed -m -u HEAD^ &&
 	test ! -f init.t
 '

@@ -183,7 +184,7 @@ test_expect_success 'read-tree updates worktree, dirty case' '
 	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
 	echo dirty >init.t &&
-	git read-tree -m -u HEAD^ &&
+	read_tree_u_must_succeed -m -u HEAD^ &&
 	grep -q dirty init.t &&
 	rm init.t
 '
@@ -192,14 +193,14 @@ test_expect_success 'read-tree removes worktree, dirty case' '
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f top &&
 	echo dirty >added &&
-	git read-tree -m -u HEAD^ &&
+	read_tree_u_must_succeed -m -u HEAD^ &&
 	grep -q dirty added
 '

 test_expect_success 'read-tree adds to worktree, absent case' '
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
-	git read-tree -u -m HEAD^ &&
+	read_tree_u_must_succeed -u -m HEAD^ &&
 	test ! -f sub/added
 '

@@ -208,7 +209,7 @@ test_expect_success 'read-tree adds to worktree, dirty case' '
 	git checkout -f removed &&
 	mkdir sub &&
 	echo dirty >sub/added &&
-	git read-tree -u -m HEAD^ &&
+	read_tree_u_must_succeed -u -m HEAD^ &&
 	grep -q dirty sub/added
 '

diff --git a/t/t1012-read-tree-df.sh b/t/t1012-read-tree-df.sh
index 9811d46..a6a04b6 100755
--- a/t/t1012-read-tree-df.sh
+++ b/t/t1012-read-tree-df.sh
@@ -3,6 +3,7 @@
 test_description='read-tree D/F conflict corner cases'

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh

 maketree () {
 	(
@@ -53,7 +54,7 @@ test_expect_success setup '

 test_expect_success '3-way (1)' '
 	settree A-000 &&
-	git read-tree -m -u O-000 A-000 B-000 &&
+	read_tree_u_must_succeed -m -u O-000 A-000 B-000 &&
 	checkindex <<-EOF
 	3 a/b
 	0 a/b-2/c/d
@@ -65,7 +66,7 @@ test_expect_success '3-way (1)' '

 test_expect_success '3-way (2)' '
 	settree A-001 &&
-	git read-tree -m -u O-000 A-001 B-000 &&
+	read_tree_u_must_succeed -m -u O-000 A-001 B-000 &&
 	checkindex <<-EOF
 	3 a/b
 	0 a/b-2/c/d
@@ -78,7 +79,7 @@ test_expect_success '3-way (2)' '

 test_expect_success '3-way (3)' '
 	settree A-010 &&
-	git read-tree -m -u O-010 A-010 B-010 &&
+	read_tree_u_must_succeed -m -u O-010 A-010 B-010 &&
 	checkindex <<-EOF
 	2 t
 	1 t-0
@@ -92,7 +93,7 @@ test_expect_success '3-way (3)' '

 test_expect_success '2-way (1)' '
 	settree O-020 &&
-	git read-tree -m -u O-020 A-020 &&
+	read_tree_u_must_succeed -m -u O-020 A-020 &&
 	checkindex <<-EOF
 	0 ds/dma/ioat/Makefile
 	0 ds/dma/ioat/registers.h
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index ddc3921..f6a44c9 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -7,6 +7,7 @@ test_description='Try various core-level commands in subdirectory.
 '

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-read-tree.sh

 test_expect_success setup '
 	long="a b c d e f g h i j k l m n o p q r s t u v w x y z" &&
@@ -98,13 +99,13 @@ test_expect_success 'checkout-index' '
 test_expect_success 'read-tree' '
 	rm -f one dir/two &&
 	tree=`git write-tree` &&
-	git read-tree --reset -u "$tree" &&
+	read_tree_u_must_succeed --reset -u "$tree" &&
 	cmp one original.one &&
 	cmp dir/two original.two &&
 	(
 		cd dir &&
 		rm -f two &&
-		git read-tree --reset -u "$tree" &&
+		read_tree_u_must_succeed --reset -u "$tree" &&
 		cmp two ../original.two &&
 		cmp ../one ../original.one
 	)
-- 
1.7.5.2.355.gdceb0
