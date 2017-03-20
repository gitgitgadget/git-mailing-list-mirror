Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6106F20958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755526AbdCTQd7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:33:59 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48517 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753006AbdCTQdz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:55 -0400
X-AuditID: 1207440d-041ff70000003721-61-58d00471f6ed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D4.2E.14113.17400D85; Mon, 20 Mar 2017 12:33:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9L010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:52 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/20] refs: record the ref_store in ref_cache, not ref_dir
Date:   Mon, 20 Mar 2017 17:33:16 +0100
Message-Id: <745f1ed3781083f99da31a33dec08f03bffa7d4f.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsUixO6iqFvIciHC4NEBK4uuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6Mde2b2QtWKVc8PLGIqYFxnUwXIyeHhICJxO6tbWxdjFwcQgI7mCSO
        Td7MCOGcYpK4ceYDK0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgUeMElfn32UHSQgLeEt0rvkA
        NIqDg0VAVWJ+MwtImFcgSuLRjumMENvkJXa1XQSbySlgIfHlfiNYjZCAuUTngl72CYw8CxgZ
        VjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEhBPvDsb/62QOMQpwMCrx8K64
        cj5CiDWxrLgy9xCjJAeTkijv09tAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8VS+BcrwpiZVV
        qUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV5RpgsRQoJFqempFWmZOSUIaSYO
        TpDhPEDD60BqeIsLEnOLM9Mh8qcYFaXEeb//B9oqAJLIKM2D64XF+ytGcaBXhHnzfgNV8QBT
        BVz3K6DBTECDl904AzK4JBEhJdXAqHJUd5NFfu49Y3+hVVfviQpd2x8kHp1WEjB3UQ6zxm9j
        7vuKtuumWhQez/WpYjO6ENDsteFbUGFk+rcO6VMVhrsL/fy336xVbI+7F+8isO+B9AXZJSd+
        W07u1OeuOy5oUmw4/e10+y1aP5ZZXr2ps6lrkYyf46HLYSZfn4uz8O1avP95zfYYJZbijERD
        Leai4kQA/Nvu49ICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of keeping a pointer to the ref_store in every ref_dir entry,
store it once in `struct ref_cache`, and change `struct ref_dir` to
include a pointer to its containing `ref_cache` instead. This makes it
easier to add to the information that is stored in `struct ref_cache`
without inflating the size of the individual entries.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  6 +++---
 refs/ref-cache.c     | 12 +++++++-----
 refs/ref-cache.h     |  9 ++++++---
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a7d912ae39..78572e55a0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -433,7 +433,7 @@ static void add_packed_ref(struct files_ref_store *refs,
  */
 void read_loose_refs(const char *dirname, struct ref_dir *dir)
 {
-	struct files_ref_store *refs = dir->ref_store;
+	struct files_ref_store *refs = dir->cache->ref_store;
 	DIR *d;
 	struct dirent *de;
 	int dirnamelen = strlen(dirname);
@@ -469,7 +469,7 @@ void read_loose_refs(const char *dirname, struct ref_dir *dir)
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
 			add_entry_to_dir(dir,
-					 create_dir_entry(refs, refname.buf,
+					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len, 1));
 		} else {
 			if (!refs_resolve_ref_unsafe(&refs->base,
@@ -526,7 +526,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 		 * lazily):
 		 */
 		add_entry_to_dir(get_ref_dir(refs->loose->root),
-				 create_dir_entry(refs, "refs/", 5, 1));
+				 create_dir_entry(refs->loose, "refs/", 5, 1));
 	}
 	return get_ref_dir(refs->loose->root);
 }
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index bf911028c8..96da094788 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -36,7 +36,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 			int pos = search_ref_dir(dir, "refs/bisect/", 12);
 			if (pos < 0) {
 				struct ref_entry *child_entry;
-				child_entry = create_dir_entry(dir->ref_store,
+				child_entry = create_dir_entry(dir->cache,
 							       "refs/bisect/",
 							       12, 1);
 				add_entry_to_dir(dir, child_entry);
@@ -67,7 +67,8 @@ struct ref_cache *create_ref_cache(struct files_ref_store *refs)
 {
 	struct ref_cache *ret = xcalloc(1, sizeof(*ret));
 
-	ret->root = create_dir_entry(refs, "", 0, 1);
+	ret->ref_store = refs;
+	ret->root = create_dir_entry(ret, "", 0, 1);
 	return ret;
 }
 
@@ -104,13 +105,14 @@ static void clear_ref_dir(struct ref_dir *dir)
 	dir->entries = NULL;
 }
 
-struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
+struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   const char *dirname, size_t len,
 				   int incomplete)
 {
 	struct ref_entry *direntry;
+
 	FLEX_ALLOC_MEM(direntry, name, dirname, len);
-	direntry->u.subdir.ref_store = ref_store;
+	direntry->u.subdir.cache = cache;
 	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
 	return direntry;
 }
@@ -181,7 +183,7 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 		 * therefore, create an empty record for it but mark
 		 * the record complete.
 		 */
-		entry = create_dir_entry(dir->ref_store, subdirname, len, 0);
+		entry = create_dir_entry(dir->cache, subdirname, len, 0);
 		add_entry_to_dir(dir, entry);
 	} else {
 		entry = dir->entries[entry_index];
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index da5388c136..83051854ff 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -3,6 +3,9 @@
 
 struct ref_cache {
 	struct ref_entry *root;
+
+	/* A pointer to the files_ref_store whose cache this is: */
+	struct files_ref_store *ref_store;
 };
 
 /*
@@ -66,8 +69,8 @@ struct ref_dir {
 	 */
 	int sorted;
 
-	/* A pointer to the files_ref_store that contains this ref_dir. */
-	struct files_ref_store *ref_store;
+	/* The ref_cache containing this entry: */
+	struct ref_cache *cache;
 
 	struct ref_entry **entries;
 };
@@ -161,7 +164,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry);
  * dirname is the name of the directory with a trailing slash (e.g.,
  * "refs/heads/") or "" for the top-level directory.
  */
-struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
+struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   const char *dirname, size_t len,
 				   int incomplete);
 
-- 
2.11.0

