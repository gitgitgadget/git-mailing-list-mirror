From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] mingw: utime() handles NULL times parameter
Date: Thu,  1 Jul 2010 13:07:45 +0200
Message-ID: <1277982466-29601-1-git-send-email-szeder@ira.uka.de>
References: <4C2C69AF.4010303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 13:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUHcj-00045D-N2
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 13:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044Ab0GALH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 07:07:58 -0400
Received: from francis.fzi.de ([141.21.7.5]:21308 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754017Ab0GALH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 07:07:57 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 1 Jul 2010 13:07:54 +0200
X-Mailer: git-send-email 1.7.2.rc0.54.g4d821
In-Reply-To: <4C2C69AF.4010303@viscovery.net>
X-OriginalArrivalTime: 01 Jul 2010 11:07:54.0409 (UTC) FILETIME=[A7684990:01CB190D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150031>

POSIX sayeth:

  "If times is a null pointer, the access and modification
   times of the file shall be set to the current time."

Let's do so.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On Thu, Jul 01, 2010 at 12:10:55PM +0200, Johannes Sixt wrote:
> Mental note: update mingw_utime to accept NULL for the second paramet=
er...

Here it is, but I don't have mingw, so it's completely untested.

 compat/mingw.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9a8e336..a54db74 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -304,8 +304,14 @@ int mingw_utime (const char *file_name, const stru=
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
+		aft->dwLowDateTime =3D mft->dwLowDateTime;
+		aft->dwHighDateTime =3D mft->dwHighDateTime;
+	}
 	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
 		errno =3D EINVAL;
 		rc =3D -1;
--=20
1.7.2.rc0.54.g4d821
