From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 09/39] lock_file(): always initialize and register lock_file object
Date: Fri, 26 Sep 2014 12:08:09 +0200
Message-ID: <1411726119-31598-10-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:16:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSa9-0002oT-E7
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbaIZKQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:16:47 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47268 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755391AbaIZKQq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:16:46 -0400
X-AuditID: 1207440d-f797f6d000000a4a-c9-54253b418dcf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.5E.02634.14B35245; Fri, 26 Sep 2014 06:09:05 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLs013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:04 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1HW0Vg0x2H9N16LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyuQ69ZC3aKVnw7tZSpgXGZYBcj
	J4eEgInE7v6d7BC2mMSFe+vZuhi5OIQELjNKzH97mxXC2cQk8bWhHayKTUBXYlFPMxOILSKg
	JjGx7RALSBGzwGImiQmHNrGBJIQFwiT2HXzKCmKzCKhK/P5zl7GLkYODV8BVovN/JMQ2OYkN
	u/8zgticQOHG7dfAbCEBF4mW9ZNZJjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6SX
	m1mil5pSuokREoy8Oxj/r5M5xCjAwajEw3tjnUqIEGtiWXFl7iFGSQ4mJVHeLxaqIUJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeO8YAeV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK8Fy2BGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRFfDIwOkBQP
	0F4uK5C9xQWJuUBRiNZTjLoc6zq/9TMJseTl56VKifMeAdkhAFKUUZoHtwKWel4xigN9LMx7
	A6SKB5i24Ca9AlrCBLRE6YgyyJKSRISUVAOjurWz0NtqttPHgs58Laqf1BY1b52jXmMha5LC
	Wv5oDp62/9bHdYttLwj913WLPspYdebR7OTtaoKXjIMLbuy6v9Bii2pNquGCVnsR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257533>

The purpose of this patch is to make the state diagram for lock_file
objects simpler and deterministic.

If locking fails, lock_file() sometimes leaves the lock_file object
partly initialized, but sometimes not. It sometimes registers the
object in lock_file_list, but sometimes not. This makes the state
diagram for lock_file objects effectively indeterministic and hard to
reason about. A future patch will also change the filename field into
a strbuf, which needs more involved initialization, so it will become
even more important that the state of a lock_file object is
well-defined after a failed attempt to lock.

The ambiguity doesn't currently have any ill effects, because
lock_file objects cannot be removed from the lock_file_list anyway.
But to make it easier to document and reason about the code, make this
behavior inconsistent: *always* initialize the lock_file object and
*always* register it in lock_file_list the first time it is used,
regardless of whether an error occurs.

While we're at it, make sure that all of the lock_file fields are
initialized to values appropriate for an unlocked object; the caller
is only responsible for making sure that on_list is set to zero before
the first time it is used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f4ce79b..81143e5 100644
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
+		lk->filename[0] = 0;
+		lk->next = lock_file_list;
+		lock_file_list = lk;
+		lk->on_list = 1;
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
