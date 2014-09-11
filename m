From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/19] refs.c: fix handling of badly named refs
Date: Wed, 10 Sep 2014 20:10:38 -0700
Message-ID: <20140911031038.GS18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:11:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRunK-0003ZP-V0
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbaIKDL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:11:29 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34316 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbaIKDKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:10:41 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so7520551pde.12
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KjdLUzCxHmKicm7EuS1iD42n3rbtRpsUQ3Qbct3NxSc=;
        b=XYPNJAYC2aEJpyW4ZvxqBR/tYffUkCrGXd8ZslP7KnHi/9mgmU19MWF/rb7KtxhZ0J
         mKNP8Aq3h4WCBQPVwS/M4q7T5Ql76I+3MBuLMYFXqnbL/TmghajfERoqfrychcV9EtjX
         XVFPI4cNkIK2YUDqSIvEkMMbvkafIWokzs5NKI69buJf3KuvE0qUNVfAZmfnBcQqo2ve
         brcjQJWdMSITInrzzARwR3VS3suuWQVWFH9p2ns45Ozf9X62B2/oTbvLiuE18Lm9SPb6
         Ii1UomPiZVtfpGf9sh91igU07a1/FJLrAIMd68Kb86kMG6wB+wgNRFrZs7To4Y90uSxc
         n2tg==
X-Received: by 10.67.3.106 with SMTP id bv10mr16970996pad.13.1410405041219;
        Wed, 10 Sep 2014 20:10:41 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id w11sm5859937pbt.84.2014.09.10.20.10.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:10:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256827>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 3 Sep 2014 11:45:43 -0700

We currently do not handle badly named refs well:

  $ cp .git/refs/heads/master .git/refs/heads/master.....@\*@\\.
  $ git branch
    fatal: Reference has invalid format: 'refs/heads/master.....@*@\.'
  $ git branch -D master.....@\*@\\.
    error: branch 'master.....@*@\.' not found.

