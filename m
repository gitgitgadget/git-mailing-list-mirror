From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 22/25] Change lock_file::filename into a strbuf
Date: Mon, 14 Apr 2014 15:54:52 +0200
Message-ID: <1397483695-10888-23-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:56:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMp-0001AN-08
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbaDNNzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:50 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59726 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755213AbaDNNzp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:45 -0400
X-AuditID: 12074413-f79076d000002d17-a4-534be8e0a230
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E8.40.11543.0E8EB435; Mon, 14 Apr 2014 09:55:44 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09M010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:43 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqPvghXewwcUJWhZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGesa3rMWjDLo2L/kXa2BsZJVl2M
	nBwSAiYSR5ZsZoOwxSQu3FsPZHNxCAlcZpRoOPqeBSQhJHCSSeLZA2UQm01AV2JRTzMTiC0i
	oCYxse0QC0gDs0A7k8ShHb1gCWEBJ4nWX1/BmlkEVCU2X7gKFucVcJWYvv0vE8Q2OYmTxyaz
	djFycHACxRd+yILY5SJx98sU1gmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW
	6KWmlG5ihISi8A7GXSflDjEKcDAq8fB2zPEOFmJNLCuuzD3EKMnBpCTKm3EDKMSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmE13UrUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYr
	w8GhJMFb8xyoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UGfHFwNgASfEA7U0C
	aectLkjMBYpCtJ5iVJQS5y0BSQiAJDJK8+DGwhLMK0ZxoC+FedNAqniAyQmu+xXQYCagwSzt
	YINLEhFSUg2MJiX/j8R3LPt03eDAmms9bLGvrZK3WH3fq1c85wpfteeXKbKvlfbmZfxLFpeJ
	ZtPpk113c6uVdLSswYNL+1s/rUrTZyuWWdkZuPrmpXCV/enzqhjWZe4tTjIVPFoR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246234>

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
index 8ffb3ef..38c137f 100644
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
index 9019c7d..319251b 100644
--- a/cache.h
+++ b/cache.h
@@ -543,7 +543,7 @@ struct lock_file {
 	volatile int fd;
 	volatile pid_t owner;
 	char on_list;
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
index 0aa2998..f552e33 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -184,13 +184,6 @@ static char *resolve_symlink(char *p, size_t s)
 
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
@@ -205,26 +198,26 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		lk->active = 0;
 		lk->owner = 0;
 		lk->on_list = 1;
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
-	strcat(lk->filename, LOCK_SUFFIX);
-	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
+	strbuf_addstr(&lk->filename, path);
+	if (!(flags & LOCK_NODEREF)) {
+		resolve_symlink(lk->filename.buf, lk->filename.alloc);
+		strbuf_setlen(&lk->filename, strlen(lk->filename.buf));
+	}
+	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
+	lk->fd = open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
-		lk->filename[0] = 0;
+		strbuf_reset(&lk->filename);
 		return -1;
 	}
 	lk->owner = getpid();
 	lk->active = 1;
-	if (adjust_shared_perm(lk->filename)) {
-		error("cannot fix permission bits on %s", lk->filename);
+	if (adjust_shared_perm(lk->filename.buf)) {
+		error("cannot fix permission bits on %s", lk->filename.buf);
 		rollback_lock_file(lk);
 		return -1;
 	}
@@ -315,14 +308,14 @@ int commit_lock_file(struct lock_file *lk)
 		die("BUG: attempt to commit unlocked object");
 
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
 	lk->active = 0;
-	lk->filename[0] = 0;
+	strbuf_reset(&lk->filename);
 	return 0;
 }
 
@@ -344,10 +337,10 @@ int commit_locked_index(struct lock_file *lk)
 	if (alternate_index_output) {
 		if (lk->fd >= 0 && close_lock_file(lk))
 			return -1;
-		if (rename(lk->filename, alternate_index_output))
+		if (rename(lk->filename.buf, alternate_index_output))
 			return -1;
 		lk->active = 0;
-		lk->filename[0] = 0;
+		strbuf_reset(&lk->filename);
 		return 0;
 	}
 	else
@@ -359,8 +352,8 @@ void rollback_lock_file(struct lock_file *lk)
 	if (lk->active) {
 		if (lk->fd >= 0)
 			close_lock_file(lk);
-		unlink_or_warn(lk->filename);
+		unlink_or_warn(lk->filename.buf);
 		lk->active = 0;
-		lk->filename[0] = 0;
+		strbuf_reset(&lk->filename);
 	}
 }
diff --git a/refs.c b/refs.c
index db8057c..4bad084 100644
--- a/refs.c
+++ b/refs.c
@@ -2492,8 +2492,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
 		 * lockfile name, minus ".lock":
 		 */
 		char *loose_filename = xmemdupz(
-				lock->lk->filename,
-				strlen(lock->lk->filename) - LOCK_SUFFIX_LEN);
+				lock->lk->filename.buf,
+				lock->lk->filename.len - LOCK_SUFFIX_LEN);
 		int err = unlink_or_warn(loose_filename);
 		free(loose_filename);
 		if (err && errno != ENOENT)
@@ -2831,7 +2831,7 @@ int write_ref_sha1(struct ref_lock *lock,
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
