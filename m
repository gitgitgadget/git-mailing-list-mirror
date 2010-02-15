From: Ludvig Strigeus <ludde@spotify.com>
Subject: [PATCH] Introduce an exponential-backoff-retry in unlink on mingw.
Date: Mon, 15 Feb 2010 20:37:33 +0000 (UTC)
Message-ID: <loom.20100215T213606-594@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 21:38:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh7hj-0005ty-DI
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 21:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab0BOUh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 15:37:58 -0500
Received: from lo.gmane.org ([80.91.229.12]:47797 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755689Ab0BOUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 15:37:57 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nh7hc-0005qL-J1
	for git@vger.kernel.org; Mon, 15 Feb 2010 21:37:56 +0100
Received: from c83-248-101-208.bredband.comhem.se ([83.248.101.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 21:37:56 +0100
Received: from ludde by c83-248-101-208.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 21:37:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.248.101.208 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.1.7) Gecko/20091221 Firefox/3.5.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140029>

This is to work around that you can't delete a file while open on Windows.
Visual Studio and other IDEs that have a change-notification-handler
set up on the source code tree, will stat all files inside of the
directory each time it changes, for example when doing git checkout.
If git checkout is unlucky, the file handle will be open exactly
the same time as git checkout is trying to delete the file, causing the
checkout to fail.

A backoff is introduced that retries the unlink a few times with a
small delay in between.

The code has logic to stop the exponential backoff if it detects
it's of no use, to prevent git from taking massively long time if
files are read only for a valid reason.
---
 compat/mingw.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h |    7 +-----
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 10d6796..677f3a6 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -375,6 +375,66 @@ int gettimeofday(struct timeval *tv, void *tz)
 	return 0;
 }
 
+/*
+ * It's not possible to delete a file while in use on Windows
+ * This frequently happens when having files open in Microsoft
+ * Visual Studio. When switching branch it seems to rapidly
+ * open/stat files at the same time as git is checking files out,
+ * causing the unlink to fail with EACCES.
+ * This code introduces an exponential delay in case
+ * of permission denied errors.
+ * With these parameters we wait approximately
+ * max half a second extra in total with the follow retry times:
+ * 16ms, 32ms, 64ms, 128ms, 256ms
+ */
+
+#define NUM_UNLINK_RETRIES 5
+#define UNLINK_SLEEP_TIME 32
+
+/* Made this volatile in case unlink is called from many threads */
+static volatile int unlink_retries = NUM_UNLINK_RETRIES;
+
+int mingw_unlink(const char *pathname)
+{
+	int r;
+	int tries_left = unlink_retries;
+	int sleepms = UNLINK_SLEEP_TIME; 
+	DWORD attrs;
+	
+	/* read-only files cannot be removed */
+	chmod(pathname, 0666);
+	
+	for(;;) {
+		r = unlink(pathname);
+		if (r == 0 || errno != EACCES) {
+			/* If the sleep helped, then reset the retry counter */
+			if (sleepms != UNLINK_SLEEP_TIME)
+				unlink_retries = NUM_UNLINK_RETRIES;
+			return r;
+		}
+
+		/* No point in sleeping if unlink is called on a directory or invalid file */
+		attrs = GetFileAttributes(pathname);
+		if (attrs == INVALID_FILE_ATTRIBUTES || (attrs & FILE_ATTRIBUTE_DIRECTORY))
+			return r;
+
+		if (--tries_left < 0) {
+			/* 
+			 * Reduce the retry count to avoid having to wait so long
+			 * next time in case we get these errors for a reason
+			 * other than windows being stupid.
+			 */
+			int t = unlink_retries;
+			unlink_retries = (t > 0) ? (t - 1) : 0;
+			return r;
+		}
+		
+		Sleep(sleepms);
+		sleepms *= 2;
+	}
+}
+
+
 int pipe(int filedes[2])
 {
 	int fd;
diff --git a/compat/mingw.h b/compat/mingw.h
index 1b528da..9163edd 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -98,12 +98,7 @@ static inline int fcntl(int fd, int cmd, long arg)
  * simple adaptors
  */
 
-static inline int mingw_unlink(const char *pathname)
-{
-	/* read-only files cannot be removed */
-	chmod(pathname, 0666);
-	return unlink(pathname);
-}
+int mingw_unlink(const char *pathname);
 #define unlink mingw_unlink
 
 static inline int waitpid(pid_t pid, int *status, unsigned options)
-- 
1.6.5.1.1367.gcd48.dirty
