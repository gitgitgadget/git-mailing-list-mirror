Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8089A2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbcGGOgA (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:51558 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbcGGOf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:58 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LuKHz-1bSdHT1MAh-011gMb; Thu, 07 Jul 2016 16:35:44
 +0200
Date:	Thu, 7 Jul 2016 16:35:43 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 07/16] merge-recursive: avoid returning a wholesale
 struct
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <d47bec8d5e711ca346f3f50551ca0765f715f26c.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1quLr4UEJko8s7CBIUibxv63LGUNq+pPoiBCY6u2w8oGOxGPxKm
 GziLqy4vJDWSYpJwentpG3uYo6QBHW2to2jYabaZhGs0+sxzQAX2ea4s3UX0dWbLsV+onkZ
 dzWIIGqNvyA0bATpo2s+rmvltU2Kk4Q9NXlrYzn6Zln4Wxgcl17elvNqMCpBEknoh1nojcs
 PXPxIQHRA3WWLPXACho4w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:F0g1XlgduSQ=:o5CEuN1HHcRGh8zIfGnQAB
 rM6faN7r8fCfrYreylAjlnlukpOR5gLyu+7rA4p30IFDoQcjq/Oq7DvVP2Q7B4pXe1BrWyKlh
 2cgUtcs3Wmc2STkeFUXk9sbXBWlR4gqe9b5qpRvvrYUGw9ojBZyiognFwvGkv6CC8Egp2B73r
 xrNP2m7I63X7auTqKv95nEsIr6chSvauw3xlVLC66ktdtnyqzYYRaHmyCc1H5cM6QaN5Wjork
 NxYiATpTj9Hqs36Z5sdG7nHh1hrCHmLBM3B3Fg0KMsauIqtJ0cPnybqbQOSjjlFQ23/QhB3lx
 L6WrPySHdi4BFOu9ncAbP1ykiI7M+verag0uTw1KjSBs3Z8T03LwJldHXucUptSNQ5U3mbEPS
 FSfdMmfTOYv24ywnTcpbgo+Cy8bk/PmHWJwZUzl1MDfUKUZEG9fOGbfuBXdq95BLtNe8h4JSg
 I9Ph5761vy9hUxGRPpz8tp5SB7yaZf4a7lFHKYK3KTO5Unce2QNS330ufplMQYE3bKkSTjCZR
 TiIus8uLDP7N+234CPBpKgzH/k7mbiBei1W+iDnyBJ0X8cyk8viOFv0HgDQO16PJt3mTqZE2l
 J2bfisHvyYYvnPrpRzZfLRAg/OXMzZkAEIcmWK9bPKUQjzh0v69QjWIcKWmmqajpfISq+rAT8
 qs1Wgppk3+qymiOIKsrklJdfl13srEzys7mAqOeBgwY6c6jt5DWdjxaJWVYDsi2il8xZNk76S
 fpGrdUnGljYmgQlB2Zy3/7wD/YppSWd2lbE9EPbX8OKCSZWUoRUSGleLhbFG8na52v1UwVZlO
 e+ujgbM
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is technically allowed, as per C89, for functions' return type to
be complete structs (i.e. *not* just pointers to structs).

However, it was just an oversight of this developer when converting
Python code to C code in 6d297f8 (Status update on merge-recursive in
C, 2006-07-08) which introduced such a return type.

Besides, by converting this construct to pass in the struct, we can now
start returning a value that can indicate errors in future patches. This
will help the current effort to libify merge-recursive.c.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 91 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 37c181a..d9221ce 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -910,47 +910,47 @@ static int merge_3way(struct merge_options *o,
 	return merge_status;
 }
 
-static struct merge_file_info merge_file_1(struct merge_options *o,
+static int merge_file_1(struct merge_options *o,
 					   const struct diff_filespec *one,
 					   const struct diff_filespec *a,
 					   const struct diff_filespec *b,
 					   const char *branch1,
-					   const char *branch2)
+					   const char *branch2,
+					   struct merge_file_info *result)
 {
-	struct merge_file_info result;
-	result.merge = 0;
-	result.clean = 1;
+	result->merge = 0;
+	result->clean = 1;
 
 	if ((S_IFMT & a->mode) != (S_IFMT & b->mode)) {
-		result.clean = 0;
+		result->clean = 0;
 		if (S_ISREG(a->mode)) {
-			result.mode = a->mode;
-			oidcpy(&result.oid, &a->oid);
+			result->mode = a->mode;
+			oidcpy(&result->oid, &a->oid);
 		} else {
-			result.mode = b->mode;
-			oidcpy(&result.oid, &b->oid);
+			result->mode = b->mode;
+			oidcpy(&result->oid, &b->oid);
 		}
 	} else {
 		if (!oid_eq(&a->oid, &one->oid) && !oid_eq(&b->oid, &one->oid))
-			result.merge = 1;
+			result->merge = 1;
 
 		/*
 		 * Merge modes
 		 */
 		if (a->mode == b->mode || a->mode == one->mode)
-			result.mode = b->mode;
+			result->mode = b->mode;
 		else {
-			result.mode = a->mode;
+			result->mode = a->mode;
 			if (b->mode != one->mode) {
-				result.clean = 0;
-				result.merge = 1;
+				result->clean = 0;
+				result->merge = 1;
 			}
 		}
 
 		if (oid_eq(&a->oid, &b->oid) || oid_eq(&a->oid, &one->oid))
-			oidcpy(&result.oid, &b->oid);
+			oidcpy(&result->oid, &b->oid);
 		else if (oid_eq(&b->oid, &one->oid))
-			oidcpy(&result.oid, &a->oid);
+			oidcpy(&result->oid, &a->oid);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int merge_status;
@@ -962,64 +962,65 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 				die(_("Failed to execute internal merge"));
 
 			if (write_sha1_file(result_buf.ptr, result_buf.size,
-					    blob_type, result.oid.hash))
+					    blob_type, result->oid.hash))
 				die(_("Unable to add %s to database"),
 				    a->path);
 
 			free(result_buf.ptr);
