From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/20] rename_tmp_log(): use raceproof_create_file()
Date: Tue, 16 Feb 2016 14:22:18 +0100
Message-ID: <a19192cb3219de9304af7d9b97be45a5e6f0895f.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjh-0004PL-FQ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbcBPNcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:32:04 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64171 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932366AbcBPNa3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:29 -0500
X-AuditID: 1207440d-6a3ff7000000068f-19-56c322ae179d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F5.B2.01679.EA223C65; Tue, 16 Feb 2016 08:22:54 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOR028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:52 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLtO6XCYwe5pPBbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8aSu93sBd1iFe2zHRsYlwl2MXJySAiYSEw7MIGx
	i5GLQ0hgK6PE2TVPmSGcE0wSG/quM4JUsQnoSizqaWYCsUUE1CQmth1iASliFnjEKNG1fztY
	kbCAi8TH1+uYQWwWAVWJPT0XweK8AlEST9/MYoVYJyfR8mM3mM0pYCFxsqWXBcQWEjCXuPNl
	D9MERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MUJCjHcH4/91MocY
	BTgYlXh4OTwOhQmxJpYVV+YeYpTkYFIS5eXhPhwmxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3
	3yugct6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG+HItBQwaLU9NSK
	tMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAMxBcDowAkxQO0Nw2knbe4IDEXKArReopRUUqc
	1wUkIQCSyCjNgxsLSxyvGMWBvhTmPQ5SxQNMOnDdr4AGMwENzrkE8lBxSSJCSqqB0cxW67D1
	scxXqt979zwPFThux7x2TkrRZOuUS0wStjaXtq/kXJqWPFHoU0nE2Zyi1QrLzwU+0bn1PvKZ
	/PRDZ9db3Kvb8N5pj8WirhaFWxZuk9Lbk0tnpTNfmOUZt3Y2Q8701NBPfjpHV2hJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286399>

Besides shortening the code, this saves an unnecessary call to
safe_create_leading_directories_const() in almost all cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 76 ++++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a549942..e5f964c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2400,55 +2400,43 @@ out:
  */
 #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
 
+static int rename_tmp_log_callback(const char *path, void *cb)
+{
+	int *true_errno = cb;
+
+	if (rename(git_path(TMP_RENAMED_LOG), path)) {
+		/*
+		 * rename(a, b) when b is an existing directory ought
+		 * to result in ISDIR, but Solaris 5.8 gives ENOTDIR.
+		 * Sheesh. Record the true errno for error reporting,
+		 * but report EISDIR to raceproof_create_file() so
+		 * that it knows to retry.
+		 */
+		*true_errno = errno;
+		if (errno==ENOTDIR)
+			errno = EISDIR;
+		return -1;
+	} else {
+		return 0;
+	}
+}
+
 static int rename_tmp_log(const char *newrefname)
 {
-	int attempts_remaining = 4;
-	struct strbuf path = STRBUF_INIT;
-	int ret = -1;
+	char *path = git_pathdup("logs/%s", newrefname);
+	int true_errno;
+	int ret;
 
- retry:
-	strbuf_reset(&path);
-	strbuf_git_path(&path, "logs/%s", newrefname);
-	switch (safe_create_leading_directories_const(path.buf)) {
-	case SCLD_OK:
-		break; /* success */
-	case SCLD_VANISHED:
-		if (--attempts_remaining > 0)
-			goto retry;
-		/* fall through */
-	default:
-		error("unable to create directory for %s", newrefname);
-		goto out;
-	}
-
-	if (rename(git_path(TMP_RENAMED_LOG), path.buf)) {
-		if ((errno==EISDIR || errno==ENOTDIR) && --attempts_remaining > 0) {
-			/*
-			 * rename(a, b) when b is an existing
-			 * directory ought to result in ISDIR, but
-			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
-			 */
-			if (remove_empty_directories(&path)) {
-				error("Directory not empty: logs/%s", newrefname);
-				goto out;
-			}
-			goto retry;
-		} else if (errno == ENOENT && --attempts_remaining > 0) {
-			/*
-			 * Maybe another process just deleted one of
-			 * the directories in the path to newrefname.
-			 * Try again from the beginning.
-			 */
-			goto retry;
-		} else {
+	ret = raceproof_create_file(path, rename_tmp_log_callback, &true_errno);
+	if (ret) {
+		if (true_errno==EISDIR)
+			error("Directory not empty: %s", path);
+		else
 			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
-				newrefname, strerror(errno));
-			goto out;
-		}
+				newrefname, strerror(true_errno));
 	}
-	ret = 0;
-out:
-	strbuf_release(&path);
+
+	free(path);
 	return ret;
 }
 
-- 
2.7.0
