From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/22] lockfile: use strbufs when handling (most) paths
Date: Tue,  1 Apr 2014 17:58:22 +0200
Message-ID: <1396367910-7299-15-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16a-0002ve-JQ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbaDAP75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:57 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56293 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751895AbaDAP66 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:58 -0400
X-AuditID: 12074413-f79076d000002d17-e4-533ae24173b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DA.58.11543.142EA335; Tue,  1 Apr 2014 11:58:57 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbI027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:56 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqOv4yCrY4NFhTYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3x+0MDa8H92orVEycyNjC+Sepi5OSQEDCR2P1uBguELSZx4d56ti5GLg4hgcuMEov7
	L7JAOMeYJO5O2sYKUsUmoCuxqKeZCcQWEVCTmNh2CKybWSBF4tXfXWC2sIC7xNre3WwgNouA
	qsTZW3fZuxg5OHgFXCS69qRCLJOTmPJ7ATuIzQkUvvRgD9h4IQFnidNvFjNPYORdwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0QvNaV0EyMkpIR3MO46KXeIUYCDUYmH98B5q2Ah
	1sSy4srcQ4ySHExKorw/7gKF+JLyUyozEosz4otKc1KLDzFKcDArifDOugmU401JrKxKLcqH
	SUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8EY9BGoULEpNT61Iy8wpQUgzcXCCDOeS
	EilOzUtJLUosLcmIB0VGfDEwNkBSPEB7p4O08xYXJOYCRSFaTzEqSonzhoAkBEASGaV5cGNh
	ieIVozjQl8K8i0GqeIBJBq77FdBgJqDB3OvABpckIqSkGhiFJ61e+yLfVZu94+udyXssJMQq
	S14UFKyuvdyxQXrFZv289bVcuwLXmBR1N6vr3J30b790ZdVttcyVn5l/Pdz0uHDTqdY6g+WS
	cpqcxSKveOfqvLXp0zvnVNneJ7Um8u2zBtvidVM3JKxY6vjme/W/4A9ORuVGeyZX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245607>

Change struct lock_file's filename field from a fixed-length buffer
into a strbuf.  This:

* Make buffer overflows a bit less likely

* Removes arbitrary limitations on the length of the path in some
  places, though the restrictions still have to be removed from other
  places to make a real difference

* Shortens the code

Name the new strbuf field lock_filename to make it clear that it
contains the name of the lockfile as opposed to the name of the file
being locked.  Initialize the strbuf the first time the lock_file
object is used.

Change resolve_symlink() to work on a strbuf.

Replace last_path_elm() with a new function, trim_last_path_elm(),
which operates on a strbuf.

