From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/25] resolve_symlink(): use a strbuf for internal scratch space
Date: Mon,  7 Apr 2014 01:34:05 +0200
Message-ID: <1396827247-28465-24-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc6-00074B-P0
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbaDFXgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:16 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53215 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754666AbaDFXf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:27 -0400
X-AuditID: 1207440e-f79c76d000003e2c-a0-5341e4be9c34
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 61.39.15916.EB4E1435; Sun,  6 Apr 2014 19:35:26 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbXA011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:24 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqLvviWOwwf1tUhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO2PXr8dMBQ18Fb/WNrA1MM7j6mLk4JAQMJHo2VTW
	xcgJZIpJXLi3nq2LkYtDSOAyo8S5U8eZIJzjTBKn/vxkAaliE9CVWNTTzARiiwioSUxsO8QC
	UsQscINR4t2+w2BFwgIhEh1X3rCDbGARUJW4P5kPJMwr4Cqx89VFJohtchInj01mBbE5geLr
	Js8FaxUScAEac49tAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxgh
	gce3g7F9vcwhRgEORiUe3hWHHIOFWBPLiitzDzFKcjApifJa3gMK8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuE9cAMox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4D36
	GKhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDtvQjSzltckJgL
	FIVoPcWoKCXOO/MRUEIAJJFRmgc3FpZOXjGKA30pzLsMpJ0HmIrgul8BDWYCGtwQZgcyuCQR
	ISXVwDhxn1FUy2eOeuuPQrfX3zv0QvkM28Xk8i//XIJnHNp55k2z3TaPvMLZiYYy19b/qCx5
	k7m1Nt7X56/5T/bzqqeNd0xJ+H/KUdOre6bzPcM9LBuDlwhvqv7pwVPHv73u8/k3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245820>

Aside from shortening and simplifying the code, this removes another
place where the path name length is arbitrarily limited.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 3befd7e..c4e32a9 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -150,44 +150,35 @@ static char *last_path_elm(char *p)
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
1.9.1
