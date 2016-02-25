From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/20] ref_transaction_commit(): clean up empty directories
Date: Thu, 25 Feb 2016 14:16:19 +0100
Message-ID: <1c2176ceec2f28709ca9f16adf291c34abb00cf3.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvn4-0003w4-DS
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760588AbcBYNRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:17:06 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52854 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760498AbcBYNRF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:17:05 -0500
X-AuditID: 1207440f-d9fff70000007e44-1f-56cefed0cb31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 65.9C.32324.0DEFEC65; Thu, 25 Feb 2016 08:17:04 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPs0024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:17:02 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqHvh37kwg92PRC3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ow1H7+zFTxXr5i7xbeB8ahCFyMnh4SAiURHxzSm
	LkYuDiGBrYwSZ66/g3JOMEmc39bACFLFJqArsainmQnEFhFQk5jYdogFpIhZ4BGjRNf+7WBF
	wgJ+EqdPnQOzWQRUJY7O7WcGsXkFoiR+d21jglgnJ9HyYzcriM0pYCFx8eR0sBohAXOJVTf2
	sE9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIyTE+Hcwdq2XOcQo
	wMGoxMPL8PNsmBBrYllxZe4hRkkOJiVR3j3Pz4UJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFd
	8Rcox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4N0E0ihYlJqeWpGW
	mVOCkGbi4AQZziUlUpyal5JalFhakhEPioH4YmAUgKR4gPbmgu0tLkjMBYpCtJ5iVJQS5zUC
	SQiAJDJK8+DGwhLHK0ZxoC+FeV+BVPEAkw5c9yugwUxAg2duABtckoiQkmpgXOhdlLt5353q
	8G/sWmmmt2rf3MrYEjuTsafS9Gxf9gONao7q1AL1pF3rpK/fn8B4f91NW1Ofst/nGYOlxbKS
	uOWzb6XYzFMqMa+bUHree6tRYorejpBLVQt3u/IVZr34Z1Fq1V3xezPnhpDZkyya 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287376>

When deleting/pruning references, remove any directories that are made
empty by the deletion of loose references or of reflogs. Otherwise such
empty directories can survive forever and accumulate over time. (Even
'pack-refs', which is smart enough to remove the parent directories of
loose references that it prunes, leaves directories that were already
empty.)

And now that ref_transaction_commit() takes care of deleting the parent
directories of loose references that it prunes, we don't have to do that
in prune_ref() anymore.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  | 37 +++++++++++++++++++++++++++++++------
 refs/refs-internal.h  |  9 ++++++++-
 t/t1400-update-ref.sh | 27 +++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9ebb188..9973958 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2263,7 +2263,6 @@ static void prune_ref(struct ref_to_prune *r)
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	try_remove_empty_parents(r->name, REMOVE_EMPTY_PARENTS_REF);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3261,6 +3260,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
 				}
+				update->flags |= REF_DELETED_LOOSE;
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
@@ -3273,16 +3273,41 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
-	for_each_string_list_item(ref_to_delete, &refs_to_delete)
-		unlink_or_warn(git_path("logs/%s", ref_to_delete->string));
+
+	/* Delete the reflogs of any references that were deleted: */
+	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
+		if (!unlink_or_warn(git_path("logs/%s", ref_to_delete->string)))
+			try_remove_empty_parents(ref_to_delete->string,
+						 REMOVE_EMPTY_PARENTS_REFLOG);
+	}
+
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
 
-	for (i = 0; i < n; i++)
-		if (updates[i]->lock)
-			unlock_ref(updates[i]->lock);
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (!update->lock)
+			continue;
+
+		if (update->flags & REF_DELETED_LOOSE) {
+			/*
+			 * The loose reference was deleted. We want to
+			 * delete any empty parent directories, but
+			 * that can only work after we have removed
+			 * the lockfile:
+			 */
+			char *path = xstrdup(update->lock->ref_name);
+			unlock_ref(update->lock);
+			try_remove_empty_parents(path, REMOVE_EMPTY_PARENTS_REF);
+			free(path);
+		} else {
+			unlock_ref(update->lock);
+		}
+	}
+
 	string_list_clear(&refs_to_delete, 0);
 	string_list_clear(&affected_refnames, 0);
 	return ret;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7dded3..dd09be1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -43,6 +43,12 @@
  */
 
 /*
+ * Used as a flag in ref_update::flags when the loose reference has
+ * been deleted.
+ */
+#define REF_DELETED_LOOSE 0x100
+
+/*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
  * example by causing a file that is not a reference to be deleted.
@@ -141,7 +147,8 @@ struct ref_update {
 	unsigned char old_sha1[20];
 	/*
 	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
-	 * REF_DELETING, and REF_ISPRUNING:
+	 * REF_DELETING, REF_ISPRUNING, REF_NEEDS_COMMIT, and
+	 * REF_DELETED_LOOSE:
 	 */
 	unsigned int flags;
 	struct ref_lock *lock;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index af1b20d..00284eb 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -191,6 +191,33 @@ test_expect_success \
 	 git update-ref HEAD'" $A &&
 	 test $A"' = $(cat .git/'"$m"')'
 
+test_expect_success "empty directory removal" '
+	git branch d1/d2/r1 HEAD &&
+	git branch d1/r2 HEAD &&
+	test -f .git/refs/heads/d1/d2/r1 &&
+	test -f .git/logs/refs/heads/d1/d2/r1 &&
+	git branch -d d1/d2/r1 &&
+	! test -e .git/refs/heads/d1/d2 &&
+	! test -e .git/logs/refs/heads/d1/d2 &&
+	test -f .git/refs/heads/d1/r2 &&
+	test -f .git/logs/refs/heads/d1/r2
+'
+
+test_expect_success "symref empty directory removal" '
+	git branch e1/e2/r1 HEAD &&
+	git branch e1/r2 HEAD &&
+	git checkout e1/e2/r1 &&
+	test_when_finished "git checkout master" &&
+	test -f .git/refs/heads/e1/e2/r1 &&
+	test -f .git/logs/refs/heads/e1/e2/r1 &&
+	git update-ref -d HEAD &&
+	! test -e .git/refs/heads/e1/e2 &&
+	! test -e .git/logs/refs/heads/e1/e2 &&
+	test -f .git/refs/heads/e1/r2 &&
+	test -f .git/logs/refs/heads/e1/r2 &&
+	test -f .git/logs/HEAD
+'
+
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
-- 
2.7.0
