From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/25] lockfile.c: document the various states of lock_file objects
Date: Mon, 14 Apr 2014 15:54:38 +0200
Message-ID: <1397483695-10888-9-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhNq-0002jL-6X
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbaDNN5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:57:06 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49829 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754809AbaDNNzU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:20 -0400
X-AuditID: 1207440c-f79656d000003eba-d0-534be8c7d752
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 27.47.16058.7C8EB435; Mon, 14 Apr 2014 09:55:19 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt098010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:17 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1D3+wjvY4OAPBYuuK91MFg29V5gt
	Vv6ssbi9Yj6zxa/DT9gtfrT0MFucedPIaNHZ8ZXRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/F
	D7w8Pm+S87j7fyeTx+1n21gCOKK4bZISS8qCM9Pz9O0SuDN6tz5iLzgmVnGq9Q1TA+MxwS5G
	Tg4JAROJA+962SFsMYkL99azdTFycQgJXGaUuPjmADOEc5JJ4vDfu0wgVWwCuhKLeprBbBEB
	NYmJbYdYQIqYBdqZJA7t6AVLCAuESey4vpoFxGYRUJXYNv8kWJxXwEXibeMcNoh1chInj01m
	7WLk4OAUcJVY+CELJCwEVHL3yxTWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurl
	ZpbopaaUbmKEBCPPDsZv62QOMQpwMCrx8HbM8Q4WYk0sK67MPcQoycGkJMqbcQMoxJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYTXdStQjjclsbIqtSgfJiXNwaIkzqu6RN1PSCA9sSQ1OzW1ILUI
	JivDwaEkwbv1OVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg24ouB0QGS4gHa
	mwTSzltckJgLFIVoPcWoy3Fr+cZGJiGWvPy8VClx3hKQIgGQoozSPLgVsNTzilEc6GNh3kUg
	VTzAtAU36RXQEiagJSztYEtKEhFSUg2MhmdElKZclHEoX/CPXe4mCz/r9j17uX6sv8j3/mxy
	/8f8w9/f9p50+LDyEWvXqgyb8pmvr2p/nvfgDeP+Gds1/J51ue7Tcz4dZv1egfX1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246243>

Document the valid states of lock_file objects, how they get into each
state, and how the state is encoded in the object's fields.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/lockfile.c b/lockfile.c
index 120a6d6..8f6652c 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -4,6 +4,57 @@
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
+ *   and on_list is set.
+ *
+ * See Documentation/api-lockfile.txt for more information.
+ */
+
 static struct lock_file *lock_file_list;
 static const char *alternate_index_output;
 
-- 
1.9.1
