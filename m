From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/24] branch -d: avoid repeated symref resolution
Date: Wed, 1 Oct 2014 19:15:10 -0700
Message-ID: <20141002021510.GH1175@google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 02 04:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVvM-00041T-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbaJBCPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:15:14 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38477 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaJBCPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:15:13 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so1363910pab.32
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VryjpdHSvv2DHQWO2M5livBiMWRMUl904ciUeIywQAU=;
        b=E0AK8AhPwtCvc1MLra2ivX6FxjU4ycKSarCcKtVFSQecibAo4BxecxmAZexQm2n9FS
         p/HWBSSmoLnD1iN2eDYm8rOerd2vNN2cUau2UYtpHmfBfAbOYN4AQMjJxwZAp6CbgVbO
         x0DSGn9l4Ni75VKkjm0gTQXxSERGj9beCkKFh4A8VgcCL+ykyAXNaT4m7OtKP1fjVceC
         jF5NbQzn1TAIolpSCxUwHUgx9NttK+YqRLCKKKKYk/KDMcwiGpk15QeP9JgU+GQbBMhv
         mRJb20QBvjEl7UPe5QCXf3SU+hC9AhX6cNRbbEvj22tFHyVTu62L/UNN9/8f42l098T2
         Ph8Q==
X-Received: by 10.66.151.196 with SMTP id us4mr80360024pab.78.1412216112920;
        Wed, 01 Oct 2014 19:15:12 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id y5sm2179850pdl.6.2014.10.01.19.15.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:15:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257786>

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Wed, 10 Sep 2014 18:22:48 -0700

If a repository gets in a broken state with too much symref nesting,
it cannot be repaired with "git branch -d":

 $ git symbolic-ref refs/heads/nonsense refs/heads/nonsense
 $ git branch -d nonsense
 error: branch 'nonsense' not found.

Worse, "git update-ref --no-deref -d" doesn't work for such repairs
either:

 $ git update-ref -d refs/heads/nonsense
 error: unable to resolve reference refs/heads/nonsense: Too many levels of symbolic links

Fix both by teaching resolve_ref_unsafe a new RESOLVE_REF_NO_RECURSE
flag and passing it when appropriate.

Callers can still read the value of a symref (for example to print a
message about it) with that flag set --- resolve_ref_unsafe will
resolve one level of symrefs and stop there.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
Since v21:
- renamed flag from RESOLVE_REF_NO_DEREF to _NO_RECURSE
- more detail in API docs
- only set NO_RECURSE when deleting refs.  Locking refs for non-deletion
  updates needs to recurse to get old_sha1 for the reflog.
- add more tests (for symrefs to refs with bad names, which should also
  be deletable now)

 builtin/branch.c      |  3 ++-
 cache.h               |  6 ++++++
 refs.c                | 17 +++++++++++++++--
 refs.h                |  2 ++
 t/t1400-update-ref.sh | 34 ++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh     |  9 +++++++++
 6 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e5d1377..a334380 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -234,7 +234,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		target = resolve_ref_unsafe(name, 0, sha1, &flags);
+		target = resolve_ref_unsafe(name, RESOLVE_REF_NO_RECURSE,
+					    sha1, &flags);
 		if (!target ||
 		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
 			error(remote_branch
diff --git a/cache.h b/cache.h
index 5b54911..5ca7f2b 100644
--- a/cache.h
+++ b/cache.h
@@ -970,6 +970,11 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  *   "writing" to the ref, the return value is the name of the ref
  *   that will actually be created or changed.
  *
+ * If the RESOLVE_REF_NO_RECURSE flag is passed, only resolves one
+ * level of symbolic reference.  The value stored in sha1 for a symbolic
+ * reference will always be null_sha1 in this case, and the return
+ * value is the reference that the symref refers to directly.
+ *
  * If flags is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
  * packed references), REF_ISSYMREF (if the initial reference was a
@@ -982,6 +987,7 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * errno is set to something meaningful on error.
  */
 #define RESOLVE_REF_READING 0x01
+#define RESOLVE_REF_NO_RECURSE 0x02
 extern const char *resolve_ref_unsafe(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 extern char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 
diff --git a/refs.c b/refs.c
index 4916d16..490e788 100644
--- a/refs.c
+++ b/refs.c
@@ -1407,6 +1407,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 				refname = refname_buffer;
 				if (flags)
 					*flags |= REF_ISSYMREF;
+				if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
+					hashclr(sha1);
+					return refname;
+				}
 				continue;
 			}
 		}
