From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/2] Windows: Work around intermittent failures in mingw_rename
Date: Mon, 20 Apr 2009 10:01:37 +0200
Message-ID: <49EC2BE1.9080200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 10:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvoTK-0005nT-Da
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 10:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbZDTIBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 04:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbZDTIBs
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 04:01:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44983 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbZDTIBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 04:01:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LvoRe-0004mG-9o; Mon, 20 Apr 2009 10:01:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0D59A4E4; Mon, 20 Apr 2009 10:01:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116943>

From: Johannes Sixt <j6t@kdbg.org>
Date: Fri, 3 Apr 2009 08:49:59 +0200

We have replaced rename() with a version that can rename a file to a
destination that already exists. Nevertheless, many users, the author
included, observe failures in the code that are not reproducible.

The theory is that the failures are due to some other process that happens
to have opened the destination file briefly at the wrong moment. (And there
is no way on Windows to delete or replace a file that is currently open.)
The most likely candidate for such a process is a virus scanner. The
failure is more often observed while there is heavy git activity (for
example while the test suite is running or during a rebase operation).

We work around the failure by retrying the rename operation if it failed
due to ERROR_ACCESS_DENIED. The retries are delayed a bit: The first only
by giving up the time slice, the next after the minimal scheduling
granularity, and if more retries are needed, then we wait some non-trivial
amount of time with exponential back-off.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Steffen, Dscho,

 this is slightly different from the version that is currently 4msysgit:
 I removed the warning that was printed when a retry was attempted.

 -- Hannes

 compat/mingw.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4b37d93..74eae20 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -978,7 +978,9 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
 {
-	DWORD attrs;
+	DWORD attrs, gle;
+	int tries = 0;
+	static const int delay[] = { 0, 1, 10, 20, 40 };

 	/*
 	 * Try native rename() first to get errno right.
@@ -988,10 +990,12 @@ int mingw_rename(const char *pold, const char *pnew)
 		return 0;
 	if (errno != EEXIST)
 		return -1;
+repeat:
 	if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
 		return 0;
 	/* TODO: translate more errors */
-	if (GetLastError() == ERROR_ACCESS_DENIED &&
+	gle = GetLastError();
+	if (gle == ERROR_ACCESS_DENIED &&
 	    (attrs = GetFileAttributes(pnew)) != INVALID_FILE_ATTRIBUTES) {
 		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
 			errno = EISDIR;
@@ -1001,10 +1005,23 @@ int mingw_rename(const char *pold, const char *pnew)
 		    SetFileAttributes(pnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
 			if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
 				return 0;
+			gle = GetLastError();
 			/* revert file attributes on failure */
 			SetFileAttributes(pnew, attrs);
 		}
 	}
+	if (tries < ARRAY_SIZE(delay) && gle == ERROR_ACCESS_DENIED) {
+		/*
+		 * We assume that some other process had the source or
+		 * destination file open at the wrong moment and retry.
+		 * In order to give the other process a higher chance to
+		 * complete its operation, we give up our time slice now.
+		 * If we have to retry again, we do sleep a bit.
+		 */
+		Sleep(delay[tries]);
+		tries++;
+		goto repeat;
+	}
 	errno = EACCES;
 	return -1;
 }
-- 
1.6.3.rc1.989.ga175e.dirty
