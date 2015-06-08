From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/14] commit_lock_file(): use get_locked_file_path()
Date: Mon,  8 Jun 2015 11:07:35 +0200
Message-ID: <54a72741f122826ffc1c7f87941b8d9961bc4642.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2N-0002P6-Kk
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbbFHJIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:05 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45959 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752054AbbFHJH6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:07:58 -0400
X-AuditID: 12074411-f796c6d000000bc9-da-55755b6d2417
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A0.DB.03017.D6B55755; Mon,  8 Jun 2015 05:07:57 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojS010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:07:56 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqJsbXRpqMOeHqkXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7Y9eaJUwF
	UwUqWhreMjUwHuLtYuTkkBAwkZi+9DwjhC0mceHeerYuRi4OIYHLjBKtJ/awQDgnmCSunv3I
	BlLFJqArsainmQnEFhFwlDjx4DoriM0s4CCx+XMj0CQODmEBV4mXU0pBwiwCqhIXX/8CK+cV
	iJJ4OnknK8QyOYnzx38yg9icAhYSv77uYgJpFRIwl/gxl3UCI+8CRoZVjHKJOaW5urmJmTnF
	qcm6xcmJeXmpRbqmermZJXqpKaWbGCHBI7iDccZJuUOMAhyMSjy8BxaVhAqxJpYVV+YeYpTk
	YFIS5f0YURoqxJeUn1KZkVicEV9UmpNafIhRgoNZSYSXyQIox5uSWFmVWpQPk5LmYFES5+Vb
	ou4nJJCeWJKanZpakFoEk5Xh4FCS4DWPAmoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUos
	LcmIB8VFfDEwMkBSPEB7G0DaeYsLEnOBohCtpxgVpcR5v0UCJQRAEhmleXBjYSnhFaM40JfC
	vDYg7TzAdALX/QpoMBPQ4O9fi0EGlyQipKQaGCfF3dc9VTbrxr7AT2f8pqV4sDWfnc2g9Fl7
	4Wn5Ut/jGoWLHr4XdbmTV/U+RjyqV9ZY4e2C7rsXAn+9j37Vcb+o79WW4sw1W77syC/m1Vg/
	e845rQ9zfgdeaZ9QftD4q+vm+Z+qLy3wUlMwPxf62yhEtPr4nT3+MUezDqbs3ac0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270995>

First beef up the sanity checking in get_locked_file_path() to match
that in commit_lock_file(). Then rewrite commit_lock_file() to use
get_locked_file_path() for its pathname computation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index c2d6ad1..7d04ed1 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -232,8 +232,11 @@ char *get_locked_file_path(struct lock_file *lk)
 {
 	if (!lk->tempfile.active)
 		die("BUG: get_locked_file_path() called for unlocked object");
-	if (lk->tempfile.filename.len <= LOCK_SUFFIX_LEN)
+	if (lk->tempfile.filename.len <= LOCK_SUFFIX_LEN ||
+	    strcmp(lk->tempfile.filename.buf + lk->tempfile.filename.len - LOCK_SUFFIX_LEN,
+		   LOCK_SUFFIX))
 		die("BUG: get_locked_file_path() called for malformed lock object");
+	/* remove ".lock": */
 	return xmemdupz(lk->tempfile.filename.buf, lk->tempfile.filename.len - LOCK_SUFFIX_LEN);
 }
 
@@ -244,23 +247,16 @@ int commit_lock_file_to(struct lock_file *lk, const char *path)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	static struct strbuf result_file = STRBUF_INIT;
-	int err;
+	char *result_path = get_locked_file_path(lk);
 
-	if (!lk->tempfile.active)
-		die("BUG: attempt to commit unlocked object");
-
-	if (lk->tempfile.filename.len <= LOCK_SUFFIX_LEN ||
-	    strcmp(lk->tempfile.filename.buf + lk->tempfile.filename.len - LOCK_SUFFIX_LEN,
-		   LOCK_SUFFIX))
-		die("BUG: lockfile filename corrupt");
-
-	/* remove ".lock": */
-	strbuf_add(&result_file, lk->tempfile.filename.buf,
-		   lk->tempfile.filename.len - LOCK_SUFFIX_LEN);
-	err = commit_lock_file_to(lk, result_file.buf);
-	strbuf_reset(&result_file);
-	return err;
+	if (commit_lock_file_to(lk, result_path)) {
+		int save_errno = errno;
+		free(result_path);
+		errno = save_errno;
+		return -1;
+	}
+	free(result_path);
+	return 0;
 }
 
 void rollback_lock_file(struct lock_file *lk)
-- 
2.1.4
