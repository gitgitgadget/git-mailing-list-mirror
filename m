From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFCv5 2/3] git rebase -i: warn about removed commits
Date: Wed, 10 Jun 2015 12:10:34 +0200
Message-ID: <1433931035-20011-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
References: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 10 12:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2cyE-0004AS-Ll
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 12:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994AbbFJKKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 06:10:46 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:42258 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754181AbbFJKKm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 06:10:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D4907278F;
	Wed, 10 Jun 2015 12:10:40 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vP-6cGr70NGi; Wed, 10 Jun 2015 12:10:40 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C305E2561;
	Wed, 10 Jun 2015 12:10:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id BD76920E4;
	Wed, 10 Jun 2015 12:10:40 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5P9c-CTcFkfQ; Wed, 10 Jun 2015 12:10:40 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.grenet.fr (eduroam-032245.grenet.fr [130.190.32.245])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 75AFA20DD;
	Wed, 10 Jun 2015 12:10:40 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.496.geaaf631
In-Reply-To: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271282>

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
 In git-rebase--interactive, in the error case of check_todo_list, I
 added 'git checkout $onto' so that using 'die' for the error allows
 to use 'git rebase --edit-todo' (otherwise HEAD would not have been
 changed and it still would be placed after the commits of the
 rebase).
 Since now it doesn't abort the rebase, the documentation and the
 messages in the case error have changed.
 I moved the error case away from the initial test case for missing
 commits as to prepare for 3/3 part of the patch. It is something that
 was advised by Eric Sunshine when I checked both missing and
 duplicated commits, but that I removed it when removing the checking
 for duplicated commits since there was only one test. However I add
 it again since 3/3 will add more checking.
 I use the variable raiseError that I affect if the error must be
 raised instead of testing directly because I think it makes more
 sense with 3/3 and if we add other check in the future since it adds
 more possible errors (the test for the error case if not something
 like 'if (test checkLevel =3D error && test -s todo.miss) || test cond=
2
 || test cond3 || ...').
 I am wondering if a check_todo_list call should be added in the
 '--continue' part of the code: with this patch, the checking is only
 done once, if the user doesn't edit correctly with 'git rebase
 --edit-todo', it won't be picked by this.
 In the tests in t3404 I now also test that the warning/error messages
 are correct.
 I tried to not change this patch too much since it was already
 heavily reviewed, but there are some changes (mostly the ones
 mentionned above).

 Documentation/config.txt      | 11 +++++
 Documentation/git-rebase.txt  |  6 +++
 git-rebase--interactive.sh    | 96 +++++++++++++++++++++++++++++++++++=
++++++++
 t/t3404-rebase-interactive.sh | 66 +++++++++++++++++++++++++++++
 4 files changed, 179 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4d21ce1..25b2a04 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2160,6 +2160,17 @@ rebase.autoStash::
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
index 72abf90..68a71d0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -834,6 +834,100 @@ add_exec_commands () {
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
+			printf "%s\n" "$sha1"
+			;;
+		esac
+	done
+}
+
+# Use warn for each line of a file
+# $1: file
+warn_file () {
+	while read -r line
+	do
+		warn " - $line"
+	done <"$1"
+}
+
+# Check if the user dropped some commits by mistake
+# Behaviour determined by rebase.missingCommitsCheck.
+check_todo_list () {
+	raiseError=3Df
+
+	checkLevel=3D$(git config --get rebase.missingCommitsCheck)
+	checkLevel=3D${checkLevel:-ignore}
+	# Don't be case sensitive
+	checkLevel=3D$(echo "$checkLevel" | tr 'A-Z' 'a-z')
+
+	case "$checkLevel" in
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
+			test "$checkLevel" =3D error && raiseError=3Dt
+
+			# Make the list user-friendly
+			opt=3D"--no-walk=3Dsorted --format=3Doneline --abbrev-commit --stdi=
n"
+			git rev-list $opt <"$todo".miss >"$todo".miss+
+			mv "$todo".miss+ "$todo".miss
+
+			warn "Warning: some commits may have been dropped" \
+				"accidentally."
+			warn "Dropped commits (newer to older):"
+			warn_file "$todo".miss
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
+		warn "Unrecognized setting $checkLevel for option" \
+			"rebase.missingCommitsCheck. Ignoring."
+		;;
+	esac
+
+	if test $raiseError =3D t
+	then
+		# Checkout before the first commit of the
+		# rebase: this way git rebase --continue
+		# will work correctly as it expects HEAD to be
+		# placed before the commit of the next action
+		GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
+		output git checkout $onto || die_abort "could not detach HEAD"
+		git update-ref ORIG_HEAD $orig_head
+
+		warn "You can fix this with 'git rebase --edit-todo'."
+		die "Or you can abort the rebase with 'git rebase --abort'."
+	fi
+}
+
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1079,6 +1173,8 @@ has_action "$todo" ||
=20
 expand_todo_ids
=20
+check_todo_list
+
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_pi=
cks
=20
 GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index ecd277c..a92ae19 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1118,4 +1118,70 @@ test_expect_success 'drop' '
 	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
 '
=20
+cat >expect <<EOF
+Successfully rebased and updated refs/heads/tmp2.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D=
 ignore' '
+	test_config rebase.missingCommitsCheck ignore &&
+	test_rebase_end tmp2 &&
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
+Successfully rebased and updated refs/heads/tmp2.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck =3D=
 warn' '
+	test_config rebase.missingCommitsCheck warn &&
+	test_rebase_end tmp2 &&
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
+	test_rebase_end tmp2 &&
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
2.4.2.496.gdc9319a
