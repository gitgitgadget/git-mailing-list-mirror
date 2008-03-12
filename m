From: Jeff King <peff@peff.net>
Subject: [PATCH 06/16] add test_cmp function for test scripts
Date: Wed, 12 Mar 2008 17:36:36 -0400
Message-ID: <20080312213636.GG26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYdW-0000bt-47
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbYCLVgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYCLVgm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:36:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3427 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbYCLVgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:36:40 -0400
Received: (qmail 3156 invoked by uid 111); 12 Mar 2008 21:36:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:36:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:36:36 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76996>

Many scripts compare actual and expected output using
"diff -u". This is nicer than "cmp" because the output shows
how the two differ. However, not all versions of diff
understand -u, leading to unnecessary test failure.

This adds a test_cmp function to the test scripts and
switches all "diff -u" invocations to use it. The function
uses the contents of "$GIT_TEST_CMP" to compare its
arguments; the default is "diff -u".

On systems with a less-capable diff, you can do:

  GIT_TEST_CMP=cmp make test

Signed-off-by: Jeff King <peff@peff.net>
---
The replacements were done mechanically with:

  perl -pi -e 's/(?<!git.)diff -u/test_cmp/' t/*.sh

Perhaps this should be a command-line option instead of an environment
variable? Maybe it should be auto-detected or set up in the Makefile?

 t/t0003-attributes.sh              |    2 +-
 t/t0022-crlf-rename.sh             |    2 +-
 t/t1005-read-tree-reset.sh         |    2 +-
 t/t2200-add-update.sh              |    2 +-
 t/t3001-ls-files-others-exclude.sh |    2 +-
 t/t3050-subprojects-fetch.sh       |    4 ++--
 t/t3060-ls-files-with-tree.sh      |    2 +-
 t/t3201-branch-contains.sh         |    6 +++---
 t/t3404-rebase-interactive.sh      |    4 ++--
 t/t3405-rebase-malformed.sh        |    4 ++--
 t/t3406-rebase-message.sh          |    2 +-
 t/t3701-add-interactive.sh         |    4 ++--
 t/t3902-quoted.sh                  |   16 ++++++++--------
 t/t3903-stash.sh                   |    2 +-
 t/t4023-diff-rename-typechange.sh  |    6 +++---
 t/t4024-diff-optimize-common.sh    |    2 +-
 t/t4025-hunk-header.sh             |    2 +-
 t/t4027-diff-submodule.sh          |    6 +++---
 t/t4105-apply-fuzz.sh              |    2 +-
 t/t4125-apply-ws-fuzz.sh           |    8 ++++----
 t/t4150-am-subdir.sh               |   10 +++++-----
 t/t4201-shortlog.sh                |    2 +-
 t/t5505-remote.sh                  |    6 +++---
 t/t5510-fetch.sh                   |    2 +-
 t/t5512-ls-remote.sh               |    8 ++++----
 t/t6004-rev-list-path-optim.sh     |    2 +-
 t/t6009-rev-list-parent.sh         |    2 +-
 t/t6027-merge-binary.sh            |    4 ++--
 t/t6029-merge-subtree.sh           |    2 +-
 t/t7010-setup.sh                   |   18 +++++++++---------
 t/t7201-co.sh                      |   18 +++++++++---------
 t/t7501-commit.sh                  |   14 +++++++-------
 t/t7502-commit.sh                  |   14 +++++++-------
 t/t7502-status.sh                  |    2 +-
 t/t7600-merge.sh                   |    2 +-
 t/t8003-blame.sh                   |    4 ++--
 t/t9001-send-email.sh              |    2 +-
 t/t9116-git-svn-log.sh             |   24 ++++++++++++------------
 t/t9200-git-cvsexportcommit.sh     |   14 +++++++-------
 t/test-lib.sh                      |   18 ++++++++++++++++++
 40 files changed, 133 insertions(+), 115 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 47f08a4..3faf135 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -11,7 +11,7 @@ attr_check () {
 
 	git check-attr test -- "$path" >actual &&
 	echo "$path: test: $2" >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 }
 
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 430a1d1..7d1ce2d 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -26,7 +26,7 @@ test_expect_success 'diff -M' '
 	git diff-tree -M -r --name-status HEAD^ HEAD |
 	sed -e "s/R[0-9]*/RNUM/" >actual &&
 	echo "RNUM	sample	elpmas" >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 8c45564..b0d31f5 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -24,7 +24,7 @@ test_expect_success 'setup' '
 test_expect_success 'reset should work' '
   git read-tree -u --reset HEAD^ &&
   git ls-files >actual &&
