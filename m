From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/5] lock_ref_for_update(): make error handling more uniform
Date: Tue,  7 Jun 2016 13:50:09 +0200
Message-ID: <4976e72fb492d5cfd2999a1fda4bc28f4ab92ae1.1465299118.git.mhagger@alum.mit.edu>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:51:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFWz-0004XT-Kh
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbcFGLui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:50:38 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52993 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161133AbcFGLuc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 07:50:32 -0400
X-AuditID: 12074413-487ff700000008c7-ee-5756b4fd3c39
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id BD.4B.02247.DF4B6575; Tue,  7 Jun 2016 07:50:21 -0400 (EDT)
Received: from michael.fritz.box (p548D6137.dip0.t-ipconnect.de [84.141.97.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u57BoCa3014544
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 7 Jun 2016 07:50:20 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465299118.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPt3S1i4wdoVRhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WF2YPP4+/4Dk8fOWXfZPZ717mH0uHhJ2WPB8/vsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ/x+Mpu54JVjxdXlIQ2MF0y6GDk5JARMJCbuPsnexcjFISSwlVHi
	5fFWZgjnGJPEgYWbmUCq2AR0JRb1NIPZIgIREg2vWhhBipgF9jFKnFw3nwUkISzgI3Fp5VEw
	m0VAVeLRh1lgNq9AlMT8CxMYIdbJSVye/oANxOYUsJA48W4lmC0kYC5xsWUT4wRGngWMDKsY
	5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcxQgJKeAfjrpNyhxgFOBiVeHh3fAkN
	F2JNLCuuzD3EKMnBpCTK+9A7LFyILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/CWqAcb0piZVVq
	UT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC1xoYOUKCRanpqRVpmTklCGkmDk6Q
	4VxSIsWpeSmpRYmlJRnxoBiILwZGAUiKB2hvHEg7b3FBYi5QFKL1FKOilDjvts1ACQGQREZp
	HtxYWJp4xSgO9KUwLwtIOw8wxcB1vwIazAQ0eNm1YJDBJYkIKakGRlU21TmNSQFHpp1NqHKe
	+Xcxg5Gm/xsxbr2ldc+eHDHK5gpN2cV2XvS9RdyT/apLvb9uniXQbPlu6bvzexesmZK6asKP
	hzNyC8PXK0y8eoDhmuZc/7pZV5+cUJNcP7/7fmBL1eHHq+ZNNzn1/KxTw2yj1H83 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296631>

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
index 0dcc16c..b4602df 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -232,7 +232,7 @@ test_expect_success 'missing old value blocks indirect update' '
 	prefix=refs/missing-indirect-update &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q
 	EOF
 	printf "%s\n" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
@@ -279,7 +279,7 @@ test_expect_success 'missing old value blocks indirect no-deref update' '
 	prefix=refs/missing-noderef-update &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	cat >expected <<-EOF &&
-	fatal: cannot lock ref $Q$prefix/symref$Q: can${Q}t resolve old value
+	fatal: cannot lock ref $Q$prefix/symref$Q: reference is missing but expected $D
 	EOF
 	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
 	test_must_fail git update-ref --stdin 2>output.err &&
@@ -298,7 +298,7 @@ test_expect_success 'incorrect old value blocks indirect no-deref update' '
 	test_cmp expected output.err
 '
 
-test_expect_failure 'existing old value blocks indirect no-deref create' '
+test_expect_success 'existing old value blocks indirect no-deref create' '
 	prefix=refs/existing-noderef-create &&
 	git symbolic-ref $prefix/symref $prefix/foo &&
 	git update-ref $prefix/foo $C &&
@@ -367,13 +367,13 @@ test_expect_success 'non-empty directory blocks indirect create' '
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
@@ -386,13 +386,13 @@ test_expect_success 'broken reference blocks indirect create' '
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
