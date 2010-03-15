From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 1/4] convert: Safer handling of $Id$ contraction.
Date: Mon, 15 Mar 2010 16:30:41 +0100
Message-ID: <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
References: <cover.1268664693.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 16:31:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrCGP-00032R-6x
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 16:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab0COPbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 11:31:24 -0400
Received: from mail.roxen.com ([212.247.29.220]:37766 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab0COPbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 11:31:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id D72E9628191
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:31:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBk1w+Z0Z6uk; Mon, 15 Mar 2010 16:31:20 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id F18D862817D;
	Mon, 15 Mar 2010 16:31:20 +0100 (CET)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o2FFVKKD022015;
	Mon, 15 Mar 2010 16:31:20 +0100 (CET)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o2FFVKbj022014;
	Mon, 15 Mar 2010 16:31:20 +0100 (CET)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <cover.1268664693.git.grubba@grubba.org>
In-Reply-To: <cover.1268664693.git.grubba@grubba.org>
References: <cover.1268664693.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142212>

The code to contract $Id:xxxxx$ strings could eat an arbitrary amount
of source text if the terminating $ was lost. It now refuses to
contract $Id:xxxxx$ strings spanning multiple lines.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
The behaviour implemented by the patch is in line with what other
VCSes that implement $Id$ do.

 convert.c             |   17 +++++++++++++++--
 t/t0021-conversion.sh |   16 ++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

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
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 6cb8d60..a21a8d2 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -65,17 +65,21 @@ test_expect_success expanded_in_repo '
 		echo "\$Id:NoSpaceAtFront \$"
 		echo "\$Id:NoSpaceAtEitherEnd\$"
 		echo "\$Id: NoTerminatingSymbol"
+		echo "\$Id: Foreign Commit With Spaces $"
+		echo "\$Id: NoTerminatingSymbolAtEOF"
 	} > expanded-keywords &&
=20
 	{
 		echo "File with expanded keywords"
-		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
-		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
-		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
-		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
-		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
-		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
+		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
+		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
+		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
+		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
+		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
+		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
 		echo "\$Id: NoTerminatingSymbol"
+		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 $"
+		echo "\$Id: NoTerminatingSymbolAtEOF"
 	} > expected-output &&
=20
 	git add expanded-keywords &&
--=20
1.6.4.122.g6ffd7
