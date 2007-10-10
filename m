From: maillist@steelskies.com
Subject: [PATCH] Fixing path quoting issues
Date: Wed, 10 Oct 2007 22:22:34 +0100
Message-ID: <11920513543478-git-send-email-maillist@steelskies.com>
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 23:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifj0x-0007cf-Qs
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbXJJVWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756628AbXJJVWh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:22:37 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:59963 "EHLO
	gir.office.bestbefore.tv" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756609AbXJJVWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:22:36 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2007 17:22:35 EDT
Received: by gir.office.bestbefore.tv (Postfix, from userid 501)
	id 45204261D6D; Wed, 10 Oct 2007 22:22:34 +0100 (BST)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60543>

From: Jonathan del Strother <jon.delStrother@bestbefore.tv>

git-rebase and a number of tests didn't properly quote paths, leading to problems when run from a path with a space in.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
 git-rebase.sh                            |   26 +++++-----
 t/t1020-subdirectory.sh                  |   22 ++++----
 t/t3050-subprojects-fetch.sh             |    2 +-
 t/t3404-rebase-interactive.sh            |    2 +-
 t/t5500-fetch-pack.sh                    |    2 +-
 t/t5700-clone-reference.sh               |    2 +-
 t/t7003-filter-branch.sh                 |    2 +-
 t/t7501-commit.sh                        |   74 +++++++++++++++---------------
 t/t9100-git-svn-basic.sh                 |   18 ++++----
 t/t9101-git-svn-props.sh                 |    6 +-
 t/t9102-git-svn-deep-rmdir.sh            |    6 +-
 t/t9104-git-svn-follow-parent.sh         |   50 ++++++++++----------
 t/t9105-git-svn-commit-diff.sh           |   10 ++--
 t/t9106-git-svn-commit-diff-clobber.sh   |   14 +++---
 t/t9107-git-svn-migrate.sh               |   40 ++++++++--------
 t/t9108-git-svn-glob.sh                  |    8 ++--
 t/t9110-git-svn-use-svm-props.sh         |    8 ++--
 t/t9111-git-svn-use-svnsync-props.sh     |    8 ++--
 t/t9112-git-svn-md5less-file.sh          |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh      |    6 +-
 t/t9114-git-svn-dcommit-merge.sh         |    4 +-
 t/t9115-git-svn-dcommit-funky-renames.sh |    4 +-
 t/t9116-git-svn-log.sh                   |    4 +-
 t/test-lib.sh                            |    2 +-
 24 files changed, 162 insertions(+), 162 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 1583402..b48397e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,7 +59,7 @@ continue_merge () {
 		die "$RESOLVEMSG"
 	fi
 
-	cmt=`cat $dotest/current`
+	cmt=`cat "$dotest/current"`
 	if ! git diff-index --quiet HEAD
 	then
 		if ! git-commit -C "$cmt"
@@ -84,14 +84,14 @@ continue_merge () {
 }
 
 call_merge () {
-	cmt="$(cat $dotest/cmt.$1)"
+	cmt="$(cat "$dotest/cmt.$1")"
 	echo "$cmt" > "$dotest/current"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD)
-	msgnum=$(cat $dotest/msgnum)
-	end=$(cat $dotest/end)
+	msgnum=$(cat "$dotest/msgnum")
+	end=$(cat "$dotest/end")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-	eval GITHEAD_$hd='"$(cat $dotest/onto_name)"'
+	eval GITHEAD_$hd='"$(cat \"$dotest/onto_name\")"'
 	export GITHEAD_$cmt GITHEAD_$hd
 	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
 	rv=$?
@@ -140,10 +140,10 @@ do
 		}
 		if test -d "$dotest"
 		then
-			prev_head="`cat $dotest/prev_head`"
-			end="`cat $dotest/end`"
-			msgnum="`cat $dotest/msgnum`"
-			onto="`cat $dotest/onto`"
+			prev_head="`cat \"$dotest/prev_head\"`"
+			end="`cat \"$dotest/end\"`"
+			msgnum="`cat \"$dotest/msgnum\"`"
+			onto="`cat \"$dotest/onto\"`"
 			continue_merge
 			while test "$msgnum" -le "$end"
 			do
@@ -160,11 +160,11 @@ do
 		if test -d "$dotest"
 		then
 			git rerere clear
-			prev_head="`cat $dotest/prev_head`"
-			end="`cat $dotest/end`"
-			msgnum="`cat $dotest/msgnum`"
+			prev_head="`cat \"$dotest/prev_head\"`"
+			end="`cat \"$dotest/end\"`"
+			msgnum="`cat \"$dotest/msgnum\"`"
 			msgnum=$(($msgnum + 1))
-			onto="`cat $dotest/onto`"
+			onto="`cat \"$dotest/onto\"`"
 			while test "$msgnum" -le "$end"
 			do
 				call_merge "$msgnum"
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index b9cef34..5ed7fa4 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -21,7 +21,7 @@ LF='
 '
 
 test_expect_success 'update-index and ls-files' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git update-index --add one &&
 	case "`git ls-files`" in
 	one) echo ok one ;;
@@ -41,7 +41,7 @@ test_expect_success 'update-index and ls-files' '
 '
 
 test_expect_success 'cat-file' '
-	cd $HERE &&
+	cd "$HERE" &&
 	two=`git ls-files -s dir/two` &&
 	two=`expr "$two" : "[0-7]* \\([0-9a-f]*\\)"` &&
 	echo "$two" &&
