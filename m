Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30BB20189
	for <e@80x24.org>; Sat, 18 Jun 2016 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbcFRWOd (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 18:14:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37418 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115AbcFRWOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 18:14:16 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [72.20.141.51])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7CB5A280A2;
	Sat, 18 Jun 2016 22:14:14 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466288055;
	bh=CHhll9WjU+2TUQ4jDMcIL1o5DDW1jHNCMPXRbL51/5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUK1j9kY65Q9h/oUGtbzpwtyprAqgz/Vq30e69/n+7kYST9kVN6iZuap65qEpfakN
	 NmS0z8HfuAx+tP4xk1EA2X04+xynG9CDCgsPtnfmlMka798H3f68sPCVcN34BBysEg
	 1DKG+UUPFnCXMZmfSSMDway8/h2ZAtwn0iMQ4jYqr14UOBDKM9Hku50UOMg2DVqg6D
	 IXkRHHcHi3M7XAaEvxwA4Abfsa5+LSLAulrgOZ5BQnTpfZ0PdNBl/ut26qidCf/uqt
	 ZM2l7HLuTgpu5Tu3wQBwSYBGrs9GbtDIdt8+YCnEEglGlY/boILZzmeMyjAh+s8Fmt
	 1ZZ/vfXOzB5HkaWpxIA+B0NuqQgVnpoJk/fswCi1QkUk2VidymU65P5CQrYQOk6vsK
	 S06rLsnHX5O6rK86N7VTRbhXb53FnSDUbN3psk/MRt+KkGYWo02DcTMUD7J3YHfk/s
	 b04unvXVRnqcbHcCY7zN5vw+h0Kmywl51vV4GBOtcPdTRmEC0ZY
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/8] Convert struct diff_filespec to struct object_id
Date:	Sat, 18 Jun 2016 22:14:02 +0000
Message-Id: <20160618221407.1046188-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Convert struct diff_filespec's sha1 member to use a struct object_id
called "oid" instead.  The following Coccinelle semantic patch was used
to implement this, followed by the transformations in object_id.cocci:

@@
struct diff_filespec o;
@@
- o.sha1
+ o.oid.hash

@@
struct diff_filespec *p;
@@
- p->sha1
+ p->oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c       |   6 +--
 builtin/fast-export.c |  10 ++---
 builtin/reset.c       |   4 +-
 combine-diff.c        |  10 ++---
 diff.c                |  69 +++++++++++++++++---------------
 diffcore-break.c      |   2 +-
 diffcore-rename.c     |  14 ++++---
 diffcore.h            |   2 +-
 line-log.c            |   2 +-
 merge-recursive.c     | 107 +++++++++++++++++++++++++++-----------------------
 notes-merge.c         |  42 ++++++++++----------
 submodule.c           |   4 +-
 wt-status.c           |   3 +-
 13 files changed, 147 insertions(+), 128 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0b..04bc4e0e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -599,7 +599,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 			    p->status);
 		case 'M':
 			porigin = get_origin(sb, parent, origin->path);
-			hashcpy(porigin->blob_sha1, p->one->sha1);
+			hashcpy(porigin->blob_sha1, p->one->oid.hash);
 			porigin->mode = p->one->mode;
 			break;
 		case 'A':
@@ -645,7 +645,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 		if ((p->status == 'R' || p->status == 'C') &&
 		    !strcmp(p->two->path, origin->path)) {
 			porigin = get_origin(sb, parent, p->one->path);
-			hashcpy(porigin->blob_sha1, p->one->sha1);
+			hashcpy(porigin->blob_sha1, p->one->oid.hash);
 			porigin->mode = p->one->mode;
 			break;
 		}
@@ -1309,7 +1309,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 				continue;
 
 			norigin = get_origin(sb, parent, p->one->path);
-			hashcpy(norigin->blob_sha1, p->one->sha1);
+			hashcpy(norigin->blob_sha1, p->one->oid.hash);
 			norigin->mode = p->one->mode;
 			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
 			if (!file_p.ptr)
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8164b581..c0652a7e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -368,7 +368,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 			print_path(spec->path);
 			putchar('\n');
 
-			if (!hashcmp(ospec->sha1, spec->sha1) &&
+			if (!oidcmp(&ospec->oid, &spec->oid) &&
 			    ospec->mode == spec->mode)
 				break;
 			/* fallthrough */
@@ -383,10 +383,10 @@ static void show_filemodify(struct diff_queue_struct *q,
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s ", spec->mode,
 				       sha1_to_hex(anonymize ?
-						   anonymize_sha1(spec->sha1) :
-						   spec->sha1));
+						   anonymize_sha1(spec->oid.hash) :
+						   spec->oid.hash));
 			else {
-				struct object *object = lookup_object(spec->sha1);
+				struct object *object = lookup_object(spec->oid.hash);
 				printf("M %06o :%d ", spec->mode,
 				       get_object_mark(object));
 			}
