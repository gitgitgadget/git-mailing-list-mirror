Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26AB120372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbdJOWIF (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:08:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55166 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751695AbdJOWIC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:08:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06B8760464;
        Sun, 15 Oct 2017 22:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105281;
        bh=CdR2YaFRsW8nfAFKVC1FPYJ/HwgZxsAY+WYRgydAmxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=N0cXcPXyKRUMd/DZV2coSk8z39HENWaCg5X075S9MBjxkGPkpVh2IrDNNhLC1oBe+
         iEouNHsOl7mfUkutdJerJIIaqDN4+F1+De/ujFE4Hs5ERf3DmFOXcI8LyK2bkFHRPe
         D8WPOp/Dr/8X2DurSujqHfxyCdSeEFRauBFgtQZjO8RAHLjHlAe8NNaDUdrVLbuH0x
         wXneHy502z81nQ2ISAFKa3JY40DAwYujbVf6AS+hUSlYmQO8/mm/BG/E1wT7nd5fK3
         qHJ0XynemWsriDsESVcyowItwsaZQ/KZCIIo7uduDF+Mumf7YoVoUZI8F5cJwiea1d
         NPwvNJa9Ndhd3WtFCAqFCB0YR6+Ez2XPgIoo3AFk2Os+QM+Eu/IViJeCl710GmPbrX
         pxs1nPLab7oikZ0jl/ObDeIeqys5jJ4IurDVNttXIxRCJCIm/js6cI3q6fvNuGSjUY
         3CvAcMcoTQiuPFQasVW5ksGpuyVYqOZlzYeCYJFjR/nSZ7BwrA8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 23/25] refs: convert peel_object to struct object_id
Date:   Sun, 15 Oct 2017 22:07:10 +0000
Message-Id: <20171015220712.97308-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c                | 10 +++++-----
 refs/packed-backend.c |  6 +++---
 refs/ref-cache.c      |  2 +-
 refs/refs-internal.h  |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 72c45a513b..6546346b6a 100644
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
 
@@ -1714,7 +1714,7 @@ int refs_peel_ref(struct ref_store *refs, const char *refname,
 			       RESOLVE_REF_READING, &base, &flag))
 		return -1;
 
-	return peel_object(base.hash, oid->hash);
+	return peel_object(&base, oid);
 }
 
 int peel_ref(const char *refname, struct object_id *oid)
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ec9fcacdd..b7652738be 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -880,7 +880,7 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
 		return -1;
 	} else {
-		return !!peel_object(iter->oid.hash, peeled->hash);
+		return !!peel_object(&iter->oid, peeled);
 	}
 }
 
@@ -1220,8 +1220,8 @@ static int write_with_updates(struct packed_ref_store *refs,
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
index 4f850e1b5c..043eb83748 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -493,7 +493,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	return peel_object(ref_iterator->oid->hash, peeled->hash);
+	return peel_object(ref_iterator->oid, peeled);
 }
 
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3c4781eb87..54059c1daf 100644
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
2.15.0.rc0.271.g36b669edcc

