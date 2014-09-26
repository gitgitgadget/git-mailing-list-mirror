From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 19/39] close_lock_file(): if close fails, roll back
Date: Fri, 26 Sep 2014 12:08:19 +0200
Message-ID: <1411726119-31598-20-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTK-0004Bi-AN
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186AbaIZKJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:26 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63123 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755766AbaIZKJW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:22 -0400
X-AuditID: 1207440c-f79036d000005e77-0a-54253b51c085
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 34.55.24183.15B35245; Fri, 26 Sep 2014 06:09:21 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM4013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:20 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1A20Vg0x2LLM0KLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oz/x1pZCyZKVzRuP8/cwPhBtIuR
	k0NCwETix/qPjBC2mMSFe+vZuhi5OIQELjNKzG6cygzhbGKSOLT/FTtIFZuArsSinmYmEFtE
	QE1iYtshFpAiZoHFTBITDm1iA0kIC7hJdDQvYgWxWQRUJSavvALWzCvgKnFu/l9WiHVyEht2
	/wdbzQkUb9x+DcwWEnCRaFk/mWUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZ
	JXqpKaWbGCHhyLOD8ds6mUOMAhyMSjy8DWtUQoRYE8uKK3MPMUpyMCmJ8n6xUA0R4kvKT6nM
	SCzOiC8qzUktPsQowcGsJMJ7xwgox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoE
	k5Xh4FCS4C2yAmoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VHfDEwPkBSPEB7
	20HaeYsLEnOBohCtpxh1OdZ1futnEmLJy89LlRLnPWIJVCQAUpRRmge3ApZ8XjGKA30szOsL
	MooHmLjgJr0CWsIEtETpiDLIkpJEhJRUA2OmqltKzg/JqKBPrXEiyV+YyjbNmPxz/9NHcxxc
	JKs+7w3yeTv986tSfZXTzhvu+dXM7uTJ5Vhdt7j4840SCVeR/pD3ac9UwgW+9qx/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257514>

If closing an open lockfile fails, then we cannot be sure of the
contents of the lockfile, so there is nothing sensible to do but
delete it. This change also insures that the lock_file object is left
in a defined state in this error path (namely, unlocked).

The only caller that is ultimately affected by this change is
try_merge_strategy() -> write_locked_index(), which can call
close_lock_file() via various execution paths. This caller uses a
static lock_file object which previously could have been reused after
a failed close_lock_file() even though it was still in locked state.
This change causes the lock_file object to be unlocked on failure,
thus fixing this error-handling path.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt |  7 ++++---
 lockfile.c                               | 28 ++++++++++++++++++----------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 0f81e53..7f04db2 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -161,6 +161,7 @@ close_lock_file::
 	Take a pointer to the `struct lock_file` initialized with an
 	earlier call to `hold_lock_file_for_update` or
 	`hold_lock_file_for_append`, and close the file descriptor.
-	Return 0 upon success or a negative value on failure to
-	close(2). Usually `commit_lock_file` or `rollback_lock_file`
-	should be called after `close_lock_file`.
+	Return 0 upon success. On failure to `close(2)`, return a
+	negative value and rollback the lock file. Usually
+	`commit_lock_file` or `rollback_lock_file` should eventually
+	be called if `close_lock_file` succeeds.
diff --git a/lockfile.c b/lockfile.c
index c897dd8..1d18c67 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -37,13 +37,14 @@
  *   lockfile, and owner holds the PID of the process that locked the
  *   file.
  *
- * - Locked, lockfile closed (after close_lock_file()).  Same as the
- *   previous state, except that the lockfile is closed and fd is -1.
+ * - Locked, lockfile closed (after successful close_lock_file()).
+ *   Same as the previous state, except that the lockfile is closed
+ *   and fd is -1.
  *
- * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
- *   failed attempt to lock).  In this state, filename[0] == '\0' and
- *   fd is -1.  The object is left registered in the lock_file_list,
- *   and on_list is set.
+ * - Unlocked (after commit_lock_file(), rollback_lock_file(), a
+ *   failed attempt to lock, or a failed close_lock_file()). In this
+ *   state, filename[0] == '\0' and fd is -1. The object is left
+ *   registered in the lock_file_list, and on_list is set.
  */
 
 static struct lock_file *lock_file_list;
@@ -284,7 +285,13 @@ int close_lock_file(struct lock_file *lk)
 		return 0;
 
 	lk->fd = -1;
-	return close(fd);
+	if (close(fd)) {
+		int save_errno = errno;
+		rollback_lock_file(lk);
+		errno = save_errno;
+		return -1;
+	}
+	return 0;
 }
 
 int reopen_lock_file(struct lock_file *lk)
@@ -330,7 +337,8 @@ void rollback_lock_file(struct lock_file *lk)
 	if (!lk->filename[0])
 		return;
 
-	close_lock_file(lk);
-	unlink_or_warn(lk->filename);
-	lk->filename[0] = 0;
+	if (!close_lock_file(lk)) {
+		unlink_or_warn(lk->filename);
+		lk->filename[0] = 0;
+	}
 }
-- 
2.1.0
