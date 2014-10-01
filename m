From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 28/38] Change lock_file::filename into a strbuf
Date: Wed,  1 Oct 2014 12:28:32 +0200
Message-ID: <1412159322-2622-29-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAt-00032b-TH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbaJAKaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 06:30:16 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53417 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719AbaJAK3i (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:38 -0400
X-AuditID: 12074411-f79d86d000006a97-29-542bd79100b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 43.AE.27287.197DB245; Wed,  1 Oct 2014 06:29:37 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6R026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:36 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsUixO6iqDvxunaIwcv9WhZdV7qZLBp6rzBb
	PJl7l9ni7c0ljBa3V8xntvjR0sNs8W9CjUVnx1dGBw6Pv+8/MHnsnHWX3WPBplKPh6+62D2e
	9e5h9Lh4Sdnj8yY5j9vPtrEEcERx2yQllpQFZ6bn6dslcGe0nzMtaI2teDO5toHxsFcXIyeH
	hICJRNu+LSwQtpjEhXvr2boYuTiEBC4zSix/e54RwjnOJHGo9TEjSBWbgK7Eop5mJhBbREBN
	YmLbIRaQImaBxUwSEw5tYgNJCAs4SfS2XWIHsVkEVCUu7L3JDGLzCrhInDr3hw1inZzEht3/
	wYZyAsWXX24GO0NIwFlix52vTBD1ghInZz4BinMALVCXWD9PCCTMLCAv0bx1NvMERoFZSKpm
	IVTNQlK1gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIXAjuYJxxUu4Q
	owAHoxIPr0KCdogQa2JZcWXuIUZJDiYlUd5Fl4BCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiz
	DwDleFMSK6tSi/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvAzXgBoFi1LTUyvS
	MnNKENJMHJwgw7mkRIpT81JSixJLSzLiQVEaXwyMU5AUD9BeZ5B23uKCxFygKETrKUZdjnWd
	3/qZhFjy8vNSpcR5M0GKBECKMkrz4FbAkuArRnGgj4V5w0GqeIAJFG7SK6AlTEBLkteALSlJ
	REhJNTAWvl2ZrPW0Z8GsUJ46O6e/zbrxyZtnf0ydvVHVo2Zhy+a15xn/c1Uv17js 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257724>

=46or now, we still make sure to allocate at least PATH_MAX characters
for the strbuf because resolve_symlink() doesn't know how to expand
the space for its return value.  (That will be fixed in a moment.)

Another alternative would be to just use a strbuf as scratch space in
lock_file() but then store a pointer to the naked string in struct
lock_file.  But lock_file objects are often reused.  By reusing the
same strbuf, we can avoid having to reallocate the string most times
when a lock_file object is reused.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c | 12 ++++++------
 builtin/reflog.c |  2 +-
 cache.h          |  2 +-
 config.c         | 14 +++++++-------
 lockfile.c       | 53 ++++++++++++++++++++++++------------------------=
-----
 read-cache.c     |  4 ++--
 refs.c           |  6 +++---
 shallow.c        |  6 +++---
 8 files changed, 47 insertions(+), 52 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 70f5935..f55e809 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -341,7 +341,7 @@ static const char *prepare_index(int argc, const ch=
ar **argv, const char *prefix
 			die(_("unable to create temporary index"));
=20
 		old_index_env =3D getenv(INDEX_ENVIRONMENT);
-		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
+		setenv(INDEX_ENVIRONMENT, index_lock.filename.buf, 1);
=20
 		if (interactive_add(argc, argv, prefix, patch_interactive) !=3D 0)
 			die(_("interactive add failed"));
@@ -352,7 +352,7 @@ static const char *prepare_index(int argc, const ch=
ar **argv, const char *prefix
 			unsetenv(INDEX_ENVIRONMENT);
=20
 		discard_cache();
-		read_cache_from(index_lock.filename);
+		read_cache_from(index_lock.filename.buf);
 		if (update_main_cache_tree(WRITE_TREE_SILENT) =3D=3D 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
@@ -362,7 +362,7 @@ static const char *prepare_index(int argc, const ch=
ar **argv, const char *prefix
 			warning(_("Failed to update main cache tree"));
=20
 		commit_style =3D COMMIT_NORMAL;
-		return index_lock.filename;
+		return index_lock.filename.buf;
 	}
=20
 	/*
@@ -385,7 +385,7 @@ static const char *prepare_index(int argc, const ch=
ar **argv, const char *prefix
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 			die(_("unable to write new_index file"));
 		commit_style =3D COMMIT_NORMAL;
-		return index_lock.filename;
+		return index_lock.filename.buf;
 	}
=20
 	/*
@@ -472,9 +472,9 @@ static const char *prepare_index(int argc, const ch=
ar **argv, const char *prefix
 		die(_("unable to write temporary index file"));
=20
 	discard_cache();
-	read_cache_from(false_lock.filename);
+	read_cache_from(false_lock.filename.buf);
=20
-	return false_lock.filename;
+	return false_lock.filename.buf;
 }
=20
 static int run_status(FILE *fp, const char *index_file, const char *pr=
efix, int nowarn,
diff --git a/builtin/reflog.c b/builtin/reflog.c
index e8a8fb1..7c78b15 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -431,7 +431,7 @@ static int expire_reflog(const char *ref, const uns=
igned char *sha1, int unused,
 			 write_str_in_full(lock->lock_fd, "\n") !=3D 1 ||
 			 close_ref(lock) < 0)) {
 			status |=3D error("Couldn't write %s",
-				lock->lk->filename);
+					lock->lk->filename.buf);
 			unlink(newlog_path);
 		} else if (rename(newlog_path, log_file)) {
 			status |=3D error("cannot rename %s to %s",
diff --git a/cache.h b/cache.h
index c2ea6f1..f81d95f 100644
--- a/cache.h
+++ b/cache.h
@@ -580,7 +580,7 @@ struct lock_file {
 	volatile int fd;
 	volatile pid_t owner;
 	char on_list;
-	char filename[PATH_MAX];
+	struct strbuf filename;
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
diff --git a/config.c b/config.c
index 123ed29..2110779 100644
--- a/config.c
+++ b/config.c
@@ -2024,9 +2024,9 @@ int git_config_set_multivar_in_file(const char *c=
onfig_filename,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
=20
-		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
+		if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
 			error("chmod on %s failed: %s",
-				lock->filename, strerror(errno));
+				lock->filename.buf, strerror(errno));
 			ret =3D CONFIG_NO_WRITE;
 			goto out_free;
 		}
@@ -2106,7 +2106,7 @@ out_free:
 	return ret;
=20
 write_err_out:
-	ret =3D write_error(lock->filename);
+	ret =3D write_error(lock->filename.buf);
 	goto out_free;
=20
 }
@@ -2207,9 +2207,9 @@ int git_config_rename_section_in_file(const char =
*config_filename,
=20
 	fstat(fileno(config_file), &st);
=20
-	if (chmod(lock->filename, st.st_mode & 07777) < 0) {
+	if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
 		ret =3D error("chmod on %s failed: %s",
-				lock->filename, strerror(errno));
+				lock->filename.buf, strerror(errno));
 		goto out;
 	}
=20
@@ -2230,7 +2230,7 @@ int git_config_rename_section_in_file(const char =
*config_filename,
 				}
 				store.baselen =3D strlen(new_name);
 				if (!store_write_section(out_fd, new_name)) {
-					ret =3D write_error(lock->filename);
+					ret =3D write_error(lock->filename.buf);
 					goto out;
 				}
 				/*
@@ -2256,7 +2256,7 @@ int git_config_rename_section_in_file(const char =
*config_filename,
 			continue;
 		length =3D strlen(output);
 		if (write_in_full(out_fd, output, length) !=3D length) {
-			ret =3D write_error(lock->filename);
+			ret =3D write_error(lock->filename.buf);
 			goto out;
 		}
 	}
diff --git a/lockfile.c b/lockfile.c
index 1dd118f..85c8648 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -47,9 +47,9 @@
  *   failed attempt to lock, or a failed close_lock_file()).  In this
  *   state:
  *   - active is unset
- *   - filename[0] =3D=3D '\0' (usually, though there are transitory s=
tates
- *     in which this condition doesn't hold). Client code should *not*
- *     rely on this fact!
+ *   - filename is empty (usually, though there are transitory
+ *     states in which this condition doesn't hold). Client code shoul=
d
+ *     *not* rely on the filename being empty in this state.
  *   - fd is -1
  *   - the object is left registered in the lock_file_list, and
  *     on_list is set.
@@ -170,13 +170,6 @@ static char *resolve_symlink(char *p, size_t s)
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags=
)
 {
-	/*
-	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
-	 * room for adding ".lock" for the lock file name:
-	 */
-	static const size_t max_path_len =3D sizeof(lk->filename) -
-					   LOCK_SUFFIX_LEN;
-
 	if (!lock_file_list) {
 		/* One-time initialization */
 		sigchain_push_common(remove_lock_file_on_signal);
@@ -191,30 +184,32 @@ static int lock_file(struct lock_file *lk, const =
char *path, int flags)
 		lk->fd =3D -1;
 		lk->active =3D 0;
 		lk->owner =3D 0;
-		lk->filename[0] =3D 0;
+		strbuf_init(&lk->filename, PATH_MAX);
 		lk->next =3D lock_file_list;
 		lock_file_list =3D lk;
 		lk->on_list =3D 1;
+	} else if (lk->filename.len) {
+		/* This shouldn't happen, but better safe than sorry. */
+		die("BUG: lock_file(\"%s\") called with improperly-reset lock_file o=
bject",
+		    path);
 	}
=20
-	if (strlen(path) >=3D max_path_len) {
-		errno =3D ENAMETOOLONG;
-		return -1;
+	strbuf_addstr(&lk->filename, path);
+	if (!(flags & LOCK_NODEREF)) {
+		resolve_symlink(lk->filename.buf, lk->filename.alloc);
+		strbuf_setlen(&lk->filename, strlen(lk->filename.buf));
 	}
-	strcpy(lk->filename, path);
-	if (!(flags & LOCK_NODEREF))
-		resolve_symlink(lk->filename, max_path_len);
-	strcat(lk->filename, LOCK_SUFFIX);
-	lk->fd =3D open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
+	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
+	lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
-		lk->filename[0] =3D 0;
+		strbuf_reset(&lk->filename);
 		return -1;
 	}
 	lk->owner =3D getpid();
 	lk->active =3D 1;
-	if (adjust_shared_perm(lk->filename)) {
+	if (adjust_shared_perm(lk->filename.buf)) {
 		int save_errno =3D errno;
-		error("cannot fix permission bits on %s", lk->filename);
+		error("cannot fix permission bits on %s", lk->filename.buf);
 		rollback_lock_file(lk);
 		errno =3D save_errno;
 		return -1;
@@ -313,7 +308,7 @@ int reopen_lock_file(struct lock_file *lk)
 		die(_("BUG: reopen a lockfile that is still open"));
 	if (!lk->active)
 		die(_("BUG: reopen a lockfile that has been committed"));
-	lk->fd =3D open(lk->filename, O_WRONLY);
+	lk->fd =3D open(lk->filename.buf, O_WRONLY);
 	return lk->fd;
 }
=20
@@ -329,9 +324,9 @@ int commit_lock_file(struct lock_file *lk)
 		return -1;
=20
 	/* remove ".lock": */
-	strbuf_add(&result_file, lk->filename,
-		   strlen(lk->filename) - LOCK_SUFFIX_LEN);
-	err =3D rename(lk->filename, result_file.buf);
+	strbuf_add(&result_file, lk->filename.buf,
+		   lk->filename.len - LOCK_SUFFIX_LEN);
+	err =3D rename(lk->filename.buf, result_file.buf);
 	strbuf_reset(&result_file);
 	if (err) {
 		int save_errno =3D errno;
@@ -341,7 +336,7 @@ int commit_lock_file(struct lock_file *lk)
 	}
=20
 	lk->active =3D 0;
-	lk->filename[0] =3D 0;
+	strbuf_reset(&lk->filename);
 	return 0;
 }
=20
@@ -359,8 +354,8 @@ void rollback_lock_file(struct lock_file *lk)
 		return;
=20
 	if (!close_lock_file(lk)) {
-		unlink_or_warn(lk->filename);
+		unlink_or_warn(lk->filename.buf);
 		lk->active =3D 0;
-		lk->filename[0] =3D 0;
+		strbuf_reset(&lk->filename);
 	}
 }
diff --git a/read-cache.c b/read-cache.c
index af69f34..91bf876 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2044,10 +2044,10 @@ static int commit_locked_index(struct lock_file=
 *lk)
 	if (alternate_index_output) {
 		if (close_lock_file(lk))
 			return -1;
-		if (rename(lk->filename, alternate_index_output))
+		if (rename(lk->filename.buf, alternate_index_output))
 			return -1;
 		lk->active =3D 0;
-		lk->filename[0] =3D 0;
+		strbuf_reset(&lk->filename);
 		return 0;
 	} else {
 		return commit_lock_file(lk);
diff --git a/refs.c b/refs.c
index a415131..598f4eb 100644
--- a/refs.c
+++ b/refs.c
@@ -2607,8 +2607,8 @@ static int delete_ref_loose(struct ref_lock *lock=
, int flag)
 		 * lockfile name, minus ".lock":
 		 */
 		char *loose_filename =3D xmemdupz(
-				lock->lk->filename,
-				strlen(lock->lk->filename) - LOCK_SUFFIX_LEN);
+				lock->lk->filename.buf,
+				lock->lk->filename.len - LOCK_SUFFIX_LEN);
 		int err =3D unlink_or_warn(loose_filename);
 		free(loose_filename);
 		if (err && errno !=3D ENOENT)
@@ -2972,7 +2972,7 @@ int write_ref_sha1(struct ref_lock *lock,
 	    write_in_full(lock->lock_fd, &term, 1) !=3D 1 ||
 	    close_ref(lock) < 0) {
 		int save_errno =3D errno;
-		error("Couldn't write %s", lock->lk->filename);
+		error("Couldn't write %s", lock->lk->filename.buf);
 		unlock_ref(lock);
 		errno =3D save_errno;
 		return -1;
diff --git a/shallow.c b/shallow.c
index 57f4afa..4919baf 100644
--- a/shallow.c
+++ b/shallow.c
@@ -269,8 +269,8 @@ void setup_alternate_shallow(struct lock_file *shal=
low_lock,
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock->filename);
-		*alternate_shallow_file =3D shallow_lock->filename;
+				  shallow_lock->filename.buf);
+		*alternate_shallow_file =3D shallow_lock->filename.buf;
 	} else
 		/*
 		 * is_repository_shallow() sees empty string as "no
@@ -316,7 +316,7 @@ void prune_shallow(int show_only)
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock.filename);
+				  shallow_lock.filename.buf);
 		commit_lock_file(&shallow_lock);
 	} else {
 		unlink(git_path("shallow"));
--=20
2.1.0
