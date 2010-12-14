From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 2/8] mingw: work around irregular failures of unlink on
 windows
Date: Tue, 14 Dec 2010 23:11:34 +0100
Message-ID: <20101214221134.GC4084@sandbox>
References: <20101214220604.GA4084@sandbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:11:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSd60-00062U-JR
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab0LNWLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:11:40 -0500
Received: from darksea.de ([83.133.111.250]:59983 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753085Ab0LNWLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:11:39 -0500
Received: (qmail 21608 invoked from network); 14 Dec 2010 23:11:38 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Dec 2010 23:11:38 +0100
Content-Disposition: inline
In-Reply-To: <20101214220604.GA4084@sandbox>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163694>

If a file is opened by another process (e.g. indexing of an IDE) for
reading it is not allowed to be deleted. So in case unlink fails retry
after waiting for some time. This extends the workaround from 6ac6f878.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 compat/mingw.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a7e1c6b..52183a7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,6 +3,8 @@
 #include <conio.h>
 #include "../strbuf.h"
 
+static const int delay[] = { 0, 1, 10, 20, 40 };
+
 int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
@@ -116,12 +118,38 @@ int err_win_to_posix(DWORD winerr)
 	return error;
 }
 
+static inline int is_file_in_use_error(DWORD errcode)
+{
+	switch(GetLastError()) {
+	case ERROR_SHARING_VIOLATION:
+	case ERROR_ACCESS_DENIED:
+		return 1;
+	}
+
+	return 0;
+}
+
 #undef unlink
 int mingw_unlink(const char *pathname)
 {
+	int ret, tries = 0;
+
 	/* read-only files cannot be removed */
 	chmod(pathname, 0666);
-	return unlink(pathname);
+	while ((ret = unlink(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+		if (!is_file_in_use_error(GetLastError()))
+			break;
+		/*
+		 * We assume that some other process had the source or
+		 * destination file open at the wrong moment and retry.
+		 * In order to give the other process a higher chance to
+		 * complete its operation, we give up our time slice now.
+		 * If we have to retry again, we do sleep a bit.
+		 */
+		Sleep(delay[tries]);
+		tries++;
+	}
+	return ret;
 }
 
 #undef open
@@ -1257,7 +1285,6 @@ int mingw_rename(const char *pold, const char *pnew)
 {
 	DWORD attrs, gle;
 	int tries = 0;
-	static const int delay[] = { 0, 1, 10, 20, 40 };
 
 	/*
 	 * Try native rename() first to get errno right.
-- 
1.7.3.3.566.gf422f
