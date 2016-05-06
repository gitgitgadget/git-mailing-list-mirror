From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 31/33] lock_ref_for_update(): don't resolve symrefs
Date: Fri,  6 May 2016 18:14:12 +0200
Message-ID: <6097b21b368baaacdd887deb086219cb919e00d9.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPe-0000Bq-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579AbcEFQP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:29 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56573 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932093AbcEFQPR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:17 -0400
X-AuditID: 12074412-52fff700000009f7-51-572cc314a25b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4D.62.02551.413CC275; Fri,  6 May 2016 12:15:16 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHVD031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:14 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqCtyWCfc4PNkMYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8a8m++ZCp5bVaxvWcHcwLhXt4uRk0NCwERiyo4Z
	7F2MXBxCAlsZJfbPm8kC4Rxnkri54CUrSBWbgK7Eop5mJhBbRCBCouFVC2MXIwcHs8BnRomV
	3CBhYQE3ia4Xj8BKWARUJeYub2IGsXkFoiQa2/exQSyTk7g8/QGYzSlgIXGo9zhYvZCAuUTH
	2hvsExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdPLzSzRS00p3cQICTChHYzrT8od
	YhTgYFTi4c04qR0uxJpYVlyZe4hRkoNJSZT3e4FOuBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3iv7gHK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8zYeAGgWLUtNT
	K9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBERBfDIwBkBQP0F4+kHbe4oLEXKAoROspRl2O
	I/vvrWUSYsnLz0uVEuedexCoSACkKKM0D24FLJ28YhQH+liY9zJIFQ8wFcFNegW0hAloyfu5
	miBLShIRUlINjDskq1iWbY6T0+Tcue/4j01FkYlhPvM+b9zkOu1uvkLHR7btjE1xmQvqji07
	4KXAsqItrWNi3TdN/kDXrkbf9b6djQ8CdyyfUbZmkUzrxkVNxq9erPthdtIspfDO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293815>

If a transaction includes a non-NODEREF update to a symbolic reference,
we don't have to look it up in lock_ref_for_update(). The reference will
be dereferenced anyway when the split-off update is processed.

This change requires that we store a backpointer from the split-off
update to its parent update, for two reasons:

* We still want to report the original reference name in error messages.
  So if an error occurs when checking the split-off update's old_sha1,
  walk the parent_update pointers back to find the original reference
  name, and report that one.

* We still need to write the old_sha1 of the symref to its reflog. So
  after we read the split-off update's reference value, walk the
  parent_update pointers back and fill in their old_sha1 fields.

Aside from eliminating unnecessary reads, this change fixes a
subtle (though not very serious) race condition: in the old code, the
old_sha1 of the symref was resolved before the reference that it pointed
at was locked. So it was possible that the old_sha1 value logged to the
symref's reflog could be wrong if another process changed the downstream
reference before it was locked.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 108 +++++++++++++++++++++++++++++++++++++--------------
 refs/refs-internal.h |  17 ++++++++
 2 files changed, 95 insertions(+), 30 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a9066ba..08ec293 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3371,8 +3371,15 @@ static int split_symref_update(struct ref_update *update,
 			update->new_sha1, update->old_sha1,
 			update->msg);
 
-	/* Change the symbolic ref update to log only: */
+	new_update->parent_update = update;
+
+	/*
+	 * Change the symbolic ref update to log only. Also, it
+	 * doesn't need to check its old SHA-1 value, as that will be
+	 * done when new_update is processed.
+	 */
 	update->flags |= REF_LOG_ONLY | REF_NODEREF;
+	update->flags &= ~REF_HAVE_OLD;
 
 	item->util = new_update;
 
@@ -3380,6 +3387,17 @@ static int split_symref_update(struct ref_update *update,
 }
 
 /*
+ * Return the refname under which update was originally requested.
+ */
+static const char *original_update_refname(struct ref_update *update)
+{
+	while (update->parent_update)
+		update = update->parent_update;
+
+	return update->refname;
+}
+
+/*
  * Prepare for carrying out update:
  * - Lock the reference referred to by update.
  * - Read the reference under lock.
@@ -3431,44 +3449,74 @@ static int lock_ref_for_update(struct ref_update *update,
 	lock = update->lock;
 
 	if (update->type & REF_ISSYMREF) {
-		if (read_ref_full(update->refname,
-				  mustexist ? RESOLVE_REF_READING : 0,
-				  lock->old_oid.hash, NULL)) {
-			if (update->flags & REF_HAVE_OLD) {
-				strbuf_addf(err, "cannot lock ref '%s': can't resolve old value",
-					    update->refname);
+		if (update->flags & REF_NODEREF) {
+			/*
+			 * We won't be reading the referent as part of
+			 * the transaction, so we have to read it here
+			 * to record and possibly check old_sha1:
+			 */
+			if (read_ref_full(update->refname,
+					  mustexist ? RESOLVE_REF_READING : 0,
+					  lock->old_oid.hash, NULL)) {
+				if (update->flags & REF_HAVE_OLD) {
+					strbuf_addf(err, "cannot lock ref '%s': "
+						    "can't resolve old value",
+						    update->refname);
+					return TRANSACTION_GENERIC_ERROR;
+				} else {
+					hashclr(lock->old_oid.hash);
+				}
+			}
+			if ((update->flags & REF_HAVE_OLD) &&
+			    hashcmp(lock->old_oid.hash, update->old_sha1)) {
+				strbuf_addf(err, "cannot lock ref '%s': "
+					    "is at %s but expected %s",
+					    update->refname,
+					    sha1_to_hex(lock->old_oid.hash),
+					    sha1_to_hex(update->old_sha1));
 				return TRANSACTION_GENERIC_ERROR;
-			} else {
-				hashclr(lock->old_oid.hash);
 			}
