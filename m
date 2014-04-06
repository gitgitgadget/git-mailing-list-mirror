From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/25] lockfile.c: document the various states of lock_file objects
Date: Mon,  7 Apr 2014 01:33:51 +0200
Message-ID: <1396827247-28465-10-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbP-000602-Rl
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbaDFXfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:43 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54077 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754613AbaDFXfA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:00 -0400
X-AuditID: 12074411-f79ab6d000002f0e-b5-5341e4a33ef1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D5.2F.12046.3A4E1435; Sun,  6 Apr 2014 19:34:59 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWu011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:57 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixO6iqLv4iWOwwcp9ohZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO2PFjS1MBT/EKlpmnGBtYHwp2MXIySEhYCJx4MEB
	RghbTOLCvfVsXYxcHEIClxklpi9vZoFwjjNJTGqewgZSxSagK7Gop5kJxBYRUJOY2HYIrIhZ
	4AajxLt9h1lAEsICYRJzPraBFbEIqEpM3jgHLM4r4Cqx4EwXG8Q6OYmTxyazgticQPF1k+eC
	1QgJuADNucc2gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQ4BPc
	wTjjpNwhRgEORiUe3hWHHIOFWBPLiitzDzFKcjApifJa3gMK8SXlp1RmJBZnxBeV5qQWH2KU
	4GBWEuE9cAMox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4O17DNQo
	WJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qO+GJgfICkeID2Tgdp5y0uSMwFikK0
	nmLU5bi1fGMjkxBLXn5eqpQ478xHQEUCIEUZpXlwK2Cp5hWjONDHwrzLQEbxANMU3KRXQEuY
	gJY0hNmBLClJREhJNTDmX14g5vJs052Dp5UWrP18t2LHLsOqasNX6j98Vt7NPrTEqf1Y4IvO
	jZvtwhh8D6hrrGH79aro5Je1dzuEj0VU+M1TrYu9tjH/0m4TQTnf7blhD5N+bGiT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245807>

Document the valid states of lock_file objects, how they get into each
state, and how the state is encoded in the object's fields.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lockfile.c b/lockfile.c
index 0486c58..2438430 100644
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
+ *   zero but the rest of its contents need not be initialized.  As
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
1.9.1