Adjust other places in the code that refer directly to the filename.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c |  12 ++--
 builtin/reflog.c |   2 +-
 cache.h          |   2 +-
 config.c         |   3 +-
 lockfile.c       | 183 ++++++++++++++++++++++++-------------------------------
 refs.c           |   6 +-
 shallow.c        |   6 +-
 7 files changed, 97 insertions(+), 117 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..28944de 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -330,7 +330,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 			die(_("unable to create temporary index"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
-		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
+		setenv(INDEX_ENVIRONMENT, index_lock.lock_filename.buf, 1);
 
 		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
@@ -341,10 +341,10 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 			unsetenv(INDEX_ENVIRONMENT);
 
 		discard_cache();
-		read_cache_from(index_lock.filename);
+		read_cache_from(index_lock.lock_filename.buf);
 
 		commit_style = COMMIT_NORMAL;
-		return index_lock.filename;
+		return index_lock.lock_filename.buf;
 	}
 
 	/*
@@ -368,7 +368,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
-		return index_lock.filename;
+		return index_lock.lock_filename.buf;
 	}
 
 	/*
@@ -453,9 +453,9 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		die(_("unable to write temporary index file"));
 
 	discard_cache();
-	read_cache_from(false_lock.filename);
+	read_cache_from(false_lock.lock_filename.buf);
 
-	return false_lock.filename;
+	return false_lock.lock_filename.buf;
 }
 
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
diff --git a/builtin/reflog.c b/builtin/reflog.c
index c12a9784..29bc07b 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -431,7 +431,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("Couldn't write %s",
-				lock->lk->filename);
+				lock->lk->lock_filename.buf);
 			unlink(newlog_path);
 		} else if (rename(newlog_path, log_file)) {
 			status |= error("cannot rename %s to %s",
diff --git a/cache.h b/cache.h
index 08d0e48..3d0a835 100644
--- a/cache.h
+++ b/cache.h
@@ -538,7 +538,7 @@ struct lock_file {
 	int fd;
 	pid_t owner;
 	unsigned char flags;
-	char filename[PATH_MAX];
+	struct strbuf lock_filename;
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
diff --git a/config.c b/config.c
index 1ea3f39..cea0af0 100644
--- a/config.c
+++ b/config.c
@@ -1305,7 +1305,8 @@ static int store_aux(const char *key, const char *value, void *cb)
 
 static int write_error(struct lock_file *lk)
 {
-	error("failed to write new configuration file %s", lk->filename);
+	error("failed to write new configuration file %s",
+	      lk->lock_filename.buf);
 
 	/* Same error code as "failed to rename". */
 	return 4;
diff --git a/lockfile.c b/lockfile.c
index 4e3ada8..931ebbd 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -34,24 +34,25 @@
  * A lock_file object can be in several states:
  *
  * - Uninitialized.  In this state the object's flags field must be
- *   zero but the rest of the contents need not be initialized.  As
- *   soon as the object is used in any way, it is irrevocably
- *   registered in the lock_file_list, and flags & LOCK_FLAGS_ON_LIST
- *   is set.
+ *   zero but the rest of the contents need not be initialized.  In
+ *   particular, the lock_filename strbuf should *not* be initialized
+ *   externally.  The first time the object is used in any way, it is
+ *   initialized, permanently registered in the lock_file_list, and
+ *   flags & LOCK_FLAGS_ON_LIST is set.
  *
  * - Locked, lockfile open (after hold_lock_file_for_update() or
  *   hold_lock_file_for_append()).  In this state, the lockfile
- *   exists, filename holds the filename of the lockfile, fd holds a
- *   file descriptor open for writing to the lockfile, and owner holds
- *   the PID of the process that locked the file.
+ *   exists, lock_filename holds the filename of the lockfile, fd
+ *   holds a file descriptor open for writing to the lockfile, and
+ *   owner holds the PID of the process that locked the file.
  *
  * - Locked, lockfile closed (after close_lock_file()).  Same as the
  *   previous state, except that the lockfile is closed and fd is -1.
  *
  * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
- *   failed attempt to lock).  In this state, filename[0] == '\0' and
- *   fd is -1.  The object is left registered in the lock_file_list,
- *   and flags & LOCK_FLAGS_ON_LIST is set.
+ *   failed attempt to lock).  In this state, lock_filename is the
+ *   empty string and fd is -1.  The object is left registered in the
+ *   lock_file_list, and flags & LOCK_FLAGS_ON_LIST is set.
  *
  * See Documentation/api-lockfile.txt for more information.
  */
@@ -70,10 +71,10 @@ static void remove_lock_file(void)
 
 	while (lock_file_list) {
 		if (lock_file_list->owner == me &&
-		    lock_file_list->filename[0]) {
+		    lock_file_list->lock_filename.len) {
 			if (lock_file_list->fd >= 0)
 				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->filename);
+			unlink_or_warn(lock_file_list->lock_filename.buf);
 		}
 		lock_file_list = lock_file_list->next;
 	}
@@ -87,95 +88,70 @@ static void remove_lock_file_on_signal(int signo)
 }
 
 /*
- * p = absolute or relative path name
+ * path = absolute or relative path name
  *
- * Return a pointer into p showing the beginning of the last path name
- * element.  If p is empty or the root directory ("/"), just return p.
+ * Remove the last path name element from path (leaving the preceding
+ * "/", if any).  If path is empty or the root directory ("/"), set
+ * path to the empty string.
  */
-static char *last_path_elm(char *p)
+static void trim_last_path_elm(struct strbuf *path)
 {
-	/* r starts pointing to null at the end of the string */
-	char *r = strchr(p, '\0');
-
-	if (r == p)
-		return p; /* just return empty string */
-
-	r--; /* back up to last non-null character */
+	int i = path->len;
 
 	/* back up past trailing slashes, if any */
-	while (r > p && *r == '/')
-		r--;
-
+	while (i && path->buf[i - 1] == '/')
+		i--;
 	/*
-	 * then go backwards until I hit a slash, or the beginning of
-	 * the string
+	 * then go backwards until a slash, or the beginning of the
+	 * string
 	 */
-	while (r > p && *(r-1) != '/')
-		r--;
-	return r;
-}
+	while (i && path->buf[i - 1] != '/')
+		i--;
 
