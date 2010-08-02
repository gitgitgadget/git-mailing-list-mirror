From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] rebase -i: add exec command to launch a shell command
Date: Mon,  2 Aug 2010 12:03:53 +0200
Message-ID: <1280743433-27803-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqwrs9nxi5.fsf@bauges.imag.fr>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Marc Branchaud <marcnarc@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 02 12:06:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfruG-0000MK-JM
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 12:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab0HBKEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 06:04:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38952 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839Ab0HBKEU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 06:04:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o72A1uqe026902
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 12:01:56 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OfrsC-00044X-Jx; Mon, 02 Aug 2010 12:03:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OfrsC-0007F0-GL; Mon, 02 Aug 2010 12:03:56 +0200
X-Mailer: git-send-email 1.7.2.1.10.g5cb67a
In-Reply-To: <vpqwrs9nxi5.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Aug 2010 12:01:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o72A1uqe026902
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281348119.9503@H8+5emgBfINljw+fA3JGyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152402>

The typical usage pattern would be to run a test (or simply a compilation
command) at given points in history.

The shell command is ran (in the directory where the rebase was started
by the user), and the rebase is stopped when the command fails, to give
the user an opportunity to fix the problem before continuing with "git
rebase --continue".

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-rebase.txt  |   26 +++++++++++++
 git-rebase--interactive.sh    |   77 +++++++++++++++++++++++++++++++++++++++
 git-rebase.sh                 |    6 +++
 t/lib-rebase.sh               |    2 +
 t/t3404-rebase-interactive.sh |   79 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 190 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index be23ad2..121f873 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -459,6 +459,32 @@ sure that the current HEAD is "B", and call
 $ git rebase -i -p --onto Q O
 -----------------------------
 
