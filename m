From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/17] rename_ref(): extract function rename_tmp_log()
Date: Sat, 18 Jan 2014 23:48:58 +0100
Message-ID: <1390085341-2553-15-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiH-0005CE-M7
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbaARWty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:54 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48290 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728AbaARWtp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:45 -0500
X-AuditID: 12074413-b7fc76d000002aba-3b-52db0509b67e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A6.04.10938.9050BD25; Sat, 18 Jan 2014 17:49:45 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN97030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:44 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqMvJejvI4OlcRYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5YsGEeU8Fa4YqN7a9YGhhX
	83cxcnJICJhIrOx7wQxhi0lcuLeeDcQWErjMKLHqITeEfYJJYvGechCbTUBXYlFPMxOILSKg
	JjGx7RALiM0s4CCx+XMjI4gtLOApcX/BRXYQm0VAVeLKmnWsIDavgIvE7BXvgGo4gHYpSKy+
	LgQS5gQKH5l/gQlilbPEzddP2Ccw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZ
	opeaUrqJERImwjsYd52UO8QowMGoxMN7kOl2kBBrYllxZe4hRkkOJiVRXmWQEF9SfkplRmJx
	RnxRaU5q8SFGCQ5mJRHe4A23goR4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2Cy
	MhwcShK8l5iBhgoWpaanVqRl5pQgpJk4OEEEF8gGHqANt0AKeYsLEnOLM9Mhik4xKkqJ8y4B
	SQiAJDJK8+AGwCL6FaM40D/CvPdBqniAyQCu+xXQYCagwSKxN0EGlyQipKQaGBu+PHt7/UO1
	Y8lzpRu3PgstObAh1D4pm+UUk7qTZUGljX2n6gHdD8zxShcDBBPFfxmqe74v3CrGkbDro2dp
	u3jXqbmTz1ouXXfU40jz1pCqCY+UEuIDKj8umOCz8rqDhLJHaL3TNo0lHow/e0WP3+boPFPg
	16/6/3uDhP3b76osBpss2Kc5KLEUZyQaajEXFScCAGxq37vDAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240657>

It's about to become a bit more complex.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 4060ed1..d0fab39 100644
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
