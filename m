From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 27/29] lock_ref_for_update(): don't resolve symrefs
Date: Wed, 27 Apr 2016 18:57:44 +0200
Message-ID: <dc9cd5747320dbbfc328f79b60ba8d6d78764fff.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSo1-00040G-4P
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbcD0Q6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:55 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43127 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752841AbcD0Q6u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:50 -0400
X-AuditID: 1207440d-bc7ff7000000090b-a4-5720efc9f97c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 52.9E.02315.9CFE0275; Wed, 27 Apr 2016 12:58:49 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6e022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:47 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqHvyvUK4wbUtkhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyVx1uZC1Y7VBzvWMPWwPjFsIuRk0NCwETixv2r
	rF2MXBxCAlsZJZ4t7GQGSQgJHGeSaDrEC2KzCehKLOppZgKxRQQcJJav/MUO0sAs0MQk8X15
	E0sXIweHsICzxKuzcSAmi4CqxPGVYOW8AlESP69uZ4TYJSdxefoDNhCbU8BC4kvrW0aIVeYS
	Sx6sZp/AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkh48e5g/L9O
	5hCjAAejEg9vgYRCuBBrYllxZe4hRkkOJiVR3iVngUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
	eKe/AcrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4zd4BNQoWpaan
	VqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDwj++GBgBICkeoL1/3oLsLS5IzAWKQrSeYlSU
	Eud1BUkIgCQySvPgxsKSxitGcaAvhXmDQLbzABMOXPcroMFMQIMvH5IFGVySiJCSamD0+XtD
	tHnttvDIqNknVXrnhn5Rv2OuzDhficWch9mU9+jf2wuvv1y10n+zh8QKV68b1VH5Fy46fC6I
	uWRt4XK8Ncbnc4/zaiYH3tK2HwpKZs3Hbtqr1G1ub0r36Xhu5/g/M+rVlXcvDI48 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292760>

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
There is one remaining race that I know of: the value of HEAD is read
at the start of the transaction to determine whether its referent is
changed in the transaction. If so, the update is also logged in HEAD's
reflog.

The problem is that HEAD is read without acquiring its lock. So in
principle HEAD could change during the time that the transaction is
being processed, leading to inconsistencies in the reflogs.

This problem could be fixed, but it would require HEAD to be locked
for every reference transaction, probably in some kind of an
additional fake ref_update. I don't know that it's worth the effort,
but if it is it can be done within the same framework that I
implemented here.

 refs/files-backend.c | 108 +++++++++++++++++++++++++++++++++++++--------------
 refs/refs-internal.h |  17 ++++++++
 2 files changed, 95 insertions(+), 30 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 66ceb83..40ed157 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3366,8 +3366,15 @@ static int split_symref_update(struct ref_update *update,
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
 
@@ -3375,6 +3382,17 @@ static int split_symref_update(struct ref_update *update,
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
@@ -3428,44 +3446,74 @@ static int lock_ref_for_update(struct ref_update *update,
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
index 9839b07..2355735 100644
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
