Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9611FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 13:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbdBIN2Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 08:28:25 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60632 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750947AbdBIN2P (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 08:28:15 -0500
X-AuditID: 12074411-fbbff700000009b7-c9-589c6e34392e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 98.0A.02487.43E6C985; Thu,  9 Feb 2017 08:27:17 -0500 (EST)
Received: from bagpipes.fritz.box (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19DRB5D023019
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 08:27:15 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/5] refs: store submodule ref stores in a hashmap
Date:   Thu,  9 Feb 2017 14:26:58 +0100
Message-Id: <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqGuWNyfCYP8eJouuK91MFg29V5gt
        +pd3sVncXjGf2WLJw9fMFt1T3jJabN7czuLA7vH3/Qcmj52z7rJ7fPgY57FgU6lHV/sRNo+L
        l5Q9Pm+SC2CP4rJJSc3JLEst0rdL4Mr41H6GrWCmfMWm2+eZGxhXSHYxcnJICJhIvH9wkLGL
        kYtDSOAyo0TjgZnMEM5JJontB+ewglSxCehKLOppZgKxRQTUJCa2HWIBKWIWWM8kcXreB7Ai
        YQEniS/HL4IVsQioSjR2HWYDsXkFoiRmHb3EArFOTuLSti/MIDangIXE7wlXGEFsIQFzib/H
        vzNNYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkwAR3MM44KXeI
        UYCDUYmH94L17Agh1sSy4srcQ4ySHExKorwR/4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhT
        cuZECPGmJFZWpRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHj/gjQKFqWmp1ak
        ZeaUIKSZODhBhvMADZ8BNry4IDG3ODMdIn+KUVFKnDcbJCEAksgozYPrhSWAV4ziQK8I8x4C
        qeIBJg+47ldAg5mABl8/PQtkcEkiQkqqgdHkr8nLMzZRX2xSZsVr+/K+ka75t8Hc99+biXtm
        ulyQE7bsey2yoZB3u8qRD1m/ly+59jHxqcmbu5mbk/d9vZXs4Tj7j/oHBstI/4VXai45Hj8m
        esws7kxyvVHghWfcby4mPvz+r2TZxKIDUqKLLz5TiizdN8HY7J+h0eNA1b9PXi1i8Wc+f7Fc
        iaU4I9FQi7moOBEACg0tgdsCAAA=
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
 refs.c               | 61 ++++++++++++++++++++++++++++++++++++++++------------
 refs/refs-internal.h |  6 ------
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index cd36b64..50d192c 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
  */
 
 #include "cache.h"
+#include "hashmap.h"
 #include "lockfile.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
@@ -1357,11 +1358,42 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
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
+	const char *submodule = keydata;
+
+	return strcmp(e1->submodule, submodule ? submodule : e2->submodule);
+}
+
+static struct submodule_hash_entry *alloc_submodule_hash_entry(
+		const char *submodule, struct ref_store *refs)
+{
+	size_t len = strlen(submodule);
+	struct submodule_hash_entry *entry = malloc(sizeof(*entry) + len + 1);
+
+	hashmap_entry_init(entry, strhash(submodule));
+	entry->refs = refs;
+	memcpy(entry->submodule, submodule, len + 1);
+	return entry;
+}
+
 /* A pointer to the ref_store for the main repository: */
 static struct ref_store *main_ref_store;
 
-/* A linked list of ref_stores for submodules: */
-static struct ref_store *submodule_ref_stores;
+/* A hashmap of ref_stores, stored by submodule name: */
+static struct hashmap submodule_ref_stores;
 
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be,
@@ -1373,16 +1405,17 @@ void base_ref_store_init(struct ref_store *refs,
 			die("BUG: main_ref_store initialized twice");
 
 		refs->submodule = "";
-		refs->next = NULL;
 		main_ref_store = refs;
 	} else {
-		if (lookup_ref_store(submodule))
+		refs->submodule = xstrdup(submodule);
+
+		if (!submodule_ref_stores.tablesize)
+			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);
+
+		if (hashmap_put(&submodule_ref_stores,
+				alloc_submodule_hash_entry(submodule, refs)))
 			die("BUG: ref_store for submodule '%s' initialized twice",
 			    submodule);
-
-		refs->submodule = xstrdup(submodule);
-		refs->next = submodule_ref_stores;
-		submodule_ref_stores = refs;
 	}
 }
 
@@ -1402,17 +1435,17 @@ struct ref_store *ref_store_init(const char *submodule)
 
 struct ref_store *lookup_ref_store(const char *submodule)
 {
-	struct ref_store *refs;
+	struct submodule_hash_entry *entry;
 
 	if (!submodule || !*submodule)
 		return main_ref_store;
 
-	for (refs = submodule_ref_stores; refs; refs = refs->next) {
-		if (!strcmp(submodule, refs->submodule))
-			return refs;
-	}
+	if (!submodule_ref_stores.tablesize)
+		hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);
 
-	return NULL;
+	entry = hashmap_get_from_hash(&submodule_ref_stores,
+				      strhash(submodule), submodule);
+	return entry ? entry->refs : NULL;
 }
 
 struct ref_store *get_ref_store(const char *submodule)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 25444cf..4ed5f89 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -634,12 +634,6 @@ struct ref_store {
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

