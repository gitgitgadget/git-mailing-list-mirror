Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13FBB206FB
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbcGELYY (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:57870 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932694AbcGELYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:18 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M4B71-1bb6KT32Jv-00rrAT; Tue, 05 Jul 2016 13:24:06
 +0200
Date:	Tue, 5 Jul 2016 13:24:06 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 13/17] merge-recursive: flush output buffer before printing
 error messages
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <83aea04d1fdceccdfd79f30cfb03671eb1303c0b.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B6CqsIQsQmb5TFk7kIPPQB4Sqq9hRWmoKcYtKc01ZUmqPq9eVvD
 Wb1U/lIOwuFLzptX3S5yoDGnZ9cl9OH8TqMLZcAuHooP2g5o90YTJVzbrVf7/HO9Fx+vbM2
 h3ovx4OOQvQa1oWyB+WLom54h92UVrMoJFXmJF/EvviD/kyBe56JZaYt8CXuVydcmdOEk8E
 oryJ6cnlqwErk+szCh5yw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2WuPBTjQtC8=:ERGVOscBcaM3WWT/wAVBP2
 05l/5nl18R1LDVeOP1yonehnKvm/e20445+2lXM0zdxsGW6AKePOC+/4xFJKClbCyynid1a1N
 RyW330bZQ5wL4VXwTEuO0W8FtHx8jO0QhiY87NtArXiyI71yAMFJ/2t349i+l7kcLsLXP27ur
 vv3ksgBxB0JXNjTE1tH2/qQGjq79qBvWT6AjCTquRyay/sSUSWTZ6v6DUX5irS/wNq/T569ig
 ZbPrLGsF7pfeGYICI+/kj+YWGM2WBrhlAXKg7U9+d/R13+MqZVg8T3qUeIXLyRRniwUsL0I2h
 kUOmETQ11tU4QksWNNhCKEc4+9Pur8NvnDwMcEMBB8gFXzh///Y4gSqqcXM2GDT8OJPkTvu5s
 suYzWGAoHSyDLSyKPOL9LRMQI8QAtyvt0cx3x0VIGZhISm1OXfz6ogdjQVUra4qlzk5fYsGcA
 BRgXboWd9GM3Ot4fNQHmmCruuBa8GP1T7jIBVTk4QC1YrxnXNdHwctJeigoYCYNXScQGVpmMt
 VCnaZkP7M/sr75myiLela1LJfHzOJDkOIRUxlane+3glDQ3MhP0O1bORhLsuCNhFpzlBpvE6e
 MeMRe2BCKKopKUK3GKCrzjc4IHtXAE1pOhS3Uu+1fYvY8lddo97+2er7XSfk7uLvafufNMtAm
 7cvpvMFIvhgJDuWnerzV81J9iDvPpfAiD2NN9FPt/vKOAI31YszgYmS1/19r4lOjTEfSoMbW+
 n1a5eWcVRid430GJsfCK11sNJtNSuE+4XtT/hoHcQmv025taVXJ1iV4I8/Wo3sXRSgfAMkR5p
 6xcYNjU
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
 merge-recursive.c | 110 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 45 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 10010a4..0eb23a6 100644
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
 
-static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
+static int add_cacheinfo(struct merge_options *o,
+		unsigned int mode, const unsigned char *sha1,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
@@ -206,7 +221,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 			      (refresh ? (CE_MATCH_REFRESH |
 					  CE_MATCH_IGNORE_MISSING) : 0 ));
 	if (!ce)
-		return error(_("addinfo_cache failed for path '%s'"), path);
+		return err(o, _("addinfo_cache failed for path '%s'"), path);
 	return add_cache_entry(ce, options);
 }
 
@@ -267,7 +282,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
 	    cache_tree_update(&the_index, 0) < 0) {
-		error(_("error building trees"));
+		err(o, _("error building trees"));
 		return NULL;
 	}
 
@@ -535,7 +550,8 @@ static struct string_list *get_renames(struct merge_options *o,
 	return renames;
 }
 
-static int update_stages(const char *path, const struct diff_filespec *o,
+static int update_stages(struct merge_options *opt, const char *path,
+			 const struct diff_filespec *o,
 			 const struct diff_filespec *a,
 			 const struct diff_filespec *b)
 {
@@ -554,13 +570,13 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 		if (remove_file_from_cache(path))
 			return -1;
 	if (o)
-		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
+		if (add_cacheinfo(opt, o->mode, o->sha1, path, 1, 0, options))
 			return -1;
 	if (a)
-		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options))
+		if (add_cacheinfo(opt, a->mode, a->sha1, path, 2, 0, options))
 			return -1;
 	if (b)
