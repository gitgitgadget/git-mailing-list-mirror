Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C842095B
	for <e@80x24.org>; Mon, 20 Mar 2017 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755824AbdCTQhq (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:37:46 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54228 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754325AbdCTQd6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:58 -0400
X-AuditID: 12074413-f67ff700000077e1-62-58d004730d0a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DE.3F.30689.37400D85; Mon, 20 Mar 2017 12:33:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9M010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/20] ref-cache: use a callback function to fill the cache
Date:   Mon, 20 Mar 2017 17:33:17 +0100
Message-Id: <4f63d54ae95066a6af7a31dbd6e9b3a404fc9287.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsUixO6iqFvCciHCYHEjl0XXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j672I2wez3r3MHpcvKTs8XmTXABb
        FJdNSmpOZllqkb5dAlfGlSNPmQuOaFU8/f+VtYHxi1IXIyeHhICJxMSmQ8xdjFwcQgI7mCQ2
        br7NCpIQEjjFJHH6rh+IzSagK7Gop5kJxBYRUJOY2HaIBaSBWeARo8TV+XfZQRLCAt4Sc67c
        YgaxWQRUJY78/c0CYvMKREnMvX+LDWKbvMSutotgCzgFLCS+3G9kgVhmLtG5oJd9AiPPAkaG
        VYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6qSmlmxgh4SS8g3HXSblDjAIcjEo8vCuu
        nI8QYk0sK67MPcQoycGkJMr79DZQiC8pP6UyI7E4I76oNCe1+BCjBAezkghv1UugHG9KYmVV
        alE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgreX6UKEkGBRanpqRVpmTglCmomD
        E2Q4D9DwOpAa3uKCxNzizHSI/ClGRSlx3gJGoIQASCKjNA+uFxbvrxjFgV4R5mUBaecBpgq4
        7ldAg5mABi+7cQZkcEkiQkqqgTE57lXn8bbGhI/5Mq/8WrTvV0QqBwZ+jrLluLZTsyNYxPus
        TdQPrWdnhS9MFvykv0D+/pTFy6vCVnxPsQgrSF0n8v1Ccs4Wn9VvVto+LK0LKX+7NvRxrmgV
        w8MjIpfklPcqbsp4YPvzsvTEoMAjPrecWh6alJ+TKTFaK5xmt2Jl3Oxrb9tWbFFiKc5INNRi
        LipOBABYI+Pa0gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a leveling violation for `ref_cache` to know about
`files_ref_store` or that it should call `read_loose_refs()` to lazily
fill cache directories. So instead, have its constructor take as an
argument a callback function that it should use for lazy-filling, and
change `files_ref_store` to supply a pointer to function
`read_loose_refs` (renamed to `loose_fill_ref_dir`) when creating the
ref cache for its loose refs.

This means that we can generify the type of the back-pointer in
`struct ref_cache` from `files_ref_store` to `ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 10 ++++++----
 refs/ref-cache.c     | 12 +++++++-----
 refs/ref-cache.h     | 29 +++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 78572e55a0..e4d78393ac 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -387,7 +387,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
 		acquire_packed_ref_cache(refs->packed);
-		refs->packed->cache = create_ref_cache(refs);
+		refs->packed->cache = create_ref_cache(&refs->base, NULL);
 		refs->packed->cache->root->flag &= ~REF_INCOMPLETE;
 		f = fopen(packed_refs_file, "r");
 		if (f) {
@@ -431,9 +431,11 @@ static void add_packed_ref(struct files_ref_store *refs,
  * (without recursing).  dirname must end with '/'.  dir must be the
  * directory entry corresponding to dirname.
  */
-void read_loose_refs(const char *dirname, struct ref_dir *dir)
+static void loose_fill_ref_dir(struct ref_store *ref_store,
+			       struct ref_dir *dir, const char *dirname)
 {
-	struct files_ref_store *refs = dir->cache->ref_store;
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
 	DIR *d;
 	struct dirent *de;
 	int dirnamelen = strlen(dirname);
@@ -516,7 +518,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 		 * are about to read the only subdirectory that can
 		 * hold references:
 		 */
-		refs->loose = create_ref_cache(refs);
+		refs->loose = create_ref_cache(&refs->base, loose_fill_ref_dir);
 
 		/* We're going to fill the top level ourselves: */
 		refs->loose->root->flag &= ~REF_INCOMPLETE;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 96da094788..7f247b9170 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -4,9 +4,6 @@
 #include "ref-cache.h"
 #include "../iterator.h"
 
-/* FIXME: This declaration shouldn't be here */
-void read_loose_refs(const char *dirname, struct ref_dir *dir);
-
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
 {
 	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
@@ -25,7 +22,10 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	assert(entry->flag & REF_DIR);
 	dir = &entry->u.subdir;
 	if (entry->flag & REF_INCOMPLETE) {
-		read_loose_refs(entry->name, dir);
+		if (!dir->cache->fill_ref_dir)
+			die("BUG: incomplete ref_store without fill_ref_dir function");
+
+		dir->cache->fill_ref_dir(dir->cache->ref_store, dir, entry->name);
 
 		/*
 		 * Manually add refs/bisect, which, being
@@ -63,11 +63,13 @@ struct ref_entry *create_ref_entry(const char *refname,
 	return ref;
 }
 
-struct ref_cache *create_ref_cache(struct files_ref_store *refs)
+struct ref_cache *create_ref_cache(struct ref_store *refs,
+				   fill_ref_dir_fn *fill_ref_dir)
 {
 	struct ref_cache *ret = xcalloc(1, sizeof(*ret));
 
 	ret->ref_store = refs;
+	ret->fill_ref_dir = fill_ref_dir;
 	ret->root = create_dir_entry(ret, "", 0, 1);
 	return ret;
 }
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 83051854ff..ed51e80d88 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,11 +1,27 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
+struct ref_dir;
+
+/*
+ * If this ref_cache is filled lazily, this function is used to load
+ * information into the specified ref_dir (shallow or deep, at the
+ * option of the ref_store). dirname includes a trailing slash.
+ */
+typedef void fill_ref_dir_fn(struct ref_store *ref_store,
+			     struct ref_dir *dir, const char *dirname);
+
 struct ref_cache {
 	struct ref_entry *root;
 
-	/* A pointer to the files_ref_store whose cache this is: */
-	struct files_ref_store *ref_store;
+	/* A pointer to the ref_store whose cache this is: */
+	struct ref_store *ref_store;
+
+	/*
+	 * Function used (if necessary) to lazily-fill cache. May be
+	 * NULL.
+	 */
+	fill_ref_dir_fn *fill_ref_dir;
 };
 
 /*
@@ -174,9 +190,14 @@ struct ref_entry *create_ref_entry(const char *refname,
 
 /*
  * Return a pointer to a new `ref_cache`. Its top-level starts out
- * marked incomplete.
+ * marked incomplete. If `fill_ref_dir` is non-NULL, it is the
+ * function called to fill in incomplete directories in the
+ * `ref_cache` when they are accessed. If it is NULL, then the whole
+ * `ref_cache` must be filled (including clearing its directories'
+ * `REF_INCOMPLETE` bits) before it is used.
  */
-struct ref_cache *create_ref_cache(struct files_ref_store *refs);
+struct ref_cache *create_ref_cache(struct ref_store *refs,
+				   fill_ref_dir_fn *fill_ref_dir);
 
 /*
  * Free the `ref_cache` and all of its associated data.
-- 
2.11.0

