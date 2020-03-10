Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B79FC18E5A
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4754020727
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pVSDjzFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgCJSWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51052 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgCJSWL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 14:22:11 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 884A160892;
        Tue, 10 Mar 2020 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583864530;
        bh=22Fj7H/qm+6qbTa85S+cBTcQkLDSivB03fS699iLxPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=pVSDjzFpfDn8jhGMxh57qXkiGBpJu/mwLRMYfEIVHCvFWTG3duwXzVSypNbznbmY4
         LG+hbOhbPfTC/In5LBAq064txQF2x79RFnSombq0Ici1T8kCkcK6q28n6Pxyg1CUyG
         Isw/jBVC3YCfOmQPi6k5J+l6IT2uma0cn3lJ3ollSHodWH2y26n/VUqzMxXOuZRwlm
         +fA8q79bbSrOHwisiql1crpNYE6+zygWjkr0TzMolJPobM9xyrgLTUxo/0Q7dGUDc6
         2lk1mii1lIFDznOmZzAH4sTlv3U1m5LV7waY8dqXpN2QzDeOYaZdf31rbJ3cocgHKn
         q5VrIN1wSaPuRuCGY04MFJ68uHAQ2XYmitCVU6vm9l1Qp9e84avX4uhICDnV4AV4a3
         mwqoYNcyHW8JkrEO7A85josLl56ScQ94kG+pqIMq0u7MCA1kXa9H6SilzZb9RQwlCA
         eDxGiIYB4NjfPk7mXvNBqMYi+e7DCiBQ9USYtN/4scoQD42nK07
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/8] convert: provide additional metadata to filters
Date:   Tue, 10 Mar 2020 18:20:41 +0000
Message-Id: <20200310182046.748959-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200310182046.748959-1-sandals@crustytoothpaste.net>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

Now that we have the codebase wired up to pass any additional metadata
to filters, let's collect the additional metadata that we'd like to
pass.

The two main places we pass this metadata are checkouts and archives.
In these two situations, reading HEAD isn't a valid option, since HEAD
isn't updated for checkouts until after the working tree is written and
archives can accept an arbitrary tree.  In other situations, HEAD will
usually reflect the refname of the branch in current use.

We pass a smaller amount of data in other cases, such as git cat-file,
where we can really only logically know about the blob.

This commit updates only the parts of the checkout code where we don't
use unpack_trees.  That function and callers of it will be handled in a
future commit.

In the archive code, we leak a small amount of memory, since nothing we
pass in the archiver argument structure is freed.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 archive.c               | 13 ++++++++++---
 archive.h               |  1 +
 builtin/cat-file.c      |  5 ++++-
 builtin/checkout.c      |  4 ++++
 cache.h                 |  1 +
 convert.c               | 22 ++++++++++++++++++++++
 convert.h               | 17 +++++++++++++++++
 diff.c                  |  5 ++++-
 entry.c                 |  7 +++++--
 t/t0021/rot13-filter.pl |  6 ++++++
 10 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/archive.c b/archive.c
index d9e92cce58..fb39706120 100644
--- a/archive.c
+++ b/archive.c
@@ -77,6 +77,11 @@ void *object_file_to_archive(const struct archiver_args *args,
 {
 	void *buffer;
 	const struct commit *commit = args->convert ? args->commit : NULL;
+	struct checkout_metadata meta;
+
+	init_checkout_metadata(&meta, args->refname,
+			       args->commit_oid ? args->commit_oid :
+			       (args->tree ? &args->tree->object.oid : NULL), oid);
 
 	path += args->baselen;
 	buffer = read_object_file(oid, type, sizep);
@@ -85,7 +90,7 @@ void *object_file_to_archive(const struct archiver_args *args,
 		size_t size = 0;
 
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
-		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf, NULL);
+		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf, &meta);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf);
 		buffer = strbuf_detach(&buf, &size);
