From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Document lockfile API
Date: Wed, 16 Jan 2008 11:00:13 -0800
Message-ID: <7vk5m9r3ya.fsf_-_@gitster.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Wed Jan 16 20:01:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDVU-0007R6-EZ
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYAPTAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbYAPTAa
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:00:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYAPTA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:00:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D738288F;
	Wed, 16 Jan 2008 14:00:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A630D288A;
	Wed, 16 Jan 2008 14:00:20 -0500 (EST)
In-Reply-To: <Pine.LNX.4.44.0801152006260.944-100000@demand> (Brandon Casey's
	message of "Tue, 15 Jan 2008 20:11:55 -0600 (CST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70721>

We have nice set of placeholders, but nobody stepped in to fill
the gap in the API documentation, so I am doing it myself.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-lockfile.txt |   67 ++++++++++++++++++++++++++---
 1 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 73ac102..5b1553e 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -1,12 +1,65 @@
 lockfile API
 ============
 
-Talk about <lockfile.c>, things like:
+The lockfile API serves two purposes:
 
-* lockfile lifetime -- atexit(3) looks at them, do not put them on the
-  stack;
-* hold_lock_file_for_update()
-* commit_lock_file()
-* rollback_rock_file()
+* Mutual exclusion.  When we write out a new index file, first
+  we create a new file `$GIT_DIR/index.lock`, write the new
+  contents into it, and rename it to the final destination
+  `$GIT_DIR/index`.  We try to create the `$GIT_DIR/index.lock`
+  file with O_EXCL so that we can notice and fail when somebody
+  else is already trying to update the index file.
 
-(JC, Dscho, Shawn)
+* Automatic cruft removal.  After we create the "lock" file, we
+  may decide to `die()`, and we would want to make sure that we
+  remove the file that has not been committed to its final
+  destination.  This is done by remembering the lockfiles we
+  created in a linked list and cleaning them up from an
+  `atexit(3)` handler.  Outstanding lockfiles are also removed
+  when the program dies on a signal.
+
+
+The functions
+-------------
+
+hold_lock_file_for_update::
+
+	Take a pointer to `struct lock_file`, the filename of
+	the final destination (e.g. `$GIT_DIR/index`) and a flag
+	`die_on_error`.  Attempt to create a lockfile for the
+	destination and return the file descriptor for writing
+	to the file.  If `die_on_error` flag is true, it dies if
+	a lock is already taken for the file; otherwise it
+	returns a negative integer to the caller on failure.
+
+commit_lock_file::
+
+	Take a pointer to the `struct lock_file` initialized
+	with an earlier call to `hold_lock_file_for_update()`,
+	close the file descriptor and rename the lockfile to its
+	final destination.
+
+rollback_lock_file::
+
+	Take a pointer to the `struct lock_file` initialized
+	with an earlier call to `hold_lock_file_for_update()`,
+	close the file descriptor and remove the lockfile.
+
+Because the structure is used in an `atexit(3)` handler, its
+storage has to stay throughout the life of the program.  It
+cannot be an auto variable allocated on the stack.
+
+Call `commit_lock_file()` or `rollback_lock_file()` when you are
+done writing to the file descriptor.  If you do not call either
+and simply `exit(3)` from the program, an `atexit(3)` handler
+will close and remove the lockfile.
+
+You should not close the file descriptor you obtained from
+`hold_lock_file_for_update` function yourself.  The `struct
+lock_file` structure still remembers that the file descriptor
+needs to be closed, and a later call to `commit_lock_file()` or
+`rollback_lock_file()` will result in duplicate calls to
+`close(2)`.  Worse yet, if you `close(2)`, open another file
+descriptor for completely different purpose, and then call
+`commit_lock_file()` or `rollback_lock_file()`, they may close
+that unrelated file descriptor.
-- 
1.5.4.rc3.14.g44397
