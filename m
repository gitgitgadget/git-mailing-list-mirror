From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCHv2] stash: Don't fail if work dir contains file named 'HEAD'
Date: Fri, 30 Dec 2011 16:14:01 -0800
Message-ID: <A244F415-73A1-4A77-BC4A-AC7F85946F02@JonathonMah.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 31 01:14:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rgmal-0000nz-8i
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 01:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab1LaAOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 19:14:11 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:18358 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120Ab1LaAOK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 19:14:10 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApEBAHBS/k5M5FL2/2dsb2JhbAAMN7AMOgWBUYgCtSiLLGMEiDeaS4RV
Received: from adsl-76-228-82-246.dsl.pltn13.sbcglobal.net (HELO [10.0.90.86]) ([76.228.82.246])
  by ipmail06.adl6.internode.on.net with ESMTP; 31 Dec 2011 10:44:05 +1030
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187811>

When performing a plain "git stash" (without --patch), git-diff would fail
with "fatal: ambiguous argument 'HEAD': both revision and filename". The
output was piped into git-update-index, masking the failed exit status.
The output is now sent to a temporary file (which is cleaned up by
existing code), and the exit status is checked. The "HEAD" arg to the
git-diff invocation has been disambiguated too, of course.

In patch mode, "git stash -p" would fail harmlessly, leaving the working
dir untouched. Interactive adding is fine, but the resulting tree was
diffed with an ambiguous 'HEAD' argument.

Use >foo (no space) when redirecting output.

In t3904, checks and operations on each file are in the order they'll
appear when interactively staging.

In t3905, fix a bug in "stash save --include-untracked -q is quiet": The
redirected stdout file was considered untracked, and so was removed from
the working directory. Use test path helper functions where appropriate.

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
Acked-by: Thomas Rast <trast@student.ethz.ch>
---
Also contains several fixes / changes for tests. Let me know if these
would better belong separately.

 git-stash.sh                       |    7 +++--
 t/t3903-stash.sh                   |   24 ++++++++++++++++++
 t/t3904-stash-patch.sh             |   47 ++++++++++++++++++++++-------------
 t/t3905-stash-include-untracked.sh |   33 +++++++++++++++++-------
 4 files changed, 80 insertions(+), 31 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c766692..fe4ab28 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -115,7 +115,8 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
+			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
 		) ) ||
