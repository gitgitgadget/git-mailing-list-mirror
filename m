From: =?UTF-8?q?Christof=20Kr=C3=BCger?= <git@christof-krueger.de>
Subject: [PATCH] Modify git stash tests to show failure with sparse checkouts
Date: Thu, 30 Jun 2011 21:06:38 +0200
Message-ID: <1309460798-17526-1-git-send-email-git@christof-krueger.de>
Cc: =?UTF-8?q?Christof=20Kr=C3=BCger?= <git@christof-krueger.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 21:07:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcMZn-0003vf-4A
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 21:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab1F3TGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 15:06:54 -0400
Received: from vserver.localhost.li ([85.214.46.152]:50301 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1F3TGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 15:06:53 -0400
Received: from p5794caec.dip.t-dialin.net ([87.148.202.236]:52401 helo=oxylap)
	by mail.localhost.li with esmtpa (Exim 4.69)
	(envelope-from <oxygene@localhost.li>)
	id 1QcMZd-0007nN-7i; Thu, 30 Jun 2011 21:06:50 +0200
Received: by oxylap (Postfix, from userid 1000)
	id B8197DC14E7; Thu, 30 Jun 2011 21:06:48 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.rc3.2.g94021
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176502>

Restoring the index from a stash doesn't respect sparse checkouts.  Tests 7
and 16 fail.
---

I'm working on a large project using sparse-checkout. Recently, I've
used stash apply --index for the first time and noticed that git status
was showing me all the files that should be hidden as deleted.

Unfortunately, I don't have the time or insight to fix the problem
myself, so this patch only contains the modification making the test
fail.

Thanks,
  Chris

 t/t3903-stash.sh |  146 +++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 101 insertions(+), 45 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7197aae..29d2090 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -7,18 +7,31 @@ test_description='Test git stash'
 
 . ./test-lib.sh
 
+check_index_for_unwanted () {
+	test -z $(git diff-index HEAD --name-only|grep unwanted)
+}
+
 test_expect_success 'stash some dirty working directory' '
+	echo x > unwanted &&
+	git add unwanted &&
+	test_tick &&
+	git commit -m unwanted &&
 	echo 1 > file &&
 	git add file &&
 	test_tick &&
 	git commit -m initial &&
+	git config core.sparsecheckout true &&
+	echo "*" > .git/info/sparse-checkout &&
+	echo "!unwanted" >> .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
 	echo 2 > file &&
 	git add file &&
 	echo 3 > file &&
 	test_tick &&
 	git stash &&
 	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD
+	git diff-index --cached --quiet HEAD &&
+	check_index_for_unwanted
 '
 
 cat > expect << EOF
@@ -34,13 +47,15 @@ EOF
 test_expect_success 'parents of stash' '
 	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
 	git diff stash^2..stash > output &&
-	test_cmp output expect
+	test_cmp output expect &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'applying bogus stash does nothing' '
 	test_must_fail git stash apply stash@{1} &&
 	echo 1 >expect &&
-	test_cmp expect file
+	test_cmp expect file &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'apply does not need clean working directory' '
@@ -49,7 +64,8 @@ test_expect_success 'apply does not need clean working directory' '
 	echo 5 >other-file &&
 	git stash apply &&
 	echo 3 >expect &&
-	test_cmp expect file
+	test_cmp expect file &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'apply does not clobber working directory changes' '
@@ -57,7 +73,8 @@ test_expect_success 'apply does not clobber working directory changes' '
 	echo 4 >file &&
 	test_must_fail git stash apply &&
 	echo 4 >expect &&
-	test_cmp expect file
+	test_cmp expect file &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'apply stashed changes' '
@@ -69,7 +86,8 @@ test_expect_success 'apply stashed changes' '
 	git stash apply &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	test 1 = $(git show HEAD:file) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'apply stashed changes (including index)' '
@@ -81,7 +99,8 @@ test_expect_success 'apply stashed changes (including index)' '
 	git stash apply --index &&
 	test 3 = $(cat file) &&
 	test 2 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	test 1 = $(git show HEAD:file) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'unstashing in a subdirectory' '
@@ -90,7 +109,8 @@ test_expect_success 'unstashing in a subdirectory' '
 	(
 		cd subdir &&
 		git stash apply
-	)
+	) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'drop top stash' '
@@ -104,7 +124,8 @@ test_expect_success 'drop top stash' '
 	git stash apply &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	test 1 = $(git show HEAD:file) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'drop middle stash' '
