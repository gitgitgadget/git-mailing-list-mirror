From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Teach read-tree the -n|--dry-run option
Date: Wed, 11 May 2011 23:50:25 +0200
Message-ID: <4DCB04A1.3010202@web.de>
References: <4DC47242.6060205@web.de> <7vhb97xx5g.fsf@alter.siamese.dyndns.org> <7vfwoqwby5.fsf@alter.siamese.dyndns.org> <4DC67CF4.80901@web.de> <4DC70200.1080201@web.de> <7vwri0ric1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 23:50:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKHIf-0000Zo-Lm
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 23:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab1EKVu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 17:50:28 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:49070 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab1EKVu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 17:50:27 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1112E18EA473C;
	Wed, 11 May 2011 23:50:26 +0200 (CEST)
Received: from [93.246.47.27] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QKHIX-00088x-00; Wed, 11 May 2011 23:50:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vwri0ric1.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18b54EdD9E32BroS4soajLS92+Q7TH2qzMhK1pL
	QqNfXVJzAMeTElXxibgp6KzyPdIq8v9hT7tL/meu7d6dU7qgLV
	qsU8Z4x+P2dCaAGRm/YQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173430>

Using this option tells read-tree to not update the index. That makes it
possible to check if updating the index would be successful without
changing it.

As using --dry-run is expected to have no side effects, this option makes
no sense together with "-u".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Now with updated tests.

 Documentation/git-read-tree.txt |    5 ++
 builtin/read-tree.c             |    7 ++-
 t/t1000-read-tree-m-3way.sh     |   96 +++++++++++++++++++++++----------------
 t/t1001-read-tree-m-2way.sh     |   48 +++++++++++--------
 t/t1002-read-tree-m-u-2way.sh   |    4 ++
 5 files changed, 98 insertions(+), 62 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 26fdadc..a35849f 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -53,6 +53,11 @@ OPTIONS
 	trees that are not directly related to the current
 	working tree status into a temporary index file.

