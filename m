From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 33/33] lock_ref_sha1_basic(): only handle REF_NODEREF mode
Date: Fri,  6 May 2016 18:14:14 +0200
Message-ID: <1b71052522155c73624dde29ddf1d613b56ff5fa.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:22:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiWg-0005yJ-No
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758232AbcEFQWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:22:47 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55626 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758140AbcEFQWq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:22:46 -0400
X-AuditID: 1207440e-ef3ff700000008c5-c7-572cc3177ba5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C0.1E.02245.713CC275; Fri,  6 May 2016 12:15:19 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHVF031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:18 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqCt+WCfc4P0dY4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd0b3p42sBT+NKjZv2sjSwPhWo4uRk0NCwESiZ9pf
	5i5GLg4hga2MEud29TFBOMeZJFqudjGDVLEJ6Eos6mlmArFFBCIkGl61MHYxcnAwC3xmlFjJ
	DRIWFvCV2LzuO1gJi4CqxLLXc1hBbF6BKIkDdzayQiyTk7g8/QEbiM0pYCFxqPc4WL2QgLlE
	x9ob7BMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECAkwvh2M7etl
	DjEKcDAq8fBmnNQOF2JNLCuuzD3EKMnBpCTK+71AJ1yILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CO+VfUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE76GDQI2CRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoAiILwbGAEiKB2gv3yGQvcUFiblAUYjWU4y6
	HEf231vLJMSSl5+XKiXOOxdkhwBIUUZpHtwKWDp5xSgO9LEw72WQKh5gKoKb9ApoCRPQkvdz
	NUGWlCQipKQaGPMWbO3cevUW65Hi6+8+fN2Wk7hTXTxH0uUYw4zfX7kEEmqdGp4W3Iz5nGOp
	FOzz7PNH4VNdLT/e7Wozrci/FRdjbDDhLnPuBH7W2LqEOa7nVx/38D5g6vxmIc+b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293829>

Now lock_ref_sha1_basic() is only called with flags==REF_NODEREF. So we
don't have to handle other cases anymore.

This enables several simplifications, the most interesting of which come
from the fact that ref_lock::orig_ref_name is now always the same as
ref_lock::ref_name:

* Remove ref_lock::orig_ref_name
* Remove local variable orig_refname from lock_ref_sha1_basic()
* ref_name can be initialize once and its value reused
* commit_ref_update() never has to write to the reflog for
  lock->orig_ref_name

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 54 +++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a180b9e..71e068b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -7,7 +7,6 @@
 
 struct ref_lock {
 	char *ref_name;
-	char *orig_ref_name;
 	struct lock_file *lk;
 	struct object_id old_oid;
 };
@@ -1522,7 +1521,6 @@ static void unlock_ref(struct ref_lock *lock)
 	if (lock->lk)
 		rollback_lock_file(lock->lk);
 	free(lock->ref_name);
-	free(lock->orig_ref_name);
 	free(lock);
 }
 
@@ -1576,7 +1574,6 @@ static int lock_raw_ref(const char *refname, int mustexist,
 	*lock_p = lock = xcalloc(1, sizeof(*lock));
 
 	lock->ref_name = xstrdup(refname);
-	lock->orig_ref_name = xstrdup(refname);
 	strbuf_git_path(&ref_file, "%s", refname);
 
 retry:
@@ -1964,14 +1961,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
-	struct strbuf orig_ref_file = STRBUF_INIT;
-	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int lflags = 0;
+	int lflags = LOCK_NO_DEREF;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
-	int resolve_flags = 0;
+	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int attempts_remaining = 3;
+	int resolved;
 
 	assert(err);
 
@@ -1981,46 +1977,39 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		resolve_flags |= RESOLVE_REF_READING;
 	if (flags & REF_DELETING)
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
-	if (flags & REF_NODEREF) {
-		resolve_flags |= RESOLVE_REF_NO_RECURSE;
-		lflags |= LOCK_NO_DEREF;
-	}
 
-	refname = resolve_ref_unsafe(refname, resolve_flags,
-				     lock->old_oid.hash, type);
-	if (!refname && errno == EISDIR) {
+	strbuf_git_path(&ref_file, "%s", refname);
+	resolved = !!resolve_ref_unsafe(refname, resolve_flags,
+					lock->old_oid.hash, type);
+	if (!resolved && errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
 		 * it is normal for the empty directory 'foo'
 		 * to remain.
 		 */
-		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
-		if (remove_empty_directories(&orig_ref_file)) {
+		if (remove_empty_directories(&ref_file)) {
 			last_errno = errno;
-			if (!verify_refname_available_dir(orig_refname, extras, skip,
+			if (!verify_refname_available_dir(refname, extras, skip,
 							  get_loose_refs(&ref_cache), err))
 				strbuf_addf(err, "there are still refs under '%s'",
-					    orig_refname);
+					    refname);
 			goto error_return;
 		}
-		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
-					     lock->old_oid.hash, type);
+		resolved = !!resolve_ref_unsafe(refname, resolve_flags,
+						lock->old_oid.hash, type);
 	}
-	if (!refname) {
+	if (!resolved) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-		    !verify_refname_available_dir(orig_refname, extras, skip,
+		    !verify_refname_available_dir(refname, extras, skip,
 						  get_loose_refs(&ref_cache), err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    orig_refname, strerror(last_errno));
+				    refname, strerror(last_errno));
 
 		goto error_return;
 	}
 
-	if (flags & REF_NODEREF)
-		refname = orig_refname;
-
 	/*
 	 * If the ref did not exist and we are creating it, make sure
 	 * there is no existing packed ref whose name begins with our
@@ -2037,8 +2026,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
 	lock->ref_name = xstrdup(refname);
-	lock->orig_ref_name = xstrdup(orig_refname);
-	strbuf_git_path(&ref_file, "%s", refname);
 
  retry:
 	switch (safe_create_leading_directories_const(ref_file.buf)) {
@@ -2081,7 +2068,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
  out:
 	strbuf_release(&ref_file);
-	strbuf_release(&orig_ref_file);
 	errno = last_errno;
 	return lock;
 }
@@ -2878,9 +2864,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			     struct strbuf *err)
 {
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err) < 0 ||
-	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, 0, err) < 0)) {
+	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -2888,7 +2872,8 @@ static int commit_ref_update(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+
+	if (strcmp(lock->ref_name, "HEAD") != 0) {
 		/*
 		 * Special hack: If a branch is updated directly and HEAD
 		 * points to it (may happen on the remote side of a push
@@ -2904,6 +2889,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		unsigned char head_sha1[20];
 		int head_flag;
 		const char *head_ref;
+
 		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
@@ -2916,6 +2902,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
+
 	if (commit_ref(lock)) {
 		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 		unlock_ref(lock);
@@ -3021,7 +3008,6 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lk = &head_lock;
 	lock->ref_name = xstrdup(head_rel);
-	lock->orig_ref_name = xstrdup(head_rel);
 
 	ret = create_symref_locked(lock, head_rel, target, NULL);
 
-- 
2.8.1
