Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758EA1FA21
	for <e@80x24.org>; Mon,  9 Oct 2017 01:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbdJIBMS (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 21:12:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54772 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753840AbdJIBMN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Oct 2017 21:12:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 07AA860DA0;
        Mon,  9 Oct 2017 01:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507511532;
        bh=vooHURFFBBSqZw8ztbVpq0Ltcxatl6P6st2pV6O5ZyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VP9+ZaGn928HnTe77FIqgJwfF7nP1HCMToREp4T+/oF0QgBdudFpHw5h7XQW7GVjK
         g71pkG+98WrNClp8YUCmLvO1U5kdiJX0mqm94y4Lr6zYUhaud+jX8AovFIPnqWTv6M
         MCTMlZVeW5VzL1ONDe4HgSt2iPczSJrDAqKF2803w5sFluZClYlwqGc2bofvCmVfBh
         cGLvDeREeHvnvvBM4I57NRYAw6TI/RZM1O4+FLFCSCyxO4bHN5/AoPwHEsLWIOZamb
         U//SHWKdFIUHKZ36JRZiFoupAHYIyKygG5oYSLpdYa3lWKAojoNwFU+pF5863CubwG
         Hj7XCsO3bC3K5hyJnQ1f8LA3BpJ/aTBQru4UxTKdS+LcyzSWuanSSeDcDNzPCXs5oa
         mG/EqnVlzGYxw8b2xxRtBAsnnJPM5ZhhOXUj7zDWfJrlfLoV3dlwCRkmGYDnt+BsdN
         Qf96pk4TxcLkfA6vqBofcuruGnzskB2P5hLUhCgz8xoDR229kVV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 22/24] refs: convert peel_object to struct object_id
Date:   Mon,  9 Oct 2017 01:11:30 +0000
Message-Id: <20171009011132.675341-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c
In-Reply-To: <20171009011132.675341-1-sandals@crustytoothpaste.net>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c                | 8 ++++----
 refs/files-backend.c  | 2 +-
 refs/packed-backend.c | 4 ++--
 refs/ref-cache.c      | 2 +-
 refs/refs-internal.h  | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index a030937f77..958234e7d6 100644
--- a/refs.c
+++ b/refs.c
@@ -252,12 +252,12 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 	return filter->fn(refname, oid, flags, filter->cb_data);
 }
 
-enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
+enum peel_status peel_object(const struct object_id *name, struct object_id *oid)
 {
-	struct object *o = lookup_unknown_object(name);
+	struct object *o = lookup_unknown_object(name->hash);
 
 	if (o->type == OBJ_NONE) {
-		int type = sha1_object_info(name, NULL);
+		int type = sha1_object_info(name->hash, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
 	}
@@ -269,7 +269,7 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 	if (!o)
 		return PEEL_INVALID;
 
-	hashcpy(sha1, o->oid.hash);
+	oidcpy(oid, &o->oid);
 	return PEEL_PEELED;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 61f3690299..417c662d5d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -675,7 +675,7 @@ static int files_peel_ref(struct ref_store *ref_store,
 	    !refs_peel_ref(refs->packed_ref_store, refname, oid))
 		return 0;
 
-	return peel_object(base.hash, oid->hash);
+	return peel_object(&base, oid);
 }
 
 struct files_ref_iterator {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a450efd21e..25e6fc4ffe 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -716,8 +716,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 			i++;
 		} else {
 			struct object_id peeled;
-			int peel_error = peel_object(update->new_oid.hash,
-						     peeled.hash);
+			int peel_error = peel_object(&update->new_oid,
+						     &peeled);
 
 			if (write_packed_entry(out, update->refname,
 					       update->new_oid.hash,
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 76bb723c86..e36702ed06 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -509,7 +509,7 @@ enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	if (entry->flag & REF_ISSYMREF)
 		return PEEL_IS_SYMREF;
 
-	status = peel_object(entry->u.value.oid.hash, entry->u.value.peeled.hash);
+	status = peel_object(&entry->u.value.oid, &entry->u.value.peeled);
 	if (status == PEEL_PEELED || status == PEEL_NON_TAG)
 		entry->flag |= REF_KNOWS_PEELED;
 	return status;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0cbce76f21..cf84da33d5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -120,11 +120,11 @@ enum peel_status {
 /*
  * Peel the named object; i.e., if the object is a tag, resolve the
  * tag recursively until a non-tag is found.  If successful, store the
- * result to sha1 and return PEEL_PEELED.  If the object is not a tag
+ * result to oid and return PEEL_PEELED.  If the object is not a tag
  * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
  * and leave sha1 unchanged.
  */
-enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
+enum peel_status peel_object(const struct object_id *name, struct object_id *oid);
 
 /*
  * Copy the reflog message msg to buf, which has been allocated sufficiently
-- 
2.14.2.920.gcf0c67979c

