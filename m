Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C746A1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 13:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbdBIN2Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 08:28:24 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54265 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750994AbdBIN2P (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 08:28:15 -0500
X-AuditID: 12074412-5ddff700000009b5-47-589c6e37ef9c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B5.29.02485.73E6C985; Thu,  9 Feb 2017 08:27:20 -0500 (EST)
Received: from bagpipes.fritz.box (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19DRB5F023019
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 08:27:18 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/5] register_ref_store(): new function
Date:   Thu,  9 Feb 2017 14:27:00 +0100
Message-Id: <ce326e17822184eff434b957d28f2233795162db.1486629195.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqGuRNyfC4Oo1MYuuK91MFg29V5gt
        +pd3sVncXjGf2WLJw9fMFt1T3jJabN7czuLA7vH3/Qcmj52z7rJ7fPgY57FgU6lHV/sRNo+L
        l5Q9Pm+SC2CP4rJJSc3JLEst0rdL4MqYdmodc8E62Yp5DY+YGxg/iXcxcnJICJhItF35y9TF
        yMUhJHCZUWLR0+vsEM5JJonJa+4xglSxCehKLOppZgKxRQTUJCa2HWIBKWIWWM8kcXreB9Yu
        Rg4OYQFziZ/bc0BqWARUJeauucsOYvMKREl8ejyfFWKbnMSlbV+YQWxOAQuJ3xOugM0XAmr9
        e/w70wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQsJLaAfj+pNy
        hxgFOBiVeHgrLGdHCLEmlhVX5h5ilORgUhLljfgPFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
        m5IzJ0KINyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mC9y9Io2BRanpq
        RVpmTglCmomDE2Q4D9DwK2DDiwsSc4sz0yHypxgVpcR5s0ESAiCJjNI8uF5Y/L9iFAd6RZjX
        KheoigeYOuC6XwENZgIafP30LJDBJYkIKakGxphLT0/ev58453ju5uTXd+Ilujb0Xg/bLCfl
        q2y79VzCDl9RnoYFt2Qbgh1jO+cqMZv++y0o/39FuNGiDa+nXWoO3KRZtCmDZ0Ng2I6i0PgF
        c88H/ZNPYd3ec3I1y6SzWyY0eh9TtXVpEspitliYnbF4AcvLt4u831UxxT/cIeewIvXwVGEX
        TyWW4oxEQy3mouJEANZRG8LaAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the responsibility for registering the ref_store for a submodule
from base_ref_store_init() to a new function, register_ref_store(). Call
the latter from ref_store_init().

This means that base_ref_store_init() can lose its submodule argument,
further weakening the 1:1 relationship between ref_stores and
submodules.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 19 +++++++++++++------
 refs/files-backend.c |  2 +-
 refs/refs-internal.h | 15 ++++++++++-----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 723b4be..6012f67 100644
--- a/refs.c
+++ b/refs.c
@@ -1395,11 +1395,8 @@ static struct ref_store *main_ref_store;
 /* A hashmap of ref_stores, stored by submodule name: */
 static struct hashmap submodule_ref_stores;
 
-void base_ref_store_init(struct ref_store *refs,
-			 const struct ref_storage_be *be,
-			 const char *submodule)
+void register_ref_store(struct ref_store *refs, const char *submodule)
 {
-	refs->be = be;
 	if (!submodule) {
 		if (main_ref_store)
 			die("BUG: main_ref_store initialized twice");
@@ -1416,18 +1413,28 @@ void base_ref_store_init(struct ref_store *refs,
 	}
 }
 
+void base_ref_store_init(struct ref_store *refs,
+			 const struct ref_storage_be *be)
+{
+	refs->be = be;
+}
+
 struct ref_store *ref_store_init(const char *submodule)
 {
 	const char *be_name = "files";
 	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+	struct ref_store *refs;
 
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
 	if (!submodule || !*submodule)
-		return be->init(NULL);
+		refs = be->init(NULL);
 	else
-		return be->init(submodule);
+		refs = be->init(submodule);
+
+	register_ref_store(refs, submodule);
+	return refs;
 }
 
 struct ref_store *lookup_ref_store(const char *submodule)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6ed7e13..794b88c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -980,7 +980,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 
-	base_ref_store_init(ref_store, &refs_be_files, submodule);
+	base_ref_store_init(ref_store, &refs_be_files);
 
 	refs->submodule = submodule ? xstrdup(submodule) : "";
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 97f275b..73281f5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -481,7 +481,7 @@ struct ref_store;
  * Initialize the ref_store for the specified submodule, or for the
  * main repository if submodule == NULL. These functions should call
  * base_ref_store_init() to initialize the shared part of the
- * ref_store and to record the ref_store for later lookup.
+ * ref_store.
  */
 typedef struct ref_store *ref_store_init_fn(const char *submodule);
 
@@ -630,12 +630,17 @@ struct ref_store {
 };
 
 /*
- * Fill in the generic part of refs for the specified submodule and
- * add it to our collection of reference stores.
+ * Register the specified ref_store to be the one that should be used
+ * for submodule (or the main repository if submodule is NULL). It is
+ * a fatal error to call this function twice for the same submodule.
+ */
+void register_ref_store(struct ref_store *refs, const char *submodule);
+
+/*
+ * Fill in the generic part of refs.
  */
 void base_ref_store_init(struct ref_store *refs,
-			 const struct ref_storage_be *be,
-			 const char *submodule);
+			 const struct ref_storage_be *be);
 
 /*
  * Create, record, and return a ref_store instance for the specified
-- 
2.9.3

