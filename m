Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEB020958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755576AbdCTQeA (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:00 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52940 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754143AbdCTQd6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:58 -0400
X-AuditID: 12074412-4bbff70000000b04-fb-58d004706891
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 87.CA.02820.07400D85; Mon, 20 Mar 2017 12:33:52 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9K010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:50 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/20] ref-cache: introduce a new type, ref_cache
Date:   Mon, 20 Mar 2017 17:33:15 +0100
Message-Id: <9fd710e84a0cf1bcdce5dd39cbb52d63a85689ae.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsUixO6iqFvAciHC4OlDEYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6MY9vusxTs0ar4MfMGUwPjO6UuRg4OCQETiY5J4l2MXBxCAjuYJDYs
        +sMI4Zxikmh49g3I4eRgE9CVWNTTzARiiwioSUxsO8QCUsQs8IhR4ur8u+wgCWEBR4mt9+cy
        g9gsAqoS999fYAWxeQWiJHo/XWIBsSUE5CV2tV0Ei3MKWEh8ud8IFhcSMJfoXNDLPoGRZwEj
        wypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkHAS2sG4/qTcIUYBDkYlHt4V
        V85HCLEmlhVX5h5ilORgUhLlfXobKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEt+olUI43JbGy
        KrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYKXHRg3QoJFqempFWmZOSUIaSYO
        TpDhPEDDFUBqeIsLEnOLM9Mh8qcYFaXEec8xASUEQBIZpXlwvbB4f8UoDvSKMO9XkCoeYKqA
        634FNJgJaPCyG2dABpckIqSkGhgrdOuWOqd8EwyInP10FY/n4stP3Bz/2vOYyT1ZeWiF5RTd
        ddxmHiaJh7bLFX3zbPqinN/BKHXlxvH9l0qfN+2Ys1Hvy8YFOSvVFN7lleQmHpBoeCEt3vfl
        sXFE/53kfdbqbK+ytb/vjfQU+PlCVWBRiYBaquaUk5cnLfvPeuTTkjtLNdfOsvyrxFKckWio
        xVxUnAgAosOuC9ICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now, it just wraps a `ref_entry *` that points at the root of the
tree. Soon it will hold more information.

Add two new functions, `create_ref_cache()` and `free_ref_cache()`.
Make `free_ref_entry()` private.

Change files-backend to use this type to hold its caches.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 28 +++++++++++++++++-----------
 refs/ref-cache.c     | 16 +++++++++++++++-
 refs/ref-cache.h     | 15 ++++++++++++++-
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f07e93d522..a7d912ae39 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -44,7 +44,7 @@ static int entry_resolves_to_object(struct ref_entry *entry)
 }
 
 struct packed_ref_cache {
-	struct ref_entry *root;
+	struct ref_cache *cache;
 
 	/*
 	 * Count of references to the data structure in this instance,
@@ -79,7 +79,7 @@ struct files_ref_store {
 	char *gitcommondir;
 	char *packed_refs_path;
 
-	struct ref_entry *loose;
+	struct ref_cache *loose;
 	struct packed_ref_cache *packed;
 };
 
@@ -101,7 +101,7 @@ static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
 static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 {
 	if (!--packed_refs->referrers) {
-		free_ref_entry(packed_refs->root);
+		free_ref_cache(packed_refs->cache);
 		stat_validity_clear(&packed_refs->validity);
 		free(packed_refs);
 		return 1;
@@ -125,7 +125,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
 static void clear_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (refs->loose) {
-		free_ref_entry(refs->loose);
+		free_ref_cache(refs->loose);
 		refs->loose = NULL;
 	}
 }
@@ -387,11 +387,12 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
 		acquire_packed_ref_cache(refs->packed);
-		refs->packed->root = create_dir_entry(refs, "", 0, 0);
+		refs->packed->cache = create_ref_cache(refs);
+		refs->packed->cache->root->flag &= ~REF_INCOMPLETE;
 		f = fopen(packed_refs_file, "r");
 		if (f) {
 			stat_validity_update(&refs->packed->validity, fileno(f));
-			read_packed_refs(f, get_ref_dir(refs->packed->root));
+			read_packed_refs(f, get_ref_dir(refs->packed->cache->root));
 			fclose(f);
 		}
 	}
@@ -400,7 +401,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 
 static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_cache)
 {
-	return get_ref_dir(packed_ref_cache->root);
+	return get_ref_dir(packed_ref_cache->cache->root);
 }
 
 static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
@@ -515,14 +516,19 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 		 * are about to read the only subdirectory that can
 		 * hold references:
 		 */
-		refs->loose = create_dir_entry(refs, "", 0, 0);
+		refs->loose = create_ref_cache(refs);
+
+		/* We're going to fill the top level ourselves: */
+		refs->loose->root->flag &= ~REF_INCOMPLETE;
+
 		/*
-		 * Create an incomplete entry for "refs/":
+		 * Add an incomplete entry for "refs/" (to be filled
+		 * lazily):
 		 */
-		add_entry_to_dir(get_ref_dir(refs->loose),
+		add_entry_to_dir(get_ref_dir(refs->loose->root),
 				 create_dir_entry(refs, "refs/", 5, 1));
 	}
-	return get_ref_dir(refs->loose);
+	return get_ref_dir(refs->loose->root);
 }
 
 /*
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 4274a43a9b..bf911028c8 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -63,9 +63,17 @@ struct ref_entry *create_ref_entry(const char *refname,
 	return ref;
 }
 
+struct ref_cache *create_ref_cache(struct files_ref_store *refs)
+{
+	struct ref_cache *ret = xcalloc(1, sizeof(*ret));
+
+	ret->root = create_dir_entry(refs, "", 0, 1);
+	return ret;
+}
+
 static void clear_ref_dir(struct ref_dir *dir);
 
-void free_ref_entry(struct ref_entry *entry)
+static void free_ref_entry(struct ref_entry *entry)
 {
 	if (entry->flag & REF_DIR) {
 		/*
@@ -77,6 +85,12 @@ void free_ref_entry(struct ref_entry *entry)
 	free(entry);
 }
 
+void free_ref_cache(struct ref_cache *cache)
+{
+	free_ref_entry(cache->root);
+	free(cache);
+}
+
 /*
  * Clear and free all entries in dir, recursively.
  */
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 2e7b1a366e..da5388c136 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,6 +1,10 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
+struct ref_cache {
+	struct ref_entry *root;
+};
+
 /*
  * Information used (along with the information in ref_entry) to
  * describe a single cached reference.  This data structure only
@@ -165,7 +169,16 @@ struct ref_entry *create_ref_entry(const char *refname,
 				   const unsigned char *sha1, int flag,
 				   int check_name);
 
-void free_ref_entry(struct ref_entry *entry);
+/*
+ * Return a pointer to a new `ref_cache`. Its top-level starts out
+ * marked incomplete.
+ */
+struct ref_cache *create_ref_cache(struct files_ref_store *refs);
+
+/*
+ * Free the `ref_cache` and all of its associated data.
+ */
+void free_ref_cache(struct ref_cache *cache);
 
 /*
  * Add a ref_entry to the end of dir (unsorted).  Entry is always
-- 
2.11.0