@@ -572,7 +572,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	/* Export the referenced blobs, and remember the marks. */
 	for (i = 0; i < diff_queued_diff.nr; i++)
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
-			export_blob(diff_queued_diff.queue[i]->two->sha1);
+			export_blob(diff_queued_diff.queue[i]->two->oid.hash);
 
 	refname = commit->util;
 	if (anonymize) {
diff --git a/builtin/reset.c b/builtin/reset.c
index 092c3a53..cce64b53 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -121,7 +121,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
-		int is_missing = !(one->mode && !is_null_sha1(one->sha1));
+		int is_missing = !(one->mode && !is_null_oid(&one->oid));
 		struct cache_entry *ce;
 
 		if (is_missing && !intent_to_add) {
@@ -129,7 +129,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 			continue;
 		}
 
-		ce = make_cache_entry(one->mode, one->sha1, one->path,
+		ce = make_cache_entry(one->mode, one->oid.hash, one->path,
 				      0, 0);
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
diff --git a/combine-diff.c b/combine-diff.c
index 8f2313d5..3537209c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -44,9 +44,9 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			memset(p->parent, 0,
 			       sizeof(p->parent[0]) * num_parent);
 
-			hashcpy(p->oid.hash, q->queue[i]->two->sha1);
+			oidcpy(&p->oid, &q->queue[i]->two->oid);
 			p->mode = q->queue[i]->two->mode;
-			hashcpy(p->parent[n].oid.hash, q->queue[i]->one->sha1);
+			oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
 			*tail = p;
@@ -77,7 +77,7 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			continue;
 		}
 
-		hashcpy(p->parent[n].oid.hash, q->queue[i]->one->sha1);
+		oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 		p->parent[n].mode = q->queue[i]->one->mode;
 		p->parent[n].status = q->queue[i]->status;
 
@@ -1268,7 +1268,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 	for (i = 0; i < num_parent; i++) {
 		pair->one[i].path = p->path;
 		pair->one[i].mode = p->parent[i].mode;
-		hashcpy(pair->one[i].sha1, p->parent[i].oid.hash);
+		oidcpy(&pair->one[i].oid, &p->parent[i].oid);
 		pair->one[i].sha1_valid = !is_null_oid(&p->parent[i].oid);
 		pair->one[i].has_more_entries = 1;
 	}
@@ -1276,7 +1276,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 
 	pair->two->path = p->path;
 	pair->two->mode = p->mode;
-	hashcpy(pair->two->sha1, p->oid.hash);
+	oidcpy(&pair->two->oid, &p->oid);
 	pair->two->sha1_valid = !is_null_oid(&p->oid);
 	return pair;
 }
diff --git a/diff.c b/diff.c
index fa78fc18..5a6d8654 100644
--- a/diff.c
+++ b/diff.c
@@ -1934,7 +1934,7 @@ static void show_dirstat(struct diff_options *options)
 		name = p->two->path ? p->two->path : p->one->path;
 
 		if (p->one->sha1_valid && p->two->sha1_valid)
-			content_changed = hashcmp(p->one->sha1, p->two->sha1);
+			content_changed = oidcmp(&p->one->oid, &p->two->oid);
 		else
 			content_changed = 1;
 
@@ -2306,7 +2306,8 @@ static void builtin_diff(const char *name_a,
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one->path ? one->path : two->path,
 				line_prefix,
-				one->sha1, two->sha1, two->dirty_submodule,
+				one->oid.hash, two->oid.hash,
+				two->dirty_submodule,
 				meta, del, add, reset);
 		return;
 	}
