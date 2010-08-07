From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2 (new version)] rebase -i: add exec command to launch a shell command
Date: Sat,  7 Aug 2010 10:56:04 +0200
Message-ID: <1281171365-15399-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqeiealsez.fsf@bauges.imag.fr>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 07 14:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhiGp-0004JG-OR
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 14:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761390Ab0HGI4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 04:56:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59153 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab0HGI4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 04:56:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o778jo44028261
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 7 Aug 2010 10:45:50 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OhfCf-0005Ru-B1; Sat, 07 Aug 2010 10:56:29 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OhfCf-00041C-8P; Sat, 07 Aug 2010 10:56:29 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <vpqeiealsez.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 07 Aug 2010 10:45:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o778jo44028261
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281775552.37005@Fw1Kg78uidu3IG6bdFRH4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152851>

The typical usage pattern would be to run a test (or simply a compilation
command) at given points in history.

The shell command is ran (from the worktree root), and the rebase is
stopped when the command fails, to give the user an opportunity to fix
the problem before continuing with "git rebase --continue".

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Compared to previous version (sorry, I didn't number them) :

* Test the case where the command stops with a dirty tree, and fix it
  (thanks to Johannes Sixt)

* Reword the doc (drop "usual", and replace "shell command" with
  "shell features" to give examples which aren't commands, but yet
  useful)

That should adress everyones's comment.

 Documentation/git-rebase.txt  |   24 ++++++++++++++++++++
 git-rebase--interactive.sh    |   29 ++++++++++++++++++++++++
 t/lib-rebase.sh               |    2 +
 t/t3404-rebase-interactive.sh |   48 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index be23ad2..9c68b66 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -459,6 +459,30 @@ sure that the current HEAD is "B", and call
 $ git rebase -i -p --onto Q O
 -----------------------------
 
+Reordering and editing commits usually creates untested intermediate
+steps.  You may want to check that your history editing did not break
+anything by running a test, or at least recompiling at intermediate
+points in history by using the "exec" command (shortcut "x").  You may
+do so by creating a todo list like this one:
+
+-------------------------------------------
+pick deadbee Implement feature XXX
+fixup f1a5c00 Fix to feature XXX
+exec make
+pick c0ffeee The oneline of the next commit
+edit deadbab The oneline of the commit after
+exec cd subdir; make test
+...
+-------------------------------------------
+
+The interactive rebase will stop when a command fails (i.e. exits with
+non-0 status) to give you an opportunity to fix the problem. You can
+continue with `git rebase --continue`.
+
+The "exec" command launches the command in a shell (the one specified
+in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
+use shell features (like "cd", ">", ";" ...). The command is run from
+the root of the working tree.
 
 SPLITTING COMMITS
 -----------------
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b94c2a0..6dd5859 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -537,6 +537,34 @@ do_next () {
 		esac
 		record_in_rewritten $sha1
 		;;
+	x|"exec")
+		read -r command rest < "$TODO"
+		mark_action_done
+		printf 'Executing: %s\n' "$rest"
+		# "exec" command doesn't take a sha1 in the todo-list.
+		# => can't just use $sha1 here.
+		git rev-parse --verify HEAD > "$DOTEST"/stopped-sha
+		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
+		status=$?
+		if test "$status" -ne 0
+		then
+			warn "Execution failed: $rest"
+			warn "You can fix the problem, and then run"
+			warn
+			warn "	git rebase --continue"
+			warn
+			exit "$status"
+		fi
+		# Run in subshell because require_clean_work_tree can die.
+		if ! (require_clean_work_tree)
+		then
+			warn "Commit or stash your changes, and then run"
+			warn
+			warn "	git rebase --continue"
+			warn
+			exit 1
+		fi
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		if git rev-parse --verify -q "$sha1" >/dev/null
@@ -957,6 +985,7 @@ first and then run 'git rebase --continue' again."
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
+#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6aefe27..6ccf797 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -47,6 +47,8 @@ for line in $FAKE_LINES; do
 	case $line in
 	squash|fixup|edit|reword)
 		action="$line";;
+	exec*)
+		echo "$line" | sed 's/_/ /g' >> "$1";;
 	"#")
 		echo '# comment' >> "$1";;
 	">")
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9f03ce6..7b0026e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -64,6 +64,54 @@ test_expect_success 'setup' '
 	done
 '
 
+test_expect_success 'rebase -i with the exec command' '
+	git checkout master &&
+	FAKE_LINES="1 exec_touch_touch-one 2 exec_touch_touch-two exec_false exec_touch_touch-three 3 4
+		exec_touch_\"touch-file__name_with_spaces\";_touch_touch-after-semicolon 5" \
+		test_must_fail git rebase -i A &&
+	test -f touch-one &&
+	test -f touch-two &&
+	! test -f touch-three &&
+	test $(git rev-parse C) = $(git rev-parse HEAD) || {
+		echo "Stopped at wrong revision:"
+		echo "($(git describe --tags HEAD) instead of C)"
+		false
+	} &&
+	git rebase --continue &&
+	test -f touch-three &&
+	test -f "touch-file  name with spaces" &&
+	test -f touch-after-semicolon &&
+	test $(git rev-parse master) = $(git rev-parse HEAD) || {
+		echo "Stopped at wrong revision:"
+		echo "($(git describe --tags HEAD) instead of master)"
+		false
+	} &&
+	rm -f touch-*
+'
+
+test_expect_success 'rebase -i with the exec command runs from tree root' '
+	git checkout master &&
+	mkdir subdir && cd subdir &&
+	FAKE_LINES="1 exec_touch_touch-subdir" \
+		git rebase -i HEAD^ &&
+	cd .. &&
+	test -f touch-subdir &&
+	rm -fr subdir
+'
+
+test_expect_success 'rebase -i with the exec command checks tree cleanness' '
+	git checkout master &&
+	FAKE_LINES="exec_echo_foo_>file1 1" \
+		test_must_fail git rebase -i HEAD^ &&
+	test $(git rev-parse master^) = $(git rev-parse HEAD) || {
+		echo "Stopped at wrong revision:"
+		echo "($(git describe --tags HEAD) instead of master^)"
+		false
+	} &&
+	git reset --hard &&
+	git rebase --continue
+'
+
 test_expect_success 'no changes are a nop' '
 	git checkout branch2 &&
 	git rebase -i F &&
-- 
1.7.2.1.52.g95e25.dirty
