From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/25] commit_lock_file(): die() if called for unlocked lockfile object
Date: Mon, 14 Apr 2014 15:54:46 +0200
Message-ID: <1397483695-10888-17-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMO-0000Ty-AR
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbaDNNzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:37 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63326 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754857AbaDNNze (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:34 -0400
X-AuditID: 12074414-f79d96d000002d2b-d0-534be8d51970
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.53.11563.5D8EB435; Mon, 14 Apr 2014 09:55:33 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09G010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:32 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqHv1hXewwdozBhZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGdcmXudueAXT8XzHwfZGhiPcnUx
	cnJICJhIHHjaxQZhi0lcuLceyObiEBK4zChx+uQidpCEkMBJJonv/dYgNpuArsSinmYmEFtE
	QE1iYtshFpAGZoF2JolDO3rBEsICURLHu2cxdjFycLAIqEpcPKQLYvIKuEpsPSwIsUtO4uSx
	yawgYU6g8MIPWRCbXCTufpnCOoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwS
	vdSU0k2MkDAU2cF45KTcIUYBDkYlHt6OOd7BQqyJZcWVuYcYJTmYlER5M24AhfiS8lMqMxKL
	M+KLSnNSiw8xSnAwK4nwum4FyvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnK
	cHAoSfBufQ7UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KivhiYFyApHiA9iaB
	tPMWFyTmAkUhWk8xKkqJ85aAJARAEhmleXBjYcnlFaM40JfCvPdBqniAiQmu+xXQYCagwSzt
	YINLEhFSUg2Mc7Iv7/O/2vT2oeQTyad/ZiZMvND/rNdG2ifQWvaIz3bjaGHhsIucpR2dRbaX
	JunnrJW55mKeZ7euSpmnnOfRNoZHaT63vpV2nst/zHzmaEv0wqWp7+JWKvXGMqkc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246229>

It was previously a bug to call commit_lock_file() with a lock_file
object that was not active (an illegal access would happen within the
function).  It was presumably never done, but this would be an easy
programming error to overlook.  So before continuing, do a consistency
check that the lock_file object really is locked.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 4 +++-
 lockfile.c                               | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index b53e300..9a94ead 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -68,7 +68,9 @@ commit_lock_file::
 	with an earlier call to `hold_lock_file_for_update()`,
 	close the file descriptor and rename the lockfile to its
 	final destination.  Returns 0 upon success, a negative
-	value on failure to close(2) or rename(2).
+	value on failure to close(2) or rename(2).  It is a bug to
+	call `commit_lock_file()` for a `lock_file` object that is not
+	currently locked.
 
 rollback_lock_file::
 
diff --git a/lockfile.c b/lockfile.c
index 664b0c3..1453a7a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -292,6 +292,9 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 
+	if (!lk->filename[0])
+		die("BUG: attempt to commit unlocked object");
+
 	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
 	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
-- 
1.9.1
