From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 08/35] lock_file(): always add lock_file object to lock_file_list
Date: Tue, 16 Sep 2014 21:33:29 +0200
Message-ID: <1410896036-12750-9-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydp-0003fJ-RN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155AbaIPTmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:08 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60014 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755134AbaIPTmF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:05 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Sep 2014 15:42:05 EDT
X-AuditID: 1207440d-f797f6d000000a4a-31-541890c36123
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.81.02634.3C098145; Tue, 16 Sep 2014 15:34:27 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcC001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:26 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqHt4gkSIweydwhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8Cd0XdxMlPBQoGKKY8vMzYwdvB2MXJySAiYSBw99ZwR
	whaTuHBvPVsXIxeHkMBlRomOexdYIZwTTBL7vk9lAaliE9CVWNTTzASSEBFoY5TYdXEzWBWz
	QDejxPsTp5lAqoQFQiTurutiBrFZBFQlNnY0gXXzCrhI3Ni9jwlin5zEht3/gXZzcHAKuEp8
	3VcAYgoBlRy86zeBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJDA
	493B+H+dzCFGAQ5GJR5ej0fiIUKsiWXFlbmHGCU5mJREef91S4QI8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuH94QuU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8PIB
	I0xIsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQb8cXA6ABJ8QDt/dgPsre4IDEX
	KArReopRl2Nd57d+JiGWvPy8VClxXhuQIgGQoozSPLgVsDTzilEc6GNh3ncgVTzAFAU36RXQ
	EiagJWd7xECWlCQipKQaGINf8V3J0FyStnrGxnoTAffL3ss/rnvCMvN4178TzewzJnirqd7v
	4DZYpS3obFftyPNuzmU+a+fWT/Ixrsr35/A/cPJ5w1z18tjm7ZOWbzhhrvnxjWrX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257173>

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
index 983c3ec..00c972c 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -129,6 +129,22 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
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
 	if (strlen(path) >= max_path_len) {
 		errno = ENAMETOOLONG;
 		return -1;
@@ -139,16 +155,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
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
 			int save_errno = errno;
 			error("cannot fix permission bits on %s",
-- 
2.1.0
