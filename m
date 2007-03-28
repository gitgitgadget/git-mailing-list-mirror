From: Jeff King <peff@peff.net>
Subject: [PATCH] --pretty=format: print fewer <unknown>s
Date: Wed, 28 Mar 2007 18:09:14 -0400
Message-ID: <20070328220914.GA25389@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWgKh-0000yf-0Y
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 00:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933593AbXC1WJR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 18:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933602AbXC1WJR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 18:09:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1319 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933593AbXC1WJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 18:09:16 -0400
Received: (qmail 14794 invoked from network); 28 Mar 2007 22:09:47 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 22:09:47 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2007 18:09:14 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43393>

This makes empty bodies truly empty, and fills in the
default UTF-8 encoding for an empty encoding.

Signed-off-by: Jeff King <peff@peff.net>
---

I think this covers everything that might happen in common practice.

 commit.c                   |    6 ++++--
 t/t6006-rev-list-format.sh |   16 ++++++++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/commit.c b/commit.c
index 754d1b8..e4f1db5 100644
--- a/commit.c
+++ b/commit.c
@@ -895,8 +895,10 @@ static long format_commit_message(const struct com=
mit *commit,
 				xstrndup(msg + i + 9, eol - i - 9);
 		i =3D eol;
 	}
-	if (msg[i])
-		table[IBODY].value =3D xstrdup(msg + i);
+	interp_set_entry(table, IBODY, msg[i] ? msg + i : "");
+
+	if (!table[IENCODING].value)
+		interp_set_entry(table, IENCODING, "UTF-8");
 	for (i =3D 0; i < ARRAY_SIZE(table); i++)
 		if (!table[i].value)
 			interp_set_entry(table, i, "<unknown>");
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index aab17fa..03ef6e0 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -79,9 +79,9 @@ EOF
=20
 test_format encoding %e <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
+UTF-8
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
+UTF-8
 EOF
=20
 test_format subject %s <<'EOF'
@@ -93,9 +93,9 @@ EOF
=20
 test_format body %b <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
+
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
+
 EOF
=20
 test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
@@ -121,9 +121,9 @@ test_format complex-encoding %e <<'EOF'
 commit f58db70b055c5718631e5c61528b28b12090cdea
 iso8859-1
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
+UTF-8
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
+UTF-8
 EOF
=20
 test_format complex-subject %s <<'EOF'
@@ -142,9 +142,9 @@ and it will be encoded in iso8859-1. We should ther=
efore
 include an iso8859 character: =A1bueno!
=20
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
+
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
+
 EOF
=20
 test_done
--=20
1.5.1.rc2.637.ge090-dirty