@@ -54,7 +54,7 @@ test_expect_success 'cat-file' '
 rm -f actual dir/actual
 
 test_expect_success 'diff-files' '
-	cd $HERE &&
+	cd "$HERE" &&
 	echo a >>one &&
 	echo d >>dir/two &&
 	case "`git diff-files --name-only`" in
@@ -74,7 +74,7 @@ test_expect_success 'diff-files' '
 '
 
 test_expect_success 'write-tree' '
-	cd $HERE &&
+	cd "$HERE" &&
 	top=`git write-tree` &&
 	echo $top &&
 	cd dir &&
@@ -84,7 +84,7 @@ test_expect_success 'write-tree' '
 '
 
 test_expect_success 'checkout-index' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git checkout-index -f -u one &&
 	cmp one original.one &&
 	cd dir &&
@@ -93,7 +93,7 @@ test_expect_success 'checkout-index' '
 '
 
 test_expect_success 'read-tree' '
-	cd $HERE &&
+	cd "$HERE" &&
 	rm -f one dir/two &&
 	tree=`git write-tree` &&
 	git read-tree --reset -u "$tree" &&
@@ -107,27 +107,27 @@ test_expect_success 'read-tree' '
 '
 
 test_expect_success 'no file/rev ambiguity check inside .git' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git commit -a -m 1 &&
-	cd $HERE/.git &&
+	cd "$HERE/.git" &&
 	git show -s HEAD
 '
 
 test_expect_success 'no file/rev ambiguity check inside a bare repo' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git clone -s --bare .git foo.git &&
 	cd foo.git && GIT_DIR=. git show -s HEAD
 '
 
 # This still does not work as it should...
 : test_expect_success 'no file/rev ambiguity check inside a bare repo' '
-	cd $HERE &&
+	cd "$HERE" &&
 	git clone -s --bare .git foo.git &&
 	cd foo.git && git show -s HEAD
 '
 
 test_expect_success 'detection should not be fooled by a symlink' '
-	cd $HERE &&
+	cd "$HERE" &&
 	rm -fr foo.git &&
 	git clone -s .git another &&
 	ln -s another yetanother &&
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 34f26a8..4b74cc6 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -20,7 +20,7 @@ test_expect_success setup '
 '
 
 test_expect_success clone '
