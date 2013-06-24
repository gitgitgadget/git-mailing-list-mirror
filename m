From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 09/16] bash prompt: use bash builtins to find out current
 branch
Date: Mon, 24 Jun 2013 18:39:19 +0200
Message-ID: <1372091966-19315-10-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:44:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9sC-0003Uh-9r
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab3FXQoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:44:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:58924 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3FXQoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:44:07 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MAASz-1Uy0RI3x5V-00B3os; Mon, 24 Jun 2013 18:44:06 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:PsNs0L+6sECQ0uhZk1/JIq0imZEwbpFdw2FHmUdcso1
 UkS2l8JVkLTlGcZ3Z0lCMAzdx7YiSktzVjAhhMUzRvky1EW3mN
 5DtKGWmVbnI/rmFPcYtlgUYUkOV9tEtWS0/wem49PF3v6HjoFP
 zvJTC1Ik2ghaJdy3gMH+TLIUapohst34uW/qL4OC03oRuEL8Dc
 bY2EBMsbIPLswp78DfC/jGm5D0THMugHXG38oX3NVfPM/fMkHT
 E25LqEWhEHvbdpDSf9gaZR8xyvarnRFuz5cHd0+Ha8Em4NIv5s
 7ozNdRHSJCMPFcDsmzmxFKnmEp1fsRWZweTrGEooE2BjVcWPz8
 AVWqCVNYlxl1BBYy+XbqHDYJwM3OXJ4XkBI1qIySkUyYPEmgUu
 pRpVd80eO8egg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228860>

__git_ps1() runs the '$(git symbolic-ref HEAD)' command substitution
to find out whether we are on a branch and to find out the name of
that branch.  This imposes the overhead of fork()ing a subshell and
fork()+exec()ing a git process.

Since HEAD is in most cases a single-line file and the symbolic ref
format is quite simple to recognize and parse, read and parse it using
only bash builtins, thereby sparing all that fork()+exec() overhead.
Don't display the git prompt if reading HEAD fails, because a readable
HEAD is required for a git repository.  HEAD can also be a symlink
symbolic ref (due to 'core.preferSymlinkRefs'), so use bash builtins
for reading HEAD only when HEAD is not a symlink.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 51 ++++++++++++++++++++++++++------=
--------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index bc402f56..c2050b69 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -355,25 +355,40 @@ __git_ps1 ()
 			r=3D"|BISECTING"
 		fi
=20
-		test -n "$b" ||
-		b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
-			detached=3Dyes
-			b=3D"$(
-			case "${GIT_PS1_DESCRIBE_STYLE-}" in
-			(contains)
-				git describe --contains HEAD ;;
-			(branch)
-				git describe --contains --all HEAD ;;
-			(describe)
-				git describe HEAD ;;
-			(* | default)
-				git describe --tags --exact-match HEAD ;;
-			esac 2>/dev/null)" ||
+		if [ -n "$b" ]; then
+			:
+		elif [ -h "$g/HEAD" ]; then
+			# symlink symbolic ref
+			b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
+		else
+			local head=3D""
+			if ! read head 2>/dev/null <"$g/HEAD"; then
+				if [ $pcmode =3D yes ]; then
+					PS1=3D"$ps1pc_start$ps1pc_end"
+				fi
+				return
+			fi
+			# is it a symbolic ref?
+			b=3D"${head#ref: }"
+			if [ "$head" =3D "$b" ]; then
+				detached=3Dyes
+				b=3D"$(
+				case "${GIT_PS1_DESCRIBE_STYLE-}" in
+				(contains)
+					git describe --contains HEAD ;;
+				(branch)
+					git describe --contains --all HEAD ;;
+				(describe)
+					git describe HEAD ;;
+				(* | default)
+					git describe --tags --exact-match HEAD ;;
+				esac 2>/dev/null)" ||
=20
-			b=3D"$(git rev-parse --short HEAD 2>/dev/null)..." ||
-			b=3D"unknown"
-			b=3D"($b)"
-		}
+				b=3D"$(git rev-parse --short HEAD 2>/dev/null)..." ||
+				b=3D"unknown"
+				b=3D"($b)"
+			fi
+		fi
 	fi
=20
 	if [ -n "$step" ] && [ -n "$total" ]; then
--=20
1.8.3.1.599.g4459181
