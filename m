Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336BB20195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbcGVMZs (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:25:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:64240 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbcGVMZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:25:47 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MKHMk-1bR81E2502-001j60; Fri, 22 Jul 2016 14:25:38
 +0200
Date:	Fri, 22 Jul 2016 14:25:36 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 10/16] merge-recursive: switch to returning errors instead
 of dying
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <41bf328361a52df72c268fc37cffe6806b2447dd.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lKP+2f/6nc4V9zL5VfzZKf9CXdCITZ5fbocW20XWM2ZKoIRAVd0
 9Vq8rnKlQxkkf4d8fgtD4J8NH28CCTdte3ImIDKKlmx4FzYTJGjsRw5pD1ihSNFaz1WCFSP
 /h7XSJVEEmQrgw5ONOFHnuZ50gL25YGne+EItgogWcGyfiLDZ8Sk4z3N+ZeuzFISUfDbW/h
 HT44P17N0CueQX8pnaLRA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/kD4d88H8nw=:pzN+aiC+PGtP2Iz3i7X50U
 FBG1RxIewReRcbPvvt3t/vUxKHQ/XjCZM7vpnKyeU8PUgZH1/eEDdXDARw8k227FXc9Zug/0h
 80nM+UI77SYoKMiIGHFjpn4U/MlsyYr7yS0CYHiw1g4AL0fIxAnBbdk9Rtv1UepPd1X5zV++t
 nEuZI4DebP+Gkr4VfXXyvK2lIR/tdG96+hW5nI21Yysm5pM/JuAc3bQpOD4xtazNHPcweJXss
 2Dd5CwUoWnnYtmTKLkQSUtzmGV4i+h0d/VX5WDGFXXzIU3y9lsEfSBHelmEDsf6un65B2CK76
 nEt9BzPjp7mKRGLcQT5Obx4ist+yHgtB6zzHnl/CdShF3+6PLq6R0ZG0M8BOCBV2gQ2/zdEm+
 jfDSn9PTMlBlDHDFjzxSG2oV2x0V20ZoWc9ixLZ/v4e4uGq2gx3S0K4lgRFdk1XpgXAdgSrI4
 IhJYwDgPu8q331zyATMa+q18LRKs0gYz8zf38JjQQxXBZU0RePsAYhHFmRR60G364Pn7M5Iz2
 wp3Y2Eg7/IgOoyLGB6GvuMCDYu6BXPU4PKa50dMU9NJlecL4OFhROToVarh7kxJN0dSkXhd3z
 hLusWpoakEwUnqbnpSdMnU/0ZEbD9LtNsDmmcCt9e/FbjZ1hAr//JFAGUyHmRe5/RqTH6Ntui
 lrtUT7SY6mwdddYvnwe/wLwLt8RWzY4fEpfl0/2fPJ+SCBnt9ItSJi4NTIj4IbLh5P48RL+RW
 lLifwAacwN8TpCFTuk8IPbwNGNjlNHAhBb67PZuhgpuMpKNuhdqlbndLlRCpwaPIbmu2ze1lq
 QGuay9P
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
 merge-recursive.c | 62 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 697ba03..24b42d6 100644
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
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
 			if (convert_to_working_tree(path, buf, size, &strbuf)) {
@@ -783,8 +787,11 @@ static int update_file_flags(struct merge_options *o,
 			else
 				mode = 0666;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
-			if (fd < 0)
-				die_errno(_("failed to open '%s'"), path);
+			if (fd < 0) {
+				ret = error_errno(_("failed to open '%s'"),
+						  path);
+				goto free_buf;
+			}
 			write_in_full(fd, buf, size);
 			close(fd);
 		} else if (S_ISLNK(mode)) {
@@ -792,18 +799,18 @@ static int update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				die_errno(_("failed to symlink '%s'"), path);
+				ret = error_errno(_("failed to symlink '%s'"), path);
 			free(lnk);
 		} else
-			die(_("do not know what to do with %06o %s '%s'"),
-			    mode, oid_to_hex(oid), path);
+			ret = error(_("do not know what to do with %06o %s '%s'"),
+				    mode, oid_to_hex(oid), path);
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
@@ -929,20 +936,22 @@ static int merge_file_1(struct merge_options *o,
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
-					    blob_type, result->oid.hash))
-				die(_("Unable to add %s to database"),
-				    a->path);
+			if (!ret && write_sha1_file(result_buf.ptr, result_buf.size,
+						    blob_type, result->oid.hash))
+				ret = error(_("Unable to add %s to database"),
+					    a->path);
 
 			free(result_buf.ptr);
+			if (ret)
+				return ret;
 			result->clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
 			result->clean = merge_submodule(result->oid.hash,
@@ -1876,11 +1885,10 @@ int merge_trees(struct merge_options *o,
 
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
@@ -2011,7 +2019,7 @@ int merge_recursive(struct merge_options *o,
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
-			die(_("merge returned no commit"));
+			return error(_("merge returned no commit"));
 	}
 
 	discard_cache();
-- 
2.9.0.281.g286a8d9


