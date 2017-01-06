Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6714E1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967502AbdAFQXv (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:51 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48260 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966898AbdAFQXl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:41 -0500
X-AuditID: 12074414-78bff70000004a85-f8-586fc483d5f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 09.EF.19077.384CF685; Fri,  6 Jan 2017 11:23:31 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmXD023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:30 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 23/23] files_transaction_commit(): clean up empty directories
Date:   Fri,  6 Jan 2017 17:22:43 +0100
Message-Id: <dc7ea83d82cbdfe2693d5dc2eb3d5275a96a665f.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqNtyJD/CoLOH2aLrSjeTRUPvFWaL
        3Yv7mS1ur5jPbLHk4Wtmix8tQNnOqbIO7B5/339g8tg56y67x/Kl6xg9utqPsHk8693D6HHx
        krLH501yAexRXDYpqTmZZalF+nYJXBlrFwUUbNGq6Nl9ga2B8blSFyMHh4SAicT7Bw5djFwc
        QgKXGSV23prB2MXICeScYJJ4fF8UxGYT0JVY1NPMBGKLCKhJTGw7xALSwCzwgVHiV+csdpCE
        sECAxMVp61hAbBYBVYndx56AxXkFoiTe3p8JNlRCQE7i0rYvzCA2p4CFROOub1DLzCU+TTzM
        PIGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkOAS2cF45KTcIUYB
        DkYlHt4Ir7wIIdbEsuLK3EOMkhxMSqK8YY75EUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeO0O
        AeV4UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4Gw8DNQoWpaanVqRl
        5pQgpJk4OEGG8wAN7wCp4S0uSMwtzkyHyJ9iVJQS590CslUAJJFRmgfXC4v+V4ziQK8I8/aA
        tPMAEwdc9yugwUxAgwU9wQaXJCKkpBoYQzae2FXjrrKIWfXqio2eHwo3XbLyLVjxiSfNaPe3
        H0HXwmZO3dO+g30Hm0QdE+ebWa//LLOJKXSXfDxLLYjVx3FKcBfTnnjGnyfsK7blqZxhuptY
        m7nj+zKupbbzr782q6x3SZf+8ylQNUb/FENv6nnfmC8MId+q9B8vb1pY2lNstVj6SlWbEktx
        RqKhFnNRcSIAP5e1gtkCAAA=
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
index bce0022..c426575 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2346,7 +2346,6 @@ static void prune_ref(struct ref_to_prune *r)
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	try_remove_empty_parents(r->name, REMOVE_EMPTY_PARENTS_REF);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3794,6 +3793,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
 				}
+				update->flags |= REF_DELETED_LOOSE;
 			}
 
 			if (!(update->flags & REF_ISPRUNING))
@@ -3806,16 +3806,38 @@ static int files_transaction_commit(struct ref_store *ref_store,
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
index dc81acc..15d5a1e 100644
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
@@ -158,8 +164,9 @@ struct ref_update {
 
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

