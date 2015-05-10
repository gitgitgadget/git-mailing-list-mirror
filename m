From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] completion: simplify query for config variables
Date: Sun, 10 May 2015 14:50:18 +0200
Message-ID: <1431262218-7304-2-git-send-email-szeder@ira.uka.de>
References: <1431262218-7304-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 14:54:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrQk2-0001Yh-4k
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 14:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbbEJMxx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 08:53:53 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44991 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751196AbbEJMxw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2015 08:53:52 -0400
Received: from x590d7ec1.dyn.telefonica.de ([89.13.126.193] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YrQjs-0001nx-C0; Sun, 10 May 2015 14:53:49 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1431262218-7304-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1431262430.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268730>

To get the name of all config variables in a given section we perform a
'git config --get-regex' query for all config variables containing the
name of that section, and then filter its output through a case stateme=
nt
to throw away those that though contain but don't start with the given
section.

Modify the regex to match only at the beginning, so the case statement
becomes unnecessary and we can get rid of it.  Add a test to check that=
 a
match in the middle doesn't fool us.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 10 +++-------
 t/t9902-completion.sh                  | 12 ++++++++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6973620857..63f960b33d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -745,13 +745,9 @@ __git_compute_porcelain_commands ()
 __git_get_config_variables ()
 {
 	local section=3D"$1" i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "$sectio=
n\..*" 2>/dev/null); do
-		case "$i" in
-		$section.*)
-			i=3D"${i#$section.}"
-			echo "${i/ */}"
-			;;
-		esac
+	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "^$secti=
on\..*" 2>/dev/null); do
+		i=3D"${i#$section.}"
+		echo "${i/ */}"
 	done
 }
=20
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 07f2478c9b..2ba62fbc17 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -370,6 +370,18 @@ test_expect_success '__git_remotes - list remotes =
from $GIT_DIR/remotes and from
 	test_cmp expect actual
 '
=20
+test_expect_success '__git_get_config_variables' '
+	cat >expect <<-EOF &&
+	name-1
+	name-2
+	EOF
+	test_config interesting.name-1 good &&
+	test_config interesting.name-2 good &&
+	test_config subsection.interesting.name-3 bad &&
+	__git_get_config_variables interesting >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '__git_pretty_aliases' '
 	cat >expect <<-EOF &&
 	author
--=20
1.9.5.msysgit.0
