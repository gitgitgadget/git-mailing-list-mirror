From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/25] lock_file(): always add lock_file object to lock_file_list
Date: Mon,  7 Apr 2014 01:33:49 +0200
Message-ID: <1396827247-28465-8-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbO-000602-PI
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbaDFXfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:40 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61995 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754598AbaDFXe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:56 -0400
X-AuditID: 12074412-f79d46d000002e58-99-5341e49f8629
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C4.8D.11864.F94E1435; Sun,  6 Apr 2014 19:34:55 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWs011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:53 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqDv/iWOwwbFfshZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO6Nt6QLGgs0CFacnTGJvYJzP28XIySEhYCJx6s5x
	dghbTOLCvfVsXYxcHEIClxklVs7rZIJwjjNJ3LnUzgRSxSagK7GopxnMFhFQk5jYdogFpIhZ
	4AajxLt9h1lAEsICIRJ77ixkBbFZBFQltj+eBWbzCrhIrHv1jRVinZzEyWOTwWxOAVeJdZPn
	gvUKAdW823ePbQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYIcEn
	tINx/Um5Q4wCHIxKPLwrDjkGC7EmlhVX5h5ilORgUhLltbwHFOJLyk+pzEgszogvKs1JLT7E
	KMHBrCTCe+AGUI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYK37zFQ
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoOuKLgfEBkuIB2hsB0s5bXJCYCxSF
	aD3FqCglzjvzEVBCACSRUZoHNxaWUl4xigN9KcxrANLOA0xHcN2vgAYzAQ1uCLMDGVySiJCS
	Asa5QPHKiWutpbdtXmBsYNw6x/Ddd+N9JtEZ0b+/7uaO1HflnRD67d/p7oz/i87JPn21gvP0
	gcqpcw8lVrM78EaFHF9/7WJ5usmjyQkLVO7+stI5Fnq9vmnB5Ede9fPK35SvP2HN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245809>

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
