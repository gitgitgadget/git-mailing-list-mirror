From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 3/7] Windows: simplify the pipe(2) implementation
Date: Fri, 15 Jan 2010 21:12:17 +0100
Message-ID: <3b24f03a7d81f2ecd83bc0779a117dc14d8abe62.1263584975.git.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: msysgit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:13:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsYM-0004sM-Tt
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 21:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758168Ab0AOUNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 15:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758152Ab0AOUNr
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 15:13:47 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:31602 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758145Ab0AOUNq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 15:13:46 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AB21CA7EB5;
	Fri, 15 Jan 2010 21:13:44 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 177CE19F60D;
	Fri, 15 Jan 2010 21:12:48 +0100 (CET)
X-Mailer: git-send-email 1.6.6.218.g3e6eb
In-Reply-To: <cover.1262895936.git.j6t@kdbg.org>
In-Reply-To: <cover.1263584975.git.j6t@kdbg.org>
References: <cover.1263584975.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137111>

Our implementation of pipe() must create non-inheritable handles for the
reason that when a child process is started, there is no opportunity to
close the unneeded pipe ends in the child (on POSIX this is done between
fork() and exec()).

Previously, we used the _pipe() function provided by Microsoft's C runtime
(which creates inheritable handles) and then turned the handles into
non-inheritable handles using the DuplicateHandle() API.

Simplify the procedure by using the CreatePipe() API, which can create
non-inheritable handles right from the beginning.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 No changes.

 compat/mingw.c |   37 ++++++++-----------------------------
 1 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2afc978..162d1ff 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -299,46 +299,25 @@ int gettimeofday(struct timeval *tv, void *tz)
 
 int pipe(int filedes[2])
 {
-	int fd;
-	HANDLE h[2], parent;
-
-	if (_pipe(filedes, 8192, 0) < 0)
-		return -1;
+	HANDLE h[2];
 
-	parent = GetCurrentProcess();
-
-	if (!DuplicateHandle (parent, (HANDLE)_get_osfhandle(filedes[0]),
-			parent, &h[0], 0, FALSE, DUPLICATE_SAME_ACCESS)) {
-		close(filedes[0]);
-		close(filedes[1]);
-		return -1;
-	}
-	if (!DuplicateHandle (parent, (HANDLE)_get_osfhandle(filedes[1]),
-			parent, &h[1], 0, FALSE, DUPLICATE_SAME_ACCESS)) {
-		close(filedes[0]);
-		close(filedes[1]);
-		CloseHandle(h[0]);
+	/* this creates non-inheritable handles */
+	if (!CreatePipe(&h[0], &h[1], NULL, 8192)) {
+		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
-	fd = _open_osfhandle((int)h[0], O_NOINHERIT);
-	if (fd < 0) {
-		close(filedes[0]);
-		close(filedes[1]);
+	filedes[0] = _open_osfhandle((int)h[0], O_NOINHERIT);
+	if (filedes[0] < 0) {
 		CloseHandle(h[0]);
 		CloseHandle(h[1]);
 		return -1;
 	}
-	close(filedes[0]);
-	filedes[0] = fd;
-	fd = _open_osfhandle((int)h[1], O_NOINHERIT);
-	if (fd < 0) {
+	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
+	if (filedes[0] < 0) {
 		close(filedes[0]);
-		close(filedes[1]);
 		CloseHandle(h[1]);
 		return -1;
 	}
-	close(filedes[1]);
-	filedes[1] = fd;
 	return 0;
 }
 
-- 
1.6.6.218.g3e6eb
