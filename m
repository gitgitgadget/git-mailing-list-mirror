Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4258B20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbdJOWIL (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:08:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55176 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751733AbdJOWIF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:08:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6ECC360468;
        Sun, 15 Oct 2017 22:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105284;
        bh=q1yDc8PcwGwPKoM9b+dG+WM1gR3+eqQvq55MqoasoHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WO5BbM/lAnJMGfnZ2uLGK6Q6DVojFlpaHlEoMLMR/wQ7rMuRmH5qeQipkSsbk+AFn
         2hpaGrapcsGI8XvMLxMtdJkuH3fJi4LhYHR2KFcI3P38fGmtwwQcH4ScK0bEZFePxY
         U0ZigykYhIO5AQF9GlU4GBUh8WBvxW1LyTekeua1nYIXXSwnbVd7QeEL5CXZPAT37t
         +ZmFy4ed1cCjSz4ERZzWuLoMStL7uu5+D6eUtLHprUi/wXpHNpdakMNBrlNoFycRKf
         xS1Zm4Ykxapn0Gbanvy30u+v8Fx+UVseViCt8tVlpYnSWQchL7X2Rf7i4eDaIMUID2
         RjKzshrxHBxRKGCzyXTiYE1B9Qe5xYIP8/WWPKVzeT7f7qqaIVBpBnndMMLuQK3aK/
         CBRfwFtj1hk8Rhktnl5IA372osRCw0vc1rTMn99K3GwazTzcEJrDpRzb/IseH7lQuU
         6l3pebbQwshmfoRIjTYbmE3BIGNCKIZ/ypVsjOMGu+Ect/XGAD3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 25/25] refs/files-backend: convert static functions to object_id
Date:   Sun, 15 Oct 2017 22:07:12 +0000
Message-Id: <20171015220712.97308-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several static functions to take pointers to struct object_id.
Change the relevant parameters to write_packed_entry to be const, as we
don't modify them.  Rename lock_ref_sha1_basic to lock_ref_oid_basic to
reflect its new argument.  Update the docstring for verify lock to
account for the new parameter name, and note additionally that the
old_oid may be NULL.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/files-backend.c | 56 ++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c1626490c2..b7b9e767de 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -770,13 +770,13 @@ static struct ref_iterator *files_ref_iterator_begin(
 }
 
 /*
- * Verify that the reference locked by lock has the value old_sha1.
- * Fail if the reference doesn't exist and mustexist is set. Return 0
- * on success. On error, write an error message to err, set errno, and
- * return a negative value.
+ * Verify that the reference locked by lock has the value old_oid
+ * (unless it is NULL).  Fail if the reference doesn't exist and
+ * mustexist is set. Return 0 on success. On error, write an error
+ * message to err, set errno, and return a negative value.
  */
 static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
-		       const unsigned char *old_sha1, int mustexist,
+		       const struct object_id *old_oid, int mustexist,
 		       struct strbuf *err)
 {
 	assert(err);
@@ -784,7 +784,7 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 	if (refs_read_ref_full(ref_store, lock->ref_name,
 			       mustexist ? RESOLVE_REF_READING : 0,
 			       &lock->old_oid, NULL)) {
-		if (old_sha1) {
+		if (old_oid) {
 			int save_errno = errno;
 			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
 			errno = save_errno;
@@ -794,11 +794,11 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 			return 0;
 		}
 	}
-	if (old_sha1 && hashcmp(lock->old_oid.hash, old_sha1)) {
+	if (old_oid && oidcmp(&lock->old_oid, old_oid)) {
 		strbuf_addf(err, "ref '%s' is at %s but expected %s",
 			    lock->ref_name,
 			    oid_to_hex(&lock->old_oid),
-			    sha1_to_hex(old_sha1));
+			    oid_to_hex(old_oid));
 		errno = EBUSY;
 		return -1;
 	}
@@ -828,22 +828,22 @@ static int create_reflock(const char *path, void *cb)
  * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
  */
-static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
-					    const char *refname,
-					    const unsigned char *old_sha1,
-					    const struct string_list *extras,
-					    const struct string_list *skip,
-					    unsigned int flags, int *type,
-					    struct strbuf *err)
+static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
+					   const char *refname,
+					   const struct object_id *old_oid,
+					   const struct string_list *extras,
+					   const struct string_list *skip,
+					   unsigned int flags, int *type,
+					   struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
+	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
 
-	files_assert_main_repository(refs, "lock_ref_sha1_basic");
+	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -909,7 +909,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (verify_lock(&refs->base, lock, old_sha1, mustexist, err)) {
+	if (verify_lock(&refs->base, lock, old_oid, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
 	}
@@ -1324,8 +1324,8 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(refs, newrefname, NULL, NULL, NULL,
-				   REF_NODEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, NULL,
+				  REF_NODEREF, NULL, &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1347,8 +1347,8 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_sha1_basic(refs, oldrefname, NULL, NULL, NULL,
-				   REF_NODEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, NULL,
+				  REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1763,9 +1763,9 @@ static int files_create_symref(struct ref_store *ref_store,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_sha1_basic(refs, refname, NULL,
-				   NULL, NULL, REF_NODEREF, NULL,
-				   &err);
+	lock = lock_ref_oid_basic(refs, refname, NULL,
+				  NULL, NULL, REF_NODEREF, NULL,
+				  &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -2937,9 +2937,9 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refs, refname, oid->hash,
-				   NULL, NULL, REF_NODEREF,
-				   &type, &err);
+	lock = lock_ref_oid_basic(refs, refname, oid,
+				  NULL, NULL, REF_NODEREF,
+				  &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
-- 
2.15.0.rc0.271.g36b669edcc