-  diff -u expect actual
+  test_cmp expect actual
 '
 
 test_done
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 24f892f..b664341 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -62,7 +62,7 @@ test_expect_success 'cache tree has not been corrupted' '
 	sed -e "s/ 0	/	/" >expect &&
 	git ls-tree -r $(git write-tree) |
 	sed -e "s/ blob / /" >current &&
-	diff -u expect current
+	test_cmp expect current
 
 '
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index b4297ba..55f057c 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -97,7 +97,7 @@ cat > expect << EOF
 EOF
 
 test_expect_success 'git-status honours core.excludesfile' \
-	'diff -u expect output'
+	'test_cmp expect output'
 
 test_expect_success 'trailing slash in exclude allows directory match(1)' '
 
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 34f26a8..2b21b10 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -26,7 +26,7 @@ test_expect_success clone '
 		cd cloned &&
 		(git rev-parse HEAD; git ls-files -s) >../actual
 	) &&
-	diff -u expected actual
+	test_cmp expected actual
 '
 
 test_expect_success advance '
@@ -46,7 +46,7 @@ test_expect_success fetch '
 		git pull &&
 		(git rev-parse HEAD; git ls-files -s) >../actual
 	) &&
-	diff -u expected actual
+	test_cmp expected actual
 '
 
 test_done
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 68eb266..3ce501b 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -66,6 +66,6 @@ test_expect_success 'git -ls-files --with-tree should succeed from subdir' '
 cd ..
 test_expect_success \
     'git -ls-files --with-tree should add entries from named tree.' \
-    'diff -u expected output'
+    'test_cmp expected output'
 
 test_done
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 9ef593f..b4cf628 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -31,7 +31,7 @@ test_expect_success 'branch --contains=master' '
 	{
 		echo "  master" && echo "* side"
 	} >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -41,7 +41,7 @@ test_expect_success 'branch --contains master' '
 	{
 		echo "  master" && echo "* side"
 	} >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -51,7 +51,7 @@ test_expect_success 'branch --contains=side' '
 	{
 		echo "* side"
 	} >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9c0acc5..9cf873f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -146,8 +146,8 @@ EOF
 test_expect_success 'stop on conflicting pick' '
 	git tag new-branch1 &&
 	! git rebase -i master &&
-	diff -u expect .git/.dotest-merge/patch &&
-	diff -u expect2 file1 &&
+	test_cmp expect .git/.dotest-merge/patch &&
+	test_cmp expect2 file1 &&
 	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
 	test 0 = $(grep -c "^[^#]" < .git/.dotest-merge/git-rebase-todo)
 '
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index e4e2e64..e5ad67c 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -41,8 +41,8 @@ test_expect_success rebase '
 	git rebase master side &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >F1 &&
 
-	diff -u F0 F1 &&
-	diff -u F F0
+	test_cmp F0 F1 &&
+	test_cmp F F0
 '
 
 test_done
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 332b2b2..5391080 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -37,7 +37,7 @@ test_expect_success 'rebase -m' '
 	git rebase -m master >report &&
 	sed -n -e "/^Already applied: /p" \
 		-e "/^Committed: /p" report >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c8dc1ac..77c90f6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -24,7 +24,7 @@ EOF
 test_expect_success 'diff works (initial)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/new file/,/content/p" <output >diff &&
-	diff -u expected diff
+	test_cmp expected diff
 '
 test_expect_success 'revert works (initial)' '
 	git add file &&
@@ -57,7 +57,7 @@ EOF
 test_expect_success 'diff works (commit)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/^index/,/content/p" <output >diff &&
