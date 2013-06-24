From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 13/16] bash prompt: use bash builtins to check stash state
Date: Mon, 24 Jun 2013 18:39:23 +0200
Message-ID: <1372091966-19315-14-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9tL-0004UP-Rh
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab3FXQpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:45:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:63981 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab3FXQpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:45:18 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0La0Mr-1UQ2cF3LQb-00lgXQ; Mon, 24 Jun 2013 18:45:11 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:m4XTtTo9L73rIICTTIYj2jup1eMC5he40LhpUMtjLaN
 KPPQQaPsmKA2c+43aLneu03t8LwDyMmY/96lt6fKRNcbXgw/BR
 OQm1B8p2xYZuVKxmaPIoeAJgv0kQtl2ol6luisa07jSEDYocFQ
 KcA+3XJaBgKANNYcGrLrYIWmaTNZtokfgJjQ7ViPH6zFbT3tVX
 dXLwc92lnHHhV6JoP7P0ek8k5ZFsjvU/t2vO2xx5DiwVg/YQGp
 ck05nhBrOxLSZXgF61r1250fBsmZIrH+PNrO1aaoXB3IP7QYf/
 mv8i6RywBK0DVM17w0HCNfZMfBGrYd7hFZG4D/P7xB5i+yfAAV
 mP9s3D2FMeVXf+v8qwZSr8p404sR8Sp9UBaGdlmM3vNdtj6Q0R
 7bcpUuAL5+YnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228865>

When the environment variable $GIT_PS1_SHOWSTASHSTATE is set
__git_ps1() checks the presence of stashes by running 'git rev-parse
--verify refs/stash'.  This command not only checks that the
'refs/stash' ref exists but also, well, verifies that it's a valid
ref.

However, we don't need to be that thorough for the bash prompt.  We
can omit that verification and only check whether 'refs/stash' exists
or not.  Since 'git pack-refs' never packs 'refs/stash', it's a matter
of checking the existence of a ref file.  Perform this check using
only bash builtins to spare the overhead of fork()+exec()ing a git
process.

Also run 'git pack-refs --all' in the corresponding test to document
that the prompt script depends on 'git pack-refs' not packing
'refs/stash' and to catch possible breakages should this behavior ever
change.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 5 +++--
 t/t9903-bash-prompt.sh           | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 6e8f486e..afa86703 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -435,8 +435,9 @@ __git_ps1 ()
 				i=3D"#"
 			fi
 		fi
-		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-			git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
+		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
+		   [ -r "$g/refs/stash" ]; then
+			s=3D"$"
 		fi
=20
 		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index b9895c79..c05458cb 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -328,6 +328,7 @@ test_expect_success 'prompt - stash status indicato=
r - stash' '
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
+	git pack-refs --all &&
 	(
 		GIT_PS1_SHOWSTASHSTATE=3Dy &&
 		__git_ps1 >"$actual"
--=20
1.8.3.1.599.g4459181