@@ -134,7 +135,7 @@ create_stash () {
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
 		die "$(gettext "Cannot save the current worktree state")"
 
-		git diff-tree -p HEAD $w_tree > "$TMP-patch" &&
+		git diff-tree -p HEAD $w_tree -- >"$TMP-patch" &&
 		test -s "$TMP-patch" ||
 		die "$(gettext "No changes selected")"
 
@@ -491,7 +492,7 @@ drop_stash () {
 		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
 
 	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
+	git rev-parse --verify "$ref_stash@{0}" >/dev/null 2>&1 || clear_stash
 }
 
 apply_to_branch () {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index fcdb182..dbe2ac1 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -601,4 +601,28 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
 	test_cmp expect actual
 '
 
+cat > expect << EOF
+diff --git a/HEAD b/HEAD
+new file mode 100644
+index 0000000..fe0cbee
+--- /dev/null
++++ b/HEAD
+@@ -0,0 +1 @@
++file-not-a-ref
+EOF
+
+test_expect_success 'stash where working directory contains "HEAD" file' '
+	git stash clear &&
+	git reset --hard &&
+	echo file-not-a-ref > HEAD &&
+	git add HEAD &&
+	test_tick &&
+	git stash &&
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD &&
+	test "$(git rev-parse stash^)" = "$(git rev-parse HEAD)" &&
+	git diff stash^..stash > output &&
+	test_cmp output expect
+'
+
 test_done
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 781fd71..70655c1 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -7,7 +7,8 @@ test_expect_success PERL 'setup' '
 	mkdir dir &&
 	echo parent > dir/foo &&
 	echo dummy > bar &&
-	git add bar dir/foo &&
+	echo committed > HEAD &&
+	git add bar dir/foo HEAD &&
 	git commit -m initial &&
 	test_tick &&
 	test_commit second dir/foo head &&
@@ -17,47 +18,57 @@ test_expect_success PERL 'setup' '
 	save_head
 '
 
-# note: bar sorts before dir, so the first 'n' is always to skip 'bar'
+# note: order of files with unstaged changes: HEAD bar dir/foo
 
 test_expect_success PERL 'saying "n" does nothing' '
+	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state dir/foo work index &&
-	(echo n; echo n) | test_must_fail git stash save -p &&
-	verify_state dir/foo work index &&
-	verify_saved_state bar
+	(echo n; echo n; echo n) | test_must_fail git stash save -p &&
+	verify_state HEAD HEADfile_work HEADfile_index &&
+	verify_saved_state bar &&
+	verify_state dir/foo work index
 '
 
 test_expect_success PERL 'git stash -p' '
-	(echo n; echo y) | git stash save -p &&
-	verify_state dir/foo head index &&
+	(echo y; echo n; echo y) | git stash save -p &&
+	verify_state HEAD committed HEADfile_index &&
 	verify_saved_state bar &&
+	verify_state dir/foo head index &&
 	git reset --hard &&
 	git stash apply &&
-	verify_state dir/foo work head &&
-	verify_state bar dummy dummy
+	verify_state HEAD HEADfile_work committed &&
+	verify_state bar dummy dummy &&
+	verify_state dir/foo work head
 '
 
 test_expect_success PERL 'git stash -p --no-keep-index' '
-	set_state dir/foo work index &&
+	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
-	(echo n; echo y) | git stash save -p --no-keep-index &&
-	verify_state dir/foo head head &&
+	set_state dir/foo work index &&
+	(echo y; echo n; echo y) | git stash save -p --no-keep-index &&
+	verify_state HEAD committed committed &&
 	verify_state bar bar_work dummy &&
+	verify_state dir/foo head head &&
 	git reset --hard &&
 	git stash apply --index &&
-	verify_state dir/foo work index &&
-	verify_state bar dummy bar_index
+	verify_state HEAD HEADfile_work HEADfile_index &&
+	verify_state bar dummy bar_index &&
+	verify_state dir/foo work index
 '
 
 test_expect_success PERL 'git stash --no-keep-index -p' '
-	set_state dir/foo work index &&
+	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
-	(echo n; echo y) | git stash save --no-keep-index -p &&
+	set_state dir/foo work index &&
+	(echo y; echo n; echo y) | git stash save --no-keep-index -p &&
+	verify_state HEAD committed committed &&
 	verify_state dir/foo head head &&
 	verify_state bar bar_work dummy &&
 	git reset --hard &&
 	git stash apply --index &&
-	verify_state dir/foo work index &&
-	verify_state bar dummy bar_index
+	verify_state HEAD HEADfile_work HEADfile_index &&
+	verify_state bar dummy bar_index &&
+	verify_state dir/foo work index
 '
 
 test_expect_success PERL 'none of this moved HEAD' '
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index ef44fb2..a5e7e6b 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -17,6 +17,7 @@ test_expect_success 'stash save --include-untracked some dirty working directory
 	echo 3 > file &&
 	test_tick &&
 	echo 1 > file2 &&
+	echo 1 > HEAD &&
 	mkdir untracked &&
 	echo untracked >untracked/untracked &&
 	git stash --include-untracked &&
@@ -35,6 +36,13 @@ test_expect_success 'stash save --include-untracked cleaned the untracked files'
 '
 
 cat > expect.diff <<EOF
+diff --git a/HEAD b/HEAD
+new file mode 100644
+index 0000000..d00491f
+--- /dev/null
++++ b/HEAD
+@@ -0,0 +1 @@
++1
 diff --git a/file2 b/file2
 new file mode 100644
 index 0000000..d00491f
@@ -51,14 +59,16 @@ index 0000000..5a72eb2
 +untracked
 EOF
 cat > expect.lstree <<EOF
+HEAD
 file2
 untracked
 EOF
 
 test_expect_success 'stash save --include-untracked stashed the untracked files' '
-	test "!" -f file2 &&
-	test ! -e untracked &&
-	git diff HEAD stash^3 -- file2 untracked >actual &&
+	test_path_is_missing file2 &&
+	test_path_is_missing untracked &&
+	test_path_is_missing HEAD &&
+	git diff HEAD stash^3 -- HEAD file2 untracked >actual &&
 	test_cmp expect.diff actual &&
 	git ls-tree --name-only stash^3: >actual &&
 	test_cmp expect.lstree actual
@@ -75,6 +85,7 @@ git clean --force --quiet
 
 cat > expect <<EOF
  M file
+?? HEAD
 ?? actual
 ?? expect
 ?? file2
@@ -116,10 +127,12 @@ test_expect_success 'stash save --include-untracked dirty index got stashed' '
 
 git reset > /dev/null
 
+# Must direct output somewhere where it won't be considered an untracked file
 test_expect_success 'stash save --include-untracked -q is quiet' '
 	echo 1 > file5 &&
-	git stash save --include-untracked --quiet > output.out 2>&1 &&
-	test ! -s output.out
+	git stash save --include-untracked --quiet > .git/stash-output.out 2>&1 &&
+	test_line_count = 0 .git/stash-output.out &&
+	rm -f .git/stash-output.out
 '
 
 test_expect_success 'stash save --include-untracked removed files' '
@@ -133,7 +146,7 @@ rm -f expect
 
 test_expect_success 'stash save --include-untracked removed files got stashed' '
 	git stash pop &&
-	test ! -f file
+	test_path_is_missing file
 '
 
 cat > .gitignore <<EOF
@@ -155,14 +168,14 @@ test_expect_success 'stash save --include-untracked respects .gitignore' '
 test_expect_success 'stash save -u can stash with only untracked files different' '
 	echo 4 > file4 &&
 	git stash -u &&
-	test "!" -f file4
+	test_path_is_missing file4
 '
 
 test_expect_success 'stash save --all does not respect .gitignore' '
 	git stash -a &&
-	test "!" -f ignored &&
-	test "!" -e ignored.d &&
-	test "!" -f .gitignore
+	test_path_is_missing ignored &&
+	test_path_is_missing ignored.d &&
+	test_path_is_missing .gitignore
 '
 
 test_expect_success 'stash save --all is stash poppable' '
-- 
1.7.8



Jonathon Mah
me@JonathonMah.com
