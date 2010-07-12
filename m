From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] mingw_utime(): handle NULL times parameter
Date: Tue, 13 Jul 2010 01:42:03 +0200
Message-ID: <1278978124-3035-1-git-send-email-szeder@ira.uka.de>
References: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 01:42:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYSeF-0000b5-DV
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 01:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab0GLXmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 19:42:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:61733 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab0GLXms (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 19:42:48 -0400
Received: from [127.0.1.1] (p5B130E72.dip0.t-ipconnect.de [91.19.14.114])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MYtGN-1Oc5ec2j7T-00V79F; Tue, 13 Jul 2010 01:42:34 +0200
X-Mailer: git-send-email 1.7.2.rc2.37.g5e8ef
In-Reply-To: <7vlj9lo6w6.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:DLJILj99/MyzZutpmYI9cwGSx4roevVf0kfyr5t8m+Y
 QM2vKEgkVDUV87ZbiY9+00tmUz05qJII/SAd8qtwMx1iikKJ7d
 pw066rLo9n/J0aY+u5waZT3e/jpjM4+ctVLXZQ3LSBuN2P5yVO
 RWQGmMVDNONA8POCZjllnigielwVR8o2escC/ol+TUbOpMuTBe
 0e5XB/SLdYE3R1r9GcDZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150853>

POSIX sayeth:

  "If times is a null pointer, the access and modification
   times of the file shall be set to the current time."

Let's do so.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9a8e336..24333cb 100644
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
1.7.2.rc2.37.g5e8ef
