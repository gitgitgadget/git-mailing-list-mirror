Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC5A1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeH2BQ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:16:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:59548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726998AbeH2BQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:16:28 -0400
Received: (qmail 29836 invoked by uid 109); 28 Aug 2018 21:22:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 21:22:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5867 invoked by uid 111); 28 Aug 2018 21:23:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 Aug 2018 17:23:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2018 17:22:55 -0400
Date:   Tue, 28 Aug 2018 17:22:55 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 7/9] convert hashmap comparison functions to oideq()
Message-ID: <20180828212255.GG11036@sigill.intra.peff.net>
References: <20180828212126.GA7039@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212126.GA7039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comparison functions used for hashmaps don't care about
strict ordering; they only want to compare entries for
equality. Let's use the oideq() function instead, which can
potentially be better optimized. Note that unlike the
previous patches mass-converting calls like "!oidcmp()",
this patch could actually provide an improvement even with
the current implementation. Those comparison functions are
passed around as function pointers, so at compile-time the
compiler cannot realize that the caller (which is in another
file completely) will treat the return value as a boolean.

Note that this does change the return values in quite a
subtle way (it's still an int, but now the sign bit is
irrelevant for ordering). Because of their funny
hashmap-specific signature, it's unlikely that any of these
static functions would be reused for more generic ordering.
But to be double-sure, let's stop using "cmp" in their
names.

Calling them "eq" doesn't quite work either, because the
hashmap convention is actually _inverted_. "0" means "same",
and non-zero means "different". So I've called them "neq" by
convention here.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c |  6 +++---
 oidmap.c           | 12 ++++++------
 patch-ids.c        |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1e7c75ba82..22c0541da5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -62,7 +62,7 @@ static const char *prio_names[] = {
 	N_("head"), N_("lightweight"), N_("annotated"),
 };
 
-static int commit_name_cmp(const void *unused_cmp_data,
+static int commit_name_neq(const void *unused_cmp_data,
 			   const void *entry,
 			   const void *entry_or_key,
 			   const void *peeled)
@@ -70,7 +70,7 @@ static int commit_name_cmp(const void *unused_cmp_data,
 	const struct commit_name *cn1 = entry;
 	const struct commit_name *cn2 = entry_or_key;
 
-	return oidcmp(&cn1->peeled, peeled ? peeled : &cn2->peeled);
+	return !oideq(&cn1->peeled, peeled ? peeled : &cn2->peeled);
 }
 
 static inline struct commit_name *find_commit_name(const struct object_id *peeled)
@@ -596,7 +596,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		return cmd_name_rev(args.argc, args.argv, prefix);
 	}
 
-	hashmap_init(&names, commit_name_cmp, NULL, 0);
+	hashmap_init(&names, commit_name_neq, NULL, 0);
 	for_each_rawref(get_name, NULL);
 	if (!hashmap_get_size(&names) && !always)
 		die(_("No names found, cannot describe anything."));
diff --git a/oidmap.c b/oidmap.c
index d9fb19ba6a..b0841a0f58 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -1,14 +1,14 @@
 #include "cache.h"
 #include "oidmap.h"
 
-static int cmpfn(const void *hashmap_cmp_fn_data,
-		 const void *entry, const void *entry_or_key,
-		 const void *keydata)
+static int oidmap_neq(const void *hashmap_cmp_fn_data,
+		      const void *entry, const void *entry_or_key,
+		      const void *keydata)
 {
 	const struct oidmap_entry *entry_ = entry;
 	if (keydata)
-		return oidcmp(&entry_->oid, (const struct object_id *) keydata);
-	return oidcmp(&entry_->oid,
+		return !oideq(&entry_->oid, (const struct object_id *) keydata);
+	return !oideq(&entry_->oid,
 		      &((const struct oidmap_entry *) entry_or_key)->oid);
 }
 
@@ -21,7 +21,7 @@ static int hash(const struct object_id *oid)
 
 void oidmap_init(struct oidmap *map, size_t initial_size)
 {
-	hashmap_init(&map->map, cmpfn, NULL, initial_size);
+	hashmap_init(&map->map, oidmap_neq, NULL, initial_size);
 }
 
 void oidmap_free(struct oidmap *map, int free_entries)
diff --git a/patch-ids.c b/patch-ids.c
index 8f7c25d5db..960ea24054 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -28,14 +28,14 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 /*
  * When we cannot load the full patch-id for both commits for whatever
  * reason, the function returns -1 (i.e. return error(...)). Despite
- * the "cmp" in the name of this function, the caller only cares about
+ * the "neq" in the name of this function, the caller only cares about
  * the return value being zero (a and b are equivalent) or non-zero (a
  * and b are different), and returning non-zero would keep both in the
  * result, even if they actually were equivalent, in order to err on
  * the side of safety.  The actual value being negative does not have
  * any significance; only that it is non-zero matters.
  */
-static int patch_id_cmp(const void *cmpfn_data,
+static int patch_id_neq(const void *cmpfn_data,
 			const void *entry,
 			const void *entry_or_key,
 			const void *unused_keydata)
@@ -53,7 +53,7 @@ static int patch_id_cmp(const void *cmpfn_data,
 	    commit_patch_id(b->commit, opt, &b->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&b->commit->object.oid));
-	return oidcmp(&a->patch_id, &b->patch_id);
+	return !oideq(&a->patch_id, &b->patch_id);
 }
 
 int init_patch_ids(struct patch_ids *ids)
@@ -63,7 +63,7 @@ int init_patch_ids(struct patch_ids *ids)
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
-	hashmap_init(&ids->patches, patch_id_cmp, &ids->diffopts, 256);
+	hashmap_init(&ids->patches, patch_id_neq, &ids->diffopts, 256);
 	return 0;
 }
 
-- 
2.19.0.rc0.584.g84d5b2a847

