From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Delete ref $frotz by moving ref file to
 "deleted-$frotz~ref".
Date: Sat, 14 Oct 2006 15:39:49 +0200
Message-ID: <20061014153949.2994a114.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 15:33:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYjdh-0001Mh-S7
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 15:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWJNNdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 09:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422631AbWJNNdJ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 09:33:09 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:36276 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422634AbWJNNdF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 09:33:05 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 42EB775C09;
	Sat, 14 Oct 2006 15:33:03 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28877>

The idea is that moving:

$GIT_DIR/refs/<refpath>/frotz

to:

$GIT_DIR/deleted-refs/<refpath>/frotz~ref

maybe cheaper and safer than repacking the refs without the
deleted one.

On the other hand now when resolving a ref we have to check
if a related deleted ref file exists.

The new "delete_ref" function is similar to "write_ref_sha1".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 refs.c |  160 ++++++++++++++++++++++++++++++++++++++++------------------------
 refs.h |    2 +
 2 files changed, 102 insertions(+), 60 deletions(-)

diff --git a/refs.c b/refs.c
index 89cffaf..6a8da58 100644
--- a/refs.c
+++ b/refs.c
@@ -176,6 +176,38 @@ static struct ref_list *get_loose_refs(v
 	return cached_refs.loose;
 }
 