-	git clone file://`pwd`/.git cloned &&
+	git clone "file://`pwd`/.git" cloned &&
 	(git rev-parse HEAD; git ls-files -s) >expected &&
 	(
 		cd cloned &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1113904..f321787 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -92,7 +92,7 @@ done
 EOF
 
 chmod a+x fake-editor.sh
-VISUAL="$(pwd)/fake-editor.sh"
+VISUAL="'$(pwd)/fake-editor.sh'"
 export VISUAL
 
 test_expect_success 'no changes are a nop' '
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 7b6798d..5489ffe 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -129,7 +129,7 @@ pull_to_client 2nd "B" $((64*3))
 
 pull_to_client 3rd "A" $((1*3)) # old fails
 
-test_expect_success "clone shallow" "git-clone --depth 2 file://`pwd`/. shallow"
+test_expect_success "clone shallow" "git-clone --depth 2 \"file://`pwd`/.\" shallow"
 
 (cd shallow; git count-objects -v) > count.shallow
 
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 4e93aaa..8bb34f9 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -51,7 +51,7 @@ diff expected current'
 cd "$base_dir"
 
 test_expect_success 'cloning with reference (no -l -s)' \
-'git clone --reference B file://`pwd`/A D'
+'git clone --reference B "file://`pwd`/A" D'
 
 cd "$base_dir"
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e935b20..1ab5392 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -107,7 +107,7 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
 	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
-		  mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE" directorymoved &&
+		  mv \"\$GIT_INDEX_FILE.new\" \"\$GIT_INDEX_FILE\"" directorymoved &&
 	test -z "$(git diff HEAD directorymoved:newsubdir)"'
 
 test_expect_success 'stops when msg filter fails' '
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b151b51..f3d0ab9 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -69,7 +69,7 @@ test_expect_success \
 
 cat >editor <<\EOF
 #!/bin/sh
-sed -i -e "s/a file/an amend commit/g" $1
+sed -i -e "s/a file/an amend commit/g" "$1"
 EOF
 chmod 755 editor
 
@@ -80,40 +80,40 @@ test_expect_success \
 test_expect_failure \
 	"passing -m and -F" \
 	"echo 'enough with the bongos' >file && \
-	 git-commit -F msg -m amending ."
+	git-commit -F msg -m amending ."
 
 test_expect_success \
-	"using message from other commit" \
-	"git-commit -C HEAD^ ."
+	 "using message from other commit" \
+	 "git-commit -C HEAD^ ."
 
 cat >editor <<\EOF
 #!/bin/sh
-sed -i -e "s/amend/older/g" $1
+sed -i -e "s/amend/older/g" "$1"
 EOF
 chmod 755 editor
 
 test_expect_success \
-	"editing message from other commit" \
-	"echo 'hula hula' >file && \
-	 VISUAL=./editor git-commit -c HEAD^ -a"
+	 "editing message from other commit" \
+	 "echo 'hula hula' >file && \
+	  VISUAL=./editor git-commit -c HEAD^ -a"
 
 test_expect_success \
-	"message from stdin" \
-	"echo 'silly new contents' >file && \
-	 echo commit message from stdin | git-commit -F - -a"
+	 "message from stdin" \
+	 "echo 'silly new contents' >file && \
+	  echo commit message from stdin | git-commit -F - -a"
 
 test_expect_success \
-	"overriding author from command line" \
-	"echo 'gak' >file && \
-	 git-commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
+	 "overriding author from command line" \
+	 "echo 'gak' >file && \
+	  git-commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
 
 test_expect_success \
-	"interactive add" \
-	"echo 7 | git-commit --interactive | grep 'What now'"
+	 "interactive add" \
+	 "echo 7 | git-commit --interactive | grep 'What now'"
 
 test_expect_success \
-	"showing committed revisions" \
-	"git-rev-list HEAD >current"
+	 "showing committed revisions" \
+	 "git-rev-list HEAD >current"
 
 # We could just check the head sha1, but checking each commit makes it
 # easier to isolate bugs.
@@ -128,38 +128,38 @@ d381ac431806e53f3dd7ac2f1ae0534f36d738b9
 EOF
 
 test_expect_success \
-    'validate git-rev-list output.' \
-    'diff current expected'
+	'validate git-rev-list output.' \
+	'diff current expected'
 
 test_expect_success 'partial commit that involves removal (1)' '
 
-	git rm --cached file &&
-	mv file elif &&
-	git add elif &&
-	git commit -m "Partial: add elif" elif &&
-	git diff-tree --name-status HEAD^ HEAD >current &&
-	echo "A	elif" >expected &&
-	diff expected current
+	 git rm --cached file &&
+	 mv file elif &&
+	 git add elif &&
+	 git commit -m "Partial: add elif" elif &&
+	 git diff-tree --name-status HEAD^ HEAD >current &&
+	 echo "A elif" >expected &&
+	 diff -b expected current
 
 '
 
 test_expect_success 'partial commit that involves removal (2)' '
 
-	git commit -m "Partial: remove file" file &&
-	git diff-tree --name-status HEAD^ HEAD >current &&
-	echo "D	file" >expected &&
-	diff expected current
+	 git commit -m "Partial: remove file" file &&
+	 git diff-tree --name-status HEAD^ HEAD >current &&
+	 echo "D file" >expected &&
+	 diff -b expected current
 
 '
 
 test_expect_success 'partial commit that involves removal (3)' '
 
-	git rm --cached elif &&
-	echo elif >elif &&
-	git commit -m "Partial: modify elif" elif &&
-	git diff-tree --name-status HEAD^ HEAD >current &&
-	echo "M	elif" >expected &&
-	diff expected current
+	 git rm --cached elif &&
+	 echo elif >elif &&
+	 git commit -m "Partial: modify elif" elif &&
+	 git diff-tree --name-status HEAD^ HEAD >current &&
+	 echo "M elif" >expected &&
+	 diff -b expected current
 
 '
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 614cf50..c3585da 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -31,16 +31,16 @@ test_expect_success \
 	echo 'zzz' > bar/zzz &&
 	echo '#!/bin/sh' > exec.sh &&
 	chmod +x exec.sh &&
-	svn import -m 'import for git-svn' . $svnrepo >/dev/null &&
+	svn import -m 'import for git-svn' . '$svnrepo' >/dev/null &&
 	cd .. &&
 	rm -rf import &&
-	git-svn init $svnrepo"
+	git-svn init '$svnrepo'"
 
 test_expect_success \
     'import an SVN revision into git' \
     'git-svn fetch'
 
-test_expect_success "checkout from svn" "svn co $svnrepo '$SVN_TREE'"
+test_expect_success "checkout from svn" "svn co '$svnrepo' '$SVN_TREE'"
 
 name='try a deep --rmdir with a commit'
 test_expect_success "$name" "
@@ -169,7 +169,7 @@ test_expect_success "$name" "
 	svn up '$SVN_TREE' &&
 	test -f '$SVN_TREE'/exec-2.sh &&
 	test ! -L '$SVN_TREE'/exec-2.sh &&
-	git diff help $SVN_TREE/exec-2.sh"
+	git diff help '$SVN_TREE/exec-2.sh'"
 
 if test "$have_utf8" = t
 then
@@ -190,7 +190,7 @@ name='test fetch functionality (svn => git) with alternate GIT_SVN_ID'
 GIT_SVN_ID=alt
 export GIT_SVN_ID
 test_expect_success "$name" \
-    "git-svn init $svnrepo && git-svn fetch &&
+    "git-svn init '$svnrepo' && git-svn fetch &&
      git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
      git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
      git diff a b"
@@ -220,16 +220,16 @@ test_expect_failure 'exit if remote refs are ambigious' "
         "
 
 test_expect_failure 'exit if init-ing a would clobber a URL' "
-        svnadmin create ${PWD}/svnrepo2 &&
-        svn mkdir -m 'mkdir bar' ${svnrepo}2/bar &&
+        svnadmin create '${PWD}/svnrepo2' &&
+        svn mkdir -m 'mkdir bar' '${svnrepo}2/bar' &&
         git config --unset svn-remote.svn.fetch \
                                 '^bar:refs/remotes/git-svn$' &&
-        git-svn init ${svnrepo}2/bar
+        git-svn init '${svnrepo}2/bar'
         "
 
 test_expect_success \
   'init allows us to connect to another directory in the same repo' "
-        git-svn init --minimize-url -i bar $svnrepo/bar &&
+        git-svn init --minimize-url -i bar '$svnrepo/bar' &&
         git config --get svn-remote.svn.fetch \
                               '^bar:refs/remotes/bar$' &&
         git config --get svn-remote.svn.fetch \
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 5aac644..a1c85e0 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -52,7 +52,7 @@ EOF
 cd ..
 
 rm -rf import
-test_expect_success 'checkout working copy from svn' "svn co $svnrepo test_wc"
+test_expect_success 'checkout working copy from svn' "svn co '$svnrepo' test_wc"
 test_expect_success 'setup some commits to svn' \
 	'cd test_wc &&
 		echo Greetings >> kw.c &&
@@ -66,7 +66,7 @@ test_expect_success 'setup some commits to svn' \
 		svn commit -m "Propset Id" &&
 	cd ..'
 
-test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'initialize git-svn' "git-svn init '$svnrepo'"
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 
 name='test svn:keywords ignoring'
@@ -92,7 +92,7 @@ test_expect_success "propset CR on crlf files" \
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	"git-svn fetch &&
 	 git pull . remotes/git-svn &&
-	 svn co $svnrepo new_wc"
+	 svn co '$svnrepo' new_wc"
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 4e08083..99c8840 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -9,12 +9,12 @@ test_expect_success 'initialize repo' "
 	mkdir -p deeply/nested/directory/number/2 &&
 	echo foo > deeply/nested/directory/number/1/file &&
 	echo foo > deeply/nested/directory/number/2/another &&
-	svn import -m 'import for git-svn' . $svnrepo &&
+	svn import -m 'import for git-svn' . '$svnrepo' &&
 	cd ..
 	"
 
 test_expect_success 'mirror via git-svn' "
-	git-svn init $svnrepo &&
+	git-svn init '$svnrepo' &&
 	git-svn fetch &&
 	git checkout -f -b test-rmdir remotes/git-svn
 	"
@@ -23,7 +23,7 @@ test_expect_success 'Try a commit on rmdir' "
 	git rm -f deeply/nested/directory/number/2/another &&
 	git commit -a -m 'remove another' &&
 	git-svn set-tree --rmdir HEAD &&
-	svn ls -R $svnrepo | grep ^deeply/nested/directory/number/1
+	svn ls -R '$svnrepo' | grep ^deeply/nested/directory/number/1
 	"
 
 
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 7ba7630..aa2bfe2 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -11,9 +11,9 @@ test_expect_success 'initialize repo' "
 	cd import &&
 	mkdir -p trunk &&
 	echo hello > trunk/readme &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . '$svnrepo' &&
 	cd .. &&
-	svn co $svnrepo wc &&
+	svn co '$svnrepo' wc &&
 	cd wc &&
 	echo world >> trunk/readme &&
 	poke trunk/readme &&
@@ -27,7 +27,7 @@ test_expect_success 'initialize repo' "
 	"
 
 test_expect_success 'init and fetch a moved directory' "
-	git-svn init --minimize-url -i thunk $svnrepo/thunk &&
+	git-svn init --minimize-url -i thunk '$svnrepo/thunk' &&
 	git-svn fetch -i thunk &&
 	test \"\`git rev-parse --verify refs/remotes/thunk@2\`\" \
            = \"\`git rev-parse --verify refs/remotes/thunk~1\`\" &&
@@ -38,7 +38,7 @@ test_expect_success 'init and fetch a moved directory' "
 	"
 
 test_expect_success 'init and fetch from one svn-remote' "
-        git config svn-remote.svn.url $svnrepo &&
+        git config svn-remote.svn.url '$svnrepo' &&
         git config --add svn-remote.svn.fetch \
           trunk:refs/remotes/svn/trunk &&
         git config --add svn-remote.svn.fetch \
@@ -52,9 +52,9 @@ test_expect_success 'init and fetch from one svn-remote' "
 
 test_expect_success 'follow deleted parent' "
         (svn cp -m 'resurrecting trunk as junk' \
-               $svnrepo/trunk@2 $svnrepo/junk ||
+               '$svnrepo/trunk@2' '$svnrepo'/junk ||
          svn cp -m 'resurrecting trunk as junk' \
-               -r2 $svnrepo/trunk $svnrepo/junk) &&
+               -r2 '$svnrepo/trunk' '$svnrepo/junk') &&
         git config --add svn-remote.svn.fetch \
           junk:refs/remotes/svn/junk &&
         git-svn fetch -i svn/thunk &&
