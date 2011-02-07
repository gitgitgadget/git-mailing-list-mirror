From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 5/5] mingw_rmdir: set errno=ENOTEMPTY when appropriate
Date: Mon, 7 Feb 2011 21:54:01 +0100
Message-ID: <20110207205400.GF63976@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com> <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:54:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY65-0004xA-SS
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1BGUyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:54:04 -0500
Received: from darksea.de ([83.133.111.250]:41706 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751798Ab1BGUyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:54:03 -0500
Received: (qmail 11787 invoked from network); 7 Feb 2011 21:54:00 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Feb 2011 21:54:00 +0100
Content-Disposition: inline
In-Reply-To: <20110207204818.GA63976@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166289>

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
index 68cc79f..368edf2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -225,6 +225,30 @@ int mingw_unlink(const char *pathname)
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
@@ -233,6 +257,10 @@ int mingw_rmdir(const char *pathname)
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
1.7.4.34.gd2cb1
