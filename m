From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 29/38] resolve_symlink(): use a strbuf for internal scratch space
Date: Wed,  1 Oct 2014 12:28:33 +0200
Message-ID: <1412159322-2622-30-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAF-0002kF-UC
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbaJAK3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:42 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42567 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751729AbaJAK3k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:40 -0400
X-AuditID: 12074414-f79446d000001f1d-97-542bd7934018
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 57.61.07965.397DB245; Wed,  1 Oct 2014 06:29:39 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6S026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:37 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1J18XTvE4OYnCYuuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDM67q1lKWjgqzjee4ytgXEeVxcj
	J4eEgInEozW7WSFsMYkL99azdTFycQgJXGaU2HngFCuEc5xJonHROTaQKjYBXYlFPc1MILaI
	gJrExLZDLCBFzAKLmSQmHNoEViQsECKx/303M4jNIqAqsffKEjCbV8BF4vHxC4wQ6+QkNuz+
	D2ZzAsWXX25mAbGFBJwldtz5yjSBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzM
	Er3UlNJNjJBwFNnBeOSk3CFGAQ5GJR5ehQTtECHWxLLiytxDjJIcTEqivIsuAYX4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8GYfAMrxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwMlwDahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRUd8MTA+QFI8QHud
	Qdp5iwsSc4GiEK2nGHU51nV+62cSYsnLz0uVEufNBCkSACnKKM2DWwFLPq8YxYE+FuYNB6ni
	ASYuuEmvgJYwAS1JXgO2pCQRISXVwCh0MCuYY0WxXFy1ybavdgILLW7afpa5d9Fysc8qt9eL
	YvJtrn23bX+Y51fKcnBbn9enPS5HL12dlN+ZcFtwW7WKzJ+6hiN1TbKbyiw2Kazf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257712>

Aside from shortening and simplifying the code, this removes another
place where the path name length is arbitrarily limited.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 85c8648..cc9b9cb 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -126,44 +126,35 @@ static char *last_path_elm(char *p)
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
