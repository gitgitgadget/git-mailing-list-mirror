From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 05/15] diff-test_cmp.patch
Date: Tue, 16 Mar 2010 05:42:25 +0000
Message-ID: <20100316054321.668397000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPjL-00038F-RZ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004Ab0CPFx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:29 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:56319 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757605Ab0CPFw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:58 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id C7B945CD5
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:43 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com C7B945CD5
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id CFBE3DE8;
	Tue, 16 Mar 2010 05:43:21 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id C80F811D4D5; Tue, 16 Mar 2010 05:43:21 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=diff-test_cmp.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142316>

In tests, call test_cmp rather than raw diff where possible (i.e. if
the output does not go to a pipe), to allow the use of, say, 'cmp'
when the default 'diff -u' is not compatible with a vendor diff.

When that is not possible, use $DIFF, as set in GIT-BUILD-OPTIONS.
---
 t/Makefile                      |    1 +
 t/t0000-basic.sh                |    2 +-
 t/t3200-branch.sh               |    4 ++--
 t/t3210-pack-refs.sh            |    8 ++++----
 t/t3903-stash.sh                |    2 +-
 t/t4002-diff-basic.sh           |    2 +-
 t/t4124-apply-ws-rule.sh        |   10 +++++-----
 t/t4127-apply-same-fn.sh        |    6 +++---
 t/t5300-pack-object.sh          |    6 +++---
 t/t5510-fetch.sh                |    2 +-
 t/t5520-pull.sh                 |    2 +-
 t/t5700-clone-reference.sh      |    8 ++++----
 t/t6000lib.sh                   |    2 +-
 t/t6001-rev-list-graft.sh       |    2 +-
 t/t6022-merge-rename.sh         |    4 ++--
 t/t7002-grep.sh                 |   16 ++++++++--------
 t/t7005-editor.sh               |    6 +++---
 t/t9200-git-cvsexportcommit.sh  |   26 +++++++++++++-------------
 t/t9400-git-cvsserver-server.sh |   24 ++++++++++++------------
 19 files changed, 67 insertions(+), 66 deletions(-)

Index: b/t/t0000-basic.sh
===================================================================
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -280,7 +280,7 @@ $expectfilter >expected <<\EOF
 EOF
 test_expect_success \
     'validate git diff-files output for a know cache/work tree state.' \
-    'git diff-files >current && diff >/dev/null -b current expected'
+    'git diff-files >current && test_cmp current expected >/dev/null'
 
 test_expect_success \
     'git update-index --refresh should succeed.' \
Index: b/t/t3200-branch.sh
===================================================================
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -43,7 +43,7 @@ test_expect_success \
      git branch -l d/e/f &&
 	 test -f .git/refs/heads/d/e/f &&
 	 test -f .git/logs/refs/heads/d/e/f &&
-	 diff expect .git/logs/refs/heads/d/e/f'
+	 test_cmp expect .git/logs/refs/heads/d/e/f'
 
 test_expect_success \
     'git branch -d d/e/f should delete a branch and a log' \
@@ -222,7 +222,7 @@ test_expect_success \
      git checkout -b g/h/i -l master &&
 	 test -f .git/refs/heads/g/h/i &&
 	 test -f .git/logs/refs/heads/g/h/i &&
-	 diff expect .git/logs/refs/heads/g/h/i'
+	 test_cmp expect .git/logs/refs/heads/g/h/i'
 
 test_expect_success 'avoid ambiguous track' '
 	git config branch.autosetupmerge true &&
Index: b/t/t3210-pack-refs.sh
===================================================================
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -28,7 +28,7 @@ test_expect_success \
      SHA1=`cat .git/refs/heads/a` &&
      echo "$SHA1 refs/heads/a" >expect &&
      git show-ref a >result &&
-     diff expect result'
+     test_cmp expect result'
 
 test_expect_success \
     'see if a branch still exists when packed' \
@@ -37,7 +37,7 @@ test_expect_success \
      rm -f .git/refs/heads/b &&
      echo "$SHA1 refs/heads/b" >expect &&
      git show-ref b >result &&
-     diff expect result'
+     test_cmp expect result'
 
 test_expect_success 'git branch c/d should barf if branch c exists' '
      git branch c &&
@@ -52,7 +52,7 @@ test_expect_success \
      git pack-refs --all --prune &&
      echo "$SHA1 refs/heads/e" >expect &&
      git show-ref e >result &&
