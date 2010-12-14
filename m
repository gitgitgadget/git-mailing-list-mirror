From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 5/5] mingw_rmdir: set errno=ENOTEMPTY when appropriate
Date: Tue, 14 Dec 2010 23:28:30 +0100
Message-ID: <20101214222830.GF4084@sandbox>
References: <20101214220604.GA4084@sandbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdMP-0006lx-1u
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935Ab0LNW2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:28:36 -0500
Received: from darksea.de ([83.133.111.250]:52281 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758636Ab0LNW2f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:28:35 -0500
Received: (qmail 21688 invoked from network); 14 Dec 2010 23:28:33 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Dec 2010 23:28:33 +0100
Content-Disposition: inline
In-Reply-To: <20101214220604.GA4084@sandbox>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163699>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, EACCES overrules ENOTEMPTY when calling rmdir(). But if the
directory is busy, we only want to retry deleting the directory if it
is empty, so test specifically for that case and set ENOTEMPTY rather
than EACCES.

Noticed by Greg Hazel.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 compat/mingw.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b920644..3e013c6 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -229,6 +229,30 @@ int mingw_unlink(const char *pathname)
 	return ret;
 }
 
+static int is_dir_empty(const char *path)
+{
+	struct strbuf buf = STRBUF_INIT;
+	WIN32_FIND_DATAA findbuf;
+	HANDLE handle;
+
+	strbuf_addf(&buf, "%s\\*", path);
+	handle = FindFirstFileA(buf.buf, &findbuf);
+	if (handle == INVALID_HANDLE_VALUE) {
+		strbuf_release(&buf);
+		return GetLastError() == ERROR_NO_MORE_FILES;
+	}
+
+	while (!strcmp(findbuf.cFileName, ".") ||
+			!strcmp(findbuf.cFileName, ".."))
+		if (!FindNextFile(handle, &findbuf)) {
+			strbuf_release(&buf);
+			return GetLastError() == ERROR_NO_MORE_FILES;
+		}
+	FindClose(handle);
+	strbuf_release(&buf);
+	return 0;
+}
+
 #undef rmdir
 int mingw_rmdir(const char *pathname)
 {
@@ -237,6 +261,10 @@ int mingw_rmdir(const char *pathname)
 	while ((ret = rmdir(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
 		if (!is_file_in_use_error(GetLastError()))
 			break;
+		if (!is_dir_empty(pathname)) {
+			errno = ENOTEMPTY;
+			break;
+		}
 		/*
 		 * We assume that some other process had the source or
 		 * destination file open at the wrong moment and retry.
-- 
1.7.3.3.566.gf422f
