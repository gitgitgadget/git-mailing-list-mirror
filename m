Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D3120A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdJAWJJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54184 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752001AbdJAWJE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9DA9B60DB7;
        Sun,  1 Oct 2017 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895744;
        bh=b8XUrOLk8bXy/P3P+yTfOBP8eFnrUOH4/qiP/3w4jXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMaQNqXt3EOAQPzllWxJSq8gUXQdoXBdIpUCmIg5vCRRcnZdoblsEVehiqehvfFKs
         0su8MKChgw3nHRuw+uKZGWKHCfwUJ8n1LBGsbvpnftRa8vCoH3koSYrQwfjSsXLtY7
         aGE41HIht0fGjf+1dRgcvCpInsSOyjUnJjTYfOsnmcuyC6c09cKVz84n5mGG35cdW1
         viPX52+4al7pDt3uRaD+FUxVeG8Y4cPXow2pCBYsjtzsvFntIEROmc+igkekQT7S+7
         J1VuP9TPdo0jx78rpjsmU9n5nWBY3gHkrhbWsfqsXJkjO6wfBGh3ioSVOTbbbod2w0
         W9Agvtn6gTA1gPcKVapcmyI4gkPJVy34BI3unjfOlwZAhCF3YOsQCM+erdH1eiDrEh
         dqnA8THaFuk0fFYaebofERgQ60WgotqOPfWEXm4dvaGIZ40Ed6R7pyZ/JXSYekpkNl
         gS0U5kPF+jtbJ0AhVU89w8xXYkbpK+DuwqVlzlNYKMiKd9H8hIF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 16/24] refs: convert reflog_expire parameter to struct object_id
Date:   Sun,  1 Oct 2017 22:08:23 +0000
Message-Id: <20171001220831.214705-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
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
index 684dd75deb..d2fd0d2a69 100644
--- a/refs.c
+++ b/refs.c
@@ -1973,19 +1973,19 @@ int delete_reflog(const char *refname)
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
@@ -1993,7 +1993,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  void *policy_cb_data)
 {
 	return refs_reflog_expire(get_main_ref_store(),
-				  refname, sha1, flags,
+				  refname, oid, flags,
 				  prepare_fn, should_prune_fn,
 				  cleanup_fn, policy_cb_data);
 }
diff --git a/refs.h b/refs.h
index 3afecd2e8a..1bc241424d 100644
--- a/refs.h
+++ b/refs.h
@@ -696,20 +696,20 @@ typedef int reflog_expiry_should_prune_fn(struct object_id *ooid,
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
index a7e4b9e1e9..4400e18eee 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2914,7 +2914,7 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int files_reflog_expire(struct ref_store *ref_store,
-			       const char *refname, const unsigned char *sha1,
+			       const char *refname, const struct object_id *oid,
 			       unsigned int flags,
 			       reflog_expiry_prepare_fn prepare_fn,
 			       reflog_expiry_should_prune_fn should_prune_fn,
@@ -2931,7 +2931,6 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	int status = 0;
 	int type;
 	struct strbuf err = STRBUF_INIT;
-	struct object_id oid;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -2943,7 +2942,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refs, refname, sha1,
+	lock = lock_ref_sha1_basic(refs, refname, oid->hash,
 				   NULL, NULL, REF_NODEREF,
 				   &type, &err);
 	if (!lock) {
@@ -2981,9 +2980,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	hashcpy(oid.hash, sha1);
-
-	(*prepare_fn)(refname, &oid, cb.policy_cb);
+	(*prepare_fn)(refname, oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index d4bb4ba357..a450efd21e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1006,7 +1006,7 @@ static int packed_delete_reflog(struct ref_store *ref_store,
 }
 
 static int packed_reflog_expire(struct ref_store *ref_store,
-				const char *refname, const unsigned char *sha1,
+				const char *refname, const struct object_id *oid,
 				unsigned int flags,
 				reflog_expiry_prepare_fn prepare_fn,
 				reflog_expiry_should_prune_fn should_prune_fn,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f0bedbd80b..0cbce76f21 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -592,7 +592,7 @@ typedef int create_reflog_fn(struct ref_store *ref_store, const char *refname,
 			     int force_create, struct strbuf *err);
 typedef int delete_reflog_fn(struct ref_store *ref_store, const char *refname);
 typedef int reflog_expire_fn(struct ref_store *ref_store,
-			     const char *refname, const unsigned char *sha1,
+			     const char *refname, const struct object_id *oid,
 			     unsigned int flags,
 			     reflog_expiry_prepare_fn prepare_fn,
 			     reflog_expiry_should_prune_fn should_prune_fn,
-- 
2.14.2.822.g60be5d43e6