@@ -124,7 +145,8 @@ test_expect_success 'drop middle stash' '
 	git stash apply &&
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
-	test 1 = $(git show HEAD:file)
+	test 1 = $(git show HEAD:file) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash pop' '
@@ -133,7 +155,8 @@ test_expect_success 'stash pop' '
 	test 3 = $(cat file) &&
 	test 1 = $(git show :file) &&
 	test 1 = $(git show HEAD:file) &&
-	test 0 = $(git stash list | wc -l)
+	test 0 = $(git stash list | wc -l) &&
+	check_index_for_unwanted
 '
 
 cat > expect << EOF
@@ -193,39 +216,45 @@ test_expect_success 'stash branch' '
 	git commit -m alternate\ second &&
 	git diff master..stashbranch > output &&
 	test_cmp output expect2 &&
-	test 0 = $(git stash list | wc -l)
+	test 0 = $(git stash list | wc -l) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'apply -q is quiet' '
 	echo foo > file &&
 	git stash &&
 	git stash apply -q > output.out 2>&1 &&
-	test ! -s output.out
+	test ! -s output.out &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'save -q is quiet' '
 	git stash save --quiet > output.out 2>&1 &&
-	test ! -s output.out
+	test ! -s output.out &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'pop -q is quiet' '
 	git stash pop -q > output.out 2>&1 &&
-	test ! -s output.out
+	test ! -s output.out &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'pop -q --index works and is quiet' '
 	echo foo > file &&
 	git add file &&
 	git stash save --quiet &&
-	git stash pop -q --index > output.out 2>&1 &&
+	git stash pop --index > output.out 2>&1 &&
 	test foo = "$(git show :file)" &&
-	test ! -s output.out
+	test ! -s output.out &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'drop -q is quiet' '
 	git stash &&
 	git stash drop -q > output.out 2>&1 &&
-	test ! -s output.out
+	test ! -s output.out &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash -k' '
@@ -233,7 +262,8 @@ test_expect_success 'stash -k' '
 	echo bar4 > file2 &&
 	git add file2 &&
 	git stash -k &&
-	test bar,bar4 = $(cat file),$(cat file2)
+	test bar,bar4 = $(cat file),$(cat file2) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash --no-keep-index' '
@@ -241,7 +271,8 @@ test_expect_success 'stash --no-keep-index' '
 	echo bar44 > file2 &&
 	git add file2 &&
 	git stash --no-keep-index &&
-	test bar,bar2 = $(cat file),$(cat file2)
+	test bar,bar2 = $(cat file),$(cat file2) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash --invalid-option' '
@@ -252,7 +283,8 @@ test_expect_success 'stash --invalid-option' '
 	test_must_fail git stash save --invalid-option &&
 	test bar5,bar6 = $(cat file),$(cat file2) &&
 	git stash -- -message-starting-with-dash &&
-	test bar,bar2 = $(cat file),$(cat file2)
+	test bar,bar2 = $(cat file),$(cat file2) &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash an added file' '
@@ -262,7 +294,8 @@ test_expect_success 'stash an added file' '
 	git stash save "added file" &&
 	! test -r file3 &&
 	git stash apply &&
-	test new = "$(cat file3)"
+	test new = "$(cat file3)" &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash rm then recreate' '
@@ -272,7 +305,8 @@ test_expect_success 'stash rm then recreate' '
 	git stash save "rm then recreate" &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	test bar7 = "$(cat file)"
+	test bar7 = "$(cat file)" &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash rm and ignore' '
@@ -284,7 +318,8 @@ test_expect_success 'stash rm and ignore' '
 	test file = "$(cat .gitignore)" &&
 	git stash apply &&
 	! test -r file &&
-	test file = "$(cat .gitignore)"
+	test file = "$(cat .gitignore)" &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash rm and ignore (stage .gitignore)' '
@@ -297,7 +332,8 @@ test_expect_success 'stash rm and ignore (stage .gitignore)' '
 	! test -r .gitignore &&
 	git stash apply &&
 	! test -r file &&
-	test file = "$(cat .gitignore)"
+	test file = "$(cat .gitignore)" &&
+	check_index_for_unwanted
 '
 
 test_expect_success SYMLINKS 'stash file to symlink' '
@@ -308,7 +344,8 @@ test_expect_success SYMLINKS 'stash file to symlink' '
 	test -f file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac &&
+	check_index_for_unwanted
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
@@ -319,7 +356,8 @@ test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
 	test -f file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac &&
+	check_index_for_unwanted
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
@@ -331,7 +369,8 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
 	test -f file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac &&
+	check_index_for_unwanted
 '
 
 # This test creates a commit with a symlink used for the following tests
@@ -348,7 +387,8 @@ test_expect_success SYMLINKS 'stash symlink to file' '
 	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac &&
 	git stash apply &&
 	! test -h filelink &&
