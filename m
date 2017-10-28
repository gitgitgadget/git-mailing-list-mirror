Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F401202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdJ1JQT (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:16:19 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46960 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751326AbdJ1JQO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:16:14 -0400
X-AuditID: 12074413-38bff70000007929-96-59f44adcfbec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.F6.31017.CDA44F95; Sat, 28 Oct 2017 05:16:12 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9G5TG015456
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:16:10 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/2] files-backend: don't rewrite the `packed-refs` file unnecessarily
Date:   Sat, 28 Oct 2017 11:16:02 +0200
Message-Id: <6004e1dea6af33cb41c523855757aa6b04b912bc.1509181545.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509181545.git.mhagger@alum.mit.edu>
References: <cover.1509181545.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqHvH60ukwflrahZdV7qZLBp6rzBb
        3F4xn9niR0sPs8WZN42MDqwef99/YPJ41ruH0ePiJWWPxQ+8PD5vkgtgjeKySUnNySxLLdK3
        S+DKuLrvIUvBHseKTfOeMjUwzjHpYuTkkBAwkbhwvoOpi5GLQ0hgB5PEto4VbBDOKSaJx7dP
        sYNUsQnoSizqaWYCsUUE1CQmth1iASliFuhllHi0+BUjSEJYIFJi1qpNrCA2i4CqxNIPE9lA
        bF6BKIlPLQvYIdbJS5x7cJsZxOYUsJBY1zafBcQWEjCXaJx/jGUCI88CRoZVjHKJOaW5urmJ
        mTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCGhI7yDcddJuUOMAhyMSjy8ErmfI4VYE8uKK3MP
        MUpyMCmJ8u47/ylSiC8pP6UyI7E4I76oNCe1+BCjBAezkghvnvOXSCHelMTKqtSifJiUNAeL
        kjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgQvLzBGhASLUtNTK9Iyc0oQ0kwcnCDDeYCG//YE
        GV5ckJhbnJkOkT/FaMzRcfPuHyaOZzNfNzALseTl56VKifPuBSkVACnNKM2DmwaL/1eM4kDP
        CfP6gyzlAaYOuHmvgFYxAa3SkARbVZKIkJJqYEwzTfrllx5RIH009JRS6vTuzle1e58/5yq+
        /nTpGun7LFM+LzHMZMlalZOokLJcTXDzn5qi3GmLpqe+Yc2oC7L1eNl8NGwdU4mLu0VbUamz
        iPq/jAX/NBrUJPZJH5mjqOQposm3vePknGVb1E1tdx59cOz65TX28UwXJpQ9CX18eefOgEyX
        I0osxRmJhlrMRcWJALUvyITaAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even when we are deleting references, we needn't overwrite the
`packed-refs` file if the references that we are deleting only exist
as loose references. Implement this optimization as follows:

* Add a function `is_packed_transaction_needed()`, which checks
  whether a given packed-refs transaction actually needs to be carried
  out (i.e., it returns false if the transaction obviously wouldn't
  have any effect). This function must be called while holding the
  `packed-refs` lock to avoid races.

* Change `files_transaction_prepare()` to check whether the
  packed-refs transaction is actually needed. If not, squelch it, but
  continue holding the `packed-refs` lock until the end of the
  transaction to avoid races.

This fixes a mild regression caused by dc39e09942 (files_ref_store:
use a transaction to update packed refs, 2017-09-08). Before that
commit, unnecessary rewrites of `packed-refs` were suppressed by
`repack_without_refs()`. But the transaction-based writing introduced
by that commit didn't perform that optimization.

Note that the pre-dc39e09942 code still had to *read* the whole
`packed-refs` file to determine that the rewrite could be skipped, so
the performance for the cases that the write could be elided was
`O(N)` in the number of packed references both before and after
dc39e09942. But after that commit the constant factor increased.

This commit reimplements the optimization of eliding unnecessary
`packed-refs` rewrites. That, plus the fact that since
cfa2e29c34 (packed_ref_store: get rid of the `ref_cache` entirely,
2017-03-17) we don't necessarily have to read the whole `packed-refs`
file at all, means that deletes of one or a few loose references can
now be done with `O(n lg N)` effort, where `n` is the number of loose
references being deleted and `N` is the total number of packed
references.

This commit fixes two tests in t1409.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c          | 18 ++++++++-
 refs/packed-backend.c         | 94 +++++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.h         |  9 +++++
 t/t1409-avoid-packing-refs.sh |  4 +-
 4 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 961424a4ea..da8a986697 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2562,7 +2562,23 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			goto cleanup;
 		}
 		backend_data->packed_refs_locked = 1;
