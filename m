Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298DB2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbcGGOgR (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:53882 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbcGGOgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:36:11 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LdpcB-1blOcS3dwJ-00j590; Thu, 07 Jul 2016 16:35:56
 +0200
Date:	Thu, 7 Jul 2016 16:35:53 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 10/16] merge-recursive: switch to returning errors instead
 of dying
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <c0b4356c3469231c7b6ebe5a031acc98937f6746.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:shaMq3L37EG99bqWfUJZZV7FryoB7bxEJEVjbHJ4cQzk9Ny4zJr
 r3TPBrXInYhzHtSf2KpV38NHouBP/oar2aZ0+puTQLDn0STDXIfkRx2cDjpjC0jBuj3m635
 7FgjItdCsM+iWTwcNV+F50Cmuk7RN7P/tkmAV7dYCclxqHH4dFbxefax5pzrfizMtGj/9SF
 sHns9Cxw5qnG7hCbg0r5Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ivZRu9vxZL4=:2km1blux8XA5kWTfQSHDqq
 lWsqBWbtP3hIHGk6kIvmNiIbXiZYh+NX7ttPtsGZn8WA9gn7d493wiKyud8abTYbQelDxulfI
 jvlvxcLJvGhnkEEt5KrAKKv6XpIXeehp6yyD4p5PLddwOYRnZwyhlUdduPmtFxdpQiQrr2PYt
 VoyE0QYOfUmw4xX1FZHCImtAUqyaniiwDLF+5wwFR3193K69USnkJHUAEBLiJIaPs/o8R7WkR
 JIgGBNQFtEcohK/cq/w132YnpN2Uiz5rK3ETgKlPJSwZgS2IMtQG7uaD+5yIHavbtr5NQes/a
 2gHowX5fCjM8gAtAVbh4QZoWO0V4/SXJlDWF1aV/EJXxMzKgI4LqfbndSwhnFLDyhN8IeIe25
 6l/cMe5jQvksXJAn2O9UpvgsOGmCWM/N5MFJj2Tr29RCi7KGmhVOjccXjQM57R1lecCSBu5V9
 2uxSxVcI6+kQUP+w6kG3il2oPjMGq+wwa3+NoyOzZjLYcEo44a151WuR7Uaiw5zzHxBMa/z/t
 2qDia/PPiVX5EObcgzAi9f2cl4emYieQk2s05pWXJ5H/DVhuoMalPDwZi5HbcipCM0qbjPiGB
 PyR/rCGzkBay1ZJcSVC1ZT0gQFtqGGx240V/533UO2WiHVReorJ/MxHCAFojFr1sV6wPQgQjI
 bAb/MAMa2FLM2lD1US9VscgN0KuTyimGces5bKLB4V1PaAq5BXtvXxg2acf32nCHzkr0q+8TX
 MUvfWQf9nbuMyr/lLewM0+W1NysBd0eoWK0aVOzsfcSiEy3OkBWozfABW7bc2lSQUZsjrh87s
 dk4wbEL
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
 merge-recursive.c | 63 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 89eb937..7c9f22c 100644
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
 
@@ -707,12 +709,10 @@ static int make_room_for_path(struct merge_options *o, const char *path)
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
@@ -740,6 +740,8 @@ static int update_file_flags(struct merge_options *o,
 			      int update_cache,
 			      int update_wd)
 {
+	int ret = 0;
+
 	if (o->call_depth)
 		update_wd = 0;
 
@@ -760,9 +762,11 @@ static int update_file_flags(struct merge_options *o,
 
 		buf = read_sha1_file(oid->hash, &type, &size);
 		if (!buf)
-			die(_("cannot read object %s '%s'"), oid_to_hex(oid), path);
-		if (type != OBJ_BLOB)
-			die(_("blob expected for %s '%s'"), oid_to_hex(oid), path);
+			return error(_("cannot read object %s '%s'"), oid_to_hex(oid), path);
+		if (type != OBJ_BLOB) {
+			ret = error(_("blob expected for %s '%s'"), oid_to_hex(oid), path);
+			goto free_buf;
+		}
 
 		if (make_room_for_path(o, path) < 0) {
 			update_wd = 0;
@@ -778,8 +782,10 @@ static int update_file_flags(struct merge_options *o,
 			else
 				mode = 0666;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
-			if (fd < 0)
-				die_errno(_("failed to open '%s'"), path);
+			if (fd < 0) {
+				ret = error_errno(_("failed to open '%s'"), path);
+				goto free_buf;
+			}
 
 			smudge_to_file = can_smudge_to_file(path);
 
@@ -792,8 +798,10 @@ static int update_file_flags(struct merge_options *o,
 					 * creation. */
 					smudge_to_file = 0;
 					fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
-					if (fd < 0)
-						die_errno(_("failed to open '%s'"), path);
+					if (fd < 0) {
+						ret = error_errno(_("failed to open '%s'"), path);
+						goto free_buf;
+					}
 				}
 				else {
 					close(fd);
@@ -817,18 +825,18 @@ static int update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				die_errno(_("failed to symlink '%s'"), path);
+				ret = error_errno(_("failed to symlink '%s'"), path);
 			free(lnk);
 		} else
-			die(_("do not know what to do with %06o %s '%s'"),
+			ret = error(_("do not know what to do with %06o %s '%s'"),
 			    mode, oid_to_hex(oid), path);
  free_buf:
 		free(buf);
 	}
  update_index:
-	if (update_cache)
+	if (!ret && update_cache)
 		add_cacheinfo(mode, oid, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
-	return 0;
+	return ret;
 }
 
 static int update_file(struct merge_options *o,
@@ -954,20 +962,22 @@ static int merge_file_1(struct merge_options *o,
 			oidcpy(&result->oid, &a->oid);
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
 					    blob_type, result->oid.hash))
-				die(_("Unable to add %s to database"),
-				    a->path);
+				ret = error(_("Unable to add %s to database"),
+					a->path);
 
 			free(result_buf.ptr);
+			if (ret)
+				return ret;
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
 			result->clean = merge_submodule(result->oid.hash,
@@ -1899,11 +1909,10 @@ int merge_trees(struct merge_options *o,
 
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
@@ -2034,7 +2043,7 @@ int merge_recursive(struct merge_options *o,
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
-			die(_("merge returned no commit"));
+			return error(_("merge returned no commit"));
 	}
 
 	discard_cache();
-- 
2.9.0.278.g1caae67