@@ -1463,13 +1467,17 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 		buf = buffer + 4;
 		while (isspace(*buf))
 			buf++;
+		refname = strcpy(refname_buffer, buf);
+		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
+			hashclr(sha1);
+			return refname;
+		}
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 			if (flags)
 				*flags |= REF_ISBROKEN;
 			errno = EINVAL;
 			return NULL;
 		}
-		refname = strcpy(refname_buffer, buf);
 	}
 }
 
@@ -2111,6 +2119,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
+	if (flags & REF_NODEREF && flags & REF_DELETING)
+		resolve_flags |= RESOLVE_REF_NO_RECURSE;
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
 				     lock->old_sha1, &type);
@@ -3610,13 +3620,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
+		int flags = update->flags;
 
+		if (is_null_sha1(update->new_sha1))
+			flags |= REF_DELETING;
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
 						   NULL,
-						   update->flags,
+						   flags,
 						   &update->type);
 		if (!update->lock) {
 			ret = (errno == ENOTDIR)
diff --git a/refs.h b/refs.h
index 3bb16db..b62c4c4 100644
--- a/refs.h
+++ b/refs.h
@@ -175,10 +175,12 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
+ * REF_DELETING: tolerate broken refs
  *
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REF_NODEREF	0x01
+#define REF_DELETING	0x02
 /*
  * This function sets errno to something meaningful on failure.
  */
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 0218e96..7c8c41a 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -110,6 +110,40 @@ test_expect_success "delete symref without dereference when the referred ref is
 cp -f .git/HEAD.orig .git/HEAD
 git update-ref -d $m
 
+test_expect_success 'update-ref -d is not confused by self-reference' '
+	git symbolic-ref refs/heads/self refs/heads/self &&
+	test_when_finished "rm -f .git/refs/heads/self" &&
+	test_path_is_file .git/refs/heads/self &&
+	test_must_fail git update-ref -d refs/heads/self &&
+	test_path_is_file .git/refs/heads/self
+'
+
+test_expect_success 'update-ref --no-deref -d can delete self-reference' '
+	git symbolic-ref refs/heads/self refs/heads/self &&
+	test_when_finished "rm -f .git/refs/heads/self" &&
+	test_path_is_file .git/refs/heads/self &&
+	git update-ref --no-deref -d refs/heads/self &&
+	test_path_is_missing .git/refs/heads/self
+'
+
+test_expect_success 'update-ref --no-deref -d can delete reference to bad ref' '
+	>.git/refs/heads/bad &&
+	test_when_finished "rm -f .git/refs/heads/bad" &&
+	git symbolic-ref refs/heads/ref-to-bad refs/heads/bad &&
+	test_when_finished "rm -f .git/refs/heads/ref-to-bad" &&
+	test_path_is_file .git/refs/heads/ref-to-bad &&
+	git update-ref --no-deref -d refs/heads/ref-to-bad &&
+	test_path_is_missing .git/refs/heads/ref-to-bad
+'
+
+test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
+	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_path_is_file .git/refs/heads/badname &&
+	git update-ref --no-deref -d refs/heads/badname &&
+	test_path_is_missing .git/refs/heads/badname
+'
+
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ac31b71..432921b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -285,6 +285,15 @@ test_expect_success 'deleting a dangling symref' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'deleting a self-referential symref' '
+	git symbolic-ref refs/heads/self-reference refs/heads/self-reference &&
+	test_path_is_file .git/refs/heads/self-reference &&
+	echo "Deleted branch self-reference (was refs/heads/self-reference)." >expect &&
+	git branch -d self-reference >actual &&
+	test_path_is_missing .git/refs/heads/self-reference &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
-- 
2.1.0.rc2.206.gedb03e5
