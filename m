Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117C4203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061AbcGZQGu (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:06:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:56891 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756786AbcGZQGr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:47 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M5q45-1b7wd40Ihd-00xqqA; Tue, 26 Jul 2016 18:06:39
 +0200
Date:	Tue, 26 Jul 2016 18:06:26 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 10/16] merge-recursive: switch to returning errors instead
 of dying
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <2729997e6e07e3548ab6aae34ffca5f6828ff6cf.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b4MsaOvtjrlSNLCOrLESWi+KSOWAat3/AsiNNJf0DJ5V2ODQmrN
 gbcPb0xOR9Hu5KON5wNUS8LKdVlLOxB7Woq3eRRInxr5m3QKYOXCnsniA39G66HBmWOPGUw
 5RBoqQZ5fOg+11yEXMwy15o+/4x1r8lkmoXzU7hoN1FVAh5UUa7uy0qk/KlSQ2I7ZVrXcSp
 QKyvfeuy8fDALzUTsF/2g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:gY6DeQTHwcY=:vfKKVRiywSJgstRBZuCx67
 dnf+gwY7rgXiVDb0hXfmPexvDRcawcr+lX1wLOmBr2QlPTUO560wh9AHmp3igFnY6+WTucR9r
 xmKoCPvc1SV4HmI3TiK8/8GKIL8fL9B/vA7mhJZE9NxXUiRg7yMRejhsOxjMy8NezxlCHXIN9
 6JuNFL5boJEL0Xq0Ja1KbGKL9G8/MbTxBI1TOFWEw4ETjsiiwamtQE0xr/qplbuVr3hVwXvZ4
 9qecEVJrUAfX5hpIbYiRN619z+VHSKoD77HramHrht8HqkfJj6AqG3wqDEajg7dnOyRPLUoZP
 HW4Kgc95UisjEEr5TrTf+0USz2oAzujPC9mPjedEFIX1MSOA/9+1z8x2K2JWLARseFl9ROYs/
 82wsAiWldFb4yR/8nz1C+9IJs5cwH74YtC7KgWD/jJmWRK2p6ldV4Rl7uITw1lUfIWMkTPh9i
 +8+4McYHDUpekWlwSxIYR89rCjYAF4xw7UDEEfKwMnFtzaCO2lRgtqYqhLNAijbiyHInpLYIL
 NyIR3V4fE0kFxQ1AzU556tKpgp17wvi095ODUdFyryrhd6kxtViU26iF33lYgvvEVv1vnv31U
 d9S4XvT6j2AzfysKuAeSjYcCqOE/h0SDEvu5XV8JAsuNDC6KjQvh9rJJ5R5cKMJJXUz7BorFe
 sah9VghgsvQmJOjLQD8Ca0yxNxWppU+z7YExhoJTx1QamR76oph+leVWZj6hRFYRmbzLbhGR8
 VdKSZpRjHbZmwPJSyMsxp3GZDB/a+pfRK0Gs0nRR4HpGAzRXjQTMp8RpWaOrZe3vmXFm2HNiC
 MbF6OMW
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
index 6beb1e4..bc59815 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -275,8 +275,10 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		active_cache_tree = cache_tree();
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
-	    cache_tree_update(&the_index, 0) < 0)
-		die(_("error building trees"));
+	    cache_tree_update(&the_index, 0) < 0) {
+		error(_("error building trees"));
+		return NULL;
+	}
 
 	result = lookup_tree(active_cache_tree->sha1);
 
@@ -716,12 +718,10 @@ static int make_room_for_path(struct merge_options *o, const char *path)
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
@@ -749,6 +749,8 @@ static int update_file_flags(struct merge_options *o,
 			     int update_cache,
 			     int update_wd)
 {
+	int ret = 0;
+
 	if (o->call_depth)
 		update_wd = 0;
 
@@ -769,9 +771,11 @@ static int update_file_flags(struct merge_options *o,
 
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
@@ -792,8 +796,11 @@ static int update_file_flags(struct merge_options *o,
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
@@ -801,18 +808,18 @@ static int update_file_flags(struct merge_options *o,
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
@@ -938,20 +945,22 @@ static int merge_file_1(struct merge_options *o,
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
@@ -1885,11 +1894,10 @@ int merge_trees(struct merge_options *o,
 
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
@@ -2021,7 +2029,7 @@ int merge_recursive(struct merge_options *o,
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
-			die(_("merge returned no commit"));
+			return error(_("merge returned no commit"));
 	}
 
 	discard_cache();
-- 
2.9.0.281.g286a8d9


