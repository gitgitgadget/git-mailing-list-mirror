From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] Test code for htonll, ntohll
Date: Thu, 31 Oct 2013 14:26:12 +0100
Message-ID: <201310311426.13657.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ramsay@ramsay1.demon.co.uk, tanoku@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 14:26:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbsGY-00070p-UB
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 14:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab3JaN0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Oct 2013 09:26:23 -0400
Received: from mout.web.de ([212.227.17.11]:63384 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203Ab3JaN0W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 09:26:22 -0400
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Lu4q2-1VlKSh1Td8-011R8i for <git@vger.kernel.org>; Thu,
 31 Oct 2013 14:26:21 +0100
X-Provags-ID: V03:K0:XkXsR6V3SmMD5tRMpb2l5YjuKw0iDpN3q1425NpfoqvfGKRQkoa
 cEotXxSEQP2G3uR60Gi9eaDcaYFElTWkOkXorbJD2dt7A0BnGO2TNZ0WPpKX50I4GwpudqB
 tVvw6D6MkM7gFA2gdUNDCT330nwltXAUayJa5D+73BhHf5e+SCzRPP/q2I6z2AmVFq0j00o
 XAiRtG76lWwR9TsEs9R5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237125>


test-endianess.c adds test code for htonl(), ntohll()
and the recently introduced ntohll() and htonll()

The test is called in t0070

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 .gitignore             |    1 +
 Makefile               |    3 +++
 t/t0070-fundamental.sh |    3 +++
 test-endianess.c       |   58 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 test-endianess.c

diff --git a/.gitignore b/.gitignore
index 66199ed..750e7d8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -183,6 +183,7 @@
 /test-date
 /test-delta
 /test-dump-cache-tree
+/test-endianess
 /test-scrap-cache-tree
 /test-genrandom
 /test-index-version
diff --git a/Makefile b/Makefile
index 07b0626..50957c7 100644
--- a/Makefile
+++ b/Makefile
@@ -555,6 +555,7 @@ TEST_PROGRAMS_NEED_X +=3D test-ctype
 TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
+TEST_PROGRAMS_NEED_X +=3D test-endianess
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
 TEST_PROGRAMS_NEED_X +=3D test-hashmap
 TEST_PROGRAMS_NEED_X +=3D test-index-version
@@ -2275,6 +2276,8 @@ test-date$X: date.o ctype.o
=20
 test-delta$X: diff-delta.o patch-delta.o
=20
+test-endianess$X: test-endianess.c
+
 test-line-buffer$X: vcs-svn/lib.a
=20
 test-parse-options$X: parse-options.o parse-options-cb.o
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 5ed69a6..dc687da 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -33,5 +33,8 @@ test_expect_success 'check for a bug in the regex rou=
tines' '
 	# if this test fails, re-build git with NO_REGEX=3D1
 	test-regex
 '
+test_expect_success 'test endianess, htonll(), ntohll()' '
+	test-endianess
+'
=20
 test_done
diff --git a/test-endianess.c b/test-endianess.c
new file mode 100644
index 0000000..5b49175
--- /dev/null
+++ b/test-endianess.c
@@ -0,0 +1,58 @@
+#include "cache.h"
+
+int main(int argc, char **argv)
+{
+	union {
+		uint8_t  bytes[8];
+		uint32_t word32;
+		uint64_t word64;
+	} wordll;
+	volatile uint64_t word64;
+	volatile uint32_t word32;
+
+	wordll.bytes[0] =3D 0x80;
+	wordll.bytes[1] =3D 0x81;
+	wordll.bytes[2] =3D 0x82;
+	wordll.bytes[3] =3D 0x83;
+	wordll.bytes[4] =3D 0x00;
+	wordll.bytes[5] =3D 0x01;
+	wordll.bytes[6] =3D 0x02;
+	wordll.bytes[7] =3D 0x03;
+
+	word32 =3D htonl(wordll.word32);
+	if (word32 !=3D 0x80818283)
+		die("htonl word32 !=3D 0x80818283");
+
+	word64 =3D htonll(wordll.word64);
+	if (word64 !=3D 0x8081828300010203ULL)
+		die("htonll word64 !=3D 0x8081828300010203");
+
+	word32 =3D ntohl(wordll.word32);
+	if (word32 !=3D 0x80818283)
+		die("ntohl word32 !=3D 0x80818283");
+
+	word64 =3D ntohll(wordll.word64);
+	if (word64 !=3D 0x8081828300010203ULL)
+		die("ntohll word64 !=3D 0x8081828300010203");
+
+	wordll.bytes[0] =3D 0x04;
+	wordll.bytes[4] =3D 0x84;
+
+	word32 =3D htonl(wordll.word32);
+	if (word32 !=3D 0x04818283)
+		die("htonl word32 !=3D 0x04818283");
+
+	word64 =3D htonll(wordll.word64);
+	if (word64 !=3D 0x0481828384010203ULL)
+		die("htonll word64 !=3D 0x0481828384010203");
+
+	word32 =3D ntohl(wordll.word32);
+	if (word32 !=3D 0x04818283)
+		die("ntohl word32 !=3D 0x04818283");
+
+	word64 =3D ntohll(wordll.word64);
+	if (word64 !=3D 0x0481828384010203ULL)
+		die("ntohll word64 !=3D 0x0481828384010203");
+
+	return 0;
+}
--=20
1.7.10.4
