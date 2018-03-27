Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E581F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeC0QsC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:48:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:44884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753763AbeC0QsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:48:00 -0400
Received: (qmail 13008 invoked by uid 109); 27 Mar 2018 16:47:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Mar 2018 16:47:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31381 invoked by uid 111); 27 Mar 2018 16:48:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Mar 2018 12:48:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2018 12:47:58 -0400
Date:   Tue, 27 Mar 2018 12:47:58 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git complains packed-refs is not a directory when used with
 GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180327164757.GB24747@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net>
 <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 04:56:00PM +0200, Duy Nguyen wrote:

> The way setup_work_tree() does it is just bad to me. When it calls
> set_git_dir() again, the assumption is the new path is exactly the
> same as the old one. The only difference is relative vs absolute. But
> this is super hard to see from set_git_dir implementation. The new
> struct repository design also inherits this (i.e. allowing to call
> set_git_dir multiple times, which really does not make sense), but
> this won't fly long term. When cwd moves, all cached relative paths
> must be adjusted, we need a better mechanism to tell everybody that,
> not just do it for $GIT_DIR and related paths.

Yeah, I agree it's questionable.

> I am planning to fix this. This is part of the "setup cleanup" effort
> to keep repository.c design less messy and hopefully unify how the
> main repo and submodule repo are created/set up. But frankly that may
> take a long while before I could submit anything substantial (I also
> have the "report multiple worktree's HEADs correctly and make fsck
> count all HEADs" task, which is not small and to me have higher
> priority).
> 
> So I would not mind papering over it right now (with an understanding
> that absolute path pays some more overhead in path walking, which was
> th reason we tried to avoid it in setup code). A slightly better patch
> is trigger this path absolutization from setup_work_tree(), near
> set_git_dir(). But then you face some ugliness there: how to find out
> all ref stores to update, or just update the main ref store alone.

I don't quite get why f57f37e2 doesn't want to call git_path(). Is it to
avoid the way the path is munged? Or is it to avoid some lazy-setup that
is triggered by calling get_git_dir() at all (which doesn't make much
sense to me, because we'd already have called get_git_dir() much
earlier). Or is it just because we may sometimes fill in refs->git_dir
with something besides get_git_dir() (for a submodule or worktree or
something)?

I.e., can we do one of (depending on which of those answers is "yes"):

  1. Stop caching the value of get_git_dir(), and instead call it
     on-demand instead of looking at refs->git_dir? (If we just want to
     avoid git_path()).

  2. If we need to avoid even calling get_git_dir(), can we add a
     "light" version of it that avoids whatever side effects we're
     trying to skip?

  3. If the problem is just that sometimes we need get_git_dir() and
     sometimes not, could we perhaps store NULL as a sentinel to mean
     "look up get_git_dir() when you need it"?

     That would let submodules and worktrees fill in their paths as
     necessary (assuming they never change after init), but handle the
     case of get_git_dir() changing.

Hmm. Typing that out, it seems like (3) is probably the right path.
Something like the patch below seems to fix it and passes the tests.

diff --git a/refs.c b/refs.c
index 20ba82b434..4094f0e7d4 100644
--- a/refs.c
+++ b/refs.c
@@ -1656,7 +1656,7 @@ struct ref_store *get_main_ref_store(void)
 	if (main_ref_store)
 		return main_ref_store;
 
-	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
+	main_ref_store = ref_store_init(NULL, REF_STORE_ALL_CAPS);
 	return main_ref_store;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bec8e30e9e..22118b5764 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -69,6 +69,7 @@ struct files_ref_store {
 	struct ref_store base;
 	unsigned int store_flags;
 
+	/* may be NULL to force lookup of get_git_dir() */
 	char *gitdir;
 	char *gitcommondir;
 
@@ -94,17 +95,23 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
-	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_store_init(ref_store, &refs_be_files);
 	refs->store_flags = flags;
 
-	refs->gitdir = xstrdup(gitdir);
-	get_common_dir_noenv(&sb, gitdir);
-	refs->gitcommondir = strbuf_detach(&sb, NULL);
-	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
-	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
-	strbuf_release(&sb);
+	if (gitdir) {
+		struct strbuf sb = STRBUF_INIT;
+		refs->gitdir = xstrdup(gitdir);
+		get_common_dir_noenv(&sb, gitdir);
+		refs->gitcommondir = strbuf_detach(&sb, NULL);
+		strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
+		refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
+		strbuf_release(&sb);
+	} else {
+		refs->gitdir = NULL;
+		refs->gitcommondir = NULL;
+		refs->packed_ref_store = packed_ref_store_create(NULL, flags);
+	}
 
 	return ref_store;
 }
@@ -147,6 +154,16 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	return refs;
 }
 
