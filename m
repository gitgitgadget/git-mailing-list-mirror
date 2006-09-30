From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/6] lock_ref_sha1(): do not sometimes error() and sometimes die().
Date: Sat, 30 Sep 2006 15:30:34 -0700
Message-ID: <7vlko19ed1.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
	<7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
	<7v1wptc7ou.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 01 00:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnMX-00031M-SE
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 00:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWI3Waq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 18:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWI3Waq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 18:30:46 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7064 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751522AbWI3Wao (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 18:30:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930223043.PGSQ13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 18:30:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UmWi1V00Y1kojtg0000000
	Sat, 30 Sep 2006 18:30:46 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28161>

This cleans up the error path in the function so it does not
die() itself sometimes while signalling an error with NULL some
other times which was inconsistent and confusing.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 refs.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 6ee5f96..157de43 100644
--- a/refs.c
+++ b/refs.c
@@ -561,6 +561,7 @@ static struct ref_lock *lock_ref_sha1_ba
 	const char *orig_ref = ref;
 	struct ref_lock *lock;
 	struct stat st;
+	int last_errno = 0;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -574,17 +575,18 @@ static struct ref_lock *lock_ref_sha1_ba
 		 * to remain.
 		 */
 		ref_file = git_path("%s", orig_ref);
-		if (remove_empty_directories(ref_file))
-			die("there are still refs under '%s'", orig_ref);
+		if (remove_empty_directories(ref_file)) {
+			last_errno = errno;
+			error("there are still refs under '%s'", orig_ref);
+			goto error_return;
+		}
 		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, NULL);
 	}
 	if (!ref) {
-		int last_errno = errno;
+		last_errno = errno;
 		error("unable to resolve reference %s: %s",
 			orig_ref, strerror(errno));
-		unlock_ref(lock);
-		errno = last_errno;
-		return NULL;
+		goto error_return;
 	}
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
@@ -593,11 +595,19 @@ static struct ref_lock *lock_ref_sha1_ba
 	ref_file = git_path("%s", ref);
 	lock->force_write = lstat(ref_file, &st) && errno == ENOENT;
 
-	if (safe_create_leading_directories(ref_file))
-		die("unable to create directory for %s", ref_file);
+	if (safe_create_leading_directories(ref_file)) {
+		last_errno = errno;
+		error("unable to create directory for %s", ref_file);
+		goto error_return;
+	}
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, 1);
 
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
+
+ error_return:
+	unlock_ref(lock);
+	errno = last_errno;
+	return NULL;
 }
 
 struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
-- 
1.4.2.1.g5a98f
