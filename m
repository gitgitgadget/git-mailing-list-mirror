Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F5F20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbdJAWJP (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54202 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752193AbdJAWJN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0B99660DC4;
        Sun,  1 Oct 2017 22:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895751;
        bh=HgotlBnn57s0vfbi9ReFhoT5MM2gL/fDZhXscGW5R6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e774HV1WZBmogHt7SWsNM7X7jLY57fWguxH6XlBGJq2VO2HWFUa4HPuCL84Gua9Q3
         soInsdM9pQTyxPi1LTdC84UwgvzTfGalt20kfC48RZE59ORfGIjwcgCXg19u5iYdkC
         SGmfSXhK7T32o6drpk6nJIi0Y5cjlCtgbW6fo88Ah+1rkyksfKFsQ+DilpJMc2Wdl6
         tdGcBXRT62E1unoGkhBbj3qk3apGEx0N4AkMqq1Qy8fw5KJssChSohxjKWxtz2GujF
         O0B9IDAIHZHGWxAoAJGfS+UbFZUjnkoMkbbTaG4zO3EA6FgR9eq8fDClAbU/o62YQl
         sdoiJPdisfJkHmZo+RVeraGzVpNCnVGOC5aXoLgAvInWiKRMGXqzVUEt57mtVGcc+f
         cQ3YaQzVm6MdTfo4u2XHqgeaAqGCNQ3uxRPd+QdBaFCdukejXyqxMxvQ059sdkPsfu
         4TmHVN4lpL+RFfTAN3bBxtT/gKZs/L25K6/8EnF31rCJ2pNbJdh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 24/24] refs/files-backend: convert static functions to object_id
Date:   Sun,  1 Oct 2017 22:08:31 +0000
Message-Id: <20171001220831.214705-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several static functions to take pointers to struct object_id.
Change the relevant parameters to write_packed_entry to be const, as we
don't modify them.  Rename lock_ref_sha1_basic to lock_ref_oid_basic to
reflect its new argument.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/files-backend.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7281f27f62..84d8e3da99 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -811,7 +811,7 @@ static struct ref_iterator *files_ref_iterator_begin(
  * return a negative value.
  */
 static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
-		       const unsigned char *old_sha1, int mustexist,
+		       const struct object_id *old_oid, int mustexist,
 		       struct strbuf *err)
 {
 	assert(err);
@@ -819,7 +819,7 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 	if (refs_read_ref_full(ref_store, lock->ref_name,
 			       mustexist ? RESOLVE_REF_READING : 0,
 			       &lock->old_oid, NULL)) {
-		if (old_sha1) {
+		if (old_oid) {
 			int save_errno = errno;
 			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
 			errno = save_errno;
@@ -829,11 +829,11 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
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
@@ -863,22 +863,22 @@ static int create_reflock(const char *path, void *cb)
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
@@ -944,7 +944,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (verify_lock(&refs->base, lock, old_sha1, mustexist, err)) {
+	if (verify_lock(&refs->base, lock, old_oid, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
 	}
@@ -1349,8 +1349,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(refs, newrefname, NULL, NULL, NULL,
-				   REF_NODEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, NULL,
+				  REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -1369,8 +1369,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_sha1_basic(refs, oldrefname, NULL, NULL, NULL,
-				   REF_NODEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, NULL,
+				  REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1769,9 +1769,9 @@ static int files_create_symref(struct ref_store *ref_store,
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
@@ -2943,9 +2943,9 @@ static int files_reflog_expire(struct ref_store *ref_store,
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
2.14.2.822.g60be5d43e6

