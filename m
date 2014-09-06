From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 31/32] trim_last_path_elm(): replace last_path_elm()
Date: Sat,  6 Sep 2014 09:50:45 +0200
Message-ID: <1409989846-22401-32-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnl-0000ZE-98
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbaIFHwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:46 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44689 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863AbaIFHwn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:43 -0400
X-AuditID: 12074414-f79446d000001f1d-27-540abd4ac2c3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 46.9A.07965.A4DBA045; Sat,  6 Sep 2014 03:52:42 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHU006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:41 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqOu1lyvE4OluEYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujE1bX7MU7BSquNe/ib2BsZGvi5GTQ0LAROLUmXmMELaYxIV769m6
	GLk4hAQuM0ps6H/HBOEcY5JonPCECaSKTUBXYlFPM1hCRKCNUWLXxc2sIAlmgRSJjufdQKM4
	OIQF3CWe9riBhFkEVCUOXvsHtoFXwFXi+dwtUNvkJDbs/g9mcwLFpzd1gtlCAi4S7Sf7mSYw
	8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopeaUrqJERJoIjsYj5yUO8QowMGo
	xMNb4MAVIsSaWFZcmXuIUZKDSUmUN285UIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb8dkoBxv
	SmJlVWpRPkxKmoNFSZz322J1PyGB9MSS1OzU1ILUIpisDAeHkgSvyx6gRsGi1PTUirTMnBKE
	NBMHJ8hwLimR4tS8lNSixNKSjHhQbMQXA6MDJMUDtJcVpJ23uCAxFygK0XqKUZdjXee3fiYh
	lrz8vFQpcV4mkCIBkKKM0jy4FbC08opRHOhjYV4xkCoeYEqCm/QKaAkT0BLzdE6QJSWJCCmp
	BsZ1h1OqdqiekCxjEo0KXDo3cieT+P29m56sD7qrYfd1gajDcrYmvp+fpmznN7SYlf6h/sKy
	ruKCL4cnL4xLSeeaectziavGlDO3Ks4vOV/3QlRw3qtPwaUtpyVO9wQxdTwqDf/g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256562>

Rewrite last_path_elm() to take a strbuf parameter and to trim off the
last path name element in place rather than returning a pointer to the
beginning of the last path name element.  This simplifies the function
a bit and makes it integrate better with its caller, which is now also
strbuf-based.  Rename the function accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index d78b6bf..4c6e720 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -86,32 +86,28 @@ static void remove_lock_file_on_signal(int signo)
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
 
 
@@ -141,14 +137,12 @@ static void resolve_symlink(struct strbuf *path)
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
2.1.0
