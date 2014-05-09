From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH 1/2] utf8.c: use a table for double_width
Date: Fri, 09 May 2014 23:51:38 +0200
Message-ID: <536D4DEA.7070406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kevin@bracey.fi, peter@softwolves.pp.se, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 23:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wisht-0007KJ-NK
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 23:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbaEIVvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 May 2014 17:51:50 -0400
Received: from mout.web.de ([212.227.15.4]:57567 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757441AbaEIVvt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 17:51:49 -0400
Received: from [192.168.209.27] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MD8Au-1WbDj43Efk-00GVyA; Fri, 09 May 2014 23:51:38
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Provags-ID: V03:K0:+aJ0Edhl5FwT2xLRxiNhJGnTmtZ4vjyOPKJ0GEvzjlMvXKWWRAT
 o5hNcF/DqYwCqT83xNp1PX401qBggoDTXIwY37+418enYME87xE48PZDO97BQRrvcbYqv6U
 6u+TTLpEe4y3MfmGc4m9kmyCQOx1bbCQ1X7BC6lKHRrtFM9x4am/qMFRRtrzrHIvd3n0L9f
 eYBs+WyM7jUQlf/lXO5EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248645>

Refactor git_wcwidth() and replace the if-else-if chain.
Use the table double_width which is scanned by the bisearch() function,
which is already used to find combining code points.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 utf8.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/utf8.c b/utf8.c
index 77c28d4..b5d8136 100644
--- a/utf8.c
+++ b/utf8.c
@@ -126,6 +126,19 @@ static int git_wcwidth(ucs_char_t ch)
 		{ 0x1D1AA, 0x1D1AD }, { 0xE0001, 0xE0001 },
 		{ 0xE0020, 0xE007F }, { 0xE0100, 0xE01EF }
 	};
+	static const struct interval double_width[] =3D {
+		{ 0x1100, 0x115F },
+		{ 0x2329, 0x232A },
+		{ 0x2E80, 0x303E },
+		{ 0x3040, 0xA4CF },
+		{ 0xAC00, 0xD7A3 },
+		{ 0xF900, 0xFAFF },
+		{ 0xFE30, 0xFE6F },
+		{ 0xFF00, 0xFF60 },
+		{ 0xFFE0, 0xFFE6 },
+		{ 0x20000, 0x2FFFD },
+		{ 0x30000, 0x3FFFD }
+	};
=20
 	/* test for 8-bit control characters */
 	if (ch =3D=3D 0)
@@ -138,30 +151,12 @@ static int git_wcwidth(ucs_char_t ch)
 				/ sizeof(struct interval) - 1))
 		return 0;
=20
-	/*
-	 * If we arrive here, ch is neither a combining nor a C0/C1
-	 * control character.
-	 */
+	/* binary search in table of double width characters */
+	if (bisearch(ch, double_width, sizeof(double_width)
+				/ sizeof(struct interval) - 1))
+		return 2;
=20
-	return 1 +
-		(ch >=3D 0x1100 &&
-                    /* Hangul Jamo init. consonants */
-		 (ch <=3D 0x115f ||
-		  ch =3D=3D 0x2329 || ch =3D=3D 0x232a ||
-                  /* CJK ... Yi */
-		  (ch >=3D 0x2e80 && ch <=3D 0xa4cf &&
-		   ch !=3D 0x303f) ||
-		  /* Hangul Syllables */
-		  (ch >=3D 0xac00 && ch <=3D 0xd7a3) ||
-		  /* CJK Compatibility Ideographs */
-		  (ch >=3D 0xf900 && ch <=3D 0xfaff) ||
-		  /* CJK Compatibility Forms */
-		  (ch >=3D 0xfe30 && ch <=3D 0xfe6f) ||
-		  /* Fullwidth Forms */
-		  (ch >=3D 0xff00 && ch <=3D 0xff60) ||
-		  (ch >=3D 0xffe0 && ch <=3D 0xffe6) ||
-		  (ch >=3D 0x20000 && ch <=3D 0x2fffd) ||
-		  (ch >=3D 0x30000 && ch <=3D 0x3fffd)));
+	return 1;
 }
=20
 /*
--=20
1.9.2.691.g8d8dc6d
