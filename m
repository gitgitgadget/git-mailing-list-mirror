From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 29/29] lock_ref_sha1_basic(): only handle REF_NODEREF mode
Date: Wed, 27 Apr 2016 18:57:46 +0200
Message-ID: <a3d853510719a37c1e4bbb52261169c25b19c148.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSo1-00040G-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbcD0Q64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:56 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43127 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753228AbcD0Q6x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:53 -0400
X-AuditID: 1207440d-bb3ff7000000090b-ae-5720efccef1b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 23.9E.02315.CCFE0275; Wed, 27 Apr 2016 12:58:52 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6g022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:51 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqHvmvUK4wY3dBhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oy3Z0oLVhlVfNlzmrGBcYVGFyMnh4SAicTeZ2+Y
	uxi5OIQEtjJKbDrVwQrhHGeSuN53lwmkik1AV2JRTzOYLSLgILF85S92kCJmgSYmie/Lm1hA
	EsICXhIn3nWAFbEIqEoc+f2BGcTmFYiSOD/xISvEOjmJy9MfsIHYnAIWEl9a3zKC2EIC5hJL
	Hqxmn8DIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSIjx7mD8v07m
	EKMAB6MSD2+BhEK4EGtiWXFl7iFGSQ4mJVHeJWeBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	p78ByvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHjN3gE1ChalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxINiIL4YGAUgKR6gvX/eguwtLkjMBYpCtJ5iVJQS
	53UFSQiAJDJK8+DGwhLHK0ZxoC+FeYNAtvMAkw5c9yugwUxAgy8fkgUZXJKIkJJqYNRyXh6w
	J2rjs/6Z9dJ3d4hlF80643xek8c9h3uC03mXhAVTKl/80I3q+vC7uq52Y4Jow78maU4BLtOb
	D5ccu83Bbdw259LCSM/pix6/uzRpHffUyhvfW5WXX09uKru/3Fjy18+D/duXObt5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292761>

Now lock_ref_sha1_basic() is only called with flags==REF_NODEREF. So we
don't have to handle other cases anymore.

This enables several simplifications, the most interesting of which come
from the fact that ref_lock::orig_ref_name is now always the same as
ref_lock::ref_name:

* Remove ref_lock::orig_ref_name
* Remove local variable orig_refname from lock_ref_sha1_basic()
* commit_ref_update() never has to write to the reflog for
  lock->orig_ref_name

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 54 ++++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 938871b..5dca352 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -7,7 +7,6 @@
 
 struct ref_lock {
 	char *ref_name;
-	char *orig_ref_name;
 	struct lock_file *lk;
 	struct object_id old_oid;
 };
@@ -1551,7 +1550,6 @@ static void unlock_ref(struct ref_lock *lock)
 	if (lock->lk)
 		rollback_lock_file(lock->lk);
 	free(lock->ref_name);
-	free(lock->orig_ref_name);
 	free(lock);
 }
 
@@ -1605,7 +1603,6 @@ static int lock_raw_ref(const char *refname, int deleting, int mustexist,
 	*lock_p = lock = xcalloc(1, sizeof(*lock));
 
 	lock->ref_name = xstrdup(refname);
-	lock->orig_ref_name = xstrdup(refname);
 	strbuf_git_path(&ref_file, "%s", refname);
 
 retry:
@@ -1991,14 +1988,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
 
@@ -2008,46 +2004,39 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
+		strbuf_git_path(&ref_file, "%s", refname);
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
@@ -2064,7 +2053,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
 	lock->ref_name = xstrdup(refname);
-	lock->orig_ref_name = xstrdup(orig_refname);
+	strbuf_reset(&ref_file);
 	strbuf_git_path(&ref_file, "%s", refname);
 
  retry:
@@ -2108,7 +2097,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
  out:
 	strbuf_release(&ref_file);
-	strbuf_release(&orig_ref_file);
 	errno = last_errno;
 	return lock;
 }
@@ -2873,9 +2861,7 @@ static int commit_ref_update(struct ref_lock *lock,
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
@@ -2883,7 +2869,8 @@ static int commit_ref_update(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+
+	if (strcmp(lock->ref_name, "HEAD") != 0) {
 		/*
 		 * Special hack: If a branch is updated directly and HEAD
 		 * points to it (may happen on the remote side of a push
@@ -2899,6 +2886,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		unsigned char head_sha1[20];
 		int head_flag;
 		const char *head_ref;
+
 		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
@@ -2911,6 +2899,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
+
 	if (commit_ref(lock)) {
 		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 		unlock_ref(lock);
@@ -3016,7 +3005,6 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lk = &head_lock;
 	lock->ref_name = xstrdup(head_rel);
-	lock->orig_ref_name = xstrdup(head_rel);
 
 	ret = create_symref_locked(lock, head_rel, target, NULL);
 
-- 
2.8.1
