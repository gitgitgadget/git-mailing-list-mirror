From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/24] refs.c: allow listing and deleting badly named refs
Date: Wed, 1 Oct 2014 19:28:19 -0700
Message-ID: <20141002022819.GL1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:28:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZW86-00018V-F4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbaJBC2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:28:23 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56948 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbaJBC2X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:28:23 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so1233042pdb.25
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zBVr7gq2Mw/A5f+5MmHckdC8FF45M05ho/rgLCtizQY=;
        b=zgCp5OPRm2gHH4GfOsWsuw4VWzU2aFbUhJoGlSS/LZiQmmEXRzZeqw51O3p6kE7Fwf
         6k2lKG1HBl50BYTHEAoQ8dHGhh9+D1Tk7xHpyYwlvZH/V3cqhN+n06/bhE8Y4SrMn/bh
         xQcJERQDNp9BpDJfMG0QmgS4FITSYLEGhv/LnV/Q2a6a1c8UCZCRyEh3nyOJYTC5gtfu
         zgZFc0nsvQbjflJsnfakj8FK1ZJ3y3A8GwkZkJE1GhyeCZ+oUk7xTUjMqtg3i4BzxVrC
         O6zrQqPN3DY5e0gcjXGZaA7rPn6+UT/TL0M7kC8Eh1BptyN5XVfmrouexDf+0OZZa1pV
         TH0g==
X-Received: by 10.67.15.137 with SMTP id fo9mr29233788pad.113.1412216902548;
        Wed, 01 Oct 2014 19:28:22 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id p1sm2091210pds.80.2014.10.01.19.28.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:28:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257790>

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

So allow "git branch --list" to show these refs and to allow "git
branch -d/-D" and "git update-ref -d" to delete them.  Other commands
(for example to rename refs) will continue to not handle these refs
but can be changed in later patches.

Details:

In resolving functions, refuse to resolve refs that don't pass the
check-ref-format(1) check unless the new RESOLVE_REF_ALLOW_BAD_NAME
flag is passed.  Even with RESOLVE_REF_ALLOW_BAD_NAME, refuse to
resolve refs that escape the refs/ directory and do not match the
pattern [A-Z_]* (think "HEAD" and "MERGE_HEAD").

In locking functions, refuse to act on badly named refs unless they
are being deleted and either are in the refs/ directory or match [A-Z_]*.

Just like other invalid refs, flag resolved, badly named refs with the
REF_ISBROKEN flag, treat them as resolving to null_sha1, and skip them
in all iteration functions except for for_each_rawref.

Flag badly named refs with a REF_BAD_NAME flag to make it easier for
future callers to notice and handle them specially.

In the transaction API, refuse to create or update badly named refs,
but allow deleting them (unless they escape refs/ and don't match
[A-Z_]*).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since v21:
- clarified change description
- handle REF_ISBROKEN case too when printing "Deleted branch" message
- tighten fallback check, so commands like 'git branch -d ../../config'
  won't work
- use REF_BAD_NAME so it's easier for callers (like for-each-ref in a
  later patch) to notice that we decided a ref's name was bad
- set errno when failing to find ref in the packed-refs file
- consistently don't set REF_ISBROKEN for missing refs
- consistently clear sha1 when successfully resolving a badly named ref
- treat refs with bad names encountered as part of symref resolution the
  same as such refs explicitly named
- always allow safe bad names when trying to lock a ref for deletion
  (though some callers don't get that far yet)
- clearer API docs, more tests

 builtin/branch.c        |   9 +--
 cache.h                 |  14 ++++-
 refs.c                  | 148 ++++++++++++++++++++++++++++++++++++++----------
 refs.h                  |   8 ++-
 t/t1430-bad-ref-name.sh | 125 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 265 insertions(+), 39 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a0c5601..94aaea1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -236,7 +236,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		name = mkpathdup(fmt, bname.buf);
 		target = resolve_ref_unsafe(name,
 					    RESOLVE_REF_READING
-					    | RESOLVE_REF_NO_RECURSE,
+					    | RESOLVE_REF_NO_RECURSE
+					    | RESOLVE_REF_ALLOW_BAD_NAME,
 					    sha1, &flags);
 		if (!target) {
 			error(remote_branch
@@ -246,7 +247,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & REF_ISSYMREF) &&
+		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
 					force)) {
 			ret = 1;
@@ -266,8 +267,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
index 5ca7f2b..0c0ac60 100644
--- a/cache.h
+++ b/cache.h
@@ -978,16 +978,26 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * If flags is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
  * packed references), REF_ISSYMREF (if the initial reference was a
- * symbolic reference) and REF_ISBROKEN (if the ref is malformed).
+ * symbolic reference), REF_BAD_NAME (if the reference name is ill
+ * formed --- see RESOLVE_REF_ALLOW_BAD_NAME below), and REF_ISBROKEN
+ * (if the ref is malformed).
  *
  * If ref is not a properly-formatted, normalized reference, return
  * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
  * give up and return NULL.
  *