-	diff -u expected diff
+	test_cmp expected diff
 '
 test_expect_success 'revert works (commit)' '
 	git add file &&
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 73da45f..fe4fb51 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -78,28 +78,28 @@ EOF
 
 test_expect_success 'check fully quoted output from ls-files' '
 
-	git ls-files >current && diff -u expect.quoted current
+	git ls-files >current && test_cmp expect.quoted current
 
 '
 
 test_expect_success 'check fully quoted output from diff-files' '
 
 	git diff --name-only >current &&
-	diff -u expect.quoted current
+	test_cmp expect.quoted current
 
 '
 
 test_expect_success 'check fully quoted output from diff-index' '
 
 	git diff --name-only HEAD >current &&
-	diff -u expect.quoted current
+	test_cmp expect.quoted current
 
 '
 
 test_expect_success 'check fully quoted output from diff-tree' '
 
 	git diff --name-only HEAD^ HEAD >current &&
-	diff -u expect.quoted current
+	test_cmp expect.quoted current
 
 '
 
@@ -111,28 +111,28 @@ test_expect_success 'setting core.quotepath' '
 
 test_expect_success 'check fully quoted output from ls-files' '
 
-	git ls-files >current && diff -u expect.raw current
+	git ls-files >current && test_cmp expect.raw current
 
 '
 
 test_expect_success 'check fully quoted output from diff-files' '
 
 	git diff --name-only >current &&
-	diff -u expect.raw current
+	test_cmp expect.raw current
 
 '
 
 test_expect_success 'check fully quoted output from diff-index' '
 
 	git diff --name-only HEAD >current &&
-	diff -u expect.raw current
+	test_cmp expect.raw current
 
 '
 
 test_expect_success 'check fully quoted output from diff-tree' '
 
 	git diff --name-only HEAD^ HEAD >current &&
-	diff -u expect.raw current
+	test_cmp expect.raw current
 
 '
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aa282e1..2d3ee3b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -34,7 +34,7 @@ EOF
 test_expect_success 'parents of stash' '
 	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
 	git diff stash^2..stash > output &&
-	diff -u output expect
+	test_cmp output expect
 '
 
 test_expect_success 'apply needs clean working directory' '
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 255604e..4dbfc6e 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -57,7 +57,7 @@ test_expect_success 'cross renames to be detected for regular files' '
 		echo "R100	foo	bar"
 		echo "R100	bar	foo"
 	} | sort >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -68,7 +68,7 @@ test_expect_success 'cross renames to be detected for typechange' '
 		echo "R100	foo	bar"
 		echo "R100	bar	foo"
 	} | sort >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -79,7 +79,7 @@ test_expect_success 'moves and renames' '
 		echo "R100	foo	bar"
 		echo "T100	foo"
 	} | sort >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 3c66102..c4d733f 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -150,7 +150,7 @@ test_expect_success 'diff -U0' '
 	do
 		git diff -U0 file-?$n
 	done | zc >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
index 9ba06b7..7a3dbc1 100755
--- a/t/t4025-hunk-header.sh
+++ b/t/t4025-hunk-header.sh
@@ -37,7 +37,7 @@ test_expect_success 'hunk header truncation with an overly long line' '
 		echo " A $N$N$N$N$N$N$N$N$N2"
 		echo " L  $N$N$N$N$N$N$N$N$N1"
 	) >expected &&
-	diff -u actual expected
+	test_cmp actual expected
 
 '
 
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 3d2d081..1fd3fb7 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -37,17 +37,17 @@ test_expect_success setup '
 
 test_expect_success 'git diff --raw HEAD' '
 	git diff --raw --abbrev=40 HEAD >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'git diff-index --raw HEAD' '
 	git diff-index --raw HEAD >actual.index &&
-	diff -u expect actual.index
+	test_cmp expect actual.index
 '
 
 test_expect_success 'git diff-files --raw' '
 	git diff-files --raw >actual.files &&
-	diff -u expect actual.files
+	test_cmp expect actual.files
 '
 
 test_done
