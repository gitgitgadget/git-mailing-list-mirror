From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH] setup.c: Remove duplicate code from prefix_pathspec()
Date: Thu, 14 Mar 2013 01:24:55 +0100
Message-ID: <1363220695-27911-1-git-send-email-git@cryptocrack.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 01:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFvzA-00031e-P8
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 01:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657Ab3CNAZC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 20:25:02 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:29476 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab3CNAZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 20:25:01 -0400
Received: from localhost (p57B459C4.dip.t-dialin.net [87.180.89.196])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 17265fe2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Thu, 14 Mar 2013 01:24:56 +0100 (CET)
X-Mailer: git-send-email 1.8.2.rc2.352.g908df73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218108>

Only check for ',' explicitly and handle both ')' and '\0' in the else
branch. strcspn() can only return ',', ')' and '\0' at this point so th=
e
new code is completely equivalent to what we had before.

This also fixes following GCC warning:

    setup.c: In function =E2=80=98get_pathspec=E2=80=99:
    setup.c:207:8: warning: =E2=80=98nextat=E2=80=99 may be used uninit=
ialized in this function [-Wmaybe-uninitialized]
    setup.c:205:15: note: =E2=80=98nextat=E2=80=99 was declared here

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
This removes the only warning that currently occurs when building the
next branch.

Junio: Feel free to squash this into Andrew's patch (805da4dee15b,
"setup.c: stop prefix_pathspec() from looping past the end of string").

 setup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index d2335a8..94c1e61 100644
--- a/setup.c
+++ b/setup.c
@@ -207,12 +207,11 @@ static const char *prefix_pathspec(const char *pr=
efix, int prefixlen, const char
 		     *copyfrom && *copyfrom !=3D ')';
 		     copyfrom =3D nextat) {
 			size_t len =3D strcspn(copyfrom, ",)");
-			if (copyfrom[len] =3D=3D '\0')
-				nextat =3D copyfrom + len;
-			else if (copyfrom[len] =3D=3D ')')
-				nextat =3D copyfrom + len;
-			else if (copyfrom[len] =3D=3D ',')
+			if (copyfrom[len] =3D=3D ',')
 				nextat =3D copyfrom + len + 1;
+			else
+				/* handle ')' and '\0' */
+				nextat =3D copyfrom + len;
 			if (!len)
 				continue;
 			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
--=20
1.8.2.rc2.352.g908df73
