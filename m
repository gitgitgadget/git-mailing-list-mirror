From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFCv4 2/2] git rebase -i: warn about removed commits
Date: Wed,  3 Jun 2015 13:44:19 +0200
Message-ID: <1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 03 13:53:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z07Ec-0004tU-6N
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 13:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbbFCLwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 07:52:20 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:47268 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754015AbbFCLo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 07:44:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 1533948853;
	Wed,  3 Jun 2015 13:44:23 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZKLgzT0t4UQ; Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id EBEFD4863D;
	Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id E587220E4;
	Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LaQs9yJJlE0g; Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.grenet.fr (eduroam-033187.grenet.fr [130.190.33.187])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B994820DF;
	Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.389.geaf7ccf
In-Reply-To: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270679>

Check if commits were removed (i.e. a line was deleted) and print
warnings or abort git rebase depending on the value of the
configuration variable rebase.missingCommits.

This patch gives the user the possibility to avoid silent loss of
information (losing a commit through deleting the line in this case)
if he wants to.

Add the configuration variable rebase.missingCommitsCheck.
    - When unset or set to "ignore", no checking is done.
    - When set to "warn", the commits are checked, warnings are
      displayed but git rebase still proceeds.
    - When set to "error", the commits are checked, warnings are
      displayed and the rebase is aborted.

rebase.missingCommitsCheck defaults to "ignore".

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 Documentation/config.txt      | 10 ++++++
 Documentation/git-rebase.txt  |  6 ++++
 git-rebase--interactive.sh    | 82 +++++++++++++++++++++++++++++++++++=
++++++++
 t/t3404-rebase-interactive.sh | 63 +++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4d21ce1..b29cd8d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2160,6 +2160,16 @@ rebase.autoStash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
=20
+rebase.missingCommitsCheck::
+	If set to "warn", git rebase -i will print a warning if some
+	commits are removed (e.g. a line was deleted), however the
+	rebase will still proceed. If set to "error", it will print
+	the previous warning and abort the rebase. If set to
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
index 9cf3760..6d413a1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -213,6 +213,12 @@ rebase.autoSquash::
 rebase.autoStash::
 	If set to true enable '--autostash' option by default.
=20
+rebase.missingCommitsCheck::
+	If set to "warn" print warnings about removed commits in
+	interactive mode. If set to "error" print the warnings and
+	abort the rebase. If set to "ignore" no checking is
+	done. "ignore" by default.
+
 OPTIONS
 -------
 --onto <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 869cc60..26804dd 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -851,6 +851,86 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
=20
+# Print the list of the SHA-1 of the commits
+# from a todo list in a file.
+# $1: todo-file, $2: outfile
+todo_list_to_sha_list () {
+	git stripspace --strip-comments <"$1" | while read -r command sha1 re=
st
+	do
+		case $command in
+		x|"exec")
+			;;
+		*)
+			printf "%s\n" "$sha1"
+			;;
+		esac
+	done >"$2"
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
+check_commits () {
+	checkLevel=3D$(git config --get rebase.missingCommitsCheck)
+	checkLevel=3D${checkLevel:-ignore}
+	# Don't be case sensitive
+	checkLevel=3D$(echo "$checkLevel" | tr 'A-Z' 'a-z')
+
+	case "$checkLevel" in
+	warn|error)
+		# Get the SHA-1 of the commits
+		todo_list_to_sha_list "$todo".backup "$todo".oldsha1
+		todo_list_to_sha_list "$todo" "$todo".newsha1
+
+		# Sort the SHA-1 and compare them
+		sort -u "$todo".oldsha1 >"$todo".oldsha1+
+		mv "$todo".oldsha1+ "$todo".oldsha1
+		sort -u "$todo".newsha1 >"$todo".newsha1+
+		mv "$todo".newsha1+ "$todo".newsha1
+		comm -2 -3 "$todo".oldsha1 "$todo".newsha1 >"$todo".miss
+
+		# Make the list user-friendly
+		opt=3D"--no-walk=3Dsorted --format=3Doneline --abbrev-commit --stdin=
"
+		git rev-list $opt <"$todo".miss >"$todo".miss+
+		mv "$todo".miss+ "$todo".miss
+
+		# Check missing commits
+		if test -s "$todo".miss
+		then
+			warn "Warning: some commits may have been dropped" \
+				"accidentally."
+			warn "Dropped commits (newer to older):"
+			warn_file "$todo".miss
+			warn ""
+			warn "To avoid this message, use \"drop\" to" \
+				"explicitly remove a commit."
+			warn "Use git --config rebase.missingCommitsCheck to change" \
+				"the level of warnings (ignore, warn, error)."
+			warn ""
+
+			if test "$checkLevel" =3D error
+			then
+				die_abort "Rebase aborted due to dropped commits."
+			fi
+		fi
+		;;
+	ignore)
+		;;
+	*)
+		warn "Unrecognized setting $checkLevel for option" \
+			"rebase.missingCommitsCheck."
+		;;
+	esac
+}
+
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1096,6 +1176,8 @@ has_action "$todo" ||
=20
 expand_todo_ids
=20
+check_commits
+
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_pi=
cks
=20
 GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION: checkout $onto_name"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 8960083..f369d2c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1112,4 +1112,67 @@ test_expect_success 'drop' '
 	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
 '
=20
+cat >expect <<EOF
+Successfully rebased and updated refs/heads/tmp2.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck=3Di=
gnore' '
+	test_config rebase.missingCommitsCheck ignore &&
+	test_when_finished "git checkout master &&
+		git branch -D tmp2" &&
+	git checkout -b tmp2 master &&
+	set_fake_editor &&
+	FAKE_LINES=3D"1 2 3 4" \
+		git rebase -i --root 2>warning &&
+	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_cmp warning expect
+'
+
+cat >expect <<EOF
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
+
+To avoid this message, use "drop" to explicitly remove a commit.
+Use git --config rebase.missingCommitsCheck to change the level of war=
nings (ignore, warn, error).
+
+Successfully rebased and updated refs/heads/tmp2.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck=3Dw=
arn' '
+	test_config rebase.missingCommitsCheck warn &&
+	test_when_finished "git checkout master &&
+		git branch -D tmp2" &&
+	git checkout -b tmp2 master &&
+	set_fake_editor &&
+	FAKE_LINES=3D"1 2 3 4" \
+		git rebase -i --root 2>warning &&
+	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_cmp warning expect
+'
+
+cat >expect <<EOF
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
+ - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master~2)
+
+To avoid this message, use "drop" to explicitly remove a commit.
+Use git --config rebase.missingCommitsCheck to change the level of war=
nings (ignore, warn, error).
+
+Rebase aborted due to dropped commits.
+EOF
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheck=3De=
rror' '
+	test_config rebase.missingCommitsCheck error &&
+	test_when_finished "git checkout master &&
+		git branch -D tmp2" &&
+	git checkout -b tmp2 master &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES=3D"1 2 4" \
+		git rebase -i --root 2>warning &&
+	test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_cmp warning expect
+'
+
 test_done
--=20
2.4.2.389.geaf7ccf
