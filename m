From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v23 0/25] rs/ref-transaction ("Use ref transactions", part 3)
Date: Tue, 14 Oct 2014 17:45:23 -0700
Message-ID: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:45:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCiZ-0006vt-2t
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbaJOAp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:45:27 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58804 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbaJOAp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:45:26 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so211074pad.39
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=WeadJWYDMsKtJexZ3cFfBaPnINdcaI1tDVK/N1tlMTs=;
        b=DmJnKrDXSJtW1fARt3yR/NpU4Ftxo1I/uuiHZx5kp7hDBWqXYHx2XZYCfjrpdwhZ4X
         dgtm4IrhAX7T1/43y0OfKuxoGiK10WyFDot3JdvXTx7Nx3C0PNZRoeZiNK2PWPKYJsaV
         Kfdv8tIyoGyGSHSl+2/BYUijf/bo2dSjFvcGKuND5aUB9BXa3+0ILqEO0O5Gjbi0zWl8
         f+4NZfnAWAom2whBCy865/kCGmIdTaQZHAoo5Mov5RqkXCmGGNhD5+SPCn5EiAiW//L5
         pPM82vroir7waEYzNAIhWfQT0HilH3xk+fU6Sz5FH8Ls5pgMGdxfKnEk96IAjwYvjIPr
         LD4w==
X-Received: by 10.67.4.167 with SMTP id cf7mr8598002pad.52.1413333926037;
        Tue, 14 Oct 2014 17:45:26 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id d9sm15395322pdm.5.2014.10.14.17.45.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:45:25 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series by Ronnie was last seen on-list at [1].  It includes some
improvements to the ref-transaction API, improves handling of poorly
named refs (which should make it easier to tighten the refname format
checks in the future), and is a stepping stone toward later series
that use the ref-transaction API more and make it support alternate
backends (yay!).

The changes since (a merge of 'master' and) v22 are very minor and can
be seen below[2].  The more important change is that it's rebased
against current 'master'.

Review comments from Michael and Junio were very helpful in getting
this in shape.  Thanks much to both.

The series can also be found at

  git://repo.or.cz/git/jrn.git tags/rs/ref-transaction

It is based against current 'master' (670a3c1d, 2014-10-14) and
intended for 'next'.

Thoughts welcome, as always.  Improvements preferred in the form of
patches on top of the series.

Jonathan Nieder (6):
  mv test: recreate mod/ directory instead of relying on stale copy
  branch -d: avoid repeated symref resolution
  packed-ref cache: forbid dot-components in refnames
  refs.c: do not permit err == NULL
  lockfile: remove unable_to_lock_error
  ref_transaction_commit: bail out on failure to remove a ref

Junio C Hamano (1):
  reflog test: test interaction with detached HEAD

Ronnie Sahlberg (18):
  wrapper.c: remove/unlink_or_warn: simplify, treat ENOENT as success
  refs.c: lock_ref_sha1_basic is used for all refs
  wrapper.c: add a new function unlink_or_msg
  refs.c: add an err argument to delete_ref_loose
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  rename_ref: don't ask read_ref_full where the ref came from
  refs.c: refuse to lock badly named refs in lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: pass a list of names to skip to is_refname_available
  refs.c: ref_transaction_commit: distinguish name conflicts from other
    errors
  fetch.c: change s_update_ref to use a ref transaction
  refs.c: make write_ref_sha1 static
  refs.c: change resolve_ref_unsafe reading argument to be a flags field
  branch -d: simplify by using RESOLVE_REF_READING
  test: put tests for handling of bad ref names in one place
  refs.c: allow listing and deleting badly named refs
  for-each-ref: skip and warn about broken ref names
  remote rm/prune: print a message when writing packed-refs fails

 branch.c                 |   6 +-
 builtin/blame.c          |   2 +-
 builtin/branch.c         |  22 ++-
 builtin/checkout.c       |   6 +-
 builtin/clone.c          |   2 +-
 builtin/commit.c         |   6 +-
 builtin/fetch.c          |  34 ++--
 builtin/fmt-merge-msg.c  |   2 +-
 builtin/for-each-ref.c   |  11 +-
 builtin/fsck.c           |   2 +-
 builtin/log.c            |   3 +-
 builtin/merge.c          |   2 +-
 builtin/notes.c          |   2 +-
 builtin/receive-pack.c   |   9 +-
 builtin/remote.c         |  20 ++-
 builtin/replace.c        |   5 +-
 builtin/show-branch.c    |   7 +-
 builtin/symbolic-ref.c   |   2 +-
 builtin/tag.c            |   4 +-
 builtin/update-ref.c     |  13 +-
 bundle.c                 |   2 +-
 cache.h                  |  44 +++--
 fast-import.c            |   8 +-
 git-compat-util.h        |  16 +-
 http-backend.c           |   4 +-
 lockfile.c               |  10 --
 lockfile.h               |   1 -
 notes-merge.c            |   2 +-
 reflog-walk.c            |   5 +-
 refs.c                   | 446 ++++++++++++++++++++++++++++++++---------------
 refs.h                   |  44 +++--
 remote.c                 |  11 +-
 sequencer.c              |   8 +-
 t/t1400-update-ref.sh    |  62 +++----
 t/t1413-reflog-detach.sh |  70 ++++++++
 t/t1430-bad-ref-name.sh  | 207 ++++++++++++++++++++++
 t/t3200-branch.sh        |   9 +
 t/t7001-mv.sh            |  15 +-
 t/t9300-fast-import.sh   |  30 ----
 transport-helper.c       |   5 +-
 transport.c              |   5 +-
 upload-pack.c            |   2 +-
 walker.c                 |   5 +-
 wrapper.c                |  28 ++-
 wt-status.c              |   2 +-
 45 files changed, 850 insertions(+), 351 deletions(-)
 create mode 100755 t/t1413-reflog-detach.sh
 create mode 100755 t/t1430-bad-ref-name.sh

