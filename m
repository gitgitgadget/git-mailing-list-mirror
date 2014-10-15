From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/25] refs.c: allow listing and deleting badly named refs
Date: Tue, 14 Oct 2014 17:54:05 -0700
Message-ID: <20141015005405.GX32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCr0-00041J-0o
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbaJOAyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:54:09 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44306 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbaJOAyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:54:08 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so223475pde.28
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fBHO1uLR8R9wbNuuwSEvKlXGF929rXcemuarQmdR/qc=;
        b=HpmTRF5v8kbJU3cdWalprf/G1wxaTioiWxL4ndBY+3v1gBJYTqTsGXTzQxpEYDFUkE
         dyLVsIRaRB4QsmVg82wI4YM1FKOgyPJ7Dxrpwf5ti8jfnsDr/G2g2Wltn+iBPm7eUwZE
         TRZ9wA8/4l+xwe5kfkyXKYPfvlbj9yLfQyXx/zM/jrU0ZzVuMqr19ky1N3fm99V4Z4PW
         aOjclhZdcQrC97wv3dwKwRPkoclMivg8K45a/Z6ocOhUqTosDfCWQsRm4qJ2Q83VJGOJ
         8vncCgysKj9TYRMPvG2XejUTK+Z8P0t3LV802sGL9l0QbroRv0boFLtEy9MhhbIPMXFJ
         6aLg==
X-Received: by 10.67.22.1 with SMTP id ho1mr9442661pad.4.1413334448187;
        Tue, 14 Oct 2014 17:54:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id rb2sm15515778pab.5.2014.10.14.17.54.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:54:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 3 Sep 2014 11:45:43 -0700

We currently do not handle badly named refs well:

  $ cp .git/refs/heads/master .git/refs/heads/master.....@\*@\\.
  $ git branch
    fatal: Reference has invalid format: 'refs/heads/master.....@*@\.'
  $ git branch -D master.....@\*@\\.
    error: branch 'master.....@*@\.' not found.

Users cannot recover from a badly named ref without manually finding
and deleting the loose ref file or appropriate line in packed-refs.
Making that easier will make it easier to tweak the ref naming rules
in the future, for example to forbid shell metacharacters like '`'
and '"', without putting people in a state that is hard to get out of.

So allow "branch --list" to show these refs and allow "branch -d/-D"
and "update-ref -d" to delete them.  Other commands (for example to
rename refs) will continue to not handle these refs but can be changed
in later patches.

Details:

In resolving functions, refuse to resolve refs that don't pass the
git-check-ref-format(1) check unless the new RESOLVE_REF_ALLOW_BAD_NAME
flag is passed.  Even with RESOLVE_REF_ALLOW_BAD_NAME, refuse to
resolve refs that escape the refs/ directory and do not match the
pattern [A-Z_]* (think "HEAD" and "MERGE_HEAD").

In locking functions, refuse to act on badly named refs unless they
are being deleted and either are in the refs/ directory or match [A-Z_]*.

Just like other invalid refs, flag resolved, badly named refs with the
REF_ISBROKEN flag, treat them as resolving to null_sha1, and skip them
in all iteration functions except for for_each_rawref.

Flag badly named refs (but not symrefs pointing to badly named refs)
with a REF_BAD_NAME flag to make it easier for future callers to
notice and handle them specially.  For example, in a later patch
for-each-ref will use this flag to detect refs whose names can confuse
callers parsing for-each-ref output.

In the transaction API, refuse to create or update badly named refs,
but allow deleting them (unless they try to escape refs/ and don't match
[A-Z_]*).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/branch.c        |   9 +--
 cache.h                 |  17 +++++-
 refs.c                  | 148 ++++++++++++++++++++++++++++++++++++++----------
 refs.h                  |  12 +++-
 t/t1430-bad-ref-name.sh | 125 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 273 insertions(+), 38 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0c7aac0..7e113d6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -238,7 +238,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		name = mkpathdup(fmt, bname.buf);
 		target = resolve_ref_unsafe(name,
 					    RESOLVE_REF_READING
-					    | RESOLVE_REF_NO_RECURSE,
+					    | RESOLVE_REF_NO_RECURSE
+					    | RESOLVE_REF_ALLOW_BAD_NAME,
 					    sha1, &flags);
 		if (!target) {
 			error(remote_branch
@@ -248,7 +249,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & REF_ISSYMREF) &&
+		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
 					force)) {
 			ret = 1;
@@ -268,8 +269,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			       ? _("Deleted remote branch %s (was %s).\n")
 			       : _("Deleted branch %s (was %s).\n"),
 			       bname.buf,
-			       (flags & REF_ISSYMREF)
-			       ? target
+			       (flags & REF_ISBROKEN) ? "broken"
+			       : (flags & REF_ISSYMREF) ? target
 			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
 		}
 		delete_branch_config(bname.buf);
