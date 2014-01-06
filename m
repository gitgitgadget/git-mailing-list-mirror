From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/17] rename_ref(): extract function rename_tmp_log()
Date: Mon,  6 Jan 2014 14:45:32 +0100
Message-ID: <1389015935-21936-15-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:53:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Acq-00023e-TC
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbaAFNxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:53:49 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43549 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbaAFNxs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:53:48 -0500
X-AuditID: 1207440c-b7f566d000004272-b0-52cab3b8186e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DF.06.17010.8B3BAC25; Mon,  6 Jan 2014 08:46:32 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfPF021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:31 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLtj86kgg/fXTCy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzJt26x1awVrhi9dzXLA2Mq/m7GDk5JARMJFbvfMYEYYtJXLi3nq2LkYtDSOAyo8Tk
	37OZIJxjTBInbp9gBqliE9CVWNTTDNYhIqAmMbHtEAtIEbPAYkaJrmnfGLsYOTiEBTwl5t2u
	AalhEVCV2HjkOFg9r4CrxLPWZewgJRICChKrrwuBhDmBwtOmHWYDsYUEXCTWHHrEMoGRdwEj
	wypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2MkJDi2cH4bZ3MIUYBDkYlHl6P
	ZyeDhFgTy4orcw8xSnIwKYnycq4+FSTEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhJdrAVCONyWx
	siq1KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PBoSTBu2ETUKNgUWp6akVaZk4JQpqJ
	gxNEcIFs4AHaMAOkkLe4IDG3ODMdougUo6KUOO8UkIQASCKjNA9uACz6XzGKA/0jzLsFpIoH
	mDjgul8BDWYCGhwaBza4JBEhJdXA6DW/svZhUgd3edbFOU2S5RufV35Y+WVDyKJfyxyVOhfV
	zW7Vz82yvzzru8K3s/M3GC/5xrf0R6ffZ4XXTZdfzc8r+/SV4VlrferquTuZ7V7OsFg3sTVe
	gM/ui5J9O9NdGYm6p/3uhdvXmFfO7t68V9L448qZSxr1tny1WWd7+GCgwI56vp0q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240009>

It's about to become a bit more complex.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 8a3d3ea..5bc01a7 100644
--- a/refs.c
+++ b/refs.c
@@ -2528,6 +2528,35 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
  */
 #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
 
+static int rename_tmp_log(const char *newrefname)
+{
+	if (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
+		error("unable to create directory for %s", newrefname);
+		return -1;
+	}
+
+ retry:
+	if (rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
+		if (errno==EISDIR || errno==ENOTDIR) {
+			/*
+			 * rename(a, b) when b is an existing
+			 * directory ought to result in ISDIR, but
+			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
+			 */
+			if (remove_empty_directories(git_path("logs/%s", newrefname))) {
+				error("Directory not empty: logs/%s", newrefname);
+				return -1;
+			}
+			goto retry;
+		} else {
+			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
+				newrefname, strerror(errno));
+			return -1;
+		}
+	}
+	return 0;
+}
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2575,30 +2604,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		}
 	}
 
-	if (log && safe_create_leading_directories(git_path("logs/%s", newrefname))) {
-		error("unable to create directory for %s", newrefname);
+	if (log && rename_tmp_log(newrefname))
 		goto rollback;
-	}
 
- retry:
-	if (log && rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
-		if (errno==EISDIR || errno==ENOTDIR) {
-			/*
-			 * rename(a, b) when b is an existing
-			 * directory ought to result in ISDIR, but
-			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
-			 */
-			if (remove_empty_directories(git_path("logs/%s", newrefname))) {
-				error("Directory not empty: logs/%s", newrefname);
-				goto rollback;
-			}
-			goto retry;
-		} else {
-			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
-				newrefname, strerror(errno));
-			goto rollback;
-		}
-	}
 	logmoved = log;
 
 	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
-- 
1.8.5.2
