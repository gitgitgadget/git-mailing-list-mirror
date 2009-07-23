From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Trailing whitespace and no newline fix
Date: Wed, 22 Jul 2009 19:24:38 -0500
Message-ID: <1248308678-23280-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 02:24:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTm7E-0007eX-8O
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 02:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbZGWAYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 20:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbZGWAYt
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 20:24:49 -0400
Received: from francis.fzi.de ([141.21.7.5]:1782 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751446AbZGWAYt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 20:24:49 -0400
Received: from localhost.localdomain ([141.21.16.6]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Jul 2009 02:24:48 +0200
X-Mailer: git-send-email 1.6.4.rc1.73.ga0daf
X-OriginalArrivalTime: 23 Jul 2009 00:24:48.0556 (UTC) FILETIME=[FCC21EC0:01CA0B2B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123815>

If a patch adds a new line to the end of a file and this line ends with
one trailing whitespace character and has no newline, then
'--whitespace=3Dfix' currently does not remove that trailing whitespace=
=2E

This patch fixes this by removing the check for trailing whitespace at
the end of the line at a hardcoded offset which does not take the
eventual absence of newline into account.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t4124-apply-ws-rule.sh |   18 ++++++++++++++++++
 ws.c                     |    5 ++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index f83322e..5698a9a 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -148,4 +148,22 @@ do
 	done
 done
=20
+create_patch () {
+	sed -e "s/_/ /" <<-\EOF
+		diff --git a/target b/target
+		index e69de29..8bd6648 100644
+		--- a/target
+		+++ b/target
+		@@ -0,0 +1 @@
+		+A line with trailing whitespace and no newline_
+		\ No newline at end of file
+	EOF
+}
+
+test_expect_success 'trailing whitespace & no newline at the end of fi=
le' '
+	>target &&
+	create_patch | git apply --whitespace=3Dfix - &&
+	grep "newline$" target
+'
+
 test_done
diff --git a/ws.c b/ws.c
index b1efcd9..9c20acd 100644
--- a/ws.c
+++ b/ws.c
@@ -259,9 +259,8 @@ int ws_fix_copy(char *dst, const char *src, int len=
, unsigned ws_rule, int *erro
 	/*
 	 * Strip trailing whitespace
 	 */
-	if ((ws_rule & WS_TRAILING_SPACE) &&
-	    (2 <=3D len && isspace(src[len-2]))) {
-		if (src[len - 1] =3D=3D '\n') {
+	if (ws_rule & WS_TRAILING_SPACE) {
+		if (1 < len && src[len - 1] =3D=3D '\n') {
 			add_nl_to_tail =3D 1;
 			len--;
 			if (1 < len && src[len - 1] =3D=3D '\r') {
--=20
1.6.4.rc1.73.ga0daf
