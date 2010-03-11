From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH 2/5] Not all vendor diffs support GNUisms (resend)
Date: Thu, 11 Mar 2010 16:30:39 +0000
Message-ID: <20100311163039.GB7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 17:30:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NplHb-0001jX-ML
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 17:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133Ab0CKQam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 11:30:42 -0500
Received: from mail1.thewrittenword.com ([69.67.212.77]:59629 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372Ab0CKQak (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 11:30:40 -0500
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id E43165CDF
	for <git@vger.kernel.org>; Thu, 11 Mar 2010 16:49:49 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com E43165CDF
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 38C73D72
	for <git@vger.kernel.org>; Thu, 11 Mar 2010 16:30:39 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 2E98EBAB1; Thu, 11 Mar 2010 16:30:39 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141982>

Some of the flags used with the first diff found in PATH cause the
vendor diff to choke.

This patch allows us to replace the problematic diff calls in our
build script as follows:

  if [ "${SB_VAR_DIFFUTILS+set}" = set ]; then
    ${SB_PATH_SED} -i -e "\
s|@DIFF@|${SB_VAR_DIFFUTILS}/bin/gnudiff|g;" \
    $(find . -type f -exec ${SB_PATH_EGREP} -l '@DIFF@' {} \;)
  else
    ${SB_PATH_SED} -i -e "\
s|@DIFF@|diff|g;" \
    $(find . -type f -exec ${SB_PATH_EGREP} -l '@DIFF@' {} \;)
  fi

This is fine for us, but upstream it would be better to search
the execution path for a diff that has all the required features at
configure time, and to do the substitutions at that time.  This is
what the latest version of quilt does if an example is useful.
---
 Documentation/install-webdoc.sh |    2 +-
 contrib/examples/git-commit.sh  |    2 +-
 contrib/hooks/setgitperms.perl  |    2 +-
 git-cvsserver.perl              |    4 ++--
 git-merge-one-file.sh           |    4 +++-
 git-svn.perl                    |    2 +-
 t/t0000-basic.sh                |    2 +-
 t/t1002-read-tree-m-u-2way.sh   |    6 +++---
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
 t/test-lib.sh                   |    2 +-
 26 files changed, 79 insertions(+), 77 deletions(-)

diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
index 2135a8e..329d052 100755
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -12,7 +12,7 @@ do
 	then
 		: did not match
 	elif test -f "$T/$h" &&
-	   diff -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
+	   @DIFF@ -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
 	then
 		:; # up to date
 	else
diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 5c72f65..726e102 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -576,7 +576,7 @@ then
 		# Test whether this is just the unaltered template.
 		if cnt=`sed -e '/^#/d' < "$templatefile" |
 			git stripspace |
-			diff "$GIT_DIR"/COMMIT_BAREMSG - |
+			@DIFF@ "$GIT_DIR"/COMMIT_BAREMSG - |
 			wc -l` &&
 		   test 0 -lt $cnt
 		then
diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index a577ad0..c45ab0d 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -180,7 +180,7 @@ elsif ($read_mode) {
 	    rename "$gitmeta.tmp", $gitmeta;
 	}
 	else {
-	    my $diff = `diff -U 0 $gitmeta $gitmeta.tmp`;
+	    my $diff = `@DIFF@ -U 0 $gitmeta $gitmeta.tmp`;
 	    if ($diff ne '') {
 		rename "$gitmeta.tmp", $gitmeta;
 	    }
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13751db..3b78497 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1716,9 +1716,9 @@ sub req_diff
 
         if ( exists $state->{opt}{u} )
         {
-            system("diff -u -L '$filename revision 1.$meta1->{revision}' -L '$filename " . ( defined($meta2->{revision}) ? "revision 1.$meta2->{revision}" : "working copy" ) . "' $file1 $file2 > $filediff");
+            system("@DIFF@ -u -L '$filename revision 1.$meta1->{revision}' -L '$filename " . ( defined($meta2->{revision}) ? "revision 1.$meta2->{revision}" : "working copy" ) . "' $file1 $file2 > $filediff");
         } else {
-            system("diff $file1 $file2 > $filediff");
+            system("@DIFF@ $file1 $file2 > $filediff");
         }
 
         while ( <$fh> )
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index d067894..826b979 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -28,6 +28,8 @@ then
 	exit 1
 fi
 
+DIFF="@DIFF@"
+
 case "${1:-.}${2:-.}${3:-.}" in
 #
 # Deleted in both or deleted in one and unchanged in the other
@@ -107,7 +109,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# remove lines that are unique to ours.
 		orig=`git-unpack-file $2`
 		sz0=`wc -c <"$orig"`
-		diff -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
+		$DIFF -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
 		sz1=`wc -c <"$orig"`
 
 		# If we do not have enough common material, it is not
diff --git a/git-svn.perl b/git-svn.perl
index 1a26843..037bc15 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1592,7 +1592,7 @@ sub find_file_type_and_diff_status {
 	return ('dir', '') if $path eq '';
 
 	my $diff_output =
-	    command_oneline(qw(diff --cached --name-status --), $path) || "";
+	    command_oneline(qw(@DIFF@ --cached --name-status --), $path) || "";
 	my $diff_status = (split(' ', $diff_output))[0] || "";
 
 	my $ls_tree = command_oneline(qw(ls-tree HEAD), $path) || "";
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ca4fc..5444527 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -280,7 +280,7 @@ $expectfilter >expected <<\EOF
 EOF
 test_expect_success \
     'validate git diff-files output for a know cache/work tree state.' \
-    'git diff-files >current && diff >/dev/null -b current expected'
+    'git diff-files >current && @DIFF@ >/dev/null -b current expected'
 
 test_expect_success \
     'git update-index --refresh should succeed.' \
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 0241329..0330f13 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -215,7 +215,7 @@ test_expect_success \
      if cmp M.sum actual14a.sum; then false; else :; fi &&
      check_cache_at nitfol clean &&
      echo nitfol nitfol >nitfol1 &&
-     diff nitfol nitfol1 &&
+     @DIFF@ nitfol nitfol1 &&
      rm -f nitfol1'
 
 test_expect_success \
@@ -236,7 +236,7 @@ test_expect_success \
      sum bozbar frotz nitfol >actual15a.sum &&
      if cmp M.sum actual15a.sum; then false; else :; fi &&
      echo nitfol nitfol nitfol >nitfol1 &&
-     diff nitfol nitfol1 &&
+     @DIFF@ nitfol nitfol1 &&
      rm -f nitfol1'
 
 test_expect_success \
@@ -286,7 +286,7 @@ test_expect_success \
      sum bozbar frotz nitfol >actual19a.sum &&
      if cmp M.sum actual19a.sum; then false; else :; fi &&
      echo gnusto gnusto >bozbar1 &&
-     diff bozbar bozbar1 &&
+     @DIFF@ bozbar bozbar1 &&
      rm -f bozbar1'
 
 test_expect_success \
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e0b7605..9abfb42 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -43,7 +43,7 @@ test_expect_success \
      git branch -l d/e/f &&
 	 test -f .git/refs/heads/d/e/f &&
 	 test -f .git/logs/refs/heads/d/e/f &&
-	 diff expect .git/logs/refs/heads/d/e/f'
+	 @DIFF@ expect .git/logs/refs/heads/d/e/f'
 
 test_expect_success \
     'git branch -d d/e/f should delete a branch and a log' \
@@ -222,7 +222,7 @@ test_expect_success \
      git checkout -b g/h/i -l master &&
 	 test -f .git/refs/heads/g/h/i &&
 	 test -f .git/logs/refs/heads/g/h/i &&
-	 diff expect .git/logs/refs/heads/g/h/i'
+	 @DIFF@ expect .git/logs/refs/heads/g/h/i'
 
 test_expect_success 'avoid ambiguous track' '
 	git config branch.autosetupmerge true &&
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 413019a..2a559d3 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -28,7 +28,7 @@ test_expect_success \
      SHA1=`cat .git/refs/heads/a` &&
      echo "$SHA1 refs/heads/a" >expect &&
      git show-ref a >result &&
-     diff expect result'
+     @DIFF@ expect result'
 
 test_expect_success \
     'see if a branch still exists when packed' \
@@ -37,7 +37,7 @@ test_expect_success \
      rm -f .git/refs/heads/b &&
      echo "$SHA1 refs/heads/b" >expect &&
      git show-ref b >result &&
-     diff expect result'
+     @DIFF@ expect result'
 
 test_expect_success 'git branch c/d should barf if branch c exists' '
      git branch c &&
@@ -52,7 +52,7 @@ test_expect_success \
      git pack-refs --all --prune &&
      echo "$SHA1 refs/heads/e" >expect &&
      git show-ref e >result &&
-     diff expect result'
+     @DIFF@ expect result'
 
 test_expect_success 'see if git pack-refs --prune remove ref files' '
      git branch f &&
@@ -109,7 +109,7 @@ test_expect_success 'pack, prune and repack' '
 	git show-ref >all-of-them &&
 	git pack-refs &&
 	git show-ref >again &&
-	diff all-of-them again
+	@DIFF@ all-of-them again
 '
 
 test_done
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 476e5ec..2c38807 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -81,7 +81,7 @@ test_expect_success 'drop top stash' '
 	git stash &&
 	git stash drop &&
 	git stash list > stashlist2 &&
-	diff stashlist1 stashlist2 &&
+	@DIFF@ stashlist1 stashlist2 &&
 	git stash apply &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 18695ce..5c9f07b 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -135,7 +135,7 @@ cmp_diff_files_output () {
     # filesystem.
     sed <"$2" >.test-tmp \
 	-e '/^:000000 /d;s/'$x40'\( [MCRNDU][0-9]*\)	/'$z40'\1	/' &&
-    diff "$1" .test-tmp
+    @DIFF@ "$1" .test-tmp
 }
 
 test_expect_success \
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ca26397..844c6fd 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -44,7 +44,7 @@ test_fix () {
 	apply_patch --whitespace=fix || return 1
 
 	# find touched lines
-	diff file target | sed -n -e "s/^> //p" >fixed
+	@DIFF@ file target | sed -n -e "s/^> //p" >fixed
 
 	# the changed lines are all expeced to change
 	fixed_cnt=$(wc -l <fixed)
@@ -85,14 +85,14 @@ test_expect_success setup '
 test_expect_success 'whitespace=nowarn, default rule' '
 
 	apply_patch --whitespace=nowarn &&
-	diff file target
+	@DIFF@ file target
 
 '
 
 test_expect_success 'whitespace=warn, default rule' '
 
 	apply_patch --whitespace=warn &&
-	diff file target
+	@DIFF@ file target
 
 '
 
@@ -108,7 +108,7 @@ test_expect_success 'whitespace=error-all, no rule' '
 
 	git config core.whitespace -trailing,-space-before,-indent &&
 	apply_patch --whitespace=error-all &&
-	diff file target
+	@DIFF@ file target
 
 '
 
@@ -117,7 +117,7 @@ test_expect_success 'whitespace=error-all, no rule (attribute)' '
 	git config --unset core.whitespace &&
 	echo "target -whitespace" >.gitattributes &&
 	apply_patch --whitespace=error-all &&
-	diff file target
+	@DIFF@ file target
 
 '
 
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 3a8202e..a3b8818 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -27,7 +27,7 @@ test_expect_success 'apply same filename with independent changes' '
 	cp same_fn same_fn2 &&
 	git reset --hard &&
 	git apply patch0 &&
-	diff same_fn same_fn2
+	@DIFF@ same_fn same_fn2
 '
 
 test_expect_success 'apply same filename with overlapping changes' '
@@ -40,7 +40,7 @@ test_expect_success 'apply same filename with overlapping changes' '
 	cp same_fn same_fn2 &&
 	git reset --hard &&
 	git apply patch0 &&
-	diff same_fn same_fn2
+	@DIFF@ same_fn same_fn2
 '
 
 test_expect_success 'apply same new filename after rename' '
@@ -54,7 +54,7 @@ test_expect_success 'apply same new filename after rename' '
 	cp new_fn new_fn2 &&
 	git reset --hard &&
 	git apply --index patch1 &&
-	diff new_fn new_fn2
+	@DIFF@ new_fn new_fn2
 '
 
 test_expect_success 'apply same old filename after rename -- should fail.' '
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 7649b81..984acbb 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -147,7 +147,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    diff expect current'
+    @DIFF@ expect current'
 
 test_expect_success \
     'use packed deltified (REF_DELTA) objects' \
@@ -162,7 +162,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    diff expect current'
+    @DIFF@ expect current'
 
 test_expect_success \
     'use packed deltified (OFS_DELTA) objects' \
@@ -177,7 +177,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    diff expect current'
+    @DIFF@ expect current'
 
 unset GIT_OBJECT_DIRECTORY
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 721821e..841de41 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -71,7 +71,7 @@ test_expect_success "fetch test for-merge" '
 		echo "$one_in_two	"
 	} >expected &&
 	cut -f -2 .git/FETCH_HEAD >actual &&
-	diff expected actual'
+	@DIFF@ expected actual'
 
 test_expect_success 'fetch tags when there is no tags' '
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index dd2ee84..2a042c3 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -26,7 +26,7 @@ cd "$D"
 test_expect_success 'checking the results' '
 	test -f file &&
 	test -f cloned/file &&
-	diff file cloned/file
+	@DIFF@ file cloned/file
 '
 
 test_expect_success 'pulling into void using master:master' '
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 1c10916..e396c66 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -48,7 +48,7 @@ test_expect_success 'that reference gets used' \
 'cd C &&
 echo "0 objects, 0 kilobytes" > expected &&
 git count-objects > current &&
-diff expected current'
+@DIFF@ expected current'
 
 cd "$base_dir"
 
@@ -75,7 +75,7 @@ cd "$base_dir"
 test_expect_success 'that reference gets used' \
 'cd D && echo "0 objects, 0 kilobytes" > expected &&
 git count-objects > current &&
-diff expected current'
+@DIFF@ expected current'
 
 cd "$base_dir"
 
@@ -100,7 +100,7 @@ test_expect_success 'that alternate to origin gets used' \
 'cd C &&
 echo "2 objects" > expected &&
 git count-objects | cut -d, -f1 > current &&
-diff expected current'
+@DIFF@ expected current'
 
 cd "$base_dir"
 
@@ -116,7 +116,7 @@ test_expect_success 'check objects expected to exist locally' \
 'cd D &&
 echo "5 objects" > expected &&
 git count-objects | cut -d, -f1 > current &&
-diff expected current'
+@DIFF@ expected current'
 
 cd "$base_dir"
 
diff --git a/t/t6000lib.sh b/t/t6000lib.sh
index 985d517..9a6e3c1 100644
--- a/t/t6000lib.sh
+++ b/t/t6000lib.sh
@@ -91,7 +91,7 @@ check_output()
 	shift 1
 	if eval "$*" | entag > $_name.actual
 	then
-		diff $_name.expected $_name.actual
+		@DIFF@ $_name.expected $_name.actual
 	else
 		return 1;
 	fi
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index b2131cd..b3891cd 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -84,7 +84,7 @@ check () {
 		git rev-list --parents --pretty=raw $arg |
 		sed -n -e 's/^commit //p' >test.actual
 	fi
-	diff test.expect test.actual
+	@DIFF@ test.expect test.actual
 }
 
 for type in basic parents parents-raw
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index e3f7ae8..4015f1b 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -280,7 +280,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 		echo "BAD: should have complained"
 		return 1
 	}
-	diff M M.saved || {
+	@DIFF@ M M.saved || {
 		echo "BAD: should have left M intact"
 		return 1
 	}
@@ -301,7 +301,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 		echo "BAD: should have complained"
 		return 1
 	}
-	diff M M.saved || {
+	@DIFF@ M M.saved || {
 		echo "BAD: should have left M intact"
 		return 1
 	}
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index e249c3e..bab7b59 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -60,7 +60,7 @@ do
 			echo ${HC}file:5:foo_mmap bar mmap baz
 		} >expected &&
 		git grep -n -w -e mmap $H >actual &&
-		diff expected actual
+		@DIFF@ expected actual
 	'
 
 	test_expect_success "grep -w $L (w)" '
@@ -74,7 +74,7 @@ do
 			echo ${HC}x:1:x x xx x
 		} >expected &&
 		git grep -n -w -e "x xx* x" $H >actual &&
-		diff expected actual
+		@DIFF@ expected actual
 	'
 
 	test_expect_success "grep -w $L (y-1)" '
@@ -82,7 +82,7 @@ do
 			echo ${HC}y:1:y yy
 		} >expected &&
 		git grep -n -w -e "^y" $H >actual &&
-		diff expected actual
+		@DIFF@ expected actual
 	'
 
 	test_expect_success "grep -w $L (y-2)" '
@@ -93,7 +93,7 @@ do
 			cat actual
 			false
 		else
-			diff expected actual
+			@DIFF@ expected actual
 		fi
 	'
 
@@ -105,14 +105,14 @@ do
 			cat actual
 			false
 		else
-			diff expected actual
+			@DIFF@ expected actual
 		fi
 	'
 
 	test_expect_success "grep $L (t-1)" '
 		echo "${HC}t/t:1:test" >expected &&
 		git grep -n -e test $H >actual &&
-		diff expected actual
+		@DIFF@ expected actual
 	'
 
 	test_expect_success "grep $L (t-2)" '
@@ -121,7 +121,7 @@ do
 			cd t &&
 			git grep -n -e test $H
 		) >actual &&
