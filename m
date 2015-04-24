From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/5] ref_transaction_commit(): only keep one lockfile open at a time
Date: Fri, 24 Apr 2015 13:35:49 +0200
Message-ID: <1429875349-29736-6-git-send-email-mhagger@alum.mit.edu>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 13:36:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlbuB-0004Xt-0x
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 13:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934088AbbDXLgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 07:36:16 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53008 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933968AbbDXLgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 07:36:09 -0400
X-AuditID: 1207440c-f79376d00000680a-47-553a2aa49306
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B5.67.26634.4AA2A355; Fri, 24 Apr 2015 07:36:04 -0400 (EDT)
Received: from michael.fritz.box (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OBZt8b008846
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 07:36:03 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqLtEyyrUYN9/KYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ1yZeImlYKFuxflbFg2Mc5S7GDk5JARMJP4fvsYOYYtJXLi3nq2LkYtDSOAyo8SvpgMs
	EM5JJontvf3MIFVsAroSi3qamboYOThEBLwk2mYWg4SZBVIkOp53M4LYwgIhEtsmrAMrZxFQ
	lXjccQ7M5hVwkZh3dh0bxDI5ifPHf4LFOQVcJfqXf2QBsYWAatZs+sA+gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQcOLZwfhtncwhRgEORiUeXodZlqFCrIll
	xZW5hxglOZiURHk7paxChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwJgoB5XhTEiurUovyYVLS
	HCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzcmkCNgkWp6akVaZk5JQhpJg5OkOFcUiLF
	qXkpqUWJpSUZ8aC4iC8GRgZIigdo7zaQdt7igsRcoChE6ylGRSlx3t8aQAkBkERGaR7cWFiS
	eMUoDvSlMK8sSDsPMMHAdb8CGswENHjmUguQwSWJCCmpBkbuKenxX3ZacAhkVfS7mM7atSow
	KliQbcrqxcZCQlcFrZrSAh4dk99jtX7tJEP/ojiJiceD+WKqHh1SXH4sJG7NSqGpL+/tv3CD
	ZzvjsU1bEyw4Q36LaK6Z4cQbkrQ2bNLX/A1frEzCxfPtnyzbtmD1uSvaYTcbdcP0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267734>

The old code locked all of the references in the first loop, leaving
all of the lockfiles open until later loops. Since we might be
updating a lot of references, this could cause file descriptor
exhaustion.

But there is no reason to keep the lockfiles open after the first
loop:

* For references being deleted or verified, we don't have to write
  anything into the lockfile, so we can close it immediately.

* For references being updated, we can write the new SHA-1 into the
  lockfile immediately and close the lockfile without renaming it into
  place. In the second loop, the already-written contents can be
  renamed into place using commit_ref_update().

To simplify the bookkeeping across loops, add a new REF_NEEDS_COMMIT
bit to update->flags, which keeps track of whether the corresponding
lockfile needs to be committed, as opposed to just unlocked.

This change fixes two tests in t1400.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                | 68 +++++++++++++++++++++++++++++++++++++--------------
 t/t1400-update-ref.sh |  4 +--
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 782e777..2bdd93c 100644
--- a/refs.c
+++ b/refs.c
@@ -36,25 +36,31 @@ static unsigned char refname_disposition[256] = {
  * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
  * refs (i.e., because the reference is about to be deleted anyway).
  */
-#define REF_DELETING	0x02
+#define REF_DELETING 0x02
 
 /*
  * Used as a flag in ref_update::flags when a loose ref is being
  * pruned.
  */
-#define REF_ISPRUNING	0x04
+#define REF_ISPRUNING 0x04
 
 /*
  * Used as a flag in ref_update::flags when the reference should be
  * updated to new_sha1.
  */
-#define REF_HAVE_NEW	0x08
+#define REF_HAVE_NEW 0x08
 
 /*
  * Used as a flag in ref_update::flags when old_sha1 should be
  * checked.
  */
-#define REF_HAVE_OLD	0x10
+#define REF_HAVE_OLD 0x10
+
+/*
+ * Used as a flag in ref_update::flags when the lockfile needs to be
+ * committed.
+ */
+#define REF_NEEDS_COMMIT 0x20
 
 /*
  * Try to read one refname component from the front of refname.
@@ -3749,7 +3755,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		goto cleanup;
 	}
 
-	/* Acquire all locks while verifying old values */
+	/*
+	 * Acquire all locks, verify old values if provided, check
+	 * that new values are valid, and write new values to the
+	 * lockfiles, ready to be activated. Only keep one lockfile
+	 * open at a time to avoid running out of file descriptors.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3770,13 +3781,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
-	}
-
-	/* Perform updates first so live commits remain referenced */
-	for (i = 0; i < n; i++) {
-		struct ref_update *update = updates[i];
-
-		if ((update->flags & REF_HAVE_NEW) && !is_null_sha1(update->new_sha1)) {
+		if ((update->flags & REF_HAVE_NEW) && !(update->flags & REF_DELETING)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3786,14 +3791,39 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				 * The reference already has the desired
 				 * value, so we don't need to write it.
 				 */
-				unlock_ref(update->lock);
-				update->lock = NULL;
 			} else if (write_ref_to_lockfile(update->lock,
-							 update->new_sha1) ||
-				   commit_ref_update(update->lock,
-						     update->new_sha1,
-						     update->msg)) {
-				update->lock = NULL; /* freed by the above calls */
+							 update->new_sha1)) {
+				update->lock = NULL; /* freed by the above call */
+				strbuf_addf(err, "Cannot update the ref '%s'.",
+					    update->refname);
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto cleanup;
+			} else {
+				update->flags |= REF_NEEDS_COMMIT;
+			}
+		}
+		if (!(update->flags & REF_NEEDS_COMMIT)) {
+			/*
+			 * We didn't have to write anything to the lockfile.
+			 * Close it to free up the file descriptor:
+			 */
+			if (close_ref(update->lock)) {
+				strbuf_addf(err, "Couldn't close %s.lock",
+					    update->refname);
+				goto cleanup;
+			}
+		}
+	}
+
+	/* Perform updates first so live commits remain referenced */
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (update->flags & REF_NEEDS_COMMIT) {
+			if (commit_ref_update(update->lock,
+						    update->new_sha1,
+						    update->msg)) {
+				update->lock = NULL; /* freed by the above call */
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7a69f1a..636d3a1 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1071,7 +1071,7 @@ run_with_limited_open_files () {
 
 test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
 
-test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
 	do
@@ -1082,7 +1082,7 @@ test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
 )
 '
 
-test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
 	do
-- 
2.1.4
