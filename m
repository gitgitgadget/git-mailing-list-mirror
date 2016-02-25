From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/20] rename_tmp_log(): use raceproof_create_file()
Date: Thu, 25 Feb 2016 14:16:04 +0100
Message-ID: <df9cf93f627da4df7060886552b3220a86586767.1456405698.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:16:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvmg-0003gV-Sf
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760308AbcBYNQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:41 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64389 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759101AbcBYNQk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:40 -0500
X-AuditID: 1207440e-c03ff70000000398-70-56cefeb528b3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 8E.6A.00920.5BEFEC65; Thu, 25 Feb 2016 08:16:37 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrj024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:36 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLvt37kwg8tnOSzmbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyF3x8wFvSLVRxc/IWpgXGZYBcjB4eEgIlE+9TE
	LkYuDiGBrYwSHQc7mCGcE0wSR24+Zexi5ORgE9CVWNTTzARiiwioSUxsO8QCUsQs8IhRomv/
	dkaQScIC7hIrNxaD1LAIqEo8n7gJrJdXIErid/d+sF4JATmJlh+7WUFsTgELiYsnpzOD2EIC
	5hKrbuxhn8DIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSIDx7WBs
	Xy9ziFGAg1GJhzfi99kwIdbEsuLK3EOMkhxMSqK8e56fCxPiS8pPqcxILM6ILyrNSS0+xCjB
	wawkwrviL1CONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB++8PUKNg
	UWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KALii4ExAJLiAdr7A6Sdt7ggMRcoCtF6
	ilFRSpx3OchBAiCJjNI8uLGwtPGKURzoS2HeFpAqHmDKget+BTSYCWjwzA1gg0sSEVJSDYwr
	VxuenTrH31Wd13cdX5evZemmi/ltTr9MIw6etdl3/XKdwlqJi5c7F0pvEFtT/oMv+W5ujaZs
	5c2fSj9msv04w5SxN6P8/5NHRjZ+5eKaKX+eqd3XSoqZuOessqpMCb/p9etNna+K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287369>

Besides shortening the code, this saves an unnecessary call to
safe_create_leading_directories_const() in almost all cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 76 ++++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a549942..2cb402d 100644
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
+		if (errno == ENOTDIR)
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
+		if (true_errno == EISDIR)
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
