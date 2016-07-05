Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404172023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbcGELYD (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:58782 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932866AbcGELXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:23:48 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LeN3N-1betPi0HpV-00qE2G; Tue, 05 Jul 2016 13:23:39
 +0200
Date:	Tue, 5 Jul 2016 13:23:38 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 07/17] merge-recursive: avoid returning a wholesale
 struct
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <435b2f32f52f6bec73ce702f71510eb9363e99ef.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IN3f4tzi8E8EXDNsWkbkAuUTisSDVXmxHHEOZ3D8WcXpCHTqk2i
 k3wSVFRFlPI8nFzknP1RH9YN8xBqPLokOhEAgKs5CguuCI2nWu9tPQXMgcL17yyJTHP0fSR
 4Fc69DNYCuUFpltrK3iIVPJqC84LXame/vjgWl4semtgiwsmsmYQgDSKRrq0TtxlMv0p4Lw
 e+tQCtv7OLp8349I1gzMg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:4fAuzyDfuLc=:gLpDozR8AHa4KLrXKCKls6
 Qfnz48zUWVDYKSvameNKYgMJpD1399SFmf7crnPzvEHKpvsq9MIqNFbizHIL2TnzlwW6jqpdQ
 RlLPzlfC2Ogzb7mmq0TyZ81wREC4z/tOMPD17njPPt0P7A6o+SR8Lp6Df0DY3vUb+TLV+LNUN
 oq2C0Gb5No5cyGDQV+FelPA1d5dEdKK6+Dxu0Z8PVllF1c+3SZoix6x5EfPRl/giQOIm2DT9r
 9MHVJyCtJuRLAIelsoarAOdc+eLax0a/5x6DApIUsL7Uf3SdDB0jFTNqEnaCjTwMH/Opsknq8
 trKqYUH6u6NXaXdP0Ro9LB38khRWhW78GxLA6aPzTGHHQ2iGB7QgvKI79zlsd7yIDPb6vfwm5
 DrXF+OaXZoFeMLUMC8ikTvUib8sTl//FZB5FxczdmDdaIJ5iotF1KQ4C7mPBtbaN5vNMgD532
 p4EZ9p8NC3pnN5JEk0vDxO/ZW47Uw1ZIFtDj2Su5+o5Qgq+cztXOM49pWqIS1e4DOLNJ/ZdGt
 lDiaHVSph29S8FAYPDOmsu+ItKwMpIDBkRdF9NpSzRHXLDxSFpxq9uZ/efirqvy5GV9r45cz7
 GETVclRlS0DvgGHvCXZrahgRBd7XwqX2b+lOLDH677sn2pm3y0DFkjc70quk8EZcLM/OuVbdk
 FXZLo7m+bmueU9cukOUrGQWr9dRVobc4Pz0AHyebtwVY+Kqn+1uPdgXGpZc11+7jyBNrjL3QA
 NLFGhJKH0G3YdJXBv5wqlcNRKHNEweyjpaEcR8T6SJS6TYoGhh//c7VFDEfz2pHAuw3Kmev+z
 WKTOXF8
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
 merge-recursive.c | 93 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 716488b..3e3667f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -886,47 +886,47 @@ static int merge_3way(struct merge_options *o,
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
-			hashcpy(result.sha, a->sha1);
+			result->mode = a->mode;
+			hashcpy(result->sha, a->sha1);
 		} else {
-			result.mode = b->mode;
-			hashcpy(result.sha, b->sha1);
+			result->mode = b->mode;
+			hashcpy(result->sha, b->sha1);
 		}
 	} else {
 		if (!sha_eq(a->sha1, one->sha1) && !sha_eq(b->sha1, one->sha1))
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
 
 		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, one->sha1))
-			hashcpy(result.sha, b->sha1);
+			hashcpy(result->sha, b->sha1);
 		else if (sha_eq(b->sha1, one->sha1))
-			hashcpy(result.sha, a->sha1);
+			hashcpy(result->sha, a->sha1);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int merge_status;
@@ -938,62 +938,63 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 				die(_("Failed to execute internal merge"));
 
 			if (write_sha1_file(result_buf.ptr, result_buf.size,
-					    blob_type, result.sha))
+					    blob_type, result->sha))
 				die(_("Unable to add %s to database"),
 				    a->path);
 
 			free(result_buf.ptr);
-			result.clean = (merge_status == 0);
+			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
-			result.clean = merge_submodule(result.sha,
+			result->clean = merge_submodule(result->sha,
 						       one->path, one->sha1,
 						       a->sha1, b->sha1,
 						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
-			hashcpy(result.sha, a->sha1);
+			hashcpy(result->sha, a->sha1);
 
 			if (!sha_eq(a->sha1, b->sha1))
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
 					 const unsigned char *o_sha, int o_mode,
 					 const unsigned char *a_sha, int a_mode,
 					 const unsigned char *b_sha, int b_mode,
 					 const char *branch1,
-					 const char *branch2)
+					 const char *branch2,
+					 struct merge_file_info *mfi)
 {
 	struct diff_filespec one, a, b;
 
@@ -1004,7 +1005,7 @@ static struct merge_file_info merge_file_one(struct merge_options *o,
 	a.mode = a_mode;
 	hashcpy(b.sha1, b_sha);
 	b.mode = b_mode;
-	return merge_file_1(o, &one, &a, &b, branch1, branch2);
+	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
 static void handle_change_delete(struct merge_options *o,
@@ -1177,11 +1178,14 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		struct merge_file_info mfi;
 		struct diff_filespec other;
 		struct diff_filespec *add;
-		mfi = merge_file_one(o, one->path,
+
+		if (merge_file_one(o, one->path,
 				 one->sha1, one->mode,
 				 a->sha1, a->mode,
 				 b->sha1, b->mode,
-				 ci->branch1, ci->branch2);
+				 ci->branch1, ci->branch2, &mfi))
+			return;
+
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
@@ -1235,12 +1239,13 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
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
@@ -1461,10 +1466,11 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					mfi = merge_file_one(o, ren1_dst, null_sha1, 0,
+					if (merge_file_one(o, ren1_dst, null_sha1, 0,
 							 ren1->pair->two->sha1, ren1->pair->two->mode,
 							 dst_other.sha1, dst_other.mode,
-							 branch1, branch2);
+							 branch1, branch2, &mfi))
+						return -1;
 					output(o, 1, _("Adding merged %s"), ren1_dst);
 					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
 					try_merge = 0;
@@ -1620,9 +1626,10 @@ static int merge_content(struct merge_options *o,
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
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
-- 
2.9.0.280.g32e2a70