+-n::
+--dry-run::
+	Don't write the index file. This option isn't allowed together
+	with -u.
+
 -v::
 	Show the progress of checking files out.

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 93c9281..693576f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -98,7 +98,7 @@ static struct lock_file lock_file;

 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 {
-	int i, newfd, stage = 0;
+	int i, newfd, stage = 0, dry_run = 0;
 	unsigned char sha1[20];
 	struct tree_desc t[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
@@ -130,6 +130,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
 			    "don't check the working tree after merging", 1),
+		OPT__DRY_RUN(&dry_run, "don't update the index"),
 		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
 			    "skip applying sparse checkout filter", 1),
 		OPT_SET_INT(0, "debug-unpack", &opts.debug_unpack,
@@ -183,6 +184,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		die("--exclude-per-directory is meaningless unless -u");
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
+	if (opts.update && dry_run)
+		die("--dry-run contradicts -u");

 	if (opts.merge) {
 		if (stage < 2)
@@ -219,7 +222,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	if (unpack_trees(nr_trees, t, &opts))
 		return 128;

-	if (opts.debug_unpack)
+	if (opts.debug_unpack || dry_run)
 		return 0; /* do not write the index out */

 	/*
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index ca8a409..a386cfd 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -131,13 +131,29 @@ check_result () {
     test_cmp expected current
 }

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
 # This is done on an empty work directory, which is the normal
 # merge person behaviour.
 test_expect_success \
     '3-way merge with git read-tree -m, empty cache' \
     "rm -fr [NDMALTS][NDMALTSF] Z &&
      rm .git/index &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 # This starts out with the first head, which is the normal
@@ -146,9 +162,9 @@ test_expect_success \
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
@@ -211,7 +227,7 @@ test_expect_success '1 - must not have an entry not in A.' "
      rm -f .git/index XX &&
      echo XX >XX &&
      git update-index --add XX &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -219,7 +235,7 @@ test_expect_success \
     "rm -f .git/index NA &&
      cp .orig-B/NA NA &&
      git update-index --add NA &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B"

 test_expect_success \
     '2 - matching B alone is OK in !O && !A && B case.' \
@@ -227,14 +243,14 @@ test_expect_success \
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
@@ -243,7 +259,7 @@ test_expect_success \
      cp .orig-A/AN AN &&
      git update-index --add AN &&
      echo extra >>AN &&
-     git read-tree -m $tree_O $tree_A $tree_B"
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B"

 test_expect_success \
     '3 (fail) - must match A in !O && A && !B case.' "
@@ -251,7 +267,7 @@ test_expect_success \
      cp .orig-A/AN AN &&
      echo extra >>AN &&
      git update-index --add AN &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -259,7 +275,7 @@ test_expect_success \
     "rm -f .git/index AA &&
      cp .orig-A/AA AA &&
      git update-index --add AA &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -268,7 +284,7 @@ test_expect_success \
      cp .orig-A/AA AA &&
      git update-index --add AA &&
      echo extra >>AA &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -277,7 +293,7 @@ test_expect_success \
      cp .orig-A/AA AA &&
      echo extra >>AA &&
      git update-index --add AA &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -285,7 +301,7 @@ test_expect_success \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      git update-index --add LL &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -294,7 +310,7 @@ test_expect_success \
      cp .orig-A/LL LL &&
      git update-index --add LL &&
      echo extra >>LL &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -303,7 +319,7 @@ test_expect_success \
      cp .orig-A/LL LL &&
      echo extra >>LL &&
      git update-index --add LL &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -311,7 +327,7 @@ test_expect_success \
      rm -f .git/index DD &&
      echo DD >DD &&
      git update-index --add DD &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -319,7 +335,7 @@ test_expect_success \
      rm -f .git/index DM &&
      cp .orig-B/DM DM &&
      git update-index --add DM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -327,7 +343,7 @@ test_expect_success \
      rm -f .git/index DN &&
      cp .orig-B/DN DN &&
      git update-index --add DN &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -335,7 +351,7 @@ test_expect_success \
     "rm -f .git/index MD &&
      cp .orig-A/MD MD &&
      git update-index --add MD &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -344,7 +360,7 @@ test_expect_success \
      cp .orig-A/MD MD &&
      git update-index --add MD &&
      echo extra >>MD &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -353,7 +369,7 @@ test_expect_success \
      cp .orig-A/MD MD &&
      echo extra >>MD &&
      git update-index --add MD &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -361,7 +377,7 @@ test_expect_success \
     "rm -f .git/index ND &&
      cp .orig-A/ND ND &&
      git update-index --add ND &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -370,7 +386,7 @@ test_expect_success \
      cp .orig-A/ND ND &&
      git update-index --add ND &&
      echo extra >>ND &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -379,7 +395,7 @@ test_expect_success \
      cp .orig-A/ND ND &&
      echo extra >>ND &&
      git update-index --add ND &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -387,7 +403,7 @@ test_expect_success \
     "rm -f .git/index MM &&
      cp .orig-A/MM MM &&
      git update-index --add MM &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -396,7 +412,7 @@ test_expect_success \
      cp .orig-A/MM MM &&
      git update-index --add MM &&
      echo extra >>MM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -405,7 +421,7 @@ test_expect_success \
      cp .orig-A/MM MM &&
      echo extra >>MM &&
      git update-index --add MM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -413,7 +429,7 @@ test_expect_success \
     "rm -f .git/index SS &&
      cp .orig-A/SS SS &&
      git update-index --add SS &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -422,7 +438,7 @@ test_expect_success \
      cp .orig-A/SS SS &&
      git update-index --add SS &&
      echo extra >>SS &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -431,7 +447,7 @@ test_expect_success \
      cp .orig-A/SS SS &&
      echo extra >>SS &&
      git update-index --add SS &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -439,7 +455,7 @@ test_expect_success \
     "rm -f .git/index MN &&
      cp .orig-A/MN MN &&
      git update-index --add MN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -448,7 +464,7 @@ test_expect_success \
      cp .orig-A/MN MN &&
      git update-index --add MN &&
      echo extra >>MN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -456,7 +472,7 @@ test_expect_success \
     "rm -f .git/index NM &&
      cp .orig-A/NM NM &&
      git update-index --add NM &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -465,7 +481,7 @@ test_expect_success \
      cp .orig-B/NM NM &&
      git update-index --add NM &&
      echo extra >>NM &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -474,7 +490,7 @@ test_expect_success \
      cp .orig-A/NM NM &&
      git update-index --add NM &&
      echo extra >>NM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -483,7 +499,7 @@ test_expect_success \
      cp .orig-A/NM NM &&
      echo extra >>NM &&
      git update-index --add NM &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 test_expect_success \
@@ -491,7 +507,7 @@ test_expect_success \
     "rm -f .git/index NN &&
      cp .orig-A/NN NN &&
      git update-index --add NN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -500,7 +516,7 @@ test_expect_success \
      cp .orig-A/NN NN &&
      git update-index --add NN &&
      echo extra >>NN &&
-     git read-tree -m $tree_O $tree_A $tree_B &&
+     read_tree_must_succeed -m $tree_O $tree_A $tree_B &&
      check_result"

 test_expect_success \
@@ -509,7 +525,7 @@ test_expect_success \
      cp .orig-A/NN NN &&
      echo extra >>NN &&
      git update-index --add NN &&
-     test_must_fail git read-tree -m $tree_O $tree_A $tree_B
+     read_tree_must_fail -m $tree_O $tree_A $tree_B
 "

 # #16
@@ -522,7 +538,7 @@ test_expect_success \
     echo E16 >F16 &&
     git update-index F16 &&
     tree1=`git write-tree` &&
-    git read-tree -m $tree0 $tree1 $tree1 $tree0 &&
+    read_tree_must_succeed -m $tree0 $tree1 $tree1 $tree0 &&
     git ls-files --stage'

 test_done
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 680d992..ebe7c4d 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -48,6 +48,14 @@ check_cache_at () {
 	esac
 }

+read_tree_must_succeed () {
+    git ls-files -s >pre-dry-run &&
+    git read-tree -n "$@" &&
+    git ls-files -s >post-dry-run &&
+    test_cmp pre-dry-run post-dry-run &&
+    git read-tree "$@"
+}
+
 cat >bozbar-old <<\EOF
 This is a sample file used in two-way fast-forward merge
 tests.  Its second line ends with a magic word bozbar
@@ -94,7 +102,7 @@ echo '+100644 X 0	yomin' >expected
 test_expect_success \
     '4 - carry forward local addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      git update-index --add yomin &&
      read_tree_twoway $treeH $treeM &&
@@ -106,7 +114,7 @@ test_expect_success \
 test_expect_success \
     '5 - carry forward local addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo yomin >yomin &&
      git update-index --add yomin &&
@@ -120,7 +128,7 @@ test_expect_success \
 test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      git update-index --add frotz &&
      read_tree_twoway $treeH $treeM &&
@@ -131,7 +139,7 @@ test_expect_success \
 test_expect_success \
     '7 - local addition already has the same.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz >frotz &&
      git update-index --add frotz &&
@@ -144,7 +152,7 @@ test_expect_success \
 test_expect_success \
     '8 - conflicting addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
@@ -153,7 +161,7 @@ test_expect_success \
 test_expect_success \
     '9 - conflicting addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
@@ -163,7 +171,7 @@ test_expect_success \
 test_expect_success \
     '10 - path removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -174,7 +182,7 @@ test_expect_success \
 test_expect_success \
     '11 - dirty path removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -184,7 +192,7 @@ test_expect_success \
 test_expect_success \
     '12 - unmatching local changes being removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -193,7 +201,7 @@ test_expect_success \
 test_expect_success \
     '13 - unmatching local changes being removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -208,7 +216,7 @@ EOF
 test_expect_success \
     '14 - unchanged in two heads.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
@@ -221,7 +229,7 @@ test_expect_success \
 test_expect_success \
     '15 - unchanged in two heads.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
@@ -235,7 +243,7 @@ test_expect_success \
 test_expect_success \
     '16 - conflicting local change.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
@@ -244,7 +252,7 @@ test_expect_success \
 test_expect_success \
     '17 - conflicting local change.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
@@ -254,7 +262,7 @@ test_expect_success \
 test_expect_success \
     '18 - local change already having a good result.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-new >bozbar &&
      git update-index --add bozbar &&
@@ -266,7 +274,7 @@ test_expect_success \
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-new >bozbar &&
      git update-index --add bozbar &&
@@ -279,7 +287,7 @@ test_expect_success \
 test_expect_success \
     '20 - no local change, use new tree.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -291,7 +299,7 @@ test_expect_success \
 test_expect_success \
     '21 - no local change, dirty cache.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -302,7 +310,7 @@ test_expect_success \
 test_expect_success \
     '22 - local change cache updated.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -401,7 +409,7 @@ test_expect_success '-m references the correct modified tree' '
 	echo a >file-a &&
 	git add file-a &&
 	git ls-tree $(git write-tree) file-a >expect &&
-	git read-tree -m HEAD initial-mod &&
+	read_tree_must_succeed -m HEAD initial-mod &&
 	git ls-tree $(git write-tree) file-a >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index a4a17e0..ad9a4e8 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -341,4 +341,8 @@ test_expect_success \
      test_cmp DFDF.out DFDFcheck.out &&
      check_cache_at DF/DF clean'

+test_expect_success \
+    '-u is not allowed with -n' \
+    'test_must_fail git read-tree -n -u -m $treeDF $treeDFDF'
+
 test_done
-- 
1.7.5.1.218.g2da34
