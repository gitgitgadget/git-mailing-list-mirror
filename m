From: Anders Kaseorg <andersk@ksplice.com>
Subject: [PATCH] apply: Recognize epoch timestamps with : in the timezone
Date: Wed, 29 Sep 2010 16:49:49 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1009291644440.15192@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 22:50:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13bJ-00010h-Ok
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab0I2Ut4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 16:49:56 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54040 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab0I2Ut4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 16:49:56 -0400
Received: by qyk36 with SMTP id 36so1531254qyk.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:49:55 -0700 (PDT)
Received: by 10.224.54.137 with SMTP id q9mr1556525qag.288.1285793392135;
        Wed, 29 Sep 2010 13:49:52 -0700 (PDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id x34sm9896621qci.6.2010.09.29.13.49.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 13:49:51 -0700 (PDT)
X-X-Sender: andersk@dr-wily.mit.edu
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157606>

Some patches have a timezone formatted like =E2=80=98-08:00=E2=80=99 in=
stead of
=E2=80=98-0800=E2=80=99 (e.g. http://lwn.net/Articles/131729/), so git =
apply would
fail to recognize the epoch timestamp of deleted files and would
create empty files instead.  Teach it to support both formats, and add
a test case.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin/apply.c          |    6 ++++--
 t/t4132-apply-removal.sh |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..0fa9a8d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -733,7 +733,7 @@ static int has_epoch_timestamp(const char *nameline=
)
 		" "
 		"[0-2][0-9]:[0-5][0-9]:00(\\.0+)?"
 		" "
-		"([-+][0-2][0-9][0-5][0-9])\n";
+		"([-+][0-2][0-9]):?([0-5][0-9])\n";
 	const char *timestamp =3D NULL, *cp;
 	static regex_t *stamp;
 	regmatch_t m[10];
@@ -765,7 +765,9 @@ static int has_epoch_timestamp(const char *nameline=
)
 	}
=20
 	zoneoffset =3D strtol(timestamp + m[3].rm_so + 1, NULL, 10);
-	zoneoffset =3D (zoneoffset / 100) * 60 + (zoneoffset % 100);
+	if (m[4].rm_so =3D=3D m[3].rm_so + 3)
+		zoneoffset /=3D 100;
+	zoneoffset =3D zoneoffset * 60 + strtol(timestamp + m[4].rm_so, NULL,=
 10);
 	if (timestamp[m[3].rm_so] =3D=3D '-')
 		zoneoffset =3D -zoneoffset;
=20
diff --git a/t/t4132-apply-removal.sh b/t/t4132-apply-removal.sh
index bb1ffe3..a2bc1cd 100755
--- a/t/t4132-apply-removal.sh
+++ b/t/t4132-apply-removal.sh
@@ -30,6 +30,7 @@ test_expect_success setup '
 	epocWest=3D"1969-12-31 16:00:00.000000000 -0800" &&
 	 epocGMT=3D"1970-01-01 00:00:00.000000000 +0000" &&
 	epocEast=3D"1970-01-01 09:00:00.000000000 +0900" &&
+	epocWest2=3D"1969-12-31 16:00:00 -08:00" &&
=20
 	sed -e "s/TS0/$epocWest/" -e "s/TS1/$timeWest/" <c >createWest.patch =
&&
 	sed -e "s/TS0/$epocEast/" -e "s/TS1/$timeEast/" <c >createEast.patch =
&&
@@ -46,6 +47,7 @@ test_expect_success setup '
 	sed -e "s/TS0/$timeWest/" -e "s/TS1/$epocWest/" <d >removeWest.patch =
&&
 	sed -e "s/TS0/$timeEast/" -e "s/TS1/$epocEast/" <d >removeEast.patch =
&&
 	sed -e "s/TS0/$timeGMT/" -e "s/TS1/$epocGMT/" <d >removeGMT.patch &&
+	sed -e "s/TS0/$timeWest/" -e "s/TS1/$epocWest2/" <d >removeWest2.patc=
h &&
=20
 	echo something >something &&
 	>empty
--=20
1.7.3