- * errno is set to something meaningful on error.
+ * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
+ * name is invalid according to git-check-ref-format(1).  If the name
+ * is bad then the value stored in sha1 will be null_sha1 and the
+ * REF_ISBROKEN and REF_BAD_NAME flags will be set.
+ *
+ * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
+ * directory and do not consist of all caps and underscores cannot be
+ * resolved.  The function returns NULL for such ref names.
  */
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
+#define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 extern const char *resolve_ref_unsafe(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 extern char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 
diff --git a/refs.c b/refs.c
index 94d6d89..0d3abb1 100644
--- a/refs.c
+++ b/refs.c
@@ -185,8 +185,8 @@ struct ref_dir {
 
 /*
  * Bit values for ref_entry::flag.  REF_ISSYMREF=0x01,
- * REF_ISPACKED=0x02, and REF_ISBROKEN=0x04 are public values; see
- * refs.h.
+ * REF_ISPACKED=0x02, REF_ISBROKEN=0x04 and REF_BAD_NAME=0x08 are
+ * public values; see refs.h.
  */
 
 /*
@@ -194,16 +194,16 @@ struct ref_dir {
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
@@ -272,6 +272,37 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	return dir;
 }
 
+static int escapes_cwd(const char *path) {
+	char *buf;
+	int result;
+
+	if (is_absolute_path(path))
+		return 1;
+	buf = xmalloc(strlen(path) + 1);
+	result = !!normalize_path_copy(buf, path);
+	free(buf);
+	return result;
+}
+
+/*
+ * Check if a refname is safe.
+ * For refs that start with "refs/" we consider it safe as long as the rest
+ * of the path components does not allow it to escape from this directory.
+ * For all other refs we only consider them safe iff they only contain
+ * upper case characters and '_'.
+ */
+static int refname_is_safe(const char *refname)
+{
+	if (starts_with(refname, "refs/"))
+		return !escapes_cwd(refname + strlen("refs/"));
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
@@ -282,6 +313,8 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	if (check_name &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
+	if (!check_name && !refname_is_safe(refname))
+		die("Reference has invalid name: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(ref->u.value.sha1, sha1);
@@ -1051,7 +1084,13 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
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
@@ -1189,8 +1228,13 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
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
@@ -1309,10 +1353,10 @@ static struct ref_entry *get_packed_ref(const char *refname)
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
 
@@ -1325,14 +1369,15 @@ static const char *handle_missing_loose_ref(const char *refname,
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
 
@@ -1343,13 +1388,29 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
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
@@ -1375,11 +1436,17 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
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
@@ -1452,6 +1519,11 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
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
@@ -1466,9 +1538,14 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 		}
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flags)
-				*flags |= REF_ISBROKEN;
-			errno = EINVAL;
-			return NULL;
+				*flags |= REF_BAD_NAME | REF_ISBROKEN;
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
@@ -2101,18 +2178,16 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -3465,6 +3540,13 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
@@ -3490,6 +3572,12 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index e48d8b9..3b35387 100644
--- a/refs.h
+++ b/refs.h
@@ -56,11 +56,15 @@ struct ref_transaction;
 
 /*
  * Reference cannot be resolved to an object name: dangling symbolic
- * reference (directly or indirectly), corrupt reference file, or
- * symbolic reference refers to ill-formatted reference name.
+ * reference (directly or indirectly), corrupt reference file,
+ * reference exists but name is bad, or symbolic reference refers to
+ * ill-formatted reference name.
  */
 #define REF_ISBROKEN 0x04
 
+/* Reference name is not well formed (see git-check-ref-format(1)). */
+#define REF_BAD_NAME 0x08
+
 /*
  * The signature for the callback function for the for_each_*()
  * functions below.  The memory pointed to by the refname and sha1
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
