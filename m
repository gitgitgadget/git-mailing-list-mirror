Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDF71FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbdBJLQ7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:59 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752899AbdBJLQj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:39 -0500
X-AuditID: 1207440d-97fff70000000a35-92-589da111fc46
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 94.1C.02613.111AD985; Fri, 10 Feb 2017 06:16:33 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLi025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:32 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/9] refs: store submodule ref stores in a hashmap
Date:   Fri, 10 Feb 2017 12:16:15 +0100
Message-Id: <3f4b16b0816d13283cb25885eb3fdafd70caa2e7.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqCu4cG6EwcMec4uuK91MFg29V5gt
        +pd3sVncXjGf2WLJw9fMFt1T3jJa/GjpYbbYvLmdxYHD4+/7D0weO2fdZff48DHOY8GmUo+u
        9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxvkfX9gLLspW9N01aGD8LN7FyMkh
        IWAi8XXSE8YuRi4OIYHLjBILDl9jBUkICZxikli5xw7EZhPQlVjU08wEYosIqElMbDvEAmIz
        g9ScWwAWFxZwlWi4+Z6ti5GDg0VAVWLC4XiQMK9AlMTKAw+YIXbJSVza9gXM5hSwkPh34gwz
        xCpzieOrjjJPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMk2Hh3
        MP5fJ3OIUYCDUYmH90XNnAgh1sSy4srcQ4ySHExKorzfZ8yNEOJLyk+pzEgszogvKs1JLT7E
        KMHBrCTCa9MBlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAyLABq
        FCxKTU+tSMvMKUFIM3FwggznARrODlLDW1yQmFucmQ6RP8WoKCXOWzcfKCEAksgozYPrhSWD
        V4ziQK8I84qBtPMAEwlc9yugwUxAg6+fngUyuCQRISXVwDjPMPXIKunEUM7eXRPdS3fmlbql
        fPy+smjG4nsnZts+0/a7r8MbZm+2Nqnr+YPU9evEDVffeXgqtvgB81JDrpVmMx9ILYw/MKVx
        a90RtqfR+tW7WsPUq1Sev/MuXbRFqf7g49tmcrxhsrucmTTnW5d5L85kfMwSw/Sjl5UlrChX
        Yw2P0a3JT5VYijMSDbWYi4oTAalH1CvhAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aside from scaling better, this means that the submodule name needn't be
stored in the ref_store instance anymore (which will be changed in a
moment). This, in turn, will help loosen the strict 1:1 relationship
between ref_stores and submodules.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 58 ++++++++++++++++++++++++++++++++++++++++------------
 refs/refs-internal.h |  6 ------
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index d7158b6..5121c57 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
  */
 
 #include "cache.h"
+#include "hashmap.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
@@ -1352,11 +1353,41 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	return 0;
 }
 
+struct submodule_hash_entry
+{
+	struct hashmap_entry ent; /* must be the first member! */
+
+	struct ref_store *refs;
+
+	/* NUL-terminated name of submodule: */
+	char submodule[FLEX_ARRAY];
+};
+
+static int submodule_hash_cmp(const void *entry, const void *entry_or_key,
+			      const void *keydata)
+{
+	const struct submodule_hash_entry *e1 = entry, *e2 = entry_or_key;
+	const char *submodule = keydata ? keydata : e2->submodule;
+
+	return strcmp(e1->submodule, submodule);
+}
+
+static struct submodule_hash_entry *alloc_submodule_hash_entry(
+		const char *submodule, struct ref_store *refs)
+{
+	struct submodule_hash_entry *entry;
+
+	FLEX_ALLOC_STR(entry, submodule, submodule);
+	hashmap_entry_init(entry, strhash(submodule));
+	entry->refs = refs;
+	return entry;
+}
+
 /* A pointer to the ref_store for the main repository: */
 static struct ref_store *main_ref_store;
 
-/* A linked list of ref_stores for submodules: */
-static struct ref_store *submodule_ref_stores;
+/* A hashmap of ref_stores, stored by submodule name: */
+static struct hashmap submodule_ref_stores;
 
 /*
  * Return the ref_store instance for the specified submodule (or the
@@ -1365,17 +1396,18 @@ static struct ref_store *submodule_ref_stores;
  */
 static struct ref_store *lookup_ref_store(const char *submodule)
 {
-	struct ref_store *refs;
+	struct submodule_hash_entry *entry;
 
 	if (!submodule)
 		return main_ref_store;
 
-	for (refs = submodule_ref_stores; refs; refs = refs->next) {
-		if (!strcmp(submodule, refs->submodule))
-			return refs;
-	}
+	if (!submodule_ref_stores.tablesize)
+		/* It's initialized on demand in register_ref_store(). */
+		return NULL;
 
-	return NULL;
+	entry = hashmap_get_from_hash(&submodule_ref_stores,
+				      strhash(submodule), submodule);
+	return entry ? entry->refs : NULL;
 }
 
 /*
@@ -1389,15 +1421,15 @@ static void register_ref_store(struct ref_store *refs, const char *submodule)
 		if (main_ref_store)
 			die("BUG: main_ref_store initialized twice");
 
-		refs->next = NULL;
 		main_ref_store = refs;
 	} else {
-		if (lookup_ref_store(submodule))
+		if (!submodule_ref_stores.tablesize)
+			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 0);
+
+		if (hashmap_put(&submodule_ref_stores,
+				alloc_submodule_hash_entry(submodule, refs)))
 			die("BUG: ref_store for submodule '%s' initialized twice",
 			    submodule);
-
-		refs->next = submodule_ref_stores;
-		submodule_ref_stores = refs;
 	}
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d8a7eb1..07fd208 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -636,12 +636,6 @@ struct ref_store {
 	 * reference store:
 	 */
 	const char *submodule;
-
-	/*
-	 * Submodule reference store instances are stored in a linked
-	 * list using this pointer.
-	 */
-	struct ref_store *next;
 };
 
 /*
-- 
2.9.3