diff --git a/t/t4105-apply-fuzz.sh b/t/t4105-apply-fuzz.sh
index 0e8d25f..3266e39 100755
--- a/t/t4105-apply-fuzz.sh
+++ b/t/t4105-apply-fuzz.sh
@@ -9,7 +9,7 @@ dotest () {
 	test_expect_success "$name" "
 		git checkout-index -f -q -u file &&
 		git apply $* &&
-		diff -u expect file
+		test_cmp expect file
 	"
 }
 
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
index d6f15be..3b471b6 100755
--- a/t/t4125-apply-ws-fuzz.sh
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -56,7 +56,7 @@ test_expect_success nofix '
 	git apply --whitespace=nowarn patch-1 &&
 
 	# The result should obviously match.
-	diff -u file-1 file
+	test_cmp file-1 file
 '
 
 test_expect_success 'withfix (forward)' '
@@ -70,7 +70,7 @@ test_expect_success 'withfix (forward)' '
 	git apply --whitespace=fix patch-0 &&
 	git apply --whitespace=fix patch-1 &&
 
-	diff -u file-fixed file
+	test_cmp file-fixed file
 '
 
 test_expect_success 'withfix (backward)' '
@@ -91,12 +91,12 @@ test_expect_success 'withfix (backward)' '
 
 	sed -e /h/d file-fixed >fixed-head &&
 	sed -e /h/d file >file-head &&
-	diff -u fixed-head file-head &&
+	test_cmp fixed-head file-head &&
 
 	sed -n -e /h/p file-fixed >fixed-tail &&
 	sed -n -e /h/p file >file-tail &&
 
-	! diff -u fixed-tail file-tail
+	! test_cmp fixed-tail file-tail
 
 '
 
diff --git a/t/t4150-am-subdir.sh b/t/t4150-am-subdir.sh
index 929d2cb..52069b4 100755
--- a/t/t4150-am-subdir.sh
+++ b/t/t4150-am-subdir.sh
@@ -22,14 +22,14 @@ test_expect_success 'am regularly from stdin' '
 	git checkout initial &&
 	git am <patchfile &&
 	git diff master >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'am regularly from file' '
 	git checkout initial &&
 	git am patchfile &&
 	git diff master >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'am regularly from stdin in subdirectory' '
@@ -41,7 +41,7 @@ test_expect_success 'am regularly from stdin in subdirectory' '
 		git am <../patchfile
 	) &&
 	git diff master>actual &&
-	diff -u expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'am regularly from file in subdirectory' '
@@ -53,7 +53,7 @@ test_expect_success 'am regularly from file in subdirectory' '
 		git am ../patchfile
 	) &&
 	git diff master >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 '
 
 test_expect_success 'am regularly from file in subdirectory with full path' '
@@ -66,7 +66,7 @@ test_expect_success 'am regularly from file in subdirectory with full path' '
 		git am "$P/patchfile"
 	) &&
 	git diff master >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 6d12efb..91ea696 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -45,6 +45,6 @@ A U Thor (5):
 
 EOF
 
-test_expect_success 'shortlog wrapping' 'diff -u expect out'
+test_expect_success 'shortlog wrapping' 'test_cmp expect out'
 
 test_done
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2822a65..ecfc999 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -24,7 +24,7 @@ setup_repository () {
 tokens_match () {
 	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
 	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 }
 
 check_remote_track () {
@@ -73,7 +73,7 @@ test_expect_success 'add another remote' '
 	sed -e "/^refs\/remotes\/origin\//d" \
 	    -e "/^refs\/remotes\/second\//d" >actual &&
 	>expect &&
-	diff -u expect actual
+	test_cmp expect actual
 )
 '
 
@@ -93,7 +93,7 @@ test_expect_success 'remove remote' '
 	git for-each-ref "--format=%(refname)" refs/remotes |
 	sed -e "/^refs\/remotes\/origin\//d" >actual &&
 	>expect &&
-	diff -u expect actual
+	test_cmp expect actual
 )
 '
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9b948c1..6946557 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -249,7 +249,7 @@ test_expect_success 'bundle should record HEAD correctly' '
 	do
 		echo "$(git rev-parse --verify $h) $h"
 	done >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6ec5f7c..c0dc949 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -24,28 +24,28 @@ test_expect_success setup '
 test_expect_success 'ls-remote --tags .git' '
 
 	git ls-remote --tags .git >actual &&
