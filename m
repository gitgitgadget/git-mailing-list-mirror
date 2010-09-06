From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Several tests: cd inside subshell instead of around
Date: Mon, 06 Sep 2010 20:39:54 +0200
Message-ID: <4C85357A.8090000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 20:40:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osgbu-0002Zz-98
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951Ab0IFSkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 14:40:00 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60211 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab0IFSj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 14:39:57 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id B80EE1677197F;
	Mon,  6 Sep 2010 20:39:55 +0200 (CEST)
Received: from [93.240.118.225] (helo=[192.168.178.29])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Osgbi-0007oE-00; Mon, 06 Sep 2010 20:39:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19YVXNlFWakrT4d0SlLY6fLkclYTPpOxnA+6LF6
	3JdZyrANfiirSoMG0CIR/Zy8CD3ty+05sQUbPyGyYErmmignUT
	mfroIdtYEU3EPravJYvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155596>

Fixed all places where it was a straightforward change from cd'ing into a
directory and back via "cd .." to a cd inside a subshell.

Found these places with "git grep -w "cd \.\.".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This patch applies to maint.

 t/t1020-subdirectory.sh                       |    6 +-
 t/t1302-repo-version.sh                       |    6 +-
 t/t2101-update-index-reupdate.sh              |    6 +-
 t/t3060-ls-files-with-tree.sh                 |    4 +-
 t/t3409-rebase-preserve-merges.sh             |   12 +-
 t/t3903-stash.sh                              |    6 +-
 t/t4041-diff-submodule-option.sh              |    6 +-
 t/t5510-fetch.sh                              |   18 ++--
 t/t6050-replace.sh                            |   22 ++--
 t/t7400-submodule-basic.sh                    |    6 +-
 t/t7401-submodule-summary.sh                  |    6 +-
 t/t9100-git-svn-basic.sh                      |    6 +-
 t/t9101-git-svn-props.sh                      |   16 ++--
 t/t9102-git-svn-deep-rmdir.sh                 |    6 +-
 t/t9104-git-svn-follow-parent.sh              |   30 +++---
 t/t9105-git-svn-commit-diff.sh                |    6 +-
 t/t9106-git-svn-commit-diff-clobber.sh        |   24 +++---
 t/t9107-git-svn-migrate.sh                    |    4 +-
 t/t9114-git-svn-dcommit-merge.sh              |    6 +-
 t/t9115-git-svn-dcommit-funky-renames.sh      |    6 +-
 t/t9116-git-svn-log.sh                        |    4 +-
 t/t9119-git-svn-info.sh                       |  126 ++++++++++++------------
 t/t9120-git-svn-clone-with-percent-escapes.sh |    6 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh   |    4 +-
 t/t9125-git-svn-multi-glob-branch-names.sh    |   12 +-
 t/t9127-git-svn-partial-rebuild.sh            |   30 +++---
 t/t9128-git-svn-cmd-branch.sh                 |   18 ++--
 t/t9137-git-svn-dcommit-clobber-series.sh     |   12 +-
 t/t9300-fast-import.sh                        |    5 +-
 t/t9401-git-cvsserver-crlf.sh                 |   53 +++++-----
 t/t9600-cvsimport.sh                          |   38 ++++----
 t/t9603-cvsimport-patchsets.sh                |    6 +-
 32 files changed, 256 insertions(+), 260 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 5687499..c36157a 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -27,13 +27,13 @@ test_expect_success 'update-index and ls-files' '
 	one) echo pass one ;;
 	*) echo bad one; exit 1 ;;
 	esac &&
-	cd dir &&
+	(cd dir &&
 	git update-index --add two &&
 	case "`git ls-files`" in
 	two) echo pass two ;;
 	*) echo bad two; exit 1 ;;
-	esac &&
-	cd .. &&
+	esac
+	) &&
 	case "`git ls-files`" in
 	dir/two"$LF"one) echo pass both ;;
 	*) echo bad; exit 1 ;;
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 8d305b4..c948719 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -32,9 +32,9 @@ test_expect_success 'gitdir selection on unsupported repo' '
 	test "$(git config core.repositoryformatversion)" = 99)'

 test_expect_success 'gitdir not required mode' '