-		ret = ref_transaction_prepare(packed_transaction, err);
+
+		if (is_packed_transaction_needed(refs->packed_ref_store,
+						 packed_transaction)) {
+			ret = ref_transaction_prepare(packed_transaction, err);
+		} else {
+			/*
+			 * We can skip rewriting the `packed-refs`
+			 * file. But we do need to leave it locked, so
+			 * that somebody else doesn't pack a reference
+			 * that we are trying to delete.
+			 */
+			if (ref_transaction_abort(packed_transaction, err)) {
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto cleanup;
+			}
+			backend_data->packed_transaction = NULL;
+		}
 	}
 
 cleanup:
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 0279aeceea..0b0a17ca8e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -754,6 +754,100 @@ static int write_with_updates(struct packed_ref_store *refs,
 	return -1;
 }
 
+int is_packed_transaction_needed(struct ref_store *ref_store,
+				 struct ref_transaction *transaction)
+{
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ,
+			"is_packed_transaction_needed");
+	struct strbuf referent = STRBUF_INIT;
+	size_t i;
+	int ret;
+
+	if (!is_lock_file_locked(&refs->lock))
+		BUG("is_packed_transaction_needed() called while unlocked");
+
+	/*
+	 * We're only going to bother returning false for the common,
+	 * trivial case that references are only being deleted, their
+	 * old values are not being checked, and the old `packed-refs`
+	 * file doesn't contain any of those reference(s). This gives
+	 * false positives for some other cases that could
+	 * theoretically be optimized away:
+	 *
+	 * 1. It could be that the old value is being verified without
+	 *    setting a new value. In this case, we could verify the
+	 *    old value here and skip the update if it agrees. If it
+	 *    disagrees, we could either let the update go through
+	 *    (the actual commit would re-detect and report the
+	 *    problem), or come up with a way of reporting such an
+	 *    error to *our* caller.
+	 *
+	 * 2. It could be that a new value is being set, but that it
+	 *    is identical to the current packed value of the
+	 *    reference.
+	 *
+	 * Neither of these cases will come up in the current code,
+	 * because the only caller of this function passes to it a
+	 * transaction that only includes `delete` updates with no
+	 * `old_id`. Even if that ever changes, false positives only
+	 * cause an optimization to be missed; they do not affect
+	 * correctness.
+	 */
+
+	/*
+	 * Start with the cheap checks that don't require old
+	 * reference values to be read:
+	 */
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		if (update->flags & REF_HAVE_OLD)
+			/* Have to check the old value -> needed. */
+			return 1;
+
+		if ((update->flags & REF_HAVE_NEW) && !is_null_oid(&update->new_oid))
+			/* Have to set a new value -> needed. */
+			return 1;
+	}
+
+	/*
+	 * The transaction isn't checking any old values nor is it
+	 * setting any nonzero new values, so it still might be able
+	 * to be skipped. Now do the more expensive check: the update
+	 * is needed if any of the updates is a delete, and the old
+	 * `packed-refs` file contains a value for that reference.
+	 */
+	ret = 0;
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		unsigned int type;
+		struct object_id oid;
+
+		if (!(update->flags & REF_HAVE_NEW))
+			/*
+			 * This reference isn't being deleted -> not
+			 * needed.
+			 */
+			continue;
+
+		if (!refs_read_raw_ref(ref_store, update->refname,
+				       oid.hash, &referent, &type) ||
+		    errno != ENOENT) {
+			/*
+			 * We have to actually delete that reference
+			 * -> this transaction is needed.
+			 */
+			ret = 1;
+			break;
+		}
+	}
+
+	strbuf_release(&referent);
+	return ret;
+}
+
 struct packed_transaction_backend_data {
 	/* True iff the transaction owns the packed-refs lock. */
 	int own_lock;
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 61687e408a..640245d3b9 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -23,4 +23,13 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 void packed_refs_unlock(struct ref_store *ref_store);
 int packed_refs_is_locked(struct ref_store *ref_store);
 
+/*
+ * Return true if `transaction` really needs to be carried out against
+ * the specified packed_ref_store, or false if it can be skipped
+ * (i.e., because it is an obvious NOOP). `ref_store` must be locked
+ * before calling this function.
+ */
+int is_packed_transaction_needed(struct ref_store *ref_store,
+				 struct ref_transaction *transaction);
+
 #endif /* REFS_PACKED_BACKEND_H */
diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index a2397c7b71..e5cb8a252d 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup' '
 	C=$(git rev-parse HEAD)
 '
 
-test_expect_failure 'do not create packed-refs file gratuitously' '
+test_expect_success 'do not create packed-refs file gratuitously' '
 	test_must_fail test -f .git/packed-refs &&
 	git update-ref refs/heads/foo $A &&
 	test_must_fail test -f .git/packed-refs &&
@@ -107,7 +107,7 @@ test_expect_success 'leave packed-refs untouched on verify of loose' '
 	check_packed_refs_marked
 '
 
-test_expect_failure 'leave packed-refs untouched on delete of loose' '
+test_expect_success 'leave packed-refs untouched on delete of loose' '
 	git pack-refs --all &&
 	git update-ref refs/heads/loose-delete $A &&
 	mark_packed_refs &&
-- 
2.14.1

