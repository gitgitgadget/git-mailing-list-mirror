From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Workaround for strange cmp bug
Date: Wed, 9 Aug 2006 12:24:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608091221550.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 09 12:24:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAlEt-00086r-S3
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 12:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030663AbWHIKYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 06:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030665AbWHIKYL
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 06:24:11 -0400
Received: from mail.gmx.de ([213.165.64.20]:42724 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030661AbWHIKYI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 06:24:08 -0400
Received: (qmail invoked by alias); 09 Aug 2006 10:24:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 09 Aug 2006 12:24:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25107>


The cmp(1) (cmp (GNU diffutils) 2.8.7) distributed with openSUSE 10.1 has
a subtle "shortcoming":

	$ echo a > a
	$ echo b > b
	$ cmp a b && echo nonono
	a b differ: char 1, line 1
	$ cmp a b >/dev/null && echo nonono
	nonono
	$ cmp -s a b >/dev/null && echo nonono

So, if cmp should _not_ be quiet, _and_ the output is redirected to
/dev/null, it has a bogus exit value. Our test suite redirects to
/dev/null, which triggers that bug. (Obviously, the tests pass when
running with '-v', which made that a real bugger to debug.)

Since we have all too many '&&' cascades in the test scripts, and you
have to run 'bash -x t*.sh' anyway, the output of cmp when running
the tests with '-v' is not too helpful. Therefore we can replace all
calls to cmp with 'cmp -s'.

This patch was produced by

	$ perl -i.bak -pe 's/cmp ([^-])/cmp -s $1/' t/*.sh

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/t1002-read-tree-m-u-2way.sh    |   32 +++++++++++++++---------------
 t/t1003-read-tree-prefix.sh      |    2 +-
 t/t1020-subdirectory.sh          |   16 ++++++++-------
 t/t1200-tutorial.sh              |   22 ++++++++++-----------
 t/t1300-repo-config.sh           |   40 +++++++++++++++++++-------------------
 t/t2101-update-index-reupdate.sh |   12 ++++++-----
 t/t3300-funny-names.sh           |    2 +-
 t/t4012-diff-binary.sh           |    4 ++--
 t/t4109-apply-multifrag.sh       |   12 ++++++-----
 t/t4110-apply-scan.sh            |    2 +-
 t/t5300-pack-object.sh           |   12 ++++++-----
 t/t5400-send-pack.sh             |    4 ++--
 t/t6021-merge-criss-cross.sh     |    2 +-
 t/t9101-git-svn-props.sh         |    2 +-
 t/t9105-git-svn-commit-diff.sh   |    2 +-
 15 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index da3c813..6be4ee2 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -59,9 +59,9 @@ test_expect_success \
      git-read-tree --reset -u $treeH &&
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >1-3.out &&
-     cmp M.out 1-3.out &&
+     cmp -s M.out 1-3.out &&
      sum bozbar frotz nitfol >actual3.sum &&
-     cmp M.sum actual3.sum &&
+     cmp -s M.sum actual3.sum &&
      check_cache_at bozbar clean &&
      check_cache_at frotz clean &&
      check_cache_at nitfol clean'
@@ -79,7 +79,7 @@ test_expect_success \
      compare_change 4diff.out expected &&
      check_cache_at yomin clean &&
      sum bozbar frotz nitfol >actual4.sum &&
-     cmp M.sum actual4.sum &&
+     cmp -s M.sum actual4.sum &&
      echo yomin >yomin1 &&
      diff yomin yomin1 &&
      rm -f yomin1'
@@ -98,7 +98,7 @@ test_expect_success \
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
      sum bozbar frotz nitfol >actual5.sum &&
-     cmp M.sum actual5.sum &&
+     cmp -s M.sum actual5.sum &&
      : dirty index should have prevented -u from checking it out. &&
      echo yomin yomin >yomin1 &&
      diff yomin yomin1 &&
@@ -115,7 +115,7 @@ test_expect_success \
      diff -U0 M.out 6.out &&
      check_cache_at frotz clean &&
      sum bozbar frotz nitfol >actual3.sum &&
-     cmp M.sum actual3.sum &&
+     cmp -s M.sum actual3.sum &&
      echo frotz >frotz1 &&
      diff frotz frotz1 &&
      rm -f frotz1'
@@ -132,7 +132,7 @@ test_expect_success \
      diff -U0 M.out 7.out &&
      check_cache_at frotz dirty &&
      sum bozbar frotz nitfol >actual7.sum &&
-     if cmp M.sum actual7.sum; then false; else :; fi &&
+     if cmp -s M.sum actual7.sum; then false; else :; fi &&
      : dirty index should have prevented -u from checking it out. &&
      echo frotz frotz >frotz1 &&
      diff frotz frotz1 &&
@@ -163,9 +163,9 @@ test_expect_success \
      git-update-index --add rezrov &&
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >10.out &&
-     cmp M.out 10.out &&
+     cmp -s M.out 10.out &&
      sum bozbar frotz nitfol >actual10.sum &&
-     cmp M.sum actual10.sum'
+     cmp -s M.sum actual10.sum'
 
 test_expect_success \
     '11 - dirty path removed.' \
@@ -210,9 +210,9 @@ test_expect_success \
      compare_change 14diff.out expected &&
      sum bozbar frotz >actual14.sum &&
      grep -v nitfol M.sum > expected14.sum &&
-     cmp expected14.sum actual14.sum &&
+     cmp -s expected14.sum actual14.sum &&
      sum bozbar frotz nitfol >actual14a.sum &&
-     if cmp M.sum actual14a.sum; then false; else :; fi &&
+     if cmp -s M.sum actual14a.sum; then false; else :; fi &&
      check_cache_at nitfol clean &&
      echo nitfol nitfol >nitfol1 &&
      diff nitfol nitfol1 &&
@@ -232,9 +232,9 @@ test_expect_success \
      check_cache_at nitfol dirty &&
      sum bozbar frotz >actual15.sum &&
      grep -v nitfol M.sum > expected15.sum &&
-     cmp expected15.sum actual15.sum &&
+     cmp -s expected15.sum actual15.sum &&
      sum bozbar frotz nitfol >actual15a.sum &&
-     if cmp M.sum actual15a.sum; then false; else :; fi &&
+     if cmp -s M.sum actual15a.sum; then false; else :; fi &&
      echo nitfol nitfol nitfol >nitfol1 &&
      diff nitfol nitfol1 &&
      rm -f nitfol1'
@@ -267,7 +267,7 @@ test_expect_success \
      diff -U0 M.out 18.out &&
      check_cache_at bozbar clean &&
      sum bozbar frotz nitfol >actual18.sum &&
-     cmp M.sum actual18.sum'
+     cmp -s M.sum actual18.sum'
 
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
@@ -282,9 +282,9 @@ test_expect_success \
      check_cache_at bozbar dirty &&
      sum frotz nitfol >actual19.sum &&
      grep -v bozbar  M.sum > expected19.sum &&
-     cmp expected19.sum actual19.sum &&
+     cmp -s expected19.sum actual19.sum &&
      sum bozbar frotz nitfol >actual19a.sum &&
-     if cmp M.sum actual19a.sum; then false; else :; fi &&
+     if cmp -s M.sum actual19a.sum; then false; else :; fi &&
      echo gnusto gnusto >bozbar1 &&
      diff bozbar bozbar1 &&
      rm -f bozbar1'
@@ -300,7 +300,7 @@ test_expect_success \
      diff -U0 M.out 20.out &&
      check_cache_at bozbar clean &&
      sum bozbar frotz nitfol >actual20.sum &&
-     cmp M.sum actual20.sum'
+     cmp -s M.sum actual20.sum'
 
 test_expect_success \
     '21 - no local change, dirty cache.' \
diff --git a/t/t1003-read-tree-prefix.sh b/t/t1003-read-tree-prefix.sh
index 48ab117..a7156b2 100755
--- a/t/t1003-read-tree-prefix.sh
+++ b/t/t1003-read-tree-prefix.sh
@@ -21,7 +21,7 @@ two/one' >expect
 test_expect_success 'read-tree --prefix' '
 	git-read-tree --prefix=two/ $tree &&
 	git-ls-files >actual &&
-	cmp expect actual
+	cmp -s expect actual
 '
 
 test_done
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 4409b87..8bd4174 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -46,10 +46,10 @@ test_expect_success 'cat-file' '
 	two=`expr "$two" : "[0-7]* \\([0-9a-f]*\\)"` &&
 	echo "$two" &&
 	git-cat-file -p "$two" >actual &&
-	cmp dir/two actual &&
+	cmp -s dir/two actual &&
 	cd dir &&
 	git-cat-file -p "$two" >actual &&
-	cmp two actual
+	cmp -s two actual
 '
 rm -f actual dir/actual
 
@@ -86,10 +86,10 @@ test_expect_success 'write-tree' '
 test_expect_success 'checkout-index' '
 	cd $HERE &&
 	git-checkout-index -f -u one &&
-	cmp one original.one &&
+	cmp -s one original.one &&
 	cd dir &&
 	git-checkout-index -f -u two &&
-	cmp two ../original.two
+	cmp -s two ../original.two
 '
 
 test_expect_success 'read-tree' '
@@ -97,13 +97,13 @@ test_expect_success 'read-tree' '
 	rm -f one dir/two &&
 	tree=`git-write-tree` &&
 	git-read-tree --reset -u "$tree" &&
-	cmp one original.one &&
-	cmp dir/two original.two &&
+	cmp -s one original.one &&
+	cmp -s dir/two original.two &&
 	cd dir &&
 	rm -f two &&
 	git-read-tree --reset -u "$tree" &&
-	cmp two ../original.two &&
-	cmp ../one ../original.one
+	cmp -s two ../original.two &&
+	cmp -s ../one ../original.one
 '
 
 test_done
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index c7db20e..2e2a898 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -27,9 +27,9 @@ index 557db03..263414f 100644
 +It's a new day for git
 EOF
 git-diff-files -p > diff.output
-test_expect_success 'git-diff-files -p' 'cmp diff.expect diff.output'
+test_expect_success 'git-diff-files -p' 'cmp -s diff.expect diff.output'
 git diff > diff.output
-test_expect_success 'git diff' 'cmp diff.expect diff.output'
+test_expect_success 'git diff' 'cmp -s diff.expect diff.output'
 
 tree=$(git-write-tree 2>/dev/null)
 
@@ -40,10 +40,10 @@ output="$(echo "Initial commit" | git-co
 test_expect_success 'commit' "test 'Committing initial tree 8988da15d077d4829fc51d8544c097def6644dbb' = \"$output\""
 
 git-diff-index -p HEAD > diff.output
-test_expect_success 'git-diff-index -p HEAD' 'cmp diff.expect diff.output'
+test_expect_success 'git-diff-index -p HEAD' 'cmp -s diff.expect diff.output'
 
 git diff HEAD > diff.output
-test_expect_success 'git diff HEAD' 'cmp diff.expect diff.output'
+test_expect_success 'git diff HEAD' 'cmp -s diff.expect diff.output'
 
 #rm hello
 #test_expect_success 'git-read-tree --reset HEAD' "git-read-tree --reset HEAD ; test \"hello: needs update\" = \"$(git-update-index --refresh)\""
@@ -75,15 +75,15 @@ git-whatchanged -p --root | \
 	sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
 		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
 > whatchanged.output
-test_expect_success 'git-whatchanged -p --root' 'cmp whatchanged.expect whatchanged.output'
+test_expect_success 'git-whatchanged -p --root' 'cmp -s whatchanged.expect whatchanged.output'
 
 git tag my-first-tag
-test_expect_success 'git tag my-first-tag' 'cmp .git/refs/heads/master .git/refs/tags/my-first-tag'
+test_expect_success 'git tag my-first-tag' 'cmp -s .git/refs/heads/master .git/refs/tags/my-first-tag'
 
 # TODO: test git-clone
 
 git checkout -b mybranch
-test_expect_success 'git checkout -b mybranch' 'cmp .git/refs/heads/master .git/refs/heads/mybranch'
+test_expect_success 'git checkout -b mybranch' 'cmp -s .git/refs/heads/master .git/refs/heads/mybranch'
 
 cat > branch.expect <<EOF
   master
@@ -91,7 +91,7 @@ cat > branch.expect <<EOF
 EOF
 
 git branch > branch.output
-test_expect_success 'git branch' 'cmp branch.expect branch.output'
+test_expect_success 'git branch' 'cmp -s branch.expect branch.output'
 
 git checkout mybranch
 echo "Work, work, work" >>hello
@@ -125,7 +125,7 @@ cat > show-branch.expect << EOF
 EOF
 
 git show-branch --topo-order master mybranch > show-branch.output
-test_expect_success 'git show-branch' 'cmp show-branch.expect show-branch.output'
+test_expect_success 'git show-branch' 'cmp -s show-branch.expect show-branch.output'
 
 git checkout mybranch
 
@@ -138,7 +138,7 @@ EOF
 
 git resolve HEAD master "Merge upstream changes." | \
 	sed -e "1s/[0-9a-f]\{40\}/VARIABLE/g" > resolve.output
-test_expect_success 'git resolve' 'cmp resolve.expect resolve.output'
+test_expect_success 'git resolve' 'cmp -s resolve.expect resolve.output'
 
 cat > show-branch2.expect << EOF
 ! [master] Merged "mybranch" changes.
@@ -148,7 +148,7 @@ cat > show-branch2.expect << EOF
 EOF
 
 git show-branch --topo-order master mybranch > show-branch2.output
-test_expect_success 'git show-branch' 'cmp show-branch2.expect show-branch2.output'
+test_expect_success 'git show-branch' 'cmp -s show-branch2.expect show-branch2.output'
 
 # TODO: test git fetch
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0de2497..5af856d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -16,7 +16,7 @@ cat > expect << EOF
 	penguin = little blue
 EOF
 
-test_expect_success 'initial' 'cmp .git/config expect'
+test_expect_success 'initial' 'cmp -s .git/config expect'
 
 git-repo-config Core.Movie BadPhysics
 
@@ -26,7 +26,7 @@ cat > expect << EOF
 	Movie = BadPhysics
 EOF
 
-test_expect_success 'mixed case' 'cmp .git/config expect'
+test_expect_success 'mixed case' 'cmp -s .git/config expect'
 
 git-repo-config Cores.WhatEver Second
 
@@ -38,7 +38,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 
-test_expect_success 'similar section' 'cmp .git/config expect'
+test_expect_success 'similar section' 'cmp -s .git/config expect'
 
 git-repo-config CORE.UPPERCASE true
 
@@ -51,7 +51,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 
-test_expect_success 'similar section' 'cmp .git/config expect'
+test_expect_success 'similar section' 'cmp -s .git/config expect'
 
 test_expect_success 'replace with non-match' \
 	'git-repo-config core.penguin kingpin !blue'
@@ -69,7 +69,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 
-test_expect_success 'non-match result' 'cmp .git/config expect'
+test_expect_success 'non-match result' 'cmp -s .git/config expect'
 
 cat > .git/config << EOF
 [beta] ; silly comment # another comment
@@ -97,7 +97,7 @@ # empty line
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'multiple unset is correct' 'cmp .git/config expect'
+test_expect_success 'multiple unset is correct' 'cmp -s .git/config expect'
 
 mv .git/config2 .git/config
 
@@ -114,7 +114,7 @@ # empty line
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'all replaced' 'cmp .git/config expect'
+test_expect_success 'all replaced' 'cmp -s .git/config expect'
 
 git-repo-config beta.haha alpha
 
@@ -128,7 +128,7 @@ # empty line
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'really mean test' 'cmp .git/config expect'
+test_expect_success 'really mean test' 'cmp -s .git/config expect'
 
 git-repo-config nextsection.nonewline wow
 
@@ -143,7 +143,7 @@ # empty line
 	nonewline = wow
 EOF
 
-test_expect_success 'really really mean test' 'cmp .git/config expect'
+test_expect_success 'really really mean test' 'cmp -s .git/config expect'
 
 test_expect_success 'get value' 'test alpha = $(git-repo-config beta.haha)'
 git-repo-config --unset beta.haha
@@ -158,7 +158,7 @@ # empty line
 	nonewline = wow
 EOF
 
-test_expect_success 'unset' 'cmp .git/config expect'
+test_expect_success 'unset' 'cmp -s .git/config expect'
 
 git-repo-config nextsection.NoNewLine "wow2 for me" "for me$"
 
@@ -173,7 +173,7 @@ # empty line
 	NoNewLine = wow2 for me
 EOF
 
-test_expect_success 'multivar' 'cmp .git/config expect'
+test_expect_success 'multivar' 'cmp -s .git/config expect'
 
 test_expect_success 'non-match' \
 	'git-repo-config --get nextsection.nonewline !for'
@@ -200,7 +200,7 @@ # empty line
 	NoNewLine = wow2 for me
 EOF
 
-test_expect_success 'multivar replace' 'cmp .git/config expect'
+test_expect_success 'multivar replace' 'cmp -s .git/config expect'
 
 test_expect_failure 'ambiguous value' 'git-repo-config nextsection.nonewline'
 
@@ -222,7 +222,7 @@ # empty line
 	NoNewLine = wow2 for me
 EOF
 
-test_expect_success 'multivar unset' 'cmp .git/config expect'
+test_expect_success 'multivar unset' 'cmp -s .git/config expect'
 
 test_expect_failure 'invalid key' 'git-repo-config inval.2key blabla'
 
@@ -245,7 +245,7 @@ # empty line
 	Alpha = beta
 EOF
 
-test_expect_success 'hierarchical section value' 'cmp .git/config expect'
+test_expect_success 'hierarchical section value' 'cmp -s .git/config expect'
 
 cat > expect << EOF
 beta.noindent=sillyValue
@@ -255,7 +255,7 @@ version.1.2.3eX.alpha=beta
 EOF
 
 test_expect_success 'working --list' \
-	'git-repo-config --list > output && cmp output expect'
+	'git-repo-config --list > output && cmp -s output expect'
 
 cat > expect << EOF
 beta.noindent sillyValue
@@ -263,7 +263,7 @@ nextsection.nonewline wow2 for me
 EOF
 
 test_expect_success '--get-regexp' \
-	'git-repo-config --get-regexp in > output && cmp output expect'
+	'git-repo-config --get-regexp in > output && cmp -s output expect'
 
 cat > .git/config << EOF
 [novalue]
@@ -292,7 +292,7 @@ cat > expect << EOF
 	x = y
 EOF
 
-test_expect_success 'new section is partial match of another' 'cmp .git/config expect'
+test_expect_success 'new section is partial match of another' 'cmp -s .git/config expect'
 
 git-repo-config b.x y
 git-repo-config a.b c
@@ -307,7 +307,7 @@ cat > expect << EOF
 	x = y
 EOF
 
-test_expect_success 'new variable inserts into proper section' 'cmp .git/config expect'
+test_expect_success 'new variable inserts into proper section' 'cmp -s .git/config expect'
 
 cat > other-config << EOF
 [ein]
@@ -320,7 +320,7 @@ EOF
 
 GIT_CONFIG=other-config git-repo-config -l > output
 
-test_expect_success 'alternative GIT_CONFIG' 'cmp output expect'
+test_expect_success 'alternative GIT_CONFIG' 'cmp -s output expect'
 
 GIT_CONFIG=other-config git-repo-config anwohner.park ausweis
 
@@ -331,7 +331,7 @@ cat > expect << EOF
 	park = ausweis
 EOF
 
-test_expect_success '--set in alternative GIT_CONFIG' 'cmp other-config expect'
+test_expect_success '--set in alternative GIT_CONFIG' 'cmp -s other-config expect'
 
 test_done
 
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index a78ea7f..bc452c4 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -17,7 +17,7 @@ test_expect_success 'update-index --add'
 	 echo goodbye people >file2 &&
 	 git-update-index --add file1 file2 &&
 	 git-ls-files -s >current &&
-	 cmp current expected'
+	 cmp -s current expected'
 
 test_expect_success 'update-index --again' \
 	'rm -f file1 &&
@@ -30,7 +30,7 @@ test_expect_success 'update-index --agai
 		echo happy - failed as expected
 	fi &&
 	 git-ls-files -s >current &&
-	 cmp current expected'
+	 cmp -s current expected'
 
 cat > expected <<\EOF
 100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
@@ -38,7 +38,7 @@ EOF
 test_expect_success 'update-index --remove --again' \
 	'git-update-index --remove --again &&
 	 git-ls-files -s >current &&
-	 cmp current expected'
+	 cmp -s current expected'
 
 test_expect_success 'first commit' 'git-commit -m initial'
 
@@ -55,7 +55,7 @@ test_expect_success 'update-index again'
 	echo happy >dir1/file3 &&
 	git-update-index --again &&
 	git-ls-files -s >current &&
-	cmp current expected'
+	cmp -s current expected'
 
 cat > expected <<\EOF
 100644 d7fb3f695f06c759dbf3ab00046e7cc2da22d10f 0	dir1/file3
@@ -68,7 +68,7 @@ test_expect_success 'update-index --upda
 	git-update-index --again &&
 	cd .. &&
 	git-ls-files -s >current &&
-	cmp current expected'
+	cmp -s current expected'
 
 cat > expected <<\EOF
 100644 594fb5bb1759d90998e2bf2a38261ae8e243c760 0	dir1/file3
@@ -79,6 +79,6 @@ test_expect_success 'update-index --upda
 	cat file2 >dir1/file3 &&
 	git-update-index --again dir1/ &&
 	git-ls-files -s >current &&
-	cmp current expected'
+	cmp -s current expected'
 
 test_done
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index c12270e..d2c1af8 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -24,7 +24,7 @@ EOF
 cat >"$p1" "$p0"
 echo 'Foo Bar Baz' >"$p2"
 
-test -f "$p1" && cmp "$p0" "$p1" || {
+test -f "$p1" && cmp -s "$p0" "$p1" || {
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
 	say 'Your filesystem does not allow tabs in filenames, test skipped.'
 	test_done
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 323606c..0ff3c4d 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -25,11 +25,11 @@ cat > expected <<\EOF
 EOF
 test_expect_success 'diff without --binary' \
 	'git-diff | git-apply --stat --summary >current &&
-	 cmp current expected'
+	 cmp -s current expected'
 
 test_expect_success 'diff with --binary' \
 	'git-diff --binary | git-apply --stat --summary >current &&
-	 cmp current expected'
+	 cmp -s current expected'
 
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
index 5988e1a..85ef40e 100755
--- a/t/t4109-apply-multifrag.sh
+++ b/t/t4109-apply-multifrag.sh
@@ -145,8 +145,8 @@ mv main.c main.c.git
 test_expect_success "S = patch (1)" \
     'cat patch1.patch patch2.patch | patch -p1'
 
-test_expect_success "S = cmp (1)" \
-    'cmp main.c.git main.c'
+test_expect_success "S = cmp -s (1)" \
+    'cmp -s main.c.git main.c'
 
 rm -f main.c main.c.git
 
@@ -157,8 +157,8 @@ mv main.c main.c.git
 test_expect_success "S = patch (2)" \
     'cat patch1.patch patch2.patch patch3.patch | patch -p1'
 
-test_expect_success "S = cmp (2)" \
-    'cmp main.c.git main.c'
+test_expect_success "S = cmp -s (2)" \
+    'cmp -s main.c.git main.c'
 
 rm -f main.c main.c.git
 
@@ -169,8 +169,8 @@ mv main.c main.c.git
 test_expect_success "S = patch (3)" \
     'cat patch1.patch patch4.patch | patch -p1'
 
-test_expect_success "S = cmp (3)" \
-    'cmp main.c.git main.c'
+test_expect_success "S = cmp -s (3)" \
+    'cmp -s main.c.git main.c'
 
 test_done
 
diff --git a/t/t4110-apply-scan.sh b/t/t4110-apply-scan.sh
index 005f744..3c767a4 100755
--- a/t/t4110-apply-scan.sh
+++ b/t/t4110-apply-scan.sh
@@ -95,7 +95,7 @@ test_expect_success "S = patch scan" \
 mv new.txt patch.txt
 
 test_expect_success "S = cmp" \
-    'cmp apply.txt patch.txt'
+    'cmp -s apply.txt patch.txt'
 
 test_done
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index de45ac4..5564162 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -56,7 +56,7 @@ test_expect_success \
     '(cd ../.git && find objects -type f -print) |
      while read path
      do
-         cmp $path ../.git/$path || {
+         cmp -s $path ../.git/$path || {
 	     echo $path differs.
 	     return 1
 	 }
@@ -86,7 +86,7 @@ test_expect_success \
     '(cd ../.git && find objects -type f -print) |
      while read path
      do
-         cmp $path ../.git/$path || {
+         cmp -s $path ../.git/$path || {
 	     echo $path differs.
 	     return 1
 	 }
@@ -182,17 +182,17 @@ test_expect_success \
     'build pack index for an existing pack' \
     'cp test-1-${packname_1}.pack test-3.pack &&
      git-index-pack -o tmp.idx test-3.pack &&
-     cmp tmp.idx test-1-${packname_1}.idx &&
+     cmp -s tmp.idx test-1-${packname_1}.idx &&
 
      git-index-pack test-3.pack &&
-     cmp test-3.idx test-1-${packname_1}.idx &&
+     cmp -s test-3.idx test-1-${packname_1}.idx &&
 
      cp test-2-${packname_2}.pack test-3.pack &&
      git-index-pack -o tmp.idx test-2-${packname_2}.pack &&
-     cmp tmp.idx test-2-${packname_2}.idx &&
+     cmp -s tmp.idx test-2-${packname_2}.idx &&
 
      git-index-pack test-3.pack &&
-     cmp test-3.idx test-2-${packname_2}.idx &&
+     cmp -s test-3.idx test-2-${packname_2}.idx &&
 
      :'
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index f3694ac..cb32283 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -52,7 +52,7 @@ test_expect_success \
 		echo >&2 Thanks, it correctly failed.
 		true
 	fi &&
-	if cmp victim/.git/refs/heads/master .git/refs/heads/master
+	if cmp -s victim/.git/refs/heads/master .git/refs/heads/master
 	then
 		# should have been left as it was!
 		false
@@ -61,7 +61,7 @@ test_expect_success \
 	fi &&
 	# this should update
 	git-send-pack --force ./victim/.git/ master &&
-	cmp victim/.git/refs/heads/master .git/refs/heads/master
+	cmp -s victim/.git/refs/heads/master .git/refs/heads/master
 '
 
 test_done
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index 8f7366d..97e85b9 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -93,6 +93,6 @@ cat > file-expect <<EOF
 9
 EOF
 
-test_expect_success 'Criss-cross merge result' 'cmp file file-expect'
+test_expect_success 'Criss-cross merge result' 'cmp -s file file-expect'
 
 test_done
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index a5a235f..e19c3df 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -97,7 +97,7 @@ test_expect_success 'fetch and pull late
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
-	test_expect_success "Comparing $i" "cmp $i new_wc/$i"
+	test_expect_success "Comparing $i" "cmp -s $i new_wc/$i"
 done
 
 
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index f994b72..315bdd3 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -35,7 +35,7 @@ test_expect_success 'test the commit-dif
 	test -n '$prev' && test -n '$head' &&
 	git-svn commit-diff '$prev' '$head' '$svnrepo' &&
 	svn co $svnrepo wc &&
-	cmp readme wc/readme
+	cmp -s readme wc/readme
 	"
 
 test_done
-- 
1.4.2.rc3.ge5673-dirty