@@ -67,10 +67,10 @@ test_expect_success 'follow deleted parent' "
 test_expect_success 'follow larger parent' "
         mkdir -p import/trunk/thunk/bump/thud &&
         echo hi > import/trunk/thunk/bump/thud/file &&
-        svn import -m 'import a larger parent' import $svnrepo/larger-parent &&
-        svn cp -m 'hi' $svnrepo/larger-parent $svnrepo/another-larger &&
+        svn import -m 'import a larger parent' import '$svnrepo/larger-parent' &&
+        svn cp -m 'hi' '$svnrepo/larger-parent' '$svnrepo/another-larger' &&
         git-svn init --minimize-url -i larger \
-          $svnrepo/another-larger/trunk/thunk/bump/thud &&
+          '$svnrepo/another-larger/trunk/thunk/bump/thud' &&
         git-svn fetch -i larger &&
         git rev-parse --verify refs/remotes/larger &&
         git rev-parse --verify \
@@ -83,23 +83,23 @@ test_expect_success 'follow larger parent' "
         "
 
 test_expect_success 'follow higher-level parent' "
-        svn mkdir -m 'follow higher-level parent' $svnrepo/blob &&
-        svn co $svnrepo/blob blob &&
+        svn mkdir -m 'follow higher-level parent' '$svnrepo/blob' &&
+        svn co '$svnrepo/blob' blob &&
         cd blob &&
                 echo hi > hi &&
                 svn add hi &&
                 svn commit -m 'hihi' &&
                 cd ..