@@ -385,16 +390,17 @@ static void parse_treeish_arg(const char **argv,
 	struct tree *tree;
 	const struct commit *commit;
 	struct object_id oid;
+	char *ref = NULL;
 
 	/* Remotes are only allowed to fetch actual refs */
 	if (remote && !remote_allow_unreachable) {
-		char *ref = NULL;
 		const char *colon = strchrnul(name, ':');
 		int refnamelen = colon - name;
 
 		if (!dwim_ref(name, refnamelen, &oid, &ref))
 			die(_("no such ref: %.*s"), refnamelen, name);
-		free(ref);
+	} else {
+		dwim_ref(name, strlen(name), &oid, &ref);
 	}
 
 	if (get_oid(name, &oid))
@@ -427,6 +433,7 @@ static void parse_treeish_arg(const char **argv,
 
 		tree = parse_tree_indirect(&tree_oid);
 	}
+	ar_args->refname = ref;
 	ar_args->tree = tree;
 	ar_args->commit_oid = commit_oid;
 	ar_args->commit = commit;
diff --git a/archive.h b/archive.h
index e60e3dd31c..3bd96bf6bb 100644
--- a/archive.h
+++ b/archive.h
@@ -8,6 +8,7 @@ struct repository;
 
 struct archiver_args {
 	struct repository *repo;
+	const char *refname;
 	const char *base;
 	size_t baselen;
 	struct tree *tree;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 545fed4924..6ecc8ee6dc 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -42,7 +42,10 @@ static int filter_object(const char *path, unsigned mode,
 			     oid_to_hex(oid), path);
 	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
 		struct strbuf strbuf = STRBUF_INIT;
-		if (convert_to_working_tree(&the_index, path, *buf, *size, &strbuf, NULL)) {
+		struct checkout_metadata meta;
+
+		init_checkout_metadata(&meta, NULL, NULL, oid);
+		if (convert_to_working_tree(&the_index, path, *buf, *size, &strbuf, &meta)) {
 			free(*buf);
 			*size = strbuf.len;
 			*buf = strbuf_detach(&strbuf, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8a28f48d67..a7bfa3688d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -360,6 +360,10 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	state.refresh_cache = 1;
 	state.istate = &the_index;
 
+	init_checkout_metadata(&state.meta, info->path,
+			       info->commit ? &info->commit->object.oid : NULL,
+			       NULL);
+
 	enable_delayed_checkout(&state);
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
diff --git a/cache.h b/cache.h
index 37c899b53f..9b24e5d61f 100644
--- a/cache.h
+++ b/cache.h
@@ -1679,6 +1679,7 @@ struct checkout {
 	const char *base_dir;
 	int base_dir_len;
 	struct delayed_checkout *delayed_checkout;
+	struct checkout_metadata meta;
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
diff --git a/convert.c b/convert.c
index 6261921cfb..5aa87d45e3 100644
--- a/convert.c
+++ b/convert.c
@@ -2006,3 +2006,25 @@ int stream_filter(struct stream_filter *filter,
 {
 	return filter->vtbl->filter(filter, input, isize_p, output, osize_p);
 }
+
+void init_checkout_metadata(struct checkout_metadata *meta, const char *refname,
+			    const struct object_id *treeish,
+			    const struct object_id *blob)
+{
+	memset(meta, 0, sizeof(*meta));
+	if (refname)
+		meta->refname = refname;
+	if (treeish)
+		oidcpy(&meta->treeish, treeish);
+	if (blob)
+		oidcpy(&meta->blob, blob);
+}
+
+void clone_checkout_metadata(struct checkout_metadata *dst,
+			     const struct checkout_metadata *src,
+			     const struct object_id *blob)
+{
+	memcpy(dst, src, sizeof(*dst));
+	if (blob)
+		oidcpy(&dst->blob, blob);
+}
diff --git a/convert.h b/convert.h
index 894e01c38b..e29d1026a6 100644
--- a/convert.h
+++ b/convert.h
@@ -102,6 +102,23 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 int would_convert_to_git_filter_fd(const struct index_state *istate,
 				   const char *path);
 
+/*
+ * Initialize the checkout metadata with the given values.  Any argument may be
+ * NULL if it is not applicable.  The treeish should be a commit if that is
+ * available, and a tree otherwise.
+ *
+ * The refname is not copied and must be valid for the lifetime of the struct.
+ * THe object IDs are copied.
+ */
+void init_checkout_metadata(struct checkout_metadata *meta, const char *refname,
+			    const struct object_id *treeish,
+			    const struct object_id *blob);
+
+/* Copy the metadata from src to dst, updating the blob. */
+void clone_checkout_metadata(struct checkout_metadata *dst,
+			     const struct checkout_metadata *src,
+			     const struct object_id *blob);
+
 /*
  * Reset the internal list of attributes used by convert_to_git and
  * convert_to_working_tree.
diff --git a/diff.c b/diff.c
index 12761c8017..1010d806f5 100644
--- a/diff.c
+++ b/diff.c
@@ -4062,6 +4062,9 @@ static void prep_temp_blob(struct index_state *istate,
 	struct strbuf tempfile = STRBUF_INIT;
 	char *path_dup = xstrdup(path);
 	const char *base = basename(path_dup);
+	struct checkout_metadata meta;
+
+	init_checkout_metadata(&meta, NULL, NULL, oid);
 
 	/* Generate "XXXXXX_basename.ext" */
 	strbuf_addstr(&tempfile, "XXXXXX_");
@@ -4071,7 +4074,7 @@ static void prep_temp_blob(struct index_state *istate,
 	if (!temp->tempfile)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(istate, path,
-			(const char *)blob, (size_t)size, &buf, NULL)) {
+			(const char *)blob, (size_t)size, &buf, &meta)) {
 		blob = buf.buf;
 		size = buf.len;
 	}
diff --git a/entry.c b/entry.c
index 4b2d9b2dad..00b4903366 100644
--- a/entry.c
+++ b/entry.c
@@ -264,6 +264,9 @@ static int write_entry(struct cache_entry *ce,
 	size_t newsize = 0;
 	struct stat st;
 	const struct submodule *sub;
+	struct checkout_metadata meta;
+
+	clone_checkout_metadata(&meta, &state->meta, &ce->oid);
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(state->istate, ce->name,
@@ -315,13 +318,13 @@ static int write_entry(struct cache_entry *ce,
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
 			ret = async_convert_to_working_tree(state->istate, ce->name, new_blob,
-							    size, &buf, NULL, dco);
+							    size, &buf, &meta, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
 				free(new_blob);
 				goto delayed;
 			}
 		} else
-			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf, NULL);
+			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf, &meta);
 
 		if (ret) {
 			free(new_blob);
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 470107248e..c43cf433cf 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -135,7 +135,13 @@ sub rot13 {
 				if ( exists $DELAY{$pathname} and $DELAY{$pathname}{"requested"} == 0 ) {
 					$DELAY{$pathname}{"requested"} = 1;
 				}
+			} elsif ($buffer =~ /^(ref|treeish|blob)=/) {
+				# Do nothing.
 			} else {
+				# In general, filters need to be graceful about
+				# new metadata, since it's documented that we
+				# can pass any key-value pairs, but for tests,
+				# let's be a little stricter.
 				die "Unknown message '$buffer'";
 			}
 
