From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/6] delete_ref(): delete packed ref
Date: Sat, 30 Sep 2006 15:30:46 -0700
Message-ID: <7vac4h9ecp.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
	<7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
	<7v1wptc7ou.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 01 00:31:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnMY-00031M-Eo
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 00:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWI3Wax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 18:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWI3Wax
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 18:30:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9622 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751530AbWI3Waw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 18:30:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930223051.CJMD6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 18:30:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UmWp1V00b1kojtg0000000
	Sat, 30 Sep 2006 18:30:54 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28159>

This implements deletion of a packed ref.  Since it is a very
rare event to delete a ref compared to looking up, creating and
updating, this opts to remove the ref from the packed-ref file
instead of doing any of the filesystem based "negative ref" trick
to optimize the deletion path.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This looks larger than it actually is, because it moves delete_ref()
   down so that it can use lock_ref_sha1_basic().

 refs.c |  109 +++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 2bfa92a..858c534 100644
--- a/refs.c
+++ b/refs.c
@@ -406,33 +406,6 @@ int get_ref_sha1(const char *ref, unsign
 	return read_ref(mkpath("refs/%s", ref), sha1);
 }
 
-int delete_ref(const char *refname, unsigned char *sha1)
-{
-	struct ref_lock *lock;
-	int err, i, ret = 0;
-
-	lock = lock_any_ref_for_update(refname, sha1);
-	if (!lock)
-		return 1;
-	i = strlen(lock->lk->filename) - 5; /* .lock */
-	lock->lk->filename[i] = 0;
-	err = unlink(lock->lk->filename);
-	if (err) {
-		ret = 1;
-		error("unlink(%s) failed: %s",
-		      lock->lk->filename, strerror(errno));
-	}
-	lock->lk->filename[i] = '.';
-
-	err = unlink(lock->log_file);
-	if (err && errno != ENOENT)
-		fprintf(stderr, "warning: unlink(%s) failed: %s",
-			lock->log_file, strerror(errno));
-
-	invalidate_cached_refs();
-	return ret;
-}
-
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
@@ -555,7 +528,7 @@ static int remove_empty_directories(char
 	return remove_empty_dir_recursive(path, len);
 }
 
-static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1, int *flag)
 {
 	char *ref_file;
 	const char *orig_ref = ref;
@@ -567,7 +540,7 @@ static struct ref_lock *lock_ref_sha1_ba
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	ref = resolve_ref(ref, lock->old_sha1, mustexist, NULL);
+	ref = resolve_ref(ref, lock->old_sha1, mustexist, flag);
 	if (!ref && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -580,7 +553,7 @@ static struct ref_lock *lock_ref_sha1_ba
 			error("there are still refs under '%s'", orig_ref);
 			goto error_return;
 		}
-		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, NULL);
+		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, flag);
 	}
 	if (!ref) {
 		last_errno = errno;
@@ -640,12 +613,84 @@ struct ref_lock *lock_ref_sha1(const cha
 	if (check_ref_format(ref))
 		return NULL;
 	strcpy(refpath, mkpath("refs/%s", ref));
-	return lock_ref_sha1_basic(refpath, old_sha1);
+	return lock_ref_sha1_basic(refpath, old_sha1, NULL);
 }
 
 struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1)
 {
-	return lock_ref_sha1_basic(ref, old_sha1);
+	return lock_ref_sha1_basic(ref, old_sha1, NULL);
+}
+
+static int repack_without_ref(const char *refname)
+{
+	struct ref_list *list, *packed_ref_list;
+	int fd;
+	int found = 0;
+	struct lock_file packlock;
+
+	packed_ref_list = get_packed_refs();
+	for (list = packed_ref_list; list; list = list->next) {
+		if (!strcmp(refname, list->name)) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found)
+		return 0;
+	memset(&packlock, 0, sizeof(packlock));
+	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
+	if (fd < 0)
+		return error("cannot delete '%s' from packed refs", refname);
+
+	for (list = packed_ref_list; list; list = list->next) {
+		char line[PATH_MAX + 100];
+		int len;
+
+		if (!strcmp(refname, list->name))
+			continue;
+		len = snprintf(line, sizeof(line), "%s %s\n",
+			       sha1_to_hex(list->sha1), list->name);
+		/* this should not happen but just being defensive */
+		if (len > sizeof(line))
+			die("too long a refname '%s'", list->name);
+		write_or_die(fd, line, len);
+	}
+	return commit_lock_file(&packlock);
+}
+
+int delete_ref(const char *refname, unsigned char *sha1)
+{
+	struct ref_lock *lock;
+	int err, i, ret = 0, flag = 0;
+
+	lock = lock_ref_sha1_basic(refname, sha1, &flag);
+	if (!lock)
+		return 1;
+	if (!(flag & REF_ISPACKED)) {
+		/* loose */
+		i = strlen(lock->lk->filename) - 5; /* .lock */
+		lock->lk->filename[i] = 0;
+		err = unlink(lock->lk->filename);
+		if (err) {
+			ret = 1;
+			error("unlink(%s) failed: %s",
+			      lock->lk->filename, strerror(errno));
+		}
+		lock->lk->filename[i] = '.';
+	}
+	/* removing the loose one could have resurrected an earlier
+	 * packed one.  Also, if it was not loose we need to repack
+	 * without it.
+	 */
+	ret |= repack_without_ref(refname);
+
+	err = unlink(lock->log_file);
+	if (err && errno != ENOENT)
+		fprintf(stderr, "warning: unlink(%s) failed: %s",
+			lock->log_file, strerror(errno));
+	invalidate_cached_refs();
+	unlock_ref(lock);
+	return ret;
 }
 
 void unlock_ref(struct ref_lock *lock)
-- 
1.4.2.1.g5a98f
