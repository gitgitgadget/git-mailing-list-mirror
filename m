Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75075207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046154AbdDWVgB (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:36:01 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37406 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046099AbdDWVfh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A4590280B9;
        Sun, 23 Apr 2017 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983331;
        bh=eN3XzFg30T0sCz9w/PAlQaGdS/QN1D+ycIQHB8cqw3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1b3MOi5L1T4EwtWdHQUkCbOh8IAfWJZR+E7NpkctGr6dOyo/0HA8ARblCj1Aub3w
         Sfwaq+OOR2rnIXMyDR6hH4OZB+r3dFdNJtLqY1wgaqF/EV1eSQt5H758d9atwvIsKQ
         08ZM8WOAP7WWNbwXI3bYNA6LRtG9wJIyhqcJHxl8xBXspLM3VOvH6XtwrdyGDrDgUL
         XxGMID5Ic5eJAYqX6THfvcfGPVv7rEEVmBszGOBPbTvVOUIlTWE0qs1OWXtSBayTI2
         1tBqyfT+4Ewm7DIwdDSEA26CdoC6Xsqz5aBKMU5Ok1nge2U/aBiRK+c9JL4wsr8k7o
         4wApLIm6aRMm+GbsW63VIjRQAsfn+mK2lcexmpoP4ODGpC8cXnf69QTvBlqgfJ+DXa
         8zEuW3H5Z+g4w73LI3s709k5dFa9bNgi/TuX6eleMcxFqNUp9SfrNuhYfdV23Lxvad
         /XCx+XNXN54xceHJx18U2hmT0wt+qJaTCnICcANsMftND/yJCS0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/53] submodule: convert merge_submodule to use struct object_id
Date:   Sun, 23 Apr 2017 21:34:12 +0000
Message-Id: <20170423213453.253425-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
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
index 5615d7392..fb782c412 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1567,9 +1567,9 @@ static void print_commit(struct commit *commit)
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
@@ -1578,14 +1578,14 @@ int merge_submodule(unsigned char result[20], const char *path,
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
@@ -1593,9 +1593,9 @@ int merge_submodule(unsigned char result[20], const char *path,
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
@@ -1609,11 +1609,11 @@ int merge_submodule(unsigned char result[20], const char *path,
 
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