+static const char *files_gitdir(const struct files_ref_store *refs)
+{
+	return refs->gitdir ? refs->gitdir : get_git_dir();
+}
+
+static const char *files_gitcommondir(const struct files_ref_store *refs)
+{
+	return refs->gitcommondir ? refs->gitcommondir : get_git_common_dir();
+}
+
 static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
@@ -154,10 +171,10 @@ static void files_reflog_path(struct files_ref_store *refs,
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
-		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
+		strbuf_addf(sb, "%s/logs/%s", files_gitdir(refs), refname);
 		break;
 	case REF_TYPE_NORMAL:
-		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
+		strbuf_addf(sb, "%s/logs/%s", files_gitcommondir(refs), refname);
 		break;
 	default:
 		die("BUG: unknown ref type %d of ref %s",
@@ -172,10 +189,10 @@ static void files_ref_path(struct files_ref_store *refs,
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
-		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
+		strbuf_addf(sb, "%s/%s", files_gitdir(refs), refname);
 		break;
 	case REF_TYPE_NORMAL:
-		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
+		strbuf_addf(sb, "%s/%s", files_gitcommondir(refs), refname);
 		break;
 	default:
 		die("BUG: unknown ref type %d of ref %s",
@@ -2151,13 +2168,13 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 		files_downcast(ref_store, REF_STORE_READ,
 			       "reflog_iterator_begin");
 
-	if (!strcmp(refs->gitdir, refs->gitcommondir)) {
-		return reflog_iterator_begin(ref_store, refs->gitcommondir);
+	if (!strcmp(files_gitdir(refs), files_gitcommondir(refs))) {
+		return reflog_iterator_begin(ref_store, files_gitcommondir(refs));
 	} else {
 		return merge_ref_iterator_begin(
 			0,
-			reflog_iterator_begin(ref_store, refs->gitdir),
-			reflog_iterator_begin(ref_store, refs->gitcommondir),
+			reflog_iterator_begin(ref_store, files_gitdir(refs)),
+			reflog_iterator_begin(ref_store, files_gitcommondir(refs)),
 			reflog_iterator_select, refs);
 	}
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 65288c6472..e5a5af1285 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -158,6 +158,16 @@ static void acquire_snapshot(struct snapshot *snapshot)
 	snapshot->referrers++;
 }
 
+static const char *packed_refs_path(const struct packed_ref_store *refs)
+{
+	return refs->path ? refs->path : git_path("packed-refs");
+}
+
+static const char *snapshot_path(const struct snapshot *snapshot)
+{
+	return packed_refs_path(snapshot->refs);
+}
+
 /*
  * If the buffer in `snapshot` is active, then either munmap the
  * memory and close the file, or free the memory. Then set the buffer
@@ -168,7 +178,7 @@ static void clear_snapshot_buffer(struct snapshot *snapshot)
 	if (snapshot->mmapped) {
 		if (munmap(snapshot->buf, snapshot->eof - snapshot->buf))
 			die_errno("error ummapping packed-refs file %s",
-				  snapshot->refs->path);
+				  snapshot_path(snapshot));
 		snapshot->mmapped = 0;
 	} else {
 		free(snapshot->buf);
@@ -201,7 +211,7 @@ struct ref_store *packed_ref_store_create(const char *path,
 	base_ref_store_init(ref_store, &refs_be_packed);
 	refs->store_flags = store_flags;
 
-	refs->path = xstrdup(path);
+	refs->path = xstrdup_or_null(path);
 	return ref_store;
 }
 
@@ -342,7 +352,7 @@ static void sort_snapshot(struct snapshot *snapshot)
 			/* The safety check should prevent this. */
 			BUG("unterminated line found in packed-refs");
 		if (eol - pos < GIT_SHA1_HEXSZ + 2)
-			die_invalid_line(snapshot->refs->path,
+			die_invalid_line(snapshot_path(snapshot),
 					 pos, eof - pos);
 		eol++;
 		if (eol < eof && *eol == '^') {
@@ -454,7 +464,7 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 
 	last_line = find_start_of_record(start, eof - 1);
 	if (*(eof - 1) != '\n' || eof - last_line < GIT_SHA1_HEXSZ + 2)
-		die_invalid_line(snapshot->refs->path,
+		die_invalid_line(snapshot_path(snapshot),
 				 last_line, eof - last_line);
 }
 
@@ -473,7 +483,7 @@ static int load_contents(struct snapshot *snapshot)
 	size_t size;
 	ssize_t bytes_read;
 
-	fd = open(snapshot->refs->path, O_RDONLY);
+	fd = open(snapshot_path(snapshot), O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT) {
 			/*
@@ -485,14 +495,14 @@ static int load_contents(struct snapshot *snapshot)
 			 */
 			return 0;
 		} else {
-			die_errno("couldn't read %s", snapshot->refs->path);
+			die_errno("couldn't read %s", snapshot_path(snapshot));
 		}
 	}
 
 	stat_validity_update(&snapshot->validity, fd);
 
 	if (fstat(fd, &st) < 0)
-		die_errno("couldn't stat %s", snapshot->refs->path);
+		die_errno("couldn't stat %s", snapshot_path(snapshot));
 	size = xsize_t(st.st_size);
 
 	if (!size) {
@@ -501,7 +511,7 @@ static int load_contents(struct snapshot *snapshot)
 		snapshot->buf = xmalloc(size);
 		bytes_read = read_in_full(fd, snapshot->buf, size);
 		if (bytes_read < 0 || bytes_read != size)
-			die_errno("couldn't read %s", snapshot->refs->path);
+			die_errno("couldn't read %s", snapshot_path(snapshot));
 		snapshot->mmapped = 0;
 	} else {
 		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -629,14 +639,14 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 		eol = memchr(snapshot->buf, '\n',
 			     snapshot->eof - snapshot->buf);
 		if (!eol)
-			die_unterminated_line(refs->path,
+			die_unterminated_line(packed_refs_path(refs),
 					      snapshot->buf,
 					      snapshot->eof - snapshot->buf);
 
 		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
 
 		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
-			die_invalid_line(refs->path,
+			die_invalid_line(packed_refs_path(refs),
 					 snapshot->buf,
 					 snapshot->eof - snapshot->buf);
 
@@ -695,7 +705,8 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 static void validate_snapshot(struct packed_ref_store *refs)
 {
 	if (refs->snapshot &&
-	    !stat_validity_check(&refs->snapshot->validity, refs->path))
+	    !stat_validity_check(&refs->snapshot->validity,
+				 packed_refs_path(refs)))
 		clear_snapshot(refs);
 }
 
@@ -739,7 +750,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 	}
 
 	if (get_oid_hex(rec, oid))
-		die_invalid_line(refs->path, rec, snapshot->eof - rec);
+		die_invalid_line(packed_refs_path(refs), rec, snapshot->eof - rec);
 
 	*type = REF_ISPACKED;
 	return 0;
@@ -795,12 +806,12 @@ static int next_record(struct packed_ref_iterator *iter)
 	if (iter->eof - p < GIT_SHA1_HEXSZ + 2 ||
 	    parse_oid_hex(p, &iter->oid, &p) ||
 	    !isspace(*p++))
-		die_invalid_line(iter->snapshot->refs->path,
+		die_invalid_line(snapshot_path(iter->snapshot),
 				 iter->pos, iter->eof - iter->pos);
 
 	eol = memchr(p, '\n', iter->eof - p);
 	if (!eol)
-		die_unterminated_line(iter->snapshot->refs->path,
+		die_unterminated_line(snapshot_path(iter->snapshot),
 				      iter->pos, iter->eof - iter->pos);
 
 	strbuf_add(&iter->refname_buf, p, eol - p);
@@ -825,7 +836,7 @@ static int next_record(struct packed_ref_iterator *iter)
 		if (iter->eof - p < GIT_SHA1_HEXSZ + 1 ||
 		    parse_oid_hex(p, &iter->peeled, &p) ||
 		    *p++ != '\n')
-			die_invalid_line(iter->snapshot->refs->path,
+			die_invalid_line(snapshot_path(iter->snapshot),
 					 iter->pos, iter->eof - iter->pos);
 		iter->pos = p;
 
@@ -995,14 +1006,14 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	 */
 	if (hold_lock_file_for_update_timeout(
 			    &refs->lock,
-			    refs->path,
+			    packed_refs_path(refs),
 			    flags, timeout_value) < 0) {
-		unable_to_lock_message(refs->path, errno, err);
+		unable_to_lock_message(packed_refs_path(refs), errno, err);
 		return -1;
 	}
 
 	if (close_lock_file_gently(&refs->lock)) {
-		strbuf_addf(err, "unable to close %s: %s", refs->path, strerror(errno));
+		strbuf_addf(err, "unable to close %s: %s", packed_refs_path(refs), strerror(errno));
 		rollback_lock_file(&refs->lock);
 		return -1;
 	}
@@ -1471,21 +1482,21 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_finish");
 	int ret = TRANSACTION_GENERIC_ERROR;
-	char *packed_refs_path;
+	char *path;
 
 	clear_snapshot(refs);
 
-	packed_refs_path = get_locked_file_path(&refs->lock);
-	if (rename_tempfile(&refs->tempfile, packed_refs_path)) {
+	path = get_locked_file_path(&refs->lock);
+	if (rename_tempfile(&refs->tempfile, path)) {
 		strbuf_addf(err, "error replacing %s: %s",
-			    refs->path, strerror(errno));
+			    path, strerror(errno));
 		goto cleanup;
 	}
 
 	ret = 0;
 
 cleanup:
-	free(packed_refs_path);
+	free(path);
 	packed_transaction_cleanup(refs, transaction);
 	return ret;
 }
