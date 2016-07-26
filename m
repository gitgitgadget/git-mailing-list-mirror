Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FE9203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 16:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108AbcGZQHH (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:07:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:61265 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757085AbcGZQHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:07:03 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0McUnM-1bjkHv0As4-00HikY; Tue, 26 Jul 2016 18:06:47
 +0200
Date:	Tue, 26 Jul 2016 18:06:34 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 12/16] merge-recursive: flush output buffer before printing
 error messages
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <349bdfacfffa11d06241655c9e0b62506e58758b.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mPKSHmhVx2d33EGTUX8C2zxk7qPWYwzNww/oPVH6dAvplNCQ7L/
 pvny7EOYBu/3VqcyGvBtzWI1D4UIGwWm5QANyhA6D9RrgrycHIZcuDTHhRt0ZIpwMiu/wgK
 sCqzZNY3L0Gc4whfpHymRktt6vqwaSnSoV2fA3Ye5PTistfkNRy3Y1v4oW4Qs1ygN3SwZ84
 wUGLjCfc7bMn02OmJwLaQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:LTJhbyNYUgs=:avI/eSHLZrAwVIK/cslmkq
 4mfpH9DrNTOgFMgMPzDdSE4t+b6g41c+cixkBQlDelk/7Hm14Nh1wztx1RZQz97Gg4FknQ+Bq
 cLXw61naHsgP2bmE1ACZt5rJdlg8FnejTzBsUCuKaFG+NoTOe4/ZS1KPdA5Amvnjo53TbRWkm
 XqKk1rbTMGfcB3zb79czsRvMTqGw/pOKjsdFgJO5Ko6sdQimf55WPnDwC7aYBGKKApHu69uN/
 mFM4/7IO+Ia3FcZHoe/jq/VFKDxcIpGEka11tFDz9MKvWj28FeBglvYsSRXuR6+adV2KiBFVT
 Y4wC6KBvEC11xN1k5TVF4PCUaaHZi5eCeGvauDgegAfF+A97SzYuclGrmii3Cwq9lsAqquPZc
 eFiNTpbIENcWk6MpH/74Mj04ATJrEmUX7093pwqzlwXn//9hxUbc4kGxgYCcxDRsVvgrhaY9r
 dQb/FCS85c3v0C+T95VytkUhO7BZsZJQYmQ5BWPGdPIP+Iy/SUTp2ZIHdrp7BRBpl6yNjnoCU
 I+3xNJYs4lp8VQC110JtpKd3dU6Vy/p6FWy4TYjHI0IQff8I3OZ783aBDCmh57K12RBhX7R9C
 X15xzSF/gJPYRp9JksVo222BW1s36KolvH4W4tBZXPFO9wtdYL1fp0tEPNb86OcXuKcTZ3zKM
 r3X43tjY9Ir/Qqqgz4JgZiCq8LvEYefVanZHk2/KbjjoCEx7YWvoD8qfakgwOZEyINaPQCEQQ
 L+MOpgv5i5dG0SMrWI6+ThJnyrs7sccLDv/kv23gd97Ze4iSOlhO4gIKGzHDI5AaeCjWybggl
 Q6It6uk
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The data structure passed to the recursive merge machinery has a feature
where the caller can ask for the output to be buffered into a strbuf, by
setting the field 'buffer_output'.

Previously, we simply swallowed the buffered output when showing error
messages. With this patch, we show the output first, and only then print
the error message.

Currently, the only user of that buffering is merge_recursive() itself,
to avoid the progress output to interfere.

In the next patches, we will introduce a new buffer_output mode that
forces merge_recursive() to retain the output buffer for further
processing by the caller. If the caller asked for that, we will then
also write the error messages into the output buffer. This is necessary
to give the caller more control not only how to react in case of errors
but also control how/if to display the error messages.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 116 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 68 insertions(+), 48 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bc59815..71a0aa0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -23,6 +23,28 @@
 #include "dir.h"
 #include "submodule.h"
 
