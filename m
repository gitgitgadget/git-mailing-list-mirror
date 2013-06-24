From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 05/16] bash prompt: print unique detached HEAD abbreviated
 object name
Date: Mon, 24 Jun 2013 18:39:15 +0200
Message-ID: <1372091966-19315-6-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:43:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9rg-000359-Pl
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab3FXQnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:43:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:50894 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab3FXQng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:43:36 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M2CDg-1U1WiK1lTA-00s8F1; Mon, 24 Jun 2013 18:43:28 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:VjdvGycRoAqh5SeVGxgY/syVQ3Mh+SKWa7xBvFwjMnd
 M6MJZOoM53uINQ9YeZEbq+jJZF2wpxZFu8LgcITgTZcKhT3SFM
 toTja00vEgC2XZXWqhJ+6ZYrrTUKTA2HMhytWB6f1ceIaIpjZb
 DzgS1qnkojPtpz02til3sDgf6r/k4pvt3N83iABOUlsmhyovG6
 o1cwOMatfNAMMcwvaYMpH9SPG9dfkI/yvR/ZkKqV+1ZSbEUDit
 xuNTB4ZcHch/uFPpDhF3Jq0HXy6BpIh3yB/AjyAUpKTD4780sw
 7mKqPyIf1mj1DIY4eZLsFhA42jAZpmLKm2NmkBC30t/WsnrceR
 hz8c+0SvUgsw6LJ8rxYSX2joK95axpCSMm1v1CFD2Zm3JeSIyV
 wLnrlEbh8fjPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228856>

When describing a detached HEAD according to the $GIT_PS1_DESCRIBE
environment variable fails, __git_ps1() runs 'cut -c1-7 .git/HEAD' to
show the 7 hexdigits abbreviated commit object name in the prompt.
Obviously, this neither respects core.abbrev nor produces a unique
object name.

=46ix this by using 'git rev-parse --short HEAD' instead and adjust the
corresponding test to use non-standard number of hexdigits.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 2 +-
 t/t9903-bash-prompt.sh           | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 07a6218d..3c5e62bb 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -392,7 +392,7 @@ __git_ps1 ()
 					git describe --tags --exact-match HEAD ;;
 				esac 2>/dev/null)" ||
=20
-				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
+				b=3D"$(git rev-parse --short HEAD 2>/dev/null)..." ||
 				b=3D"unknown"
 				b=3D"($b)"
 			}
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 416e6219..0d53aa6d 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -50,7 +50,8 @@ test_expect_success SYMLINKS 'prompt - branch name - =
symlink symref' '
 '
=20
 test_expect_success 'prompt - detached head' '
-	printf " ((%s...))" $(git log -1 --format=3D"%h" b1^) >expected &&
+	printf " ((%s...))" $(git log -1 --format=3D"%h" --abbrev=3D13 b1^) >=
expected &&
+	test_config core.abbrev 13 &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	__git_ps1 >"$actual" &&
--=20
1.8.3.1.599.g4459181
