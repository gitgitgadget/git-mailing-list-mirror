Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6C6B2070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbcLaDNr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:47 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47948 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754692AbcLaDNl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:41 -0500
X-AuditID: 1207440e-7dfff700000009ec-36-58672263a49b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B3.C9.02540.36227685; Fri, 30 Dec 2016 22:13:39 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6uH010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:38 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 23/23] files_transaction_commit(): clean up empty directories
Date:   Sat, 31 Dec 2016 04:13:03 +0100
Message-Id: <732e8a06acd424f718add206214515919b107ebc.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsUixO6iqJuslB5hsPGGhUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mo7+2sdUsEWrorGrgaWB8blSFyMnh4SAicS7cwtYuhi5OIQELjNK9DYsh3KOM0ls6vrO
        BFLFJqArsainGcwWEVCTmNh2CKyIWWAio8S0LZfAEsICARIzJv1lBrFZBFQl3p8+wN7FyMHB
        KxAlMb3bCmKbnMSlbV/ASjgFLCQWf+oDaxUSMJdYt/MS8wRGngWMDKsY5RJzSnN1cxMzc4pT
        k3WLkxPz8lKLdI31cjNL9FJTSjcxQkKHbwdj+3qZQ4wCHIxKPLwd19IihFgTy4orcw8xSnIw
        KYnyWlqmRgjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4V0olx4hxJuSWFmVWpQPk5LmYFES51Vb
        ou4nJJCeWJKanZpakFoEk5Xh4FCS4F2oCNQoWJSanlqRlplTgpBm4uAEGc4DNLwXpIa3uCAx
        tzgzHSJ/ilFRSpx3rQJQQgAkkVGaB9cLi+1XjOJArwjz7gJp5wGmBbjuV0CDmYAGq+Ukgwwu
        SURISTUw+uUJn/7P6W671vXNUzv1rZovLj471C90SOWU6OV/rGy9lZ/6HHMO2tn7nGjxMU65
        UfflqymrjYD//gBDvxhmhidCalOzfym/vGTv7m1o9Ol28qz6r+cuZAbtl1gsMct1k/u6VyFV
        7VyMZ+elqyxu0vd88JzHaYb97Jvpq7Snifd+eb+acbu6EktxRqKhFnNRcSIAbeQ8mcgCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When deleting/pruning references, remove any directories that are made
empty by the deletion of loose references or of reflogs. Otherwise such
empty directories can survive forever and accumulate over time. (Even
'pack-refs', which is smart enough to remove the parent directories of
loose references that it prunes, leaves directories that were already
empty.)

And now that files_transaction_commit() takes care of deleting the
parent directories of loose references that it prunes, we don't have to
do that in prune_ref() anymore.

This change would be unwise if the *creation* of these directories could
race with our deletion of them. But the earlier changes in this patch
series made the creation paths robust against races, so now it is safe
to tidy them up more aggressively.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  | 34 ++++++++++++++++++++++++++++------
 refs/refs-internal.h  | 11 +++++++++--
 t/t1400-update-ref.sh | 27 +++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2155acf..26cfea3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2345,7 +2345,6 @@ static void prune_ref(struct ref_to_prune *r)
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	try_remove_empty_parents(r->name, REMOVE_EMPTY_PARENTS_REF);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3792,6 +3791,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
 				}
+				update->flags |= REF_DELETED_LOOSE;
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
@@ -3804,16 +3804,38 @@ static int files_transaction_commit(struct ref_store *ref_store,
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
 	clear_loose_ref_cache(refs);
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
 
-	for (i = 0; i < transaction->nr; i++)
-		if (transaction->updates[i]->backend_data)
-			unlock_ref(transaction->updates[i]->backend_data);
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct ref_lock *lock = update->backend_data;
+
+		if (lock)
+			unlock_ref(lock);
+
+		if (update->flags & REF_DELETED_LOOSE) {
+			/*
+			 * The loose reference was deleted. Delete any
+			 * empty parent directories. (Note that this
+			 * can only work because we have already
+			 * removed the lockfile.)
+			 */
+			try_remove_empty_parents(update->refname,
+						 REMOVE_EMPTY_PARENTS_REF);
+		}
+	}
+
 	string_list_clear(&refs_to_delete, 0);
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 708b260..de49362 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -56,6 +56,12 @@
 #define REF_UPDATE_VIA_HEAD 0x100
 
 /*
+ * Used as a flag in ref_update::flags when the loose reference has
+ * been deleted.
+ */
+#define REF_DELETED_LOOSE 0x200
+
+/*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
  * example by causing a file that is not a reference to be deleted.
@@ -157,8 +163,9 @@ struct ref_update {
 
 	/*
 	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
-	 * REF_DELETING, REF_ISPRUNING, REF_LOG_ONLY, and
-	 * REF_UPDATE_VIA_HEAD:
+	 * REF_DELETING, REF_ISPRUNING, REF_LOG_ONLY,
+	 * REF_UPDATE_VIA_HEAD, REF_NEEDS_COMMIT, and
+	 * REF_DELETED_LOOSE:
 	 */
 	unsigned int flags;
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d4fb977..97d8793 100755
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
2.9.3

