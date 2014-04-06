From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/25] Change lock_file::filename into a strbuf
Date: Mon,  7 Apr 2014 01:34:04 +0200
Message-ID: <1396827247-28465-23-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc7-00074B-A7
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbaDFXgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:19 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46573 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754663AbaDFXfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:25 -0400
X-AuditID: 1207440c-f79656d000003eba-56-5341e4bcde84
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 35.41.16058.CB4E1435; Sun,  6 Apr 2014 19:35:24 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX9011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:22 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLvniWOwwbo98hZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO2PGzB+MBcs9K47cvc3UwDjZuouRk0NCwETi9/dD
	bBC2mMSFe+uBbC4OIYHLjBKtD5sZIZzjTBKT155hBaliE9CVWNTTzARiiwioSUxsO8QCUsQs
	cINR4t2+wywgCWEBJ4lzV7uZQWwWAVWJJR27wJp5BVwlPu18zw6xTk7i5LHJYHFOoPi6yXPB
	eoUEXIDm3GObwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrpJkZI8PHs
	YPy2TuYQowAHoxIP74pDjsFCrIllxZW5hxglOZiURHkfPAYK8SXlp1RmJBZnxBeV5qQWH2KU
	4GBWEuE9cAMox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4O0DGSpY
	lJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPio74YmB8gKR4gPZOB2nnLS5IzAWKQrSe
	YlSUEued+QgoIQCSyCjNgxsLSymvGMWBvhTmXQbSzgNMR3Ddr4AGMwENbgizAxlckoiQkmpg
	dGNP/L2U7cum5Damc3JGXj+s3Cylrr5s3e7lM2vaVQ1Gz5U6xgnfQ7fvWrvqv+uMsDqdBg+9
	+YdrFnRWljz68cBrmWF8wAZLwZPqESt33XmcUNMSoLPv1VS+u9tPN1m82bGQgTPr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245821>

For now, we still make sure to allocate at least PATH_MAX characters
for the strbuf because resolve_symlink() doesn't know how to expand
the space for its return value.  (That will be fixed in a moment.)

Another alternative would be to just use a strbuf as scratch space in
lock_file() but then store a pointer to the naked string in struct
lock_file.  But lock_file objects are often reused.  By reusing the
same strbuf, we can avoid having to reallocate the string most times
when a lock_file object is reused.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c | 12 ++++++------
 builtin/reflog.c |  2 +-
 cache.h          |  2 +-
 config.c         |  6 +++---
 lockfile.c       | 45 +++++++++++++++++++--------------------------
 refs.c           |  6 +++---
 shallow.c        |  6 +++---
 7 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2e2d8bb..1833595 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -330,7 +330,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			die(_("unable to create temporary index"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
-		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
+		setenv(INDEX_ENVIRONMENT, index_lock.filename.buf, 1);
 
 		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
@@ -341,10 +341,10 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			unsetenv(INDEX_ENVIRONMENT);
 
 		discard_cache();
-		read_cache_from(index_lock.filename);
+		read_cache_from(index_lock.filename.buf);
 
 		commit_style = COMMIT_NORMAL;
-		return index_lock.filename;
+		return index_lock.filename.buf;
 	}
 
 	/*
@@ -368,7 +368,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		    close_lock_file(&index_lock))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
-		return index_lock.filename;
+		return index_lock.filename.buf;
 	}
 
 	/*
@@ -453,9 +453,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		die(_("unable to write temporary index file"));
 
 	discard_cache();
-	read_cache_from(false_lock.filename);
+	read_cache_from(false_lock.filename.buf);
 
-	return false_lock.filename;
+	return false_lock.filename.buf;
 }
 
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
diff --git a/builtin/reflog.c b/builtin/reflog.c
index c12a9784..d7df34e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -431,7 +431,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("Couldn't write %s",
-				lock->lk->filename);
+					lock->lk->filename.buf);
 			unlink(newlog_path);
 		} else if (rename(newlog_path, log_file)) {
 			status |= error("cannot rename %s to %s",
diff --git a/cache.h b/cache.h
index 59ce5cd..6ab2483 100644
--- a/cache.h
+++ b/cache.h
@@ -538,7 +538,7 @@ struct lock_file {
 	int fd;
 	pid_t owner;
 	unsigned char flags;
-	char filename[PATH_MAX];
+	struct strbuf filename;
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
diff --git a/config.c b/config.c
index 6821cef..78c3dad 100644
--- a/config.c
+++ b/config.c
@@ -1706,7 +1706,7 @@ out_free:
 	return ret;
 
 write_err_out:
-	ret = write_error(lock->filename);
+	ret = write_error(lock->filename.buf);
 	goto out_free;
 
 }
@@ -1821,7 +1821,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 				}
 				store.baselen = strlen(new_name);
 				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error(lock->filename);
+					ret = write_error(lock->filename.buf);
 					goto out;
 				}
 				/*
@@ -1847,7 +1847,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 			continue;
 		length = strlen(output);
 		if (write_in_full(out_fd, output, length) != length) {
-			ret = write_error(lock->filename);
+			ret = write_error(lock->filename.buf);
 			goto out;
 		}
 	}
diff --git a/lockfile.c b/lockfile.c
index bf018b5..3befd7e 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -196,13 +196,6 @@ static char *resolve_symlink(char *p, size_t s)
 
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
-	/*
-	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
-	 * room for adding ".lock" for the lock file name:
-	 */
-	static const size_t max_path_len = sizeof(lk->filename) -
-					   LOCK_SUFFIX_LEN;
-
 	if (!lock_file_list) {
 		/* One-time initialization */
 		sigchain_push_common(remove_lock_file_on_signal);
@@ -216,26 +209,26 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		lk->fd = -1;
 		lk->owner = 0;
 		lk->flags |= LOCK_FLAGS_ON_LIST;
-		lk->filename[0] = 0;
+		strbuf_init(&lk->filename, PATH_MAX);
 		lk->next = lock_file_list;
 		lock_file_list = lk;
 	}
 
-	if (strlen(path) >= max_path_len)
-		return -1;
-	strcpy(lk->filename, path);
-	if (!(flags & LOCK_NODEREF))
-		resolve_symlink(lk->filename, max_path_len);
-	strcat(lk->filename, ".lock");
-	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
+	strbuf_addstr(&lk->filename, path);
+	if (!(flags & LOCK_NODEREF)) {
+		resolve_symlink(lk->filename.buf, lk->filename.alloc);
+		strbuf_setlen(&lk->filename, strlen(lk->filename.buf));
+	}
+	strbuf_addstr(&lk->filename, ".lock");
+	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
-		lk->filename[0] = 0;
+		strbuf_reset(&lk->filename);
 		return -1;
 	}
 	lk->owner = getpid();
 	lk->flags |= LOCK_FLAGS_LOCKFILE_ACTIVE;
