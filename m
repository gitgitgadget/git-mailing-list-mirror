Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829F0207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754990AbdEFWMz (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:55 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37852 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754152AbdEFWLd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D9F5C280D3;
        Sat,  6 May 2017 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108675;
        bh=AFzfFLarjxqphw09fife5OBSNaARhxG+QEqg5vEdaK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF/BhbAY8v0gUUP69WVLBeI968j4VZWmFnUUSgRleOarvHBNIC1GXidTFBHbgaQw4
         heL+SGGQBomQeD7exU0laTQqJMXLF0nOr5zRCg849AzGiL3treM6kpopClDPKutTEH
         7ZOssAuiPz63bkEGw9SeGRXuSbJ3HEs1LrW+MPuzwFbK+0vfpwlka9KXNuMR/UgUnO
         u06WHLcbC6mgZI2oh6z17QXoZrrMMgO5YgYSNuxtuoUkA3seOFc7ktb8aaOyFRanUd
         FRrKaV2MJHnfs0AZameE5i4i8sxOA/4c3b70ld4J9PWvwmAM1VboWSc6Lp4tek1k2q
         UfaeHSKOSYxsFA9N/ddCRsrGbZl0Hu2r/lqw3OAnBW+oOsyg8IT+supuan0IBClfxV
         bwqdZhFBGRu9jGZsO/g3ceGQN/MUn6yM+oK4SJMoqzdeK5CjPlYSNz6iUgpqKT5/4k
         dmsWFIH4MBCWS3MlelQHgxR+vGQO+eptoHY85P6CYko+wv+etT8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 38/53] refs: convert struct ref_update to use struct object_id
Date:   Sat,  6 May 2017 22:10:23 +0000
Message-Id: <20170506221038.296722-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
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
index df75f8e0d..c738f5911 100644
--- a/refs.c
+++ b/refs.c
@@ -882,9 +882,9 @@ struct ref_update *ref_transaction_add_update(
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
index 298a838c5..413505ff0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2633,7 +2633,7 @@ static int split_head_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NODEREF,
-			update->new_sha1, update->old_sha1,
+			update->new_oid.hash, update->old_oid.hash,
 			update->msg);
 
 	item->util = new_update;
@@ -2690,7 +2690,7 @@ static int split_symref_update(struct files_ref_store *refs,
 
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
-			update->new_sha1, update->old_sha1,
+			update->new_oid.hash, update->old_oid.hash,
 			update->msg);
 
 	new_update->parent_update = update;
@@ -2729,10 +2729,10 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
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
@@ -2740,13 +2740,13 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
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
@@ -2773,13 +2773,13 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2861,12 +2861,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
 
@@ -3002,7 +3002,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			if (files_log_ref_write(refs,
 						lock->ref_name,
 						lock->old_oid.hash,
-						update->new_sha1,
+						update->new_oid.hash,
 						update->msg, update->flags,
 						err)) {
 				char *old_msg = strbuf_detach(err, NULL);
@@ -3151,7 +3151,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 
 		if ((update->flags & REF_HAVE_OLD) &&
-		    !is_null_sha1(update->old_sha1))
+		    !is_null_oid(&update->old_oid))
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (refs_verify_refname_available(&refs->base, update->refname,
 						  &affected_refnames, NULL,
@@ -3172,8 +3172,9 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
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
index 3d46131ef..b267d5ca9 100644
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
