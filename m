From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/17] safe_create_leading_directories(): always restore slash at end of loop
Date: Mon,  6 Jan 2014 14:45:24 +0100
Message-ID: <1389015935-21936-7-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:53:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AcS-0001Ka-EX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbaAFNxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:53:24 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60383 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751417AbaAFNxX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:53:23 -0500
X-AuditID: 12074414-b7fb46d000002a4d-ae-52cab3ac00e9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 27.84.10829.CA3BAC25; Mon,  6 Jan 2014 08:46:20 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP7021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:19 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqLtm86kgg//zZCy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgznnd9Yyq4yVMx9fQuxgbG45xdjBwcEgImEpfaeboYOYFMMYkL99azdTFycQgJXGaU
	mDvpLwuEc4xJ4uyMXYwgVWwCuhKLepqZQGwRATWJiW2HwIqYBRYzSnRN+wZWJCyQIHFkVScr
	iM0ioCpxffNHsDivgItE47ldzBCbFSRWXxcCCXMKuEpMm3aYDcQWAipZc+gRywRG3gWMDKsY
	5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQkJKZAfjkZNyhxgFOBiVeHg/PD4Z
	JMSaWFZcmXuIUZKDSUmUl3P1qSAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxcC4ByvCmJlVWp
	RfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvCabgBoFi1LTUyvSMnNKENJMHJwg
	ggtkAw/QhjiQQt7igsTc4sx0iKJTjIpS4rxiIAkBkERGaR7cAFj0v2IUB/pHmNcGpIoHmDjg
	ul8BDWYCGhwaBza4JBEhJdXAqPb7SFM42+Xpm4yc7uUu38L2rOzd/OaG1IVvmkI3ZVe93XPm
	wceXt/Q3zp5+zjc4Qjx5p4WvhNWF/FU63mKWIi1LEgQ45ZodWp6kB7rsSDlsyF41kdPY68JE
	y2qBy9nfVDP55LrDJCz7uSacOGh52FzkwauVXOf38t3OTw9pzjz+Z9aK1uw+JZbi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240008>

Always restore the slash that we scribbled over at the end of the
loop, rather than also fixing it up at each premature exit from the
loop.  This makes it harder to forget to do the cleanup as new paths
are added to the code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f3190c6..4513cbb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -108,8 +108,9 @@ int mkdir_in_gitdir(const char *path)
 int safe_create_leading_directories(char *path)
 {
 	char *next_component = path + offset_1st_component(path);
+	int ret = 0;
 
-	while (next_component) {
+	while (!ret && next_component) {
 		struct stat st;
 		char *slash = strchr(next_component, '/');
 
@@ -125,25 +126,20 @@ int safe_create_leading_directories(char *path)
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
-			if (!S_ISDIR(st.st_mode)) {
-				*slash = '/';
-				return -3;
-			}
+			if (!S_ISDIR(st.st_mode))
+				ret = -3;
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
-			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
+			    !stat(path, &st) && S_ISDIR(st.st_mode))
 				; /* somebody created it since we checked */
-			} else {
-				*slash = '/';
-				return -1;
-			}
+			else
+				ret = -1;
 		} else if (adjust_shared_perm(path)) {
-			*slash = '/';
-			return -2;
+			ret = -2;
 		}
 		*slash = '/';
 	}
-	return 0;
+	return ret;
 }
 
 int safe_create_leading_directories_const(const char *path)
-- 
1.8.5.2