-	diff -u expected.tag actual
+	test_cmp expected.tag actual
 
 '
 
 test_expect_success 'ls-remote .git' '
 
 	git ls-remote .git >actual &&
-	diff -u expected.all actual
+	test_cmp expected.all actual
 
 '
 
 test_expect_success 'ls-remote --tags self' '
 
 	git ls-remote --tags self >actual &&
-	diff -u expected.tag actual
+	test_cmp expected.tag actual
 
 '
 
 test_expect_success 'ls-remote self' '
 
 	git ls-remote self >actual &&
-	diff -u expected.all actual
+	test_cmp expected.all actual
 
 '
 
diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index 80d7198..5dabf1c 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -45,7 +45,7 @@ test_expect_success 'further setup' '
 test_expect_success 'path optimization 2' '
 	( echo "$side"; echo "$initial" ) >expected &&
 	git rev-list HEAD -- a >actual &&
-	diff -u expected actual
+	test_cmp expected actual
 '
 
 test_done
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index be3d238..f248a32 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -31,7 +31,7 @@ test_expect_failure 'one is ancestor of others and should not be shown' '
 
 	git rev-list one --not four >result &&
 	>expect &&
-	diff -u expect result
+	test_cmp expect result
 
 '
 
diff --git a/t/t6027-merge-binary.sh b/t/t6027-merge-binary.sh
index a7358f7..92ca1f0 100755
--- a/t/t6027-merge-binary.sh
+++ b/t/t6027-merge-binary.sh
@@ -45,7 +45,7 @@ test_expect_success resolve '
 		false
 	else
 		git ls-files -s >current
-		diff -u current expect
+		test_cmp current expect
 	fi
 '
 
@@ -60,7 +60,7 @@ test_expect_success recursive '
 		false
 	else
 		git ls-files -s >current
-		diff -u current expect
+		test_cmp current expect
 	fi
 '
 
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 35d66e8..43f5459 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -25,7 +25,7 @@ test_expect_success 'subtree available and works like recursive' '
 
 	git merge -s subtree side &&
 	for i in mundo $s world; do echo $i; done >expect &&
-	diff -u expect hello
+	test_cmp expect hello
 
 '
 
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index bc8ab6a..02cf7c5 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -18,7 +18,7 @@ test_expect_success 'git add (absolute)' '
 	git add "$D/a/b/c/d" &&
 	git ls-files >current &&
 	echo a/b/c/d >expect &&
-	diff -u expect current
+	test_cmp expect current
 
 '
 
@@ -32,7 +32,7 @@ test_expect_success 'git add (funny relative)' '
 	) &&
 	git ls-files >current &&
 	echo a/e/f >expect &&
-	diff -u expect current
+	test_cmp expect current
 
 '
 
@@ -43,7 +43,7 @@ test_expect_success 'git rm (absolute)' '
 	git rm -f --cached "$D/a/b/c/d" &&
 	git ls-files >current &&
 	echo a/e/f >expect &&
-	diff -u expect current
+	test_cmp expect current
 
 '
 
@@ -57,7 +57,7 @@ test_expect_success 'git rm (funny relative)' '
 	) &&
 	git ls-files >current &&
 	echo a/b/c/d >expect &&
-	diff -u expect current
+	test_cmp expect current
 
 '
 
@@ -67,7 +67,7 @@ test_expect_success 'git ls-files (absolute)' '
 	git add a &&
 	git ls-files "$D/a/e/../b" >current &&
 	echo a/b/c/d >expect &&
-	diff -u expect current
+	test_cmp expect current
 
 '
 
@@ -80,7 +80,7 @@ test_expect_success 'git ls-files (relative #1)' '
 		git ls-files "../b/c"
 	)  >current &&
 	echo c/d >expect &&
-	diff -u expect current
+	test_cmp expect current
 
 '
 
@@ -93,7 +93,7 @@ test_expect_success 'git ls-files (relative #2)' '
 		git ls-files --full-name "../e/f"
 	)  >current &&
 	echo a/e/f >expect &&