+Reordering and editing commits usually creates untested intermediate
+steps.  You may want to check that your history editting did not break
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
+exec make; make test
+...
+-------------------------------------------
+
+The interactive rebase will stop when a command fails (i.e. exists
+with non-0 status) to give you an opportunity to fix the problem.  You
+can continue with `git rebase --continue`.
+
+The "exec" command launches the command in a shell (the one specified
+in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
+use usual shell commands like "cd". The commands are ran from the same
+directory as "rebase -i" was started (this directory is temporarily
+re-created if needed).
+
 
 SPLITTING COMMITS
 -----------------
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b94c2a0..98a54e5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -104,6 +104,10 @@ AMEND="$DOTEST"/amend
 REWRITTEN_LIST="$DOTEST"/rewritten-list
 REWRITTEN_PENDING="$DOTEST"/rewritten-pending
 
+# The "exec" command needs to know from which directory the
+# interactive rebase started.
+START_PREFIX="$DOTEST"/start-prefix
+
 PRESERVE_MERGES=
 STRATEGY=
 ONTO=
@@ -448,6 +452,31 @@ record_in_rewritten() {
 	esac
 }
 
+# Like "mkdir -p", but outputs the largest prefix of "$1" which
+# already exists as a directory
+mkdir_parent_verbose() {
+	dir=$1
+	to_mk=.
+	while ! test -d "$dir"
+	do
+		to_mk=$(basename "$dir")/"$to_mk"
+		dir=$(dirname "$dir")
+	done
+	(cd "$dir" && mkdir -p "$to_mk" && pwd -P)
+}
+
+# Delete directory "$1", and its parent, until encountering a
+# non-empty directory or "$2".
+cleanup_directory() {
+	to_rm="$1"
+	while test -d "$1" && test -d "$2" &&
+		test "$(cd "$to_rm"; pwd -P)" != "$(cd "$2"; pwd -P)" &&
+		rmdir "$to_rm"
+	do
+		to_rm=$(dirname "$to_rm")
+	done
+}
+
 do_next () {
 	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
 	read -r command sha1 rest < "$TODO"
@@ -537,6 +566,52 @@ do_next () {
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
+		# We run the command from the directory in which "git
+		# rebase -i" was first started.
+		prefix=$(cat "$START_PREFIX")
+		to_rm=
+		old_pwd=$(pwd)
+		cd "$prefix" 2>/dev/null || {
+			# The prefix from which the rebase started
+			# didn't exist in the past.  We create the
+			# directory to let the command run from there,
+			# and remember how to delete it in $to_rm.
+			to_rm=$(mkdir_parent_verbose "$prefix") && cd "$prefix"
+		} || {
+			warn "Cannot create directory $prefix"
+			warn "Aborting execution of command $rest"
+			warn "To continue, run"
+			warn
+			warn "	git rebase --continue"
+			warn
+			exit 1
+		}
+		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
+		status=$?
+		cd "$old_pwd"
+		# Don't leave empty directory around.
+		# Since cleanup_directory never deletes non-empty
+		# directories, this can't lose valuable data.
+		if [ -n "$to_rm" ]; then
+			cleanup_directory "$prefix" "$to_rm"
+		fi
+		if test "$status" -ne 0
+		then
+			warn "Execution failed: $rest"
+			warn "You can fix the problem, and then run"
+			warn
+			warn "	git rebase --continue"
+			warn
+			exit "$status"
+		fi
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		if git rev-parse --verify -q "$sha1" >/dev/null
@@ -851,6 +926,7 @@ first and then run 'git rebase --continue' again."
 		echo $ONTO > "$DOTEST"/onto
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
+		echo "$GIT_PREFIX" > "$START_PREFIX"
 		if test t = "$PRESERVE_MERGES"
 		then
 			if test -z "$REBASE_ROOT"
@@ -957,6 +1033,7 @@ first and then run 'git rebase --continue' again."
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
+#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/git-rebase.sh b/git-rebase.sh
index ab4afa7..fff512c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -32,6 +32,12 @@ OPTIONS_SPEC=
 . git-sh-setup
 set_reflog_action rebase
 require_work_tree
+
+# Keep the prefix path in an environment variable so that
+# git-rebase--interactive can find it.
+GIT_PREFIX=$(git rev-parse --show-prefix)
+export GIT_PREFIX
+
 cd_to_toplevel
 
 LF='
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
index 9f03ce6..649a400 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -64,6 +64,85 @@ test_expect_success 'setup' '
 	done
 '
 
+file_must_exist () {
+    if ! [ -f "$1" ]; then
+	echo "file $1 not created."
+	false
+    fi
+}
+
+file_must_not_exist () {
+    if [ -f "$1" ]; then
+	echo "file $1 created while it shouldn't have. $2"
+	false
+    fi
+}
+
+dir_must_exist () {
+    if ! [ -d "$1" ]; then
+	echo "dir $1 does not exist."
+	false
+    fi
+}
+
+dir_must_not_exist () {
+    if [ -d "$1" ]; then
+	echo "dir $1 exists while it shouldn't. $2"
+	false
+    fi
+}
+
+test_expect_success 'rebase -i with the exec command' '
+	git checkout master &&
+	FAKE_LINES="1 exec_touch_touch-one 2 exec_touch_touch-two exec_false exec_touch_touch-three 3 4
+		exec_touch_\"touch-file__name_with_spaces\";_touch_touch-after-semicolon 5" \
+		test_must_fail git rebase -i A &&
+	file_must_exist touch-one &&
+	file_must_exist touch-two &&
+	file_must_not_exist touch-three "(Should have stopped before)" &&
+	test $(git rev-parse C) = $(git rev-parse HEAD) || {
+		echo "Stopped at wrong revision:"
+		echo "($(git describe --tags HEAD) instead of C)"
+		false
+	} &&
+	git rebase --continue &&
+	file_must_exist touch-three &&
+	file_must_exist "touch-file  name with spaces" &&
+	file_must_exist touch-after-semicolon &&
+	test $(git rev-parse master) = $(git rev-parse HEAD) || {
+		echo "Stopped at wrong revision:"
+		echo "($(git describe --tags HEAD) instead of master)"
+		false
+	} &&
+	rm -f touch-*
+'
+
+test_expect_success 'rebase -i with exec in deleted directory' '
+	git checkout master &&
+	rm -f pwd.txt &&
+	mkdir tmpdir &&
+	cd tmpdir &&
+	pwd > ../expect &&
+	FAKE_LINES="1 exec_false_one
+		      exec_pwd>../actual exec_false_two
+		      exec_touch_tmpfile exec_false_three
+		      exec_pwd" \
+		test_must_fail git rebase -i HEAD^ &&
+	cd .. && rm -fr tmpdir &&
+	# Should re-create tmpdir temporarily, and clean it up:
+	test_must_fail git rebase --continue &&
+	test_cmp expect actual &&
+	dir_must_not_exist tmpdir &&
+	# Should not cleanup non-empty directory
+	test_must_fail git rebase --continue &&
+	file_must_exist tmpdir/tmpfile &&
+	rm -fr tmpdir && touch tmpdir &&
+	# Should fail because of D/F conflict
+	test_must_fail git rebase --continue &&
+	git rebase --continue &&
+	rm -fr tmpdir
+'
+
 test_expect_success 'no changes are a nop' '
 	git checkout branch2 &&
 	git rebase -i F &&
-- 
1.7.2.1.10.g5cb67a
