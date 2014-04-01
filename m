From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/22] lock_file(): always add lock_file object to lock_file_list
Date: Tue,  1 Apr 2014 17:58:15 +0200
Message-ID: <1396367910-7299-8-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16y-0005wl-Be
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbaDAQAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 12:00:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56291 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751814AbaDAP6r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:47 -0400
X-AuditID: 12074413-f79076d000002d17-c0-533ae236dda6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C8.58.11543.632EA335; Tue,  1 Apr 2014 11:58:46 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbB027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:45 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqGv2yCrYYPkCfYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3Req6NuWC3QMW+bW+ZGhhX8nYxcnJICJhIHJp0nx3CFpO4cG89WxcjF4eQwGVGiWcP
	9jNBOMeYJP79fsYIUsUmoCuxqKeZCcQWEVCTmNh2iAXEZhZIkXj1dxeYLSwQKNF5bgKYzSKg
	KnGubytYPa+As8S+PS2MENvkJKb8XgC2mVPAReLSgz2sILYQUM3pN4uZJzDyLmBkWMUol5hT
	mqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokRElTCOxh3nZQ7xCjAwajEw3vgvFWwEGti
	WXFl7iFGSQ4mJVHeH3eBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4Z90EyvGmJFZWpRblw6Sk
	OViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHijHgI1ChalpqdWpGXmlCCkmTg4QYZzSYkU
	p+alpBYllpZkxINiI74YGB0gKR6gvdNB2nmLCxJzgaIQracYFaXEeUNAEgIgiYzSPLixsFTx
	ilEc6Eth3sUgVTzANAPX/QpoMBPQYO51YINLEhFSUg2M3pIffwV8MD5p1XCyZT2v7IFljg8m
	vd1l5L7uSOekD88jY2qt9T55/5z3R+vjJP4gYFyJhB5fJHFGQEvlSg3zNJUtOUveTXlQmKSo
	xJDYoXCKmXOajlgYd5XY0gUv3B5qPHJsstOc7bL77/w0T41rZ0MNuxfXBLeKlfze 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245610>

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
 lockfile.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index e679e4c..c989f6c 100644
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
+	lk->owner = getpid();
+	if (!lk->on_list) {
+		/* Initialize *lk and add it to lock_file_list: */
+		lk->fd = -1;
+		lk->on_list = 1;
+		lk->filename[0] = 0;
+		lk->next = lock_file_list;
+		lock_file_list = lk;
+	}
+
 	if (strlen(path) >= max_path_len)
 		return -1;
 	strcpy(lk->filename, path);
@@ -138,16 +154,6 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strcat(lk->filename, ".lock");
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
-		if (!lock_file_list) {
-			sigchain_push_common(remove_lock_file_on_signal);
-			atexit(remove_lock_file);
-		}
-		lk->owner = getpid();
-		if (!lk->on_list) {
-			lk->next = lock_file_list;
-			lock_file_list = lk;
-			lk->on_list = 1;
-		}
 		if (adjust_shared_perm(lk->filename)) {
 			error("cannot fix permission bits on %s", lk->filename);
 			rollback_lock_file(lk);
-- 
1.9.0
