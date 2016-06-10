From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/6] lock_ref_for_update(): make error handling more uniform
Date: Fri, 10 Jun 2016 10:14:48 +0200
Message-ID: <6cc13da6767c5fd9dbf1b372634adf7c3a353464.1465544913.git.mhagger@alum.mit.edu>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, David Turner <novalis@novalis.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHbW-0001ui-Oa
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcFJIPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:15:32 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56819 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663AbcFJIPI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 04:15:08 -0400
X-AuditID: 1207440e-ef3ff700000008c5-e9-575a770755ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E3.A5.02245.7077A575; Fri, 10 Jun 2016 04:15:03 -0400 (EDT)
Received: from michael.fritz.box (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A8EpD7028943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 04:15:02 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465544913.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqMteHhVu8HijpUXXlW4mi4beK8wW
	T+beZba4vWI+s8WSh6+ZLbqnvGW0+NHSw+zA7vH3/Qcmj52z7rJ7PHzVxe7R1X6EzeNZ7x5G
	j4uXlD0+b5ILYI/itklKLCkLzkzP07dL4M74+eIRa8Ebx4rNndUNjJdMuhg5OSQETCRmX+1i
	6WLk4hAS2MoosePvBjYI5ySTxJUT99hAqtgEdCUW9TQzgdgiAmoSE9sOgXUwC3QySZzY84YF
	JCEs4C+xds1jVhCbRUBVYt39U+wgNq9AlERH71wWiHVyEpenPwAbyilgIXH6+gQwW0jAXOLf
	7Cb2CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEBBnfDsb29TKH
	GAU4GJV4eCN2RYYLsSaWFVfmHmKU5GBSEuXdGRgVLsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	Vwwkx5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4J1aCtQoWJSanlqR
	lplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qB+GJgFICkeID2toO08xYXJOYCRSFaTzHqchzZ
	f28tkxBLXn5eqpQ47yKQIgGQoozSPLgVsJTyilEc6GNh3g0gVTzAdAQ36RXQEiagJcuPhIMs
	KUlESEk1MM4494rnH9/MFcynj5eq17Nmxf67WuLvuSH6tLTPmjturEHXj5bV/3lv9HfbrMN2
	BdJLxU5J3P6/h/OxRPHnf+nntl6xKvkzZZrDm1BLhRB57hjeCXrbZz9xZ8n1uX1v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296956>

To aid the effort, extract a new function, check_old_oid(), and use it
in the two places where the read value of the reference has to be
checked against update->old_sha1.

Update tests to reflect the improvements.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c         | 77 ++++++++++++++++++++++++++------------------
 t/t1404-update-ref-errors.sh | 14 ++++----
 2 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1230dfb..98c8b95 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3389,6 +3389,41 @@ static const char *original_update_refname(struct ref_update *update)
 }
 
 /*
+ * Check whether the REF_HAVE_OLD and old_oid values stored in update
+ * are consistent with the result read for the reference. error is
+ * true iff there was an error reading the reference; otherwise, oid
+ * is the value read for the reference.
+ *
+ * If there was a problem, write an error message to err and return
+ * -1.
+ */
+static int check_old_oid(struct ref_update *update, struct object_id *oid,
+			 struct strbuf *err)
+{
+	if (!(update->flags & REF_HAVE_OLD) ||
+		   !hashcmp(oid->hash, update->old_sha1))
+		return 0;
+
+	if (is_null_sha1(update->old_sha1))
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "reference already exists",
+			    original_update_refname(update));
+	else if (is_null_oid(oid))
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "reference is missing but expected %s",
+			    original_update_refname(update),
+			    sha1_to_hex(update->old_sha1));
+	else
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "is at %s but expected %s",
+			    original_update_refname(update),
+			    oid_to_hex(oid),
+			    sha1_to_hex(update->old_sha1));
+
+	return -1;
+}
+
+/*
  * Prepare for carrying out update:
  * - Lock the reference referred to by update.
  * - Read the reference under lock.
@@ -3432,7 +3467,7 @@ static int lock_ref_for_update(struct ref_update *update,
 
 		reason = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot lock ref '%s': %s",
-			    update->refname, reason);
+			    original_update_refname(update), reason);
 		free(reason);
 		return ret;
 	}
@@ -3446,28 +3481,17 @@ static int lock_ref_for_update(struct ref_update *update,
 			 * the transaction, so we have to read it here
 			 * to record and possibly check old_sha1:
 			 */
