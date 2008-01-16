From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 11:05:32 -0800
Message-ID: <7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.44.0801152006260.944-100000@demand>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDae-00011h-1C
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYAPTFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYAPTFv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:05:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYAPTFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:05:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB302CAE;
	Wed, 16 Jan 2008 14:05:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F1AA2CAB;
	Wed, 16 Jan 2008 14:05:39 -0500 (EST)
In-Reply-To: <Pine.LNX.4.44.0801152006260.944-100000@demand> (Brandon Casey's
	message of "Tue, 15 Jan 2008 20:11:55 -0600 (CST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70722>

The lockfile API is a handy way to obtain a file that is cleaned
up if you die().  But sometimes you would need this sequence to
work:

 1. hold_lock_file_for_update() to get a file descriptor for
    writing;

 2. write the contents out, without being able to decide if the
    results should be committed or rolled back;

 3. do something else that makes the decision --- and this
    "something else" needs the lockfile not to have an open file
    descriptor for writing (e.g. Windows do not want a open file
    to be renamed);

 4. call commit_lock_file() or rollback_lock_file() as
    appropriately.

This adds close_lock_file() you can call between step 2 and 3 in
the above sequence.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-lockfile.txt |   11 +++++++++--
 cache.h                                  |    2 +-
 lockfile.c                               |    6 ++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 5b1553e..def5f2a 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -45,6 +45,11 @@ rollback_lock_file::
 	with an earlier call to `hold_lock_file_for_update()`,
 	close the file descriptor and remove the lockfile.
 
+close_lock_file::
+	Take a pointer to the `struct lock_file` initialized
+	with an earlier call to `hold_lock_file_for_update()`,
+	and close the file descriptor.
+
 Because the structure is used in an `atexit(3)` handler, its
 storage has to stay throughout the life of the program.  It
 cannot be an auto variable allocated on the stack.
@@ -54,8 +59,10 @@ done writing to the file descriptor.  If you do not call either
 and simply `exit(3)` from the program, an `atexit(3)` handler
 will close and remove the lockfile.
 
-You should not close the file descriptor you obtained from
-`hold_lock_file_for_update` function yourself.  The `struct
+If you need to close the file descriptor you obtained from
+`hold_lock_file_for_update` function yourself, do so by calling
+`close_lock_file()`.  You should never call `close(2)` yourself!
+Otherwise the `struct
 lock_file` structure still remembers that the file descriptor
 needs to be closed, and a later call to `commit_lock_file()` or
 `rollback_lock_file()` will result in duplicate calls to
diff --git a/cache.h b/cache.h
index 39331c2..5033b34 100644
--- a/cache.h
+++ b/cache.h
@@ -308,7 +308,7 @@ extern int commit_lock_file(struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern int commit_locked_index(struct lock_file *);
 extern void set_alternate_index_output(const char *);
-
+extern void close_lock_file(struct lock_file *);
 extern void rollback_lock_file(struct lock_file *);
 extern int delete_ref(const char *, const unsigned char *sha1);
 
diff --git a/lockfile.c b/lockfile.c
index f45d3ed..e57d850 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -201,3 +201,9 @@ void rollback_lock_file(struct lock_file *lk)
 	}
 	lk->filename[0] = 0;
 }
+
+void close_lock_file(struct lock_file *lk)
+{
+	close(lk->fd);
+	lk->fd = -1;
+}
-- 
1.5.4.rc3.14.g44397