+static char *get_del_ref_name(const char *ref_name)
+{
+	size_t ref_name_len = strlen(ref_name);
+	char *delref_name = xmalloc(ref_name_len + 13);
+
+	strncpy(delref_name, "deleted-", 8);
+	strncpy(delref_name + 8, ref_name, ref_name_len);
+	strcpy(delref_name + 8 + ref_name_len, "~ref");
+
+	return delref_name;
+}
+
+static int lstat_del_ref_file(const char *ref_name, struct stat *st)
+{
+	char *delref_name = get_del_ref_name(ref_name);
+	char *delref_file = git_path("%s", delref_name);
+
+	int ret = lstat(delref_file, st);
+
+	free(delref_name);
+	return ret;
+}
+
+static char *get_del_ref_file(const char *ref_name)
+{
+	char *delref_name = get_del_ref_name(ref_name);
+	char *delref_file = xstrdup(git_path("%s", delref_name));
+
+	free(delref_name);
+	return delref_file;
+}
+
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
@@ -204,6 +236,17 @@ const char *resolve_ref(const char *ref,
 		 * born.  It is NOT OK if we are resolving for
 		 * reading.
 		 */
+
+		if (!lstat_del_ref_file(ref, &st)) {
+			/* The ref has been deleted. */
+			if (flag)
+				*flag |= REF_ISDELETED;
+			if (reading)
+				return NULL;
+			hashclr(sha1);
+			return ref;
+		}
+
 		if (lstat(path, &st) < 0) {
 			struct ref_list *list = get_packed_refs();
 			while (list) {
@@ -541,12 +584,14 @@ static struct ref_lock *lock_ref_sha1_ba
 	struct ref_lock *lock;
 	struct stat st;
 	int last_errno = 0;
+	int default_flag;
+	int *ref_flag = flag ? flag : &default_flag;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	ref = resolve_ref(ref, lock->old_sha1, mustexist, flag);
+	ref = resolve_ref(ref, lock->old_sha1, mustexist, ref_flag);
 	if (!ref && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -559,7 +604,7 @@ static struct ref_lock *lock_ref_sha1_ba
 			error("there are still refs under '%s'", orig_ref);
 			goto error_return;
 		}
-		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, flag);
+		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, ref_flag);
 	}
 	if (!ref) {
 		last_errno = errno;
@@ -568,7 +613,8 @@ static struct ref_lock *lock_ref_sha1_ba
 		goto error_return;
 	}
 	if (is_null_sha1(lock->old_sha1)) {
-		/* The ref did not exist and we are creating it.
+		/* The ref did not exist (or has been deleted)
+		 * and we are (re)creating it.
 		 * Make sure there is no existing ref that is packed
 		 * whose name begins with our refname, nor a ref whose
 		 * name is a proper prefix of our refname.
@@ -580,15 +626,19 @@ static struct ref_lock *lock_ref_sha1_ba
 			int len = strlen(list->name);
 			int cmplen = (namlen < len) ? namlen : len;
 			const char *lead = (namlen < len) ? list->name : ref;
+			struct stat st;
 
 			if (!strncmp(ref, list->name, cmplen) &&
-			    lead[cmplen] == '/') {
+			    lead[cmplen] == '/' &&
+			    lstat_del_ref_file(list->name, &st)) {
 				error("'%s' exists; cannot create '%s'",
 				      list->name, ref);
 				goto error_return;
 			}
 			list = list->next;
 		}
+		if (*ref_flag & REF_ISDELETED)
+			lock->del_file = get_del_ref_file(ref);
 	}
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
@@ -627,77 +677,60 @@ struct ref_lock *lock_any_ref_for_update
 	return lock_ref_sha1_basic(ref, old_sha1, NULL);
 }
 
-static struct lock_file packlock;
-
-static int repack_without_ref(const char *refname)
+/* Remove the ref "refs/$frotz" by creating "deleted-refs/$frotz~ref". */
+int delete_ref(const char *ref_name, unsigned char *sha1)
 {
-	struct ref_list *list, *packed_ref_list;
-	int fd;
-	int found = 0;
+	int flag = 0;
+	static char term = '\n';
+	struct ref_lock *lock = lock_ref_sha1_basic(ref_name, sha1, &flag);
 
-	packed_ref_list = get_packed_refs();
-	for (list = packed_ref_list; list; list = list->next) {
-		if (!strcmp(refname, list->name)) {
-			found = 1;
-			break;
-		}
+	if (!lock)
+		return -1;
+	if (flag & REF_ISDELETED) {
+		unlock_ref(lock);
+		return 0; /* Already deleted is ok. */
 	}
-	if (!found)
-		return 0;
-	memset(&packlock, 0, sizeof(packlock));
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (fd < 0)
-		return error("cannot delete '%s' from packed refs", refname);
-
-	for (list = packed_ref_list; list; list = list->next) {
-		char line[PATH_MAX + 100];
-		int len;
-
-		if (!strcmp(refname, list->name))
-			continue;
-		len = snprintf(line, sizeof(line), "%s %s\n",
-			       sha1_to_hex(list->sha1), list->name);
-		/* this should not happen but just being defensive */
-		if (len > sizeof(line))
-			die("too long a refname '%s'", list->name);
-		write_or_die(fd, line, len);
+	if (write(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
+	    write(lock->lock_fd, &term, 1) != 1
+		|| close(lock->lock_fd) < 0) {
+		error("Couldn't write %s", lock->lk->filename);
+		unlock_ref(lock);
+		return -1;
 	}
-	return commit_lock_file(&packlock);
-}
-
-int delete_ref(const char *refname, unsigned char *sha1)
-{
-	struct ref_lock *lock;
-	int err, i, ret = 0, flag = 0;
-
-	lock = lock_ref_sha1_basic(refname, sha1, &flag);
-	if (!lock)
-		return 1;
+	invalidate_cached_refs();
 	if (!(flag & REF_ISPACKED)) {
 		/* loose */
-		i = strlen(lock->lk->filename) - 5; /* .lock */
+		int i = strlen(lock->lk->filename) - 5; /* .lock */
 		lock->lk->filename[i] = 0;
-		err = unlink(lock->lk->filename);
-		if (err) {
-			ret = 1;
+		if (unlink(lock->lk->filename)) {
 			error("unlink(%s) failed: %s",
 			      lock->lk->filename, strerror(errno));
+			unlock_ref(lock);
+			return -1;
 		}
 		lock->lk->filename[i] = '.';
 	}
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |= repack_without_ref(refname);
-
-	err = unlink(lock->log_file);
-	if (err && errno != ENOENT)
+	if (unlink(lock->log_file) && errno != ENOENT)
 		fprintf(stderr, "warning: unlink(%s) failed: %s",
 			lock->log_file, strerror(errno));
-	invalidate_cached_refs();
+	if (!lock->del_file)
+		lock->del_file = get_del_ref_file(ref_name);
+	if (safe_create_leading_directories(lock->del_file)) {
+		error("unable to create directory for %s: %s",
+		      lock->del_file, strerror(errno));
+		unlock_ref(lock);
+		return -1;
+	}
+	if (rename(lock->lk->filename, lock->del_file)) {
+		error("rename(%s -> %s) failed: %s",
+		      lock->lk->filename, lock->del_file,
+		      strerror(errno));
+		unlock_ref(lock);
+		return -1;
+	}
+	lock->lock_fd = -1;
 	unlock_ref(lock);
-	return ret;
+	return 0;
 }
 
 void unlock_ref(struct ref_lock *lock)
@@ -710,6 +743,7 @@ void unlock_ref(struct ref_lock *lock)
 	}
 	free(lock->ref_name);
 	free(lock->log_file);
+	free(lock->del_file);
 	free(lock);
 }
 
@@ -786,6 +820,12 @@ int write_ref_sha1(struct ref_lock *lock
 		unlock_ref(lock);
 		return -1;
 	}
+	if (lock->del_file && unlink(lock->del_file) && errno != ENOENT) {
+		error("unlink(%s) failed: %s",
+		      lock->del_file, strerror(errno));
+		unlock_ref(lock);
+		return -1;
+	}
 	if (commit_lock_file(lock->lk)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
diff --git a/refs.h b/refs.h
index a57d437..5aa7755 100644
--- a/refs.h
+++ b/refs.h
@@ -4,6 +4,7 @@ #define REFS_H
 struct ref_lock {
 	char *ref_name;
 	char *log_file;
+	char *del_file;
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
 	int lock_fd;
@@ -16,6 +17,7 @@ struct ref_lock {
  */
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
+#define REF_ISDELETED 04
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
-- 
1.4.3.rc2.gbcf275-dirty
