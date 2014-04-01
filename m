From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/22] lockfile.c: document the various states of lock_file objects
Date: Tue,  1 Apr 2014 17:58:18 +0200
Message-ID: <1396367910-7299-11-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16H-0001EQ-OA
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbaDAP7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:02 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45718 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870AbaDAP6w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:52 -0400
X-AuditID: 1207440e-f79c76d000003e2c-45-533ae23bfb4e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.1A.15916.B32EA335; Tue,  1 Apr 2014 11:58:51 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbE027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:50 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqGv9yCrY4OgCKYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3xfdc61oIfYhWLJrxjb2B8KdjFyMEhIWAicfAbbxcjJ5ApJnHh3nq2LkYuDiGBy4wS
	v5q+MYEkhASOMUkcuKkBYrMJ6Eos6mkGi4sIqElMbDvEAmIzC6RIvPq7C8wWFgiWWH77FiuI
	zSKgKjHjfhMLyC5eAReJk3+FIXbJSUz5vYAdxOYECl96sIcVYpWzxOk3i5knMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrrJebWaKXmlK6iRESTnw7GNvXyxxiFOBgVOLhPXDeKliI
	NbGsuDL3EKMkB5OSKO+Pu0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwzHgLleFMSK6tSi/Jh
	UtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvEdBGgWLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJBURFfDIwLkBQP0N7pYHuLCxJzgaIQracYdTluLd/YyCTEkpeflyolzhsC
	UiQAUpRRmge3ApY8XjGKA30szLsYpIoHmHjgJr0CWsIEtIR7HdiSkkSElFQDY4BFxr+MnzKr
	BV9curw17FTk/0vftWY+739fLpSS5poQpfmDc+bUoGif+cfKHbYn72EL47rz3zwka693fuDk
	VxfcF6/gsKpeqbFB/DVT5IJzzFEKT+PUc4wcyre3bVc7L1RXwuJ1mrtO6IHl3Nod 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245603>

Document the valid states of lock_file objects, how they get into each
state, and how the state is encoded in the object's fields.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lockfile.c b/lockfile.c
index 33325a4..4a9ceda 100644
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
+ * - Uninitialized.  In this state the object's flags field must be
+ *   zero but the rest of the contents need not be initialized.  As
+ *   soon as the object is used in any way, it is irrevocably
+ *   registered in the lock_file_list, and flags & LOCK_FLAGS_ON_LIST
+ *   is set.
+ *
+ * - Locked, lockfile open (after hold_lock_file_for_update() or
+ *   hold_lock_file_for_append()).  In this state, the lockfile
+ *   exists, filename holds the filename of the lockfile, fd holds a
+ *   file descriptor open for writing to the lockfile, and owner holds
+ *   the PID of the process that locked the file.
+ *
+ * - Locked, lockfile closed (after close_lock_file()).  Same as the
+ *   previous state, except that the lockfile is closed and fd is -1.
+ *
+ * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
+ *   failed attempt to lock).  In this state, filename[0] == '\0' and
+ *   fd is -1.  The object is left registered in the lock_file_list,
+ *   and flags & LOCK_FLAGS_ON_LIST is set.
+ *
+ * See Documentation/api-lockfile.txt for more information.
+ */
+
 /* Values for lock_file::flags: */
 
 /* This lock_file instance is in the lock_file_list */
-- 
1.9.0