Currently we can not really recover from a badly named ref with less than
manually deleting the .git/refs/heads/<refname> file. This will also help
if change the naming rules in the future. For example if we decide to remove
`, " and such from the set of valid characters.

The purpose of this change is to allow git branch --list to show these refs
and to allow git branch -d/-D and update-ref -d to delete them.
Other functions will continue to not handle these refs but can be changed in
later patches.

Introduce two new internal flags: RESOLVE_REF_ALLOW_BAD_NAME and REF_BADNAMEOK.

In resolving functions, refuse to resolve badly named refs unless the new
RESOLVE_REF_ALLOW_BAD_NAME flag is passed. For these cases, if the badly named
ref exists then flag it as REF_ISBROKEN and resolve it to nullsha1.

In locking functions, refuse to act on badly named refs unless the new
REF_BADNAMEOK flag is passed. This is currently used only from branch.c and
update-ref.c when deleting a ref.

Change the internal functions that read loose and packed refs to allow
badly named refs but flag them as REF_ISBROKEN just like unresolvable refs
are.

During ref iteration only include these refs during for_each_rawref but
none of the other iterators. I.e. just like unresolvable refs, flag
inclusion of these refs based on DO_FOR_EACH_INCLUDE_BROKEN during
iteration.

In the transaction API, always refuse to create or update badly named refs
and refuse to delete them unless REF_BADNAMEOK flag is passed.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/branch.c            | 13 ++++++----
 builtin/update-ref.c        |  3 ++-
 cache.h                     |  8 +++++-
 refs.c                      | 63 ++++++++++++++++++++++++++++++++++++++-------
 refs.h                      |  2 ++
 t/t1402-check-ref-format.sh | 48 ++++++++++++++++++++++++++++++++++
 6 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7925660..5d5bc56 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -234,10 +234,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		target = resolve_ref_unsafe(name, sha1,
-					    &flags, RESOLVE_REF_NODEREF);
+		target = resolve_ref_unsafe(name, sha1, &flags,
+					    RESOLVE_REF_READING
+					    | RESOLVE_REF_NODEREF
+					    | RESOLVE_REF_ALLOW_BAD_NAME);
 		if (!target ||
-		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
+		    (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		     is_null_sha1(sha1))) {
 			error(remote_branch
 			      ? _("remote branch '%s' not found.")
 			      : _("branch '%s' not found."), bname.buf);
@@ -245,14 +248,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & REF_ISSYMREF) &&
+		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
 					force)) {
 			ret = 1;
 			continue;
 		}
 
-		if (delete_ref(name, sha1, REF_NODEREF)) {
+		if (delete_ref(name, sha1, REF_NODEREF|REF_BADNAMEOK)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6c9be05..e379fdd 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -419,7 +419,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (no_deref)
 		flags = REF_NODEREF;
 	if (delete)
-		return delete_ref(refname, oldval ? oldsha1 : NULL, flags);
+		return delete_ref(refname, oldval ? oldsha1 : NULL,
+				  flags|REF_BADNAMEOK);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
 				  flags, UPDATE_REFS_DIE_ON_ERR);
diff --git a/cache.h b/cache.h
index 03ade12..03a6144 100644
--- a/cache.h
+++ b/cache.h
@@ -979,10 +979,16 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
  * give up and return NULL.
  *
- * errno is set to something meaningful on error.
+ * RESOLVE_REF_ALLOW_BAD_NAME disables most of the ref name checking except
+ * for names that are absolute paths or contain ".." components. For both
+ * these cases the function will return NULL and set errno to EINVAL.
+ * If the name is bad then the function will set the REF_ISBROKEN flag and
+ * return the name, if the ref exists, or NULL, if it does not.
+ * When this flag is set, any badly named refs will resolve to nullsha1.
  */
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NODEREF 0x02
+#define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int *flags, int resolve_flags);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int *flags, int resolve_flags);
 
diff --git a/refs.c b/refs.c
index f11df33..6faf0c8 100644
--- a/refs.c
+++ b/refs.c
@@ -1060,7 +1060,13 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			last = create_ref_entry(refname, sha1, REF_ISPACKED, 1);
+			int flag = REF_ISPACKED;
+
+			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT)) {
+				flag |= REF_ISBROKEN;
+				hashclr(sha1);
+			}
+			last = create_ref_entry(refname, sha1, flag, 0);
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
@@ -1197,8 +1203,14 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
+			if (check_refname_format(refname.buf,
+						 REFNAME_ALLOW_ONELEVEL|
+						 REFNAME_DOT_COMPONENT)) {
+				hashclr(sha1);
+				flag |= REF_ISBROKEN;
+			}
 			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, sha1, flag, 1));
+					 create_ref_entry(refname.buf, sha1, flag, 0));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
@@ -1344,6 +1356,18 @@ static const char *handle_missing_loose_ref(const char *refname,
 	}
 }
 
+static int escapes_cwd(const char *path) {
+	char *buf;
+	int result;
+
+	if (is_absolute_path(path))
+		return 1;
+	buf = xmalloc(strlen(path) + 1);
+	result = normalize_path_copy(buf, path);
+	free(buf);
+	return result;
+}
+
 /* This function needs to return a meaningful errno on failure */
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *flags, int resolve_flags)
 {
@@ -1351,13 +1375,21 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 	ssize_t len;
 	char buffer[256];
 	static char refname_buffer[256];
+	int bad_name = 0;
 
 	if (flags)
 		*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		errno = EINVAL;
-		return NULL;
+		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+		    escapes_cwd(refname)) {
+			errno = EINVAL;
+			return NULL;
+		}
+		hashclr(sha1);
+		if (flags)
+			*flags |= REF_ISBROKEN;
+		bad_name = 1;
 	}
 	for (;;) {
 		char path[PATH_MAX];
@@ -1461,6 +1493,8 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *fl
 				errno = EINVAL;
 				return NULL;
 			}
+			if (bad_name)
+				hashclr(sha1);
 			return refname;
 		}
 		if (flags)
@@ -2108,14 +2142,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		errno = EINVAL;
-		return NULL;
-	}
-
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
+	if (flags & REF_BADNAMEOK)
+		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
+
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
 	if (flags & REF_NODEREF)
@@ -3472,6 +3504,13 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
@@ -3497,6 +3536,12 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index fafa493..a96e174 100644
--- a/refs.h
+++ b/refs.h
@@ -175,10 +175,12 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
+ * REF_BADNAMEOK: allow locking a ref that has a bad name.
  *
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REF_NODEREF	0x01
+#define REF_BADNAMEOK	0x02
 /*
  * This function sets errno to something meaningful on failure.
  */
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 1a5a5f3..058fa37 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -196,4 +196,52 @@ invalid_ref_normalized 'heads///foo.lock'
 invalid_ref_normalized 'foo.lock/bar'
 invalid_ref_normalized 'foo.lock///bar'
 
+test_expect_success 'git branch shows badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch >output &&
+	grep -e "broken...ref" output
+'
+
+test_expect_success 'git branch -d can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -d broken...ref &&
+	git branch >output &&
+	! grep -e "broken...ref" output
+'
+
+test_expect_success 'git branch -D can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -D broken...ref &&
+	git branch >output &&
+	! grep -e "broken...ref" output
+'
+
+test_expect_success 'git update-ref -d can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git update-ref -d refs/heads/broken...ref &&
+	git branch >output &&
+	! grep -e "broken...ref" output
+'
+
+test_expect_success 'git branch can not create a badly named ref' '
+	test_must_fail git branch broken...ref
+'
+
+test_expect_success 'git branch can not rename to a bad ref name' '
+	git branch goodref &&
+	test_must_fail git branch -m goodref broken...ref
+'
+
+test_expect_failure 'git branch can rename from a bad ref name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -m broken...ref renamed &&
+	test_must_fail git rev-parse broken...ref &&
+	test_cmp_rev master renamed
+'
+
 test_done
-- 
2.1.0.rc2.206.gedb03e5
