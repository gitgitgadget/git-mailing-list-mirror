From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 08/13] bash prompt: use bash builtins to find out current
 branch
Date: Tue, 18 Jun 2013 04:17:01 +0200
Message-ID: <1371521826-3225-9-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolUz-00071h-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703Ab3FRCSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:18:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:50620 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab3FRCSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:18:14 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Mhegl-1V15Hy1fJT-00MHmL; Tue, 18 Jun 2013 04:18:13 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:Z9L8CaO7qeL85+ZgSELyPSpOsZ6g0dZQoeVz4ma/MfS
 aq59g62rMFAfcs/eNx0wtrcfEJC2puW6nr8DSGzUZ/6qOkhO23
 Hh6a8OfM6xWygUTRQYSdlZY+Q8fWCjuR3yNzoVh3nZa22RjX7P
 u24+uMMQnhmrvlMcnsruGddbhvLyRMZhUVNqggg9ehCId+Zxk0
 DMQV6e5AJBX4klN+nOOqb9S442rg3eXV3KeIgi4rPPF5fbTKvJ
 u3EibnB9JtG6ghOuaiRKKcoeH9sEpYMLNsxkbMeZwFZJphM8as
 ATQfG01KTqmBPgnDQWd4BzcI/qSAXQ+RSvTwkPnwZW7CCeb/bQ
 LnGVy4rwzWYSIL/Gg++PsnOeIItTsNc6L8GRvcWMILPK/3lWpu
 /hbJIQ5yNhNfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228141>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

__git_ps1() runs the '$(git symbolic-ref HEAD)' command substitution
to find out whether we are on a branch and to find out the name of
that branch.  This imposes the overhead of fork()ing a subshell and
fork()+exec()ing a git process.

Since HEAD is in most cases a single-line file and the symbolic ref
format is quite simple to recognize and parse, read and parse it using
only bash builtins, thereby sparing all that fork()+exec() overhead.
However, HEAD can also be a symlink symbolic ref (due to
'core.preferSymlinkRefs'), so do this only if HEAD is not a symlink.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 46 ++++++++++++++++++++++++--------=
--------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 26380787..4e5c8efa 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -355,25 +355,35 @@ __git_ps1 ()
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
+			read head 2>/dev/null <"$g/HEAD" || return
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
-			b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-			b=3D"unknown"
-			b=3D"($b)"
-		}
+				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
+				b=3D"unknown"
+				b=3D"($b)"
+			fi
+		fi
 	fi
=20
 	if [ -n "$step" ] && [ -n "$total" ]; then
--=20
1.8.3.1.487.g8f4672d
