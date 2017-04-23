Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6346F207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046246AbdDWVhf (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:37:35 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37448 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046148AbdDWVf4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 43425280D1;
        Sun, 23 Apr 2017 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983340;
        bh=GupUf11LlBvkZqu7iq6DtZ0Djm5//ofrywh4uwPz3Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4FJH6J0BeiMc2LeCUUogh7xAKt5tutUNEhx9wmvZ2vyQErV6bkLNMXdyPEGuXvkY
         sYifGkVwS80+oXAjKlohWRTXacHnRm2yUTMZ3q6Y/dSlKSiUXo4lz8WlmcYtdo2fqz
         wG6t2FcRVEPh7QOVFsNnP3fIT5Bxg6cfz+ce7KtbPudPEsk4FXUtIK1401OUumCqq9
         1jGnlcEF0SEiwUvIfOllH4/LC+D1vkR3m+0tqkH+2CP6BL2G/u7KWQrZeS8h0cqWJm
         X9hdiKkwYuIAjX8EWTi9DtFB6sBsGxJcLE2RaynZGZ4CO0PewXHKSrvHZxKhoKh+Hx
         8uIeLbikd2JOFb7+y08koPKtFXfqZ+HeWBxsSEPHESqMhzJtPTUnbWthmDaE+A4OKD
         vXrQ2FZ2OK5UoT66r2m31c7JuHhAa8QtldtYn9B2pQyIAkTKBeQ1d5GpjPSmMOAgq/
         PJVhb343Rr+6NtsFOPQdCbVhg6SzI9mynEMsCuET5uSpB99Jf2c
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 38/53] refs: convert struct ref_update to use struct object_id
Date:   Sun, 23 Apr 2017 21:34:38 +0000
Message-Id: <20170423213453.253425-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct ref_array_item to use struct object_id by changing the
definition and applying the following semantic patch, plus the standard
object_id transforms:

@@
struct ref_update E1;
@@
- E1.new_sha1
+ E1.new_oid.hash

@@
struct ref_update *E1;
@@
- E1->new_sha1
+ E1->new_oid.hash

@@
struct ref_update E1;
@@
- E1.old_sha1
+ E1.old_oid.hash

@@
struct ref_update *E1;
@@
- E1->old_sha1
+ E1->old_oid.hash

This transformation allows us to convert write_ref_to_lockfile, which is
required to convert parse_object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c               |  4 ++--
 refs/files-backend.c | 29 +++++++++++++++--------------
 refs/refs-internal.h |  4 ++--
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index d1e1b4399..f76c42081 100644
--- a/refs.c
+++ b/refs.c
@@ -881,9 +881,9 @@ struct ref_update *ref_transaction_add_update(
 	update->flags = flags;
 
 	if (flags & REF_HAVE_NEW)
-		hashcpy(update->new_sha1, new_sha1);
+		hashcpy(update->new_oid.hash, new_sha1);
 	if (flags & REF_HAVE_OLD)
-		hashcpy(update->old_sha1, old_sha1);
+		hashcpy(update->old_oid.hash, old_sha1);
 	update->msg = xstrdup_or_null(msg);
 	return update;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 238a046e6..ccabf761e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3549,7 +3549,7 @@ static int split_head_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NODEREF,
-			update->new_sha1, update->old_sha1,
+			update->new_oid.hash, update->old_oid.hash,
 			update->msg);
 
 	item->util = new_update;
@@ -3606,7 +3606,7 @@ static int split_symref_update(struct files_ref_store *refs,
 
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
-			update->new_sha1, update->old_sha1,
+			update->new_oid.hash, update->old_oid.hash,
 			update->msg);
 
 	new_update->parent_update = update;
@@ -3645,10 +3645,10 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 			 struct strbuf *err)
 {
 	if (!(update->flags & REF_HAVE_OLD) ||
-		   !hashcmp(oid->hash, update->old_sha1))
+		   !oidcmp(oid, &update->old_oid))
 		return 0;
 
-	if (is_null_sha1(update->old_sha1))
+	if (is_null_oid(&update->old_oid))
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
 			    original_update_refname(update));
@@ -3656,13 +3656,13 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference is missing but expected %s",
 			    original_update_refname(update),
-			    sha1_to_hex(update->old_sha1));
+			    oid_to_hex(&update->old_oid));
 	else
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "is at %s but expected %s",
 			    original_update_refname(update),
 			    oid_to_hex(oid),
-			    sha1_to_hex(update->old_sha1));
+			    oid_to_hex(&update->old_oid));
 
 	return -1;
 }
@@ -3689,13 +3689,13 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 {
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
-		!is_null_sha1(update->old_sha1);
+		!is_null_oid(&update->old_oid);
 	int ret;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
-	if ((update->flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
+	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
@@ -3777,12 +3777,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	    !(update->flags & REF_DELETING) &&
 	    !(update->flags & REF_LOG_ONLY)) {
 		if (!(update->type & REF_ISSYMREF) &&
-		    !hashcmp(lock->old_oid.hash, update->new_sha1)) {
+		    !oidcmp(&lock->old_oid, &update->new_oid)) {
 			/*
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(lock, update->new_sha1,
+		} else if (write_ref_to_lockfile(lock, update->new_oid.hash,
 						 err)) {
 			char *write_err = strbuf_detach(err, NULL);
 
@@ -3918,7 +3918,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			if (files_log_ref_write(refs,
 						lock->ref_name,
 						lock->old_oid.hash,
-						update->new_sha1,
+						update->new_oid.hash,
 						update->msg, update->flags,
 						err)) {
 				char *old_msg = strbuf_detach(err, NULL);
@@ -4067,7 +4067,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 
 		if ((update->flags & REF_HAVE_OLD) &&
-		    !is_null_sha1(update->old_sha1))
+		    !is_null_oid(&update->old_oid))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (refs_verify_refname_available(&refs->base, update->refname,
 						  &affected_refnames, NULL,
@@ -4088,8 +4088,9 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !is_null_sha1(update->new_sha1))
-			add_packed_ref(refs, update->refname, update->new_sha1);
+		    !is_null_oid(&update->new_oid))
+			add_packed_ref(refs, update->refname,
+				       update->new_oid.hash);
 	}
 
 	if (commit_packed_refs(refs)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 690498698..72a4a49fb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -130,13 +130,13 @@ struct ref_update {
 	/*
 	 * If (flags & REF_HAVE_NEW), set the reference to this value:
 	 */
-	unsigned char new_sha1[20];
+	struct object_id new_oid;
 
 	/*
 	 * If (flags & REF_HAVE_OLD), check that the reference
 	 * previously had this value:
 	 */
-	unsigned char old_sha1[20];
+	struct object_id old_oid;
 
 	/*
 	 * One or more of REF_HAVE_NEW, REF_HAVE_OLD, REF_NODEREF,
