From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP PATCH] Teach read-tree the -n|--dry-run option
Date: Tue, 17 May 2011 21:43:16 +0200
Message-ID: <4DD2CFD4.7060508@web.de>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org> <4DD0043D.1050101@web.de> <7vfwofpvai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 21:43:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMQAw-0003Pc-KD
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 21:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147Ab1EQTnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 15:43:20 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39287 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086Ab1EQTnT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 15:43:19 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id A7D8719FEEE27;
	Tue, 17 May 2011 21:43:17 +0200 (CEST)
Received: from [93.240.98.235] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QMQAm-0008TN-00; Tue, 17 May 2011 21:43:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vfwofpvai.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/wO1BMz6gsA3yMRsVYMB0KBGEeYM8Z3NCHfLHP
	pyVtteE38zD0QIC90pqhRmlD0MHRC93L63Q4pSdf+JLK1V+nPN
	lOGlY0yT7EL17ZZArAWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173820>

Using this option tells read-tree to not update the index. That makes it
possible to check if updating the index would be successful without
changing anything. Using this option will silently ignore -u.

The relevant tests in the t10?? range were extended to do a read-tree -n
before the real read-tree to make sure neither the index nor any local
files were changed with -n and the same exit code as without -n is
returned.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 15.05.2011 22:23, schrieb Junio C Hamano:
> Later we _may_ have a condition where "read-tree -m" with some options
> (except "-n") may succeed but "read-tree -m -u" with the same other
> options may fail, and the reason to have "-n" is so that the caller can
> tell if the operation may or may not fail in advance without changing the
> state. Singling out "do not write INDEX" was a mistake to begin with.
> 
> I think the change to the implementation would be trivial, but you would
> probably want to update the tests in 1002 (remove the one at the end that
> checks -u/-n incompatibility, and perhaps make sure "-n -u" combination
> does not touch anything as advertised).

I added two convenience functions read_tree_u_must_[succeed|fail]() which
work pretty much the way read_tree_must_[succeed|fail]() do but with the
added functionality that they check git diff-files before and after the
read-tree -n too.

I went through all the test cases in the t10?? range and replaced every
relevant call to "git read-tree" with a call to one of those functions
(the only exception being plain resets of the work tree in tests that did
not test read-tree themselves).

The only exceptions where I could not make that replacement without
breaking a test were:

