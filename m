From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Wed, 28 Jul 2010 15:29:44 +0200
Message-ID: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 15:32:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe6jq-0002TA-0z
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 15:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab0G1Nb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 09:31:56 -0400
Received: from imag.imag.fr ([129.88.30.1]:37031 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab0G1Nbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 09:31:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6SDTktC017819
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 15:29:46 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe6he-0003JL-3e; Wed, 28 Jul 2010 15:29:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe6he-00079b-2U; Wed, 28 Jul 2010 15:29:46 +0200
X-Mailer: git-send-email 1.7.2.21.ge9796
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 28 Jul 2010 15:29:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152084>

The typical usage pattern would be to run a test (or simply a compilation
command) at given points in history.

The shell command is ran, and the rebase is stopped when the command
fails, to give the user an opportunity to fix the problem before
continuing with "git rebase --continue".

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

The name of the command may be subject to discussions. I've chosen
"run", but maybe "shell" would be OK too. In both cases, it doesn't
allow the one-letter version since both "r" and "s" are already used.

 Documentation/git-rebase.txt  |   18 ++++++++++++++++++
 git-rebase--interactive.sh    |   15 +++++++++++++++
 t/lib-rebase.sh               |    2 ++
 t/t3404-rebase-interactive.sh |   31 +++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index be23ad2..72e3152 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -459,6 +459,24 @@ sure that the current HEAD is "B", and call
 $ git rebase -i -p --onto Q O
 -----------------------------
 
+Reordering and editing commits usually creates untested intermediate
+steps.  You may want to check that your history editting did not break
+anything by running a test, or at least recompiling at intermediate
+points in history by using the "run" command.  You may do so by
+creating a todo list like this one:
+
+-------------------------------------------
+pick deadbee The oneline of this commit
+run make
+pick c0ffeee The oneline of the next commit
+run make test
+...
+-------------------------------------------
+
+The interactive rebase will stop when a command fails (i.e. exists
+with non-0 status) to give you an opportunity to fix the problem.  You
+can continue with `git rebase --continue`.
+
 
 SPLITTING COMMITS
 -----------------
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b94c2a0..ab8bae0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -537,6 +537,20 @@ do_next () {
 		esac
 		record_in_rewritten $sha1
 		;;
+	run)
+		read -r command rest < "$TODO"
+		mark_action_done
+		printf 'Running command: %s\n' "$rest"
+		if ! eval "$rest"
+		then
+			warn "Command $rest failed"
+			warn "You can fix the problem, and then run"
+			warn
+			warn "	git rebase --continue"
+			warn
+			exit 0
+		fi
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		if git rev-parse --verify -q "$sha1" >/dev/null
@@ -957,6 +971,7 @@ first and then run 'git rebase --continue' again."
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
+#  run <command> = Run a shell command, and stop if it fails
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6aefe27..81dd17b 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -47,6 +47,8 @@ for line in $FAKE_LINES; do
 	case $line in
 	squash|fixup|edit|reword)
 		action="$line";;
+	run*)
+		echo "$line" | sed 's/_/ /g' >> "$1";;
 	"#")
 		echo '# comment' >> "$1";;
 	">")
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9f03ce6..274a767 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -64,6 +64,37 @@ test_expect_success 'setup' '
 	done
 '
 
+test_expect_success 'rebase -i with the run command' '
+	git checkout master
+	FAKE_LINES="1 run_touch_touch-one 2 run_touch_touch-two run_false run_touch_touch-three 3 4
+		run_touch_\"touch-file__name_with_spaces\" 5" \
+		git rebase -i A &&
+	if ! [ -f touch-one ]; then
+		echo file touch-one not created
+		exit 1
+	fi &&
+	if ! [ -f touch-two ]; then
+		echo file touch-two not created
+		exit 1
+	fi &&
+	if [ -f touch-three ]; then
+		echo "file touch-three already created. Should have stopped before"
+		exit 1
+	fi &&
+	test $(git rev-parse C) = $(git rev-parse HEAD) &&
+	git rebase --continue &&
+	if ! [ -f touch-three ]; then
+		echo "file touch-three not created"
+		exit 1
+	fi &&
+	if ! [ -f "touch-file  name with spaces" ]; then
+		echo "file \"touch-file  name with spaces\" not created"
+		exit 1
+	fi &&
+	test $(git rev-parse master) = $(git rev-parse HEAD) &&
+	rm -f touch-*
+'
+
 test_expect_success 'no changes are a nop' '
 	git checkout branch2 &&
 	git rebase -i F &&
-- 
1.7.2.21.ge9796