-	(git apply --stat test.patch &&
-	cd test && git apply --stat ../test.patch &&
-	cd ../test2 && git apply --stat ../test.patch)'
+	git apply --stat test.patch &&
+	(cd test && git apply --stat ../test.patch) &&
+	(cd test2 && git apply --stat ../test.patch)'

 test_expect_success 'gitdir required mode on normal repos' '
 	(git apply --check --index test.patch &&
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index 648184f..76ad7c3 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -63,10 +63,10 @@ cat > expected <<\EOF
 EOF
 test_expect_success 'update-index --update from subdir' \
 	'echo not so happy >file2 &&
-	cd dir1 &&
+	(cd dir1 &&
 	cat ../file2 >file3 &&
-	git update-index --again &&
-	cd .. &&
+	git update-index --again
+	) &&
 	git ls-files -s >current &&
 	cmp current expected'

diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 3ce501b..25afb4f 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -55,15 +55,13 @@ test_expect_success setup '

 # We have to run from a sub-directory to trigger prune_path
 # Then we finally get to run our --with-tree test
-cd sub

 test_expect_success 'git -ls-files --with-tree should succeed from subdir' '

-	git ls-files --with-tree=HEAD~1 >../output
+	(cd sub && git ls-files --with-tree=HEAD~1 >../output)

 '

-cd ..
 test_expect_success \
     'git -ls-files --with-tree should add entries from named tree.' \
     'test_cmp expected output'
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 8f785e7..1a362d2 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -42,23 +42,23 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git commit -a -m "Modify A2" &&

 	git clone ./. clone1 &&
-	cd clone1 &&
+	(cd clone1 &&
 	git checkout -b topic origin/topic &&
-	git merge origin/master &&
-	cd .. &&
+	git merge origin/master
+	) &&

 	echo Fifth > B &&
 	git add B &&
 	git commit -m "Add different B" &&

 	git clone ./. clone2 &&
-	cd clone2 &&
+	(cd clone2 &&
 	git checkout -b topic origin/topic &&
 	test_must_fail git merge origin/master &&
 	echo Resolved > B &&
 	git add B &&
-	git commit -m "Merge origin/master into topic" &&
-	cd .. &&
+	git commit -m "Merge origin/master into topic"
+	) &&

 	git checkout topic &&
 	echo Fourth >> B &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 62e208a..3f43012 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -69,9 +69,9 @@ test_expect_success 'apply stashed changes (including index)' '
 test_expect_success 'unstashing in a subdirectory' '
 	git reset --hard HEAD &&
 	mkdir subdir &&
-	cd subdir &&
-	git stash apply &&
-	cd ..
+	(cd subdir &&
+	git stash apply
+	)
 '

 test_expect_success 'drop top stash' '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 8e391cf..737c3d9 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -85,10 +85,10 @@ EOF
 "

 commit_file sm1 &&
-cd sm1 &&
+head3=$(cd sm1 &&
 git reset --hard HEAD~2 >/dev/null &&
-head3=$(git rev-parse --verify HEAD | cut -c1-7) &&
-cd ..
+git rev-parse --verify HEAD | cut -c1-7
+)

 test_expect_success 'modified submodule(backward)' "
 	git diff-index -p --submodule=log HEAD >actual &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4eb10f6..34d59d5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -21,18 +21,18 @@ test_expect_success setup '

 test_expect_success "clone and setup child repos" '
 	git clone . one &&
-	cd one &&
+	(cd one &&
 	echo >file updated by one &&
-	git commit -a -m "updated by one" &&
-	cd .. &&
+	git commit -a -m "updated by one"
+	) &&
 	git clone . two &&
-	cd two &&
+	(cd two &&
 	git config branch.master.remote one &&
 	git config remote.one.url ../one/.git/ &&
-	git config remote.one.fetch refs/heads/master:refs/heads/one &&
-	cd .. &&
+	git config remote.one.fetch refs/heads/master:refs/heads/one
+	) &&
 	git clone . three &&
-	cd three &&
+	(cd three &&
 	git config branch.master.remote two &&
 	git config branch.master.merge refs/heads/one &&
 	mkdir -p .git/remotes &&
@@ -40,8 +40,8 @@ test_expect_success "clone and setup child repos" '
 		echo "URL: ../two/.git/"
 		echo "Pull: refs/heads/master:refs/heads/two"
 		echo "Pull: refs/heads/one:refs/heads/one"
-	} >.git/remotes/two &&
-	cd .. &&
+	} >.git/remotes/two
+	) &&
 	git clone . bundle &&
 	git clone . seven
 '
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 4185b7c..01dfa51 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -104,7 +104,7 @@ test_expect_success '"git fsck" works' '
 test_expect_success 'repack, clone and fetch work' '
      git repack -a -d &&
      git clone --no-hardlinks . clone_dir &&
-     cd clone_dir &&
+     (cd clone_dir &&
      git show HEAD~5 | grep "A U Thor" &&
      git show $HASH2 | grep "A U Thor" &&
      git cat-file commit $R &&
@@ -113,8 +113,8 @@ test_expect_success 'repack, clone and fetch work' '
      git fetch ../ "refs/replace/*:refs/replace/*" &&
      git show HEAD~5 | grep "O Thor" &&
      git show $HASH2 | grep "O Thor" &&
-     git cat-file commit $R &&
-     cd ..
+     git cat-file commit $R
+     )
 '

 test_expect_success '"git replace" listing and deleting' '
@@ -177,10 +177,10 @@ test_expect_success 'create parallel branch without the bug' '

 test_expect_success 'push to cloned repo' '
      git push cloned $HASH6^:refs/heads/parallel &&
-     cd clone_dir &&
+     (cd clone_dir &&
      git checkout parallel &&
-     git log --pretty=oneline | grep $PARA2 &&
-     cd ..
+     git log --pretty=oneline | grep $PARA2
+     )
 '

 test_expect_success 'push branch with replacement' '
@@ -191,20 +191,20 @@ test_expect_success 'push branch with replacement' '
      git show $HASH6~2 | grep "O Thor" &&
      git show $PARA3 | grep "O Thor" &&
      git push cloned $HASH6^:refs/heads/parallel2 &&
-     cd clone_dir &&
+     (cd clone_dir &&
      git checkout parallel2 &&
      git log --pretty=oneline | grep $PARA3 &&
-     git show $PARA3 | grep "A U Thor" &&
-     cd ..
+     git show $PARA3 | grep "A U Thor"
+     )
 '

 test_expect_success 'fetch branch with replacement' '
      git branch tofetch $HASH6 &&
-     cd clone_dir &&
+     (cd clone_dir &&
      git fetch origin refs/heads/tofetch:refs/heads/parallel3
      git log --pretty=oneline parallel3 | grep $PARA3
      git show $PARA3 | grep "A U Thor"
-     cd ..
+     )
 '

 test_expect_success 'bisect and replacements' '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 9bda970..21b0839 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -413,12 +413,12 @@ test_expect_success 'submodule <invalid-path> warns' '

 test_expect_success 'add submodules without specifying an explicit path' '
 	mkdir repo &&
-	cd repo &&
+	(cd repo &&
 	git init &&
 	echo r >r &&
 	git add r &&
-	git commit -m "repo commit 1" &&
-	cd .. &&
+	git commit -m "repo commit 1"
+	) &&
 	git clone --bare repo/ bare.git &&
 	cd addtest &&
 	git submodule add "$submodurl/repo" &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index cee319d..b5ad45f 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -66,10 +66,10 @@ EOF
 "

 commit_file sm1 &&
