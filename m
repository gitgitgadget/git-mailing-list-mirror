From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 4/5] mingw: add fallback for rmdir in case directory is
	in use
Date: Mon, 7 Feb 2011 21:52:34 +0100
Message-ID: <20110207205233.GE63976@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com> <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:52:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY4j-00048U-5b
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab1BGUwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:52:36 -0500
Received: from darksea.de ([83.133.111.250]:41697 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754230Ab1BGUwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:52:35 -0500
Received: (qmail 11762 invoked from network); 7 Feb 2011 21:52:33 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Feb 2011 21:52:33 +0100
Content-Disposition: inline
In-Reply-To: <20110207204818.GA63976@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166287>

The same logic as for unlink and rename also applies to rmdir. For
example in case you have a shell open in a git controlled folder. This
will easily fail. So lets be nice for such cases as well.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 compat/mingw.c |   25 +++++++++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1354b8e..68cc79f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -225,6 +225,31 @@ int mingw_unlink(const char *pathname)
 	return ret;
 }
 
+#undef rmdir
+int mingw_rmdir(const char *pathname)
+{
+	int ret, tries = 0;
+
+	while ((ret = rmdir(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
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
+	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
+	       ask_yes_no_if_possible("Deletion of directory '%s' failed. "
+			"Should I try again?", pathname))
+	       ret = rmdir(pathname);
+	return ret;
+}
+
 #undef open
 int mingw_open (const char *filename, int oflags, ...)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 970d743..fe6ba34 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -169,6 +169,9 @@ int link(const char *oldpath, const char *newpath);
 int mingw_unlink(const char *pathname);
 #define unlink mingw_unlink
 
+int mingw_rmdir(const char *path);
+#define rmdir mingw_rmdir
+
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
-- 
1.7.4.34.gd2cb1
