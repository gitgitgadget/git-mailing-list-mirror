From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 08/32] lock_file(): always add lock_file object to lock_file_list
Date: Sat,  6 Sep 2014 09:50:22 +0200
Message-ID: <1409989846-22401-9-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnI-0000CU-Ni
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbaIFHwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:19 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44680 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863AbaIFHwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:09 -0400
X-AuditID: 12074414-f79446d000001f1d-0c-540abd29dba2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 94.9A.07965.92DBA045; Sat,  6 Sep 2014 03:52:09 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH7006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:08 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqKu5lyvE4MRefouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujL6Lk5kKFgpUTHl8mbGBsYO3i5GTQ0LARGL9m22sELaYxIV769m6
	GLk4hAQuM0rMeziRBcI5xiTx4P8vFpAqNgFdiUU9zUwgCRGBNkaJXRc3g7UzC6RIdDzvZgSx
	hQVCJA4df8sOYrMIqEqcX30ZLM4r4CKx9thLNoh1chIbdv8Hi3MKuEpMb+oEs4WAatpP9jNN
	YORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMk1ER2MB45KXeIUYCD
	UYmHt8CBK0SINbGsuDL3EKMkB5OSKG/ecqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6OyUA5
	3pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJ3r7dQI2CRanpqRVpmTkl
	CGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiILwbGB0iKB2jvWZB23uKCxFygKETrKUZdjnWd3/qZ
	hFjy8vNSpcR57+wCKhIAKcoozYNbAUssrxjFgT4W5r0PMooHmJTgJr0CWsIEtMQ8nRNkSUki
	QkqqgTEgM/XE/R2JbWcuOGRuNyu53iz3qO6GvsmcWPVFtz9tfFe72qhtzq3+cn+dCtb5D6wD
	OxX+rCwwaV9dohWzosj7q+60wu2nA+23nQqK6FixRmOSUGuZhXPfldU1is9Ksv32 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256553>

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
