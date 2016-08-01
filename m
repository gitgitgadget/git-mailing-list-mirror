Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44BE21F955
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbcHALpc (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:54881 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283AbcHALpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LgISa-1ayN4C062W-00nfSr; Mon, 01 Aug 2016 13:44:20
 +0200
Date:	Mon, 1 Aug 2016 13:44:17 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 07/16] merge-recursive: avoid returning a wholesale
 struct
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <4cbe2757bd921a202c359382086fadeb2616434a.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L0plT+VCcsLka6Yi2N+0i9vbId5ZvRakF0vXmtyoYahjNkFId99
 Dx1r9aKrw4VjuHPV3SEQ36rTHY4IZcRvaakKQe3kkC4BXPx0WdZYNE/QQVHIpWYpp+C8qF4
 AaT7jR69DMcLqZrgyQoQ8zFBE3cyKYI8XmGut7DdZ2pT+fK23tS40GTpia9gbnObVF5vmJs
 ZCjflwDADA8qXNHkPbJeQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YnAprurS4O0=:22BTM33f/Nzd+O4MenKro6
 FVaKOEIFXZcySopLL2dc7GgczprG1e/l8Z0EdiLKSl15l1HV/hbGuWkMpa9ldPyr0P10+/iwK
 pmythH9dpiABViMpgKcy0YQ2ZCxJ+IpPBfp8f5roNrhYkXM8r9bscNISfW8l8k0UKBVGORqKU
 X+kuAqHTs1UoAxPgUxN/lssdEvf37scJiY/HPcuouSCaRnKTBRoOBnbeF5nzeO2+R2i0G+3E9
 EsoCC8/iI5WW9qAiSBzzrBPZxmK7+5jwUaYvwoiBzJz2Sva8inXwn3UTAOju8gpZvRenB6tg/
 PZJTjIMkbvz1Q2icUdt1ssjatQR/D4l+X+fmCkl5JX9NARLrCiDem9MmsC07okt9sCS/x3yVn
 OmLju3tXCgM46gBtEStvrMkLelag7mk02vM51UpuSvSHzvxJ3h4Uf9WoLHE+fHCnCepHP0Qlf
 VjjgZ79PncMyQ4UAt6FcX78Gmvid+6EKLy4nTei7Q/El3uCgujSYoIrAZDRTTlOEOo5A/DUVO
 6aHJE8a5dVKWq4c0LdjVunM7DT00HJTgWkG+E/AVWqaZnjtbABPeOUvrnTcLhQd45NIXNofpu
 XjDa2rN0WoxcpH9JaI+MZE1d6gk8ExQITTW5l9ipsYe2ZazuQWMdoXpJkppI+tTkdI8PJaAfH
 kIjq6moIgK/UQ348hpy8kwQRvrvmXjvDfI+/xVima5SN+yc6jEwo291jG0OYfg3PeUg4GLzFR
 XQW01D0Kz1nyQWbE+LEFmlz72FAkvYOaFt7MDCTyjEM11TELhMZ9abbz290JsMHNtZZJI4eOq
 Vh+PvA8
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
 merge-recursive.c | 106 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 50 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 58ced25..2be1e17 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -894,47 +894,47 @@ static int merge_3way(struct merge_options *o,
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
@@ -946,64 +946,66 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
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
+			   side1 ? side1 : branch1,
+			   side2 ? side2 : branch2, mfi);
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
 
@@ -1014,7 +1016,7 @@ static struct merge_file_info merge_file_one(struct merge_options *o,
 	a.mode = a_mode;
 	oidcpy(&b.oid, b_oid);
 	b.mode = b_mode;
-	return merge_file_1(o, &one, &a, &b, branch1, branch2);
+	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
 static void handle_change_delete(struct merge_options *o,
@@ -1187,11 +1189,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
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
@@ -1245,12 +1248,13 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
 
-	mfi_c1 = merge_file_special_markers(o, a, c1, &ci->ren1_other,
-					    o->branch1, c1->path,
-					    o->branch2, ci->ren1_other.path);
-	mfi_c2 = merge_file_special_markers(o, b, &ci->ren2_other, c2,
-					    o->branch1, ci->ren2_other.path,
-					    o->branch2, c2->path);
+	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
+				       o->branch1, c1->path,
+				       o->branch2, ci->ren1_other.path, &mfi_c1) ||
+	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
+				       o->branch1, ci->ren2_other.path,
+				       o->branch2, c2->path, &mfi_c2))
+		return;
 
 	if (o->call_depth) {
 		/*
@@ -1473,12 +1477,13 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					mfi = merge_file_one(o, ren1_dst, &null_oid, 0,
-							 &ren1->pair->two->oid,
-							 ren1->pair->two->mode,
-							 &dst_other.oid,
-							 dst_other.mode,
-							 branch1, branch2);
+					if (merge_file_one(o, ren1_dst, &null_oid, 0,
+							   &ren1->pair->two->oid,
+							   ren1->pair->two->mode,
+							   &dst_other.oid,
+							   dst_other.mode,
+							   branch1, branch2, &mfi))
+						return -1;
 					output(o, 1, _("Adding merged %s"), ren1_dst);
 					update_file(o, 0, &mfi.oid,
 						    mfi.mode, ren1_dst);
@@ -1636,9 +1641,10 @@ static int merge_content(struct merge_options *o,
 		if (dir_in_way(path, !o->call_depth))
 			df_conflict_remains = 1;
 	}
-	mfi = merge_file_special_markers(o, &one, &a, &b,
-					 o->branch1, path1,
-					 o->branch2, path2);
+	if (merge_file_special_markers(o, &one, &a, &b,
+				       o->branch1, path1,
+				       o->branch2, path2, &mfi))
+		return -1;
 
 	if (mfi.clean && !df_conflict_remains &&
 	    oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
-- 
2.9.0.281.g286a8d9


