Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C91520A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbdJAWJk (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54172 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751980AbdJAWJD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AC80C60DB1;
        Sun,  1 Oct 2017 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895742;
        bh=4dzhSBpRahvBj1zbTu6p0MfmHXZc/M7ldQd3lvqGL2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8+bj17+6BTfIu34ankZjkq9ssX728zVq7go9IWa4MjOIp27rbYUXoVF2KpUUQqoq
         3p5BtC+PKZemSsacNuGBIenA+6NeScrBlsUaOMHcWeaaT/7LAMtqVVxcZLdcSlAzrR
         KWJyp7DkDc1RFReh01j2HIdjnlhLQRhAkxRKb3+JpnTUFo0xBuOhByZ90n9pabmAMF
         bMA4u41RCq1/vpqInlp1NJOV2GPR5CFj++4wBbJ04Oe28EHltHjnhvVx8ifGDvK9bT
         +P6juydrRJDawGGgeaNAHHou/goXBfYvKsd7M0GicPfirIRizsM3xxnXAOZ5Lm5nC9
         dsoJgf4oGKWeS/p3ZskXZADOkMavuKzrmv/xnh8XFoUYy6U2HdiErJbqdteuku33o6
         zt0/Bx7YBihPUtHKiusyq0RdsWoZPfPu/HJTviNy2j58tu2BOCpOVnk3ByBfLmk7k0
         cGGBl7XyxLWXqg1oW76qdYDkZjQAm1Gk6rpGEPvNa0MPqyAM36q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 14/24] refs: convert peel_ref to struct object_id
Date:   Sun,  1 Oct 2017 22:08:21 +0000
Message-Id: <20171001220831.214705-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert peel_ref (and its corresponding backend) to struct object_id.

This transformation was done with an update to the declaration,
definition, and test helper and the following semantic patch:

@@
expression E1, E2;
@@
- peel_ref(E1, E2.hash)
+ peel_ref(E1, &E2)

@@
expression E1, E2;
@@
- peel_ref(E1, E2->hash)
+ peel_ref(E1, E2)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/describe.c        | 2 +-
 builtin/pack-objects.c    | 4 ++--
 builtin/show-ref.c        | 2 +-
 refs.c                    | 8 ++++----
 refs.h                    | 4 ++--
 refs/files-backend.c      | 8 ++++----
 refs/packed-backend.c     | 4 ++--
 refs/refs-internal.h      | 2 +-
 t/helper/test-ref-store.c | 6 +++---
 upload-pack.c             | 2 +-
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 29075dbd0f..352f8821fd 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -181,7 +181,7 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	}
 
 	/* Is it annotated? */
