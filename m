From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: =?UTF-8?q?=5BPATCH=201/2=20=28fix=20broken=20test=29=5D=20rebase=20-i=3A=20add=20exec=20command=20to=20launch=20a=20shell=20command?=
Date: Tue, 10 Aug 2010 17:17:51 +0200
Message-ID: <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq62ziv788.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 10 17:28:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiqkS-0006mX-TT
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 17:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120Ab0HJP2G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 11:28:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:61944 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757572Ab0HJP2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 11:28:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7AFHrxo000138
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Aug 2010 17:17:54 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiqaP-0002h5-Qx; Tue, 10 Aug 2010 17:17:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OiqaP-0007mr-Q4; Tue, 10 Aug 2010 17:17:53 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <vpq62ziv788.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 10 Aug 2010 17:17:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153119>

The typical usage pattern would be to run a test (or simply a compilati=
on
command) at given points in history.

The shell command is ran (from the worktree root), and the rebase is
stopped when the command fails, to give the user an opportunity to fix
the problem before continuing with "git rebase --continue".

This needs a little rework of skip_unnecessary_picks, which wasn't robu=
st
enough to deal with lines like

  exec >"file    name with many spaces"

in the todolist. The new version extracts command, sha1 and rest from
each line, but outputs the line itself verbatim to avoid changing the
whitespace layout.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This fixes the non-POSIX behavior of the tests found by =C3=86var Arnfj=
=C3=B6r=C3=B0
Bjarmason (FAKE_LINES=3Dfoo test_must_fail ... does not work).

Also, I replaced "touch foo" with ">foo" and found a small bug. This
is the skip_unnecessary_picks of the commit message and of the patch
below.

 Documentation/git-rebase.txt  |   24 ++++++++++++++++
 git-rebase--interactive.sh    |   38 +++++++++++++++++++++++--
 t/lib-rebase.sh               |    2 +
 t/t3404-rebase-interactive.sh |   61 +++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index be23ad2..9c68b66 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -459,6 +459,30 @@ sure that the current HEAD is "B", and call
 $ git rebase -i -p --onto Q O
 -----------------------------
=20
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
=20
 SPLITTING COMMITS
 -----------------
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b94c2a0..bf49b5b 100755
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
+		# =3D> can't just use $sha1 here.
+		git rev-parse --verify HEAD > "$DOTEST"/stopped-sha
+		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
+		status=3D$?
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
@@ -591,10 +619,13 @@ do_rest () {
 # skip picking commits whose parents are unchanged
 skip_unnecessary_picks () {
 	fd=3D3
-	while read -r command sha1 rest
+	while read -r line
 	do
+		command=3D$(echo "$line" | sed 's/  */ /' | cut -d ' ' -f 1)
+		sha1=3D$(echo "$line"    | sed 's/  */ /' | cut -d ' ' -f 2)
+		rest=3D$(echo "$line"    | sed 's/  */ /' | cut -d ' ' -f 3-)
 		# fd=3D3 means we skip the command
-		case "$fd,$command,$(git rev-parse --verify --quiet $sha1^)" in
+		case "$fd,$command,$(git rev-parse --verify --quiet "$sha1"^)" in
 		3,pick,"$ONTO"*|3,p,"$ONTO"*)
 			# pick a commit whose parent is current $ONTO -> skip
 			ONTO=3D$sha1
@@ -606,7 +637,7 @@ skip_unnecessary_picks () {
 			fd=3D1
 			;;
 		esac
-		printf '%s\n' "$command${sha1:+ }$sha1${rest:+ }$rest" >&$fd
+		echo "$line" >&$fd
 	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
 	mv -f "$TODO".new "$TODO" &&
 	case "$(peek_next_command)" in
@@ -957,6 +988,7 @@ first and then run 'git rebase --continue' again."
 #  e, edit =3D use commit, but stop for amending
 #  s, squash =3D use commit, but meld into previous commit
 #  f, fixup =3D like "squash", but discard this commit's log message
+#  x <cmd>, exec <cmd> =3D Run a shell command <cmd>, and stop if it f=
ails
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
 		action=3D"$line";;
+	exec*)
+		echo "$line" | sed 's/_/ /g' >> "$1";;
 	"#")
 		echo '# comment' >> "$1";;
 	">")
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 9f03ce6..93b181e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -64,6 +64,67 @@ test_expect_success 'setup' '
 	done
 '
=20
+# "exec" commands are ran with the user shell by default, but this may
+# be non-POSIX. For example, if SHELL=3Dzsh then ">file" doesn't work
+# to create a file. Unseting SHELL avoids such non-portable behavior
+# in tests.
+SHELL=3D
+
+test_expect_success 'rebase -i with the exec command' '
+	git checkout master &&
+	(
+	FAKE_LINES=3D"1 exec_>touch-one
+		2 exec_>touch-two exec_false exec_>touch-three
+		3 4 exec_>\"touch-file__name_with_spaces\";_>touch-after-semicolon 5=
" &&
+	export FAKE_LINES &&
+	test_must_fail git rebase -i A
+	) &&
+	test -f touch-one &&
+	test -f touch-two &&
+	! test -f touch-three &&
+	test $(git rev-parse C) =3D $(git rev-parse HEAD) || {
+		echo "Stopped at wrong revision:"
+		echo "($(git describe --tags HEAD) instead of C)"
+		false
+	} &&
+	git rebase --continue &&
+	test -f touch-three &&
+	test -f "touch-file  name with spaces" &&
+	test -f touch-after-semicolon &&
+	test $(git rev-parse master) =3D $(git rev-parse HEAD) || {
+		echo "Stopped at wrong revision:"
+		echo "($(git describe --tags HEAD) instead of master)"
+		false
+	} &&
+	rm -f touch-*
+'
+
+test_expect_success 'rebase -i with the exec command runs from tree ro=
ot' '
+	git checkout master &&
+	mkdir subdir && cd subdir &&
+	FAKE_LINES=3D"1 exec_>touch-subdir" \
+		git rebase -i HEAD^ &&
+	cd .. &&
+	test -f touch-subdir &&
+	rm -fr subdir
+'
+
+test_expect_success 'rebase -i with the exec command checks tree clean=
ness' '
+	git checkout master &&
+	(
+	FAKE_LINES=3D"exec_echo_foo_>file1 1" &&
+	export FAKE_LINES &&
+	test_must_fail git rebase -i HEAD^
+	) &&
+	test $(git rev-parse master^) =3D $(git rev-parse HEAD) || {
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
--=20
1.7.2.1.52.g95e25.dirty