diff --git a/cache.h b/cache.h
index b735f3f..0501f7d 100644
--- a/cache.h
+++ b/cache.h
@@ -981,16 +981,29 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * If flags is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
  * packed references), REF_ISSYMREF (if the initial reference was a
- * symbolic reference) and REF_ISBROKEN (if the ref is malformed).
+ * symbolic reference), REF_BAD_NAME (if the reference name is ill
+ * formed --- see RESOLVE_REF_ALLOW_BAD_NAME below), and REF_ISBROKEN
+ * (if the ref is malformed or has a bad name). See refs.h for more detail
+ * on each flag.
  *
  * If ref is not a properly-formatted, normalized reference, return
  * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
  * give up and return NULL.
  *
- * errno is set to something meaningful on error.
+ * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
+ * name is invalid according to git-check-ref-format(1).  If the name
+ * is bad then the value stored in sha1 will be null_sha1 and the two
+ * flags REF_ISBROKEN and REF_BAD_NAME will be set.
+ *
+ * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
+ * directory and do not consist of all caps and underscores cannot be
+ * resolved. The function returns NULL for such ref names.
+ * Caps and underscores refers to the special refs, such as HEAD,
+ * FETCH_HEAD and friends, that all live outside of the refs/ directory.
  */
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
+#define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 extern const char *resolve_ref_unsafe(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 extern char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 
diff --git a/refs.c b/refs.c
index fe1352a..e7000f2 100644
--- a/refs.c
+++ b/refs.c
@@ -187,8 +187,8 @@ struct ref_dir {
 
 /*
  * Bit values for ref_entry::flag.  REF_ISSYMREF=0x01,
- * REF_ISPACKED=0x02, and REF_ISBROKEN=0x04 are public values; see
- * refs.h.
+ * REF_ISPACKED=0x02, REF_ISBROKEN=0x04 and REF_BAD_NAME=0x08 are
+ * public values; see refs.h.
  */
 
 /*
@@ -196,16 +196,16 @@ struct ref_dir {
  * the correct peeled value for the reference, which might be
  * null_sha1 if the reference is not a tag or if it is broken.
  */
-#define REF_KNOWS_PEELED 0x08
+#define REF_KNOWS_PEELED 0x10
 
 /* ref_entry represents a directory of references */
-#define REF_DIR 0x10
+#define REF_DIR 0x20
 
 /*
  * Entry has not yet been read from disk (used only for REF_DIR
  * entries representing loose references)
  */
-#define REF_INCOMPLETE 0x20
+#define REF_INCOMPLETE 0x40
 
 /*
  * A ref_entry represents either a reference or a "subdirectory" of
@@ -274,6 +274,39 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	return dir;
 }
 
+/*
+ * Check if a refname is safe.
+ * For refs that start with "refs/" we consider it safe as long they do
+ * not try to resolve to outside of refs/.
+ *
+ * For all other refs we only consider them safe iff they only contain
+ * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
+ * "config").
+ */
+static int refname_is_safe(const char *refname)
+{
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
+	while (*refname) {
+		if (!isupper(*refname) && *refname != '_')
+			return 0;
+		refname++;
+	}
+	return 1;
+}
+
 static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag,
 					  int check_name)
@@ -284,6 +317,8 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	if (check_name &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
+	if (!check_name && !refname_is_safe(refname))
+		die("Reference has invalid name: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(ref->u.value.sha1, sha1);
@@ -1111,7 +1146,13 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			last = create_ref_entry(refname, sha1, REF_ISPACKED, 1);
+			int flag = REF_ISPACKED;
+
+			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+				hashclr(sha1);
+				flag |= REF_BAD_NAME | REF_ISBROKEN;
+			}
+			last = create_ref_entry(refname, sha1, flag, 0);
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
@@ -1249,8 +1290,13 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
+			if (check_refname_format(refname.buf,
+						 REFNAME_ALLOW_ONELEVEL)) {
+				hashclr(sha1);
+				flag |= REF_BAD_NAME | REF_ISBROKEN;
+			}
 			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, sha1, flag, 1));