-	diff -u expect current
+	test_cmp expect current
 
 '
 
@@ -126,13 +126,13 @@ test_expect_success 'log using absolute path names' '
 
 	git log a/b/c/d >f1.txt &&
 	git log "$(pwd)/a/b/c/d" >f2.txt &&
-	diff -u f1.txt f2.txt
+	test_cmp f1.txt f2.txt
 '
 
 test_expect_success 'blame using absolute path names' '
 	git blame a/b/c/d >f1.txt &&
 	git blame "$(pwd)/a/b/c/d" >f2.txt &&
-	diff -u f1.txt f2.txt
+	test_cmp f1.txt f2.txt
 '
 
 test_expect_success 'setup deeper work tree' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 63915cd..3111baa 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -83,13 +83,13 @@ test_expect_success "checkout with unrelated dirty tree without -m" '
 	fill 0 1 2 3 4 5 6 7 8 >same &&
 	cp same kept
 	git checkout side >messages &&
-	diff -u same kept
+	test_cmp same kept
 	(cat > messages.expect <<EOF
 M	same
 EOF
 ) &&
 	touch messages.expect &&
-	diff -u messages.expect messages
+	test_cmp messages.expect messages
 '
 
 test_expect_success "checkout -m with dirty tree" '
@@ -106,19 +106,19 @@ test_expect_success "checkout -m with dirty tree" '
 M	one
 EOF
 ) &&
-	diff -u expect.messages messages &&
+	test_cmp expect.messages messages &&
 
 	fill "M	one" "A	three" "D	two" >expect.master &&
 	git diff --name-status master >current.master &&
-	diff -u expect.master current.master &&
+	test_cmp expect.master current.master &&
 
 	fill "M	one" >expect.side &&
 	git diff --name-status side >current.side &&
-	diff -u expect.side current.side &&
+	test_cmp expect.side current.side &&
 
 	: >expect.index &&
 	git diff --cached >current.index &&
-	diff -u expect.index current.index
+	test_cmp expect.index current.index
 '
 
 test_expect_success "checkout -m with dirty tree, renamed" '
@@ -136,7 +136,7 @@ test_expect_success "checkout -m with dirty tree, renamed" '
 
 	git checkout -m renamer &&
 	fill 1 3 4 5 7 8 >expect &&
-	diff -u expect uno &&
+	test_cmp expect uno &&
 	! test -f one &&
 	git diff --cached >current &&
 	! test -s current
@@ -161,7 +161,7 @@ test_expect_success 'checkout -m with merge conflict' '
 	git diff master:one :3:uno |
 	sed -e "1,/^@@/d" -e "/^ /d" -e "s/^-/d/" -e "s/^+/a/" >current &&
 	fill d2 aT d7 aS >expect &&
-	diff -u current expect &&
+	test_cmp current expect &&
 	git diff --cached two >current &&
 	! test -s current
 '
@@ -178,7 +178,7 @@ If you want to create a new branch from this checkout, you may do so
 HEAD is now at 7329388... Initial A one, A two
 EOF
 ) &&
-	diff -u messages.expect messages &&
+	test_cmp messages.expect messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 361886c..c0288f3 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -203,7 +203,7 @@ test_expect_success 'sign off (1)' '
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
-	diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -223,7 +223,7 @@ $existing" &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
-	diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -240,7 +240,7 @@ test_expect_success 'multiple -m' '
 		echo
 		echo three
 	) >expected &&
-	diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -301,12 +301,12 @@ test_expect_success 'same tree (merge and amend merge)' '
 	git merge -s ours side -m "empty ok" &&
 	git diff HEAD^ HEAD >actual &&
 	: >expected &&
-	diff -u expected actual &&
+	test_cmp expected actual &&
 
 	git commit --amend -m "empty really ok" &&
 	git diff HEAD^ HEAD >actual &&
 	: >expected &&
-	diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -323,7 +323,7 @@ test_expect_success 'amend using the message from another commit' '
 	git commit --allow-empty --amend -C "$old" &&
 	git show --pretty="format:%ad %s" "$old" >expected &&
 	git show --pretty="format:%ad %s" HEAD >actual &&