+	strbuf_setlen(path, i);
+}
 
 /* We allow "recursive" symbolic links. Only within reason, though */
 #define MAXDEPTH 5
 
 /*
- * p = path that may be a symlink
- * s = full size of p
- *
- * If p is a symlink, attempt to overwrite p with a path to the real
- * file or directory (which may or may not exist), following a chain of
- * symlinks if necessary.  Otherwise, leave p unmodified.
+ * path contains a path that may be a symlink
  *
- * This is a best-effort routine.  If an error occurs, p will either be
- * left unmodified or will name a different symlink in a symlink chain
- * that started with p's initial contents.
+ * If path is a symlink, attempt to overwrite it with a path to the
+ * real file or directory (which may or may not exist), following a
+ * chain of symlinks if necessary.  Otherwise, leave path unmodified.
  *
- * Always returns p.
+ * This is a best-effort routine.  If an error occurs, path will
+ * either be left unmodified or will name a different symlink in a
+ * symlink chain that started with path's initial contents.
  */
-
-static char *resolve_symlink(char *p, size_t s)
+static void resolve_symlink(struct strbuf *path)
 {
 	int depth = MAXDEPTH;
 
 	while (depth--) {
 		char link[PATH_MAX];
-		int link_len = readlink(p, link, sizeof(link));
+		int link_len = readlink(path->buf, link, sizeof(link));
 		if (link_len < 0) {
 			/* not a symlink anymore */
-			return p;
+			return;
 		}
-		else if (link_len < sizeof(link))
-			/* readlink() never null-terminates */
-			link[link_len] = '\0';
-		else {
-			warning("%s: symlink too long", p);
-			return p;
+		if (link_len >= sizeof(link)) {
+			warning("%s: symlink too long", path->buf);
+			return;
 		}
+		/* readlink() never null-terminates */
+		link[link_len] = '\0';
 
-		if (is_absolute_path(link)) {
-			/* absolute path simply replaces p */
-			if (link_len < s)
-				strcpy(p, link);
-			else {
-				warning("%s: symlink too long", p);
-				return p;
-			}
-		} else {
-			/*
-			 * link is a relative path, so I must replace the
-			 * last element of p with it.
-			 */
-			char *r = (char *)last_path_elm(p);
-			if (r - p + link_len < s)
-				strcpy(r, link);
-			else {
-				warning("%s: symlink too long", p);
-				return p;
-			}
-		}
+		if (is_absolute_path(link))
+			/* an absolute path replaces the whole path: */
+			strbuf_setlen(path, 0);
+		else
+			/* a relative path replaces the last element of path: */
+			trim_last_path_elm(path);
+
+		strbuf_add(path, link, link_len);
 	}
-	return p;
 }
 
 /* We append ".lock" to the filename to derive the lockfile name: */
@@ -183,12 +159,7 @@ static char *resolve_symlink(char *p, size_t s)
 
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
-	/*
-	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
-	 * room for adding ".lock" for the lock file name:
-	 */
-	static const size_t max_path_len = sizeof(lk->filename) -
-		                           LOCK_SUFFIX_LEN;
+	size_t path_len = strlen(path);
 
 	if (!lock_file_list) {
 		/* One-time initialization */
@@ -197,31 +168,39 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	}
 
 	lk->owner = getpid();
-	if (!(lk->flags & LOCK_FLAGS_ON_LIST)) {
+	if (lk->flags & LOCK_FLAGS_ON_LIST) {
+		assert(!lk->lock_filename.len); /* object not already in use */
+		if (strbuf_avail(&lk->lock_filename) < path_len + LOCK_SUFFIX_LEN)
+			strbuf_grow(&lk->lock_filename, path_len + LOCK_SUFFIX_LEN);
+	} else {
 		/* Initialize *lk and add it to lock_file_list: */
 		lk->fd = -1;
 		lk->flags |= LOCK_FLAGS_ON_LIST;
-		lk->filename[0] = 0;
+		strbuf_init(&lk->lock_filename, path_len + LOCK_SUFFIX_LEN);
 		lk->next = lock_file_list;
 		lock_file_list = lk;
 	}
 
-	if (strlen(path) >= max_path_len)
-		return -1;
-	strcpy(lk->filename, path);
+	strbuf_add(&lk->lock_filename, path, path_len);
 	if (!(flags & LOCK_NODEREF))
-		resolve_symlink(lk->filename, max_path_len);
-	strcat(lk->filename, ".lock");
-	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
+		resolve_symlink(&lk->lock_filename);
+	strbuf_addstr(&lk->lock_filename, ".lock");
+
+	if (lk->lock_filename.len >= PATH_MAX) {
+		error("%s: path too long", lk->lock_filename.buf);
+		strbuf_setlen(&lk->lock_filename, 0);
+		return -1;
+	}
+	lk->fd = open(lk->lock_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
-		if (adjust_shared_perm(lk->filename)) {
-			error("cannot fix permission bits on %s", lk->filename);
+		if (adjust_shared_perm(lk->lock_filename.buf)) {
+			error("cannot fix permission bits on %s", lk->lock_filename.buf);
 			rollback_lock_file(lk);
 			return -1;
 		}
 	}
 	else
-		lk->filename[0] = 0;
+		strbuf_setlen(&lk->lock_filename, 0);
 	return lk->fd;
 }
 
@@ -300,15 +279,15 @@ int close_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
-	size_t i;
+	size_t path_len = lk->lock_filename.len - LOCK_SUFFIX_LEN;
+
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
-	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
-	result_file[i] = 0;
-	if (rename(lk->filename, result_file))
+	memcpy(result_file, lk->lock_filename.buf, path_len);
+	result_file[path_len] = '\0';
+	if (rename(lk->lock_filename.buf, result_file))
 		return -1;
-	lk->filename[0] = 0;
+	strbuf_setlen(&lk->lock_filename, 0);
 	return 0;
 }
 
@@ -330,9 +309,9 @@ int commit_locked_index(struct lock_file *lk)
 	if (alternate_index_output) {
 		if (lk->fd >= 0 && close_lock_file(lk))
 			return -1;
-		if (rename(lk->filename, alternate_index_output))
+		if (rename(lk->lock_filename.buf, alternate_index_output))
 			return -1;
-		lk->filename[0] = 0;
+		strbuf_setlen(&lk->lock_filename, 0);
 		return 0;
 	}
 	else
@@ -341,10 +320,10 @@ int commit_locked_index(struct lock_file *lk)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0]) {
+	if (lk->lock_filename.len) {
 		if (lk->fd >= 0)
 			close_lock_file(lk);
-		unlink_or_warn(lk->filename);
-		lk->filename[0] = 0;
+		unlink_or_warn(lk->lock_filename.buf);
+		strbuf_setlen(&lk->lock_filename, 0);
 	}
 }
