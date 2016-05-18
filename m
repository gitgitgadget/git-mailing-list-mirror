From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 17/21] tests: use test_i18n* functions to suppress false positives
Date: Wed, 18 May 2016 15:27:50 +0000
Message-ID: <1463585274-9027-18-git-send-email-vascomalmeida@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:31:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33RD-0001jN-A7
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbcERPaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:30:52 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:58884 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932506AbcERPas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:30:48 -0400
Received: (qmail 21454 invoked from network); 18 May 2016 15:30:41 -0000
Received: (qmail 30968 invoked from network); 18 May 2016 15:30:41 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:30:36 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294962>

The test functions test_i18ncmp and test_i18ngrep pretend success if run
under GETTEXT_POISON. By using those functions to test output which is
correctly marked as translatable, enables one to detect if the strings
newly marked for translation are from plumbing output. If they are
indeed from plumbing, the test would fail, and the string should be
unmarked, since it is not seen by users.

Thus, it is productive to not have false positives when running the test
under GETTEXT_POISON. This commit replaces normal test functions by
their i18n aware variants in use-cases know to be correctly marked for
translation, suppressing false positives.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t0008-ignores.sh                |  4 ++--
 t/t1300-repo-config.sh            |  8 ++++----
 t/t1307-config-blob.sh            |  2 +-
 t/t1308-config-set.sh             |  4 ++--
 t/t1400-update-ref.sh             |  2 +-
 t/t2010-checkout-ambiguous.sh     |  2 +-
 t/t2018-checkout-branch.sh        |  2 +-
 t/t3200-branch.sh                 |  6 +++---
 t/t3201-branch-contains.sh        |  2 +-
 t/t3320-notes-merge-worktrees.sh  |  2 +-
 t/t5505-remote.sh                 |  2 +-
 t/t5510-fetch.sh                  |  2 +-
 t/t5523-push-upstream.sh          |  4 ++--
 t/t5536-fetch-conflicts.sh        |  4 ++--
 t/t6301-for-each-ref-errors.sh    | 10 +++++-----
 t/t7063-status-untracked-cache.sh |  2 +-
 t/t7102-reset.sh                  |  4 ++--
 t/t7400-submodule-basic.sh        |  2 +-
 t/t7403-submodule-sync.sh         |  4 ++--
 t/t7406-submodule-update.sh       | 10 +++++-----
 t/t7508-status.sh                 |  4 ++--
 21 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 89544dd..43aa2bd 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -34,7 +34,7 @@ expect_from_stdin () {
 test_stderr () {
 	expected="$1"
 	expect_in stderr "$1" &&
-	test_cmp "$HOME/expected-stderr" "$HOME/stderr"
+	test_i18ncmp "$HOME/expected-stderr" "$HOME/stderr"
 }
 
 broken_c_unquote () {
@@ -47,7 +47,7 @@ broken_c_unquote_verbose () {
 
 stderr_contains () {
 	regexp="$1"
-	if grep "$regexp" "$HOME/stderr"
+	if test_i18ngrep "$regexp" "$HOME/stderr"
 	then
 		return 0
 	else
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index d934a24..923bfc5 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -886,7 +886,7 @@ test_expect_success !MINGW 'get --path copes with unset $HOME' '
 		git config --get --path path.normal >>result &&
 		git config --get --path path.trailingtilde >>result
 	) &&
-	grep "[Ff]ailed to expand.*~/" msg &&
+	test_i18ngrep "[Ff]ailed to expand.*~/" msg &&
 	test_cmp expect result
 '
 
@@ -1126,7 +1126,7 @@ test_expect_success 'barf on syntax error' '
 	key garbage
 	EOF
 	test_must_fail git config --get section.key >actual 2>error &&
-	grep " line 3 " error
+	test_i18ngrep " line 3 " error
 '
 
 test_expect_success 'barf on incomplete section header' '
@@ -1136,7 +1136,7 @@ test_expect_success 'barf on incomplete section header' '
 	key = value
 	EOF
 	test_must_fail git config --get section.key >actual 2>error &&
-	grep " line 2 " error
+	test_i18ngrep " line 2 " error
 '
 
 test_expect_success 'barf on incomplete string' '
@@ -1146,7 +1146,7 @@ test_expect_success 'barf on incomplete string' '
 	key = "value string
 	EOF
 	test_must_fail git config --get section.key >actual 2>error &&
-	grep " line 3 " error
+	test_i18ngrep " line 3 " error
 '
 
 test_expect_success 'urlmatch' '
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 3c6791e..4079fef 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -64,7 +64,7 @@ test_expect_success 'parse errors in blobs are properly attributed' '
 
 	# just grep for our token as the exact error message is likely to
 	# change or be internationalized
-	grep "HEAD:config" err
+	test_i18ngrep "HEAD:config" err
 '
 
 test_expect_success 'can parse blob ending with CR' '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 005d66d..cd62063 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -197,14 +197,14 @@ test_expect_success 'proper error on error in default config files' '
 	echo "[" >>.git/config &&
 	echo "fatal: bad config line 34 in file .git/config" >expect &&
 	test_expect_code 128 test-config get_value foo.bar 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_expect_success 'proper error on error in custom config files' '
 	echo "[" >>syntax-error &&
 	echo "fatal: bad config line 1 in file syntax-error" >expect &&
 	test_expect_code 128 test-config configset_get_value foo.bar syntax-error 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_expect_success 'check line errors for malformed values' '
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index af1b20d..75fa654 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -361,7 +361,7 @@ test_expect_success 'stdin test setup' '
 
 test_expect_success '-z fails without --stdin' '
 	test_must_fail git update-ref -z $m $m $m 2>err &&
-	grep "usage: git update-ref" err
+	test_i18ngrep "usage: git update-ref" err
 '
 
 test_expect_success 'stdin works with no input' '
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 87bdf9c..e76e84a 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -49,7 +49,7 @@ test_expect_success 'disambiguate checking out from a tree-ish' '
 
 test_expect_success 'accurate error message with more than one ref' '
 	test_must_fail git checkout HEAD master -- 2>actual &&
-	grep 2 actual &&
+	test_i18ngrep 2 actual &&
 	test_i18ngrep "one reference expected, 2 given" actual
 '
 
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 2741262..2131fb2 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -124,7 +124,7 @@ test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
 	git checkout branch2 &&
 	echo  >expect "fatal: A branch named '\''branch1'\'' already exists." &&
 	test_must_fail git checkout -b @{-1} 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f3e3b6c..ac9c764 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -550,7 +550,7 @@ If you wanted to make '"'master'"' track '"'origin/master'"', do this:
     git branch -d origin/master
     git branch --set-upstream-to origin/master
 EOF
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success '--set-upstream with two args only shows the deprecation message' '
@@ -559,7 +559,7 @@ test_expect_success '--set-upstream with two args only shows the deprecation mes
 	cat >expected <<EOF &&
 The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
 EOF
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success '--set-upstream with one arg only shows the deprecation message if the branch existed' '
@@ -568,7 +568,7 @@ test_expect_success '--set-upstream with one arg only shows the deprecation mess
 	cat >expected <<EOF &&
 The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
 EOF
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 912a663..7f3ec47 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -156,7 +156,7 @@ test_expect_success 'branch --merged with --verbose' '
 	* topic  2c939f4 [ahead 1] foo
 	  zzz    c77a0a9 second on master
 	EOF
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_done
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 1f71d58..522157b 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -52,7 +52,7 @@ test_expect_success 'merge z into y while mid-merge in another workdir fails' '
 		cd worktree &&
 		git config core.notesRef refs/notes/y &&
 		test_must_fail git notes merge z 2>err &&
-		grep "A notes merge into refs/notes/y is already in-progress at" err
+		test_i18ngrep "A notes merge into refs/notes/y is already in-progress at" err
 	) &&
 	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
 '
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index dd2e6ce..8198d8e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1182,7 +1182,7 @@ test_expect_success 'extra args: setup' '
 test_extra_arg () {
 	test_expect_success "extra args: $*" "
 		test_must_fail git remote $* bogus_extra_arg 2>actual &&
-		grep '^usage:' actual
+		test_i18ngrep '^usage:' actual
 	"
 }
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 454d896..88076da 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -644,7 +644,7 @@ test_expect_success 'fetch --prune prints the remotes url' '
 		git fetch --prune origin 2>&1 | head -n1 >../actual
 	) &&
 	echo "From ${D}/." >expect &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_expect_success 'branchname D/F conflict resolved by --prune' '
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 3683df1..4a7b98b 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -75,7 +75,7 @@ test_expect_success TTY 'progress messages go to tty' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push -u upstream master >out 2>err &&
-	grep "Writing objects" err
+	test_i18ngrep "Writing objects" err
 '
 
 test_expect_success 'progress messages do not go to non-tty' '
@@ -91,7 +91,7 @@ test_expect_success 'progress messages go to non-tty (forced)' '
 
 	# force progress messages to stderr, even though it is non-tty
 	git push -u --progress upstream master >out 2>err &&
-	grep "Writing objects" err
+	test_i18ngrep "Writing objects" err
 '
 
 test_expect_success TTY 'push -q suppresses progress' '
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 6c5d3a4..2e42cf3 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -22,8 +22,8 @@ verify_stderr () {
 	cat >expected &&
 	# We're not interested in the error
 	# "fatal: The remote end hung up unexpectedly":
-	grep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
-	test_cmp expected actual
+	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
+	test_i18ncmp expected actual
 }
 
 test_expect_success 'setup' '
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index cdb67a0..c734ce2 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -20,8 +20,8 @@ test_expect_success 'Broken refs are reported correctly' '
 	test_when_finished "rm -f .git/$r" &&
 	echo "warning: ignoring broken ref $r" >broken-err &&
 	git for-each-ref >out 2>err &&
-	test_cmp full-list out &&
-	test_cmp broken-err err
+	test_i18ncmp full-list out &&
+	test_i18ncmp broken-err err
 '
 
 test_expect_success 'NULL_SHA1 refs are reported correctly' '
@@ -31,10 +31,10 @@ test_expect_success 'NULL_SHA1 refs are reported correctly' '
 	echo "warning: ignoring broken ref $r" >zeros-err &&
 	git for-each-ref >out 2>err &&
 	test_cmp full-list out &&
-	test_cmp zeros-err err &&
+	test_i18ncmp zeros-err err &&
 	git for-each-ref --format="%(objectname) %(refname)" >brief-out 2>brief-err &&
 	test_cmp brief-list brief-out &&
-	test_cmp zeros-err brief-err
+	test_i18ncmp zeros-err brief-err
 '
 
 test_expect_success 'Missing objects are reported correctly' '
@@ -43,7 +43,7 @@ test_expect_success 'Missing objects are reported correctly' '
 	test_when_finished "rm -f .git/$r" &&
 	echo "fatal: missing object $MISSING for $r" >missing-err &&
 	test_must_fail git for-each-ref 2>err &&
-	test_cmp missing-err err &&
+	test_i18ncmp missing-err err &&
 	(
 		cat brief-list &&
 		echo "$MISSING $r"
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a971884..38b3890 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -643,7 +643,7 @@ test_expect_success 'test ident field is working' '
 	cp -R done dthree dtwo four three ../other_worktree &&
 	GIT_WORK_TREE=../other_worktree git status 2>../err &&
 	echo "warning: Untracked cache is disabled on this system or location." >../expect &&
-	test_cmp ../expect ../err
+	test_i18ncmp ../expect ../err
 '
 
 test_done
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..86f23be 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -66,14 +66,14 @@ test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
 	git reset --hard > .actual &&
 	echo HEAD is now at $hex $(commit_msg) > .expected &&
-	test_cmp .expected .actual
+	test_i18ncmp .expected .actual
 '
 
 test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding)' '
 	hex=$(git log -1 --format="%h") &&
 	git -c "i18n.logOutputEncoding=$test_encoding" reset --hard > .actual &&
 	echo HEAD is now at $hex $(commit_msg $test_encoding) > .expected &&
-	test_cmp .expected .actual
+	test_i18ncmp .expected .actual
 '
 
 >.diff_expect
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 3570f7b..b77cce8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -942,7 +942,7 @@ test_expect_success 'submodule deinit from subdirectory' '
 		cd sub &&
 		git submodule deinit ../init >../output
 	) &&
