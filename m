From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 29/32] resolve_symlink(): use a strbuf for internal scratch space
Date: Sat,  6 Sep 2014 09:50:43 +0200
Message-ID: <1409989846-22401-30-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 10:00:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuo-0005XB-WA
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 10:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbaIFIAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 04:00:07 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64348 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751530AbaIFIAF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 04:00:05 -0400
X-AuditID: 12074412-f792e6d000005517-85-540abd473eec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 41.9E.21783.74DBA045; Sat,  6 Sep 2014 03:52:39 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHS006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:38 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqOu+lyvEYM4CZYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujL9NJQUNfBWLt9xhbWCcx9XFyMkhIWAicfnZRyYIW0ziwr31bF2M
	XBxCApcZJbr6/zBDOMeYJG6tfc0KUsUmoCuxqKeZCSQhItDGKLHr4mawBLNAikTH827GLkYO
	DmGBEImLvQUgYRYBVYmLu5Yzgti8Aq4Sq1v2sUJsk5PYsPs/WJwTKD69qRPMFhJwkWg/2c80
	gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQMBPawbj+pNwhRgEO
	RiUe3gIHrhAh1sSy4srcQ4ySHExKorx5y4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHg7JgPl
	eFMSK6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbBZGU4OJQkeF32ADUKFqWmp1akZeaU
	IKSZODhBhnNJiRSn5qWkFiWWlmTEgyIjvhgYGyApHqC9rCDtvMUFiblAUYjWU4y6HOs6v/Uz
	CbHk5eelSonzMoEUCYAUZZTmwa2AJZVXjOJAHwvzioFU8QATEtykV0BLmICWmKdzgiwpSURI
	STUwqpu+az3x7nhIX9sjmcOBrU+n5erkPtn6UWbVhGy+eRN3ddufdz/C+0GfK6BA/eEaf87M
	UvfpJ/KZuhYzRUz9r2HzlrV80xQXjucf1nJeqXvduUleXsbdYRp33MJQuTl/nv0T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256581>

Aside from shortening and simplifying the code, this removes another
place where the path name length is arbitrarily limited.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index c34bf6c..9413f7a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -136,44 +136,35 @@ static char *last_path_elm(char *p)
 static char *resolve_symlink(char *p, size_t s)
 {
 	int depth = MAXDEPTH;
+	static struct strbuf link = STRBUF_INIT;
 
 	while (depth--) {
-		char link[PATH_MAX];
-		int link_len = readlink(p, link, sizeof(link));
-		if (link_len < 0) {
-			/* not a symlink anymore */
-			return p;
-		}
-		else if (link_len < sizeof(link))
-			/* readlink() never null-terminates */
-			link[link_len] = '\0';
-		else {
-			warning("%s: symlink too long", p);
-			return p;
-		}
+		if (strbuf_readlink(&link, p, strlen(p)) < 0)
+			break;
 
-		if (is_absolute_path(link)) {
+		if (is_absolute_path(link.buf)) {
 			/* absolute path simply replaces p */
-			if (link_len < s)
-				strcpy(p, link);
+			if (link.len < s)
+				strcpy(p, link.buf);
 			else {
 				warning("%s: symlink too long", p);
-				return p;
+				break;
 			}
 		} else {
 			/*
-			 * link is a relative path, so I must replace the
+			 * link is a relative path, so replace the
 			 * last element of p with it.
 			 */
 			char *r = (char *)last_path_elm(p);
-			if (r - p + link_len < s)
-				strcpy(r, link);
+			if (r - p + link.len < s)
+				strcpy(r, link.buf);
 			else {
 				warning("%s: symlink too long", p);
-				return p;
+				break;
 			}
 		}
 	}
+	strbuf_reset(&link);
 	return p;
 }
 
-- 
2.1.0
