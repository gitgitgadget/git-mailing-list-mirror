Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578EA207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdEFWLt (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:11:49 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37604 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754209AbdEFWLN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 77527280AF;
        Sat,  6 May 2017 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108669;
        bh=6PzqCm71A4v/7BrM649kJdSVvHquVdSryyJ2EYnkyyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MG03g5NiLBK3/ePs9lUmP6CkV5mWNe5aj5UwIZdXkO2eFxfHKeRIRUKb/eVKnVVga
         lYY+zAwDMKWZJZqhlM8z8xLI2FovdSkR63kaGpgHmN4u03uwvAE+ISLQSrrhvyLj4i
         3mpPCwDy+WY5LIpSTszf0B1wCrY3ck7Mvt4CBgzQEihUXGJfFJTV1kfbNh/G1bb90G
         Ohzz9jxxTqnRSdoPJvVb1CLxv26d3eYlT+Unn4FvNty96MlQ1w+A5emZbSABF5hJnD
         NeHPsUoUYEzcI/junIbEOoUKSi3ludDhc3Uo5XeQE/YZIlfJzbHBf3bsPgfiDtu8Q8
         mCs18d8fmVlk0WEx1pTxp8+MWd5koLG6hE5oK5lEnHt22na+ePEfSGv5ciI6T4IJXE
         7KJYrG0Fnqa1ma0kh+gbKm5Rc5+P5aG9hypwi806tdW/9Mx/WpSrd/OyNVZWjQpVgk
         vFEZAxfW4VfwZJkMb9vcPCrJ7KCqTLdZ+hMOiWcjGFmb5bg6XRa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 15/53] reflog_expire: convert to struct object_id
Date:   Sat,  6 May 2017 22:10:00 +0000
Message-Id: <20170506221038.296722-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the callback functions to take struct object_id * instead of
unsigned char *, and modify related static functions accordingly.

Introduce a temporary object_id instance into files_reflog_expire and
copy the SHA-1 value passed in.  This is necessary because the sha1
parameter can come indirectly from get_sha1.  Without the temporary, it
would require much more refactoring to be able to convert this function.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reflog.c     | 22 +++++++++++-----------
 refs.h               |  6 +++---
 refs/files-backend.c |  7 +++++--
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 747277577..d6718d326 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -186,13 +186,13 @@ static int commit_is_complete(struct commit *commit)
 	return !is_incomplete;
 }
 
-static int keep_entry(struct commit **it, unsigned char *sha1)
+static int keep_entry(struct commit **it, struct object_id *oid)
 {
 	struct commit *commit;
 
-	if (is_null_sha1(sha1))
+	if (is_null_oid(oid))
 		return 1;
-	commit = lookup_commit_reference_gently(sha1, 1);
+	commit = lookup_commit_reference_gently(oid->hash, 1);
 	if (!commit)
 		return 0;
 
@@ -251,17 +251,17 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 	cb->mark_list = leftover;
 }
 
-static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, unsigned char *sha1)
+static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
 {
 	/*
 	 * We may or may not have the commit yet - if not, look it
 	 * up using the supplied sha1.
 	 */
 	if (!commit) {
-		if (is_null_sha1(sha1))
+		if (is_null_oid(oid))
 			return 0;
 
-		commit = lookup_commit_reference_gently(sha1, 1);
+		commit = lookup_commit_reference_gently(oid->hash, 1);
 
 		/* Not a commit -- keep it */
 		if (!commit)
@@ -283,7 +283,7 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
 /*
  * Return true iff the specified reflog entry should be expired.
  */
-static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 				    const char *email, unsigned long timestamp, int tz,
 				    const char *message, void *cb_data)
 {
@@ -295,13 +295,13 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 	old = new = NULL;
 	if (cb->cmd.stalefix &&
-	    (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
+	    (!keep_entry(&old, ooid) || !keep_entry(&new, noid)))
 		return 1;
 
 	if (timestamp < cb->cmd.expire_unreachable) {
 		if (cb->unreachable_expire_kind == UE_ALWAYS)
 			return 1;
-		if (unreachable(cb, old, osha1) || unreachable(cb, new, nsha1))
+		if (unreachable(cb, old, ooid) || unreachable(cb, new, noid))
 			return 1;
 	}
 
@@ -326,7 +326,7 @@ static int push_tip_to_list(const char *refname, const struct object_id *oid,
 }
 
 static void reflog_expiry_prepare(const char *refname,
-				  const unsigned char *sha1,
+				  const struct object_id *oid,
 				  void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
@@ -335,7 +335,7 @@ static void reflog_expiry_prepare(const char *refname,
 		cb->tip_commit = NULL;
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
-		cb->tip_commit = lookup_commit_reference_gently(sha1, 1);
+		cb->tip_commit = lookup_commit_reference_gently(oid->hash, 1);
 		if (!cb->tip_commit)
 			cb->unreachable_expire_kind = UE_ALWAYS;
 		else
diff --git a/refs.h b/refs.h
index 07cf4cd41..a22f696dd 100644
--- a/refs.h
+++ b/refs.h
@@ -611,10 +611,10 @@ enum expire_reflog_flags {
  *     unlocked again.
  */
 typedef void reflog_expiry_prepare_fn(const char *refname,
-				      const unsigned char *sha1,
+				      const struct object_id *oid,
 				      void *cb_data);
-typedef int reflog_expiry_should_prune_fn(unsigned char *osha1,
-					  unsigned char *nsha1,
+typedef int reflog_expiry_should_prune_fn(struct object_id *ooid,
+					  struct object_id *noid,
 					  const char *email,
 					  unsigned long timestamp, int tz,
 					  const char *message, void *cb_data);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 83ea080e0..298a838c5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3207,7 +3207,7 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
 		ooid = &cb->last_kept_oid;
 
-	if ((*cb->should_prune_fn)(ooid->hash, noid->hash, email, timestamp, tz,
+	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
 				   message, policy_cb)) {
 		if (!cb->newlog)
 			printf("would prune %s", message);
@@ -3244,6 +3244,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	int status = 0;
 	int type;
 	struct strbuf err = STRBUF_INIT;
+	struct object_id oid;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -3293,7 +3294,9 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	(*prepare_fn)(refname, sha1, cb.policy_cb);
+	hashcpy(oid.hash, sha1);
+
+	(*prepare_fn)(refname, &oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