-	grep "\\.\\./init" output &&
+	test_i18ngrep "\\.\\./init" output &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -n "$(git config --get-regexp "submodule\.example2\.")" &&
 	test -f example2/.git &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 79bc135..b8690b1 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -157,7 +157,7 @@ test_expect_success '"git submodule sync" should update submodule URLs - subdire
 		cd sub &&
 		git submodule sync >../../output
 	) &&
-	grep "\\.\\./submodule" output &&
+	test_i18ngrep "\\.\\./submodule" output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
@@ -188,7 +188,7 @@ test_expect_success '"git submodule sync --recursive" should update all submodul
 		cd sub &&
 		git submodule sync --recursive >../../output
 	) &&
-	grep "\\.\\./submodule/sub-submodule" output &&
+	test_i18ngrep "\\.\\./submodule/sub-submodule" output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 5f27879..88e9750 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -136,8 +136,8 @@ test_expect_success 'submodule update --init --recursive from subdirectory' '
 	 cd tmp &&
 	 git submodule update --init --recursive ../super >../../actual 2>../../actual2
 	) &&
-	test_cmp expect actual &&
-	test_cmp expect2 actual2
+	test_i18ncmp expect actual &&
+	test_i18ncmp expect2 actual2
 '
 
 apos="'";
@@ -370,7 +370,7 @@ test_expect_success 'submodule update - command in .git/config catches failure'
 	(cd super &&
 	 test_must_fail git submodule update submodule 2>../actual
 	) &&
