From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/22] lock_file(): exit early if lockfile cannot be opened
Date: Tue,  1 Apr 2014 17:58:25 +0200
Message-ID: <1396367910-7299-18-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16C-0008Th-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbaDAP7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60167 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870AbaDAP7D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:59:03 -0400
X-AuditID: 12074414-f79d96d000002d2b-19-533ae2465041
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 85.2D.11563.642EA335; Tue,  1 Apr 2014 11:59:02 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbL027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:59:01 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqOv2yCrY4OI2QYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ1x8OZFtoLDHBWH1n1gbmB8x9bFyMkhIWAi8fxTDzOELSZx4d56oDgXh5DAZUaJFZ3/
	mSCcY0wSP2bPZgKpYhPQlVjU0wxmiwioSUxsO8QCYjMLpEi8+rsLyObgEBbwlrj5URIkzCKg
	KtF28BDYAl4BF4kNp99DLZOTmPJ7ATuIzQkUv/RgDyuILSTgLHH6zWLmCYy8CxgZVjHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKEhJTIDsYjJ+UOMQpwMCrx8B48bxUsxJpY
	VlyZe4hRkoNJSZT3x12gEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeWTeBcrwpiZVVqUX5MClp
	DhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErzXHgA1ChalpqdWpGXmlCCkmTg4QYZzSYkU
	p+alpBYllpZkxIMiI74YGBsgKR6gvY9A2nmLCxJzgaIQracYFaXEeVlAEgIgiYzSPLixsETx
	ilEc6Eth3vcgVTzAJAPX/QpoMBPQYO51YINLEhFSUg2MvLM+vzzw7G7+1atvs7wPvmOZ+WGj
	bkp72gyXhnxp5yM7PnU/l9nr0ze196bXxcnfshK6vynXbtXZv2r39+fr/gYWCkTa375o9eXj
	q5Ie4/SFxU3bXB5HnFBxWHdTTyA1bKXd3g3f77U3GffHyzVpL/5+cdbh1+sfJ7Fs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245602>

This is a bit easier to read than the old version, which nested part
of the non-error code in an "if" block.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index c1ca5b1..87b40c4 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -182,15 +182,16 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strbuf_addstr(&lk->lock_filename, ".lock");
 
 	lk->fd = open(lk->lock_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (0 <= lk->fd) {
-		if (adjust_shared_perm(lk->lock_filename.buf)) {
-			error("cannot fix permission bits on %s", lk->lock_filename.buf);
-			rollback_lock_file(lk);
-			return -1;
-		}
-	}
-	else
+	if (lk->fd < 0) {
 		strbuf_setlen(&lk->lock_filename, 0);
+		return -1;
+	}
+	if (adjust_shared_perm(lk->lock_filename.buf)) {
+		error("cannot fix permission bits on %s", lk->lock_filename.buf);
+		rollback_lock_file(lk);
+		return -1;
+	}
+
 	return lk->fd;
 }
 
-- 
1.9.0
