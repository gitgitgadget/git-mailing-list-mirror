Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4E620372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbdJOWI0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:08:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55126 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751657AbdJOWHz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 171E16045D;
        Sun, 15 Oct 2017 22:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105274;
        bh=YnAXnJxjPXwb0IeszQR5JTlmUYuafMFWd8x6x70ZCt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Alylrbl55/4cXBBvPbPV8NySttapDymGbaAxJqrFNnYDNPP/p6tig/dXThA/3t916
         yz081JiCMHqvwtpqWl6SpSPXZcMp0k2rb2rQ1ylEYRguI42AoitIbdzR7/7AIdACLU
         gQwbbLH3DxRTWC+0Sb+2t22576kVANUop2NHYuU9CYlMGAKm1ZX9LSOl++c1V3prTe
         3pWs0/7BdgpBJfj+TIvpBARaNmfByZjuE5oTQRRvE8vRNUbtbB6d9fdqHs6pAw6vOa
         ZiCk/bA4w9YlWyuHfakq4413UcPVmIFWFzSzRGZIR4nmLnqj3DXDY8OqYCj3OT0Gmw
         m0vcW4cKOFr/2NnLJvhC1tvNIwZJvYUC3G4du7gb625fBIQd4e4P4nBcZ0seCmNMAL
         DitSU3UaEdPmugvkZucaBty4BYYKWYQGrtW23Oc6sGH7LGlfUoLEsOVcAO4TAQiPWD
         XL8r0+Bm+iVTN41FFdzTXBME+PeNCv1yYC0ovKWjm78a3WLdqfF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 17/25] refs: convert reflog_expire parameter to struct object_id
Date:   Sun, 15 Oct 2017 22:07:04 +0000
Message-Id: <20171015220712.97308-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

