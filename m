From: Jonathon Mah <me@JonathonMah.com>
Subject: [PATCH] stash: Don't fail if work dir contains file named 'HEAD'
Date: Thu, 29 Dec 2011 12:47:44 -0800
Message-ID: <913BB2F9-3C51-44D0-BFEC-3A49A5EC9E15@JonathonMah.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 29 21:53:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgMyG-0000WH-Od
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 21:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab1L2Uw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 15:52:56 -0500
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:2262 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753729Ab1L2Uwx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 15:52:53 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Dec 2011 15:52:52 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar4bANXO/E5HynyrPGdsb2JhbAAMN4lWoy4BAQEBN4JlOgWBJC2IArVMiyxjBIg3nyA
Received: from c-71-202-124-171.hsd1.ca.comcast.net (HELO [192.168.120.10]) ([71.202.124.171])
  by ipmail04.adl6.internode.on.net with ESMTP; 30 Dec 2011 07:17:47 +1030
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187784>

When performing a plain "git stash" (without --patch), git-diff would fail
with "fatal: ambiguous argument 'HEAD': both revision and filename". The
output was piped into git-update-index, masking the failed exit status.
The output is now sent to a temporary file (which is cleaned up by
existing code), and the exit status is checked. The "HEAD" arg to the
git-diff invocation has been disambiguated too, of course.

In patch mode, "git stash -p" would fail harmlessly, leaving the working
dir untouched.

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
 git-stash.sh                       |    5 ++-
 t/t3903-stash.sh                   |   25 +++++++++++++++++++
 t/t3904-stash-patch.sh             |   47 ++++++++++++++++++++++-------------
 t/t3905-stash-include-untracked.sh |   13 +++++++++-
 4 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c766692..a46f32a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -115,7 +115,8 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
+			git diff --name-only -z HEAD -- > "$TMP-stagenames" &&
+			git update-index -z --add --remove --stdin < "$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
 		) ) ||
@@ -134,7 +135,7 @@ create_stash () {
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
 		die "$(gettext "Cannot save the current worktree state")"
 
-		git diff-tree -p HEAD $w_tree > "$TMP-patch" &&
+		git diff-tree -p HEAD $w_tree -- > "$TMP-patch" &&
 		test -s "$TMP-patch" ||
 		die "$(gettext "No changes selected")"
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index fcdb182..8f1d07a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -601,4 +601,29 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
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
+	git stash &&
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD &&
+	test_tick &&
+	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
+	git diff stash^..stash > output &&
+	test_cmp output expect &&
+	git stash drop
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
index ef44fb2..7f75622 100755
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
@@ -51,6 +59,7 @@ index 0000000..5a72eb2
 +untracked
 EOF
 cat > expect.lstree <<EOF
+HEAD
 file2
 untracked
 EOF
@@ -58,7 +67,8 @@ EOF
 test_expect_success 'stash save --include-untracked stashed the untracked files' '
 	test "!" -f file2 &&
 	test ! -e untracked &&
-	git diff HEAD stash^3 -- file2 untracked >actual &&
+	test "!" -f HEAD &&
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
-- 
1.7.8



Jonathon Mah
me@JonathonMah.com
