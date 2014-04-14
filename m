From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/25] lock_file(): always add lock_file object to lock_file_list
Date: Mon, 14 Apr 2014 15:54:37 +0200
Message-ID: <1397483695-10888-8-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMA-0000Ae-CS
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbaDNNzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:21 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48563 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755102AbaDNNzS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:18 -0400
X-AuditID: 1207440e-f79c76d000003e2c-d6-534be8c5cced
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F6.7E.15916.5C8EB435; Mon, 14 Apr 2014 09:55:17 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt097010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:16 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHv0hXewwc7LmhZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGe0LV3AWLBZoOL0hEnsDYzzebsY
	OTkkBEwk1kxZyAxhi0lcuLeerYuRi0NI4DKjxO1dm1ghnJNMEj82XWABqWIT0JVY1NPMBGKL
	CKhJTGw7xAJSxCzQziRxaEcvWEJYIETicW8TmM0ioCox//0MsGZeAReJDTvnsUOsk5M4eWwy
	0AYODk4BV4mFH7JAwkJAJXe/TGGdwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGusV5u
	ZoleakrpJkZIMPLtYGxfL3OIUYCDUYmHt2OOd7AQa2JZcWXuIUZJDiYlUd6MG0AhvqT8lMqM
	xOKM+KLSnNTiQ4wSHMxKIryuW4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUw
	WRkODiUJXvvnQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiILwZGB0iKB2hv
	Ekg7b3FBYi5QFKL1FKOilDhvCUhCACSRUZoHNxaWYl4xigN9KcybBlLFA0xPcN2vgAYzAQ1m
	aQcbXJKIkJJqYMyXXc+YbXJs39oYj8U8P5oWM+x0+CJ88UBgwBS1j++aOxZzfIkpz4vZdeRw
	U6C/Pp/0xL/XGlidz64PmJQfU2lcFfbnwwSLhUKdG/59er7s0SqhPdJnDNltZjgd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246225>

It used to be that if locking failed, lock_file() usually did not
register the lock_file object in lock_file_list but sometimes it did.
This confusion was compounded if lock_file() was called via
hold_lock_file_for_append(), which has its own failure modes.

The ambiguity didn't have any ill effects, because lock_file objects
cannot be removed from the lock_file_list anyway.  But it is
unnecessary to leave this behavior inconsistent.

So change lock_file() to *always* ensure that the lock_file object is
registered in lock_file_list regardless of whether an error occurs.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index e78a35f..120a6d6 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -130,6 +130,22 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	 */
 	static const size_t max_path_len = sizeof(lk->filename) - 5;
 
+	if (!lock_file_list) {
+		/* One-time initialization */
+		sigchain_push_common(remove_lock_file_on_signal);
+		atexit(remove_lock_file);
+	}
+
+	if (!lk->on_list) {
+		/* Initialize *lk and add it to lock_file_list: */
+		lk->fd = -1;
+		lk->owner = 0;
+		lk->on_list = 1;
+		lk->filename[0] = 0;
+		lk->next = lock_file_list;
+		lock_file_list = lk;
+	}
+
 	if (strlen(path) >= max_path_len)
 		return -1;
 	strcpy(lk->filename, path);
@@ -138,16 +154,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strcat(lk->filename, ".lock");
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
-		if (!lock_file_list) {
-			sigchain_push_common(remove_lock_file_on_signal);
-			atexit(remove_lock_file);
-		}
 		lk->owner = getpid();
-		if (!lk->on_list) {
-			lk->next = lock_file_list;
-			lock_file_list = lk;
-			lk->on_list = 1;
-		}
 		if (adjust_shared_perm(lk->filename)) {
 			error("cannot fix permission bits on %s", lk->filename);
 			rollback_lock_file(lk);
-- 
1.9.1
