From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Clean-up lock-ref implementation
Date: Mon, 25 Sep 2006 21:13:22 -0700
Message-ID: <7vlko7uuxp.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<200609231322.30214.chriscool@tuxfamily.org>
	<7veju2nthl.fsf@assigned-by-dhcp.cox.net>
	<200609240645.54467.chriscool@tuxfamily.org>
	<7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 26 06:13:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4Jz-0006Lc-Eu
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWIZENY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIZENY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:13:24 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14302 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750702AbWIZENX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:13:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926041323.KONG18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:13:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SsDL1V00J1kojtg0000000
	Tue, 26 Sep 2006 00:13:20 -0400
To: git@vger.kernel.org
In-Reply-To: <7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 25 Sep 2006 02:26:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27768>

This drops "mustexist" parameter lock_ref_sha1() and lock_any_ref_forupdate()
functions take.  Existing callers were always passing 0.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * A bit of clean-up before the real changes...

 builtin-update-ref.c |    2 +-
 fetch.c              |    2 +-
 refs.c               |   20 +++++++++-----------
 refs.h               |    4 ++--
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 90a3da5..ab52833 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -48,7 +48,7 @@ int cmd_update_ref(int argc, const char 
 	if (oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);
 
-	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL, 0);
+	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL);
 	if (!lock)
 		return 1;
 	if (write_ref_sha1(lock, sha1, msg) < 0)
diff --git a/fetch.c b/fetch.c
index 34df8d3..74585c4 100644
--- a/fetch.c
+++ b/fetch.c
@@ -266,7 +266,7 @@ int pull(int targets, char **target, con
 		if (!write_ref || !write_ref[i])
 			continue;
 
-		lock[i] = lock_ref_sha1(write_ref[i], NULL, 0);
+		lock[i] = lock_ref_sha1(write_ref[i], NULL);
 		if (!lock[i]) {
 			error("Can't lock ref %s", write_ref[i]);
 			goto unlock_and_fail;
diff --git a/refs.c b/refs.c
index 5e65314..b4f6d4f 100644
--- a/refs.c
+++ b/refs.c
@@ -264,12 +264,11 @@ int check_ref_format(const char *ref)
 	}
 }
 
-static struct ref_lock *verify_lock(struct ref_lock *lock,
-	const unsigned char *old_sha1, int mustexist)
+static struct ref_lock *verify_lock(struct ref_lock *lock, const unsigned char *old_sha1)
 {
 	char buf[40];
 	int nr, fd = open(lock->ref_file, O_RDONLY);
-	if (fd < 0 && (mustexist || errno != ENOENT)) {
+	if (fd < 0 && errno != ENOENT) {
 		error("Can't verify ref %s", lock->ref_file);
 		unlock_ref(lock);
 		return NULL;
@@ -292,11 +291,12 @@ static struct ref_lock *verify_lock(stru
 
 static struct ref_lock *lock_ref_sha1_basic(const char *path,
 	int plen,
-	const unsigned char *old_sha1, int mustexist)
+	const unsigned char *old_sha1)
 {
 	const char *orig_path = path;
 	struct ref_lock *lock;
 	struct stat st;
+	int mustexist = 0;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
@@ -321,23 +321,21 @@ static struct ref_lock *lock_ref_sha1_ba
 		die("unable to create directory for %s", lock->ref_file);
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, lock->ref_file, 1);
 
-	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
+	return old_sha1 ? verify_lock(lock, old_sha1) : lock;
 }
 
-struct ref_lock *lock_ref_sha1(const char *ref,
-	const unsigned char *old_sha1, int mustexist)
+struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 {
 	if (check_ref_format(ref))
 		return NULL;
 	return lock_ref_sha1_basic(git_path("refs/%s", ref),
-		5 + strlen(ref), old_sha1, mustexist);
+		5 + strlen(ref), old_sha1);
 }
 
-struct ref_lock *lock_any_ref_for_update(const char *ref,
-	const unsigned char *old_sha1, int mustexist)
+struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1)
 {
 	return lock_ref_sha1_basic(git_path("%s", ref),
-		strlen(ref), old_sha1, mustexist);
+		strlen(ref), old_sha1);
 }
 
 void unlock_ref(struct ref_lock *lock)
diff --git a/refs.h b/refs.h
index 553155c..d3bc295 100644
--- a/refs.h
+++ b/refs.h
@@ -24,10 +24,10 @@ extern int for_each_remote_ref(int (*fn)
 extern int get_ref_sha1(const char *ref, unsigned char *sha1);
 
 /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
-extern struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1, int mustexist);
+extern struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
-extern struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int mustexist);
+extern struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1);
 
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
-- 
1.4.2.1.g7a39b
