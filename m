From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 15/40] Windows: A work-around for a misbehaved vsnprintf.
Date: Wed, 27 Feb 2008 19:54:38 +0100
Message-ID: <1204138503-6126-16-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURVN-00022R-Nl
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbYB0Szh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbYB0Szg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:36 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40442 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418AbYB0SzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:08 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 7A962973C8;
	Wed, 27 Feb 2008 19:55:06 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75280>

On Windows, vsnprintf deviates in two regards from the "usual" behavior
that its callers in GIT expect:

- It returns -1 if the buffer is too small instead of the number of
  characters that the operation produces.

- The size parameter is the number of characters to write, which does not
  include the trailing NUL byte, instead of the available space.

This wrapper computes the needed buffer size by trying various sizes with
exponential growth. A large growth factor is used so as only few trials are
required if a really large result needs to be stored.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c    |   34 ++++++++++++++++++++++++++++++++++
 git-compat-util.h |    3 +++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4888a03..77e4b83 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -115,6 +115,40 @@ int mingw_rename(const char *pold, const char *pnew)
 	return -1;
 }
 
+#undef vsnprintf
+/* Note that the size parameter specifies the available space, i.e.
+ * includes the trailing NUL byte; but Windows's vsnprintf expects the
+ * number of characters to write without the trailing NUL.
+ */
+
+/* This is out of line because it uses alloca() behind the scenes,
+ * which must not be called in a loop (alloca() reclaims the allocations
+ * only at function exit).
+ */
+static int try_vsnprintf(size_t size, const char *fmt, va_list args)
+{
+	char buf[size];	/* gcc-ism */
+	return vsnprintf(buf, size-1, fmt, args);
+}
+
+int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	int len;
+	if (size > 0) {
+		len = vsnprintf(buf, size-1, fmt, args);
+		if (len >= 0)
+			return len;
+	}
+	/* ouch, buffer too small; need to compute the size */
+	if (size < 250)
+		size = 250;
+	do {
+		size *= 4;
+		len = try_vsnprintf(size, fmt, args);
+	} while (len < 0);
+	return len;
+}
+
 struct passwd *getpwuid(int uid)
 {
 	static char user_name[100];
diff --git a/git-compat-util.h b/git-compat-util.h
index 483ace2..6fa93b6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -602,6 +602,9 @@ char *mingw_getcwd(char *pointer, int len);
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
+int mingw_vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
+#define vsnprintf mingw_vsnprintf
+
 sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define signal mingw_signal
 
-- 
1.5.4.1.126.ge5a7d