-cd sm1 &&
+head3=$(cd sm1 &&
 git reset --hard HEAD~2 >/dev/null &&
-head3=$(git rev-parse --verify HEAD | cut -c1-7) &&
-cd ..
+git rev-parse --verify HEAD | cut -c1-7
+)

 test_expect_success 'modified submodule(backward)' "
     git submodule summary >actual &&
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 13766ab..75388f3 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -22,7 +22,7 @@ esac
 test_expect_success \
     'initialize git svn' '
 	mkdir import &&
-	cd import &&
+	(cd import &&
 	echo foo > foo &&
 	ln -s foo foo.link
 	mkdir -p dir/a/b/c/d/e &&
@@ -31,8 +31,8 @@ test_expect_success \
 	echo "zzz" > bar/zzz &&
 	echo "#!/bin/sh" > exec.sh &&
 	chmod +x exec.sh &&
-	svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null &&
-	cd .. &&
+	svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
+	) &&
 	rm -rf import &&
 	git svn init "$svnrepo"'

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 929499e..f53a1a9 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -54,7 +54,7 @@ cd ..
 rm -rf import
 test_expect_success 'checkout working copy from svn' 'svn co "$svnrepo" test_wc'
 test_expect_success 'setup some commits to svn' \
-	'cd test_wc &&
+	'(cd test_wc &&
 		echo Greetings >> kw.c &&
 		poke kw.c &&
 		svn_cmd commit -m "Not yet an Id" &&
@@ -63,8 +63,8 @@ test_expect_success 'setup some commits to svn' \
 		svn_cmd commit -m "Modified file, but still not yet an Id" &&
 		svn_cmd propset svn:keywords Id kw.c &&
 		poke kw.c &&
-		svn_cmd commit -m "Propset Id" &&
-	cd ..'
+		svn_cmd commit -m "Propset Id"
+	)'

 test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git svn fetch'
@@ -82,12 +82,12 @@ got="`sed -ne 2p kw.c`"
 test_expect_success 'raw $Id$ found in kw.c' "test '$expect' = '$got'"

 test_expect_success "propset CR on crlf files" \
-	'cd test_wc &&
+	'(cd test_wc &&
 		svn_cmd propset svn:eol-style CR empty &&
 		svn_cmd propset svn:eol-style CR crlf &&
 		svn_cmd propset svn:eol-style CR ne_crlf &&
-		svn_cmd commit -m "propset CR on crlf files" &&
-	 cd ..'
+		svn_cmd commit -m "propset CR on crlf files"
+	 )'

 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	'git svn fetch &&
@@ -137,7 +137,7 @@ cat > show-ignore.expect <<\EOF
 EOF

 test_expect_success 'test show-ignore' "
-	cd test_wc &&
+	(cd test_wc &&
 	mkdir -p deeply/nested/directory &&
 	touch deeply/nested/directory/.keep &&
 	svn_cmd add deeply &&
@@ -146,7 +146,7 @@ test_expect_success 'test show-ignore' "
 no-such-file*
 ' .
 	svn_cmd commit -m 'propset svn:ignore'
-	cd .. &&
+	) &&
 	git svn show-ignore > show-ignore.got &&
 	cmp show-ignore.expect show-ignore.got
 	"
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 028fb19..d60a8ef 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -4,13 +4,13 @@ test_description='git svn rmdir'

 test_expect_success 'initialize repo' '
 	mkdir import &&
-	cd import &&
+	(cd import &&
 	mkdir -p deeply/nested/directory/number/1 &&
 	mkdir -p deeply/nested/directory/number/2 &&
 	echo foo > deeply/nested/directory/number/1/file &&
 	echo foo > deeply/nested/directory/number/2/another &&
-	svn_cmd import -m "import for git svn" . "$svnrepo" &&
-	cd ..
+	svn_cmd import -m "import for git svn" . "$svnrepo"
+	)
 	'

 test_expect_success 'mirror via git svn' '
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index bbfd7f4..d2f0e92 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -8,13 +8,13 @@ test_description='git svn fetching'

 test_expect_success 'initialize repo' '
 	mkdir import &&
-	cd import &&
+	(cd import &&
 	mkdir -p trunk &&
 	echo hello > trunk/readme &&
-	svn_cmd import -m "initial" . "$svnrepo" &&
-	cd .. &&
+	svn_cmd import -m "initial" . "$svnrepo"
+	) &&
 	svn_cmd co "$svnrepo" wc &&
-	cd wc &&
+	(cd wc &&
 	echo world >> trunk/readme &&
 	poke trunk/readme &&
 	svn_cmd commit -m "another commit" &&
@@ -22,8 +22,8 @@ test_expect_success 'initialize repo' '
 	svn_cmd mv trunk thunk &&
 	echo goodbye >> thunk/readme &&
 	poke thunk/readme &&
-	svn_cmd commit -m "bye now" &&
-	cd ..
+	svn_cmd commit -m "bye now"
+	)
 	'

 test_expect_success 'init and fetch a moved directory' '
@@ -85,11 +85,11 @@ test_expect_success 'follow larger parent' '
 test_expect_success 'follow higher-level parent' '
         svn mkdir -m "follow higher-level parent" "$svnrepo"/blob &&
         svn co "$svnrepo"/blob blob &&
-        cd blob &&
+        (cd blob &&
                 echo hi > hi &&
                 svn add hi &&
-                svn commit -m "hihi" &&
-                cd ..
+                svn commit -m "hihi"
+                ) &&
         svn mkdir -m "new glob at top level" "$svnrepo"/glob &&
         svn mv -m "move blob down a level" "$svnrepo"/blob "$svnrepo"/glob/blob &&
         git svn init --minimize-url -i blob "$svnrepo"/glob/blob &&
@@ -117,18 +117,18 @@ test_expect_success 'follow-parent avoids deleting relevant info' '
 	   import/trunk/subversion/bindings/swig/perl/t/larger-parent &&
 	  echo "bad delete test 2" > \
 	   import/trunk/subversion/bindings/swig/perl/another-larger &&
