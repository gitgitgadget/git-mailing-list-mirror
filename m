Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BEAD1FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbdBJLQn (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:43 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752902AbdBJLQm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:42 -0500
X-AuditID: 1207440d-967ff70000000a35-9c-589da1193520
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B6.1C.02613.911AD985; Fri, 10 Feb 2017 06:16:41 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLm025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:39 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 9/9] read_loose_refs(): read refs using resolve_ref_recursively()
Date:   Fri, 10 Feb 2017 12:16:19 +0100
Message-Id: <d8e906d969700acbca8dc717673d0a9cdc910f62.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqCu5cG6EwcOVahZdV7qZLBp6rzBb
        9C/vYrO4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+7x4WOcx4JNpR5d
        7UfYPJ717mH0uHhJ2ePzJrkAjigum5TUnMyy1CJ9uwSujIlHF7AVPFOqWHrmPnsD4z7pLkZO
        DgkBE4kbF0+ydzFycQgJXGaUOHd/LguEc4pJ4m37PmaQKjYBXYlFPc1MILaIgJrExLZDLCA2
        M0jRuQVAcQ4OYYEQiQvXM0DCLAKqEuv33gIr5xWIktjc+I4FYpmcxKVtX8BGcgpYSPw7cQbM
        FhIwlzi+6ijzBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFCAo53
        B+P/dTKHGAU4GJV4eF/UzIkQYk0sK67MPcQoycGkJMr7fcbcCCG+pPyUyozE4oz4otKc1OJD
        jBIczEoivDYdQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgQvwwKg
        RsGi1PTUirTMnBKENBMHJ8hwHqDh7CA1vMUFibnFmekQ+VOMilLivHXzgRICIImM0jy4XlhC
        eMUoDvSKMK8YSDsPMJnAdb8CGswENPj66Vkgg0sSEVJSDYyzHt28EuT7g/eT5qrtqx33Jxxz
        KYqqV/2yl3uySdKeez1edga9NtU2l/umrmCV+zp10YuJfwtnOz5Yap21bl9n7nyXzQydN9bp
        h1WdreSvszmTdd1L/VihHscGtbuca05WqiwJvfmyYustsdpVMy9fnV8R90ymepunvmLAfY/V
        UtX/1z+tXj5ZiaU4I9FQi7moOBEAliNTRuMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to call read_ref_full() or resolve_gitlink_ref() from
read_loose_refs(), because we already have a ref_store object in hand.
So we can call resolve_ref_recursively() ourselves. Happily, this
unifies the code for the submodule vs. non-submodule cases.

This requires resolve_ref_recursively() to be exposed to the refs
subsystem, though not to non-refs code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 50 +++++++++++++++++++++++++-------------------------
 refs/files-backend.c | 18 ++++--------------
 refs/refs-internal.h |  5 +++++
 3 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/refs.c b/refs.c
index 05af56b..f03dcf5 100644
--- a/refs.c
+++ b/refs.c
@@ -1230,10 +1230,10 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 }
 
 /* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_recursively(struct ref_store *refs,
-					   const char *refname,
-					   int resolve_flags,
-					   unsigned char *sha1, int *flags)
+const char *resolve_ref_recursively(struct ref_store *refs,
+				    const char *refname,
+				    int resolve_flags,
+				    unsigned char *sha1, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	int unused_flags;
@@ -1390,27 +1390,6 @@ static struct ref_store *main_ref_store;
 static struct hashmap submodule_ref_stores;
 
 /*
- * Return the ref_store instance for the specified submodule (or the
- * main repository if submodule is NULL). If that ref_store hasn't
- * been initialized yet, return NULL.
- */
-static struct ref_store *lookup_ref_store(const char *submodule)
-{
-	struct submodule_hash_entry *entry;
-
-	if (!submodule)
-		return main_ref_store;
-
-	if (!submodule_ref_stores.tablesize)
-		/* It's initialized on demand in register_ref_store(). */
-		return NULL;
-
-	entry = hashmap_get_from_hash(&submodule_ref_stores,
-				      strhash(submodule), submodule);
-	return entry ? entry->refs : NULL;
-}
-
-/*
  * Register the specified ref_store to be the one that should be used
  * for submodule (or the main repository if submodule is NULL). It is
  * a fatal error to call this function twice for the same submodule.
@@ -1451,6 +1430,27 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
+/*
+ * Return the ref_store instance for the specified submodule (or the
+ * main repository if submodule is NULL). If that ref_store hasn't
+ * been initialized yet, return NULL.
+ */
+static struct ref_store *lookup_ref_store(const char *submodule)
+{
+	struct submodule_hash_entry *entry;
+
+	if (!submodule)
+		return main_ref_store;
+
+	if (!submodule_ref_stores.tablesize)
+		/* It's initialized on demand in register_ref_store(). */
+		return NULL;
+
+	entry = hashmap_get_from_hash(&submodule_ref_stores,
+				      strhash(submodule), submodule);
+	return entry ? entry->refs : NULL;
+}
+
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4fe92f0..cdb6b8f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1267,20 +1267,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					 create_dir_entry(refs, refname.buf,
 							  refname.len, 1));
 		} else {
-			int read_ok;
-
-			if (refs->submodule) {
-				hashclr(sha1);
-				flag = 0;
-				read_ok = !resolve_gitlink_ref(refs->submodule,
-							       refname.buf, sha1);
-			} else {
-				read_ok = !read_ref_full(refname.buf,
-							 RESOLVE_REF_READING,
-							 sha1, &flag);
-			}
-
-			if (!read_ok) {
+			if (!resolve_ref_recursively(&refs->base,
+						     refname.buf,
+						     RESOLVE_REF_READING,
+						     sha1, &flag)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			} else if (is_null_sha1(sha1)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 793c850..33adbf9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -650,4 +650,9 @@ void base_ref_store_init(struct ref_store *refs,
  */
 struct ref_store *get_ref_store(const char *submodule);
 
+const char *resolve_ref_recursively(struct ref_store *refs,
+				    const char *refname,
+				    int resolve_flags,
+				    unsigned char *sha1, int *flags);
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.9.3