-		diff expected actual
+		@DIFF@ expected actual
 	'
 
 	test_expect_success "grep $L (t-3)" '
@@ -130,7 +130,7 @@ do
 			cd t &&
 			git grep --full-name -n -e test $H
 		) >actual &&
-		diff expected actual
+		@DIFF@ expected actual
 	'
 
 	test_expect_success "grep -c $L (no /dev/null)" '
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 5257f4d..c5ea314 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -38,7 +38,7 @@ test_expect_success setup '
 	test_commit "$msg" &&
 	echo "$msg" >expect &&
 	git show -s --format=%s > actual &&
-	diff actual expect
+	@DIFF@ actual expect
 
 '
 
@@ -85,7 +85,7 @@ do
 		git --exec-path=. commit --amend &&
 		git show -s --pretty=oneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&
-		diff actual expect
+		@DIFF@ actual expect
 	'
 done
 
@@ -107,7 +107,7 @@ do
 		git --exec-path=. commit --amend &&
 		git show -s --pretty=oneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&
-		diff actual expect
+		@DIFF@ actual expect
 	'
 done
 
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index fc3795d..dfe25bc 100755
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
+     @DIFF@ A/newfile1.txt ../A/newfile1.txt &&
+     @DIFF@ B/newfile2.txt ../B/newfile2.txt &&
+     @DIFF@ C/newfile3.png ../C/newfile3.png &&
+     @DIFF@ D/newfile4.png ../D/newfile4.png
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
+     @DIFF@ A/newfile1.txt ../A/newfile1.txt &&
+     @DIFF@ D/newfile4.png ../D/newfile4.png &&
+     @DIFF@ E/newfile5.txt ../E/newfile5.txt &&
+     @DIFF@ F/newfile6.png ../F/newfile6.png
      )'
 
 # Should fail (but only on the git cvsexportcommit stage)
