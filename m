From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 2/4] convert: Keep foreign $Id$ on checkout.
Date: Mon, 15 Mar 2010 16:30:42 +0100
Message-ID: <cff48594f97960444a3cd642dafd7fd4905e6891.1268664693.git.grubba@grubba.org>
References: <cover.1268664693.git.grubba@grubba.org>
 <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 16:31:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrCGY-000382-OW
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 16:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762Ab0COPb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 11:31:28 -0400
Received: from mail.roxen.com ([212.247.29.220]:51925 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab0COPb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 11:31:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id EC6B9628191
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:31:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVqD0ERDCiDh; Mon, 15 Mar 2010 16:31:26 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 2560F62817D;
	Mon, 15 Mar 2010 16:31:26 +0100 (CET)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o2FFVQXX022019;
	Mon, 15 Mar 2010 16:31:26 +0100 (CET)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o2FFVQTj022018;
	Mon, 15 Mar 2010 16:31:26 +0100 (CET)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
In-Reply-To: <cover.1268664693.git.grubba@grubba.org>
References: <cover.1268664693.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142213>

If there are foreign $Id$ keywords in the repository, they are most
likely there for a reason. Let's keep them on checkout (which is also
what the documentation indicates). Foreign $Id$ keywords are now
recognized by there being multiple space separated fields in $Id:xxxxx$=
=2E

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
The typical use case is for repositories that have been converted
from some other VCS, where it is desirable to keep the old identifiers
around until there's some other reason to alter the file.

 convert.c             |   16 ++++++++++++++--
 t/t0021-conversion.sh |    2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index 91207ab..4165385 100644
--- a/convert.c
+++ b/convert.c
@@ -477,7 +477,7 @@ static int ident_to_worktree(const char *path, cons=
t char *src, size_t len,
                              struct strbuf *buf, int ident)
 {
 	unsigned char sha1[20];
-	char *to_free =3D NULL, *dollar, *nl;
+	char *to_free =3D NULL, *dollar, *nl, *spc;
 	int cnt;
=20
 	if (!ident)
@@ -513,7 +513,10 @@ static int ident_to_worktree(const char *path, con=
st char *src, size_t len,
 		} else if (src[2] =3D=3D ':') {
 			/*
 			 * It's possible that an expanded Id has crept its way into the
-			 * repository, we cope with that by stripping the expansion out
+			 * repository, we cope with that by stripping the expansion out.
+			 * This is probably not a good idea, since it will cause changes
+			 * on checkout, which won't go away by stash, but let's keep it
+			 * for git-style ids.
 			 */
 			dollar =3D memchr(src + 3, '$', len - 3);
 			if (!dollar) {
@@ -527,6 +530,15 @@ static int ident_to_worktree(const char *path, con=
st char *src, size_t len,
 				continue;
 			}
=20
+			spc =3D memchr(src + 4, ' ', len - 4);
+			if (spc && spc < dollar-1) {
+				/* There are spaces in unexpected places.
+				 * This is probably an id from some other
+				 * versioning system. Keep it for now.
+				 */
+				continue;
+			}
+
 			len -=3D dollar + 1 - src;
 			src  =3D dollar + 1;
 		} else {
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index a21a8d2..248efcc 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -78,7 +78,7 @@ test_expect_success expanded_in_repo '
 		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
 		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
 		echo "\$Id: NoTerminatingSymbol"
-		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 $"
+		echo "\$Id: Foreign Commit With Spaces $"
 		echo "\$Id: NoTerminatingSymbolAtEOF"
 	} > expected-output &&
=20
--=20
1.6.4.122.g6ffd7
