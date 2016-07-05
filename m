Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67742023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbcGELYN (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:60402 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932720AbcGELYC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:02 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MBq8p-1bBuXt058Z-00Am92; Tue, 05 Jul 2016 13:23:54
 +0200
Date:	Tue, 5 Jul 2016 13:23:53 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 10/17] merge-recursive: switch to returning errors instead
 of dying
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <109a08b8c31d35cfbb5e82e3016446a2a5f774b3.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AbY9YgS0VU8h6f2Qi1pbxRTrAyV13D55sZ8CA7fm+FoDKijTFua
 Agktu2Gf58uWrSqUs+daACi783Ak63kUGfHeghGFIZ1La5yBf9vq3vWyUrnYUmGYkXdgQ0n
 PBj7fN8dpalO5Vy4H3xvWZnjGyq76rxVPXKFhKSeamqrZ1j5an1hofivzSOmxMJfEnEDbhB
 IQQZnnMB53tMPESJWJb2A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YzH8Olsk77s=:TLBHUwaoHNcFIC2uyqgeVC
 eoM0WC7pmNIBA2its3tsJfovNm5vchPre+BcUPMfh5jVONWtF8pGynJ7jECgz5/muIPS096JP
 DdOWBCKHxb/3Q+Cd02ooh4rn4sCK+xWo0a+PpB4YHi1BDm8P9/nqQifCj+BijkUWDF0uB8mPK
 zLP84Va+IWoA0ikYhT47rkfxuw2jUCNLr5hHt/T1LXOGI/zsiRDJClvg5Kj2arTfbBhjxC4k8
 F5qQRxx7FHfRZgQYpOAVh6dRVB6w9+t1TKNAJYtGV/l9Rts/gIUViq6E1QD9Z1uZneVsmciL0
 +R0prGoLbp4MglzlmmJpxr6aHokGkp5SuRQi2E5/rL+biBY5gOkK1SIQtbGhxFoevanwy5YY7
 rlT71qKZCpKnKDytF/WRUuNX5gtWGe6BrqRttbQuG27mKqEG9J88qhXpU0IfBg0rjGc0VSqtU
 REmvyS43AE0p3HIJw2orKTsLWrSCK1mwifZEX40O4mwegG+alayqf2gXfsbF42lDDBSL4Y23R
 /i4uRevSsKgyoKyXuRLsPMn4uBptPTKNfUj0Kz8zxAwj174+V/JRMAekgEm+fsrVv82fYeMqb
 lJTFNU3sj+UXavKVYy2BYS4BOBUtChZ8NvEtfLuQ4o8oCsMoNM2zpLAzeH+vddTXURnBdr8gM
 MEBHh657TTrVudyyQE4Qmtq2HToeqh/HSI7oXXsM6Lu2mLB8wmdIxxdQElKBIHpvFnEbZtkyo
 PAQVG8U+ZXnZDHnp68c9v5xGOI8zoiAVcFPfje9Ivk/rUgzHnS04qI1NVXEL77dMA8EhAq8T5
 6AJ7oUN
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The recursive merge machinery is supposed to be a library function, i.e.
it should return an error when it fails. Originally the functions were
part of the builtin "merge-recursive", though, where it was simpler to
call die() and be done with error handling.

The existing callers were already prepared to detect negative return
values to indicate errors and to behave as previously: exit with code 128
(which is the same thing that die() does, after printing the message).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 59 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 209427c..10010a4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -266,8 +266,10 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		active_cache_tree = cache_tree();
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
-	    cache_tree_update(&the_index, 0) < 0)
-		die(_("error building trees"));
+	    cache_tree_update(&the_index, 0) < 0) {
+		error(_("error building trees"));
+		return NULL;
+	}
 
 	result = lookup_tree(active_cache_tree->sha1);
 
