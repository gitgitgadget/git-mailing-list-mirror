Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522BC20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbdJOWH4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55098 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751642AbdJOWHx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 159176045C;
        Sun, 15 Oct 2017 22:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105272;
        bh=UQxTXgXTZkBAVH8SWjJOHn4W/ahf0JohN4UBJ0H57+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BnRZHlvApLQXOA3kBIJnBzmBHRPtdiALD6ykiFQDKiJ0Dz4pwwjbFm6qtS2O7qbFh
         aN9IGsG2zoziH5wX9gFCI+N0Q4xWW8N9O4qtfUILlD86c9DeCcnNbpDoF6OWeXfy3t
         XXIY2fB4k0/earlGOTRhMmQVcNIAEjeOKlMshi/85filLs6P1iRAO78H5xisswug5A
         DoR2pF8+BJrZdAHHg8g40PjOG/WkI6Y91ISZUrTmoVF4yIbVGM3F4s6dGJTcqACrY1
         H2NXkh/50qhfkWCEefFdTVxuNGgEltDlEgRWCe8OKz6Qy0oZcnjsScmIxtX/GtXvjL
         +sKwtTFlTaQJ3MFQMoR/8RXOWxE75DLujkzRT6hw/SrNraPE4QXAjVK60cVH+ASw6+
         uRPVESFy7OcMQYxau4TzUW4zrn+UxblcD0iKj0keIYZFuq4n/SdvBf1LDWvgYJ0rnf
         j/p/5X0F3pSguwjMMBGFvzdulx9gRE+AfTITXC1SdODggW70vs5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 15/25] refs: convert peel_ref to struct object_id
Date:   Sun, 15 Oct 2017 22:07:02 +0000
Message-Id: <20171015220712.97308-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert peel_ref (and its corresponding backend) to struct object_id.

This transformation was done with an update to the declaration,
definition, comments, and test helper and the following semantic patch:

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
 builtin/describe.c        |  2 +-
 builtin/pack-objects.c    |  4 ++--
 builtin/show-ref.c        |  2 +-
 refs.c                    | 10 +++++-----
 refs.h                    |  8 ++++----
 t/helper/test-ref-store.c |  6 +++---
 upload-pack.c             |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

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
index 9c6b224973..631de28761 100644
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
index ecb43a113e..f8a2d98666 100644
--- a/refs.c
+++ b/refs.c
@@ -1697,7 +1697,7 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags)
 }
 
 int refs_peel_ref(struct ref_store *refs, const char *refname,
-		  unsigned char *sha1)
+		  struct object_id *oid)
 {
 	int flag;
 	struct object_id base;
@@ -1707,7 +1707,7 @@ int refs_peel_ref(struct ref_store *refs, const char *refname,
 
 		if (ref_iterator_peel(current_ref_iter, &peeled))
 			return -1;
-		hashcpy(sha1, peeled.hash);
+		oidcpy(oid, &peeled);
 		return 0;
 	}
 
@@ -1715,12 +1715,12 @@ int refs_peel_ref(struct ref_store *refs, const char *refname,
 			       RESOLVE_REF_READING, &base, &flag))
 		return -1;
 
-	return peel_object(base.hash, sha1);
+	return peel_object(base.hash, oid->hash);
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+int peel_ref(const char *refname, struct object_id *oid)
 {
-	return refs_peel_ref(get_main_ref_store(), refname, sha1);
+	return refs_peel_ref(get_main_ref_store(), refname, oid);
 }
 
 int refs_create_symref(struct ref_store *refs,
diff --git a/refs.h b/refs.h
index 9d59c414aa..89f28d482d 100644
--- a/refs.h
+++ b/refs.h
@@ -114,14 +114,14 @@ extern int refs_init_db(struct strbuf *err);
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
- * store the SHA1 of the referred-to object to sha1 and return 0.  If
- * any of these conditions are not met, return a non-zero value.
+ * store the object ID of the referred-to object to oid and return 0.
+ * If any of these conditions are not met, return a non-zero value.
  * Symbolic references are considered unpeelable, even if they
  * ultimately resolve to a peelable tag.
  */
 int refs_peel_ref(struct ref_store *refs, const char *refname,
-		  unsigned char *sha1);
-int peel_ref(const char *refname, unsigned char *sha1);
+		  struct object_id *oid);
+int peel_ref(const char *refname, struct object_id *oid);
 
 /**
  * Resolve refname in the nested "gitlink" repository in the specified
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
2.15.0.rc0.271.g36b669edcc

