Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4541FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbcFXXJ6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:09:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52616 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751465AbcFXXJo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:44 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 96BA42809F;
	Fri, 24 Jun 2016 23:09:42 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809783;
	bh=pw3c/eoeSw/sGPpcEiqbP6k1eTLgoR6kfenrCm7hv+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izNLTM8RPYO+cx//VVK0w/DVUqr/9hAeLUbcfDsABHkyOAjzEhQvKWSYrjgVBtnjk
	 WLzX7CxO3ovp2ZvFjdNpWNk/NDXCZOaPMk55FhQCxBMLERbiJUAkOzccAdpvUhMDW0
	 mIbLmLhIo6p3RP/aYDKfe7axCAP9s89SFoHuf4sDoBsYTmqU3ko8+LbzQRao5ScDiI
	 lBqx3b4Bq7IMW8IKGjAdySdRG3yoDNcDuTqdMV5JttHN1ftf/husH6WxWYddznoiAs
	 8A8JPYQqRMZx0tWePNv2OQTW5R14EPT51TJ0YTJqLqOltgF1JwM+8QlBq6e+tcZy9/
	 dOCLqC/pMPWrckSpAP7/n+TX5zmPKGRhX3GBbkSt3m/gPZGQDaEqEXTA5G/m/HPkUT
	 NIAkPRaH/va5WNcN2LF5PCIYoMkJzvwXYC+zK8g9erPsWxN25I1qaYAYcYnXnMvKL3
	 uOQFuLmhQ72PueBk82kcfASa/TM+n/pdPM1oE56vC7idzksTYm2
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 08/11] merge-recursive: convert struct merge_file_info to object_id
Date:	Fri, 24 Jun 2016 23:09:26 +0000
Message-Id: <20160624230929.82222-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160624230929.82222-1-sandals@crustytoothpaste.net>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Convert struct merge_file_info to use struct object_id.  The following
Coccinelle semantic patch was used to implement this, followed by the
transformations in object_id.cocci:

@@
struct merge_file_info o;
@@
- o.sha
+ o.oid.hash

@@
struct merge_file_info *p;
@@
- p->sha
+ p->oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a07050cd..bc455491 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -819,7 +819,7 @@ static void update_file(struct merge_options *o,
 /* Low level file merging, update and removal */
 
 struct merge_file_info {
-	unsigned char sha[20];
+	struct object_id oid;
 	unsigned mode;
 	unsigned clean:1,
 		 merge:1;
@@ -902,10 +902,10 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 		result.clean = 0;
 		if (S_ISREG(a->mode)) {
 			result.mode = a->mode;
-			hashcpy(result.sha, a->oid.hash);
+			oidcpy(&result.oid, &a->oid);
 		} else {
 			result.mode = b->mode;
-			hashcpy(result.sha, b->oid.hash);
+			oidcpy(&result.oid, &b->oid);
 		}
 	} else {
 		if (!sha_eq(a->oid.hash, one->oid.hash) && !sha_eq(b->oid.hash, one->oid.hash))
@@ -925,9 +925,9 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 		}
 
 		if (sha_eq(a->oid.hash, b->oid.hash) || sha_eq(a->oid.hash, one->oid.hash))
-			hashcpy(result.sha, b->oid.hash);
+			oidcpy(&result.oid, &b->oid);
 		else if (sha_eq(b->oid.hash, one->oid.hash))
-			hashcpy(result.sha, a->oid.hash);
+			oidcpy(&result.oid, &a->oid);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int merge_status;
@@ -939,21 +939,21 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 				die(_("Failed to execute internal merge"));
 
 			if (write_sha1_file(result_buf.ptr, result_buf.size,
-					    blob_type, result.sha))
+					    blob_type, result.oid.hash))
 				die(_("Unable to add %s to database"),
 				    a->path);
 
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result.clean = merge_submodule(result.sha,
+			result.clean = merge_submodule(result.oid.hash,
 						       one->path,
 						       one->oid.hash,
 						       a->oid.hash,
 						       b->oid.hash,
 						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
-			hashcpy(result.sha, a->oid.hash);
+			oidcpy(&result.oid, &a->oid);
 
 			if (!sha_eq(a->oid.hash, b->oid.hash))
 				result.clean = 0;
@@ -1192,7 +1192,7 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		update_file(o, 0, mfi.sha, mfi.mode, one->path);
+		update_file(o, 0, mfi.oid.hash, mfi.mode, one->path);
 
 		/*
 		 * Above, we put the merged content at the merge-base's
@@ -1255,16 +1255,16 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		 * again later for the non-recursive merge.
 		 */
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, a->path);
-		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, b->path);
+		update_file(o, 0, mfi_c1.oid.hash, mfi_c1.mode, a->path);
+		update_file(o, 0, mfi_c2.oid.hash, mfi_c2.mode, b->path);
 	} else {
 		char *new_path1 = unique_path(o, path, ci->branch1);
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, new_path1);
-		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, new_path2);
+		update_file(o, 0, mfi_c1.oid.hash, mfi_c1.mode, new_path1);
+		update_file(o, 0, mfi_c2.oid.hash, mfi_c2.mode, new_path2);
 		free(new_path2);
 		free(new_path1);
 	}
@@ -1474,7 +1474,8 @@ static int process_renames(struct merge_options *o,
 							 dst_other.mode,
 							 branch1, branch2);
 					output(o, 1, _("Adding merged %s"), ren1_dst);
-					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
+					update_file(o, 0, mfi.oid.hash,
+						    mfi.mode, ren1_dst);
 					try_merge = 0;
 				} else {
 					char *new_path = unique_path(o, ren1_dst, branch2);
@@ -1634,7 +1635,7 @@ static int merge_content(struct merge_options *o,
 					 o->branch2, path2);
 
 	if (mfi.clean && !df_conflict_remains &&
-	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
+	    sha_eq(mfi.oid.hash, a_sha) && mfi.mode == a_mode) {
 		int path_renamed_outside_HEAD;
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		/*
@@ -1645,7 +1646,7 @@ static int merge_content(struct merge_options *o,
 		 */
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
-			add_cacheinfo(mfi.mode, mfi.sha, path,
+			add_cacheinfo(mfi.mode, mfi.oid.hash, path,
 				      0, (!o->call_depth), 0);
 			return mfi.clean;
 		}
@@ -1671,7 +1672,7 @@ static int merge_content(struct merge_options *o,
 			else {
 				int file_from_stage2 = was_tracked(path);
 				struct diff_filespec merged;
-				hashcpy(merged.oid.hash, mfi.sha);
+				oidcpy(&merged.oid, &mfi.oid);
 				merged.mode = mfi.mode;
 
 				update_stages(path, NULL,
@@ -1682,11 +1683,11 @@ static int merge_content(struct merge_options *o,
 		}
 		new_path = unique_path(o, path, rename_conflict_info->branch1);
 		output(o, 1, _("Adding as %s instead"), new_path);
-		update_file(o, 0, mfi.sha, mfi.mode, new_path);
+		update_file(o, 0, mfi.oid.hash, mfi.mode, new_path);
 		free(new_path);
 		mfi.clean = 0;
 	} else {
-		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
+		update_file(o, mfi.clean, mfi.oid.hash, mfi.mode, path);
 	}
 	return mfi.clean;
 
