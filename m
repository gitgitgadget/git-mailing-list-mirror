From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 8/8] ref_transaction_commit(): fix atomicity and avoid fd exhaustion
Date: Sun, 10 May 2015 04:45:37 +0200
Message-ID: <1431225937-10456-9-git-send-email-mhagger@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 05:01:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHV1-0004tB-JT
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 05:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbbEJDBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 23:01:46 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54623 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072AbbEJDBq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 23:01:46 -0400
X-Greylist: delayed 941 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2015 23:01:45 EDT
X-AuditID: 12074411-f79fa6d000006b8a-52-554ec66960e8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.78.27530.966CE455; Sat,  9 May 2015 22:46:01 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxg015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:59 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqJt5zC/UYPp8VouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8bu2XtZCk5ZVVw8dZWtgfGFThcjJ4eEgIlE1/u77BC2mMSFe+vZuhi5
	OIQELjNKrOj/wgjhHGeSaL10AKyKTUBXYlFPM1MXIweHiICXRNvMYpAaZoFeRolHi18xgtQI
	C4RLLDv6mwnEZhFQlbh/ey9YL6+Ai8Tih0ehtslJnD/+kxnE5hRwlbh9Zi6YLQRU07i0iWUC
	I+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCFBJriDccZJuUOMAhyM
	Sjy8H7b5hQqxJpYVV+YeYpTkYFIS5bVZCBTiS8pPqcxILM6ILyrNSS0+xCjBwawkwntyPVCO
	NyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTBG3sUqFGwKDU9tSItM6cE
	Ic3EwQkynEtKpDg1LyW1KLG0JCMeFBvxxcDoAEnxAO2tBGnnLS5IzAWKQrSeYlSUEudtA0kI
	gCQySvPgxsJSxytGcaAvhXm7Qap4gGkHrvsV0GAmoMF/i31ABpckIqSkGhj7grMXytjma7n+
	9Dj9penhgR497lPFuRXsqS9qbvpHB05Q7BHzS/j5WDTeerHXxQsnW0tTY49OyZ2ixmySF5TZ
	EjWl3Uph//uJKUtXGuw8FM/08fCukuKTgTX3MoTXlgc4bjvjdOGwvbpAncj7Ev8z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268724>

The old code was roughly

    for update in updates:
        acquire locks and check old_sha
    for update in updates:
        if changing value:
            write_ref_to_lockfile()
            commit_ref_update()
    for update in updates:
        if deleting value:
            unlink()
    rewrite packed-refs file
    for update in updates:
        if reference still locked:
            unlock_ref()

This has two problems.

Non-atomic updates
==================

The atomicity of the reference transaction depends on all pre-checks
being done in the first loop, before any changes have started being
committed in the second loop. The problem is that
write_ref_to_lockfile() (previously part of write_ref_sha1()), which
is called from the second loop, contains two more checks:

* It verifies that new_sha1 is a valid object

* If the reference being updated is a branch, it verifies that
  new_sha1 points at a commit object (as opposed to a tag, tree, or
  blob).

If either of these checks fails, the "transaction" is aborted during
the second loop. But this might happen after some reference updates
have already been permanently committed. In other words, the
all-or-nothing promise of "git update-ref --stdin" could be violated.

So these checks have to be moved to the first loop.

File descriptor exhaustion
==========================

The old code locked all of the references in the first loop, leaving
all of the lockfiles open until later loops. Since we might be
updating a lot of references, this could result in file descriptor
exhaustion.

The solution
============

After this patch, the code looks like

    for update in updates:
        acquire locks and check old_sha
        if changing value:
            write_ref_to_lockfile()
        else:
            close_ref()
    for update in updates:
        if changing value:
            commit_ref_update()
    for update in updates:
        if deleting value:
            unlink()
    rewrite packed-refs file
    for update in updates:
        if reference still locked:
            unlock_ref()

This fixes both problems:

1. The pre-checks in write_ref_to_lockfile() are now done in the first
   loop, before any changes have been committed. If any of the checks
   fails, the whole transaction can now be rolled back correctly.

2. All lockfiles are closed in the first loop immediately after they
   are created (either by write_ref_to_lockfile() or by close_ref()).
   This means that there is never more than one open lockfile at a
   time, preventing file descriptor exhaustion.

To simplify the bookkeeping across loops, add a new REF_NEEDS_COMMIT
bit to update->flags, which keeps track of whether the corresponding
lockfile needs to be committed, as opposed to just unlocked. (Since
"struct ref_update" is internal to the refs module, this change is not
visible to external callers.)

This change fixes two tests in t1400.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                | 55 +++++++++++++++++++++++++++++++++++++++++----------
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 58b1182..85c1dcb 100644
--- a/refs.c
+++ b/refs.c
@@ -30,6 +30,13 @@ static unsigned char refname_disposition[256] = {
  * pruned.
  */
 #define REF_ISPRUNING	0x0100
+
+/*
+ * Used as a flag in ref_update::flags when the lockfile needs to be
+ * committed.
+ */
+#define REF_NEEDS_COMMIT 0x0200
+
 /*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
@@ -3799,7 +3806,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
 
@@ -3820,26 +3832,49 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
+		if (!(update->flags & REF_DELETING) &&
+		    (update->lock->force_write ||
+		     hashcmp(update->lock->old_sha1, update->new_sha1))) {
+			if (write_ref_to_lockfile(update->lock, update->new_sha1)) {
+				/*
+				 * The lock was freed upon failure of
+				 * write_ref_to_lockfile():
+				 */
+				update->lock = NULL;
+				strbuf_addf(err, "Cannot update the ref '%s'.",
+					    update->refname);
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto cleanup;
+			}
+			update->flags |= REF_NEEDS_COMMIT;
+		} else {
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
 	}
 
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (!(update->flags & REF_DELETING)) {
-			if (!update->lock->force_write &&
-			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
-				unlock_ref(update->lock);
+		if (update->flags & REF_NEEDS_COMMIT) {
+			if (commit_ref_update(update->lock,
+					      update->new_sha1, update->msg)) {
+				/* The lock was freed by commit_ref_update(): */
 				update->lock = NULL;
-			} else if (write_ref_to_lockfile(update->lock, update->new_sha1) ||
-				   commit_ref_update(update->lock, update->new_sha1, update->msg)) {
-				update->lock = NULL; /* freed by the above calls */
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			} else {
-				/* freed by the above calls: */
+				/* freed by the above call: */
 				update->lock = NULL;
 			}
 		}
@@ -3849,7 +3884,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->lock) {
+		if (update->flags & REF_DELETING) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 47d2fe9..c593a1d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -979,7 +979,7 @@ run_with_limited_open_files () {
 
 test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
 
-test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
 	do
@@ -990,7 +990,7 @@ test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
 )
 '
 
-test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
+test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
 	do
-- 
2.1.4
