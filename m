From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 10/39] lockfile.c: document the various states of lock_file objects
Date: Fri, 26 Sep 2014 12:08:10 +0200
Message-ID: <1411726119-31598-11-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSSg-0003cB-Os
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbaIZKJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:11 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53323 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755664AbaIZKJH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:07 -0400
X-AuditID: 1207440e-f79da6d0000002fc-2d-54253b43067b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CA.49.00764.34B35245; Fri, 26 Sep 2014 06:09:07 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLt013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:05 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1HW2Vg0xeLJayKLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oynP38xFewXrliyp4e9gXE1fxcj
	J4eEgIlEw5vTTBC2mMSFe+vZuhi5OIQELjNKLDzylRHC2cQksXfOalaQKjYBXYlFPc1gHSIC
	ahIT2w6xgBQxCyxmkphwaBMbSEJYIExi+aUVLCA2i4CqxMU969hBbF4BV4k9my+zQ6yTk9iw
	+z8jiM0JFG/cfg3MFhJwkWhZP5llAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5
	mSV6qSmlmxgh4ci3g7F9vcwhRgEORiUe3hvrVEKEWBPLiitzDzFKcjApifJ+sVANEeJLyk+p
	zEgszogvKs1JLT7EKMHBrCTCe8cIKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBa
	BJOV4eBQkuAtsgJqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFR3wxMD5AUjxA
	ez1A2nmLCxJzgaIQracYdTnWdX7rZxJiycvPS5US5z1iCVQkAFKUUZoHtwKWfF4xigN9LMzr
	CzKKB5i44Ca9AlrCBLRE6YgyyJKSRISUVAPjrO2Jxhlmc66tufubLX/RAjuvvn0bWX8qu3wP
	EF125eemY7OYfCZoxZ2zcVw7sSl729TV9sduu/sqFeg8WxWwKiO+mNU1XMU2Mkm4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257507>

Document the valid states of lock_file objects, how they get into each
state, and how the state is encoded in the object's fields.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 lockfile.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lockfile.c b/lockfile.c
index 81143e5..2680dc9 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -4,6 +4,48 @@
 #include "cache.h"
 #include "sigchain.h"
 
+/*
+ * File write-locks as used by Git.
+ *
+ * For an overview of how to use the lockfile API, please see
+ *
+ *     Documentation/technical/api-lockfile.txt
+ *
+ * This module keeps track of all locked files in lock_file_list for
+ * use at cleanup. This list and the lock_file objects that comprise
+ * it must be kept in self-consistent states at all time, because the
+ * program can be interrupted any time by a signal, in which case the
+ * signal handler will walk through the list attempting to clean up
+ * any open lock files.
+ *
+ * A lockfile is owned by the process that created it. The lock_file
+ * object has an "owner" field that records its owner. This field is
+ * used to prevent a forked process from closing a lockfile created by
+ * its parent.
+ *
+ * A lock_file object can be in several states:
+ *
+ * - Uninitialized.  In this state the object's on_list field must be
+ *   zero but the rest of its contents need not be initialized.  As
+ *   soon as the object is used in any way, it is irrevocably
+ *   registered in the lock_file_list, and on_list is set.
+ *
+ * - Locked, lockfile open (after hold_lock_file_for_update(),
+ *   hold_lock_file_for_append(), or reopen_lock_file()). In this
+ *   state, the lockfile exists, filename holds the filename of the
+ *   lockfile, fd holds a file descriptor open for writing to the
+ *   lockfile, and owner holds the PID of the process that locked the
+ *   file.
+ *
+ * - Locked, lockfile closed (after close_lock_file()).  Same as the
+ *   previous state, except that the lockfile is closed and fd is -1.
+ *
+ * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
+ *   failed attempt to lock).  In this state, filename[0] == '\0' and
+ *   fd is -1.  The object is left registered in the lock_file_list,
+ *   and on_list is set.
+ */
+
 static struct lock_file *lock_file_list;
 
 static void remove_lock_file(void)
-- 
2.1.0