-	test bar = "$(cat file)"
+	test bar = "$(cat file)" &&
+	check_index_for_unwanted
 '
 
 test_expect_success SYMLINKS 'stash symlink to file (stage rm)' '
@@ -360,7 +400,8 @@ test_expect_success SYMLINKS 'stash symlink to file (stage rm)' '
 	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac &&
 	git stash apply &&
 	! test -h filelink &&
-	test bar = "$(cat file)"
+	test bar = "$(cat file)" &&
+	check_index_for_unwanted
 '
 
 test_expect_success SYMLINKS 'stash symlink to file (full stage)' '
@@ -373,7 +414,8 @@ test_expect_success SYMLINKS 'stash symlink to file (full stage)' '
 	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac &&
 	git stash apply &&
 	! test -h filelink &&
-	test bar = "$(cat file)"
+	test bar = "$(cat file)" &&
+	check_index_for_unwanted
 '
 
 test_expect_failure 'stash directory to file' '
@@ -389,7 +431,8 @@ test_expect_failure 'stash directory to file' '
 	test foo = "$(cat dir/file)" &&
 	test_must_fail git stash apply &&
 	test bar = "$(cat dir)" &&
-	git reset --soft HEAD^
+	git reset --soft HEAD^ &&
+	check_index_for_unwanted
 '
 
 test_expect_failure 'stash file to directory' '
@@ -402,7 +445,8 @@ test_expect_failure 'stash file to directory' '
 	test bar = "$(cat file)" &&
 	git stash apply &&
 	test -f file/file &&
-	test foo = "$(cat file/file)"
+	test foo = "$(cat file/file)" &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
@@ -414,7 +458,8 @@ test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
 	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
-	test $(git ls-files --modified | wc -l) -eq 1
+	test $(git ls-files --modified | wc -l) -eq 1 &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash branch - stashes on stack, stash-like argument' '
@@ -429,7 +474,8 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	git reset --hard &&
 	git stash branch stash-branch ${STASH_ID} &&
 	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
-	test $(git ls-files --modified | wc -l) -eq 1
+	test $(git ls-files --modified | wc -l) -eq 1 &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash show - stashes on stack, stash-like argument' '
@@ -447,7 +493,8 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	 1 files changed, 1 insertions(+), 0 deletions(-)
 	EOF
 	git stash show ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_cmp expected actual &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
@@ -470,7 +517,8 @@ test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
 	+bar
 	EOF
 	git stash show -p ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_cmp expected actual &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash show - no stashes on stack, stash-like argument' '
@@ -485,7 +533,8 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	 1 files changed, 1 insertions(+), 0 deletions(-)
 	EOF
 	git stash show ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_cmp expected actual &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
@@ -505,7 +554,8 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	+foo
 	EOF
 	git stash show -p ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_cmp expected actual &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
@@ -519,7 +569,8 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
 	test_must_fail git stash drop $(git rev-parse stash@{0}) &&
 	git stash pop &&
 	test bar = "$(cat file)" &&
-	git reset --hard HEAD
+	git reset --hard HEAD &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash pop - fail early if specified stash is not a stash reference' '
@@ -533,7 +584,8 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
 	test_must_fail git stash pop $(git rev-parse stash@{0}) &&
 	git stash pop &&
 	test bar = "$(cat file)" &&
-	git reset --hard HEAD
+	git reset --hard HEAD &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'ref with non-existent reflog' '
@@ -553,7 +605,8 @@ test_expect_success 'ref with non-existent reflog' '
 	test_must_fail git stash show does-not-exist@{0} &&
 	test_must_fail git stash branch tmp does-not-exist &&
 	test_must_fail git stash branch tmp does-not-exist@{0} &&
-	git stash drop
+	git stash drop &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
@@ -568,7 +621,8 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	test_must_fail git stash apply stash@{1} &&
 	test_must_fail git stash show stash@{1} &&
 	test_must_fail git stash branch tmp stash@{1} &&
-	git stash drop
+	git stash drop &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash branch should not drop the stash if the branch exists' '
@@ -579,7 +633,8 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	echo bar >file &&
 	git stash &&
 	test_must_fail git stash branch master stash@{0} &&
-	git rev-parse stash@{0} --
+	git rev-parse stash@{0} -- &&
+	check_index_for_unwanted
 '
 
 test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
@@ -598,7 +653,8 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
 		git stash apply
 	) |
 	sed -e 1,2d >actual && # drop "Saved..." and "HEAD is now..."
-	test_cmp expect actual
+	test_cmp expect actual &&
+	check_index_for_unwanted
 '
 
 test_done
-- 
1.7.6.rc3.2.g94021
