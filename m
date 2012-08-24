From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Fri, 24 Aug 2012 12:39:54 +0200
Message-ID: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 12:40:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4rJK-0006ct-Fy
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 12:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab2HXKkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 06:40:11 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57131 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab2HXKkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 06:40:08 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0Mb9Rr-1TNkq70JX1-00Kiur; Fri, 24 Aug 2012 12:40:04 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B5AAzrbm9hijYS+CDi+1PeMQX6Q==
Content-Language: de
X-Provags-ID: V02:K0:oT2EVFiqbhuyociAns/toa21SAb+qiAppaNe3PXNgxe
 fj0UmWHNoenXp6ic01qAlPiCBmwc9AIojHYM5QCVXzX9S5xI9H
 zUL2Jj6+TPAauiwRUmtPN8EXO87nnx4uoPCdLB47Cq2DFEDpb8
 Tz6fML1fTOFxSnjZq40QiVmUil+t3Zdnmmyxs/B3lytRkY4Wcc
 FKqX+85JUBHX2ReSq3F16/KHZ1oNtONMr6QBYOTVfQdJPqWhoh
 /R/NVu3esHhIVs1ksIxleisRVYfy61PteIAteKfbF/EIiptECK
 mKQm89J6hCZrc3NmfxneoMr+Ma88Vqv43IVg5XZthOXvyGCZit
 cyCxBa0E3FLPkfET9gJcc0Iq7fYBE6Mg01xJ+gS4CJgqX5X6HF
 EDTJs02uLENrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204202>


Implementation includes getitimer(), but for now it is static.
Supports ITIMER_REAL only.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
May need a header file for ITIMER_*, struct itimerval and the prototypes,
But for now, and the HP NonStop platform this isn't needed, here
<sys/time> has ITIMER_* and struct timeval, and the prototypes can 
vo into git-compat-util.h for now (Patch 2/2) 

 compat/itimer.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 compat/itimer.c

diff --git a/compat/itimer.c b/compat/itimer.c
new file mode 100644
index 0000000..713f1ff
--- /dev/null
+++ b/compat/itimer.c
@@ -0,0 +1,50 @@
+#include "../git-compat-util.h"
+
+static int git_getitimer(int which, struct itimerval *value)
+{
+	int ret = 0;
+
+	switch (which) {
+		case ITIMER_REAL:
+			value->it_value.tv_usec = 0;
+			value->it_value.tv_sec = alarm(0);
+			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
+			break;
+		case ITIMER_VIRTUAL: /* FALLTHRU */
+		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
+		default: errno = EINVAL; ret = -1;
+	}
+	return ret;
+}
+
+int git_setitimer(int which, const struct itimerval *value,
+				struct itimerval *ovalue)
+{
+	int ret = 0;
+
+	if (!value
+		|| value->it_value.tv_usec < 0
+		|| value->it_value.tv_usec > 1000000
+		|| value->it_value.tv_sec < 0) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	else if (ovalue)
+		if (!git_getitimer(which, ovalue))
+			return -1; /* errno set in git_getitimer() */
+
+	else
+	switch (which) {
+		case ITIMER_REAL:
+			alarm(value->it_value.tv_sec +
+				(value->it_value.tv_usec > 0) ? 1 : 0);
+			ret = 0; /* if alarm() fails, we get a SIGLIMIT */
+			break;
+		case ITIMER_VIRTUAL: /* FALLTHRU */
+		case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
+		default: errno = EINVAL; ret = -1;
+	}
+
+	return ret;
+}
-- 
1.7.12
