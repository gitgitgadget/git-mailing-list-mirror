From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCHv7 2/3] git rebase -i: warn about removed commits
Date: Mon, 29 Jun 2015 22:20:31 +0200
Message-ID: <1435609232-14232-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:21:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fXx-0007tG-MU
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbbF2UUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2015 16:20:47 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:46092 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752649AbbF2UUh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2015 16:20:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 35103296F;
	Mon, 29 Jun 2015 22:20:35 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U+rDNxmV6OaX; Mon, 29 Jun 2015 22:20:35 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0F20B29A3;
	Mon, 29 Jun 2015 22:20:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 08E1720DC;
	Mon, 29 Jun 2015 22:20:35 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9w60AZwvJks; Mon, 29 Jun 2015 22:20:34 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.univnautes.lan (eduspot-condillac.crous-grenoble.fr [193.52.241.183])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id D50CD20DD;
	Mon, 29 Jun 2015 22:20:34 +0200 (CEST)
X-Mailer: git-send-email 2.4.3.532.gab13793
In-Reply-To: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273012>

Check if commits were removed (i.e. a line was deleted) and print
warnings or stop git rebase depending on the value of the
configuration variable rebase.missingCommitsCheck.

This patch gives the user the possibility to avoid silent loss of
information (losing a commit through deleting the line in this case)
if he wants.

Add the configuration variable rebase.missingCommitsCheck.
    - When unset or set to "ignore", no checking is done.
    - When set to "warn", the commits are checked, warnings are
      displayed but git rebase still proceeds.
    - When set to "error", the commits are checked, warnings are
      displayed and the rebase is stopped.
      (The user can then use 'git rebase --edit-todo' and
      'git rebase --continue', or 'git rebase --abort')

rebase.missingCommitsCheck defaults to "ignore".

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 Documentation/config.txt      |  11 +++++
 Documentation/git-rebase.txt  |   6 +++
 git-rebase--interactive.sh    | 104 ++++++++++++++++++++++++++++++++++=
++++++--
 t/t3404-rebase-interactive.sh |  66 +++++++++++++++++++++++++++
 4 files changed, 184 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93..0360e7b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2169,6 +2169,17 @@ rebase.autoStash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
=20
+rebase.missingCommitsCheck::
+	If set to "warn", git rebase -i will print a warning if some
+	commits are removed (e.g. a line was deleted), however the
+	rebase will still proceed. If set to "error", it will print
+	the previous warning and stop the rebase, 'git rebase
+	--edit-todo' can then be used to correct the error. If set to
+	"ignore", no checking is done.
+	To drop a commit without warning or error, use the `drop`
+	command in the todo-list.
+	Defaults to "ignore".
+
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to this capability
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 34bd070..2ca3b8d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -213,6 +213,12 @@ rebase.autoSquash::
 rebase.autoStash::
 	If set to true enable '--autostash' option by default.
=20
+rebase.missingCommitsCheck::
+	If set to "warn", print warnings about removed commits in
+	interactive mode. If set to "error", print the warnings and
+	stop the rebase. If set to "ignore", no checking is
+	done. "ignore" by default.
+
 OPTIONS
 -------
 --onto <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 72abf90..66daacf 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -834,6 +834,104 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