-			result.clean = (merge_status == 0);
+			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result.clean = merge_submodule(result.oid.hash,
+			result->clean = merge_submodule(result->oid.hash,
 						       one->path,
 						       one->oid.hash,
 						       a->oid.hash,
 						       b->oid.hash,
 						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
-			oidcpy(&result.oid, &a->oid);
+			oidcpy(&result->oid, &a->oid);
 
 			if (!oid_eq(&a->oid, &b->oid))
-				result.clean = 0;
+				result->clean = 0;
 		} else
 			die("BUG: unsupported object type in the tree");
 	}
 
-	return result;
+	return 0;
 }
 
-static struct merge_file_info
-merge_file_special_markers(struct merge_options *o,
+static int merge_file_special_markers(struct merge_options *o,
 			   const struct diff_filespec *one,
 			   const struct diff_filespec *a,
 			   const struct diff_filespec *b,
 			   const char *branch1,
 			   const char *filename1,
 			   const char *branch2,
-			   const char *filename2)
+			   const char *filename2,
+			   struct merge_file_info *mfi)
 {
 	char *side1 = NULL;
 	char *side2 = NULL;
-	struct merge_file_info mfi;
+	int ret;
 
 	if (filename1)
 		side1 = xstrfmt("%s:%s", branch1, filename1);
 	if (filename2)
 		side2 = xstrfmt("%s:%s", branch2, filename2);
 
-	mfi = merge_file_1(o, one, a, b,
-			   side1 ? side1 : branch1, side2 ? side2 : branch2);
+	ret = merge_file_1(o, one, a, b,
+		side1 ? side1 : branch1, side2 ? side2 : branch2, mfi);
 	free(side1);
 	free(side2);
-	return mfi;
+	return ret;
 }
 
-static struct merge_file_info merge_file_one(struct merge_options *o,
+static int merge_file_one(struct merge_options *o,
 					 const char *path,
 					 const struct object_id *o_oid, int o_mode,
 					 const struct object_id *a_oid, int a_mode,
 					 const struct object_id *b_oid, int b_mode,
 					 const char *branch1,
-					 const char *branch2)
+					 const char *branch2,
+					 struct merge_file_info *mfi)
 {
 	struct diff_filespec one, a, b;
 
@@ -1030,7 +1031,7 @@ static struct merge_file_info merge_file_one(struct merge_options *o,
 	a.mode = a_mode;
 	oidcpy(&b.oid, b_oid);
 	b.mode = b_mode;
-	return merge_file_1(o, &one, &a, &b, branch1, branch2);
+	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
 static void handle_change_delete(struct merge_options *o,
@@ -1203,11 +1204,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		struct merge_file_info mfi;
 		struct diff_filespec other;
 		struct diff_filespec *add;
-		mfi = merge_file_one(o, one->path,
+		if (merge_file_one(o, one->path,
 				 &one->oid, one->mode,
 				 &a->oid, a->mode,
 				 &b->oid, b->mode,
-				 ci->branch1, ci->branch2);
+				 ci->branch1, ci->branch2, &mfi))
+			return;
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
@@ -1261,12 +1263,13 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
 
-	mfi_c1 = merge_file_special_markers(o, a, c1, &ci->ren1_other,
+	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
 					    o->branch1, c1->path,
-					    o->branch2, ci->ren1_other.path);
-	mfi_c2 = merge_file_special_markers(o, b, &ci->ren2_other, c2,
+					    o->branch2, ci->ren1_other.path, &mfi_c1) ||
+	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
 					    o->branch1, ci->ren2_other.path,
-					    o->branch2, c2->path);
+					    o->branch2, c2->path, &mfi_c2))
+		return;
 
 	if (o->call_depth) {
 		/*
@@ -1489,12 +1492,13 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					mfi = merge_file_one(o, ren1_dst, &null_oid, 0,
+					if (merge_file_one(o, ren1_dst, &null_oid, 0,
 							 &ren1->pair->two->oid,
 							 ren1->pair->two->mode,
 							 &dst_other.oid,
 							 dst_other.mode,
-							 branch1, branch2);
+							 branch1, branch2, &mfi))
+						return -1;
 					output(o, 1, _("Adding merged %s"), ren1_dst);
 					update_file(o, 0, &mfi.oid,
 						    mfi.mode, ren1_dst);
@@ -1652,9 +1656,10 @@ static int merge_content(struct merge_options *o,
 		if (dir_in_way(path, !o->call_depth))
 			df_conflict_remains = 1;
 	}
-	mfi = merge_file_special_markers(o, &one, &a, &b,
+	if (merge_file_special_markers(o, &one, &a, &b,
 					 o->branch1, path1,
-					 o->branch2, path2);
+					 o->branch2, path2, &mfi))
+		return -1;
 
 	if (mfi.clean && !df_conflict_remains &&
 	    oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
-- 
2.9.0.278.g1caae67