@@ -137,9 +137,9 @@ test_expect_success \
      check_entries D "" &&
      check_entries E "newfile5.txt/1.1/" &&
      check_entries F "newfile6.png/1.1/-kb" &&
-     diff A/newfile1.txt ../A/newfile1.txt &&
-     diff E/newfile5.txt ../E/newfile5.txt &&
-     diff F/newfile6.png ../F/newfile6.png
+     @DIFF@ A/newfile1.txt ../A/newfile1.txt &&
+     @DIFF@ E/newfile5.txt ../E/newfile5.txt &&
+     @DIFF@ F/newfile6.png ../F/newfile6.png
      )'
 
 test_expect_success \
@@ -155,8 +155,8 @@ test_expect_success \
      check_entries D "" &&
      check_entries E "newfile5.txt/1.1/" &&
      check_entries F "newfile6.png/1.1/-kb" &&
-     diff E/newfile5.txt ../E/newfile5.txt &&
-     diff F/newfile6.png ../F/newfile6.png
+     @DIFF@ E/newfile5.txt ../E/newfile5.txt &&
+     @DIFF@ F/newfile6.png ../F/newfile6.png
      )'
 
 test_expect_success \
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 4327eb8..19e5a90 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -226,7 +226,7 @@ test_expect_success 'gitcvs.ext.enabled = true' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2'
+   @DIFF@ -q cvswork cvswork2'
 
 rm -fr cvswork2
 test_expect_success 'gitcvs.ext.enabled = false' \
