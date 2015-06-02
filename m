From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFCv3 2/2] git rebase -i: warn about removed commits
Date: Tue,  2 Jun 2015 15:36:20 +0200
Message-ID: <1433252180-25591-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
References: <1433252180-25591-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Tue Jun 02 15:38:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzmMx-00022O-A9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 15:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182AbbFBNge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 09:36:34 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:54335 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755649AbbFBNgc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 09:36:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0E9462787;
	Tue,  2 Jun 2015 15:36:30 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qL7eOhSPSxvd; Tue,  2 Jun 2015 15:36:29 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F123B269F;
	Tue,  2 Jun 2015 15:36:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id EA8FF20E4;
	Tue,  2 Jun 2015 15:36:29 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pZMYhc0Npv5i; Tue,  2 Jun 2015 15:36:29 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.grenet.fr (eduroam-033033.grenet.fr [130.190.33.33])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B8DF720DD;
	Tue,  2 Jun 2015 15:36:29 +0200 (CEST)
X-Mailer: git-send-email 2.4.1.411.g9c4ad60
In-Reply-To: <1433252180-25591-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270531>

Check if commits were removed (i.e. a line was deleted) and print
warnings or abort git rebase according to the value of the
configuration variable rebase.missingCommitsCheckLevel.

Add the configuration variable rebase.missingCommitsCheckLevel.
    - When unset or set to "ignore", no checking is done.
    - When set to "warn", the commits are checked, warnings are
      displayed but git rebase still proceeds.
    - When set to "error", the commits are checked, warnings are
      displayed and the rebase is aborted.

rebase.missingCommitsCheckLevel defaults to "ignore".

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 Documentation/config.txt      |   7 +++
 Documentation/git-rebase.txt  |   6 +++
 git-rebase--interactive.sh    | 105 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t3404-rebase-interactive.sh |  25 ++++++++++
 4 files changed, 143 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4d21ce1..ec9011d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2160,6 +2160,13 @@ rebase.autoStash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
=20
+rebase.missingCommitsCheckLevel::
+	If set to "warn", git rebase -i will print a warning if some
+	commits are removed (i.e. a line was deleted), however the
+	rebase will still proceed. If set to "error", it will print
+	the previous warning and abort the rebase. If set to
+	"ignore", no checking is done.  Defaults to "ignore".
+
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to this capability
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 9cf3760..71029f8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -213,6 +213,12 @@ rebase.autoSquash::
 rebase.autoStash::
 	If set to true enable '--autostash' option by default.
=20
+rebase.missingCommitsCheckLevel::
+	If set to "warn" print warnings about removed commits in
+	interactive mode. If set to "error" print the warnings and
+	abort the rebase. If set to "ignore" no checking is
+	done. "ignore" by default.
+
 OPTIONS
 -------
 --onto <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 869cc60..6391423 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -851,6 +851,109 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
=20
+# Print the list of the SHA-1 of the commits
+# from a todo list in a file.
+# $1: todo-file, $2: outfile
+todo_list_to_sha_list () {
+	todo_list=3D$(git stripspace --strip-comments <"$1")
+	temp_file=3D$(mktemp)
+	echo "$todo_list" >$temp_file
+	while read -r command sha1 rest
+	do
+		case $command in
+		x|"exec")
+			;;
+		*)
+			printf "%s\n" "$sha1"
+			;;
+		esac
+	done <$temp_file >"$2"
+	rm $temp_file
+}
+
+# Transforms SHA-1 list in argument
+# to a list of commits (in place)
+# Doesn't check if the SHA-1 are commits.
+# $1: file with long SHA-1 list
+long_sha_to_commit_list () {
+	short_missing=3D""
+	git_command=3D"git show --oneline"
+	get_line_command=3D"head -n 1"
+	temp_file=3D$(mktemp)
+	while read -r sha
+	do
+		if test -n "$sha"
+		then
+			commit=3D$($git_command $sha | $get_line_command)
+			if test -n "$commit"
+			then
+				printf "%s\n" "$commit"
+			fi
+		fi
+	done <"$1" >$temp_file
+	mv $temp_file "$1"
+}
+
+# Use warn for each line of a file
+# $1: file to warn
+warn_file () {
+	while read -r line
+	do
+		warn " - $line"
+	done <"$1"
+}
+
+# Check if the user dropped some commits by mistake
+# Behaviour determined by .gitconfig.
+check_commits () {
+	checkLevel=3D$(git config --get rebase.missingCommitsCheckLevel)
+	checkLevel=3D${checkLevel:-ignore}
+	# To lowercase
+	checkLevel=3D$(echo "$checkLevel" | tr 'A-Z' 'a-z')
+
+	case "$checkLevel" in
+	warn|error)
+		# Get the SHA-1 of the commits
+		todo_list_to_sha_list "$todo".backup "$todo".oldsha1
+		todo_list_to_sha_list "$todo" "$todo".newsha1
+
+		# Sort the SHA-1 and compare them
+		echo "$(sort -u "$todo".oldsha1)" >"$todo".oldsha1
+		echo "$(sort -u "$todo".newsha1)" >"$todo".newsha1
+		echo "$(comm -2 -3 "$todo".oldsha1 "$todo".newsha1)" >"$todo".miss
+
+		# Make the list user-friendly
+		long_sha_to_commit_list "$todo".miss
+
+		# Check missing commits
+		if test -s "$todo".miss
+		then
+			warn "Warning : some commits may have been dropped" \
+				"accidentally."
+			warn "Dropped commits (in no relevent order):"
+			warn_file "$todo".miss
+			warn ""
+			warn "To avoid this message, use \"drop\" to" \
+				"explicitly remove a commit."
+			warn "Use git --config rebase.missingCommitsCheckLevel to change" \
+				"the level of warnings (ignore,warn,error)."
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
+			"rebase.missingCommitsCheckLevel in git rebase -i."
+		;;
+	esac
+}
+
 # The whole contents of this file is run by dot-sourcing it from
 # inside a shell function.  It used to be that "return"s we see
 # below were not inside any function, and expected to return
@@ -1096,6 +1199,8 @@ has_action "$todo" ||
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
index 8960083..07a7158 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1112,4 +1112,29 @@ test_expect_success 'drop' '
 	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
 '
=20
+test_expect_success 'rebase -i respects rebase.missingCommitsCheckLeve=
l=3Derror' '
+	test_config rebase.missingCommitsCheckLevel error &&
+	test_when_finished "git checkout master &&
+		git branch -D tmp2" &&
+	git checkout -b tmp2 master &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES=3D"1 2 3 4" \
+		git rebase -i --root &&
+	test E =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+test_expect_success 'rebase -i respects rebase.missingCommitsCheckLeve=
l=3Dwarn' '
+	test_config rebase.missingCommitsCheckLevel warn &&
+	test_when_finished "git checkout master &&
+		git branch -D tmp2" &&
+	git checkout -b tmp2 master &&
+	set_fake_editor &&
+	FAKE_LINES=3D"1 2 3 4" \
+		git rebase -i --root 2>warn.tmp &&
+	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	sed -n "1p" warn.tmp >warnl1.tmp &&
+	echo "Warning : some commits may have been dropped accidentally." >l1=
=2Etmp &&
+	test_cmp warnl1.tmp l1.tmp
+'
+
 test_done
--=20
2.4.1.411.g9c4ad60
