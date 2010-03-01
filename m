From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m?= <grubba@grubba.org>
Subject: [PATCH 1/4] convert: Safer handling of $Id$ contraction.
Date: Mon,  1 Mar 2010 17:16:55 +0100
Message-ID: <1267460218-1172-1-git-send-email-grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 17:50:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm8p4-0001P2-7J
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 17:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab0CAQt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 11:49:57 -0500
Received: from mail.roxen.com ([212.247.29.220]:40209 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab0CAQty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 11:49:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 9DD9A6280CB
	for <git@vger.kernel.org>; Mon,  1 Mar 2010 17:17:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQZ3X-UXyG2Q; Mon,  1 Mar 2010 17:17:03 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 7FCD0628093;
	Mon,  1 Mar 2010 17:17:03 +0100 (CET)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o21GH3Jr001219;
	Mon, 1 Mar 2010 17:17:03 +0100 (CET)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o21GH3wj001218;
	Mon, 1 Mar 2010 17:17:03 +0100 (CET)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141329>

=46rom: Henrik Grubbstr=C3=B6m (Grubba) <grubba@grubba.org>

The code to contract $Id:xxxxx$ strings could eat an arbitrary amount
of source text if the terminating $ was lost. It now refuses to
contract $Id:xxxxx$ strings spanning multiple lines.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 convert.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 4f8fcb7..91207ab 100644
--- a/convert.c
+++ b/convert.c
@@ -425,6 +425,7 @@ static int count_ident(const char *cp, unsigned lon=
g size)
 				cnt++;
 				break;
 			}
+			if (ch =3D=3D '\n') break;
 		}
 	}
 	return cnt;
@@ -433,7 +434,7 @@ static int count_ident(const char *cp, unsigned lon=
g size)
 static int ident_to_git(const char *path, const char *src, size_t len,
                         struct strbuf *buf, int ident)
 {
-	char *dst, *dollar;
+	char *dst, *dollar, *nl;
=20
 	if (!ident || !count_ident(src, len))
 		return 0;
@@ -455,6 +456,12 @@ static int ident_to_git(const char *path, const ch=
ar *src, size_t len,
 			dollar =3D memchr(src + 3, '$', len - 3);
 			if (!dollar)
 				break;
+			nl =3D memchr(src + 3, '\n', len - 3);
+			if (nl && nl < dollar) {
+				/* Line break before the next dollar. */
+				continue;
+			}
+
 			memcpy(dst, "Id$", 3);
 			dst +=3D 3;
 			len -=3D dollar + 1 - src;
@@ -470,7 +477,7 @@ static int ident_to_worktree(const char *path, cons=
t char *src, size_t len,
                              struct strbuf *buf, int ident)
 {
 	unsigned char sha1[20];
-	char *to_free =3D NULL, *dollar;
+	char *to_free =3D NULL, *dollar, *nl;
 	int cnt;
=20
 	if (!ident)
@@ -514,6 +521,12 @@ static int ident_to_worktree(const char *path, con=
st char *src, size_t len,
 				break;
 			}
=20
+			nl =3D memchr(src + 3, '\n', len - 3);
+			if (nl && nl < dollar) {
+				/* Line break before the next dollar. */
+				continue;
+			}
+
 			len -=3D dollar + 1 - src;
 			src  =3D dollar + 1;
 		} else {
--=20
1.6.4.122.g6ffd7