-	diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -341,7 +341,7 @@ test_expect_success 'amend using the message from a commit named with tag' '
 	git commit --allow-empty --amend -C tagged-old &&
 	git show --pretty="format:%ad %s" "$old" >expected &&
 	git show --pretty="format:%ad %s" HEAD >actual &&
-	diff -u expected actual
+	test_cmp expected actual
 
 '
 
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index b780fdd..284c941 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -85,7 +85,7 @@ test_expect_success 'verbose' '
 	git add negative &&
 	git status -v | sed -ne "/^diff --git /p" >actual &&
 	echo "diff --git a/negative b/negative" >expect &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -95,7 +95,7 @@ test_expect_success 'cleanup commit messages (verbatim,-t)' '
 	{ echo;echo "# text";echo; } >expect &&
 	git commit --cleanup=verbatim -t expect -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -104,7 +104,7 @@ test_expect_success 'cleanup commit messages (verbatim,-F)' '
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -113,7 +113,7 @@ test_expect_success 'cleanup commit messages (verbatim,-m)' '
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$(cat expect)" -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -124,7 +124,7 @@ test_expect_success 'cleanup commit messages (whitespace,-F)' '
 	echo "# text" >expect &&
 	git commit --cleanup=whitespace -F text -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -135,7 +135,7 @@ test_expect_success 'cleanup commit messages (strip,-F)' '
 	echo sample >expect &&
 	git commit --cleanup=strip -F text -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
@@ -150,7 +150,7 @@ test_expect_success 'cleanup commit messages (strip,-F,-e)' '
 	{ echo;echo sample;echo; } >text &&
 	git commit -e -F text -a &&
 	head -n 4 .git/COMMIT_EDITMSG >actual &&
-	diff -u expect actual
+	test_cmp expect actual
 
 '
 
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index 70b802b..cd08516 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -146,7 +146,7 @@ cat <<EOF >expect
 EOF
 test_expect_success 'status of partial commit excluding new file in index' '
 	git status dir1/modified >output &&
-	diff -u expect output
+	test_cmp expect output
 '
 
 test_done
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 219411f..56869ac 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -108,7 +108,7 @@ create_merge_msgs() {
 }
 
 verify_diff() {
-	if ! diff -u "$1" "$2"
+	if ! test_cmp "$1" "$2"
 	then
 		echo "$3"
 		false
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index db51b3a..966bb0a 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -112,7 +112,7 @@ test_expect_success 'blame wholesale copy' '
 		echo mouse-Second
 		echo mouse-Third
 	} >expected &&
-	diff -u expected current
+	test_cmp expected current
 
 '
 
@@ -125,7 +125,7 @@ test_expect_success 'blame wholesale copy and more' '
 		echo cow-Fifth
 		echo mouse-Third
 	} >expected &&
-	diff -u expected current
+	test_cmp expected current
 
 '
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index cbbfa9c..c0973b4 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -81,7 +81,7 @@ test_expect_success 'Show all headers' '
 		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
 		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
 		>actual-show-all-headers &&
-	diff -u expected-show-all-headers actual-show-all-headers
+	test_cmp expected-show-all-headers actual-show-all-headers
 '
 
 z8=zzzzzzzz
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 902ed41..e1e8bdf 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -55,74 +55,74 @@ printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
 
 test_expect_success 'test ascending revision range' "
 	git reset --hard trunk &&
-	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r1-r2-r4 -
+	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2-r4 -
 	"
 
 printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
 
 test_expect_success 'test descending revision range' "
 	git reset --hard trunk &&
-	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4-r2-r1 -
+	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4-r2-r1 -
 	"
 
 printf 'r1 \nr2 \n' > expected-range-r1-r2
 
 test_expect_success 'test ascending revision range with unreachable revision' "
 	git reset --hard trunk &&
-	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r1-r2 -
+	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r1-r2 -
 	"
 
 printf 'r2 \nr1 \n' > expected-range-r2-r1
 
 test_expect_success 'test descending revision range with unreachable revision' "
 	git reset --hard trunk &&