-     diff expect result'
+     test_cmp expect result'
 
 test_expect_success 'see if git pack-refs --prune remove ref files' '
      git branch f &&
@@ -109,7 +109,7 @@ test_expect_success 'pack, prune and rep
 	git show-ref >all-of-them &&
 	git pack-refs &&
 	git show-ref >again &&
-	diff all-of-them again
+	test_cmp all-of-them again
 '
 
 test_done
Index: b/t/t4002-diff-basic.sh
===================================================================
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -135,7 +135,7 @@ cmp_diff_files_output () {
     # filesystem.
     sed <"$2" >.test-tmp \
 	-e '/^:000000 /d;s/'$x40'\( [MCRNDU][0-9]*\)	/'$z40'\1	/' &&
-    diff "$1" .test-tmp
+    test_cmp "$1" .test-tmp
 }
 
 test_expect_success \
Index: b/t/t4124-apply-ws-rule.sh
===================================================================
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -44,7 +44,7 @@ test_fix () {
 	apply_patch --whitespace=fix || return 1
 
 	# find touched lines
-	diff file target | sed -n -e "s/^> //p" >fixed
+	$DIFF file target | sed -n -e "s/^> //p" >fixed
 
 	# the changed lines are all expeced to change
 	fixed_cnt=$(wc -l <fixed)
@@ -85,14 +85,14 @@ test_expect_success setup '
 test_expect_success 'whitespace=nowarn, default rule' '
 
 	apply_patch --whitespace=nowarn &&
-	diff file target
+	test_cmp file target
 
 '
 
 test_expect_success 'whitespace=warn, default rule' '
 
 	apply_patch --whitespace=warn &&
-	diff file target
+	test_cmp file target
 
 '
 
@@ -108,7 +108,7 @@ test_expect_success 'whitespace=error-al
 
 	git config core.whitespace -trailing,-space-before,-indent &&
 	apply_patch --whitespace=error-all &&
-	diff file target
+	test_cmp file target
 
 '
 
@@ -117,7 +117,7 @@ test_expect_success 'whitespace=error-al
 	git config --unset core.whitespace &&
 	echo "target -whitespace" >.gitattributes &&
 	apply_patch --whitespace=error-all &&
-	diff file target
+	test_cmp file target
 
 '
 
Index: b/t/t5300-pack-object.sh
===================================================================
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -147,7 +147,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    diff expect current'
+    test_cmp expect current'
 
 test_expect_success \
     'use packed deltified (REF_DELTA) objects' \
@@ -162,7 +162,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    diff expect current'
+    test_cmp expect current'
 
 test_expect_success \
     'use packed deltified (OFS_DELTA) objects' \
@@ -177,7 +177,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    diff expect current'
+    test_cmp expect current'
 
 unset GIT_OBJECT_DIRECTORY
 
Index: b/t/t5510-fetch.sh
===================================================================
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -71,7 +71,7 @@ test_expect_success "fetch test for-merg
 		echo "$one_in_two	"
 	} >expected &&
 	cut -f -2 .git/FETCH_HEAD >actual &&
-	diff expected actual'
+	test_cmp expected actual'
 
 test_expect_success 'fetch tags when there is no tags' '
 
Index: b/t/t5520-pull.sh
===================================================================
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -26,7 +26,7 @@ cd "$D"
 test_expect_success 'checking the results' '
 	test -f file &&
 	test -f cloned/file &&
-	diff file cloned/file
+	test_cmp file cloned/file
 '
 
 test_expect_success 'pulling into void using master:master' '
Index: b/t/t5700-clone-reference.sh
===================================================================
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -48,7 +48,7 @@ test_expect_success 'that reference gets
 'cd C &&
 echo "0 objects, 0 kilobytes" > expected &&
 git count-objects > current &&
-diff expected current'
+test_cmp expected current'
 
 cd "$base_dir"
 
@@ -75,7 +75,7 @@ cd "$base_dir"
 test_expect_success 'that reference gets used' \
 'cd D && echo "0 objects, 0 kilobytes" > expected &&
 git count-objects > current &&
-diff expected current'
+test_cmp expected current'
 
 cd "$base_dir"
 
@@ -100,7 +100,7 @@ test_expect_success 'that alternate to o
 'cd C &&
 echo "2 objects" > expected &&
 git count-objects | cut -d, -f1 > current &&