diff --git a/refs.c b/refs.c
index 11ad23e..93abc94 100644
--- a/refs.c
+++ b/refs.c
@@ -2489,8 +2489,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 		 * loose.  The loose file name is the same as the
 		 * lockfile name, minus ".lock":
 		 */
-		char *loose_filename = xmemdupz(lock->lk->filename,
-						strlen(lock->lk->filename) - 5);
+		char *loose_filename = xmemdupz(lock->lk->lock_filename.buf,
+						lock->lk->lock_filename.len - 5);
 		int err = unlink_or_warn(loose_filename);
 		free(loose_filename);
 		if (err && errno != ENOENT)
@@ -2828,7 +2828,7 @@ int write_ref_sha1(struct ref_lock *lock,
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lock_fd, &term, 1) != 1
 		|| close_ref(lock) < 0) {
-		error("Couldn't write %s", lock->lk->filename);
+		error("Couldn't write %s", lock->lk->lock_filename.buf);
 		unlock_ref(lock);
 		return -1;
 	}
diff --git a/shallow.c b/shallow.c
index 0b267b6..a27d587 100644
--- a/shallow.c
+++ b/shallow.c
@@ -269,8 +269,8 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock->filename);
-		*alternate_shallow_file = shallow_lock->filename;
+				  shallow_lock->lock_filename.buf);
+		*alternate_shallow_file = shallow_lock->lock_filename.buf;
 	} else
 		/*
 		 * is_repository_shallow() sees empty string as "no
@@ -316,7 +316,7 @@ void prune_shallow(int show_only)
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock.filename);
+				  shallow_lock.lock_filename.buf);
 		commit_lock_file(&shallow_lock);
 	} else {
 		unlink(git_path("shallow"));
-- 
1.9.0
