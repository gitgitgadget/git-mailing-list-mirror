From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 1/5] mingw: move unlink wrapper to mingw.c
Date: Mon, 7 Feb 2011 21:49:33 +0100
Message-ID: <20110207204932.GB63976@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com> <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY1j-0002HT-Lo
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab1BGUtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:49:35 -0500
Received: from darksea.de ([83.133.111.250]:37597 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751798Ab1BGUte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:49:34 -0500
Received: (qmail 11704 invoked from network); 7 Feb 2011 21:49:32 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Feb 2011 21:49:32 +0100
Content-Disposition: inline
In-Reply-To: <20110207204818.GA63976@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166283>

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
index cafc1eb..970d743 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -119,14 +119,6 @@ static inline int mingw_mkdir(const char *path, int mode)
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
 
@@ -174,6 +166,9 @@ int link(const char *oldpath, const char *newpath);
  * replacements of existing functions
  */
 
+int mingw_unlink(const char *pathname);
+#define unlink mingw_unlink
+
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
-- 
1.7.4.34.gd2cb1
