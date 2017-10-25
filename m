Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB5B202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 09:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbdJYJxf (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 05:53:35 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56802 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932402AbdJYJxc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2017 05:53:32 -0400
X-AuditID: 12074412-1fdff7000000748d-aa-59f05f1baf36
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id DF.34.29837.B1F50F95; Wed, 25 Oct 2017 05:53:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC93E.dip0.t-ipconnect.de [87.188.201.62])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9P9rPQa025997
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 25 Oct 2017 05:53:30 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] files-backend: don't rewrite the `packed-refs` file unnecessarily
Date:   Wed, 25 Oct 2017 11:53:21 +0200
Message-Id: <4c03fc458f619a5f02dd4cae38da8b9b139b850b.1508924577.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1508924577.git.mhagger@alum.mit.edu>
References: <cover.1508924577.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqCsd/yHS4NcHXouuK91MFg29V5gt
        bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFJdNSmpOZllqkb5dAlfGjVdbmQoO
        61csPXGOpYGxVa2LkZNDQsBEYu/6uaxdjFwcQgI7mCRurF3ADpIQEjjJJLFnUyKIzSagK7Go
        p5kJxBYRUJOY2HaIBcRmFkiR6HjezQhiCwuESaxZ3wlmswioSty52wE0h4ODVyBK4uI8Lohd
        8hLnHtxmBrE5BSwkvu+8xAixylzi0oFVrBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st
        0jXTy80s0UtNKd3ECAkRoR2M60/KHWIU4GBU4uEVmP4+Uog1say4MvcQoyQHk5Iob7jHh0gh
        vqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrztsUA53pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZ
        qakFqUUwWRkODiUJXpM4oEbBotT01Iq0zJwShDQTByfIcB6g4SfAhhcXJOYWZ6ZD5E8xGnN0
        3Lz7h4nj2czXDcxCLHn5ealS4rxZIOMEQEozSvPgpsHi/BWjONBzwry7QAbyAFME3LxXQKuY
        gFY1qYKtKklESEk1MHKrpMuKiMRv7ZopUc1qkCm0e870O+XWdjsPbTlUJJsQ/ipaLUpW5v/f
        JM3OX0Vq3u+0Cj0D1ij6dQrGZJ3/Wp/pWT/5xeTdtbtjwn5uemq24+e0WWdXWWfrJapwzzV5
        +3Z+SukR/jBFpRdfvfKeHHPLPXAhUEJ7hd4N94cX+mITnKeldNccVGIpzkg01GIuKk4EAHmS
        C7nOAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even when we are deleting references, we needn't overwrite the
`packed-refs` file if the references that we are deleting are not
present in that file. Implement this optimization as follows:

* Add a function `is_packed_transaction_noop()`, which checks whether
  a given packed-refs transaction doesn't actually have to do
  anything. This function must be called while holding the
  `packed-refs` lock to avoid races.

* Change `files_transaction_prepare()` to check whether the
  packed-refs transaction is unneeded. If so, squelch it, but continue
  holding the `packed-refs` lock until the end of the transaction to
  avoid races.

This fixes two tests in t1409.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c          | 18 +++++++++++-
 refs/packed-backend.c         | 68 +++++++++++++++++++++++++++++++++++++++++++
 refs/packed-backend.h         |  8 +++++
 t/t1409-avoid-packing-refs.sh |  4 +--
 4 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 014dabb0bf..5689e3a58d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2605,7 +2605,23 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			goto cleanup;
 		}
 		backend_data->packed_refs_locked = 1;
-		ret = ref_transaction_prepare(packed_transaction, err);
+
+		if (is_packed_transaction_noop(refs->packed_ref_store,
+					       packed_transaction)) {
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
+		} else {
+			ret = ref_transaction_prepare(packed_transaction, err);
+		}
 	}
 
 cleanup:
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3279d42c5a..064b1b58a2 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1261,6 +1261,74 @@ static int write_with_updates(struct packed_ref_store *refs,
 	return -1;
 }
 
+int is_packed_transaction_noop(struct ref_store *ref_store,
+			       struct ref_transaction *transaction)
+{
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ,
+			"is_packed_transaction_noop");
+	struct strbuf referent = STRBUF_INIT;
+	size_t i;
+	int ret;
+
+	if (!is_lock_file_locked(&refs->lock))
+		BUG("is_packed_transaction_noop() called while unlocked");
+
+	/*
+	 * We're only going to bother returning true for the common,
+	 * trivial case that references are only being deleted, their
+	 * old values are not being checked, and the old `packed-refs`
+	 * file doesn't contain any of those reference(s). More
+	 * complicated cases (1) are unlikely to be able to be
+	 * optimized away anyway, and (2) are more expensive to check.
+	 * Start with cheap checks:
+	 */
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		if (update->flags & REF_HAVE_OLD)
+			/* Have to check the old value -> not a NOOP. */
+			return 0;
+
+		if ((update->flags & REF_HAVE_NEW) && !is_null_oid(&update->new_oid))
+			/* Have to set a new value -> not a NOOP. */
+			return 0;
+	}
+
+	/*
+	 * The transaction isn't checking any old values nor is it
+	 * setting any nonzero new values, so it still might be a
+	 * NOOP. Now do the more expensive check: the update is not a
+	 * NOOP if one of the updates is a delete, and the old
+	 * `packed-refs` file contains a value for that reference.
+	 */
+	ret = 1;
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		unsigned int type;
+		struct object_id oid;
+
+		if (!(update->flags & REF_HAVE_NEW))
+			/* This reference isn't being deleted -> NOOP. */
+			continue;
+
+		if (!refs_read_raw_ref(ref_store, update->refname,
+				       oid.hash, &referent, &type) ||
+		    errno != ENOENT) {
+			/*
+			 * We might have to actually delete that
+			 * reference -> not a NOOP.
+			 */
+			ret = 0;
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
index 61687e408a..0b8b2b9695 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -23,4 +23,12 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 void packed_refs_unlock(struct ref_store *ref_store);
 int packed_refs_is_locked(struct ref_store *ref_store);
 
+/*
+ * Return true if `transaction` is an obvious NOOP with respect to the
+ * specified packed_ref_store. `ref_store` must be locked before
+ * calling this function.
+ */
+int is_packed_transaction_noop(struct ref_store *ref_store,
+			       struct ref_transaction *transaction);
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

