From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 08/16] bash prompt: use bash builtins to find out rebase
 state
Date: Mon, 24 Jun 2013 18:39:18 +0200
Message-ID: <1372091966-19315-9-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:44:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9sB-0003Uh-PD
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab3FXQoE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:44:04 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:58518 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3FXQoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:44:03 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MMLX7-1Uuidr10H7-008d7W; Mon, 24 Jun 2013 18:43:54 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:IEkRQkr/X1pCoaQ+JGrJy9nAProVOcAMeOKyNNnNzLU
 lvbJ9jg8qSVUf7TwQfwFgIGu6ZXu0k+fqJSq6F7cBfw9AGB24U
 ip+0c+pSwIt6/ht4rSQvuI3+zKX4+wd9O4hVMRBx8LOe8XrIrL
 vw5zeEzWXeC53BwrgNPhtJVfPJlKQN1vfQUdMKEd/ra7OLt8oz
 zCDrBRJr7lLS7XiwBKu/WCYq+o2JVrOh5WyetN29LQFqpNIGyl
 LIUMhk3u5a3O6/Wpj72wiAKM7jP32RIc/BFTBAmlLdWQEJ14XX
 pEev/27YOAO5SRBEL/UXfzqL4z7QG3maP0dtb1R+I2yW3IzX1g
 wfDJReYFWnxTLjFiz+BylanXiTg0N286RP8VkPV52i8i53SOnp
 TuyPg1Bnyfv6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228861>

During an ongoing interactive rebase __git_ps1() finds out the name of
the rebased branch, the total number of patches and the number of the
current patch by executing a '$(cat .git/rebase-merge/<FILE>)' command
substitution for each.  That is not quite the most efficient way to
read single line single word files, because it imposes the overhead of
fork()ing a subshell and fork()+exec()ing 'cat' several times.

Use the 'read' bash builtin instead to avoid those overheads.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 0563dea8..bc402f56 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -325,9 +325,9 @@ __git_ps1 ()
 	local step=3D""
 	local total=3D""
 	if [ -d "$g/rebase-merge" ]; then
-		b=3D"$(cat "$g/rebase-merge/head-name" 2>/dev/null)"
-		step=3D$(cat "$g/rebase-merge/msgnum" 2>/dev/null)
-		total=3D$(cat "$g/rebase-merge/end" 2>/dev/null)
+		read b 2>/dev/null <"$g/rebase-merge/head-name"
+		read step 2>/dev/null <"$g/rebase-merge/msgnum"
+		read total 2>/dev/null <"$g/rebase-merge/end"
 		if [ -f "$g/rebase-merge/interactive" ]; then
 			r=3D"|REBASE-i"
 		else
@@ -335,10 +335,10 @@ __git_ps1 ()
 		fi
 	else
 		if [ -d "$g/rebase-apply" ]; then
-			step=3D$(cat "$g/rebase-apply/next" 2>/dev/null)
-			total=3D$(cat "$g/rebase-apply/last" 2>/dev/null)
+			read step 2>/dev/null <"$g/rebase-apply/next"
+			read total 2>/dev/null <"$g/rebase-apply/last"
 			if [ -f "$g/rebase-apply/rebasing" ]; then
-				b=3D"$(cat "$g/rebase-apply/head-name" 2>/dev/null)"
+				read b 2>/dev/null <"$g/rebase-apply/head-name"
 				r=3D"|REBASE"
 			elif [ -f "$g/rebase-apply/applying" ]; then
 				r=3D"|AM"
--=20
1.8.3.1.599.g4459181