-		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options))
+		if (add_cacheinfo(opt, b->mode, b->sha1, path, 3, 0, options))
 			return -1;
 	return 0;
 }
@@ -712,8 +728,8 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	if (status) {
 		if (status == SCLD_EXISTS)
 			/* something else exists */
-			return error(msg, path, _(": perhaps a D/F conflict?"));
-		return error(msg, path, "");
+			return err(o, msg, path, _(": perhaps a D/F conflict?"));
+		return err(o, msg, path, "");
 	}
 
 	/*
@@ -721,7 +737,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	 * tracking it.
 	 */
 	if (would_lose_untracked(path))
-		return error(_("refusing to lose untracked file at '%s'"),
+		return err(o, _("refusing to lose untracked file at '%s'"),
 			     path);
 
 	/* Successful unlink is good.. */
@@ -731,7 +747,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	if (errno == ENOENT)
 		return 0;
 	/* .. but not some other error (who really cares what?) */
-	return error(msg, path, _(": perhaps a D/F conflict?"));
+	return err(o, msg, path, _(": perhaps a D/F conflict?"));
 }
 
 static int update_file_flags(struct merge_options *o,
@@ -763,9 +779,9 @@ static int update_file_flags(struct merge_options *o,
 
 		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
-			return error(_("cannot read object %s '%s'"), sha1_to_hex(sha), path);
+			return err(o, _("cannot read object %s '%s'"), sha1_to_hex(sha), path);
 		if (type != OBJ_BLOB) {
-			ret = error(_("blob expected for %s '%s'"), sha1_to_hex(sha), path);
+			ret = err(o, _("blob expected for %s '%s'"), sha1_to_hex(sha), path);
 			goto free_buf;
 		}
 		if (S_ISREG(mode)) {
@@ -789,7 +805,8 @@ static int update_file_flags(struct merge_options *o,
 				mode = 0666;
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 			if (fd < 0) {
-				ret = error_errno(_("failed to open '%s'"), path);
+				ret = err(o, _("failed to open '%s': %s"),
+					path, strerror(errno));
 				goto free_buf;
 			}
 			write_in_full(fd, buf, size);
@@ -799,17 +816,18 @@ static int update_file_flags(struct merge_options *o,
 			safe_create_leading_directories_const(path);
 			unlink(path);
 			if (symlink(lnk, path))
-				ret = error_errno(_("failed to symlink '%s'"), path);
+				ret = err(o, _("failed to symlink '%s': %s"),
+					path, strerror(errno));
 			free(lnk);
 		} else
-			ret = error(_("do not know what to do with %06o %s '%s'"),
+			ret = err(o, _("do not know what to do with %06o %s '%s'"),
 				mode, sha1_to_hex(sha), path);
  free_buf:
 		free(buf);
 	}
  update_index:
 	if (!ret && update_cache)
-		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
+		add_cacheinfo(o, mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
 	return ret;
 }
 
@@ -942,11 +960,11 @@ static int merge_file_1(struct merge_options *o,
 						  branch1, branch2);
 
 			if ((merge_status < 0) || !result_buf.ptr)
-				ret = error(_("Failed to execute internal merge"));
+				ret = err(o, _("Failed to execute internal merge"));
 
 			if (!ret && write_sha1_file(result_buf.ptr, result_buf.size,
 					    blob_type, result->sha))
-				ret = error(_("Unable to add %s to database"),
+				ret = err(o, _("Unable to add %s to database"),
 					a->path);
 
 			free(result_buf.ptr);
@@ -1109,7 +1127,7 @@ static int conflict_rename_delete(struct merge_options *o,
 	if (o->call_depth)
 		return remove_file_from_cache(dest->path);
 	else
-		return update_stages(dest->path, NULL,
+		return update_stages(o, dest->path, NULL,
 			      rename_branch == o->branch1 ? dest : NULL,
 			      rename_branch == o->branch1 ? NULL : dest);
 }
@@ -1167,9 +1185,9 @@ static int handle_file(struct merge_options *o,
 	if ((ret = update_file(o, 0, rename->sha1, rename->mode, dst_name)))
 		; /* fall through, do allow dst_name to be released */
 	else if (stage == 2)
-		ret = update_stages(rename->path, NULL, rename, add);
+		ret = update_stages(o, rename->path, NULL, rename, add);
 	else
-		ret = update_stages(rename->path, NULL, add, rename);
+		ret = update_stages(o, rename->path, NULL, add, rename);
 
 	if (dst_name != rename->path)
 		free(dst_name);
@@ -1557,23 +1575,25 @@ static unsigned char *stage_sha(const unsigned char *sha, unsigned mode)
 	return (is_null_sha1(sha) || mode == 0) ? NULL: (unsigned char *)sha;
 }
 
-static int read_sha1_strbuf(const unsigned char *sha1, struct strbuf *dst)
+static int read_sha1_strbuf(struct merge_options *o,
+	const unsigned char *sha1, struct strbuf *dst)
 {
 	void *buf;
 	enum object_type type;
 	unsigned long size;
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		return error(_("cannot read object %s"), sha1_to_hex(sha1));
+		return err(o, _("cannot read object %s"), sha1_to_hex(sha1));
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return error(_("object %s is not a blob"), sha1_to_hex(sha1));
+		return err(o, _("object %s is not a blob"), sha1_to_hex(sha1));
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
 }
 
-static int blob_unchanged(const unsigned char *o_sha,
+static int blob_unchanged(struct merge_options *opt,
+			  const unsigned char *o_sha,
 			  unsigned o_mode,
 			  const unsigned char *a_sha,
 			  unsigned a_mode,
@@ -1591,7 +1611,7 @@ static int blob_unchanged(const unsigned char *o_sha,
 		return 0;
 
 	assert(o_sha && a_sha);
-	if (read_sha1_strbuf(o_sha, &o) || read_sha1_strbuf(a_sha, &a))
+	if (read_sha1_strbuf(opt, o_sha, &o) || read_sha1_strbuf(opt, a_sha, &a))
 		goto error_return;
 	/*
 	 * Note: binary | is used so that both renormalizations are
@@ -1680,7 +1700,7 @@ static int merge_content(struct merge_options *o,
 		 */
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
-			add_cacheinfo(mfi.mode, mfi.sha, path,
+			add_cacheinfo(o, mfi.mode, mfi.sha, path,
 				      0, (!o->call_depth), 0);
 			return mfi.clean;
 		}
@@ -1693,7 +1713,7 @@ static int merge_content(struct merge_options *o,
 		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (rename_conflict_info && !df_conflict_remains)
-			if (update_stages(path, &one, &a, &b))
+			if (update_stages(o, path, &one, &a, &b))
 				return -1;
 	}
 
@@ -1703,7 +1723,7 @@ static int merge_content(struct merge_options *o,
 			remove_file_from_cache(path);
 		} else {
 			if (!mfi.clean) {
-				if (update_stages(path, &one, &a, &b))
+				if (update_stages(o, path, &one, &a, &b))
 					return -1;
 			} else {
 				int file_from_stage2 = was_tracked(path);
@@ -1711,7 +1731,7 @@ static int merge_content(struct merge_options *o,
 				hashcpy(merged.sha1, mfi.sha);
 				merged.mode = mfi.mode;
 
-				if (update_stages(path, NULL,
+				if (update_stages(o, path, NULL,
 					      file_from_stage2 ? &merged : NULL,
 					      file_from_stage2 ? NULL : &merged))
 					return -1;
@@ -1779,8 +1799,8 @@ static int process_entry(struct merge_options *o,
 	} else if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
 		if ((!a_sha && !b_sha) ||
-		    (!b_sha && blob_unchanged(o_sha, o_mode, a_sha, a_mode, normalize, path)) ||
-		    (!a_sha && blob_unchanged(o_sha, o_mode, b_sha, b_mode, normalize, path))) {
+		    (!b_sha && blob_unchanged(o, o_sha, o_mode, a_sha, a_mode, normalize, path)) ||
+		    (!a_sha && blob_unchanged(o, o_sha, o_mode, b_sha, b_mode, normalize, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
@@ -1876,7 +1896,7 @@ int merge_trees(struct merge_options *o,
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
-			error(_("merging of trees %s and %s failed"),
+			err(o, _("merging of trees %s and %s failed"),
 			    oid_to_hex(&head->object.oid),
 			    oid_to_hex(&merge->object.oid));
 		return -1;
@@ -2010,7 +2030,7 @@ int merge_recursive(struct merge_options *o,
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
-			return error(_("merge returned no commit"));
+			return err(o, _("merge returned no commit"));
 	}
 
 	discard_cache();
@@ -2069,7 +2089,7 @@ int merge_recursive_generic(struct merge_options *o,
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
 			if (!(base = get_ref(base_list[i], sha1_to_hex(base_list[i]))))
-				return error(_("Could not parse object '%s'"),
+				return err(o, _("Could not parse object '%s'"),
 					sha1_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
 		}
@@ -2083,7 +2103,7 @@ int merge_recursive_generic(struct merge_options *o,
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
-		return error(_("Unable to write index."));
+		return err(o, _("Unable to write index."));
 
 	return clean ? 0 : 1;
 }
-- 
2.9.0.280.g32e2a70


