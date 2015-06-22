From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a commit
Date: Mon, 22 Jun 2015 23:42:47 +0200
Message-ID: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Mon Jun 22 23:43:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z79Ur-0000w7-Kg
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbbFVVnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 17:43:09 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:33682 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbbFVVnH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 17:43:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2316528CB;
	Mon, 22 Jun 2015 23:43:05 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kmcjADuGs7GP; Mon, 22 Jun 2015 23:43:05 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id EBC9E2890;
	Mon, 22 Jun 2015 23:43:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id D6D7620DC;
	Mon, 22 Jun 2015 23:43:04 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HAzsZljy0jJR; Mon, 22 Jun 2015 23:43:04 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.univnautes.lan (eduspot-condillac.crous-grenoble.fr [193.52.241.183])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B138E20D2;
	Mon, 22 Jun 2015 23:43:04 +0200 (CEST)
X-Mailer: git-send-email 2.4.3.371.g8992f2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272420>

Instead of removing a line to remove the commit, you can use the
command "drop" (just like "pick" or "edit"). It has the same effect as
deleting the line (removing the commit) except that you keep a visual
trace of your actions, allowing a better control and reducing the
possibility of removing a commit by mistake.

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 Documentation/git-rebase.txt  |  3 +++
 git-rebase--interactive.sh    |  3 ++-
 t/lib-rebase.sh               |  4 ++--
 t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 1d01baa..34bd070 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -514,6 +514,9 @@ rebasing.
 If you just want to edit the commit message for a commit, replace the
 command "pick" with the command "reword".
=20
+To drop a commit, replace the command "pick" with "drop", or just
+delete the matching line.
+
 If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..72abf90 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -152,6 +152,7 @@ Commands:
  s, squash =3D use commit, but meld into previous commit
  f, fixup =3D like "squash", but discard this commit's log message
  x, exec =3D run command (the rest of the line) using shell
+ d, drop =3D remove commit
=20
 These lines can be re-ordered; they are executed from top to bottom.
=20
@@ -505,7 +506,7 @@ do_next () {
 	rm -f "$msg" "$author_script" "$amend" "$state_dir"/stopped-sha || ex=
it
 	read -r command sha1 rest < "$todo"
 	case "$command" in
-	"$comment_char"*|''|noop)
+	"$comment_char"*|''|noop|drop|d)
 		mark_action_done
 		;;
 	pick|p)
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6bd2522..fdbc900 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -14,7 +14,7 @@
 #       specified line.
 #
 #   "<cmd> <lineno>" -- add a line with the specified command
-#       ("squash", "fixup", "edit", or "reword") and the SHA1 taken
+#       ("squash", "fixup", "edit", "reword" or "drop") and the SHA1 t=
aken
 #       from the specified line.
 #
 #   "exec_cmd_with_args" -- add an "exec cmd with args" line.
@@ -46,7 +46,7 @@ set_fake_editor () {
 	action=3Dpick
 	for line in $FAKE_LINES; do
 		case $line in
-		squash|fixup|edit|reword)
+		squash|fixup|edit|reword|drop)
 			action=3D"$line";;
 		exec*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index ac429a0..ecd277c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1102,4 +1102,20 @@ test_expect_success 'rebase -i commits that over=
write untracked files (no ff)' '
 	test $(git cat-file commit HEAD | sed -ne \$p) =3D I
 '
=20
+test_rebase_end () {
+	test_when_finished "git checkout master &&
+	git branch -D $1 &&
+	test_might_fail git rebase --abort" &&
+	git checkout -b $1 master
+}
+
+test_expect_success 'drop' '
+	test_rebase_end dropTest &&
+	set_fake_editor &&
+	FAKE_LINES=3D"1 drop 2 3 drop 4 5" git rebase -i --root &&
+	test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test C =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
+'
+
 test_done
--=20
2.4.3.371.g8992f2a