-	if (!peel_ref(path, peeled.hash)) {
+	if (!peel_ref(path, &peeled)) {
 		is_annotated = !!oidcmp(oid, &peeled);
 	} else {
 		oidcpy(&peeled, oid);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cde4c96f3d..a2c6029750 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -562,7 +562,7 @@ static int mark_tagged(const char *path, const struct object_id *oid, int flag,
 
 	if (entry)
 		entry->tagged = 1;
-	if (!peel_ref(path, peeled.hash)) {
+	if (!peel_ref(path, &peeled)) {
 		entry = packlist_find(&to_pack, peeled.hash, NULL);
 		if (entry)
 			entry->tagged = 1;
@@ -2371,7 +2371,7 @@ static int add_ref_tag(const char *path, const struct object_id *oid, int flag,
 	struct object_id peeled;
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
-	    !peel_ref(path, peeled.hash)    && /* peelable? */
+	    !peel_ref(path, &peeled)    && /* peelable? */
 	    packlist_find(&to_pack, peeled.hash, NULL))      /* object packed? */
 		add_tag_chain(oid);
 	return 0;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index cbb8cfc7d2..41e5e71cad 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -38,7 +38,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 	if (!deref_tags)
 		return;
 
-	if (!peel_ref(refname, peeled.hash)) {
+	if (!peel_ref(refname, &peeled)) {
 		hex = find_unique_abbrev(peeled.hash, abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
diff --git a/refs.c b/refs.c
index c158a2d107..6cbe2c1c6b 100644
--- a/refs.c
+++ b/refs.c
@@ -1676,14 +1676,14 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags)
 }
 
 int refs_peel_ref(struct ref_store *refs, const char *refname,
-		  unsigned char *sha1)
+		  struct object_id *oid)
 {
-	return refs->be->peel_ref(refs, refname, sha1);
+	return refs->be->peel_ref(refs, refname, oid);
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+int peel_ref(const char *refname, struct object_id *oid)
 {
-	return refs_peel_ref(get_main_ref_store(), refname, sha1);
+	return refs_peel_ref(get_main_ref_store(), refname, oid);
 }
 
 int refs_create_symref(struct ref_store *refs,
diff --git a/refs.h b/refs.h
index 8159b7b067..832ade2b13 100644
--- a/refs.h
+++ b/refs.h
@@ -120,8 +120,8 @@ extern int refs_init_db(struct strbuf *err);
  * ultimately resolve to a peelable tag.
  */
 int refs_peel_ref(struct ref_store *refs, const char *refname,
-		  unsigned char *sha1);
-int peel_ref(const char *refname, unsigned char *sha1);
+		  struct object_id *oid);
+int peel_ref(const char *refname, struct object_id *oid);
 
 /**
  * Resolve refname in the nested "gitlink" repository in the specified
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 148b98490f..a7e4b9e1e9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -642,7 +642,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 }
 
 static int files_peel_ref(struct ref_store *ref_store,
-			  const char *refname, unsigned char *sha1)
+			  const char *refname, struct object_id *oid)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ | REF_STORE_ODB,
@@ -655,7 +655,7 @@ static int files_peel_ref(struct ref_store *ref_store,
 
 		if (ref_iterator_peel(current_ref_iter, &peeled))
 			return -1;
-		hashcpy(sha1, peeled.hash);
+		oidcpy(oid, &peeled);
 		return 0;
 	}
 
@@ -672,10 +672,10 @@ static int files_peel_ref(struct ref_store *ref_store,
 	 * have REF_KNOWS_PEELED.
 	 */
 	if (flag & REF_ISPACKED &&
-	    !refs_peel_ref(refs->packed_ref_store, refname, sha1))
+	    !refs_peel_ref(refs->packed_ref_store, refname, oid))
 		return 0;
 
-	return peel_object(base.hash, sha1);
+	return peel_object(base.hash, oid->hash);
 }
 
 struct files_ref_iterator {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3bc47ffd5e..d4bb4ba357 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -341,7 +341,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 }
 
 static int packed_peel_ref(struct ref_store *ref_store,
-			   const char *refname, unsigned char *sha1)
+			   const char *refname, struct object_id *oid)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ | REF_STORE_ODB,
@@ -351,7 +351,7 @@ static int packed_peel_ref(struct ref_store *ref_store,
 	if (!r || peel_entry(r, 0))
 		return -1;
 
-	hashcpy(sha1, r->u.value.peeled.hash);
+	oidcpy(oid, &r->u.value.peeled);
 	return 0;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6636a13a62..f0bedbd80b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -549,7 +549,7 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 
 typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
 typedef int peel_ref_fn(struct ref_store *ref_store,
-			const char *refname, unsigned char *sha1);
+			const char *refname, struct object_id *oid);
 typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index af8dba9560..cea3285ada 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -72,12 +72,12 @@ static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 static int cmd_peel_ref(struct ref_store *refs, const char **argv)
 {
 	const char *refname = notnull(*argv++, "refname");
-	unsigned char sha1[20];
+	struct object_id oid;
 	int ret;
 
-	ret = refs_peel_ref(refs, refname, sha1);
+	ret = refs_peel_ref(refs, refname, &oid);
 	if (!ret)
-		puts(sha1_to_hex(sha1));
+		puts(oid_to_hex(&oid));
 	return ret;
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index 030eba5a0c..6d5f3c0d39 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -955,7 +955,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
-	if (!peel_ref(refname, peeled.hash))
+	if (!peel_ref(refname, &peeled))
 		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return 0;
 }
-- 
2.14.2.822.g60be5d43e6

