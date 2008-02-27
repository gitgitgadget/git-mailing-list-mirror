From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 09/40] Windows: Work around misbehaved rename().
Date: Wed, 27 Feb 2008 19:54:32 +0100
Message-ID: <1204138503-6126-10-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:59:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVJ-00022R-SS
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbYB0SzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbYB0SzW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:22 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40431 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbYB0SzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:07 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 7370997580;
	Wed, 27 Feb 2008 19:55:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75253>

Windows's rename() is based on the MoveFile() API, which fails if the
destination exists. Here we work around the problem by using MoveFileEx().
Furthermore, the posixly correct error is returned if the destination is
a directory.

The implementation is still slightly incomplete, however, because of the
missing error code translation: We assume that the failure is due to
permissions.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |   25 +++++++++++++++++++++++++
 git-compat-util.h |    3 +++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0c1d0e4..733ef87 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -60,6 +60,31 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 	return result;
 }
 
+#undef rename
+int mingw_rename(const char *pold, const char *pnew)
+{
+	/*
+	 * Try native rename() first to get errno right.
+	 * It is based on MoveFile(), which cannot overwrite existing files.
+	 */
+	if (!rename(pold, pnew))
+		return 0;
+	if (errno != EEXIST)
+		return -1;
+	if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
+		return 0;
+	/* TODO: translate more errors */
+	if (GetLastError() == ERROR_ACCESS_DENIED) {
+		DWORD attrs = GetFileAttributes(pnew);
+		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY)) {
+			errno = EISDIR;
+			return -1;
+		}
+	}
+	errno = EACCES;
+	return -1;
+}
+
 struct passwd *getpwuid(int uid)
 {
 	static char user_name[100];
diff --git a/git-compat-util.h b/git-compat-util.h
index 06ac2c1..f44a287 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -592,6 +592,9 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
+int mingw_rename(const char*, const char*);
+#define rename mingw_rename
+
 #endif /* __MINGW32__ */
 
 #endif
-- 
1.5.4.1.126.ge5a7d