reflog_expire already used struct object_id internally, but it did not
take it as a parameter.  Adjust the parameter (and the callers) to pass
a pointer to struct object_id instead of a pointer to unsigned char.
Remove the temporary inserted earlier as it is no longer required.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reflog.c      | 6 +++---
 refs.c                | 8 ++++----
 refs.h                | 6 +++---
 refs/files-backend.c  | 9 +++------
 refs/packed-backend.c | 2 +-
 refs/refs-internal.h  | 2 +-
 6 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index cd4c4847b7..ab31a3b6aa 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -589,7 +589,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= reflog_expire(e->reflog, e->oid.hash, flags,
+			status |= reflog_expire(e->reflog, &e->oid, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
@@ -607,7 +607,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
-		status |= reflog_expire(ref, oid.hash, flags,
+		status |= reflog_expire(ref, &oid, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
@@ -683,7 +683,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.cmd.expire_total = 0;
 		}
 
-		status |= reflog_expire(ref, oid.hash, flags,
+		status |= reflog_expire(ref, &oid, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
diff --git a/refs.c b/refs.c
index d19fae5077..37485283c0 100644
--- a/refs.c
+++ b/refs.c
@@ -2010,19 +2010,19 @@ int delete_reflog(const char *refname)
 }
 
 int refs_reflog_expire(struct ref_store *refs,
-		       const char *refname, const unsigned char *sha1,
+		       const char *refname, const struct object_id *oid,
 		       unsigned int flags,
 		       reflog_expiry_prepare_fn prepare_fn,
 		       reflog_expiry_should_prune_fn should_prune_fn,
 		       reflog_expiry_cleanup_fn cleanup_fn,
 		       void *policy_cb_data)
 {
-	return refs->be->reflog_expire(refs, refname, sha1, flags,
+	return refs->be->reflog_expire(refs, refname, oid, flags,
 				       prepare_fn, should_prune_fn,
 				       cleanup_fn, policy_cb_data);
 }
 
-int reflog_expire(const char *refname, const unsigned char *sha1,
+int reflog_expire(const char *refname, const struct object_id *oid,
 		  unsigned int flags,
 		  reflog_expiry_prepare_fn prepare_fn,
 		  reflog_expiry_should_prune_fn should_prune_fn,
@@ -2030,7 +2030,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  void *policy_cb_data)
 {
 	return refs_reflog_expire(get_main_ref_store(),
-				  refname, sha1, flags,
+				  refname, oid, flags,
 				  prepare_fn, should_prune_fn,
 				  cleanup_fn, policy_cb_data);
 }
diff --git a/refs.h b/refs.h
index 5f329d6618..50f6f0dbd7 100644
--- a/refs.h
+++ b/refs.h
@@ -703,20 +703,20 @@ typedef int reflog_expiry_should_prune_fn(struct object_id *ooid,
 typedef void reflog_expiry_cleanup_fn(void *cb_data);
 
 /*
- * Expire reflog entries for the specified reference. sha1 is the old
+ * Expire reflog entries for the specified reference. oid is the old
  * value of the reference. flags is a combination of the constants in
  * enum expire_reflog_flags. The three function pointers are described
  * above. On success, return zero.
  */
 int refs_reflog_expire(struct ref_store *refs,
 		       const char *refname,
-		       const unsigned char *sha1,
+		       const struct object_id *oid,
 		       unsigned int flags,
 		       reflog_expiry_prepare_fn prepare_fn,
 		       reflog_expiry_should_prune_fn should_prune_fn,
 		       reflog_expiry_cleanup_fn cleanup_fn,
 		       void *policy_cb_data);
-int reflog_expire(const char *refname, const unsigned char *sha1,
+int reflog_expire(const char *refname, const struct object_id *oid,
 		  unsigned int flags,
 		  reflog_expiry_prepare_fn prepare_fn,
 		  reflog_expiry_should_prune_fn should_prune_fn,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9814cbdcef..3ff5dc5b1c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2908,7 +2908,7 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int files_reflog_expire(struct ref_store *ref_store,
-			       const char *refname, const unsigned char *sha1,
+			       const char *refname, const struct object_id *oid,
 			       unsigned int flags,
 			       reflog_expiry_prepare_fn prepare_fn,
 			       reflog_expiry_should_prune_fn should_prune_fn,
@@ -2925,7 +2925,6 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	int status = 0;
 	int type;
 	struct strbuf err = STRBUF_INIT;
-	struct object_id oid;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -2937,7 +2936,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refs, refname, sha1,
+	lock = lock_ref_sha1_basic(refs, refname, oid->hash,
 				   NULL, NULL, REF_NODEREF,
 				   &type, &err);
 	if (!lock) {
@@ -2975,9 +2974,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	hashcpy(oid.hash, sha1);
-
-	(*prepare_fn)(refname, &oid, cb.policy_cb);
+	(*prepare_fn)(refname, oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3279d42c5a..4ec9fcacdd 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1519,7 +1519,7 @@ static int packed_delete_reflog(struct ref_store *ref_store,
 }
 
 static int packed_reflog_expire(struct ref_store *ref_store,
-				const char *refname, const unsigned char *sha1,
+				const char *refname, const struct object_id *oid,
 				unsigned int flags,
 				reflog_expiry_prepare_fn prepare_fn,
 				reflog_expiry_should_prune_fn should_prune_fn,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 951bd340c8..3c4781eb87 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -608,7 +608,7 @@ typedef int create_reflog_fn(struct ref_store *ref_store, const char *refname,
 			     int force_create, struct strbuf *err);
 typedef int delete_reflog_fn(struct ref_store *ref_store, const char *refname);
 typedef int reflog_expire_fn(struct ref_store *ref_store,
-			     const char *refname, const unsigned char *sha1,
+			     const char *refname, const struct object_id *oid,
 			     unsigned int flags,
 			     reflog_expiry_prepare_fn prepare_fn,
 			     reflog_expiry_should_prune_fn should_prune_fn,
-- 
2.15.0.rc0.271.g36b669edcc

