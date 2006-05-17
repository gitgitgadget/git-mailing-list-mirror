From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC 2/5] Improve abstraction of ref lock/write.
Date: Wed, 17 May 2006 05:55:02 -0400
Message-ID: <20060517095502.GC28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 17 11:55:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIkK-0004PT-DM
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWEQJzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWEQJzI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:55:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53968 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750798AbWEQJzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:55:06 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgIk9-0000vE-FD
	for git@vger.kernel.org; Wed, 17 May 2006 05:55:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C9877212667; Wed, 17 May 2006 05:55:02 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20181>

Created 'struct ref_lock' to contain the data necessary to perform
a ref update.  This change improves writing a ref as the file names
are generated only once (rather than twice) and supports following
symrefs (up to the maximum depth).  Further the ref_lock structure
provides room to extend the update API with ref logging.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 fetch.c |   32 +++++----
 refs.c  |  236 ++++++++++++++++++++++++++++++---------------------------------
 refs.h  |   24 ++++--
 3 files changed, 144 insertions(+), 148 deletions(-)

d38945e0c759f8739da4c24485578a8193d54c59
diff --git a/fetch.c b/fetch.c
index 73bde07..8bdaacb 100644
--- a/fetch.c
+++ b/fetch.c
@@ -204,14 +204,14 @@ static int mark_complete(const char *pat
 
 int pull(char *target)
 {
+	struct ref_lock *lock;
 	unsigned char sha1[20];
-	int fd = -1;
 
 	save_commit_buffer = 0;
 	track_object_refs = 0;
-	if (write_ref && current_ref) {
-		fd = lock_ref_sha1(write_ref, current_ref);
-		if (fd < 0)
+	if (write_ref) {
+		lock = lock_ref_sha1(write_ref, current_ref, 1);
+		if (!lock)
 			return -1;
 	}
 
@@ -219,20 +219,22 @@ int pull(char *target)
 		for_each_ref(mark_complete);
 	}
 
-	if (interpret_target(target, sha1))
-		return error("Could not interpret %s as something to pull",
-			     target);
-	if (process(lookup_unknown_object(sha1)))
+	if (interpret_target(target, sha1)) {
+		error("Could not interpret %s as something to pull", target);
+		unlock_ref(lock);
+		return -1;
+	}
+	if (process(lookup_unknown_object(sha1))) {
+		unlock_ref(lock);
 		return -1;
-	if (loop())
+	}
+	if (loop()) {
+		unlock_ref(lock);
 		return -1;
-	
+	}
+
 	if (write_ref) {
-		if (current_ref) {
-			write_ref_sha1(write_ref, fd, sha1);
-		} else {
-			write_ref_sha1_unlocked(write_ref, sha1);
-		}
+		return write_ref_sha1(lock, sha1, "git fetch");
 	}
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 0f3491f..91c8c44 100644
--- a/refs.c
+++ b/refs.c
@@ -198,26 +198,6 @@ int for_each_remote_ref(int (*fn)(const 
 	return do_for_each_ref("refs/remotes", fn, 13);
 }
 
-static char *ref_file_name(const char *ref)
-{
-	char *base = get_refs_directory();
-	int baselen = strlen(base);
-	int reflen = strlen(ref);
-	char *ret = xmalloc(baselen + 2 + reflen);
-	sprintf(ret, "%s/%s", base, ref);
-	return ret;
-}
-
-static char *ref_lock_file_name(const char *ref)
-{
-	char *base = get_refs_directory();
-	int baselen = strlen(base);
-	int reflen = strlen(ref);
-	char *ret = xmalloc(baselen + 7 + reflen);
-	sprintf(ret, "%s/%s.lock", base, ref);
-	return ret;
-}
-
 int get_ref_sha1(const char *ref, unsigned char *sha1)
 {
 	if (check_ref_format(ref))
@@ -225,94 +205,6 @@ int get_ref_sha1(const char *ref, unsign
 	return read_ref(git_path("refs/%s", ref), sha1);
 }
 
-static int lock_ref_file(const char *filename, const char *lock_filename,
-			 const unsigned char *old_sha1)
-{
-	int fd = open(lock_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
-	unsigned char current_sha1[20];
-	int retval;
-	if (fd < 0) {
-		return error("Couldn't open lock file for %s: %s",
-			     filename, strerror(errno));
-	}
-	retval = read_ref(filename, current_sha1);
-	if (old_sha1) {
-		if (retval) {
-			close(fd);
-			unlink(lock_filename);
-			return error("Could not read the current value of %s",
-				     filename);
-		}
-		if (memcmp(current_sha1, old_sha1, 20)) {
-			close(fd);
-			unlink(lock_filename);
-			error("The current value of %s is %s",
-			      filename, sha1_to_hex(current_sha1));
-			return error("Expected %s",
-				     sha1_to_hex(old_sha1));
-		}
-	} else {
-		if (!retval) {
-			close(fd);
-			unlink(lock_filename);
-			return error("Unexpectedly found a value of %s for %s",
-				     sha1_to_hex(current_sha1), filename);
-		}
-	}
-	return fd;
-}
-
-int lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
-{
-	char *filename;
-	char *lock_filename;
-	int retval;
-	if (check_ref_format(ref))
-		return -1;
-	filename = ref_file_name(ref);
-	lock_filename = ref_lock_file_name(ref);
-	retval = lock_ref_file(filename, lock_filename, old_sha1);
-	free(filename);
-	free(lock_filename);
-	return retval;
-}
-
-static int write_ref_file(const char *filename,
-			  const char *lock_filename, int fd,
-			  const unsigned char *sha1)
-{
-	char *hex = sha1_to_hex(sha1);
-	char term = '\n';
-	if (write(fd, hex, 40) < 40 ||
-	    write(fd, &term, 1) < 1) {
-		error("Couldn't write %s", filename);
-		close(fd);
-		return -1;
-	}
-	close(fd);
-	rename(lock_filename, filename);
-	return 0;
-}
-
-int write_ref_sha1(const char *ref, int fd, const unsigned char *sha1)
-{
-	char *filename;
-	char *lock_filename;
-	int retval;
-	if (fd < 0)
-		return -1;
-	if (check_ref_format(ref))
-		return -1;
-	filename = ref_file_name(ref);
-	lock_filename = ref_lock_file_name(ref);
-	if (safe_create_leading_directories(filename))
-		die("unable to create leading directory for %s", filename);
-	retval = write_ref_file(filename, lock_filename, fd, sha1);
-	free(filename);
-	free(lock_filename);
-	return retval;
-}
-
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
@@ -365,25 +257,119 @@ int check_ref_format(const char *ref)
 	}
 }
 
-int write_ref_sha1_unlocked(const char *ref, const unsigned char *sha1)
+static struct ref_lock* verify_lock(struct ref_lock *lock,
+	const unsigned char *old_sha1, int mustexist)
+{
+	char buf[40];
+	int nr, fd = open(lock->ref_file, O_RDONLY);
+	if (fd < 0 && (mustexist || errno != ENOENT)) {
+		error("Can't verify ref %s", lock->ref_file);
+		unlock_ref(lock);
+		return NULL;
+	}
+	nr = read(fd, buf, 40);
+	close(fd);
+	if (nr != 40 || get_sha1_hex(buf, lock->old_sha1) < 0) {
+		error("Can't verify ref %s", lock->ref_file);
+		unlock_ref(lock);
+		return NULL;
+	}
+	if (memcmp(lock->old_sha1, old_sha1, 20)) {
+		error("Ref %s is at %s but expected %s", lock->ref_file,
+			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
+		unlock_ref(lock);
+		return NULL;
+	}
+	return lock;
+}
+
+static struct ref_lock* lock_ref_sha1_basic(const char *path,
+	int plen,
+	const unsigned char *old_sha1, int mustexist)
+{
+	struct ref_lock *lock;
+
+	lock = xcalloc(1, sizeof(struct ref_lock));
+	lock->lock_fd = -1;
+
+	plen = strlen(path) - plen;
+	path = resolve_ref(path, lock->old_sha1, mustexist);
+	if (!path) {
+		error("Can't read ref %s", path);
+		unlock_ref(lock);
+		return NULL;
+	}
+
+	lock->ref_file = strdup(path);
+	lock->lock_file = strdup(mkpath("%s.lock", lock->ref_file));
+
+	if (safe_create_leading_directories(lock->lock_file))
+		die("unable to create directory for %s", lock->lock_file);
+	lock->lock_fd = open(lock->lock_file,
+		O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (lock->lock_fd < 0) {
+		error("Couldn't open lock file %s: %s",
+			lock->lock_file, strerror(errno));
+		unlock_ref(lock);
+		return NULL;
+	}
+
+	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
+}
+
+struct ref_lock* lock_ref_sha1(const char *ref,
+	const unsigned char *old_sha1, int mustexist)
 {
-	char *filename;
-	char *lock_filename;
-	int fd;
-	int retval;
 	if (check_ref_format(ref))
+		return NULL;
+	return lock_ref_sha1_basic(git_path("refs/%s", ref),
+		strlen(ref), old_sha1, mustexist);
+}
+
+struct ref_lock* lock_any_ref_for_update(const char *ref,
+	const unsigned char *old_sha1, int mustexist)
+{
+	return lock_ref_sha1_basic(git_path("%s", ref),
+		strlen(ref), old_sha1, mustexist);
+}
+
+void unlock_ref (struct ref_lock *lock)
+{
+	if (lock->lock_fd >= 0) {
+		close(lock->lock_fd);
+		unlink(lock->lock_file);
+	}
+	if (lock->ref_file)
+		free(lock->ref_file);
+	if (lock->lock_file)
+		free(lock->lock_file);
+	free(lock);
+}
+
+int write_ref_sha1(struct ref_lock *lock,
+	const unsigned char *sha1, const char *logmsg)
+{
+	static char term = '\n';
+
+	if (!lock)
 		return -1;
-	filename = ref_file_name(ref);
-	lock_filename = ref_lock_file_name(ref);
-	if (safe_create_leading_directories(filename))
-		die("unable to create leading directory for %s", filename);
-	fd = open(lock_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
-	if (fd < 0) {
-		error("Writing %s", lock_filename);
-		perror("Open");
+	if (!memcmp(lock->old_sha1, sha1, 20)) {
+		unlock_ref(lock);
+		return 0;
 	}
-	retval = write_ref_file(filename, lock_filename, fd, sha1);
-	free(filename);
-	free(lock_filename);
-	return retval;
+	if (write(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
+	    write(lock->lock_fd, &term, 1) != 1
+		|| close(lock->lock_fd) < 0) {
+		error("Couldn't write %s", lock->lock_file);
+		unlock_ref(lock);
+		return -1;
+	}
+	if (rename(lock->lock_file, lock->ref_file) < 0) {
+		error("Couldn't set %s", lock->ref_file);
+		unlock_ref(lock);
+		return -1;
+	}
+	lock->lock_fd = -1;
+	unlock_ref(lock);
+	return 0;
 }
diff --git a/refs.h b/refs.h
index fa816c1..b7e9df2 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,13 @@
 #ifndef REFS_H
 #define REFS_H
 
+struct ref_lock {
+	char *ref_file;
+	char *lock_file;
+	unsigned char old_sha1[20];
+	int lock_fd;
+};
+
 /*
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
@@ -14,16 +21,17 @@ extern int for_each_remote_ref(int (*fn)
 /** Reads the refs file specified into sha1 **/
 extern int get_ref_sha1(const char *ref, unsigned char *sha1);
 
-/** Locks ref and returns the fd to give to write_ref_sha1() if the ref
- * has the given value currently; otherwise, returns -1.
- **/
-extern int lock_ref_sha1(const char *ref, const unsigned char *old_sha1);
+/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
+extern struct ref_lock* lock_ref_sha1(const char *ref, const unsigned char *old_sha1, int mustexist);
+
+/** Locks any ref (for 'HEAD' type refs). */
+extern struct ref_lock* lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int mustexist);
 
-/** Writes sha1 into the refs file specified, locked with the given fd. **/
-extern int write_ref_sha1(const char *ref, int fd, const unsigned char *sha1);
+/** Release any lock taken but not written. **/
+extern void unlock_ref (struct ref_lock *lock);
 
-/** Writes sha1 into the refs file specified. **/
-extern int write_ref_sha1_unlocked(const char *ref, const unsigned char *sha1);
+/** Writes sha1 into the ref specified by the lock. **/
+extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
-- 
1.3.2.g7278