@@ -247,7 +247,7 @@ test_expect_success 'gitcvs.dbname' \
   'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
    GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2 &&
+   @DIFF@ -q cvswork cvswork2 &&
    test -f "$SERVERDIR/gitcvs.ext.master.sqlite" &&
    cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs.ext.master.sqlite"'
 
@@ -257,7 +257,7 @@ test_expect_success 'gitcvs.ext.dbname' \
    GIT_DIR="$SERVERDIR" git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
    GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
    GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 master >cvs.log 2>&1 &&
-   diff -q cvswork cvswork2 &&
+   @DIFF@ -q cvswork cvswork2 &&
    test -f "$SERVERDIR/gitcvs1.ext.master.sqlite" &&
    test ! -f "$SERVERDIR/gitcvs2.ext.master.sqlite" &&
    cmp "$SERVERDIR/gitcvs.master.sqlite" "$SERVERDIR/gitcvs1.ext.master.sqlite"'
@@ -282,7 +282,7 @@ test_expect_success 'cvs update (create new file)' \
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
-   diff -q testfile1 ../testfile1'
+   @DIFF@ -q testfile1 ../testfile1'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (update existing file)' \
@@ -293,7 +293,7 @@ test_expect_success 'cvs update (update existing file)' \
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.2/" &&
-   diff -q testfile1 ../testfile1'
+   @DIFF@ -q testfile1 ../testfile1'
 
 cd "$WORKDIR"
 #TODO: cvsserver doesn't support update w/o -d