-	cd import &&
-	  svn import -m "r9270 test" . "$svnrepo"/r9270 &&
-	cd .. &&
+	(cd import &&
+	  svn import -m "r9270 test" . "$svnrepo"/r9270
+	) &&
 	svn_cmd co "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl r9270 &&
-	cd r9270 &&
+	(cd r9270 &&
 	  svn mkdir native &&
 	  svn mv t native/t &&
 	  for i in a b c; do svn mv $i.pm native/$i.pm; done &&
 	  echo z >> native/t/c.t &&
 	  poke native/t/c.t &&
-	  svn commit -m "reorg test" &&
-	cd .. &&
+	  svn commit -m "reorg test"
+	) &&
 	git svn init --minimize-url -i r9270-t \
 	  "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl/native/t &&
 	git svn fetch -i r9270-t &&
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index dd48e9c..d432d83 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -6,10 +6,10 @@ test_description='git svn commit-diff'

 test_expect_success 'initialize repo' '
 	mkdir import &&
-	cd import &&
+	(cd import &&
 	echo hello > readme &&
-	svn_cmd import -m "initial" . "$svnrepo" &&
-	cd .. &&
+	svn_cmd import -m "initial" . "$svnrepo"
+	) &&
 	echo hello > readme &&
 	git update-index --add readme &&
 	git commit -a -m "initial" &&
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 12f21b7..af367a1 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -6,21 +6,21 @@ test_description='git svn commit-diff clobber'

 test_expect_success 'initialize repo' '
 	mkdir import &&
-	cd import &&
+	(cd import &&
 	echo initial > file &&
-	svn_cmd import -m "initial" . "$svnrepo" &&
-	cd .. &&
+	svn_cmd import -m "initial" . "$svnrepo"
+	) &&
 	echo initial > file &&
 	git update-index --add file &&
 	git commit -a -m "initial"
 	'
 test_expect_success 'commit change from svn side' '
 	svn_cmd co "$svnrepo" t.svn &&
-	cd t.svn &&
+	(cd t.svn &&
 	echo second line from svn >> file &&
 	poke file &&
-	svn_cmd commit -m "second line from svn" &&
-	cd .. &&
+	svn_cmd commit -m "second line from svn"
+	) &&
 	rm -rf t.svn
 	'

@@ -44,11 +44,11 @@ test_expect_success 'dcommit fails to commit because of conflict' '
 	git svn fetch &&
 	git reset --hard refs/${remotes_git_svn} &&
 	svn_cmd co "$svnrepo" t.svn &&
-	cd t.svn &&
+	(cd t.svn &&
 	echo fourth line from svn >> file &&
 	poke file &&
-	svn_cmd commit -m "fourth line from svn" &&
-	cd .. &&
+	svn_cmd commit -m "fourth line from svn"
+	) &&
 	rm -rf t.svn &&
 	echo "fourth line from git" >> file &&
 	git commit -a -m "fourth line from git" &&
@@ -68,11 +68,11 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "

 test_expect_success 'commit another change from svn side' '
 	svn_cmd co "$svnrepo" t.svn &&
-	cd t.svn &&
+	(cd t.svn &&
 		echo third line from svn >> file &&
 		poke file &&
-		svn_cmd commit -m "third line from svn" &&
-	cd .. &&
+		svn_cmd commit -m "third line from svn"
+	) &&
 	rm -rf t.svn
 	'

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 901b8e0..f60b306 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -6,14 +6,14 @@ test_description='git svn metadata migrations from previous versions'
 test_expect_success 'setup old-looking metadata' '
 	cp "$GIT_DIR"/config "$GIT_DIR"/config-old-git-svn &&
 	mkdir import &&
-	cd import &&
+	(cd import &&
 		for i in trunk branches/a branches/b \
 		         tags/0.1 tags/0.2 tags/0.3; do
 			mkdir -p $i && \
 			echo hello >> $i/README || exit 1
 		done && \
 		svn_cmd import -m test . "$svnrepo"
-		cd .. &&
+		) &&
 	git svn init "$svnrepo" &&
 	git svn fetch &&
 	rm -rf "$GIT_DIR"/svn &&
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 84f7c9b..a7d0c7d 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -37,11 +37,11 @@ EOF
 test_expect_success 'setup svn repository' '
 	svn_cmd co "$svnrepo" mysvnwork &&
 	mkdir -p mysvnwork/trunk &&
-	cd mysvnwork &&
+	(cd mysvnwork &&
 		big_text_block >> trunk/README &&
 		svn_cmd add trunk &&
-		svn_cmd ci -m "first commit" trunk &&
-		cd ..
+		svn_cmd ci -m "first commit" trunk
+		)
 	'

 test_expect_success 'setup git mirror and merge' '
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 767799e..9fdbc9b 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -61,11 +61,11 @@ test_expect_success 'add a file with plus signs' '

 test_expect_success 'clone the repository to test rebase' '
 	git svn clone "$svnrepo" test-rebase &&
-	cd test-rebase &&
+	(cd test-rebase &&
 		echo test-rebase > test-rebase &&
 		git add test-rebase &&
-		git commit -m test-rebase &&
-		cd ..
+		git commit -m test-rebase
+		)
 	'

 test_expect_success 'make a commit to test rebase' '
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 0374a74..244b5cd 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -8,14 +8,14 @@ test_description='git svn log tests'

 test_expect_success 'setup repository and import' '
 	mkdir import &&
-	cd import &&
+	(cd import &&
 		for i in trunk branches/a branches/b \
 		         tags/0.1 tags/0.2 tags/0.3; do
 			mkdir -p $i && \
 			echo hello >> $i/README || exit 1
 		done && \
 		svn_cmd import -m test . "$svnrepo"
-		cd .. &&
+		) &&
 	git svn init "$svnrepo" -T trunk -b branches -t tags &&
 	git svn fetch &&
 	git reset --hard trunk &&
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 5fb94fb..e3f08c4 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -39,27 +39,27 @@ quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"

 test_expect_success 'setup repository and import' '
 	mkdir info &&
