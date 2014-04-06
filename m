From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 25/25] trim_last_path_elm(): replace last_path_elm()
Date: Mon,  7 Apr 2014 01:34:07 +0200
Message-ID: <1396827247-28465-26-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc8-00074B-De
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbaDFXgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:23 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62014 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754669AbaDFXfb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:31 -0400
X-AuditID: 12074412-f79d46d000002e58-dd-5341e4c2cfbd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A8.8D.11864.2C4E1435; Sun,  6 Apr 2014 19:35:30 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbXC011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:28 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHvoiWOwQcNOKYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MFmfeNDJadHZ8ZXRg9/j7/gOTx85Zd9k9nvXuYfS4eEnZY/EDL4/P
	m+Q8bj/bxhLAHsVtk5RYUhacmZ6nb5fAnbGoaw57wXahiq3NS1kaGBv4uhg5OSQETCQeTvrA
	DmGLSVy4t56ti5GLQ0jgMqPEuW/32CGc40wSVztAMpwcbAK6Eot6mplAbBEBNYmJbYdYQIqY
	BW4wSrzbd5gFJCEs4C6x+OUOsAYWAVWJWZO3MYPYvAKuEvPXbWKDWCcncfLYZFYQmxMovm7y
	XLBeIQEXoDn32CYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERJ8
	QjsY15+UO8QowMGoxMO74pBjsBBrYllxZe4hRkkOJiVRXst7QCG+pPyUyozE4oz4otKc1OJD
	jBIczEoivAduAOV4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4+x4D
	NQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoiO+GBgfICkeoL0RIO28xQWJuUBR
	iNZTjIpS4rwzHwElBEASGaV5cGNhKeUVozjQl8K8BiDtPMB0BNf9CmgwE9DghjA7kMEliQgp
	qQZG/Q1f3i9ewCD0NPaNU2Lf3+yCks0NLYc5hdteGemV3r+97TivqealFd0/qyuft4qxSXz/
	krbylDCvfo+JcejGrqSQ7uwlO/dOvOR2We3ZBRe2XktRP0/9hL4tdUd2LLZOm+3+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245818>

Rewrite last_path_elm() to take a strbuf parameter and to trim off the
last path name element in place rather than returning a pointer to the
beginning of the last path name element.  This simplifies the function
a bit and makes it integrate better with its caller, which is also
strbuf-based.  Rename the function accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 8e7bcda..f9c8515 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -100,32 +100,28 @@ static void remove_lock_file_on_signal(int signo)
 }
 
 /*
- * p = absolute or relative path name
+ * path = absolute or relative path name
  *
- * Return a pointer into p showing the beginning of the last path name
- * element.  If p is empty or the root directory ("/"), just return p.
+ * Remove the last path name element from path (leaving the preceding
+ * "/", if any).  If path is empty or the root directory ("/"), set
+ * path to the empty string.
  */
-static char *last_path_elm(char *p)
+static void trim_last_path_elm(struct strbuf *path)
 {
-	/* r starts pointing to null at the end of the string */
-	char *r = strchr(p, '\0');
-
-	if (r == p)
-		return p; /* just return empty string */
-
-	r--; /* back up to last non-null character */
+	int i = path->len;
 
 	/* back up past trailing slashes, if any */
-	while (r > p && *r == '/')
-		r--;
+	while (i && path->buf[i - 1] == '/')
+		i--;
 
 	/*
-	 * then go backwards until I hit a slash, or the beginning of
-	 * the string
+	 * then go backwards until a slash, or the beginning of the
+	 * string
 	 */
-	while (r > p && *(r-1) != '/')
-		r--;
-	return r;
+	while (i && path->buf[i - 1] != '/')
+		i--;
+
+	strbuf_setlen(path, i);
 }
 
 
@@ -155,14 +151,12 @@ static void resolve_symlink(struct strbuf *path)
 		if (is_absolute_path(link.buf))
 			/* absolute path simply replaces p */
 			strbuf_reset(path);
-		else {
+		else
 			/*
 			 * link is a relative path, so replace the
 			 * last element of p with it.
 			 */
-			char *r = last_path_elm(path->buf);
-			strbuf_setlen(path, r - path->buf);
-		}
+			trim_last_path_elm(path);
 
 		strbuf_addbuf(path, &link);
 	}
-- 
1.9.1
