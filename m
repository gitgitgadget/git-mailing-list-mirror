From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/5] safe_create_leading_directories(): add "slash" pointer
Date: Sun, 22 Dec 2013 08:14:09 +0100
Message-ID: <1387696451-32224-4-git-send-email-mhagger@alum.mit.edu>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 08:15:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VudFg-0006Rg-Jf
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 08:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab3LVHOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 02:14:47 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57087 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752467Ab3LVHOk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Dec 2013 02:14:40 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-a2-52b6915fabd9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 66.FE.19161.F5196B25; Sun, 22 Dec 2013 02:14:40 -0500 (EST)
Received: from michael.fritz.box (p57A25B75.dip0.t-ipconnect.de [87.162.91.117])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBM7ERFN023935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 22 Dec 2013 02:14:39 -0500
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqJswcVuQwa9eJouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5obJ3LXtDNV7Hq/UfWBsbt
	XF2MnBwSAiYS2798Z4SwxSQu3FvP1sXIxSEkcJlR4u7iLijnBJPE5xsrWECq2AR0JRb1NDOB
	2CICahIT2w6BxZkFHCQ2f24EmyQs4C3xfftDsBoWAVWJvj/b2UBsXgEXicV7V7FDbFOQ2Hfp
	JFgNp4CrxNQvG1lBbCGgmh2vHjFNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83
	s0QvNaV0EyMkWPh2MLavlznEKMDBqMTDe0BiW5AQa2JZcWXuIUZJDiYlUV7uCUAhvqT8lMqM
	xOKM+KLSnNTiQ4wSHMxKIrxrXIFyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUw
	WRkODiUJXm+QoYJFqempFWmZOSUIaSYOThDBBbKBB2hDKkghb3FBYm5xZjpE0SlGRSlx3h6Q
	hABIIqM0D24ALK5fMYoD/SPMmwFSxQNMCXDdr4AGMwENNl67CWRwSSJCSqqBsUz/t0Bjpm7N
	FLW9176f+uAZuagtS189gp+tvdjk+YElbPNm2k/9seXa14llNxe6Gux+NjfvRc3LHfkrvFqa
	8krqcvU/t3vsVPS8dWR7f3rf8p/zj8wOda+IbVHneO4q+Hx68/vZH7LdeaR37hLaqrrCr3nN
	8q+ps84cuXl34ZzQGhbNcK6QOUosxRmJhlrMRcWJAAEK8cjGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239634>

Keep track of the position of the slash character separately, and
restore the slash character at a single place, at the end of the while
loop.  This makes the next change easier to implement.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index cc9957e..dcfd35a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -107,40 +107,40 @@ int mkdir_in_gitdir(const char *path)
 
 int safe_create_leading_directories(char *path)
 {
-	char *pos = path + offset_1st_component(path);
+	char *next_component = path + offset_1st_component(path);
+	int retval = 0;
 
-	while (pos) {
+	while (!retval && next_component) {
 		struct stat st;
+		char *slash = strchr(next_component, '/');
 
-		pos = strchr(pos, '/');
-		if (!pos)
-			break;
-		while (*++pos == '/')
-			;
-		if (!*pos)
-			break;
-		*--pos = '\0';
+		if (!slash)
+			return 0;
+		while (*(slash + 1) == '/')
+			slash++;
+		next_component = slash + 1;
+		if (!*next_component)
+			return 0;
+
+		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
 			if (!S_ISDIR(st.st_mode)) {
-				*pos = '/';
-				return -3;
+				retval = -3;
 			}
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
 				; /* somebody created it since we checked */
 			} else {
-				*pos = '/';
-				return -1;
+				retval = -1;
 			}
 		} else if (adjust_shared_perm(path)) {
-			*pos = '/';
-			return -2;
+			retval = -2;
 		}
-		*pos++ = '/';
+		*slash = '/';
 	}
-	return 0;
+	return retval;
 }
 
 int safe_create_leading_directories_const(const char *path)
-- 
1.8.5.1
