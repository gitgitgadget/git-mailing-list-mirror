From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/2 fixed] mingw_utime(): handle NULL times parameter
Date: Thu, 01 Jul 2010 14:16:24 +0200
Message-ID: <4C2C8718.5080203@viscovery.net>
References: <4C2C69AF.4010303@viscovery.net> <1277982466-29601-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jul 01 14:16:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUIh0-0002PY-PL
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 14:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0GAMQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 08:16:30 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:22242 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab0GAMQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 08:16:29 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OUIgq-0005Dq-TX; Thu, 01 Jul 2010 14:16:25 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A5F731660F;
	Thu,  1 Jul 2010 14:16:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <1277982466-29601-1-git-send-email-szeder@ira.uka.de>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150033>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

POSIX sayeth:

  "If times is a null pointer, the access and modification
   times of the file shall be set to the current time."

Let's do so.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 >> Mental note: update mingw_utime to accept NULL for the second
 >> parameter...
 >=20
 > Here it is, but I don't have mingw, so it's completely untested.

 Thanks. Here is a version that compiles; the interdiff is

 @@ -309,8 +309,7 @@
                 time_t_to_filetime(times->actime, &aft);
         } else {
                 GetSystemTimeAsFileTime(&mft);
 -               aft->dwLowDateTime =3D mft->dwLowDateTime;
 -               aft->dwHighDateTime =3D mft->dwHighDateTime;
 +               aft =3D mft;
         }
         if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)=
) {
                 errno =3D EINVAL;

 With this, the series passes the test suite on MinGW.

 -- Hannes

 compat/mingw.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0722a6d..b6f0a7f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -304,8 +304,13 @@ int mingw_utime (const char *file_name, const stru=
ct utimbuf *times)
 		goto revert_attrs;
 	}
=20
-	time_t_to_filetime(times->modtime, &mft);
-	time_t_to_filetime(times->actime, &aft);
+	if (times) {
+		time_t_to_filetime(times->modtime, &mft);
+		time_t_to_filetime(times->actime, &aft);
+	} else {
+		GetSystemTimeAsFileTime(&mft);
+		aft =3D mft;
+	}
 	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
 		errno =3D EINVAL;
 		rc =3D -1;
--=20
1.7.2.rc1.1057.g1270