-	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2-r1 -
+	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2-r1 -
 	"
 
 printf 'r2 \n' > expected-range-r2
 
 test_expect_success 'test ascending revision range with unreachable upper boundary revision and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2 -
+	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
 	"
 
 test_expect_success 'test descending revision range with unreachable upper boundary revision and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2 -
+	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r2 -
 	"
 
 printf 'r4 \n' > expected-range-r4
 
 test_expect_success 'test ascending revision range with unreachable lower boundary revision and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 test_expect_success 'test descending revision range with unreachable lower boundary revision and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 printf -- '------------------------------------------------------------------------\n' > expected-separator
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and no commits' "
 	git reset --hard trunk &&
-	git svn log -r 5:6 | diff -u expected-separator -
+	git svn log -r 5:6 | test_cmp expected-separator -
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and no commits' "
 	git reset --hard trunk &&
-	git svn log -r 6:5 | diff -u expected-separator -
+	git svn log -r 6:5 | test_cmp expected-separator -
 	"
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_cmp expected-range-r4 -
 	"
 
 test_done
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 58c59ed..42b144b 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -37,7 +37,7 @@ check_entries () {
 	else
 		printf '%s\n' "$2" | tr '|' '\012' >expected
 	fi
-	diff -u expected actual
+	test_cmp expected actual
 }
 
 test_expect_success \
@@ -257,8 +257,8 @@ test_expect_success '-w option should work with relative GIT_DIR' '
       (cd "$GIT_DIR" &&
       GIT_DIR=. git cvsexportcommit -w "$CVSWORK" -c $id &&
       check_entries "$CVSWORK/W" "file1.txt/1.1/|file2.txt/1.1/" &&
-      diff -u "$CVSWORK/W/file1.txt" ../W/file1.txt &&
-      diff -u "$CVSWORK/W/file2.txt" ../W/file2.txt
+      test_cmp "$CVSWORK/W/file1.txt" ../W/file1.txt &&
+      test_cmp "$CVSWORK/W/file2.txt" ../W/file2.txt
       )
 '
 
@@ -279,9 +279,9 @@ test_expect_success 'check files before directories' '
 	git cvsexportcommit -w "$CVSWORK" -c $id &&
 	check_entries "$CVSWORK/E" "DS/1.1/|newfile5.txt/1.1/" &&
 	check_entries "$CVSWORK" "DS/1.1/|release-notes/1.2/" &&
-	diff -u "$CVSWORK/DS" DS &&
-	diff -u "$CVSWORK/E/DS" E/DS &&
-	diff -u "$CVSWORK/release-notes" release-notes
+	test_cmp "$CVSWORK/DS" DS &&
+	test_cmp "$CVSWORK/E/DS" E/DS &&
+	test_cmp "$CVSWORK/release-notes" release-notes
 
 '
 
@@ -293,7 +293,7 @@ test_expect_success 'commit a file with leading spaces in the name' '
 	id=$(git rev-parse HEAD) &&
 	git cvsexportcommit -w "$CVSWORK" -c $id &&
 	check_entries "$CVSWORK" " space/1.1/|DS/1.1/|release-notes/1.2/" &&
-	diff -u "$CVSWORK/ space" " space"
+	test_cmp "$CVSWORK/ space" " space"
 
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6aea0ea..268b26c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -42,6 +42,7 @@ export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
+GIT_TEST_CMP=${GIT_TEST_CMP:-diff -u}
 
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
@@ -302,6 +303,23 @@ test_must_fail () {
 	test $? -gt 0 -a $? -le 128
 }
 
+# test_cmp is a helper function to compare actual and expected output.
+# You can use it like:
+#
+#	test_expect_success 'foo works' '
+#		echo expected >expected &&
+#		foo >actual &&
+#		test_cmp expected actual
+#	'
+#
+# This could be written as either "cmp" or "diff -u", but:
+# - cmp's output is not nearly as easy to read as diff -u
+# - not all diff versions understand "-u"
+
+test_cmp() {
+	$GIT_TEST_CMP "$@"
+}
+
 # Most tests can use the created repository, but some may need to create more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
-- 
1.5.4.4.543.g30fdd.dirty