@@ -2384,7 +2385,7 @@ static void builtin_diff(const char *name_a,
 		if (!one->data && !two->data &&
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
 		    !DIFF_OPT_TST(o, BINARY)) {
-			if (!hashcmp(one->sha1, two->sha1)) {
+			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
 					fprintf(o->file, "%s", header.buf);
 				goto free_ab_and_return;
@@ -2505,7 +2506,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		return;
 	}
 
-	same_contents = !hashcmp(one->sha1, two->sha1);
+	same_contents = !oidcmp(&one->oid, &two->oid);
 
 	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
 		data->is_binary = 1;
@@ -2638,7 +2639,7 @@ void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
 {
 	if (mode) {
 		spec->mode = canon_mode(mode);
-		hashcpy(spec->sha1, sha1);
+		hashcpy(spec->oid.hash, sha1);
 		spec->sha1_valid = sha1_valid;
 	}
 }
@@ -2721,7 +2722,8 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 	if (s->dirty_submodule)
 		dirty = "-dirty";
 
-	strbuf_addf(&buf, "Subproject commit %s%s\n", sha1_to_hex(s->sha1), dirty);
+	strbuf_addf(&buf, "Subproject commit %s%s\n",
+		    oid_to_hex(&s->oid), dirty);
 	s->size = buf.len;
 	if (size_only) {
 		s->data = NULL;
@@ -2765,7 +2767,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		return diff_populate_gitlink(s, size_only);
 
 	if (!s->sha1_valid ||
-	    reuse_worktree_file(s->path, s->sha1, 0)) {
+	    reuse_worktree_file(s->path, s->oid.hash, 0)) {
 		struct strbuf buf = STRBUF_INIT;
 		struct stat st;
 		int fd;
@@ -2822,9 +2824,10 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	else {
 		enum object_type type;
 		if (size_only || (flags & CHECK_BINARY)) {
-			type = sha1_object_info(s->sha1, &s->size);
+			type = sha1_object_info(s->oid.hash, &s->size);
 			if (type < 0)
-				die("unable to read %s", sha1_to_hex(s->sha1));
+				die("unable to read %s",
+				    oid_to_hex(&s->oid));
 			if (size_only)
 				return 0;
 			if (s->size > big_file_threshold && s->is_binary == -1) {
@@ -2832,9 +2835,9 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 				return 0;
 			}
 		}
-		s->data = read_sha1_file(s->sha1, &type, &s->size);
+		s->data = read_sha1_file(s->oid.hash, &type, &s->size);
 		if (!s->data)
-			die("unable to read %s", sha1_to_hex(s->sha1));
+			die("unable to read %s", oid_to_hex(&s->oid));
 		s->should_free = 1;
 	}
 	return 0;
@@ -2913,7 +2916,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 
 	if (!S_ISGITLINK(one->mode) &&
 	    (!one->sha1_valid ||
-	     reuse_worktree_file(name, one->sha1, 1))) {
+	     reuse_worktree_file(name, one->oid.hash, 1))) {
 		struct stat st;
 		if (lstat(name, &st) < 0) {
 			if (errno == ENOENT)
@@ -2926,7 +2929,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 				die_errno("readlink(%s)", name);
 			prep_temp_blob(name, temp, sb.buf, sb.len,
 				       (one->sha1_valid ?
-					one->sha1 : null_sha1),
+					one->oid.hash : null_sha1),
 				       (one->sha1_valid ?
 					one->mode : S_IFLNK));
 			strbuf_release(&sb);
@@ -2937,7 +2940,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 			if (!one->sha1_valid)
 				sha1_to_hex_r(temp->hex, null_sha1);
 			else
-				sha1_to_hex_r(temp->hex, one->sha1);
+				sha1_to_hex_r(temp->hex, one->oid.hash);
 			/* Even though we may sometimes borrow the
 			 * contents from the work tree, we always want
 			 * one->mode.  mode is trustworthy even when
@@ -2952,7 +2955,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		if (diff_populate_filespec(one, 0))
 			die("cannot read data blob for %s", one->path);
 		prep_temp_blob(name, temp, one->data, one->size,
-			       one->sha1, one->mode);
+			       one->oid.hash, one->mode);
 	}
 	return temp;
 }
@@ -3065,7 +3068,7 @@ static void fill_metainfo(struct strbuf *msg,
 	default:
 		*must_show_header = 0;
 	}
-	if (one && two && hashcmp(one->sha1, two->sha1)) {
+	if (one && two && oidcmp(&one->oid, &two->oid)) {
 		int abbrev = DIFF_OPT_TST(o, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
 
 		if (DIFF_OPT_TST(o, BINARY)) {
@@ -3075,8 +3078,8 @@ static void fill_metainfo(struct strbuf *msg,
 				abbrev = 40;
 		}
 		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
-			    find_unique_abbrev(one->sha1, abbrev));
-		strbuf_addstr(msg, find_unique_abbrev(two->sha1, abbrev));
+			    find_unique_abbrev(one->oid.hash, abbrev));
+		strbuf_addstr(msg, find_unique_abbrev(two->oid.hash, abbrev));
 		if (one->mode == two->mode)
 			strbuf_addf(msg, " %06o", one->mode);
 		strbuf_addf(msg, "%s\n", reset);
@@ -3134,17 +3137,17 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 		if (!one->sha1_valid) {
 			struct stat st;
 			if (one->is_stdin) {
-				hashcpy(one->sha1, null_sha1);
+				hashcpy(one->oid.hash, null_sha1);
 				return;
 			}
 			if (lstat(one->path, &st) < 0)
 				die_errno("stat '%s'", one->path);
-			if (index_path(one->sha1, one->path, &st, 0))
+			if (index_path(one->oid.hash, one->path, &st, 0))
 				die("cannot hash %s", one->path);
 		}
 	}
 	else
-		hashclr(one->sha1);
+		oidclr(&one->oid);
 }
 
 static void strip_prefix(int prefix_length, const char **namep, const char **otherp)
@@ -4118,8 +4121,9 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 	fprintf(opt->file, "%s", diff_line_prefix(opt));
 	if (!(opt->output_format & DIFF_FORMAT_NAME_STATUS)) {
 		fprintf(opt->file, ":%06o %06o %s ", p->one->mode, p->two->mode,
-			diff_unique_abbrev(p->one->sha1, opt->abbrev));
-		fprintf(opt->file, "%s ", diff_unique_abbrev(p->two->sha1, opt->abbrev));
+			diff_unique_abbrev(p->one->oid.hash, opt->abbrev));
+		fprintf(opt->file, "%s ",
+			diff_unique_abbrev(p->two->oid.hash, opt->abbrev));
 	}
 	if (p->score) {
 		fprintf(opt->file, "%c%03d%c", p->status, similarity_index(p),
@@ -4169,7 +4173,7 @@ int diff_unmodified_pair(struct diff_filepair *p)
 	 * dealing with a change.
 	 */
 	if (one->sha1_valid && two->sha1_valid &&
-	    !hashcmp(one->sha1, two->sha1) &&
+	    !oidcmp(&one->oid, &two->oid) &&
 	    !one->dirty_submodule && !two->dirty_submodule)
 		return 1; /* no change */
 	if (!one->sha1_valid && !two->sha1_valid)
@@ -4233,7 +4237,7 @@ void diff_debug_filespec(struct diff_filespec *s, int x, const char *one)
 		s->path,
 		DIFF_FILE_VALID(s) ? "valid" : "invalid",
 		s->mode,
-		s->sha1_valid ? sha1_to_hex(s->sha1) : "");
+		s->sha1_valid ? oid_to_hex(&s->oid) : "");
 	fprintf(stderr, "queue[%d] %s size %lu\n",
 		x, one ? one : "",
 		s->size);
@@ -4303,11 +4307,11 @@ static void diff_resolve_rename_copy(void)
 			else
 				p->status = DIFF_STATUS_RENAMED;
 		}
-		else if (hashcmp(p->one->sha1, p->two->sha1) ||
+		else if (oidcmp(&p->one->oid, &p->two->oid) ||
 			 p->one->mode != p->two->mode ||
 			 p->one->dirty_submodule ||
 			 p->two->dirty_submodule ||
-			 is_null_sha1(p->one->sha1))
+			 is_null_oid(&p->one->oid))
 			p->status = DIFF_STATUS_MODIFIED;
 		else {
 			/* This is a "no-change" entry and should not
@@ -4523,8 +4527,10 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
 		if (diff_filespec_is_binary(p->one) ||
 		    diff_filespec_is_binary(p->two)) {
-			git_SHA1_Update(&ctx, sha1_to_hex(p->one->sha1), 40);
-			git_SHA1_Update(&ctx, sha1_to_hex(p->two->sha1), 40);
+			git_SHA1_Update(&ctx, oid_to_hex(&p->one->oid),
+					40);
+			git_SHA1_Update(&ctx, oid_to_hex(&p->two->oid),
+					40);
 			continue;
 		}
 
@@ -5113,7 +5119,8 @@ size_t fill_textconv(struct userdiff_driver *driver,
 		die("BUG: fill_textconv called with non-textconv driver");
 
 	if (driver->textconv_cache && df->sha1_valid) {
-		*outbuf = notes_cache_get(driver->textconv_cache, df->sha1,
+		*outbuf = notes_cache_get(driver->textconv_cache,
+					  df->oid.hash,
 					  &size);
 		if (*outbuf)
 			return size;
@@ -5125,7 +5132,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 
 	if (driver->textconv_cache && df->sha1_valid) {
 		/* ignore errors, as we might be in a readonly repository */
-		notes_cache_put(driver->textconv_cache, df->sha1, *outbuf,
+		notes_cache_put(driver->textconv_cache, df->oid.hash, *outbuf,
 				size);
 		/*
 		 * we could save up changes and flush them all at the end,
diff --git a/diffcore-break.c b/diffcore-break.c
index 5473493e..a3e79608 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -58,7 +58,7 @@ static int should_break(struct diff_filespec *src,
 	}
 
 	if (src->sha1_valid && dst->sha1_valid &&
-	    !hashcmp(src->sha1, dst->sha1))
+	    !oidcmp(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7f03eb5a..22b239a4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -60,7 +60,8 @@ static int add_rename_dst(struct diff_filespec *two)
 		memmove(rename_dst + first + 1, rename_dst + first,
 			(rename_dst_nr - first - 1) * sizeof(*rename_dst));
 	rename_dst[first].two = alloc_filespec(two->path);
-	fill_filespec(rename_dst[first].two, two->sha1, two->sha1_valid, two->mode);
+	fill_filespec(rename_dst[first].two, two->oid.hash, two->sha1_valid,
+		      two->mode);
 	rename_dst[first].pair = NULL;
 	return 0;
 }
@@ -263,9 +264,10 @@ static unsigned int hash_filespec(struct diff_filespec *filespec)
 	if (!filespec->sha1_valid) {
 		if (diff_populate_filespec(filespec, 0))
 			return 0;
-		hash_sha1_file(filespec->data, filespec->size, "blob", filespec->sha1);
+		hash_sha1_file(filespec->data, filespec->size, "blob",
+			       filespec->oid.hash);
 	}
-	return sha1hash(filespec->sha1);
+	return sha1hash(filespec->oid.hash);
 }
 
 static int find_identical_files(struct hashmap *srcs,
@@ -287,7 +289,7 @@ static int find_identical_files(struct hashmap *srcs,
 		struct diff_filespec *source = p->filespec;
 
 		/* False hash collision? */
-		if (hashcmp(source->sha1, target->sha1))
+		if (oidcmp(&source->oid, &target->oid))
 			continue;
 		/* Non-regular files? If so, the modes must match! */
 		if (!S_ISREG(source->mode) || !S_ISREG(target->mode)) {
@@ -466,7 +468,7 @@ void diffcore_rename(struct diff_options *options)
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
 			else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
-				 is_empty_blob_sha1(p->two->sha1))
+				 is_empty_blob_sha1(p->two->oid.hash))
 				continue;
 			else if (add_rename_dst(p->two) < 0) {
 				warning("skipping rename detection, detected"
@@ -476,7 +478,7 @@ void diffcore_rename(struct diff_options *options)
 			}
 		}
 		else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
-			 is_empty_blob_sha1(p->one->sha1))
+			 is_empty_blob_sha1(p->one->oid.hash))
 			continue;
 		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
 			/*
diff --git a/diffcore.h b/diffcore.h
index 33ea2de3..c40e5b6c 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -25,7 +25,7 @@
 struct userdiff_driver;
 
 struct diff_filespec {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *path;
 	void *data;
 	void *cnt_data;
diff --git a/line-log.c b/line-log.c
index bbe31ed6..02938639 100644
--- a/line-log.c
+++ b/line-log.c
@@ -520,7 +520,7 @@ static void fill_line_ends(struct diff_filespec *spec, long *lines,
 	char *data = NULL;
 
 	if (diff_populate_filespec(spec, 0))
-		die("Cannot read blob %s", sha1_to_hex(spec->sha1));
+		die("Cannot read blob %s", oid_to_hex(&spec->oid));
 
 	ALLOC_ARRAY(ends, size);
 	ends[cur++] = 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 65cb5d6c..1e802097 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -134,11 +134,13 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 		int ostage2 = ostage1 ^ 1;
 
 		ci->ren1_other.path = pair1->one->path;
-		hashcpy(ci->ren1_other.sha1, src_entry1->stages[ostage1].sha);
+		hashcpy(ci->ren1_other.oid.hash,
+			src_entry1->stages[ostage1].sha);
 		ci->ren1_other.mode = src_entry1->stages[ostage1].mode;
 
 		ci->ren2_other.path = pair2->one->path;
-		hashcpy(ci->ren2_other.sha1, src_entry2->stages[ostage2].sha);
+		hashcpy(ci->ren2_other.oid.hash,
+			src_entry2->stages[ostage2].sha);
 		ci->ren2_other.mode = src_entry2->stages[ostage2].mode;
 	}
 }
@@ -552,13 +554,13 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 		if (remove_file_from_cache(path))
 			return -1;
 	if (o)
-		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
+		if (add_cacheinfo(o->mode, o->oid.hash, path, 1, 0, options))
 			return -1;
 	if (a)
-		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options))
+		if (add_cacheinfo(a->mode, a->oid.hash, path, 2, 0, options))
 			return -1;
 	if (b)
-		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options))
+		if (add_cacheinfo(b->mode, b->oid.hash, path, 3, 0, options))
 			return -1;
 	return 0;
 }
@@ -572,9 +574,9 @@ static void update_entry(struct stage_data *entry,
 	entry->stages[1].mode = o->mode;
 	entry->stages[2].mode = a->mode;
 	entry->stages[3].mode = b->mode;
-	hashcpy(entry->stages[1].sha, o->sha1);
-	hashcpy(entry->stages[2].sha, a->sha1);
-	hashcpy(entry->stages[3].sha, b->sha1);
+	hashcpy(entry->stages[1].sha, o->oid.hash);
+	hashcpy(entry->stages[2].sha, a->oid.hash);
+	hashcpy(entry->stages[3].sha, b->oid.hash);
 }
 
 static int remove_file(struct merge_options *o, int clean,
@@ -871,9 +873,9 @@ static int merge_3way(struct merge_options *o,
 		name2 = mkpathdup("%s", branch2);
 	}
 
-	read_mmblob(&orig, one->sha1);
-	read_mmblob(&src1, a->sha1);
-	read_mmblob(&src2, b->sha1);
+	read_mmblob(&orig, one->oid.hash);
+	read_mmblob(&src1, a->oid.hash);
+	read_mmblob(&src2, b->oid.hash);
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2, &ll_opts);
@@ -902,13 +904,13 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 		result.clean = 0;
 		if (S_ISREG(a->mode)) {
 			result.mode = a->mode;
-			hashcpy(result.sha, a->sha1);
+			hashcpy(result.sha, a->oid.hash);
 		} else {
 			result.mode = b->mode;
-			hashcpy(result.sha, b->sha1);
+			hashcpy(result.sha, b->oid.hash);
 		}
 	} else {
-		if (!sha_eq(a->sha1, one->sha1) && !sha_eq(b->sha1, one->sha1))
+		if (!sha_eq(a->oid.hash, one->oid.hash) && !sha_eq(b->oid.hash, one->oid.hash))
 			result.merge = 1;
 
 		/*
@@ -924,10 +926,10 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			}
 		}
 
-		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, one->sha1))
-			hashcpy(result.sha, b->sha1);
-		else if (sha_eq(b->sha1, one->sha1))
-			hashcpy(result.sha, a->sha1);
+		if (sha_eq(a->oid.hash, b->oid.hash) || sha_eq(a->oid.hash, one->oid.hash))
+			hashcpy(result.sha, b->oid.hash);
+		else if (sha_eq(b->oid.hash, one->oid.hash))
+			hashcpy(result.sha, a->oid.hash);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int merge_status;
@@ -947,13 +949,15 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			result.clean = (merge_status == 0);
 		} else if (S_ISGITLINK(a->mode)) {
 			result.clean = merge_submodule(result.sha,
-						       one->path, one->sha1,
-						       a->sha1, b->sha1,
+						       one->path,
+						       one->oid.hash,
+						       a->oid.hash,
+						       b->oid.hash,
 						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
-			hashcpy(result.sha, a->sha1);
+			hashcpy(result.sha, a->oid.hash);
 
-			if (!sha_eq(a->sha1, b->sha1))
+			if (!sha_eq(a->oid.hash, b->oid.hash))
 				result.clean = 0;
 		} else {
 			die(_("unsupported object type in the tree"));
@@ -1000,11 +1004,11 @@ static struct merge_file_info merge_file_one(struct merge_options *o,
 	struct diff_filespec one, a, b;
 
 	one.path = a.path = b.path = (char *)path;
-	hashcpy(one.sha1, o_sha);
+	hashcpy(one.oid.hash, o_sha);
 	one.mode = o_mode;
-	hashcpy(a.sha1, a_sha);
+	hashcpy(a.oid.hash, a_sha);
 	a.mode = a_mode;
-	hashcpy(b.sha1, b_sha);
+	hashcpy(b.oid.hash, b_sha);
 	b.mode = b_mode;
 	return merge_file_1(o, &one, &a, &b, branch1, branch2);
 }
@@ -1079,16 +1083,16 @@ static void conflict_rename_delete(struct merge_options *o,
 	int b_mode = 0;
 
 	if (rename_branch == o->branch1) {
-		a_sha = dest->sha1;
+		a_sha = dest->oid.hash;
 		a_mode = dest->mode;
 	} else {
-		b_sha = dest->sha1;
+		b_sha = dest->oid.hash;
 		b_mode = dest->mode;
 	}
 
 	handle_change_delete(o,
 			     o->call_depth ? orig->path : dest->path,
-			     orig->sha1, orig->mode,
+			     orig->oid.hash, orig->mode,
 			     a_sha, a_mode,
 			     b_sha, b_mode,
 			     _("rename"), _("renamed"));
@@ -1111,7 +1115,7 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	unsigned mode = entry->stages[stage].mode;
 	if (mode == 0 || is_null_sha1(sha))
 		return NULL;
-	hashcpy(target->sha1, sha);
+	hashcpy(target->oid.hash, sha);
 	target->mode = mode;
 	return target;
 }
@@ -1140,7 +1144,7 @@ static void handle_file(struct merge_options *o,
 	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
 	if (add) {
 		char *add_name = unique_path(o, rename->path, other_branch);
-		update_file(o, 0, add->sha1, add->mode, add_name);
+		update_file(o, 0, add->oid.hash, add->mode, add_name);
 
 		remove_file(o, 0, rename->path, 0);
 		dst_name = unique_path(o, rename->path, cur_branch);
@@ -1151,7 +1155,7 @@ static void handle_file(struct merge_options *o,
 			       rename->path, other_branch, dst_name);
 		}
 	}
-	update_file(o, 0, rename->sha1, rename->mode, dst_name);
+	update_file(o, 0, rename->oid.hash, rename->mode, dst_name);
 	if (stage == 2)
 		update_stages(rename->path, NULL, rename, add);
 	else
@@ -1180,9 +1184,9 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		struct diff_filespec other;
 		struct diff_filespec *add;
 		mfi = merge_file_one(o, one->path,
-				 one->sha1, one->mode,
-				 a->sha1, a->mode,
-				 b->sha1, b->mode,
+				 one->oid.hash, one->mode,
+				 a->oid.hash, a->mode,
+				 b->oid.hash, b->mode,
 				 ci->branch1, ci->branch2);
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
@@ -1202,12 +1206,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 */
 		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
 		if (add)
