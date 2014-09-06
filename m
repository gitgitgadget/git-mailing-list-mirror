From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 09/32] lockfile.c: document the various states of lock_file objects
Date: Sat,  6 Sep 2014 09:50:23 +0200
Message-ID: <1409989846-22401-10-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuM-0005Dd-Hu
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbaIFH7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:36 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64343 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbaIFH7f (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:35 -0400
X-AuditID: 12074412-f792e6d000005517-67-540abd2a1a21
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.8E.21783.A2DBA045; Sat,  6 Sep 2014 03:52:10 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH8006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:09 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqKu1lyvE4H+TukXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi86Or4wObB5/339g8nj4qovd41nvHkaPi5eUPT5vkvO4/WwbSwBb
	FLdNUmJJWXBmep6+XQJ3xpEWx4JbYhUrP/1na2C8JtjFyMkhIWAisXHVQUYIW0ziwr31bF2M
	XBxCApcZJb40NbNCOMeYJOacXscGUsUmoCuxqKeZCSQhItDGKLHr4mZWkASzQIpEx/NusFHC
	AmESD77PYAGxWQRUJXp29zGD2LwCrhLLHj1lg1gnJ7Fh93+wek6g+PSmTjBbSMBFov1kP9ME
	Rt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MUICTWgH4/qTcocYBTgY
	lXh4Cxy4QoRYE8uKK3MPMUpyMCmJ8uYtBwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4e2YDJTj
	TUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLgddkD1ChYlJqeWpGWmVOC
	kGbi4AQZziUlUpyal5JalFhakhEPio34YmB0gKR4gPaygrTzFhck5gJFIVpPMRpzTNr4vpeJ
	Y13nt34mIZa8/LxUKXFeJpBSAZDSjNI8uEWwFPOKURzob2FeMZAqHmB6gpv3CmgVE9Aq83RO
	kFUliQgpqQbGZZ/8NQ0L6gW6rp6y6v7y3Mv4uHqWoIHH/msKq1YqTwy1UbwUbCe7cVHcHy51
	u2aR8P1/GrJyMqN7rmvt7dki8HbeA3GbNUUTX5bOqKlcsGj+8Ximybx2BlIHviuw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256573>

Document the valid states of lock_file objects, how they get into each
state, and how the state is encoded in the object's fields.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lockfile.c b/lockfile.c
index 00c972c..964b3fc 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -4,6 +4,58 @@
 #include "cache.h"
 #include "sigchain.h"
 
+/*
+ * File write-locks as used by Git.
+ *
+ * When a file at $FILENAME needs to be written, it is done as
+ * follows:
+ *
+ * 1. Obtain a lock on the file by creating a lockfile at path
+ *    $FILENAME.lock.  The file is opened for read/write using O_CREAT
+ *    and O_EXCL mode to ensure that it doesn't already exist.  Such a
+ *    lock file is respected by writers *but not by readers*.
+ *
+ *    Usually, if $FILENAME is a symlink, then it is resolved, and the
+ *    file ultimately pointed to is the one that is locked and later
+ *    replaced.  However, if LOCK_NODEREF is used, then $FILENAME
+ *    itself is locked and later replaced, even if it is a symlink.
+ *
+ * 2. Write the new file contents to the lockfile.
+ *
+ * 3. Move the lockfile to its final destination using rename(2).
+ *
+ * Instead of (3), the change can be rolled back by deleting lockfile.
+ *
+ * This module keeps track of all locked files in lock_file_list.
+ * When the first file is locked, it registers an atexit(3) handler;
+ * when the program exits, the handler rolls back any files that have
+ * been locked but were never committed or rolled back.
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
+ *
+ * See Documentation/api-lockfile.txt for more information.
+ */
+
 static struct lock_file *lock_file_list;
 
 static void remove_lock_file(void)
-- 
2.1.0