-diff expected current'
+test_cmp expected current'
 
 cd "$base_dir"
 
@@ -116,7 +116,7 @@ test_expect_success 'check objects expec
 'cd D &&
 echo "5 objects" > expected &&
 git count-objects | cut -d, -f1 > current &&
-diff expected current'
+test_cmp expected current'
 
 cd "$base_dir"
 
Index: b/t/t6000lib.sh
===================================================================
--- a/t/t6000lib.sh
+++ b/t/t6000lib.sh
@@ -91,7 +91,7 @@ check_output()
 	shift 1
 	if eval "$*" | entag > $_name.actual
 	then
-		diff $_name.expected $_name.actual
+		test_cmp $_name.expected $_name.actual
 	else
 		return 1;
 	fi
Index: b/t/t6001-rev-list-graft.sh
===================================================================
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -84,7 +84,7 @@ check () {
 		git rev-list --parents --pretty=raw $arg |
 		sed -n -e 's/^commit //p' >test.actual
 	fi
-	diff test.expect test.actual
+	test_cmp test.expect test.actual
 }
 
 for type in basic parents parents-raw
Index: b/t/t6022-merge-rename.sh
===================================================================
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -280,7 +280,7 @@ test_expect_success 'updated working tre
 		echo "BAD: should have complained"
 		return 1
 	}
-	diff M M.saved || {
+	test_cmp M M.saved || {
 		echo "BAD: should have left M intact"
 		return 1
 	}
@@ -301,7 +301,7 @@ test_expect_success 'updated working tre
 		echo "BAD: should have complained"
 		return 1
 	}
-	diff M M.saved || {
+	test_cmp M M.saved || {
 		echo "BAD: should have left M intact"
 		return 1
 	}
Index: b/t/t7002-grep.sh
===================================================================
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -60,7 +60,7 @@ do
 			echo ${HC}file:5:foo_mmap bar mmap baz
 		} >expected &&
 		git grep -n -w -e mmap $H >actual &&
-		diff expected actual
+		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (w)" '
@@ -74,7 +74,7 @@ do
 			echo ${HC}x:1:x x xx x
 		} >expected &&
 		git grep -n -w -e "x xx* x" $H >actual &&
-		diff expected actual
+		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (y-1)" '
@@ -82,7 +82,7 @@ do
 			echo ${HC}y:1:y yy
 		} >expected &&
 		git grep -n -w -e "^y" $H >actual &&
-		diff expected actual
+		test_cmp expected actual
 	'
 
 	test_expect_success "grep -w $L (y-2)" '
@@ -93,7 +93,7 @@ do
 			cat actual
 			false
 		else
-			diff expected actual
+			test_cmp expected actual
 		fi
 	'
 
@@ -105,14 +105,14 @@ do
 			cat actual
 			false
 		else
-			diff expected actual
+			test_cmp expected actual
 		fi
 	'
 
 	test_expect_success "grep $L (t-1)" '
 		echo "${HC}t/t:1:test" >expected &&
 		git grep -n -e test $H >actual &&
-		diff expected actual
+		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L (t-2)" '
@@ -121,7 +121,7 @@ do
 			cd t &&
 			git grep -n -e test $H
 		) >actual &&
-		diff expected actual
+		test_cmp expected actual
 	'
 
 	test_expect_success "grep $L (t-3)" '
@@ -130,7 +130,7 @@ do
 			cd t &&
 			git grep --full-name -n -e test $H
 		) >actual &&
-		diff expected actual
+		test_cmp expected actual
 	'
 
 	test_expect_success "grep -c $L (no /dev/null)" '
Index: b/t/t7005-editor.sh
===================================================================
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -38,7 +38,7 @@ test_expect_success setup '
 	test_commit "$msg" &&
 	echo "$msg" >expect &&
 	git show -s --format=%s > actual &&
-	diff actual expect
+	test_cmp actual expect
 
 '
 
@@ -85,7 +85,7 @@ do
 		git --exec-path=. commit --amend &&
 		git show -s --pretty=oneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&
-		diff actual expect
+		test_cmp actual expect
 	'
 done
 
@@ -107,7 +107,7 @@ do
 		git --exec-path=. commit --amend &&
 		git show -s --pretty=oneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&
-		diff actual expect
+		test_cmp actual expect
 	'
 done
 