=20
+# Print the list of the SHA-1 of the commits
+# from stdin to stdout
+todo_list_to_sha_list () {
+	git stripspace --strip-comments |
+	while read -r command sha1 rest
+	do
+		case $command in
+		"$comment_char"*|''|noop|x|"exec")
+			;;
+		*)
+			long_sha=3D$(git rev-list --no-walk "$sha1" 2>/dev/null)
+			printf "%s\n" "$long_sha"
+			;;
+		esac
+	done
+}
+
+# Use warn for each line in stdin
+warn_lines () {
+	while read -r line
+	do
+		warn " - $line"
+	done
+}
+
+# Switch to the branch in $into and notify it in the reflog
+checkout_onto () {
+	GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
+	output git checkout $onto || die_abort "could not detach HEAD"
+	git update-ref ORIG_HEAD $orig_head
+}
+
+# Check if the user dropped some commits by mistake
+# Behaviour determined by rebase.missingCommitsCheck.
+check_todo_list () {
+	raise_error=3Df
+
+	check_level=3D$(git config --get rebase.missingCommitsCheck)
+	check_level=3D${check_level:-ignore}
+	# Don't be case sensitive
+	check_level=3D$(printf '%s' "$check_level" | tr 'A-Z' 'a-z')
+
+	case "$check_level" in
+	warn|error)
+		# Get the SHA-1 of the commits
+		todo_list_to_sha_list <"$todo".backup >"$todo".oldsha1
+		todo_list_to_sha_list <"$todo" >"$todo".newsha1
+
+		# Sort the SHA-1 and compare them
+		sort -u "$todo".oldsha1 >"$todo".oldsha1+
+		mv "$todo".oldsha1+ "$todo".oldsha1
+		sort -u "$todo".newsha1 >"$todo".newsha1+
+		mv "$todo".newsha1+ "$todo".newsha1
+		comm -2 -3 "$todo".oldsha1 "$todo".newsha1 >"$todo".miss
+
+		# Warn about missing commits
+		if test -s "$todo".miss
+		then
+			test "$check_level" =3D error && raise_error=3Dt
+
+			warn "Warning: some commits may have been dropped" \
+				"accidentally."
+			warn "Dropped commits (newer to older):"
+
+			# Make the list user-friendly and display
+			opt=3D"--no-walk=3Dsorted --format=3Doneline --abbrev-commit --stdi=
n"
+			git rev-list $opt <"$todo".miss | warn_lines
+
+			warn "To avoid this message, use \"drop\" to" \
+				"explicitly remove a commit."
+			warn
+			warn "Use 'git --config rebase.missingCommitsCheck' to change" \
+				"the level of warnings."
+			warn "The possible behaviours are: ignore, warn, error."
+			warn
+		fi
+		;;
+	ignore)
+		;;
+	*)
+		warn "Unrecognized setting $check_level for option" \
+			"rebase.missingCommitsCheck. Ignoring."
+		;;
+	esac
+
+	if test $raise_error =3D t
+	then
+		# Checkout before the first commit of the
+		# rebase: this way git rebase --continue
+		# will work correctly as it expects HEAD to be
+		# placed before the commit of the next action
+		checkout_onto
+
+		warn "You can fix this with 'git rebase --edit-todo'."
+		die "Or you can abort the rebase with 'git rebase --abort'."
+	fi
+}
+
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1077,13 +1175,13 @@ git_sequence_editor "$todo" ||
 has_action "$todo" ||
 	return 2
=20
+check_todo_list
+
 expand_todo_ids
=20
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_pi=
cks
=20
-GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
-output git checkout $onto || die_abort "could not detach HEAD"
-git update-ref ORIG_HEAD $orig_head
+checkout_onto
 do_rest
=20
 }
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 3d059e5..904a2d0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1120,4 +1120,70 @@ test_expect_success 'drop' '
 	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
 '
=20
+cat >expect <<EOF
+Successfully rebased and updated refs/heads/missing-commit.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D=
 ignore' '
+	test_config rebase.missingCommitsCheck ignore &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	FAKE_LINES=3D"1 2 3 4" \
+		git rebase -i --root 2>actual &&
+	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
+To avoid this message, use "drop" to explicitly remove a commit.
+
+Use 'git --config rebase.missingCommitsCheck' to change the level of w=
arnings.
+The possible behaviours are: ignore, warn, error.
+
+Successfully rebased and updated refs/heads/missing-commit.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D=
 warn' '
+	test_config rebase.missingCommitsCheck warn &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	FAKE_LINES=3D"1 2 3 4" \
+		git rebase -i --root 2>actual &&
+	test_cmp expect actual &&
+	test D =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+cat >expect <<EOF
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master~2)
+To avoid this message, use "drop" to explicitly remove a commit.
+
+Use 'git --config rebase.missingCommitsCheck' to change the level of w=
arnings.
+The possible behaviours are: ignore, warn, error.
+
+You can fix this with 'git rebase --edit-todo'.
+Or you can abort the rebase with 'git rebase --abort'.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D=
 error' '
+	test_config rebase.missingCommitsCheck error &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES=3D"1 2 4" \
+		git rebase -i --root 2>actual &&
+	test_cmp expect actual &&
+	cp .git/rebase-merge/git-rebase-todo.backup \
+		.git/rebase-merge/git-rebase-todo &&
+	FAKE_LINES=3D"1 2 drop 3 4 drop 5" \
+		git rebase --edit-todo &&
+	git rebase --continue &&
+	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test B =3D $(git cat-file commit HEAD^ | sed -ne \$p)
+'
+
 test_done
--=20
2.4.3.532.gf6210e5.dirty