@@ -708,12 +710,10 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	/* Make sure leading directories are created */
 	status = safe_create_leading_directories_const(path);
 	if (status) {
-		if (status == SCLD_EXISTS) {
+		if (status == SCLD_EXISTS)
 			/* something else exists */
-			error(msg, path, _(": perhaps a D/F conflict?"));
-			return -1;
-		}
-		die(msg, path, "");
+			return error(msg, path, _(": perhaps a D/F conflict?"));
+		return error(msg, path, "");
 	}
 
 	/*
@@ -741,6 +741,8 @@ static int update_file_flags(struct merge_options *o,
 			      int update_cache,
 			      int update_wd)
 {
+	int ret = 0;
+
 	if (o->call_depth)
 		update_wd = 0;
 
@@ -761,9 +763,11 @@ static int update_file_flags(struct merge_options *o,
 
 		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
-			die(_("cannot read object %s '%s'"), sha1_to_hex(sha), path);
-		if (type != OBJ_BLOB)
-			die(_("blob expected for %s '%s'"), sha1_to_hex(sha), path);
+			return error(_("cannot read object %s '%s'"), sha1_to_hex(sha), path);
+		if (type != OBJ_BLOB) {
+			ret = error(_("blob expected for %s '%s'"), sha1_to_hex(sha), path);
+			goto free_buf;
+		}
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
 			if (convert_to_working_tree(path, buf, size, &strbuf)) {
@@ -784,8 +788,10 @@ static int update_file_flags(struct merge_options *o,
 			else
 				mode = 0666;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
-			if (fd < 0)
-				die_errno(_("failed to open '%s'"), path);
+			if (fd < 0) {
+				ret = error_errno(_("failed to open '%s'"), path);
+				goto free_buf;
+			}
 			write_in_full(fd, buf, size);
 			close(fd);
 		} else if (S_ISLNK(mode)) {
@@ -793,18 +799,18 @@ static int update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				die_errno(_("failed to symlink '%s'"), path);
+				ret = error_errno(_("failed to symlink '%s'"), path);
 			free(lnk);
 		} else
-			die(_("do not know what to do with %06o %s '%s'"),
-			    mode, sha1_to_hex(sha), path);
+			ret = error(_("do not know what to do with %06o %s '%s'"),
+				mode, sha1_to_hex(sha), path);
  free_buf:
 		free(buf);
 	}
  update_index:
-	if (update_cache)
+	if (!ret && update_cache)
 		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
-	return 0;
+	return ret;
 }
 
 static int update_file(struct merge_options *o,
@@ -930,20 +936,22 @@ static int merge_file_1(struct merge_options *o,
 			hashcpy(result->sha, a->sha1);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
-			int merge_status;
+			int ret = 0, merge_status;
 
 			merge_status = merge_3way(o, &result_buf, one, a, b,
 						  branch1, branch2);
 
 			if ((merge_status < 0) || !result_buf.ptr)
-				die(_("Failed to execute internal merge"));
+				ret = error(_("Failed to execute internal merge"));
 
-			if (write_sha1_file(result_buf.ptr, result_buf.size,
+			if (!ret && write_sha1_file(result_buf.ptr, result_buf.size,
 					    blob_type, result->sha))
-				die(_("Unable to add %s to database"),
-				    a->path);
+				ret = error(_("Unable to add %s to database"),
+					a->path);
 
 			free(result_buf.ptr);
+			if (ret)
+				return ret;
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
 			result->clean = merge_submodule(result->sha,
@@ -1868,11 +1876,10 @@ int merge_trees(struct merge_options *o,
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
-			die(_("merging of trees %s and %s failed"),
+			error(_("merging of trees %s and %s failed"),
 			    oid_to_hex(&head->object.oid),
 			    oid_to_hex(&merge->object.oid));
-		else
-			exit(128);
+		return -1;
 	}
 
 	if (unmerged_cache()) {
@@ -2003,7 +2010,7 @@ int merge_recursive(struct merge_options *o,
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
-			die(_("merge returned no commit"));
+			return error(_("merge returned no commit"));
 	}
 
 	discard_cache();
-- 
2.9.0.280.g32e2a70


