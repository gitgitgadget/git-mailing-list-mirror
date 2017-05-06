Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863A8207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbdEFWLh (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:11:37 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37712 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753516AbdEFWLL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 66793280B9;
        Sat,  6 May 2017 22:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108668;
        bh=wEiLCkj4q+qWyS7OCSGpDSfnGCdWlKviIUv1z4ed2Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9smQo6o420og/0CEsbLIwkzcf1GGWn/t47AHAzjX8GFk7e80uxyBLD0VCTrvBfT3
         qme9D+fHCpIKN8MUNHsaA20bwmaus96mkSmjNSXoDz/xR1MEOp1R5i5js4cHkqd6At
         Po57e7Op8Ud5+IG6T+yIuGpbytTXu/VC6VU6b4/qc5rpI0J3cqGxWK2hVIxJVP7wB6
         W2PXaXWcjEz6PkjlsLGKZiWChliheHQgQFMKw0RuDSa+vIUVrhhkLJ7nNanxBojJGV
         EEI8Q924avVLJ1SXKPNGuKhGPrHJw82E/e2vAheezLk7uwzMdv4nLJiDHrQVyzSKXd
         YpA7jKTYGptxHg1Art2rUK4GHoFUl3wUnmuJGwXWtaViPHyaHdI9VWIj9HgTz6Uyjd
         dyI6UQUfS093FLTm3Xl3CVqsTxzpqFIbPL+8iqZdiAXPwNjQPKCmUf2sAqeWBUz+h2
         SZtCWv7XdDAxx/EXJkuVx5vlRuUHijBx5OJEqEkAQ0iZv4PIaVR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 12/53] submodule: convert merge_submodule to use struct object_id
Date:   Sat,  6 May 2017 22:09:57 +0000
Message-Id: <20170506221038.296722-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a caller of lookup_commit_reference, which we will convert
later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 merge-recursive.c |  8 ++++----
 submodule.c       | 24 ++++++++++++------------
 submodule.h       |  8 ++++----
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9d6fd577e..1315a45b9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -994,11 +994,11 @@ static int merge_file_1(struct merge_options *o,
 				return ret;
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result->clean = merge_submodule(result->oid.hash,
+			result->clean = merge_submodule(&result->oid,
 						       one->path,
-						       one->oid.hash,
-						       a->oid.hash,
-						       b->oid.hash,
+						       &one->oid,
+						       &a->oid,
+						       &b->oid,
 						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
 			oidcpy(&result->oid, &a->oid);
diff --git a/submodule.c b/submodule.c
index d3299e29c..9bdd5f605 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1566,9 +1566,9 @@ static void print_commit(struct commit *commit)
 #define MERGE_WARNING(path, msg) \
 	warning("Failed to merge submodule %s (%s)", path, msg);
 
-int merge_submodule(unsigned char result[20], const char *path,
-		    const unsigned char base[20], const unsigned char a[20],
-		    const unsigned char b[20], int search)
+int merge_submodule(struct object_id *result, const char *path,
+		    const struct object_id *base, const struct object_id *a,
+		    const struct object_id *b, int search)
 {
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
@@ -1577,14 +1577,14 @@ int merge_submodule(unsigned char result[20], const char *path,
 	int i;
 
 	/* store a in result in case we fail */
-	hashcpy(result, a);
+	oidcpy(result, a);
 
 	/* we can not handle deletion conflicts */
-	if (is_null_sha1(base))
+	if (is_null_oid(base))
 		return 0;
-	if (is_null_sha1(a))
+	if (is_null_oid(a))
 		return 0;
-	if (is_null_sha1(b))
+	if (is_null_oid(b))
 		return 0;
 
 	if (add_submodule_odb(path)) {
@@ -1592,9 +1592,9 @@ int merge_submodule(unsigned char result[20], const char *path,
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(base)) ||
-	    !(commit_a = lookup_commit_reference(a)) ||
-	    !(commit_b = lookup_commit_reference(b))) {
+	if (!(commit_base = lookup_commit_reference(base->hash)) ||
+	    !(commit_a = lookup_commit_reference(a->hash)) ||
+	    !(commit_b = lookup_commit_reference(b->hash))) {
 		MERGE_WARNING(path, "commits not present");
 		return 0;
 	}
@@ -1608,11 +1608,11 @@ int merge_submodule(unsigned char result[20], const char *path,
 
 	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, commit_b)) {
-		hashcpy(result, b);
+		oidcpy(result, b);
 		return 1;
 	}
 	if (in_merge_bases(commit_b, commit_a)) {
-		hashcpy(result, a);
+		oidcpy(result, a);
 		return 1;
 	}
 
diff --git a/submodule.h b/submodule.h
index 1277480ad..89c2ed219 100644
--- a/submodule.h
+++ b/submodule.h
@@ -84,10 +84,10 @@ extern int submodule_uses_gitfile(const char *path);
 #define SUBMODULE_REMOVAL_IGNORE_UNTRACKED (1<<1)
 #define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
 extern int bad_to_remove_submodule(const char *path, unsigned flags);
-extern int merge_submodule(unsigned char result[20], const char *path,
-			   const unsigned char base[20],
-			   const unsigned char a[20],
-			   const unsigned char b[20], int search);
+extern int merge_submodule(struct object_id *result, const char *path,
+			   const struct object_id *base,
+			   const struct object_id *a,
+			   const struct object_id *b, int search);
 extern int find_unpushed_submodules(struct oid_array *commits,
 				    const char *remotes_name,
 				    struct string_list *needs_pushing);
