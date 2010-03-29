From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH 1/5] convert: Safer handling of $Id$ contraction.
Date: Mon, 29 Mar 2010 13:28:55 +0200
Message-ID: <a75a46b1b6fdb9d52f608643676512e87474e16d.1269860022.git.grubba@grubba.org>
References: <cover.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 13:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwD9h-0005ax-OK
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 13:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab0C2L3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 07:29:10 -0400
Received: from mail.roxen.com ([212.247.29.220]:49856 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426Ab0C2L3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 07:29:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 31995628255
	for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:29:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K8isGE+sx78w; Mon, 29 Mar 2010 13:29:04 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id F3C0C628254;
	Mon, 29 Mar 2010 13:29:03 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o2TBT3vs006175;
	Mon, 29 Mar 2010 13:29:03 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o2TBT377006174;
	Mon, 29 Mar 2010 13:29:03 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <cover.1269860022.git.grubba@grubba.org>
In-Reply-To: <cover.1269860022.git.grubba@grubba.org>
References: <cover.1269860022.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143457>

The code to contract $Id:xxxxx$ strings could eat an arbitrary amount
of source text if the terminating $ was lost. It now refuses to
contract $Id:xxxxx$ strings spanning multiple lines.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
The behaviour implemented by the patch is in line with what other
VCSes that implement $Id$ do.

=46ixes quoting portability issue remarked on by Bert Wesarg
<bert.wesarg@googlemail.com>.
Implemented some optimizations suggested by Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx>.

 convert.c             |   12 ++++++++++++
 t/t0021-conversion.sh |   16 ++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 4f8fcb7..239fa0a 100644
--- a/convert.c
+++ b/convert.c
@@ -425,6 +425,8 @@ static int count_ident(const char *cp, unsigned lon=
g size)
 				cnt++;
 				break;
 			}
+			if (ch =3D=3D '\n')
+				break;
 		}
 	}
 	return cnt;
@@ -455,6 +457,11 @@ static int ident_to_git(const char *path, const ch=
ar *src, size_t len,
 			dollar =3D memchr(src + 3, '$', len - 3);
 			if (!dollar)
 				break;
+			if (memchr(src + 3, '\n', dollar - src - 3)) {
+				/* Line break before the next dollar. */
+				continue;
+			}
+
 			memcpy(dst, "Id$", 3);
 			dst +=3D 3;
 			len -=3D dollar + 1 - src;
@@ -514,6 +521,11 @@ static int ident_to_worktree(const char *path, con=
st char *src, size_t len,
 				break;
 			}
=20
+			if (memchr(src + 3, '\n', dollar - src - 3)) {
+				/* Line break before the next dollar. */
+				continue;
+			}
+
 			len -=3D dollar + 1 - src;
 			src  =3D dollar + 1;
 		} else {
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 6cb8d60..29438c5 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -65,17 +65,21 @@ test_expect_success expanded_in_repo '
 		echo "\$Id:NoSpaceAtFront \$"
 		echo "\$Id:NoSpaceAtEitherEnd\$"
 		echo "\$Id: NoTerminatingSymbol"
+		echo "\$Id: Foreign Commit With Spaces \$"
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
+		echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 \$"
+		echo "\$Id: NoTerminatingSymbolAtEOF"
 	} > expected-output &&
=20
 	git add expanded-keywords &&
--=20
1.6.4.122.g6ffd7
