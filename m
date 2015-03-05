From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/5] xfdopen(): if first attempt fails, free memory and try again
Date: Thu,  5 Mar 2015 17:07:45 +0100
Message-ID: <1425571669-22800-2-git-send-email-mhagger@alum.mit.edu>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:15:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTYQW-0000BJ-HK
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240AbbCEQPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:15:01 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:65447 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752743AbbCEQPA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 11:15:00 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2015 11:15:00 EST
X-AuditID: 1207440c-f79376d00000680a-72-54f87f5d70e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.51.26634.D5F78F45; Thu,  5 Mar 2015 11:07:57 -0500 (EST)
Received: from michael.fritz.box (p5DDB3EC9.dip0.t-ipconnect.de [93.219.62.201])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t25G7s7f031040
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 5 Mar 2015 11:07:56 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqBtb/yPEYGuPlkXXlW4mi4beK8wW
	b28uYbS4vWI+swOLx9/3H5g8ds66y+5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGStW9zMX
	bBWquLl5LlMD40W+LkZODgkBE4ml56azQthiEhfurWfrYuTiEBK4zCjxa/JsVgjnOJNEb995
	dpAqNgFdiUU9zUwgtoiAmsTEtkMsIDazQL7E990nwOLCAoESv7aeYwOxWQRUJV6tOcAMYvMK
	uEis+vCfBWKbnMT54z/B4pwCrhLTrtwCmy8EVDPv31LWCYy8CxgZVjHKJeaU5urmJmbmFKcm
	6xYnJ+blpRbpGurlZpbopaaUbmKEBBDPDsZv62QOMQpwMCrx8M7Y+D1EiDWxrLgy9xCjJAeT
	kijvj6ofIUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeK9EAuV4UxIrq1KL8mFS0hwsSuK8qkvU
	/YQE0hNLUrNTUwtSi2CyMhwcShK8ZnVAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUl
	GfGg2IgvBkYHSIoHaK8rSDtvcUFiLlAUovUUo6KUOK8iSEIAJJFRmgc3FpYWXjGKA30pzFsI
	UsUDTClw3a+ABjMBDdYSAxtckoiQkmpgFPhdvtrheMXiBumu659VO3YsWuWYHF+aIPb00/ej
	Sz7kX7bwu7ekl+vepv3b5XZf+/f0W85HxulZkiU3f90NjGWQe8zxjmVKWmNY6EL+zaWvJuyY
	586ZL2bLWOiWEDzf88SCP+lvdG41FlrtTCnb2sVfnBjJaKDOe95B7F/DJ6GXM8+f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264848>

One likely reason for the failure of fdopen() is a lack of free
memory.

Also expose a new function, fdopen_with_retry(), which retries on
ENOMEM but doesn't die() on errors. In a moment this function will be
used elsewhere.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-compat-util.h | 11 +++++++++++
 wrapper.c         | 28 +++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 3455c5e..a5652a7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -672,7 +672,18 @@ extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
 extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
+
+/*
+ * Like fdopen(), but if the first attempt fails with ENOMEM, try to
+ * free up some memory and try again.
+ */
+extern FILE *fdopen_with_retry(int fd, const char *mode);
+
+/*
+ * Like fdopen_with_retry(), but die on errors.
+ */
 extern FILE *xfdopen(int fd, const char *mode);
+
 extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
diff --git a/wrapper.c b/wrapper.c
index d5a6cef..b60cc03 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -311,14 +311,36 @@ int xdup(int fd)
 	return ret;
 }
 
-FILE *xfdopen(int fd, const char *mode)
+FILE *fdopen_with_retry(int fd, const char *mode)
 {
 	FILE *stream = fdopen(fd, mode);
-	if (stream == NULL)
-		die_errno("Out of memory? fdopen failed");
+
+	if (!stream && errno == ENOMEM) {
+		/*
+		 * Try to free up some memory, then try again. We
+		 * would prefer to use sizeof(FILE) here, but that is
+		 * not guaranteed to be defined (e.g., FILE might be
+		 * an incomplete type).
+		 */
+		try_to_free_routine(1000);
+		stream = fdopen(fd, mode);
+	}
+
 	return stream;
 }
 
+FILE *xfdopen(int fd, const char *mode)
+{
+	FILE *stream = fdopen_with_retry(fd, mode);
+
+	if (stream)
+		return stream;
+	else if (errno == ENOMEM)
+		die_errno("Out of memory? fdopen failed");
+	else
+		die_errno("fdopen failed");
+}
+
 int xmkstemp(char *template)
 {
 	int fd;
-- 
2.1.4