-		}
-		if ((update->flags & REF_HAVE_OLD) &&
-		    hashcmp(lock->old_oid.hash, update->old_sha1)) {
-			strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
-				    update->refname,
-				    sha1_to_hex(lock->old_oid.hash),
-				    sha1_to_hex(update->old_sha1));
-			return TRANSACTION_GENERIC_ERROR;
-		}
 
-		if (!(update->flags & REF_NODEREF)) {
+		} else {
+			/*
+			 * Create a new update for the reference this
+			 * symref is pointing at. Also, we will record
+			 * and verify old_sha1 for this update as part
+			 * of processing the split-off update, so we
+			 * don't have to do it here.
+			 */
 			ret = split_symref_update(update, referent.buf, transaction,
 						  affected_refnames, err);
 			if (ret)
 				return ret;
 		}
-	} else if ((update->flags & REF_HAVE_OLD) &&
-		   hashcmp(lock->old_oid.hash, update->old_sha1)) {
-		if (is_null_sha1(update->old_sha1))
-			strbuf_addf(err, "cannot lock ref '%s': reference already exists",
-				    update->refname);
-		else
-			strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
-				    update->refname,
-				    sha1_to_hex(lock->old_oid.hash),
-				    sha1_to_hex(update->old_sha1));
+	} else {
+		struct ref_update *parent_update;
 
-		return TRANSACTION_GENERIC_ERROR;
+		/*
+		 * If this update is happening indirectly because of a
+		 * symref update, record the old SHA-1 in the parent
+		 * update:
+		 */
+		for (parent_update = update->parent_update;
+		     parent_update;
+		     parent_update = parent_update->parent_update) {
+			oidcpy(&parent_update->lock->old_oid, &lock->old_oid);
+		}
+
+		if ((update->flags & REF_HAVE_OLD) &&
+		    hashcmp(lock->old_oid.hash, update->old_sha1)) {
+			if (is_null_sha1(update->old_sha1))
+				strbuf_addf(err, "cannot lock ref '%s': reference already exists",
+					    original_update_refname(update));
+			else
+				strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
+					    original_update_refname(update),
+					    sha1_to_hex(lock->old_oid.hash),
+					    sha1_to_hex(update->old_sha1));
+
+			return TRANSACTION_GENERIC_ERROR;
+		}
 	}
 
 	if ((update->flags & REF_HAVE_NEW) &&
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index cccd76b..1bb3d87 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -143,24 +143,41 @@ int should_autocreate_reflog(const char *refname);
  * not exist before update.
  */
 struct ref_update {
+
 	/*
 	 * If (flags & REF_HAVE_NEW), set the reference to this value:
 	 */
 	unsigned char new_sha1[20];
+
 	/*
 	 * If (flags & REF_HAVE_OLD), check that the reference
 	 * previously had this value:
 	 */
 	unsigned char old_sha1[20];
+
 	/*
 	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
 	 * REF_DELETING, REF_ISPRUNING, REF_LOG_ONLY, and
 	 * REF_UPDATE_VIA_HEAD:
 	 */
 	unsigned int flags;
+
 	struct ref_lock *lock;
 	unsigned int type;
 	char *msg;
+
+	/*
+	 * If this ref_update was split off of a symref update via
+	 * split_symref_update(), then this member points at that
+	 * update. This is used for two purposes:
+	 * 1. When reporting errors, we report the refname under which
+	 *    the update was originally requested.
+	 * 2. When we read the old value of this reference, we
+	 *    propagate it back to its parent update for recording in
+	 *    the latter's reflog.
+	 */
+	struct ref_update *parent_update;
+
 	const char refname[FLEX_ARRAY];
 };
 
-- 
2.8.1
