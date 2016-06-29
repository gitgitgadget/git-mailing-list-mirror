Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69891FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbcF2LhY (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:37:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:60494 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbcF2LhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:37:23 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MhiTL-1avRrS35gh-00Mtns; Wed, 29 Jun 2016 13:37:09
 +0200
Date:	Wed, 29 Jun 2016 13:37:09 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] merge-recursive: switch to returning errors instead of
 dying
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <06c09ab4d684c239ae4ae03373c7cc7afb3be60b.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XA4N9vG3OTpYg4q2g+/+xCy956zOEm7Jte4SZ5md40I/2of8YOp
 nuguPOx5Wa+CXVdYxAiJypIaleA6uhqNe0sHPEfYg4iw/yxh9yfad8s+ocNYcpgTHhrrDlt
 3SCoOI32Ixnjk6b0AtpDOwVFjOht4sa1zLEY0/22e4KlDtZ1OgiyUVsiYfeGwqK3TN3FwPf
 LlscUMbXDD7FgIGMUPpqw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:mXQi6QT+BDQ=:J+TtrTsR4mtpMMV5KcauVu
 NKIf9RZkkMpp0tbGjsM6YbUDNZ5TAHZwrTpfO+5xxp5+qyuzWQfeMN/vzXlKw4O8VZzhG/wV0
 uRdt63ht4B9KSk2XM6yh+w6bgLbar2iz9XYNFIGp7N20emwPIiHnB4e7WVix82DuFEcrXvFdg
 LfqNm+/ckmM1kcaLzfcY9me0xwPbdJwyze8BWsJPFMJl7M0Za7yLPZgEML9pYknON3p1VsezJ
 mEYH1cMhrERP3NGKj9w40vAswdQ1Bj3YZbLcaNzjcIFjAMma+kqo8NNyuJ7q+NiunklpBv/WJ
 2LF5GGl2aD/P76zlIyMRqbUl4XNOfw2zIbwmfWjKN1QhVuBZ9CZX/ohSPoLbJ4M1RNyD32Peq
 A7WMFV6bN7JoXAKSun4IXyD1yzRIbGeuJKfI4YahiDZ/V2RSCfRvqjTh+xIa9RF0lUyf7C5dT
 W0/aFw9u3tj5sRSkhAWjiTPpLOSqRo/6H/g0sWYEVk33DG5fZjkLd736GZgv1RstdX2ddpFjl
 hLfGn+l1bELsM7B6tr5QQ9fGja08bNMOgpOztlBSM8bQrZg1mMZlmOV3o8kwfiZdL3xXo6lun
 G9xvLVVGWdbMrgJX5oOdH/GnySzqAKVjmrLlJwca4S/0hFdu/ZXT0BrawKRpSSYq8pkA6pc//
 Kh/re+khi4GQ7mTATrf+ViAJqQmvlzagxkFZQ/0il1GBqOSO3y2atEW2kg9uVT+ax/AnuU2l1
 RgKM1WvKfd7Ui9qBXRsZPOZidlJ5Ps0vz1VPSHFya7wsXqTMAycjUBqJ+NWCkGhoSedBB9Swg
 4KQbZxI
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
 merge-recursive.c | 55 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bb075e3..d5a593c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -710,12 +710,10 @@ static int make_room_for_path(struct merge_options *o, const char *path)
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
@@ -743,6 +741,8 @@ static int update_file_flags(struct merge_options *o,
 			      int update_cache,
 			      int update_wd)
 {
+	int ret = 0;
+
 	if (o->call_depth)
 		update_wd = 0;
 
@@ -763,9 +763,11 @@ static int update_file_flags(struct merge_options *o,
 
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
@@ -786,8 +788,10 @@ static int update_file_flags(struct merge_options *o,
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
@@ -795,18 +799,18 @@ static int update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				die_errno(_("failed to symlink '%s'"), path);
+				ret = error_errno(_("failed to symlink '%s'"), path);
 			free(lnk);
 		} else
-			die(_("do not know what to do with %06o %s '%s'"),
-			    mode, sha1_to_hex(sha), path);
+			ret = error_errno(_("do not know what to do with %06o %s '%s'"),
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
@@ -932,20 +936,22 @@ static int merge_file_1(struct merge_options *o,
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
@@ -1861,7 +1867,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("Fatal merge failure, shouldn't happen."));
+		return error(_("Fatal merge failure, shouldn't happen."));
 
 	return clean_merge;
 }
@@ -1889,11 +1895,10 @@ int merge_trees(struct merge_options *o,
 
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
@@ -2024,7 +2029,7 @@ int merge_recursive(struct merge_options *o,
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
-			die(_("merge returned no commit"));
+			return error(_("merge returned no commit"));
 	}
 
 	discard_cache();
-- 
2.9.0.268.gcabc8b0