-			update_file(o, 0, add->sha1, add->mode, a->path);
+			update_file(o, 0, add->oid.hash, add->mode, a->path);
 		else
 			remove_file_from_cache(a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add)
-			update_file(o, 0, add->sha1, add->mode, b->path);
+			update_file(o, 0, add->oid.hash, add->mode, b->path);
 		else
 			remove_file_from_cache(b->path);
 	} else {
@@ -1421,13 +1425,15 @@ static int process_renames(struct merge_options *o,
 			remove_file(o, 1, ren1_src,
 				    renamed_stage == 2 || !was_tracked(ren1_src));
 
-			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
+			hashcpy(src_other.oid.hash,
+				ren1->src_entry->stages[other_stage].sha);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;
-			hashcpy(dst_other.sha1, ren1->dst_entry->stages[other_stage].sha);
+			hashcpy(dst_other.oid.hash,
+				ren1->dst_entry->stages[other_stage].sha);
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
-			if (sha_eq(src_other.sha1, null_sha1)) {
+			if (sha_eq(src_other.oid.hash, null_sha1)) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   ren1->pair,
 							   NULL,
@@ -1439,7 +1445,7 @@ static int process_renames(struct merge_options *o,
 							   NULL,
 							   NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
-				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
+				   sha_eq(dst_other.oid.hash, ren1->pair->two->oid.hash)) {
 				/*
 				 * Added file on the other side identical to
 				 * the file being renamed: clean merge.
@@ -1449,12 +1455,12 @@ static int process_renames(struct merge_options *o,
 				 * update_file().
 				 */
 				update_file_flags(o,
-						  ren1->pair->two->sha1,
+						  ren1->pair->two->oid.hash,
 						  ren1->pair->two->mode,
 						  ren1_dst,
 						  1, /* update_cache */
 						  0  /* update_wd    */);
-			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
+			} else if (!sha_eq(dst_other.oid.hash, null_sha1)) {
 				clean_merge = 0;
 				try_merge = 1;
 				output(o, 1, _("CONFLICT (rename/add): Rename %s->%s in %s. "
@@ -1464,8 +1470,10 @@ static int process_renames(struct merge_options *o,
 				if (o->call_depth) {
 					struct merge_file_info mfi;
 					mfi = merge_file_one(o, ren1_dst, null_sha1, 0,
-							 ren1->pair->two->sha1, ren1->pair->two->mode,
-							 dst_other.sha1, dst_other.mode,
+							 ren1->pair->two->oid.hash,
+							 ren1->pair->two->mode,
+							 dst_other.oid.hash,
+							 dst_other.mode,
 							 branch1, branch2);
 					output(o, 1, _("Adding merged %s"), ren1_dst);
 					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
@@ -1473,7 +1481,8 @@ static int process_renames(struct merge_options *o,
 				} else {
 					char *new_path = unique_path(o, ren1_dst, branch2);
 					output(o, 1, _("Adding as %s instead"), new_path);
-					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
+					update_file(o, 0, dst_other.oid.hash,
+						    dst_other.mode, new_path);
 					free(new_path);
 				}
 			} else
@@ -1599,11 +1608,11 @@ static int merge_content(struct merge_options *o,
 		o_sha = (unsigned char *)null_sha1;
 	}
 	one.path = a.path = b.path = (char *)path;
-	hashcpy(one.sha1, o_sha);
+	hashcpy(one.oid.hash, o_sha);
 	one.mode = o_mode;
-	hashcpy(a.sha1, a_sha);
+	hashcpy(a.oid.hash, a_sha);
 	a.mode = a_mode;
-	hashcpy(b.sha1, b_sha);
+	hashcpy(b.oid.hash, b_sha);
 	b.mode = b_mode;
 
 	if (rename_conflict_info) {
@@ -1664,7 +1673,7 @@ static int merge_content(struct merge_options *o,
 			else {
 				int file_from_stage2 = was_tracked(path);
 				struct diff_filespec merged;
-				hashcpy(merged.sha1, mfi.sha);
+				hashcpy(merged.oid.hash, mfi.sha);
 				merged.mode = mfi.mode;
 
 				update_stages(path, NULL,
diff --git a/notes-merge.c b/notes-merge.c
index 34bfac0c..62c23d8a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -41,14 +41,14 @@ static int verify_notes_filepair(struct diff_filepair *p, unsigned char *sha1)
 	switch (p->status) {
 	case DIFF_STATUS_MODIFIED:
 		assert(p->one->mode == p->two->mode);
-		assert(!is_null_sha1(p->one->sha1));
-		assert(!is_null_sha1(p->two->sha1));
+		assert(!is_null_oid(&p->one->oid));
+		assert(!is_null_oid(&p->two->oid));
 		break;
 	case DIFF_STATUS_ADDED:
-		assert(is_null_sha1(p->one->sha1));
+		assert(is_null_oid(&p->one->oid));
 		break;
 	case DIFF_STATUS_DELETED:
-		assert(is_null_sha1(p->two->sha1));
+		assert(is_null_oid(&p->two->oid));
 		break;
 	default:
 		return -1;
@@ -142,27 +142,27 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 		if (verify_notes_filepair(p, obj)) {
 			trace_printf("\t\tCannot merge entry '%s' (%c): "
 			       "%.7s -> %.7s. Skipping!\n", p->one->path,
-			       p->status, sha1_to_hex(p->one->sha1),
-			       sha1_to_hex(p->two->sha1));
+			       p->status, oid_to_hex(&p->one->oid),
+			       oid_to_hex(&p->two->oid));
 			continue;
 		}
 		mp = find_notes_merge_pair_pos(changes, len, obj, 1, &occupied);
 		if (occupied) {
 			/* We've found an addition/deletion pair */
 			assert(!hashcmp(mp->obj, obj));
-			if (is_null_sha1(p->one->sha1)) { /* addition */
+			if (is_null_oid(&p->one->oid)) { /* addition */
 				assert(is_null_sha1(mp->remote));
-				hashcpy(mp->remote, p->two->sha1);
-			} else if (is_null_sha1(p->two->sha1)) { /* deletion */
+				hashcpy(mp->remote, p->two->oid.hash);
+			} else if (is_null_oid(&p->two->oid)) { /* deletion */
 				assert(is_null_sha1(mp->base));
-				hashcpy(mp->base, p->one->sha1);
+				hashcpy(mp->base, p->one->oid.hash);
 			} else
 				assert(!"Invalid existing change recorded");
 		} else {
 			hashcpy(mp->obj, obj);
-			hashcpy(mp->base, p->one->sha1);
+			hashcpy(mp->base, p->one->oid.hash);
 			hashcpy(mp->local, uninitialized);
-			hashcpy(mp->remote, p->two->sha1);
+			hashcpy(mp->remote, p->two->oid.hash);
 			len++;
 		}
 		trace_printf("\t\tStored remote change for %s: %.7s -> %.7s\n",
@@ -203,21 +203,21 @@ static void diff_tree_local(struct notes_merge_options *o,
 		if (verify_notes_filepair(p, obj)) {
 			trace_printf("\t\tCannot merge entry '%s' (%c): "
 			       "%.7s -> %.7s. Skipping!\n", p->one->path,
-			       p->status, sha1_to_hex(p->one->sha1),
-			       sha1_to_hex(p->two->sha1));
+			       p->status, oid_to_hex(&p->one->oid),
+			       oid_to_hex(&p->two->oid));
 			continue;
 		}
 		mp = find_notes_merge_pair_pos(changes, len, obj, 0, &match);
 		if (!match) {
 			trace_printf("\t\tIgnoring local-only change for %s: "
 			       "%.7s -> %.7s\n", sha1_to_hex(obj),
-			       sha1_to_hex(p->one->sha1),
-			       sha1_to_hex(p->two->sha1));
+			       oid_to_hex(&p->one->oid),
+			       oid_to_hex(&p->two->oid));
 			continue;
 		}
 
 		assert(!hashcmp(mp->obj, obj));
-		if (is_null_sha1(p->two->sha1)) { /* deletion */
+		if (is_null_oid(&p->two->oid)) { /* deletion */
 			/*
 			 * Either this is a true deletion (1), or it is part
 			 * of an A/D pair (2), or D/A pair (3):
@@ -229,7 +229,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 			 */
 			if (!hashcmp(mp->local, uninitialized))
 				hashclr(mp->local);
-		} else if (is_null_sha1(p->one->sha1)) { /* addition */
+		} else if (is_null_oid(&p->one->oid)) { /* addition */
 			/*
 			 * Either this is a true addition (1), or it is part
 			 * of an A/D pair (2), or D/A pair (3):
@@ -240,16 +240,16 @@ static void diff_tree_local(struct notes_merge_options *o,
 			 */
 			assert(is_null_sha1(mp->local) ||
 			       !hashcmp(mp->local, uninitialized));
-			hashcpy(mp->local, p->two->sha1);
+			hashcpy(mp->local, p->two->oid.hash);
 		} else { /* modification */
 			/*
 			 * This is a true modification. p->one->sha1 shall
 			 * match mp->base, and mp->local shall be uninitialized.
 			 * Set mp->local to p->two->sha1.
 			 */
-			assert(!hashcmp(p->one->sha1, mp->base));
+			assert(!hashcmp(p->one->oid.hash, mp->base));
 			assert(!hashcmp(mp->local, uninitialized));
-			hashcpy(mp->local, p->two->sha1);
+			hashcpy(mp->local, p->two->oid.hash);
 		}
 		trace_printf("\t\tStored local change for %s: %.7s -> %.7s\n",
 		       sha1_to_hex(mp->obj), sha1_to_hex(mp->base),
diff --git a/submodule.c b/submodule.c
index 4532b11d..cdccf65c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -445,7 +445,7 @@ static void collect_submodules_from_diff(struct diff_queue_struct *q,
 		struct diff_filepair *p = q->queue[i];
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
-		if (submodule_needs_pushing(p->two->path, p->two->sha1))
+		if (submodule_needs_pushing(p->two->path, p->two->oid.hash))
 			string_list_insert(needs_pushing, p->two->path);
 	}
 }
@@ -577,7 +577,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 			 * being moved around. */
 			struct string_list_item *path;
 			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
-			if (!path && !is_submodule_commit_present(p->two->path, p->two->sha1))
+			if (!path && !is_submodule_commit_present(p->two->path, p->two->oid.hash))
 				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
 		} else {
 			/* Submodule is new or was moved here */
diff --git a/wt-status.c b/wt-status.c
index 4f27bd62..7c2fa8cd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -432,7 +432,8 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			d->worktree_status = p->status;
 		d->dirty_submodule = p->two->dirty_submodule;
 		if (S_ISGITLINK(p->two->mode))
-			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
+			d->new_submodule_commits = !!oidcmp(&p->one->oid,
+							    &p->two->oid);
 	}
 }
 