+					 create_ref_entry(refname.buf, sha1, flag, 0));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
@@ -1369,10 +1415,10 @@ static struct ref_entry *get_packed_ref(const char *refname)
  * A loose ref file doesn't exist; check for a packed ref.  The
  * options are forwarded from resolve_safe_unsafe().
  */
-static const char *handle_missing_loose_ref(const char *refname,
-					    int resolve_flags,
-					    unsigned char *sha1,
-					    int *flags)
+static int resolve_missing_loose_ref(const char *refname,
+				     int resolve_flags,
+				     unsigned char *sha1,
+				     int *flags)
 {
 	struct ref_entry *entry;
 
@@ -1385,14 +1431,15 @@ static const char *handle_missing_loose_ref(const char *refname,
 		hashcpy(sha1, entry->u.value.sha1);
 		if (flags)
 			*flags |= REF_ISPACKED;
-		return refname;
+		return 0;
 	}
 	/* The reference is not a packed reference, either. */
 	if (resolve_flags & RESOLVE_REF_READING) {
-		return NULL;
+		errno = ENOENT;
+		return -1;
 	} else {
 		hashclr(sha1);
-		return refname;
+		return 0;
 	}
 }
 
@@ -1403,13 +1450,29 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 	ssize_t len;
 	char buffer[256];
 	static char refname_buffer[256];
+	int bad_name = 0;
 
 	if (flags)
 		*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		errno = EINVAL;
-		return NULL;
+		if (flags)
+			*flags |= REF_BAD_NAME;
+
+		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+		    !refname_is_safe(refname)) {
+			errno = EINVAL;
+			return NULL;
+		}
+		/*
+		 * dwim_ref() uses REF_ISBROKEN to distinguish between
+		 * missing refs and refs that were present but invalid,
+		 * to complain about the latter to stderr.
+		 *
+		 * We don't know whether the ref exists, so don't set
+		 * REF_ISBROKEN yet.
+		 */
+		bad_name = 1;
 	}
 	for (;;) {
 		char path[PATH_MAX];
@@ -1435,11 +1498,17 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 		 */
 	stat_ref:
 		if (lstat(path, &st) < 0) {
-			if (errno == ENOENT)
-				return handle_missing_loose_ref(refname,
-						resolve_flags, sha1, flags);
-			else
+			if (errno != ENOENT)
 				return NULL;
+			if (resolve_missing_loose_ref(refname, resolve_flags,
+						      sha1, flags))
+				return NULL;
+			if (bad_name) {
+				hashclr(sha1);
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			}
+			return refname;
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
@@ -1512,6 +1581,11 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 				errno = EINVAL;
 				return NULL;
 			}
+			if (bad_name) {
+				hashclr(sha1);
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			}
 			return refname;
 		}
 		if (flags)
@@ -1527,8 +1601,13 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flags)
 				*flags |= REF_ISBROKEN;
-			errno = EINVAL;
-			return NULL;
+
+			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+			    !refname_is_safe(buf)) {
+				errno = EINVAL;
+				return NULL;
+			}
+			bad_name = 1;
 		}
 	}
 }
@@ -2160,18 +2239,16 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		errno = EINVAL;
-		return NULL;
-	}
-
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
-	if (flags & REF_NODEREF && flags & REF_DELETING)
-		resolve_flags |= RESOLVE_REF_NO_RECURSE;
+	if (flags & REF_DELETING) {
+		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
+		if (flags & REF_NODEREF)
+			resolve_flags |= RESOLVE_REF_NO_RECURSE;
+	}
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
 				     lock->old_sha1, &type);
