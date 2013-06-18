From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 07/13] bash prompt: use bash builtins to find out rebase
 state
Date: Tue, 18 Jun 2013 04:17:00 +0200
Message-ID: <1371521826-3225-8-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolUs-0006f0-F7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab3FRCSJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:18:09 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:57958 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab3FRCSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:18:07 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0La2FZ-1U36Pb3PYb-00lYrb; Tue, 18 Jun 2013 04:18:07 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:WUNhBoCUquelKzKroVqwV4eCcKdIHYEa9Cywc7zftE9
 Lv1iyq6W64XJr6SThBxusCRla2NYZHcN8RWbMpEOVWBwiGW3Kd
 Nenk5NJwVIos5fzneXUJPCn79djaSaQetJXiSw6hdpNKEFNn2R
 DcAmezaGsyp1yz2QNp19vTij2qtirm8Q+p02FoWUF+8Q1AQ5/w
 7PWkNh2ZQ7h5We73FyPY2/j4fKKHghxOslr0kiMLPpEv3SkRlB
 7Ovd8UvnRYmlk0I+dXmpQQROtXpZOjP8BJ2Tg1VyOcsa/r+C/X
 RuZjGWbNuiqtk5q1bIW5WlWczobZ6cOtyXpYjMPFvcnPplPv0T
 Y3CfGbjqCr6mSMaBDjgFEPNbPWtCd+F8vunbFHW5dUclsNQYDy
 MSIATM8coXKWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228140>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

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
index 0fc1d317..26380787 100644
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
1.8.3.1.487.g8f4672d