[1] http://thread.gmane.org/gmane.comp.version-control.git/254501/focus=257771
[2]
 cache.h           | 11 ++++---
 git-compat-util.h |  4 +--
 refs.c            | 96 +++++++++++++++++++++++++++++--------------------------
 refs.h            |  6 +++-
 4 files changed, 64 insertions(+), 53 deletions(-)

diff --git a/cache.h b/cache.h
index 209e8ba..0501f7d 100644
--- a/cache.h
+++ b/cache.h
@@ -983,7 +983,8 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * packed references), REF_ISSYMREF (if the initial reference was a
  * symbolic reference), REF_BAD_NAME (if the reference name is ill
  * formed --- see RESOLVE_REF_ALLOW_BAD_NAME below), and REF_ISBROKEN
- * (if the ref is malformed).
+ * (if the ref is malformed or has a bad name). See refs.h for more detail
+ * on each flag.
  *
  * If ref is not a properly-formatted, normalized reference, return
  * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
@@ -991,12 +992,14 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  *
  * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
  * name is invalid according to git-check-ref-format(1).  If the name
- * is bad then the value stored in sha1 will be null_sha1 and the
- * REF_ISBROKEN and REF_BAD_NAME flags will be set.
+ * is bad then the value stored in sha1 will be null_sha1 and the two
+ * flags REF_ISBROKEN and REF_BAD_NAME will be set.
  *
  * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
  * directory and do not consist of all caps and underscores cannot be
- * resolved.  The function returns NULL for such ref names.
+ * resolved. The function returns NULL for such ref names.
+ * Caps and underscores refers to the special refs, such as HEAD,
+ * FETCH_HEAD and friends, that all live outside of the refs/ directory.
  */
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
diff --git a/git-compat-util.h b/git-compat-util.h
index 8f805bf..59ecf21 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -779,7 +779,7 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
- * Returns 0 on success which includes trying to unlink an object that does
+ * Returns 0 on success, which includes trying to unlink an object that does
  * not exist.
  */
 int unlink_or_warn(const char *path);
@@ -792,7 +792,7 @@ int unlink_or_warn(const char *path);
 int unlink_or_msg(const char *file, struct strbuf *err);
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
- * Returns 0 on success which includes trying to remove a directory that does
+ * Returns 0 on success, which includes trying to remove a directory that does
  * not exist.
  */
 int rmdir_or_warn(const char *path);
diff --git a/refs.c b/refs.c
index bee0e39..0368ed4 100644
--- a/refs.c
+++ b/refs.c
@@ -274,29 +274,31 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	return dir;
 }
 
-static int escapes_cwd(const char *path) {
-	char *buf;
-	int result;
-
-	if (is_absolute_path(path))
-		return 1;
-	buf = xmalloc(strlen(path) + 1);
-	result = !!normalize_path_copy(buf, path);
-	free(buf);
-	return result;
-}
-
 /*
  * Check if a refname is safe.
- * For refs that start with "refs/" we consider it safe as long as the rest
- * of the path components does not allow it to escape from this directory.
+ * For refs that start with "refs/" we consider it safe as long they do
+ * not try to resolve to outside of refs/.
+ *
  * For all other refs we only consider them safe iff they only contain
- * upper case characters and '_'.
+ * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
+ * "config").
  */
 static int refname_is_safe(const char *refname)
 {
-	if (starts_with(refname, "refs/"))
-		return !escapes_cwd(refname + strlen("refs/"));
+	if (starts_with(refname, "refs/")) {
+		char *buf;
+		int result;
+
+		buf = xmalloc(strlen(refname) + 1);
+		/*
+		 * Does the refname try to escape refs/?
+		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
+		 * is not.
+		 */
+		result = !normalize_path_copy(buf, refname + strlen("refs/"));
+		free(buf);
+		return result;
+	}
 	while (*refname) {
 		if (!isupper(*refname) && *refname != '_')
 			return 0;
@@ -812,13 +814,13 @@ static void prime_ref_dir(struct ref_dir *dir)
 	}
 }
 