* t1001:381 (#25) new file conflicts with untracked directory
  This should have been detected by verify_absent_1(), but that function
  is left early when opts->update is 0. Will look into that.

* t1004:209 (#13) unlinking an un-unlink-able symlink
  This is an issue of wrong directory permissions, it should be ok that
  -n doesn't detect this as this is not a version control issue. I will
  document that in the commit message.

* 1011:95  (#5)  read-tree with empty .git/info/sparse-checkout
* t1011:163 (#11) read-tree updates worktree, dirty case
  Not sure about those two as I haven't got much experience with sparse
  checkout. Will dig further, pointers welcome.

Apart from these four all other tests look good.


 Documentation/git-read-tree.txt      |    5 ++
 builtin/read-tree.c                  |    7 ++-
 t/t1000-read-tree-m-3way.sh          |   96 ++++++++++++++++++++--------------
 t/t1001-read-tree-m-2way.sh          |   61 ++++++++++++++-------
 t/t1002-read-tree-m-u-2way.sh        |   91 ++++++++++++++++++--------------
 t/t1004-read-tree-m-u-wf.sh          |   44 ++++++++++++----
 t/t1005-read-tree-reset.sh           |   23 ++++++--
 t/t1008-read-tree-overlay.sh         |   10 +++-
 t/t1011-read-tree-sparse-checkout.sh |   33 ++++++++----
 t/t1012-read-tree-df.sh              |   19 +++++--
 t/t1020-subdirectory.sh              |   15 +++++-
 11 files changed, 266 insertions(+), 138 deletions(-)

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
index 93c9281..c0da227 100644
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
+		OPT__DRY_RUN(&dry_run, "don't update the index or the work tree"),
 		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
 			    "skip applying sparse checkout filter", 1),
 		OPT_SET_INT(0, "debug-unpack", &opts.debug_unpack,
@@ -183,6 +184,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		die("--exclude-per-directory is meaningless unless -u");
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
+	if (opts.update && dry_run)
+		opts.update = 0;

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
index 680d992..54e69ce 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -48,6 +48,25 @@ check_cache_at () {
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
 cat >bozbar-old <<\EOF
 This is a sample file used in two-way fast-forward merge
 tests.  Its second line ends with a magic word bozbar
@@ -94,7 +113,7 @@ echo '+100644 X 0	yomin' >expected
 test_expect_success \
     '4 - carry forward local addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      git update-index --add yomin &&
      read_tree_twoway $treeH $treeM &&
@@ -106,7 +125,7 @@ test_expect_success \
 test_expect_success \
     '5 - carry forward local addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo yomin >yomin &&
      git update-index --add yomin &&
@@ -120,7 +139,7 @@ test_expect_success \
 test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      git update-index --add frotz &&
      read_tree_twoway $treeH $treeM &&
@@ -131,7 +150,7 @@ test_expect_success \
 test_expect_success \
     '7 - local addition already has the same.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz >frotz &&
      git update-index --add frotz &&
@@ -144,7 +163,7 @@ test_expect_success \
 test_expect_success \
     '8 - conflicting addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
@@ -153,7 +172,7 @@ test_expect_success \
 test_expect_success \
     '9 - conflicting addition.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
@@ -163,7 +182,7 @@ test_expect_success \
 test_expect_success \
     '10 - path removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -174,7 +193,7 @@ test_expect_success \
 test_expect_success \
     '11 - dirty path removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -184,7 +203,7 @@ test_expect_success \
 test_expect_success \
     '12 - unmatching local changes being removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -193,7 +212,7 @@ test_expect_success \
 test_expect_success \
     '13 - unmatching local changes being removed.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
@@ -208,7 +227,7 @@ EOF
 test_expect_success \
     '14 - unchanged in two heads.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
@@ -221,7 +240,7 @@ test_expect_success \
 test_expect_success \
     '15 - unchanged in two heads.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
@@ -235,7 +254,7 @@ test_expect_success \
 test_expect_success \
     '16 - conflicting local change.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
@@ -244,7 +263,7 @@ test_expect_success \
 test_expect_success \
     '17 - conflicting local change.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
@@ -254,7 +273,7 @@ test_expect_success \
 test_expect_success \
     '18 - local change already having a good result.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-new >bozbar &&
      git update-index --add bozbar &&
@@ -266,7 +285,7 @@ test_expect_success \
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-new >bozbar &&
      git update-index --add bozbar &&
@@ -279,7 +298,7 @@ test_expect_success \
 test_expect_success \
     '20 - no local change, use new tree.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -291,7 +310,7 @@ test_expect_success \
 test_expect_success \
     '21 - no local change, dirty cache.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      cat bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -302,7 +321,7 @@ test_expect_success \
 test_expect_success \
     '22 - local change cache updated.' \
     'rm -f .git/index &&
-     git read-tree $treeH &&
+     read_tree_must_succeed $treeH &&
      git checkout-index -u -f -q -a &&
      sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
      git update-index --add bozbar &&
@@ -386,7 +405,7 @@ test_expect_success \

 test_expect_success \
     'a/b vs a, plus c/d case test.' \
-    'git read-tree -u -m "$treeH" "$treeM" &&
+    'read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
      git ls-files --stage | tee >treeMcheck.out &&
      test_cmp treeM.out treeMcheck.out'

@@ -401,7 +420,7 @@ test_expect_success '-m references the correct modified tree' '
 	echo a >file-a &&
 	git add file-a &&
 	git ls-tree $(git write-tree) file-a >expect &&
-	git read-tree -m HEAD initial-mod &&
+	read_tree_must_succeed -m HEAD initial-mod &&
 	git ls-tree $(git write-tree) file-a >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index a4a17e0..9211711 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -33,6 +33,17 @@ check_cache_at () {
 	esac
 }

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
 test_expect_success \
     setup \
     'echo frotz >frotz &&
@@ -56,8 +67,8 @@ test_expect_success \
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
@@ -69,11 +80,11 @@ test_expect_success \
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
@@ -87,12 +98,12 @@ test_expect_success \
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
@@ -107,10 +118,10 @@ test_expect_success \
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
@@ -123,11 +134,11 @@ test_expect_success \
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
@@ -141,27 +152,27 @@ test_expect_success \
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
@@ -170,28 +181,28 @@ test_expect_success \
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
@@ -201,10 +212,10 @@ EOF
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
@@ -221,11 +232,11 @@ test_expect_success \
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
@@ -242,27 +253,27 @@ test_expect_success \
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
@@ -272,11 +283,11 @@ test_expect_success \
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
@@ -292,10 +303,10 @@ test_expect_success \
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
@@ -305,11 +316,11 @@ test_expect_success \
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
@@ -336,7 +347,7 @@ test_expect_success \
      rm -fr DF &&
      echo DF >DF &&
      git update-index --add DF &&
-     git read-tree -m -u $treeDF $treeDFDF &&
+     read_tree_u_must_succeed -m -u $treeDF $treeDFDF &&
      git ls-files --stage >DFDFcheck.out &&
      test_cmp DFDF.out DFDFcheck.out &&
      check_cache_at DF/DF clean'
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index eb8e3d4..1e9b5d8 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -6,6 +6,28 @@ test_description='read-tree -m -u checks working tree files'

 # two-tree test

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
+
 test_expect_success 'two-way setup' '

 	mkdir subdir &&
@@ -29,7 +51,7 @@ test_expect_success 'two-way not clobbering' '

 	echo >file2 master creates untracked file2 &&
 	echo >subdir/file2 master creates untracked subdir/file2 &&
-	if err=`git read-tree -m -u master side 2>&1`
+	if err=`read_tree_u_must_succeed -m -u master side 2>&1`
 	then
 		echo should have complained
 		false
@@ -42,7 +64,7 @@ echo file2 >.gitignore

 test_expect_success 'two-way with incorrect --exclude-per-directory (1)' '

-	if err=`git read-tree -m --exclude-per-directory=.gitignore master side 2>&1`
+	if err=`read_tree_u_must_succeed -m --exclude-per-directory=.gitignore master side 2>&1`
 	then
 		echo should have complained
 		false
@@ -53,7 +75,7 @@ test_expect_success 'two-way with incorrect --exclude-per-directory (1)' '

 test_expect_success 'two-way with incorrect --exclude-per-directory (2)' '

-	if err=`git read-tree -m -u --exclude-per-directory=foo --exclude-per-directory=.gitignore master side 2>&1`
+	if err=`read_tree_u_must_succeed -m -u --exclude-per-directory=foo --exclude-per-directory=.gitignore master side 2>&1`
 	then
 		echo should have complained
 		false
@@ -64,7 +86,7 @@ test_expect_success 'two-way with incorrect --exclude-per-directory (2)' '

 test_expect_success 'two-way clobbering a ignored file' '

-	git read-tree -m -u --exclude-per-directory=.gitignore master side
+	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore master side
 '

 rm -f .gitignore
@@ -84,7 +106,7 @@ test_expect_success 'three-way not complaining on an untracked path in both' '
 	echo >file2 file two is untracked on the master side &&
 	echo >subdir/file2 file two is untracked on the master side &&

-	git read-tree -m -u branch-point master side
+	read_tree_u_must_succeed -m -u branch-point master side
 '

 test_expect_success 'three-way not clobbering a working tree file' '
@@ -94,7 +116,7 @@ test_expect_success 'three-way not clobbering a working tree file' '
 	git checkout master &&
 	echo >file3 file three created in master, untracked &&
 	echo >subdir/file3 file three created in master, untracked &&
-	if err=`git read-tree -m -u branch-point master side 2>&1`
+	if err=`read_tree_u_must_succeed -m -u branch-point master side 2>&1`
 	then
 		echo should have complained
 		false
@@ -113,7 +135,7 @@ test_expect_success 'three-way not complaining on an untracked file' '
 	echo >file3 file three created in master, untracked &&
 	echo >subdir/file3 file three created in master, untracked &&

-	git read-tree -m -u --exclude-per-directory=.gitignore branch-point master side
+	read_tree_u_must_succeed -m -u --exclude-per-directory=.gitignore branch-point master side
 '

 test_expect_success '3-way not overwriting local changes (setup)' '
@@ -137,7 +159,7 @@ test_expect_success '3-way not overwriting local changes (our side)' '
 	git reset --hard &&

 	echo >>file1 "local changes" &&
-	git read-tree -m -u branch-point side-a side-b &&
+	read_tree_u_must_succeed -m -u branch-point side-a side-b &&
 	grep "new line to be kept" file1 &&
 	grep "local changes" file1

@@ -151,7 +173,7 @@ test_expect_success '3-way not overwriting local changes (their side)' '
 	git reset --hard &&

 	echo >>file2 "local changes" &&
-	test_must_fail git read-tree -m -u branch-point side-a side-b &&
+	read_tree_u_must_fail -m -u branch-point side-a side-b &&
 	! grep "new line to be kept" file2 &&
 	grep "local changes" file2

@@ -173,7 +195,7 @@ test_expect_success SYMLINKS 'funny symlink in work tree' '
 	git add a/b &&
 	git commit -m "we add a/b" &&

-	git read-tree -m -u sym-a sym-a sym-b
+	read_tree_u_must_succeed -m -u sym-a sym-a sym-b

 '

@@ -209,7 +231,7 @@ test_expect_success 'D/F setup' '
 test_expect_success 'D/F' '

 	git checkout side-b &&
-	git read-tree -m -u branch-point side-b side-a &&
+	read_tree_u_must_succeed -m -u branch-point side-b side-a &&
 	git ls-files -u >actual &&
 	(
 		a=$(git rev-parse branch-point:subdir/file2)
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 8499116..33a6a18 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -6,6 +6,17 @@ test_description='read-tree -u --reset'

 # two-tree test

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
 test_expect_success 'setup' '
   git init &&
   mkdir df &&
@@ -22,13 +33,13 @@ test_expect_success 'setup' '
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
@@ -37,13 +48,13 @@ test_expect_success 'reset should remove remnants from a failed merge' '
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
@@ -58,7 +69,7 @@ test_expect_success 'Porcelain reset should remove remnants too' '
 '

 test_expect_success 'Porcelain checkout -f should remove remnants too' '
-  git read-tree --reset -u HEAD &&
+  read_tree_u_must_succeed --reset -u HEAD &&
   git ls-files -s >expect &&
   sha1=$(git rev-parse :new) &&
   (
@@ -73,7 +84,7 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
 '

 test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
-  git read-tree --reset -u HEAD &&
+  read_tree_u_must_succeed --reset -u HEAD &&
   git ls-files -s >expect &&
   sha1=$(git rev-parse :new) &&
   (
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index f9e0028..b88a35f 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -4,6 +4,14 @@ test_description='test multi-tree read-tree without merging'

 . ./test-lib.sh

+read_tree_must_succeed () {
+    git ls-files -s >pre-dry-run &&
+    git read-tree -n "$@" &&
+    git ls-files -s >post-dry-run &&
+    test_cmp pre-dry-run post-dry-run &&
+    git read-tree "$@"
+}
+
 test_expect_success setup '
 	echo one >a &&
 	git add a &&
@@ -21,7 +29,7 @@ test_expect_success setup '
 '

 test_expect_success 'multi-read' '
-	git read-tree initial master side &&
+	read_tree_must_succeed initial master side &&
 	(echo a; echo b/c) >expect &&
 	git ls-files >actual &&
 	test_cmp expect actual
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index de84e35..6d47c37 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -13,6 +13,17 @@ test_description='sparse checkout tests

 . ./test-lib.sh

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
 test_expect_success 'setup' '
 	cat >expected <<-\EOF &&
 	100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
@@ -41,7 +52,7 @@ test_expect_success 'setup' '
 '

 test_expect_success 'read-tree without .git/info/sparse-checkout' '
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files --stage >result &&
 	test_cmp expected result &&
 	git ls-files -t >result &&
@@ -50,7 +61,7 @@ test_expect_success 'read-tree without .git/info/sparse-checkout' '

 test_expect_success 'read-tree with .git/info/sparse-checkout but disabled' '
 	echo >.git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
@@ -60,7 +71,7 @@ test_expect_success 'read-tree with .git/info/sparse-checkout but disabled' '
 test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-checkout and enabled' '
 	git config core.sparsecheckout true &&
 	echo >.git/info/sparse-checkout &&
-	git read-tree --no-sparse-checkout -m -u HEAD &&
+	read_tree_u_must_succeed --no-sparse-checkout -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
@@ -87,7 +98,7 @@ test_expect_success 'match directories with trailing slash' '
 	EOF

 	echo sub/ > .git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t > result &&
 	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
@@ -96,7 +107,7 @@ test_expect_success 'match directories with trailing slash' '

 test_expect_success 'match directories without trailing slash' '
 	echo sub >>.git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
@@ -105,7 +116,7 @@ test_expect_success 'match directories without trailing slash' '

 test_expect_success 'match directory pattern' '
 	echo "s?b" >>.git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
@@ -120,7 +131,7 @@ test_expect_success 'checkout area changes' '
 	EOF

 	echo init.t >.git/info/sparse-checkout &&
-	git read-tree -m -u HEAD &&
+	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-nosub result &&
 	test -f init.t &&
@@ -130,7 +141,7 @@ test_expect_success 'checkout area changes' '
 test_expect_success 'read-tree updates worktree, absent case' '
 	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
-	git read-tree -m -u HEAD^ &&
+	read_tree_u_must_succeed -m -u HEAD^ &&
 	test ! -f init.t
 '

@@ -147,14 +158,14 @@ test_expect_success 'read-tree removes worktree, dirty case' '
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

@@ -163,7 +174,7 @@ test_expect_success 'read-tree adds to worktree, dirty case' '
 	git checkout -f removed &&
 	mkdir sub &&
 	echo dirty >sub/added &&
-	git read-tree -u -m HEAD^ &&
+	read_tree_u_must_succeed -u -m HEAD^ &&
 	grep -q dirty sub/added
 '

diff --git a/t/t1012-read-tree-df.sh b/t/t1012-read-tree-df.sh
index 9811d46..d3e814d 100755
--- a/t/t1012-read-tree-df.sh
+++ b/t/t1012-read-tree-df.sh
@@ -36,6 +36,17 @@ checkindex () {
 	test_cmp expect current
 }

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
 test_expect_success setup '
 	maketree O-000 a/b-2/c/d a/b/c/d a/x &&
 	maketree A-000 a/b-2/c/d a/b/c/d a/x &&
@@ -53,7 +64,7 @@ test_expect_success setup '

 test_expect_success '3-way (1)' '
 	settree A-000 &&
-	git read-tree -m -u O-000 A-000 B-000 &&
+	read_tree_u_must_succeed -m -u O-000 A-000 B-000 &&
 	checkindex <<-EOF
 	3 a/b
 	0 a/b-2/c/d
@@ -65,7 +76,7 @@ test_expect_success '3-way (1)' '

 test_expect_success '3-way (2)' '
 	settree A-001 &&
-	git read-tree -m -u O-000 A-001 B-000 &&
+	read_tree_u_must_succeed -m -u O-000 A-001 B-000 &&
 	checkindex <<-EOF
 	3 a/b
 	0 a/b-2/c/d
@@ -78,7 +89,7 @@ test_expect_success '3-way (2)' '

 test_expect_success '3-way (3)' '
 	settree A-010 &&
-	git read-tree -m -u O-010 A-010 B-010 &&
+	read_tree_u_must_succeed -m -u O-010 A-010 B-010 &&
 	checkindex <<-EOF
 	2 t
 	1 t-0
@@ -92,7 +103,7 @@ test_expect_success '3-way (3)' '

 test_expect_success '2-way (1)' '
 	settree O-020 &&
-	git read-tree -m -u O-020 A-020 &&
+	read_tree_u_must_succeed -m -u O-020 A-020 &&
 	checkindex <<-EOF
 	0 ds/dma/ioat/Makefile
 	0 ds/dma/ioat/registers.h
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index ddc3921..a9d2a71 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -8,6 +8,17 @@ test_description='Try various core-level commands in subdirectory.

 . ./test-lib.sh

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
 test_expect_success setup '
 	long="a b c d e f g h i j k l m n o p q r s t u v w x y z" &&
 	for c in $long; do echo $c; done >one &&
@@ -98,13 +109,13 @@ test_expect_success 'checkout-index' '
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
1.7.5.1.340.g084d4.dirty