@@ -3519,6 +3596,13 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (!is_null_sha1(new_sha1) &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(err, "refusing to update ref with bad name %s",
+			    refname);
+		return -1;
+	}
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3544,6 +3628,12 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(err, "refusing to create ref with bad name %s",
+			    refname);
+		return -1;
+	}
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
diff --git a/refs.h b/refs.h
index c61b8f4..2bc3556 100644
--- a/refs.h
+++ b/refs.h
@@ -56,12 +56,20 @@ struct ref_transaction;
 
 /*
  * Reference cannot be resolved to an object name: dangling symbolic
- * reference (directly or indirectly), corrupt reference file, or
- * symbolic reference refers to ill-formatted reference name.
+ * reference (directly or indirectly), corrupt reference file,
+ * reference exists but name is bad, or symbolic reference refers to
+ * ill-formatted reference name.
  */
 #define REF_ISBROKEN 0x04
 
 /*
+ * Reference name is not well formed.
+ *
+ * See git-check-ref-format(1) for the definition of well formed ref names.
+ */
+#define REF_BAD_NAME 0x08
+
+/*
  * The signature for the callback function for the for_each_*()
  * functions below.  The memory pointed to by the refname and sha1
  * arguments is only guaranteed to be valid for the duration of a
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index c7b19b0..468e856 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -4,7 +4,8 @@ test_description='Test handling of ref names that check-ref-format rejects'
 . ./test-lib.sh
 
 test_expect_success setup '
-	test_commit one
+	test_commit one &&
+	test_commit two
 '
 
 test_expect_success 'fast-import: fail on invalid branch name ".badbranchname"' '
@@ -37,6 +38,107 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
 	test_must_fail git fast-import <input
 '
 
+test_expect_success 'git branch shows badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch >output &&
+	grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -d can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -d broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -D can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -D broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -D cannot delete non-ref in .git dir' '
+	echo precious >.git/my-private-file &&
+	echo precious >expect &&
+	test_must_fail git branch -D ../../my-private-file &&
+	test_cmp expect .git/my-private-file
+'
+
+test_expect_success 'branch -D cannot delete absolute path' '
+	git branch -f extra &&
+	test_must_fail git branch -D "$(pwd)/.git/refs/heads/extra" &&
+	test_cmp_rev HEAD extra
+'
+
+test_expect_success 'git branch cannot create a badly named ref' '
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_must_fail git branch broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -m cannot rename to a bad ref name' '
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_might_fail git branch -D goodref &&
+	git branch goodref &&
+	test_must_fail git branch -m goodref broken...ref &&
+	test_cmp_rev master goodref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_failure 'branch -m can rename from a bad ref name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -m broken...ref renamed &&
+	test_cmp_rev master renamed &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'push cannot create a badly named ref' '
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_must_fail git push "file://$(pwd)" HEAD:refs/heads/broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_failure 'push --mirror can delete badly named ref' '
+	top=$(pwd) &&
+	git init src &&
+	git init dest &&
+
+	(
+		cd src &&
+		test_commit one
+	) &&
+	(
+		cd dest &&
+		test_commit two &&
+		git checkout --detach &&
+		cp .git/refs/heads/master .git/refs/heads/broken...ref
+	) &&
+	git -C src push --mirror "file://$top/dest" &&
+	git -C dest branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'rev-parse skips symref pointing to broken name' '
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch shadow one &&
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	git symbolic-ref refs/tags/shadow refs/heads/broken...ref &&
+
+	git rev-parse --verify one >expect &&
+	git rev-parse --verify shadow >actual 2>err &&
+	test_cmp expect actual &&
+	test_i18ngrep "ignoring.*refs/tags/shadow" err
+'
+
 test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
 	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
@@ -45,6 +147,27 @@ test_expect_success 'update-ref --no-deref -d can delete reference to broken nam
 	test_path_is_missing .git/refs/heads/badname
 '
 
+test_expect_success 'update-ref -d can delete broken name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git update-ref -d refs/heads/broken...ref &&
+	git branch >output &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
+	echo precious >.git/my-private-file &&
+	echo precious >expect &&
+	test_must_fail git update-ref -d my-private-file &&
+	test_cmp expect .git/my-private-file
+'
+
+test_expect_success 'update-ref -d cannot delete absolute path' '
+	git branch -f extra &&
+	test_must_fail git update-ref -d "$(pwd)/.git/refs/heads/extra" &&
+	test_cmp_rev HEAD extra
+'
+
 test_expect_success 'update-ref --stdin fails create with bad ref name' '
 	echo "create ~a refs/heads/master" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-- 
2.1.0.rc2.206.gedb03e5
