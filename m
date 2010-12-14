From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 1/8] mingw: move unlink wrapper to mingw.c
Date: Tue, 14 Dec 2010 23:09:49 +0100
Message-ID: <20101214220948.GB4084@sandbox>
References: <20101214220604.GA4084@sandbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSd4N-0004rP-6H
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab0LNWJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:09:55 -0500
Received: from darksea.de ([83.133.111.250]:36999 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752967Ab0LNWJx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:09:53 -0500
Received: (qmail 21590 invoked from network); 14 Dec 2010 23:09:52 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Dec 2010 23:09:52 +0100
Content-Disposition: inline
In-Reply-To: <20101214220604.GA4084@sandbox>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163693>

The next patch implements a workaround in case unlink fails on Windows.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 compat/mingw.c |    8 ++++++++
 compat/mingw.h |   11 +++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bee6054..a7e1c6b 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -116,6 +116,14 @@ int err_win_to_posix(DWORD winerr)
 	return error;
 }
 
+#undef unlink
+int mingw_unlink(const char *pathname)
+{
+	/* read-only files cannot be removed */
+	chmod(pathname, 0666);
+	return unlink(pathname);
+}
+
 #undef open
 int mingw_open (const char *filename, int oflags, ...)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 2283071..8316938 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -125,14 +125,6 @@ static inline int mingw_mkdir(const char *path, int mode)
 }
 #define mkdir mingw_mkdir
 
-static inline int mingw_unlink(const char *pathname)
-{
-	/* read-only files cannot be removed */
-	chmod(pathname, 0666);
-	return unlink(pathname);
-}
-#define unlink mingw_unlink
-
 #define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
@@ -180,6 +172,9 @@ int link(const char *oldpath, const char *newpath);
  * replacements of existing functions
  */
 
+int mingw_unlink(const char *pathname);
+#define unlink mingw_unlink
+
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
-- 
1.7.3.3.566.gf422f
