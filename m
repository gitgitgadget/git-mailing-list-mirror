From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 56/56] struct ref_lock: convert old_sha1 member to object_id
Date: Mon, 25 May 2015 18:39:22 +0000
Message-ID: <1432579162-411464-57-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJB-0001F8-Qh
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbbEYSlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:01 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50788 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527AbbEYSki (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2878A280A5;
	Mon, 25 May 2015 18:40:36 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269869>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 7515c2e..a742d79 100644
--- a/refs.c
+++ b/refs.c
@@ -10,7 +10,7 @@ struct ref_lock {
 	char *ref_name;
 	char *orig_ref_name;
 	struct lock_file *lk;
-	unsigned char old_sha1[20];
+	struct object_id old_oid;
 };
 
 /*
@@ -2225,16 +2225,16 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
 {
 	if (read_ref_full(lock->ref_name,
 			  mustexist ? RESOLVE_REF_READING : 0,
-			  lock->old_sha1, NULL)) {
+			  lock->old_oid.hash, NULL)) {
 		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
 		errno = save_errno;
 		return NULL;
 	}
-	if (hashcmp(lock->old_sha1, old_sha1)) {
+	if (hashcmp(lock->old_oid.hash, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_name,
-			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
+			oid_to_hex(&lock->old_oid), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
 		errno = EBUSY;
 		return NULL;
@@ -2382,7 +2382,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	}
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
-				     lock->old_sha1, &type);
+				     lock->old_oid.hash, &type);
 	if (!refname && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -2401,7 +2401,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
-					     lock->old_sha1, &type);
+					     lock->old_oid.hash, &type);
 	}
 	if (type_p)
 	    *type_p = type;
@@ -2421,7 +2421,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * refname, nor a packed ref whose name is a proper prefix of
 	 * our refname.
 	 */
-	if (is_null_sha1(lock->old_sha1) &&
+	if (is_null_oid(&lock->old_oid) &&
 	    verify_refname_available(refname, extras, skip,
 				     get_packed_refs(&ref_cache), err)) {
 		last_errno = ENOTDIR;
@@ -2944,7 +2944,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		strbuf_release(&err);
 		goto rollback;
 	}
-	hashcpy(lock->old_sha1, orig_sha1);
+	hashcpy(lock->old_oid.hash, orig_sha1);
 
 	if (write_ref_to_lockfile(lock, orig_sha1) ||
 	    commit_ref_update(lock, orig_sha1, logmsg)) {
@@ -3199,9 +3199,9 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg)
 {
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
+	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
+	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg) < 0)) {
 		unlock_ref(lock);
 		return -1;
 	}
@@ -3225,7 +3225,7 @@ static int commit_ref_update(struct ref_lock *lock,
 					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
-			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
+			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg);
 	}
 	if (commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
@@ -3923,7 +3923,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						  (update->flags & REF_NODEREF));
 
 			if (!overwriting_symref &&
-			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
+			    !hashcmp(update->lock->old_oid.hash, update->new_sha1)) {
 				/*
 				 * The reference already has the desired
 				 * value, so we don't need to write it.
-- 
2.4.0