@@ -322,7 +322,7 @@ test_expect_success 'cvs update (subdirectories)' \
    (for dir in A A/B A/B/C A/D E; do
       filename="file_in_$(echo $dir|sed -e "s#/# #g")" &&
       if test "$(echo $(grep -v ^D $dir/CVS/Entries|cut -d/ -f2,3,5))" = "$filename/1.1/" &&
-           diff -q "$dir/$filename" "../$dir/$filename"; then
+           @DIFF@ -q "$dir/$filename" "../$dir/$filename"; then
         :
       else
         echo >failure
@@ -349,7 +349,7 @@ test_expect_success 'cvs update (re-add deleted file)' \
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
-   diff -q testfile1 ../testfile1'
+   @DIFF@ -q testfile1 ../testfile1'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (merge)' \
@@ -366,7 +366,7 @@ test_expect_success 'cvs update (merge)' \
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep merge CVS/Entries|cut -d/ -f2,3,5))" = "merge/1.1/" &&
-   diff -q merge ../merge &&
+   @DIFF@ -q merge ../merge &&
    ( echo Line 0; cat merge ) >merge.tmp &&
    mv merge.tmp merge &&
    cd "$WORKDIR" &&
@@ -377,7 +377,7 @@ test_expect_success 'cvs update (merge)' \
    cd cvswork &&
    sleep 1 && touch merge &&
    GIT_CONFIG="$git_config" cvs -Q update &&
-   diff -q merge ../expected'
+   @DIFF@ -q merge ../expected'
 
 cd "$WORKDIR"
 
@@ -402,13 +402,13 @@ test_expect_success 'cvs update (conflict merge)' \
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update &&
-   diff -q merge ../expected.C'
+   @DIFF@ -q merge ../expected.C'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (-C)' \
   'cd cvswork &&
    GIT_CONFIG="$git_config" cvs -Q update -C &&
-   diff -q merge ../merge'
+   @DIFF@ -q merge ../merge'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (merge no-op)' \
@@ -420,7 +420,7 @@ test_expect_success 'cvs update (merge no-op)' \
     cd cvswork &&
     sleep 1 && touch merge &&
     GIT_CONFIG="$git_config" cvs -Q update &&
-    diff -q merge ../merge'
+    @DIFF@ -q merge ../merge'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (-p)' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a0e396a..cd2c886 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -59,7 +59,7 @@ export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
-GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
+GIT_TEST_CMP=${GIT_TEST_CMP:-@DIFF@}
 
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
-- 
1.7.0.2

-- 
Gary V. Vaughan (gary@thewrittenword.com)