Index: b/t/t9200-git-cvsexportcommit.sh
===================================================================
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -63,10 +63,10 @@ test_expect_success \
      check_entries B "newfile2.txt/1.1/" &&
      check_entries C "newfile3.png/1.1/-kb" &&
      check_entries D "newfile4.png/1.1/-kb" &&
-     diff A/newfile1.txt ../A/newfile1.txt &&
-     diff B/newfile2.txt ../B/newfile2.txt &&
-     diff C/newfile3.png ../C/newfile3.png &&
-     diff D/newfile4.png ../D/newfile4.png
+     test_cmp A/newfile1.txt ../A/newfile1.txt &&
+     test_cmp B/newfile2.txt ../B/newfile2.txt &&
+     test_cmp C/newfile3.png ../C/newfile3.png &&
+     test_cmp D/newfile4.png ../D/newfile4.png
      )'
 
 test_expect_success \
@@ -89,10 +89,10 @@ test_expect_success \
      check_entries D "newfile4.png/1.2/-kb" &&
      check_entries E "newfile5.txt/1.1/" &&
      check_entries F "newfile6.png/1.1/-kb" &&
-     diff A/newfile1.txt ../A/newfile1.txt &&
-     diff D/newfile4.png ../D/newfile4.png &&
-     diff E/newfile5.txt ../E/newfile5.txt &&
-     diff F/newfile6.png ../F/newfile6.png
+     test_cmp A/newfile1.txt ../A/newfile1.txt &&
+     test_cmp D/newfile4.png ../D/newfile4.png &&
+     test_cmp E/newfile5.txt ../E/newfile5.txt &&
+     test_cmp F/newfile6.png ../F/newfile6.png
      )'
 
 # Should fail (but only on the git cvsexportcommit stage)
@@ -137,9 +137,9 @@ test_expect_success \
      check_entries D "" &&
      check_entries E "newfile5.txt/1.1/" &&
      check_entries F "newfile6.png/1.1/-kb" &&
-     diff A/newfile1.txt ../A/newfile1.txt &&
-     diff E/newfile5.txt ../E/newfile5.txt &&
-     diff F/newfile6.png ../F/newfile6.png
+     test_cmp A/newfile1.txt ../A/newfile1.txt &&
+     test_cmp E/newfile5.txt ../E/newfile5.txt &&
+     test_cmp F/newfile6.png ../F/newfile6.png
      )'
 
 test_expect_success \
@@ -155,8 +155,8 @@ test_expect_success \
      check_entries D "" &&
      check_entries E "newfile5.txt/1.1/" &&
      check_entries F "newfile6.png/1.1/-kb" &&
-     diff E/newfile5.txt ../E/newfile5.txt &&
-     diff F/newfile6.png ../F/newfile6.png
+     test_cmp E/newfile5.txt ../E/newfile5.txt &&
+     test_cmp F/newfile6.png ../F/newfile6.png
      )'
 
 test_expect_success \
Index: b/t/t9400-git-cvsserver-server.sh
===================================================================
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -226,7 +226,7 @@ test_expect_success 'gitcvs.ext.enabled 
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2'
+   test_cmp cvswork cvswork2' >/dev/null
 
 rm -fr cvswork2
 test_expect_success 'gitcvs.ext.enabled = false' \
@@ -247,7 +247,7 @@ test_expect_success 'gitcvs.dbname' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2 &&
+   test_cmp cvswork cvswork2 >/dev/null &&
    test -f "$SERVERDIR/gitcvs.ext.master.sqlite" &&
    cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs.ext.master.sqlite"'
 
@@ -257,7 +257,7 @@ test_expect_success 'gitcvs.ext.dbname' 
    GIT_DIR="$SERVERDIR" git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
    GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2 &&
+   test_cmp cvswork cvswork2 >/dev/null &&
    test -f "$SERVERDIR/gitcvs1.ext.master.sqlite" &&
    test ! -f "$SERVERDIR/gitcvs2.ext.master.sqlite" &&
    cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs1.ext.master.sqlite"'
