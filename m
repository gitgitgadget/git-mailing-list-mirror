From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 18/38] close_lock_file(): if close fails, roll back
Date: Wed,  1 Oct 2014 12:28:22 +0200
Message-ID: <1412159322-2622-19-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBK-0003EM-8c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbaJAK3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:23 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53417 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361AbaJAK3V (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:21 -0400
X-AuditID: 12074411-f79d86d000006a97-16-542bd7804ed7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 50.AE.27287.087DB245; Wed,  1 Oct 2014 06:29:20 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6H026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:19 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1G24rh1isOeyukXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BlrT8xmKlgrXTH5yH2WBsZmsS5G
	Tg4JAROJiRtXsULYYhIX7q1n62Lk4hASuMwosX3bKyjnOJPEyQfPGUGq2AR0JRb1NDOB2CIC
	ahIT2w6xgBQxCyxmkphwaBMbSEJYwE2i4ckqsCIWAVWJ7YvXgdm8Ai4S7z/9YIRYJyexYfd/
	MJsTKL78cjMLiC0k4Cyx485XpgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW
	6KWmlG5ihISj4A7GGSflDjEKcDAq8fAqJGiHCLEmlhVX5h5ilORgUhLlXXQJKMSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmEN/sAUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYr
	w8GhJMHLcA2oUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UHfHFwPgASfEA7XUG
	aectLkjMBYpCtJ5i1OVY1/mtn0mIJS8/L1VKnDcTpEgApCijNA9uBSz5vGIUB/pYmDccpIoH
	mLjgJr0CWsIEtCR5DdiSkkSElFQDY8WcnQdzz8Td+xp83FbO4c69hqnvUh6Y7E3aNt2b0Xnf
	X5OPXwIkZuRIPlX/tvl/c0uAQ2mWweXK3BRf5gtPD2QbdSySu/0kYYHC4gM5wd+u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257729>

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
index 6538610..d3bf940 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -162,9 +162,10 @@ close_lock_file::
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
 
 reopen_lock_file::
 
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
