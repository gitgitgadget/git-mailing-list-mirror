From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 12/19] bash prompt: use bash builtins to check whether inside
	git dir
Date: Wed,  9 May 2012 02:44:43 +0200
Message-ID: <1336524290-30023-13-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv3V-0005FO-6N
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab2EIAq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:46:57 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:65321 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974Ab2EIAq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:46:57 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0M9tYC-1SGsRc00bo-00BEGV; Wed, 09 May 2012 02:46:56 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:AuIs1c4HEIfHDU4Q/i/kZf+o7a8jSb/kVn+Z+FmOas/
 a4eva2OIJqjj5USI0Op/xw/JoKRdwN7XVJGlXcCaytjXlq42m4
 oqPU5ClefY2z6+00k29uk+9xgVum7GfzOSMQUqhZhsj+L9aZdi
 ooboI9doPMFbe8abjFTKdO1nMib70MVB+9WXrdAzRAiI0iZil7
 TtB5ud/n4i3yp4XAwFQm5XnCeqnd9a9bkVlzWYAF4BWxnegt+m
 d2XSS1+p0qoJOkNukA3XUV7fOfpmqi5hAFV4GrpDZtG/TjLXXX
 z2Occ2oQbPF4aYC9KqBvrMyh8T2A63yPp5OCpf4On1bVC0oG1M
 hz0/McBvCkkCCDK5Mj5c+yj4md6EqASWjIyoQVlf8nNs4qBomx
 SHcE+ADd8OkZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197444>

__git_ps1() runs the '$(git rev-parse --is-inside-git-dir)' command
substitution to check whether we are inside a .git directory and the
bash prompt needs to be adjusted accordingly (i.e. display 'BARE!' or
'GIT_DIR!').  This imposes the overhead of fork()ing a subshell and
fork()+exec()ing a git process.

Perform this check by comparing the path to the repository and the
current directory using only bash builtins, thereby sparing all that
fork()+exec() overhead.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ed372c41..72f7d0ed 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -323,7 +323,11 @@ __git_ps1 ()
 	local c=3D""
 	local p=3D""
=20
-	if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ];=
 then
+	local pwd_p
+	__git_pwd_p pwd_p
+	# inside .git dir?
+	if [ "$__git_dir" =3D "." -o \
+			"${pwd_p#$__git_dir}" !=3D "$pwd_p" ]; then
 		if [ "true" =3D "$(git rev-parse --is-bare-repository 2>/dev/null)" =
]; then
 			c=3D"BARE:"
 		else
--=20
1.7.10.1.541.gb1be298
