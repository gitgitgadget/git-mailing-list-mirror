From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCHv6 3/3] git rebase -i: add static check for commands and SHA-1
Date: Mon, 22 Jun 2015 23:42:49 +0200
Message-ID: <1435009369-11496-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Mon Jun 22 23:43:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z79Uu-0000w7-EZ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbbFVVnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 17:43:16 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:39301 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746AbbFVVnK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 17:43:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A64D28AA5;
	Mon, 22 Jun 2015 23:43:08 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVUyH04IWSy7; Mon, 22 Jun 2015 23:43:08 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9525C86FC;
	Mon, 22 Jun 2015 23:43:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 8EE0F20DC;
	Mon, 22 Jun 2015 23:43:08 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZGujkFrRmp6; Mon, 22 Jun 2015 23:43:08 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.univnautes.lan (eduspot-condillac.crous-grenoble.fr [193.52.241.183])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 663DB20D2;
	Mon, 22 Jun 2015 23:43:08 +0200 (CEST)
X-Mailer: git-send-email 2.4.3.371.g8992f2a
In-Reply-To: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272422>

Check before the start of the rebasing if the commands exists, and for
the commands expecting a SHA-1, check if the SHA-1 is present and
corresponds to a commit. In case of error, print the error, stop git
rebase and prompt the user to fix with 'git rebase --edit-todo' or to
abort.

This allows to avoid doing half of a rebase before finding an error
and giving back what's left of the todo list to the user and prompt
him to fix when it might be too late for him to do so (he might have
to abort and restart the rebase).

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 I used:
   read -r command sha1 rest <<EOF
   $line
   EOF
 because
   printf '%s' "$line" | read -r command sha1 rest
 doesn't work (the 3 variables have no value as a result).
 There might be a better way to do this, but I don't have it right now.

 git-rebase--interactive.sh    | 70 +++++++++++++++++++++++++++++++++++=
++++++++
 t/lib-rebase.sh               |  5 ++++
 t/t3404-rebase-interactive.sh | 40 +++++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 66daacf..6381686 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -834,6 +834,52 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
=20
+# Check if the SHA-1 passed as an argument is a
+# correct one, if not then print $2 in "$todo".badsha
+# $1: the SHA-1 to test
+# $2: the line to display if incorrect SHA-1
+check_commit_sha () {
+	badsha=3Df
+	if test -z $1
+	then
+		badsha=3Dt
+	else
+		sha1_verif=3D"$(git rev-parse --verify --quiet $1^{commit})"
+		if test -z $sha1_verif
+		then
+			badsha=3Dt
+		fi
+	fi
+
+	if test $badsha =3D t
+	then
+		printf '%s\n' "$2" >>"$todo".badsha
+	fi
+}
+
+# prints the bad commits and bad commands
+# from the todolist in stdin
+check_bad_cmd_and_sha () {
+	git stripspace --strip-comments |
+	while read -r line
+	do
+		read -r command sha1 rest <<EOF
+$line
+EOF
+		case $command in
+		''|noop|x|"exec")
+			# Doesn't expect a SHA-1
+			;;
+		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
+			check_commit_sha $sha1 "$line"
+			;;
+		*)
+			printf '%s\n' "$line" >>"$todo".badcmd
+			;;
+		esac
+	done
+}
+
 # Print the list of the SHA-1 of the commits
 # from stdin to stdout
 todo_list_to_sha_list () {
@@ -868,6 +914,8 @@ checkout_onto () {
=20
 # Check if the user dropped some commits by mistake
 # Behaviour determined by rebase.missingCommitsCheck.
+# Check if there is an unrecognized command or a
+# bad SHA-1 in a command.
 check_todo_list () {
 	raise_error=3Df
=20
@@ -919,6 +967,28 @@ check_todo_list () {
 		;;
 	esac
=20
+	check_bad_cmd_and_sha <"$todo"
+
+	if test -s "$todo".badsha
+	then
+		raise_error=3Dt
+
+		warn "Warning: the SHA-1 is missing or isn't" \
+			"a commit in the following line(s):"
+		warn_lines <"$todo".badsha
+		warn
+	fi
+
+	if test -s "$todo".badcmd
+	then
+		raise_error=3Dt
+
+		warn "Warning: the command isn't recognized" \
+			"in the following line(s):"
+		warn_lines <"$todo".badcmd
+		warn
+	fi
+
 	if test $raise_error =3D t
 	then
 		# Checkout before the first commit of the
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index fdbc900..9a96e15 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -54,6 +54,11 @@ set_fake_editor () {
 			echo '# comment' >> "$1";;
 		">")
 			echo >> "$1";;
+		bad)
+			action=3D"badcmd";;
+		fakesha)
+			echo "$action XXXXXXX False commit" >> "$1"
+			action=3Dpick;;
 		*)
 			sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
 			action=3Dpick;;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index a92ae19..d691b1c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1184,4 +1184,44 @@ test_expect_success 'rebase -i respects rebase.m=
issingCommitsCheck =3D error' '
 	test B =3D $(git cat-file commit HEAD^ | sed -ne \$p)
 '
=20
+cat >expect <<EOF
+Warning: the command isn't recognized in the following line(s):
+ - badcmd $(git rev-list --oneline -1 master~1)
+
+You can fix this with 'git rebase --edit-todo'.
+Or you can abort the rebase with 'git rebase --abort'.
+EOF
+
+test_expect_success 'static check of bad command' '
+	test_rebase_end tmp2 &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES=3D"1 2 3 bad 4 5" \
+		git rebase -i --root 2>actual &&
+	test_cmp expect actual &&
+	FAKE_LINES=3D"1 2 3 drop 4 5" git rebase --edit-todo &&
+	git rebase --continue &&
+	test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test C =3D $(git cat-file commit HEAD^ | sed -ne \$p)
+'
+
+cat >expect <<EOF
+Warning: the SHA-1 is missing or isn't a commit in the following line(=
s):
+ - edit XXXXXXX False commit
+
+You can fix this with 'git rebase --edit-todo'.
+Or you can abort the rebase with 'git rebase --abort'.
+EOF
+
+test_expect_success 'static check of bad SHA-1' '
+	test_config rebase.missingCommitsCheck error &&
+	test_rebase_end tmp2 &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES=3D"1 2 edit fakesha 3 4 5 #" \
+		git rebase -i --root 2>actual &&
+	test_cmp expect actual &&
+	FAKE_LINES=3D"1 2 4 5 6" git rebase --edit-todo &&
+	git rebase --continue &&
+	test E =3D $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 test_done
--=20
2.4.3.371.g8992f2a