-        svn mkdir -m 'new glob at top level' $svnrepo/glob &&
-        svn mv -m 'move blob down a level' $svnrepo/blob $svnrepo/glob/blob &&
-        git-svn init --minimize-url -i blob $svnrepo/glob/blob &&
+        svn mkdir -m 'new glob at top level' '$svnrepo/glob' &&
+        svn mv -m 'move blob down a level' '$svnrepo/blob' '$svnrepo/glob/blob' &&
+        git-svn init --minimize-url -i blob '$svnrepo/glob/blob' &&
         git-svn fetch -i blob
         "
 
 test_expect_success 'follow deleted directory' "
-	svn mv -m 'bye!' $svnrepo/glob/blob/hi $svnrepo/glob/blob/bye &&
-	svn rm -m 'remove glob' $svnrepo/glob &&
-	git-svn init --minimize-url -i glob $svnrepo/glob &&
+	svn mv -m 'bye!' '$svnrepo/glob/blob/hi' '$svnrepo/glob/blob/bye' &&
+	svn rm -m 'remove glob' '$svnrepo/glob' &&
+	git-svn init --minimize-url -i glob '$svnrepo/glob' &&
 	git-svn fetch -i glob &&
 	test \"\`git cat-file blob refs/remotes/glob:blob/bye\`\" = hi &&
 	test \"\`git ls-tree refs/remotes/glob | wc -l \`\" -eq 1
@@ -118,9 +118,9 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  echo 'bad delete test 2' > \
 	   import/trunk/subversion/bindings/swig/perl/another-larger &&
 	cd import &&
-	  svn import -m 'r9270 test' . $svnrepo/r9270 &&
+	  svn import -m 'r9270 test' . '$svnrepo/r9270' &&
 	cd .. &&
-	svn co $svnrepo/r9270/trunk/subversion/bindings/swig/perl r9270 &&
+	svn co '$svnrepo/r9270/trunk/subversion/bindings/swig/perl' r9270 &&
 	cd r9270 &&
 	  svn mkdir native &&
 	  svn mv t native/t &&
@@ -130,7 +130,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	  svn commit -m 'reorg test' &&
 	cd .. &&
 	git-svn init --minimize-url -i r9270-t \