-static int entry_matches(struct ref_entry *entry, struct string_list *list)
+static int entry_matches(struct ref_entry *entry, const struct string_list *list)
 {
 	return list && string_list_has_string(list, entry->name);
 }
 
 struct nonmatching_ref_data {
-	struct string_list *skip;
+	const struct string_list *skip;
 	struct ref_entry *found;
 };
 
@@ -842,18 +844,20 @@ static void report_refname_conflict(struct ref_entry *entry,
 /*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.  If
- * skiplist is non-NULL, ignore potential conflicts with names in
- * skiplist (e.g., because those refs are scheduled for deletion in
- * the same operation).  skiplist must be sorted.
+ * skip is non-NULL, ignore potential conflicts with refs in skip
+ * (e.g., because they are scheduled for deletion in the same
+ * operation).
  *
  * Two reference names conflict if one of them exactly matches the
  * leading components of the other; e.g., "foo/bar" conflicts with
  * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
  * "foo/barbados".
+ *
+ * skip must be sorted.
  */
 static int is_refname_available(const char *refname,
-				struct ref_dir *dir,
-				struct string_list *skiplist)
+				const struct string_list *skip,
+				struct ref_dir *dir)
 {
 	const char *slash;
 	size_t len;
@@ -866,12 +870,12 @@ static int is_refname_available(const char *refname,
 		 * looking for a conflict with a leaf entry.
 		 *
 		 * If we find one, we still must make sure it is
-		 * not in "skiplist".
+		 * not in "skip".
 		 */
 		pos = search_ref_dir(dir, refname, slash - refname);
 		if (pos >= 0) {
 			struct ref_entry *entry = dir->entries[pos];
-			if (entry_matches(entry, skiplist))
+			if (entry_matches(entry, skip))
 				return 1;
 			report_refname_conflict(entry, refname);
 			return 0;
@@ -903,14 +907,14 @@ static int is_refname_available(const char *refname,
 	if (pos >= 0) {
 		/*
 		 * We found a directory named "refname". It is a
-		 * problem iff it contains any ref that is not in
-		 * "skiplist".
+		 * problem iff it contains any ref that is not
+		 * in "skip".
 		 */
 		struct ref_entry *entry = dir->entries[pos];
 		struct ref_dir *dir = get_ref_dir(entry);
 		struct nonmatching_ref_data data;
 
-		data.skip = skiplist;
+		data.skip = skip;
 		sort_ref_dir(dir);
 		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
 			return 1;
@@ -1596,7 +1600,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 		}
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flags)
-				*flags |= REF_BAD_NAME | REF_ISBROKEN;
+				*flags |= REF_ISBROKEN;
 
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(buf)) {
@@ -2217,12 +2221,12 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 }
 
 /*
- * Locks a "refs/" ref returning the lock on success and NULL on failure.
+ * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    struct string_list *skiplist,
+					    const struct string_list *skip,
 					    int flags, int *type_p)
 {
 	char *ref_file;
@@ -2278,8 +2282,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, get_packed_refs(&ref_cache),
-				   skiplist)) {
+	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2780,6 +2783,18 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int rename_ref_available(const char *oldname, const char *newname)
+{
+	struct string_list skip = STRING_LIST_INIT_NODUP;
+	int ret;
+
+	string_list_insert(&skip, oldname);
+	ret = is_refname_available(newname, &skip, get_packed_refs(&ref_cache))
+	    && is_refname_available(newname, &skip, get_loose_refs(&ref_cache));
+	string_list_clear(&skip, 0);
+	return ret;
+}
+
 static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
 			  const char *logmsg);
 
@@ -2791,7 +2806,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
-	struct string_list skiplist = STRING_LIST_INIT_NODUP;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -2804,18 +2818,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
-	string_list_insert(&skiplist, oldrefname);
-	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
-				  &skiplist)) {
-		string_list_clear(&skiplist, 0);
+	if (!rename_ref_available(oldrefname, newrefname))
 		return 1;
-	}
-	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
-				  &skiplist)) {
-		string_list_clear(&skiplist, 0);
-		return 1;
-	}
-	string_list_clear(&skiplist, 0);
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
diff --git a/refs.h b/refs.h
index e1c43f9..2bc3556 100644
--- a/refs.h
+++ b/refs.h
@@ -62,7 +62,11 @@ struct ref_transaction;
  */
 #define REF_ISBROKEN 0x04
 
-/* Reference name is not well formed (see git-check-ref-format(1)). */
+/*
+ * Reference name is not well formed.
+ *
+ * See git-check-ref-format(1) for the definition of well formed ref names.
+ */
 #define REF_BAD_NAME 0x08
 
 /*