-	cd info &&
+	(cd info &&
 		echo FIRST > A &&
 		echo one > file &&
 		ln -s file symlink-file &&
 		mkdir directory &&
 		touch directory/.placeholder &&
 		ln -s directory symlink-directory &&
-		svn_cmd import -m "initial" . "$svnrepo" &&
-	cd .. &&
+		svn_cmd import -m "initial" . "$svnrepo"
+	) &&
 	svn_cmd co "$svnrepo" svnwc &&
-	cd svnwc &&
+	(cd svnwc &&
 		echo foo > foo &&
 		svn_cmd add foo &&
 		svn_cmd commit -m "change outside directory" &&
-		svn_cmd update &&
-	cd .. &&
+		svn_cmd update
+	) &&
 	mkdir gitwc &&
-	cd gitwc &&
+	(cd gitwc &&
 		git svn init "$svnrepo" &&
-		git svn fetch &&
-	cd .. &&
+		git svn fetch
+	) &&
 	ptouch gitwc/file svnwc/file &&
 	ptouch gitwc/directory svnwc/directory &&
 	ptouch gitwc/symlink-file svnwc/symlink-file &&
@@ -138,14 +138,14 @@ test_expect_success 'info --url symlink-directory' '

 test_expect_success 'info added-file' "
 	echo two > gitwc/added-file &&
-	cd gitwc &&
-		git add added-file &&
-	cd .. &&
+	(cd gitwc &&
+		git add added-file
+	) &&
 	cp gitwc/added-file svnwc/added-file &&
 	ptouch gitwc/added-file svnwc/added-file &&
-	cd svnwc &&
-		svn_cmd add added-file > /dev/null &&
-	cd .. &&
+	(cd svnwc &&
+		svn_cmd add added-file > /dev/null
+	) &&
 	(cd svnwc; svn info added-file) > expected.info-added-file &&
 	(cd gitwc; git svn info added-file) > actual.info-added-file &&
 	test_cmp expected.info-added-file actual.info-added-file
@@ -160,12 +160,12 @@ test_expect_success 'info added-directory' "
 	mkdir gitwc/added-directory svnwc/added-directory &&
 	ptouch gitwc/added-directory svnwc/added-directory &&
 	touch gitwc/added-directory/.placeholder &&
-	cd svnwc &&
-		svn_cmd add added-directory > /dev/null &&
-	cd .. &&
-	cd gitwc &&
-		git add added-directory &&
-	cd .. &&
+	(cd svnwc &&
+		svn_cmd add added-directory > /dev/null
+	) &&
+	(cd gitwc &&
+		git add added-directory
+	) &&
 	(cd svnwc; svn info added-directory) \
 		> expected.info-added-directory &&
 	(cd gitwc; git svn info added-directory) \
@@ -179,14 +179,14 @@ test_expect_success 'info --url added-directory' '
 	'

 test_expect_success 'info added-symlink-file' "
-	cd gitwc &&
+	(cd gitwc &&
 		ln -s added-file added-symlink-file &&
-		git add added-symlink-file &&
-	cd .. &&
-	cd svnwc &&
+		git add added-symlink-file
+	) &&
+	(cd svnwc &&
 		ln -s added-file added-symlink-file &&
-		svn_cmd add added-symlink-file > /dev/null &&
-	cd .. &&
+		svn_cmd add added-symlink-file > /dev/null
+	) &&
 	ptouch gitwc/added-symlink-file svnwc/added-symlink-file &&
 	(cd svnwc; svn info added-symlink-file) \
 		> expected.info-added-symlink-file &&
@@ -202,14 +202,14 @@ test_expect_success 'info --url added-symlink-file' '
 	'

 test_expect_success 'info added-symlink-directory' "
-	cd gitwc &&
+	(cd gitwc &&
 		ln -s added-directory added-symlink-directory &&
-		git add added-symlink-directory &&
-	cd .. &&
-	cd svnwc &&
+		git add added-symlink-directory
+	) &&
+	(cd svnwc &&
 		ln -s added-directory added-symlink-directory &&
-		svn_cmd add added-symlink-directory > /dev/null &&
-	cd .. &&
+		svn_cmd add added-symlink-directory > /dev/null
+	) &&
 	ptouch gitwc/added-symlink-directory svnwc/added-symlink-directory &&
 	(cd svnwc; svn info added-symlink-directory) \
 		> expected.info-added-symlink-directory &&
@@ -230,12 +230,12 @@ test_expect_success 'info --url added-symlink-directory' '
 # simply reuses the Last Changed Date.

 test_expect_success 'info deleted-file' "
-	cd gitwc &&
-		git rm -f file > /dev/null &&
-	cd .. &&
-	cd svnwc &&
-		svn_cmd rm --force file > /dev/null &&
-	cd .. &&
+	(cd gitwc &&
+		git rm -f file > /dev/null
+	) &&
+	(cd svnwc &&
+		svn_cmd rm --force file > /dev/null
+	) &&
 	(cd svnwc; svn info file) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
 		> expected.info-deleted-file &&
@@ -251,12 +251,12 @@ test_expect_success 'info --url file (deleted)' '
 	'

 test_expect_success 'info deleted-directory' "
-	cd gitwc &&
-		git rm -r -f directory > /dev/null &&
-	cd .. &&
-	cd svnwc &&
-		svn_cmd rm --force directory > /dev/null &&
-	cd .. &&
+	(cd gitwc &&
+		git rm -r -f directory > /dev/null
+	) &&
+	(cd svnwc &&
+		svn_cmd rm --force directory > /dev/null
+	) &&
 	(cd svnwc; svn info directory) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
 		> expected.info-deleted-directory &&
@@ -272,12 +272,12 @@ test_expect_success 'info --url directory (deleted)' '
 	'

 test_expect_success 'info deleted-symlink-file' "