+static void flush_output(struct merge_options *o)
+{
+	if (o->obuf.len) {
+		fputs(o->obuf.buf, stdout);
+		strbuf_reset(&o->obuf);
+	}
+}
+
+static int err(struct merge_options *o, const char *err, ...)
+{
+	va_list params;
+
+	va_start(params, err);
+	flush_output(o);
+	strbuf_vaddf(&o->obuf, err, params);
+	error("%s", o->obuf.buf);
+	strbuf_reset(&o->obuf);
+	va_end(params);
+
+	return -1;
+}
+
 static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 				      const char *subtree_shift)
 {
@@ -148,14 +170,6 @@ static int show(struct merge_options *o, int v)
 	return (!o->call_depth && o->verbosity >= v) || o->verbosity >= 5;
 }
 
-static void flush_output(struct merge_options *o)
-{
-	if (o->obuf.len) {
-		fputs(o->obuf.buf, stdout);
-		strbuf_reset(&o->obuf);
-	}
-}
-
 __attribute__((format (printf, 3, 4)))
 static void output(struct merge_options *o, int v, const char *fmt, ...)
 {
@@ -198,7 +212,8 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 	}
 }
 
-static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
+static int add_cacheinfo(struct merge_options *o,
+		unsigned int mode, const struct object_id *oid,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
@@ -206,7 +221,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 
 	ce = make_cache_entry(mode, oid ? oid->hash : null_sha1, path, stage, 0);
 	if (!ce)
-		return error(_("addinfo_cache failed for path '%s'"), path);
+		return err(o, _("addinfo_cache failed for path '%s'"), path);
 
 	ret = add_cache_entry(ce, options);
 	if (refresh) {
@@ -276,7 +291,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(&the_index, 0) < 0) {
-		error(_("error building trees"));
+		err(o, _("error building trees"));
 		return NULL;
 	}
 
@@ -544,7 +559,8 @@ static struct string_list *get_renames(struct merge_options *o,
 	return renames;
 }
 
-static int update_stages(const char *path, const struct diff_filespec *o,
+static int update_stages(struct merge_options *opt, const char *path,
+			 const struct diff_filespec *o,
 			 const struct diff_filespec *a,
 			 const struct diff_filespec *b)
 {
@@ -563,13 +579,13 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 		if (remove_file_from_cache(path))
 			return -1;
 	if (o)
-		if (add_cacheinfo(o->mode, &o->oid, path, 1, 0, options))
+		if (add_cacheinfo(opt, o->mode, &o->oid, path, 1, 0, options))
 			return -1;
 	if (a)
-		if (add_cacheinfo(a->mode, &a->oid, path, 2, 0, options))
+		if (add_cacheinfo(opt, a->mode, &a->oid, path, 2, 0, options))
 			return -1;
 	if (b)
-		if (add_cacheinfo(b->mode, &b->oid, path, 3, 0, options))
+		if (add_cacheinfo(opt, b->mode, &b->oid, path, 3, 0, options))
 			return -1;
 	return 0;
 }
@@ -720,8 +736,8 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	if (status) {
 		if (status == SCLD_EXISTS)
 			/* something else exists */
-			return error(msg, path, _(": perhaps a D/F conflict?"));
-		return error(msg, path, "");
+			return err(o, msg, path, _(": perhaps a D/F conflict?"));
+		return err(o, msg, path, "");
 	}
 
 	/*
@@ -729,7 +745,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	 * tracking it.
 	 */
 	if (would_lose_untracked(path))
-		return error(_("refusing to lose untracked file at '%s'"),
+		return err(o, _("refusing to lose untracked file at '%s'"),
 			     path);
 
 	/* Successful unlink is good.. */
@@ -739,7 +755,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	if (errno == ENOENT)
 		return 0;
 	/* .. but not some other error (who really cares what?) */
-	return error(msg, path, _(": perhaps a D/F conflict?"));
+	return err(o, msg, path, _(": perhaps a D/F conflict?"));
 }
 
 static int update_file_flags(struct merge_options *o,
@@ -771,9 +787,9 @@ static int update_file_flags(struct merge_options *o,
 
 		buf = read_sha1_file(oid->hash, &type, &size);
 		if (!buf)
-			return error(_("cannot read object %s '%s'"), oid_to_hex(oid), path);
+			return err(o, _("cannot read object %s '%s'"), oid_to_hex(oid), path);
 		if (type != OBJ_BLOB) {
-			ret = error(_("blob expected for %s '%s'"), oid_to_hex(oid), path);
+			ret = err(o, _("blob expected for %s '%s'"), oid_to_hex(oid), path);
 			goto free_buf;
 		}
 		if (S_ISREG(mode)) {
@@ -797,8 +813,8 @@ static int update_file_flags(struct merge_options *o,
 				mode = 0666;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0) {
-				ret = error_errno(_("failed to open '%s'"),
-						  path);
+				ret = err(o, _("failed to open '%s': %s"),
+					  path, strerror(errno));
 				goto free_buf;
 			}
 			write_in_full(fd, buf, size);
@@ -808,17 +824,19 @@ static int update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				ret = error_errno(_("failed to symlink '%s'"), path);
+				ret = err(o, _("failed to symlink '%s': %s"),
+					path, strerror(errno));
 			free(lnk);
 		} else
-			ret = error(_("do not know what to do with %06o %s '%s'"),
-				    mode, oid_to_hex(oid), path);
+			ret = err(o,
+				  _("do not know what to do with %06o %s '%s'"),
+				  mode, oid_to_hex(oid), path);
  free_buf:
 		free(buf);
 	}
  update_index:
 	if (!ret && update_cache)
-		add_cacheinfo(mode, oid, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
+		add_cacheinfo(o, mode, oid, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
 	return ret;
 }
 
@@ -951,12 +969,12 @@ static int merge_file_1(struct merge_options *o,
 						  branch1, branch2);
 
 			if ((merge_status < 0) || !result_buf.ptr)
-				ret = error(_("Failed to execute internal merge"));
+				ret = err(o, _("Failed to execute internal merge"));
 
 			if (!ret && write_sha1_file(result_buf.ptr, result_buf.size,
 						    blob_type, result->oid.hash))
-				ret = error(_("Unable to add %s to database"),
-					    a->path);
+				ret = err(o, _("Unable to add %s to database"),
+					  a->path);
 
 			free(result_buf.ptr);
 			if (ret)
@@ -1122,7 +1140,7 @@ static int conflict_rename_delete(struct merge_options *o,
 	if (o->call_depth)
 		return remove_file_from_cache(dest->path);
 	else
-		return update_stages(dest->path, NULL,
+		return update_stages(o, dest->path, NULL,
 				     rename_branch == o->branch1 ? dest : NULL,
 				     rename_branch == o->branch1 ? NULL : dest);
 }
@@ -1180,9 +1198,9 @@ static int handle_file(struct merge_options *o,
 	if ((ret = update_file(o, 0, &rename->oid, rename->mode, dst_name)))
 		; /* fall through, do allow dst_name to be released */
 	else if (stage == 2)
-		ret = update_stages(rename->path, NULL, rename, add);
+		ret = update_stages(o, rename->path, NULL, rename, add);
 	else
-		ret = update_stages(rename->path, NULL, add, rename);
+		ret = update_stages(o, rename->path, NULL, add, rename);
 
 	if (dst_name != rename->path)
 		free(dst_name);
@@ -1575,23 +1593,25 @@ static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
 	return (is_null_oid(oid) || mode == 0) ? NULL: (struct object_id *)oid;
 }
 
-static int read_oid_strbuf(const struct object_id *oid, struct strbuf *dst)
+static int read_oid_strbuf(struct merge_options *o,
+	const struct object_id *oid, struct strbuf *dst)
 {
 	void *buf;
 	enum object_type type;
 	unsigned long size;
 	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
-		return error(_("cannot read object %s"), oid_to_hex(oid));
+		return err(o, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return error(_("object %s is not a blob"), oid_to_hex(oid));
+		return err(o, _("object %s is not a blob"), oid_to_hex(oid));
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
 }
 
-static int blob_unchanged(const struct object_id *o_oid,
+static int blob_unchanged(struct merge_options *opt,
+			  const struct object_id *o_oid,
 			  unsigned o_mode,
 			  const struct object_id *a_oid,
 			  unsigned a_mode,
@@ -1609,7 +1629,7 @@ static int blob_unchanged(const struct object_id *o_oid,
 		return 0;
 
 	assert(o_oid && a_oid);
-	if (read_oid_strbuf(o_oid, &o) || read_oid_strbuf(a_oid, &a))
+	if (read_oid_strbuf(opt, o_oid, &o) || read_oid_strbuf(opt, a_oid, &a))
 		goto error_return;
 	/*
 	 * Note: binary | is used so that both renormalizations are
@@ -1698,7 +1718,7 @@ static int merge_content(struct merge_options *o,
 		 */
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
-			add_cacheinfo(mfi.mode, &mfi.oid, path,
+			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
 				      0, (!o->call_depth), 0);
 			return mfi.clean;
 		}
@@ -1711,7 +1731,7 @@ static int merge_content(struct merge_options *o,
 		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (rename_conflict_info && !df_conflict_remains)
-			if (update_stages(path, &one, &a, &b))
+			if (update_stages(o, path, &one, &a, &b))
 				return -1;
 	}
 
@@ -1721,7 +1741,7 @@ static int merge_content(struct merge_options *o,
 			remove_file_from_cache(path);
 		} else {
 			if (!mfi.clean) {
-				if (update_stages(path, &one, &a, &b))
+				if (update_stages(o, path, &one, &a, &b))
 					return -1;
 			} else {
 				int file_from_stage2 = was_tracked(path);
@@ -1729,7 +1749,7 @@ static int merge_content(struct merge_options *o,
 				oidcpy(&merged.oid, &mfi.oid);
 				merged.mode = mfi.mode;
 
-				if (update_stages(path, NULL,
+				if (update_stages(o, path, NULL,
 						  file_from_stage2 ? &merged : NULL,
 						  file_from_stage2 ? NULL : &merged))
 					return -1;
@@ -1797,8 +1817,8 @@ static int process_entry(struct merge_options *o,
 	} else if (o_oid && (!a_oid || !b_oid)) {
 		/* Case A: Deleted in one */
 		if ((!a_oid && !b_oid) ||
-		    (!b_oid && blob_unchanged(o_oid, o_mode, a_oid, a_mode, normalize, path)) ||
-		    (!a_oid && blob_unchanged(o_oid, o_mode, b_oid, b_mode, normalize, path))) {
+		    (!b_oid && blob_unchanged(o, o_oid, o_mode, a_oid, a_mode, normalize, path)) ||
+		    (!a_oid && blob_unchanged(o, o_oid, o_mode, b_oid, b_mode, normalize, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_oid)
@@ -1894,7 +1914,7 @@ int merge_trees(struct merge_options *o,
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
-			error(_("merging of trees %s and %s failed"),
+			err(o, _("merging of trees %s and %s failed"),
 			    oid_to_hex(&head->object.oid),
 			    oid_to_hex(&merge->object.oid));
 		return -1;
@@ -2029,7 +2049,7 @@ int merge_recursive(struct merge_options *o,
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
-			return error(_("merge returned no commit"));
+			return err(o, _("merge returned no commit"));
 	}
 
 	discard_cache();
@@ -2088,7 +2108,7 @@ int merge_recursive_generic(struct merge_options *o,
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
 			if (!(base = get_ref(base_list[i], oid_to_hex(base_list[i]))))
-				return error(_("Could not parse object '%s'"),
+				return err(o, _("Could not parse object '%s'"),
 					oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
 		}
@@ -2102,7 +2122,7 @@ int merge_recursive_generic(struct merge_options *o,
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
-		return error(_("Unable to write index."));
+		return err(o, _("Unable to write index."));
 
 	return clean ? 0 : 1;
 }
-- 
2.9.0.281.g286a8d9


