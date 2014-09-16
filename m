From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 19/35] commit_lock_file(): rollback lock file on failure to rename
Date: Tue, 16 Sep 2014 21:33:40 +0200
Message-ID: <1410896036-12750-20-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydj-0003e3-8s
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbaIPTmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:11 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50610 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755053AbaIPTmI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:08 -0400
X-AuditID: 12074412-f792e6d000005517-24-541890d4dce8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 99.45.21783.4D098145; Tue, 16 Sep 2014 15:34:44 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcN001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:43 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqHtlgkSIwZLZWhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdsbzrL0vBEa6K1TP2szUwbuHoYuTkkBAwkVj85hoz
	hC0mceHeerYuRi4OIYHLjBLNC1pYIZwTTBIz1h1gBaliE9CVWNTTzASSEBFoY5TYdXEzWBWz
	QDejxPsTp5lAqoQFQiWm7HgDNIuDg0VAVWLZX1OQMK+Aq0TH1z9sEOvkJDbs/s8IUsIJFP+6
	rwDEFBJwkTh4128CI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCFh
	J7SDcf1JuUOMAhyMSjy8Ho/EQ4RYE8uKK3MPMUpyMCmJ8v7rlggR4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJML7wxcox5uSWFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwXuz
	H6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDt/QjSzltckJgL
	FIVoPcWoy7Gu81s/kxBLXn5eqpQ4rw1IkQBIUUZpHtwKWJJ5xSgO9LEw7zuQKh5ggoKb9Apo
	CRPQkrM9YiBLShIRUlINjGpBP6uaHT0DjbO/Htc/4v6iMvHojOksG03uZe1QSTH+O9No8Y2W
	rcKPM24t2x759f5vTyOhmQpuVzgCjTh4O6teqi7aqGSvar9hgq9pyfJFb1zNth5+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257171>

If rename() fails, call rollback_lock_file() to delete the lock file
(in case it is still present) and reset the filename field to the
empty string so that the lockfile object is left in a valid state.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index becb3da..6ae5c84 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -311,25 +311,29 @@ int reopen_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
+	int save_errno;
 
 	if (!lk->filename[0])
 		die("BUG: attempt to commit unlocked object");
 
-	if (lk->fd >= 0 && close_lock_file(lk)) {
-		int save_errno = errno;
-		rollback_lock_file(lk);
-		errno = save_errno;
-		return -1;
-	}
+	if (lk->fd >= 0 && close_lock_file(lk))
+		goto rollback;
 
 	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
 	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
 
 	if (rename(lk->filename, result_file))
-		return -1;
+		goto rollback;
+
 	lk->filename[0] = 0;
 	return 0;
+
+rollback:
+	save_errno = errno;
+	rollback_lock_file(lk);
+	errno = save_errno;
+	return -1;
 }
 
 int hold_locked_index(struct lock_file *lk, int die_on_error)
-- 
2.1.0