-			if (read_ref_full(update->refname,
-					  mustexist ? RESOLVE_REF_READING : 0,
+			if (read_ref_full(update->refname, 0,
 					  lock->old_oid.hash, NULL)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
-						    "can't resolve old value",
-						    update->refname);
-					return TRANSACTION_GENERIC_ERROR;
-				} else {
-					hashclr(lock->old_oid.hash);
+						    "error reading reference",
+						    original_update_refname(update));
+					return -1;
 				}
-			}
-			if ((update->flags & REF_HAVE_OLD) &&
-			    hashcmp(lock->old_oid.hash, update->old_sha1)) {
-				strbuf_addf(err, "cannot lock ref '%s': "
-					    "is at %s but expected %s",
-					    update->refname,
-					    sha1_to_hex(lock->old_oid.hash),
-					    sha1_to_hex(update->old_sha1));
+			} else if (check_old_oid(update, &lock->old_oid, err)) {
 				return TRANSACTION_GENERIC_ERROR;
 			}
-
 		} else {
 			/*
 			 * Create a new update for the reference this
@@ -3484,6 +3508,9 @@ static int lock_ref_for_update(struct ref_update *update,
 	} else {
 		struct ref_update *parent_update;
 
+		if (check_old_oid(update, &lock->old_oid, err))
+			return TRANSACTION_GENERIC_ERROR;
+
 		/*
 		 * If this update is happening indirectly because of a
 		 * symref update, record the old SHA-1 in the parent
@@ -3494,20 +3521,6 @@ static int lock_ref_for_update(struct ref_update *update,
 		     parent_update = parent_update->parent_update) {
 			oidcpy(&parent_update->lock->old_oid, &lock->old_oid);
 		}
-
-		if ((update->flags & REF_HAVE_OLD) &&
-		    hashcmp(lock->old_oid.hash, update->old_sha1)) {
-			if (is_null_sha1(update->old_sha1))
-				strbuf_addf(err, "cannot lock ref '%s': reference already exists",
-					    original_update_refname(update));
-			else
-				strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
-					    original_update_refname(update),
-					    sha1_to_hex(lock->old_oid.hash),
-					    sha1_to_hex(update->old_sha1));
-
-			return TRANSACTION_GENERIC_ERROR;
-		}
 	}
 
 	if ((update->flags & REF_HAVE_NEW) &&
@@ -3529,7 +3542,7 @@ static int lock_ref_for_update(struct ref_update *update,
 			 */
 			update->lock = NULL;
 			strbuf_addf(err,
-				    "cannot update the ref '%s': %s",
+				    "cannot update ref '%s': %s",
 				    update->refname, write_err);
 			free(write_err);
 			return TRANSACTION_GENERIC_ERROR;
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 5234b41f1..c34ece4 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -237,7 +237,7 @@ test_expect_success 'missing old value blocks indirect update' '
 	prefix=refs/missing-indirect-update &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
@@ -284,7 +284,7 @@ test_expect_success 'missing old value blocks indirect no-deref update' '
 	prefix=refs/missing-noderef-update &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $Q$prefix/symref$Q: can${Q}t resolve old value
+	fatal: cannot lock ref $Q$prefix/symref$Q: reference is missing but expected $D
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
@@ -303,7 +303,7 @@ test_expect_success 'incorrect old value blocks indirect no-deref update' '
 	test_cmp expected output.err
 '
 
-test_expect_failure 'existing old value blocks indirect no-deref create' '
+test_expect_success 'existing old value blocks indirect no-deref create' '
 	prefix=refs/existing-noderef-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	git update-ref $prefix/foo $C &&
@@ -372,13 +372,13 @@ test_expect_success 'non-empty directory blocks indirect create' '
 	: >.git/$prefix/foo/bar/baz.lock &&
 	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $Q$prefix/foo$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
+	fatal: cannot lock ref $Q$prefix/symref$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/symref $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/symref $D $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
@@ -391,13 +391,13 @@ test_expect_success 'broken reference blocks indirect create' '
 	echo "gobbledigook" >.git/$prefix/foo &&
 	test_when_finished "rm -f .git/$prefix/foo" &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
 	EOF
 	printf "%s\n" "update $prefix/symref $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
 	test_cmp expected output.err &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
 	EOF
 	printf "%s\n" "update $prefix/symref $D $C" |
 	test_must_fail git update-ref --stdin 2>output.err &&
-- 
2.8.1
