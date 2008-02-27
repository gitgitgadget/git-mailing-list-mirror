From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 06/40] Windows: Implement a wrapper of the open() function.
Date: Wed, 27 Feb 2008 19:54:29 +0100
Message-ID: <1204138503-6126-7-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:59:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVI-00022R-JF
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbYB0SzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbYB0SzT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:19 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40428 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbYB0SzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:07 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 115AF974ED;
	Wed, 27 Feb 2008 19:55:05 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75251>

The wrapper does two things:
- Requests to open /dev/null are redirected to open the nul pseudo file.
- A request to open a file that currently exists as a directory on
  Windows fails with EACCES; this is changed to EISDIR.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |   20 ++++++++++++++++++++
 git-compat-util.h |    7 +++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0c87e43..faa6df3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2,6 +2,26 @@
 
 unsigned int _CRT_fmode = _O_BINARY;
 
+#undef open
+int mingw_open (const char *filename, int oflags, ...)
+{
+	va_list args;
+	unsigned mode;
+	va_start(args, oflags);
+	mode = va_arg(args, int);
+	va_end(args);
+
+	if (!strcmp(filename, "/dev/null"))
+		filename = "nul";
+	int fd = open(filename, oflags, mode);
+	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
+		DWORD attrs = GetFileAttributes(filename);
+		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
+			errno = EISDIR;
+	}
+	return fd;
+}
+
 unsigned int sleep (unsigned int seconds)
 {
 	Sleep(seconds*1000);
diff --git a/git-compat-util.h b/git-compat-util.h
index b1f3f92..672c074 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -577,6 +577,13 @@ struct passwd *getpwuid(int uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 
+/*
+ * replacements of existing functions
+ */
+
+int mingw_open (const char *filename, int oflags, ...);
+#define open mingw_open
+
 #endif /* __MINGW32__ */
 
 #endif
-- 
1.5.4.1.126.ge5a7d