@@ -282,7 +282,7 @@ test_expect_success 'cvs update (create 
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
-   diff -q testfile1 ../testfile1'
+   test_cmp testfile1 ../testfile1' >/dev/null
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (update existing file)' \
@@ -293,7 +293,7 @@ test_expect_success 'cvs update (update 
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.2/" &&
-   diff -q testfile1 ../testfile1'
+   test_cmp testfile1 ../testfile1' >/dev/null
 
 cd "$WORKDIR"
 #TODO: cvsserver doesn't support update w/o -d
@@ -322,7 +322,7 @@ test_expect_success 'cvs update (subdire
    (for dir in A A/B A/B/C A/D E; do
       filename="file_in_$(echo $dir|sed -e "s#/# #g")" &&
       if test "$(echo $(grep -v ^D $dir/CVS/Entries|cut -d/ -f2,3,5))" = "$filename/1.1/" &&
-           diff -q "$dir/$filename" "../$dir/$filename"; then
+           test_cmp "$dir/$filename" "../$dir/$filename" >/dev/null; then
         :
       else
         echo >failure
@@ -349,7 +349,7 @@ test_expect_success 'cvs update (re-add 
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
-   diff -q testfile1 ../testfile1'
+   test_cmp testfile1 ../testfile1' >/dev/null
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (merge)' \
@@ -366,7 +366,7 @@ test_expect_success 'cvs update (merge)'
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep merge CVS/Entries|cut -d/ -f2,3,5))" = "merge/1.1/" &&
-   diff -q merge ../merge &&
+   test_cmp merge ../merge >/dev/null &&
    ( echo Line 0; cat merge ) >merge.tmp &&
    mv merge.tmp merge &&
    cd "$WORKDIR" &&
@@ -377,7 +377,7 @@ test_expect_success 'cvs update (merge)'
    cd cvswork &&
    sleep 1 && touch merge &&
    GIT_CONFIG="$git_config" cvs -Q update &&
-   diff -q merge ../expected'
+   test_cmp merge ../expected' >/dev/null
 
 cd "$WORKDIR"
 
@@ -402,13 +402,13 @@ test_expect_success 'cvs update (conflic
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
-   diff -q merge ../expected.C'
+   test_cmp merge ../expected.C' >/dev/null
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (-C)' \
   'cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update -C &&
-   diff -q merge ../merge'
+   test_cmp merge ../merge' >/dev/null
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (merge no-op)' \
@@ -420,7 +420,7 @@ test_expect_success 'cvs update (merge n
     cd cvswork &&
     sleep 1 && touch merge &&
     GIT_CONFIG="$git_config" cvs -Q update &&
-    diff -q merge ../merge'
+    test_cmp merge ../merge' >/dev/null
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (-p)' '
Index: b/t/t3903-stash.sh
===================================================================
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -81,7 +81,7 @@ test_expect_success 'drop top stash' '
 	git stash &&
 	git stash drop &&
 	git stash list > stashlist2 &&
-	diff stashlist1 stashlist2 &&
+	test_cmp stashlist1 stashlist2 &&
 	git stash apply &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
Index: b/t/t4127-apply-same-fn.sh
===================================================================
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -27,7 +27,7 @@ test_expect_success 'apply same filename
 	cp same_fn same_fn2 &&
 	git reset --hard &&
 	git apply patch0 &&
-	diff same_fn same_fn2
+	test_cmp same_fn same_fn2
 '
 
 test_expect_success 'apply same filename with overlapping changes' '
@@ -40,7 +40,7 @@ test_expect_success 'apply same filename
 	cp same_fn same_fn2 &&
 	git reset --hard &&
 	git apply patch0 &&
-	diff same_fn same_fn2
+	test_cmp same_fn same_fn2
 '
 
 test_expect_success 'apply same new filename after rename' '
@@ -54,7 +54,7 @@ test_expect_success 'apply same new file
 	cp new_fn new_fn2 &&
 	git reset --hard &&
 	git apply --index patch1 &&
-	diff new_fn new_fn2
+	test_cmp new_fn new_fn2
 '
 
 test_expect_success 'apply same old filename after rename -- should fail.' '
Index: b/t/Makefile
===================================================================
--- a/t/Makefile
+++ b/t/Makefile
@@ -6,6 +6,7 @@
 -include ../config.mak
 
 #GIT_TEST_OPTS=--verbose --debug
+GIT_TEST_CMP ?= $(DIFF)
 SHELL_PATH ?= $(SHELL)
 TAR ?= $(TAR)
 RM ?= rm -f

-- 
Gary V. Vaughan (gary@thewrittenword.com)