-	test_cmp actual expect
+	test_i18ncmp actual expect
 '
 
 cat << EOF >expect
@@ -388,7 +388,7 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 	 mkdir tmp && cd tmp &&
 	 test_must_fail git submodule update ../submodule 2>../../actual
 	) &&
-	test_cmp actual expect
+	test_i18ncmp actual expect
 '
 
 cat << EOF >expect
@@ -408,7 +408,7 @@ test_expect_success 'recursive submodule update - command in .git/config catches
 	 mkdir -p tmp && cd tmp &&
 	 test_must_fail git submodule update --recursive ../super 2>../../actual
 	) &&
-	test_cmp actual expect
+	test_i18ncmp actual expect
 '
 
 test_expect_success 'submodule init does not copy command into .git/config' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c3ed7cb..b3bdd16 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1377,7 +1377,7 @@ EOF
 	git config --add -f .gitmodules submodule.subname.ignore all &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
-	test_cmp expect output &&
+	test_i18ncmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1387,7 +1387,7 @@ test_expect_success '.git/config ignore=all suppresses unstaged submodule summar
 	git config --add submodule.subname.ignore all &&
 	git config --add submodule.subname.path sm &&
 	git status > output &&
-	test_cmp expect output &&
+	test_i18ncmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
-- 
2.7.3