-	if (adjust_shared_perm(lk->filename)) {
-		error("cannot fix permission bits on %s", lk->filename);
+	if (adjust_shared_perm(lk->filename.buf)) {
+		error("cannot fix permission bits on %s", lk->filename.buf);
 		rollback_lock_file(lk);
 		return -1;
 	}
@@ -326,14 +319,14 @@ int commit_lock_file(struct lock_file *lk)
 		return 0;
 
 	/* remove ".lock": */
-	strbuf_add(&result_file, lk->filename,
-		   strlen(lk->filename) - LOCK_SUFFIX_LEN);
-	err = rename(lk->filename, result_file.buf);
+	strbuf_add(&result_file, lk->filename.buf,
+		   lk->filename.len - LOCK_SUFFIX_LEN);
+	err = rename(lk->filename.buf, result_file.buf);
 	strbuf_reset(&result_file);
 	if (err)
 		return -1;
 	lk->flags &= ~LOCK_FLAGS_LOCKFILE_ACTIVE;
-	lk->filename[0] = 0;
+	strbuf_reset(&lk->filename);
 	return 0;
 }
 
@@ -355,10 +348,10 @@ int commit_locked_index(struct lock_file *lk)
 	if (alternate_index_output) {
 		if (lk->fd >= 0 && close_lock_file(lk))
 			return -1;
-		if (rename(lk->filename, alternate_index_output))
+		if (rename(lk->filename.buf, alternate_index_output))
 			return -1;
 		lk->flags &= ~LOCK_FLAGS_LOCKFILE_ACTIVE;
-		lk->filename[0] = 0;
+		strbuf_reset(&lk->filename);
 		return 0;
 	}
 	else
@@ -370,8 +363,8 @@ void rollback_lock_file(struct lock_file *lk)
 	if (lk->flags & LOCK_FLAGS_LOCKFILE_ACTIVE) {
 		if (lk->fd >= 0)
 			close_lock_file(lk);
-		unlink_or_warn(lk->filename);
+		unlink_or_warn(lk->filename.buf);
 		lk->flags &= ~LOCK_FLAGS_LOCKFILE_ACTIVE;
-		lk->filename[0] = 0;
+		strbuf_reset(&lk->filename);
 	}
 }
diff --git a/refs.c b/refs.c
index cd471ab..15d9e04 100644
--- a/refs.c
+++ b/refs.c
@@ -2489,8 +2489,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 		 * loose.  The loose file name is the same as the
 		 * lockfile name, minus ".lock":
 		 */
-		char *loose_filename = xmemdupz(lock->lk->filename,
-						strlen(lock->lk->filename) - 5);
+		char *loose_filename = xmemdupz(lock->lk->filename.buf,
+						lock->lk->filename.len - 5);
 		int err = unlink_or_warn(loose_filename);
 		free(loose_filename);
 		if (err && errno != ENOENT)
@@ -2828,7 +2828,7 @@ int write_ref_sha1(struct ref_lock *lock,
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lock_fd, &term, 1) != 1
 		|| close_ref(lock) < 0) {
-		error("Couldn't write %s", lock->lk->filename);
+		error("Couldn't write %s", lock->lk->filename.buf);
 		unlock_ref(lock);
 		return -1;
 	}
diff --git a/shallow.c b/shallow.c
index 0b267b6..cb29a66 100644
--- a/shallow.c
+++ b/shallow.c
@@ -269,8 +269,8 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock->filename);
-		*alternate_shallow_file = shallow_lock->filename;
+				  shallow_lock->filename.buf);
+		*alternate_shallow_file = shallow_lock->filename.buf;
 	} else
 		/*
 		 * is_repository_shallow() sees empty string as "no
@@ -316,7 +316,7 @@ void prune_shallow(int show_only)
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock.filename);
+				  shallow_lock.filename.buf);
 		commit_lock_file(&shallow_lock);
 	} else {
 		unlink(git_path("shallow"));
-- 
1.9.1