-	cd gitwc &&
-		git rm -f symlink-file > /dev/null &&
-	cd .. &&
-	cd svnwc &&
-		svn_cmd rm --force symlink-file > /dev/null &&
-	cd .. &&
+	(cd gitwc &&
+		git rm -f symlink-file > /dev/null
+	) &&
+	(cd svnwc &&
+		svn_cmd rm --force symlink-file > /dev/null
+	) &&
 	(cd svnwc; svn info symlink-file) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
 		> expected.info-deleted-symlink-file &&
@@ -294,12 +294,12 @@ test_expect_success 'info --url symlink-file (deleted)' '
 	'

 test_expect_success 'info deleted-symlink-directory' "
-	cd gitwc &&
-		git rm -f symlink-directory > /dev/null &&
-	cd .. &&
-	cd svnwc &&
-		svn_cmd rm --force symlink-directory > /dev/null &&
-	cd .. &&
+	(cd gitwc &&
+		git rm -f symlink-directory > /dev/null
+	) &&
+	(cd svnwc &&
+		svn_cmd rm --force symlink-directory > /dev/null
+	) &&
 	(cd svnwc; svn info symlink-directory) |
 	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
 		 > expected.info-deleted-symlink-directory &&
@@ -346,9 +346,9 @@ test_expect_success 'info --url unknown-directory' '
 	'

 test_expect_success 'info unknown-symlink-file' "
-	cd gitwc &&
-		ln -s unknown-file unknown-symlink-file &&
-	cd .. &&
+	(cd gitwc &&
+		ln -s unknown-file unknown-symlink-file
+	) &&
 	(cd gitwc; test_must_fail git svn info unknown-symlink-file) \
 		 2> actual.info-unknown-symlink-file &&
 	grep unknown-symlink-file actual.info-unknown-symlink-file
@@ -361,9 +361,9 @@ test_expect_success 'info --url unknown-symlink-file' '
 	'

 test_expect_success 'info unknown-symlink-directory' "
-	cd gitwc &&
-		ln -s unknown-directory unknown-symlink-directory &&
-	cd .. &&
+	(cd gitwc &&
+		ln -s unknown-directory unknown-symlink-directory
+	) &&
 	(cd gitwc; test_must_fail git svn info unknown-symlink-directory) \
 		 2> actual.info-unknown-symlink-directory &&
 	grep unknown-symlink-directory actual.info-unknown-symlink-directory
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index 9d9ebd5..cddb9d4 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -20,9 +20,9 @@ test_expect_success 'setup svnrepo' '

 test_expect_success 'test clone with percent escapes' '
 	git svn clone "$svnrepo/pr%20ject" clone &&
-	cd clone &&
-		git rev-parse refs/${remotes_git_svn} &&
-	cd ..
+	(cd clone &&
+		git rev-parse refs/${remotes_git_svn}
+	)
 '

 # SVN works either way, so should we...
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index 0455216..0ed90d9 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -8,10 +8,10 @@ test_description='git svn respects rewriteRoot during rebuild'
 . ./lib-git-svn.sh

 mkdir import
-cd import
+(cd import
 	touch foo
 	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
-cd ..
+)
 rm -rf import

 test_expect_success 'init, fetch and checkout repository' '
diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-svn-multi-glob-branch-names.sh
index c194186..096abd1 100755
--- a/t/t9125-git-svn-multi-glob-branch-names.sh
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -19,19 +19,19 @@ test_expect_success 'setup svnrepo' '
 test_expect_success 'test clone with multi-glob in branch names' '
 	git svn clone -T trunk -b branches/*/* -t tags \
 	              "$svnrepo/project" project &&
-	cd project &&
+	(cd project &&
 		git rev-parse "refs/remotes/v14.1/beta" &&
-		git rev-parse "refs/remotes/v14.1/gold" &&
-	cd ..
+		git rev-parse "refs/remotes/v14.1/gold"
+	)
 	'

 test_expect_success 'test dcommit to multi-globbed branch' "
-	cd project &&
+	(cd project &&
 	git reset --hard 'refs/remotes/v14.1/gold' &&
 	echo hello >> foo &&
 	git commit -m 'hello' -- foo &&
-	git svn dcommit &&
-	cd ..
+	git svn dcommit
+	)
 	"

 test_done
diff --git a/t/t9127-git-svn-partial-rebuild.sh b/t/t9127-git-svn-partial-rebuild.sh
index 4aab8ec..2e4789d 100755
--- a/t/t9127-git-svn-partial-rebuild.sh
+++ b/t/t9127-git-svn-partial-rebuild.sh
@@ -9,27 +9,27 @@ test_description='git svn partial-rebuild tests'
 test_expect_success 'initialize svnrepo' '
 	mkdir import &&
 	(
-		cd import &&
+		(cd import &&
 		mkdir trunk branches tags &&
-		cd trunk &&
-		echo foo > foo &&
-		cd .. &&
+		(cd trunk &&
+		echo foo > foo
+		) &&
 		svn_cmd import -m "import for git-svn" . "$svnrepo" >/dev/null &&
 		svn_cmd copy "$svnrepo"/trunk "$svnrepo"/branches/a \
-			-m "created branch a" &&
-		cd .. &&
+			-m "created branch a"
+		) &&
 		rm -rf import &&
 		svn_cmd co "$svnrepo"/trunk trunk &&
-		cd trunk &&
+		(cd trunk &&
 		echo bar >> foo &&
-		svn_cmd ci -m "updated trunk" &&
-		cd .. &&
+		svn_cmd ci -m "updated trunk"
+		) &&
 		svn_cmd co "$svnrepo"/branches/a a &&
-		cd a &&
+		(cd a &&
 		echo baz >> a &&
 		svn_cmd add a &&
-		svn_cmd ci -m "updated a" &&
-		cd .. &&
+		svn_cmd ci -m "updated a"
+		) &&
 		git svn init --stdlayout "$svnrepo"
 	)
 '
@@ -41,11 +41,11 @@ test_expect_success 'import an early SVN revision into git' '
 test_expect_success 'make full git mirror of SVN' '
 	mkdir mirror &&
 	(
-		cd mirror &&
+		(cd mirror &&
 		git init &&
 		git svn init --stdlayout "$svnrepo" &&
-		git svn fetch &&
-		cd ..
+		git svn fetch
+		)
 	)
 '

diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
index 807e494..4b034a6 100755
--- a/t/t9128-git-svn-cmd-branch.sh
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -9,19 +9,19 @@ test_description='git svn partial-rebuild tests'
 test_expect_success 'initialize svnrepo' '
 	mkdir import &&
 	(
-		cd import &&
+		(cd import &&
 		mkdir trunk branches tags &&
-		cd trunk &&
-		echo foo > foo &&
-		cd .. &&
-		svn_cmd import -m "import for git-svn" . "$svnrepo" >/dev/null &&
-		cd .. &&
+		(cd trunk &&
+		echo foo > foo
+		) &&
+		svn_cmd import -m "import for git-svn" . "$svnrepo" >/dev/null
+		) &&
 		rm -rf import &&
 		svn_cmd co "$svnrepo"/trunk trunk &&
-		cd trunk &&
+		(cd trunk &&
 		echo bar >> foo &&
-		svn_cmd ci -m "updated trunk" &&
-		cd .. &&
+		svn_cmd ci -m "updated trunk"
+		) &&
 		rm -rf trunk
 	)
 '
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index 636ca0a..d60da63 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -6,10 +6,10 @@ test_description='git svn dcommit clobber series'

 test_expect_success 'initialize repo' '
 	mkdir import &&
-	cd import &&
+	(cd import &&
 	awk "BEGIN { for (i = 1; i < 64; i++) { print i } }" > file
-	svn_cmd import -m "initial" . "$svnrepo" &&
-	cd .. &&
+	svn_cmd import -m "initial" . "$svnrepo"
+	) &&
 	git svn init "$svnrepo" &&
 	git svn fetch &&
 	test -e file
@@ -19,14 +19,14 @@ test_expect_success '(supposedly) non-conflicting change from SVN' '
 	test x"`sed -n -e 58p < file`" = x58 &&
 	test x"`sed -n -e 61p < file`" = x61 &&
 	svn_cmd co "$svnrepo" tmp &&
-	cd tmp &&
+	(cd tmp &&
 		perl -i.bak -p -e "s/^58$/5588/" file &&
 		perl -i.bak -p -e "s/^61$/6611/" file &&
 		poke file &&
 		test x"`sed -n -e 58p < file`" = x5588 &&
 		test x"`sed -n -e 61p < file`" = x6611 &&
-		svn_cmd commit -m "58 => 5588, 61 => 6611" &&
-		cd ..
+		svn_cmd commit -m "58 => 5588, 61 => 6611"
+	)
 	'

 test_expect_success 'some unrelated changes to git' "
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2aeed7b..1a205a4 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1056,11 +1056,10 @@ test_expect_success \
 	'P: supermodule & submodule mix' \
 	'git fast-import <input &&
 	 git checkout subuse1 &&
-	 rm -rf sub && mkdir sub && cd sub &&
+	 rm -rf sub && mkdir sub && (cd sub &&
 	 git init &&
 	 git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
-	 git checkout master &&
-	 cd .. &&
+	 git checkout master) &&
 	 git submodule init &&
 	 git submodule update'

diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 925bd0f..1bbfd82 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -129,21 +129,22 @@ test_expect_success 'cvs co (use attributes)' '
 '

 test_expect_success 'adding files' '
-    cd cvswork/subdir &&
+    (cd cvswork &&
+    (cd subdir &&
     echo "more text" > src.c &&
     GIT_CONFIG="$git_config" cvs -Q add src.c >cvs.log 2>&1 &&
     marked_as . src.c "" &&
-    echo "psuedo-binary" > temp.bin &&
-    cd .. &&
+    echo "psuedo-binary" > temp.bin
+    ) &&
     GIT_CONFIG="$git_config" cvs -Q add subdir/temp.bin >cvs.log 2>&1 &&
     marked_as subdir temp.bin "-kb" &&
     cd subdir &&
     GIT_CONFIG="$git_config" cvs -Q ci -m "adding files" >cvs.log 2>&1 &&
     marked_as . temp.bin "-kb" &&
     marked_as . src.c ""
+    )
 '

-cd "$WORKDIR"
 test_expect_success 'updating' '
     git pull gitcvs.git &&
     echo 'hi' > subdir/newfile.bin &&
@@ -153,9 +154,9 @@ test_expect_success 'updating' '
     git add subdir/newfile.bin subdir/file.h subdir/newfile.c binfile.bin &&
     git commit -q -m "Add and change some files" &&
     git push gitcvs.git >/dev/null &&
-    cd cvswork &&
-    GIT_CONFIG="$git_config" cvs -Q update &&
-    cd .. &&
+    (cd cvswork &&
+    GIT_CONFIG="$git_config" cvs -Q update
+    ) &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes "" &&
@@ -233,35 +234,35 @@ test_expect_success 'cvs co another copy (guess)' '
 '

 test_expect_success 'add text (guess)' '
-    cd cvswork &&
+    (cd cvswork &&
     echo "simpleText" > simpleText.c &&
-    GIT_CONFIG="$git_config" cvs -Q add simpleText.c &&
-    cd .. &&
+    GIT_CONFIG="$git_config" cvs -Q add simpleText.c
+    ) &&
     marked_as cvswork simpleText.c ""
 '

 test_expect_success 'add bin (guess)' '
-    cd cvswork &&
+    (cd cvswork &&
     echo "simpleBin: NUL: Q <- there" | q_to_nul > simpleBin.bin &&
-    GIT_CONFIG="$git_config" cvs -Q add simpleBin.bin &&
-    cd .. &&
+    GIT_CONFIG="$git_config" cvs -Q add simpleBin.bin
+    ) &&
     marked_as cvswork simpleBin.bin -kb
 '

 test_expect_success 'remove files (guess)' '
-    cd cvswork &&
+    (cd cvswork &&
     GIT_CONFIG="$git_config" cvs -Q rm -f subdir/file.h &&
-    cd subdir &&
-    GIT_CONFIG="$git_config" cvs -Q rm -f withCr.bin &&
-    cd ../.. &&
+    (cd subdir &&
+    GIT_CONFIG="$git_config" cvs -Q rm -f withCr.bin
+    )) &&
     marked_as cvswork/subdir withCr.bin -kb &&
     marked_as cvswork/subdir file.h ""
 '

 test_expect_success 'cvs ci (guess)' '
-    cd cvswork &&
-    GIT_CONFIG="$git_config" cvs -Q ci -m "add/rm files" >cvs.log 2>&1 &&
-    cd .. &&
+    (cd cvswork &&
+    GIT_CONFIG="$git_config" cvs -Q ci -m "add/rm files" >cvs.log 2>&1
+    ) &&
     marked_as cvswork textfile.c "" &&
     marked_as cvswork binfile.bin -kb &&
     marked_as cvswork .gitattributes "" &&
@@ -278,9 +279,9 @@ test_expect_success 'cvs ci (guess)' '
 '

 test_expect_success 'update subdir of other copy (guess)' '
-    cd cvswork2/subdir &&
-    GIT_CONFIG="$git_config" cvs -Q update &&
-    cd ../.. &&
+    (cd cvswork2/subdir &&
+    GIT_CONFIG="$git_config" cvs -Q update
+    ) &&
     marked_as cvswork2 textfile.c "" &&
     marked_as cvswork2 binfile.bin -kb &&
     marked_as cvswork2 .gitattributes "" &&
@@ -304,11 +305,11 @@ test_expect_success 'update/merge full other copy (guess)' '
     git add multilineTxt.c &&
     git commit -q -m "modify multiline file" >> "${WORKDIR}/marked.log" &&
     git push gitcvs.git >/dev/null &&
-    cd cvswork2 &&
+    (cd cvswork2 &&
     sed "s/1/replaced_1/" < multilineTxt.c > ml.temp &&
     mv ml.temp multilineTxt.c &&
-    GIT_CONFIG="$git_config" cvs update > cvs.log 2>&1 &&
-    cd .. &&
+    GIT_CONFIG="$git_config" cvs update > cvs.log 2>&1
+    ) &&
     marked_as cvswork2 textfile.c "" &&
     marked_as cvswork2 binfile.bin -kb &&
     marked_as cvswork2 .gitattributes "" &&
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 2eff9cd..6ef1c34 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup a cvs module' '

 	mkdir "$CVSROOT/module" &&
 	$CVS co -d module-cvs module &&
-	cd module-cvs &&
+	(cd module-cvs &&
 	cat <<EOF >o_fortuna &&
 O Fortuna
 velut luna
@@ -41,8 +41,8 @@ add "O Fortuna" lyrics

 These public domain lyrics make an excellent sample text.
 EOF
-	$CVS commit -F message &&
-	cd ..
+	$CVS commit -F message
+	)
 '

 test_expect_success 'import a trivial module' '
@@ -52,7 +52,7 @@ test_expect_success 'import a trivial module' '

 '

-test_expect_success 'pack refs' 'cd module-git && git gc && cd ..'
+test_expect_success 'pack refs' '(cd module-git && git gc)'

 test_expect_success 'initial import has correct .git/cvs-revisions' '

@@ -62,8 +62,7 @@ test_expect_success 'initial import has correct .git/cvs-revisions' '
 '

 test_expect_success 'update cvs module' '
-
-	cd module-cvs &&
+	(cd module-cvs &&
 	cat <<EOF >o_fortuna &&
 O Fortune,
 like the moon
@@ -86,16 +85,16 @@ translate to English

 My Latin is terrible.
 EOF
-	$CVS commit -F message &&
-	cd ..
+	$CVS commit -F message
+	)
 '

 test_expect_success 'update git module' '

-	cd module-git &&
+	(cd module-git &&
 	git cvsimport -a -R -z 0 module &&
-	git merge origin &&
-	cd .. &&
+	git merge origin
+	) &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna

 '
@@ -110,21 +109,20 @@ test_expect_success 'update has correct .git/cvs-revisions' '

 test_expect_success 'update cvs module' '

-	cd module-cvs &&
+	(cd module-cvs &&
 		echo 1 >tick &&
 		$CVS add tick &&
 		$CVS commit -m 1
-	cd ..
-
+	)
 '

 test_expect_success 'cvsimport.module config works' '

-	cd module-git &&
+	(cd module-git &&
 		git config cvsimport.module module &&
 		git cvsimport -a -R -z0 &&
-		git merge origin &&
-	cd .. &&
+		git merge origin
+	) &&
 	test_cmp module-cvs/tick module-git/tick

 '
@@ -141,12 +139,12 @@ test_expect_success 'second update has correct .git/cvs-revisions' '
 test_expect_success 'import from a CVS working tree' '

 	$CVS co -d import-from-wt module &&
-	cd import-from-wt &&
+	(cd import-from-wt &&
 		git cvsimport -a -z0 &&
 		echo 1 >expect &&
 		git log -1 --pretty=format:%s%n >actual &&
-		test_cmp actual expect &&
-	cd ..
+		test_cmp actual expect
+	)

 '

diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 958bdce..6733f0f 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -20,12 +20,12 @@ export CVSROOT
 test_expect_failure 'import with criss cross times on revisions' '

     git cvsimport -p"-x" -C module-git module &&
-    cd module-git &&
+    (cd module-git &&
         git log --pretty=format:%s > ../actual-master &&
         git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
         echo "" >> ../actual-master &&
-        echo "" >> ../actual-A &&
-    cd .. &&
+        echo "" >> ../actual-A
+    ) &&
     echo "Rev 4
 Rev 3
 Rev 2
-- 
1.7.3.rc0.181.g885f40