-	  $svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t &&
+	  '$svnrepo/r9270/trunk/subversion/bindings/swig/perl/native/t' &&
 	git-svn fetch -i r9270-t &&
 	test \`git rev-list r9270-t | wc -l\` -eq 2 &&
 	test \"\`git ls-tree --name-only r9270-t~1\`\" = \
@@ -138,9 +138,9 @@ test_expect_success 'follow-parent avoids deleting relevant info' "
 	"
 
 test_expect_success "track initial change if it was only made to parent" "
-	svn cp -m 'wheee!' $svnrepo/r9270/trunk $svnrepo/r9270/drunk &&
+	svn cp -m 'wheee!' '$svnrepo/r9270/trunk' '$svnrepo/r9270/drunk' &&
 	git-svn init --minimize-url -i r9270-d \
-	  $svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t &&
+	  '$svnrepo/r9270/drunk/subversion/bindings/swig/perl/native/t' &&
 	git-svn fetch -i r9270-d &&
 	test \`git rev-list r9270-d | wc -l\` -eq 3 &&
 	test \"\`git ls-tree --name-only r9270-t\`\" = \
@@ -150,7 +150,7 @@ test_expect_success "track initial change if it was only made to parent" "
 	"
 
 test_expect_success "track multi-parent paths" "
-	svn cp -m 'resurrect /glob' $svnrepo/r9270 $svnrepo/glob &&
+	svn cp -m 'resurrect /glob' '$svnrepo/r9270' '$svnrepo/glob' &&
 	git-svn multi-fetch &&
 	test \`git cat-file commit refs/remotes/glob | \
 	       grep '^parent ' | wc -l\` -eq 2
@@ -161,8 +161,8 @@ test_expect_success "multi-fetch continues to work" "
 	"
 
 test_expect_success "multi-fetch works off a 'clean' repository" "
-	rm -r $GIT_DIR/svn $GIT_DIR/refs/remotes $GIT_DIR/logs &&
-	mkdir $GIT_DIR/svn &&
+	rm -r '$GIT_DIR/svn' '$GIT_DIR/refs/remotes' '$GIT_DIR/logs' &&
+	mkdir '$GIT_DIR/svn' &&
 	git-svn multi-fetch
 	"
 
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index 318e172..2e1eb75 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -8,7 +8,7 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	echo hello > readme &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . '$svnrepo' &&
 	cd .. &&
 	echo hello > readme &&
 	git update-index --add readme &&
@@ -27,16 +27,16 @@ prev=`git rev-parse --verify HEAD^1`
 test_expect_success 'test the commit-diff command' "
 	test -n '$prev' && test -n '$head' &&
 	git-svn commit-diff -r1 '$prev' '$head' '$svnrepo' &&
-	svn co $svnrepo wc &&
+	svn co '$svnrepo' wc &&
 	cmp readme wc/readme
 	"
 
 test_expect_success 'commit-diff to a sub-directory (with git-svn config)' "
-	svn import -m 'sub-directory' import $svnrepo/subdir &&
-	git-svn init --minimize-url $svnrepo/subdir &&
+	svn import -m 'sub-directory' import '$svnrepo/subdir' &&
+	git-svn init --minimize-url '$svnrepo/subdir' &&
 	git-svn fetch &&
 	git-svn commit-diff -r3 '$prev' '$head' &&
-	svn cat $svnrepo/subdir/readme > readme.2 &&
+	svn cat '$svnrepo/subdir/readme' > readme.2 &&
 	cmp readme readme.2
 	"
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 79b7968..bb42339 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -8,14 +8,14 @@ test_expect_success 'initialize repo' "
 	mkdir import &&
 	cd import &&
 	echo initial > file &&
-	svn import -m 'initial' . $svnrepo &&
+	svn import -m 'initial' . '$svnrepo' &&
 	cd .. &&
 	echo initial > file &&
 	git update-index --add file &&
 	git commit -a -m 'initial'
 	"
 test_expect_success 'commit change from svn side' "
-	svn co $svnrepo t.svn &&
+	svn co '$svnrepo' t.svn &&
 	cd t.svn &&
 	echo second line from svn >> file &&
 	poke file &&
@@ -27,7 +27,7 @@ test_expect_success 'commit change from svn side' "
 test_expect_failure 'commit conflicting change from git' "
 	echo second line from git >> file &&
 	git commit -a -m 'second line from git' &&
-	git-svn commit-diff -r1 HEAD~1 HEAD $svnrepo
+	git-svn commit-diff -r1 HEAD~1 HEAD '$svnrepo'
 	" || true
 
 test_expect_success 'commit complementing change from git' "
@@ -36,14 +36,14 @@ test_expect_success 'commit complementing change from git' "
 	git commit -a -m 'second line from svn' &&
 	echo third line from git >> file &&
 	git commit -a -m 'third line from git' &&
-	git-svn commit-diff -r2 HEAD~1 HEAD $svnrepo
+	git-svn commit-diff -r2 HEAD~1 HEAD '$svnrepo'
 	"
 
 test_expect_failure 'dcommit fails to commit because of conflict' "
-	git-svn init $svnrepo &&
+	git-svn init '$svnrepo' &&
 	git-svn fetch &&
 	git reset --hard refs/remotes/git-svn &&
-	svn co $svnrepo t.svn &&
+	svn co '$svnrepo' t.svn &&
 	cd t.svn &&
 	echo fourth line from svn >> file &&
 	poke file &&
@@ -67,7 +67,7 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "
 	"
 
 test_expect_success 'commit another change from svn side' "
-	svn co $svnrepo t.svn &&
+	svn co '$svnrepo' t.svn &&
 	cd t.svn &&
 		echo third line from svn >> file &&
 		poke file &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 67fdf70..90bf786 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -4,7 +4,7 @@ test_description='git-svn metadata migrations from previous versions'
 . ./lib-git-svn.sh
 
 test_expect_success 'setup old-looking metadata' "
-	cp $GIT_DIR/config $GIT_DIR/config-old-git-svn &&
+	cp '$GIT_DIR/config' '$GIT_DIR/config-old-git-svn' &&
 	mkdir import &&
 	cd import &&
 		for i in trunk branches/a branches/b \
@@ -12,13 +12,13 @@ test_expect_success 'setup old-looking metadata' "
 			mkdir -p \$i && \
 			echo hello >> \$i/README || exit 1
 		done && \
-		svn import -m test . $svnrepo
+		svn import -m test . '$svnrepo'
 		cd .. &&
-	git-svn init $svnrepo &&
+	git-svn init '$svnrepo' &&
 	git-svn fetch &&
-	mv $GIT_DIR/svn/* $GIT_DIR/ &&
-	mv $GIT_DIR/svn/.metadata $GIT_DIR/ &&
-	rmdir $GIT_DIR/svn &&
+	mv '$GIT_DIR'/svn/* '$GIT_DIR/' &&
+	mv '$GIT_DIR/svn/.metadata' '$GIT_DIR/' &&
+	rmdir '$GIT_DIR/svn' &&
 	git update-ref refs/heads/git-svn-HEAD refs/remotes/git-svn &&
 	git update-ref refs/heads/svn-HEAD refs/remotes/git-svn &&
 	git update-ref -d refs/remotes/git-svn refs/remotes/git-svn
@@ -28,20 +28,20 @@ head=`git rev-parse --verify refs/heads/git-svn-HEAD^0`
 test_expect_success 'git-svn-HEAD is a real HEAD' "test -n '$head'"
 
 test_expect_success 'initialize old-style (v0) git-svn layout' "
-	mkdir -p $GIT_DIR/git-svn/info $GIT_DIR/svn/info &&
-	echo $svnrepo > $GIT_DIR/git-svn/info/url &&
-	echo $svnrepo > $GIT_DIR/svn/info/url &&
+	mkdir -p '$GIT_DIR/git-svn/info' '$GIT_DIR/svn/info' &&
+	echo '$svnrepo' > '$GIT_DIR/git-svn/info/url' &&
+	echo '$svnrepo' > '$GIT_DIR/svn/info/url' &&
 	git-svn migrate &&
-	! test -d $GIT_DIR/git-svn &&
+	! test -d '$GIT_DIR/git-svn' &&
 	git rev-parse --verify refs/remotes/git-svn^0 &&
 	git rev-parse --verify refs/remotes/svn^0 &&
-	test \`git config --get svn-remote.svn.url\` = '$svnrepo' &&
+	test \"\`git config --get svn-remote.svn.url\`\" = \"$svnrepo\" &&
 	test \`git config --get svn-remote.svn.fetch\` = \
              ':refs/remotes/git-svn'
 	"
 
 test_expect_success 'initialize a multi-repository repo' "
-	git-svn init $svnrepo -T trunk -t tags -b branches &&
+	git-svn init '$svnrepo' -T trunk -t tags -b branches &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep '^trunk:refs/remotes/trunk$' fetch.out &&
 	test -n \"\`git config --get svn-remote.svn.branches \
@@ -76,14 +76,14 @@ test_expect_success 'multi-fetch works on partial urls + paths' "
 test_expect_success 'migrate --minimize on old inited layout' "
 	git config --unset-all svn-remote.svn.fetch &&
 	git config --unset-all svn-remote.svn.url &&
-	rm -rf $GIT_DIR/svn &&
+	rm -rf '$GIT_DIR/svn' &&
 	for i in \`cat fetch.out\`; do
 		path=\`expr \$i : '\\([^:]*\\):.*$'\`
 		ref=\`expr \$i : '[^:]*:refs/remotes/\\(.*\\)$'\`
 		if test -z \"\$ref\"; then continue; fi
 		if test -n \"\$path\"; then path=\"/\$path\"; fi
-		( mkdir -p $GIT_DIR/svn/\$ref/info/ &&
-		echo $svnrepo\$path > $GIT_DIR/svn/\$ref/info/url ) || exit 1;
+		( mkdir -p '$GIT_DIR'/svn/\$ref/info/ &&
+		echo '$svnrepo'\$path > '$GIT_DIR'/svn/\$ref/info/url ) || exit 1;
 	done &&
 	git-svn migrate --minimize &&
 	test -z \"\`git config -l |grep -v '^svn-remote\.git-svn\.'\`\" &&
@@ -99,13 +99,13 @@ test_expect_success 'migrate --minimize on old inited layout' "
 
 test_expect_success  ".rev_db auto-converted to .rev_db.UUID" "
 	git-svn fetch -i trunk &&
-	expect=$GIT_DIR/svn/trunk/.rev_db.* &&
+	expect=\"\`find \"\$GIT_DIR\"/svn/trunk/ -name '.rev_db.*'\`\" &&
 	test -n \"\$expect\" &&
-	mv \$expect $GIT_DIR/svn/trunk/.rev_db &&
+	mv \"\$expect\" \"\$GIT_DIR\"/svn/trunk/.rev_db &&
 	git-svn fetch -i trunk &&
-	test -L $GIT_DIR/svn/trunk/.rev_db &&
-	test -f \$expect &&
-	cmp \$expect $GIT_DIR/svn/trunk/.rev_db
+	test -L \"\$GIT_DIR\"/svn/trunk/.rev_db &&
+	test -f \"\$expect\" &&
+	cmp \"\$expect\" \"\$GIT_DIR\"/svn/trunk/.rev_db
 	"
 
 test_done
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index db4344c..c6dc0ef 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -14,8 +14,8 @@ test_expect_success 'test refspec globbing' "
 	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
 	echo 'hello world' > trunk/src/a/readme &&
 	echo 'goodbye world' > trunk/src/b/readme &&
-	svn import -m 'initial' trunk $svnrepo/trunk &&
-	svn co $svnrepo tmp &&
+	svn import -m 'initial' trunk '$svnrepo/trunk' &&
+	svn co '$svnrepo' tmp &&
 	cd tmp &&
 		mkdir branches tags &&
 		svn add branches tags &&
@@ -38,7 +38,7 @@ test_expect_success 'test refspec globbing' "
 		poke tags/end/src/b/readme &&
 		svn commit -m 'nothing to see here'
 		cd .. &&
-	git config --add svn-remote.svn.url $svnrepo &&
+	git config --add svn-remote.svn.url '$svnrepo' &&
 	git config --add svn-remote.svn.fetch \
 	                 'trunk/src/a:refs/remotes/trunk' &&
 	git config --add svn-remote.svn.branches \
@@ -60,7 +60,7 @@ echo nothing to see here >> expect.two
 cat expect.end >> expect.two
 
 test_expect_success 'test left-hand-side only globbing' "
-	git config --add svn-remote.two.url $svnrepo &&
+	git config --add svn-remote.two.url '$svnrepo' &&
 	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
 	git config --add svn-remote.two.branches \
 	                 'branches/*:refs/remotes/two/branches/*' &&
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index 6235af4..d4ab01f 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -8,11 +8,11 @@ test_description='git-svn useSvmProps test'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svm repo' "
-	svnadmin load -q $rawsvnrepo < ../t9110/svm.dump &&
-	git-svn init --minimize-url -R arr -i bar $svnrepo/mirror/arr &&
-	git-svn init --minimize-url -R argh -i dir $svnrepo/mirror/argh &&
+	svnadmin load -q '$rawsvnrepo' < ../t9110/svm.dump &&
+	git-svn init --minimize-url -R arr -i bar '$svnrepo/mirror/arr' &&
+	git-svn init --minimize-url -R argh -i dir '$svnrepo/mirror/argh' &&
 	git-svn init --minimize-url -R argh -i e \
-	  $svnrepo/mirror/argh/a/b/c/d/e &&
+	  '$svnrepo/mirror/argh/a/b/c/d/e' &&
 	git config svn.useSvmProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index ec7dedd..936f023 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -8,10 +8,10 @@ test_description='git-svn useSvnsyncProps test'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svnsync repo' "
-	svnadmin load -q $rawsvnrepo < ../t9111/svnsync.dump &&
-	git-svn init --minimize-url -R arr -i bar $svnrepo/bar &&
-	git-svn init --minimize-url -R argh -i dir $svnrepo/dir &&
-	git-svn init --minimize-url -R argh -i e $svnrepo/dir/a/b/c/d/e &&
+	svnadmin load -q '$rawsvnrepo' < ../t9111/svnsync.dump &&
+	git-svn init --minimize-url -R arr -i bar '$svnrepo/bar' &&
+	git-svn init --minimize-url -R argh -i dir '$svnrepo/dir' &&
+	git-svn init --minimize-url -R argh -i e '$svnrepo/dir/a/b/c/d/e' &&
 	git config svn.useSvnsyncProps true &&
 	git-svn fetch --all
 	"
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-file.sh
index 08313bb..b095583 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -38,8 +38,8 @@ PROPS-END
 
 EOF
 
-test_expect_success 'load svn dumpfile' "svnadmin load $rawsvnrepo < dumpfile.svn"
+test_expect_success 'load svn dumpfile' "svnadmin load '$rawsvnrepo' < dumpfile.svn"
 
-test_expect_success 'initialize git-svn' "git-svn init $svnrepo"
+test_expect_success 'initialize git-svn' "git-svn init '$svnrepo'"
 test_expect_success 'fetch revisions from svn' 'git-svn fetch'
 test_done
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
index 9ef0db9..0088c75 100755
--- a/t/t9113-git-svn-dcommit-new-file.sh
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -15,14 +15,14 @@ test_description='git-svn dcommit new files over svn:// test'
 
 start_svnserve () {
 	svnserve --listen-port $SVNSERVE_PORT \
-	         --root $rawsvnrepo \
+	         --root '$rawsvnrepo' \
 	         --listen-once \
 	         --listen-host 127.0.0.1 &
 }
 
 test_expect_success 'start tracking an empty repo' "
-	svn mkdir -m 'empty dir' $svnrepo/empty-dir &&
-	echo anon-access = write >> $rawsvnrepo/conf/svnserve.conf &&
+	svn mkdir -m 'empty dir' '$svnrepo/empty-dir' &&
+	echo anon-access = write >> '$rawsvnrepo/conf/svnserve.conf' &&
 	start_svnserve &&
 	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
 	git svn fetch
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index d6ca955..64ec7fd 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -35,7 +35,7 @@ EOF
 }
 
 test_expect_success 'setup svn repository' "
-	svn co $svnrepo mysvnwork &&
+	svn co '$svnrepo' mysvnwork &&
 	mkdir -p mysvnwork/trunk &&
 	cd mysvnwork &&
 		big_text_block >> trunk/README &&
@@ -45,7 +45,7 @@ test_expect_success 'setup svn repository' "
 	"
 
 test_expect_success 'setup git mirror and merge' "
-	git svn init $svnrepo -t tags -T trunk -b branches &&
+	git svn init '$svnrepo' -t tags -T trunk -b branches &&
 	git svn fetch &&
 	git checkout --track -b svn remotes/trunk &&
 	git checkout -b merge &&
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 182299c..653578d 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -8,12 +8,12 @@ test_description='git-svn dcommit can commit renames of files with ugly names'
 . ./lib-git-svn.sh
 
 test_expect_success 'load repository with strange names' "
-	svnadmin load -q $rawsvnrepo < ../t9115/funky-names.dump &&
+	svnadmin load -q '$rawsvnrepo' < ../t9115/funky-names.dump &&
 	start_httpd
 	"
 
 test_expect_success 'init and fetch repository' "
-	git svn init $svnrepo &&
+	git svn init '$svnrepo' &&
 	git svn fetch &&
 	git reset --hard git-svn
 	"
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 0d4e6b3..70c0c5f 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -14,9 +14,9 @@ test_expect_success 'setup repository and import' "
 			mkdir -p \$i && \
 			echo hello >> \$i/README || exit 1
 		done && \
-		svn import -m test . $svnrepo
+		svn import -m test . '$svnrepo'
 		cd .. &&
-	git-svn init $svnrepo -T trunk -b branches -t tags &&
+	git-svn init '$svnrepo' -T trunk -b branches -t tags &&
 	git-svn fetch &&
 	git reset --hard trunk &&
 	echo bye >> README &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index cc1253c..a68415f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -229,7 +229,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
+	"$GIT_EXEC_PATH/git" init --template="$GIT_EXEC_PATH/templates/blt/" >/dev/null 2>&1 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.5.3.1
