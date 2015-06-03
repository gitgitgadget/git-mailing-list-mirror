From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFCv4 1/2] git-rebase -i: add command "drop" to remove a commit
Date: Wed,  3 Jun 2015 13:44:18 +0200
Message-ID: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 03 13:52:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z07Di-0004Cx-1y
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 13:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbbFCLwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 07:52:22 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:52270 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754422AbbFCLo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 07:44:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5F9ED35EC;
	Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4RssRT78T8bM; Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3D1AB3243;
	Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 3038720E4;
	Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PatakYbxCVhj; Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.grenet.fr (eduroam-033187.grenet.fr [130.190.33.187])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 0500D20DF;
	Wed,  3 Jun 2015 13:44:22 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.389.geaf7ccf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270678>

Instead of removing a line to remove the commit, you can use the
command "drop" (just like "pick" or "edit"). It has the same effect as
deleting the line (removing the commit) except that you keep a visual
trace of your actions, allowing a better control and reducing the
possibility of removing a commit by mistake.

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 Documentation/git-rebase.txt  |  3 +++
 git-rebase--interactive.sh    | 18 ++++++++++++++++++
 t/lib-rebase.sh               |  4 ++--
 t/t3404-rebase-interactive.sh | 10 ++++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 1d01baa..9cf3760 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -514,6 +514,9 @@ rebasing.
 If you just want to edit the commit message for a commit, replace the
 command "pick" with the command "reword".
=20
+To drop a commit, replace the command "pick" with "drop", or just
+delete its line.
+
 If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..869cc60 100644
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
@@ -508,6 +509,23 @@ do_next () {
 	"$comment_char"*|''|noop)
 		mark_action_done
 		;;
+	drop|d)
+		if test -z $sha1
+		then
+			warn "Missing SHA-1 in 'drop' command."
+			die "Please fix this using 'git rebase --edit-todo'."
+		fi
+
+		sha1_verif=3D"$(git rev-parse --verify --quiet $sha1^{commit})"
+		if test -z $sha1_verif
+		then
+			warn "'$sha1' is not a SHA-1 or does not represent" \
+				"a commit in 'drop' command."
+			die "Please fix this using 'git rebase --edit-todo'."
+		fi
+
+		mark_action_done
+		;;
 	pick|p)
 		comment_for_reflog pick
=20
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
index ac429a0..8960083 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1102,4 +1102,14 @@ test_expect_success 'rebase -i commits that over=
write untracked files (no ff)' '
 	test $(git cat-file commit HEAD | sed -ne \$p) =3D I
 '
=20
+test_expect_success 'drop' '
+	test_when_finished "git checkout master" &&
+	git checkout -b dropBranchTest master &&
+	set_fake_editor &&
+	FAKE_LINES=3D"1 drop 2 3 drop 4 5" git rebase -i --root &&
+	test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test C =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
+'
+
 test_done
--=20
2.4.2.389.geaf7ccf
