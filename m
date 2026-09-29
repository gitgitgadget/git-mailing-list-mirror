Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB713C1983
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664763; cv=none; b=IwHHhm5qLOdknJ3Pbt/Gq+tCNIFqoYB9dtRwjNd1P+9G69mR4r4MT/vhp3WPLMYc5OqklfaLjRUmui/KeVqu1pmY0gQLVzY6Isd9+/j2M3HjCxOBKZ84neAumr+fZb6JFo+SjogMsEWl40RGo4fNGgMP61TSNkIHK91Fc9rA/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664763; c=relaxed/simple;
	bh=qAB8PX8qCySW9kI/KEnL5fBXUd+K88TGwkThKq1W7Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbZt/HG8sVFWZ41lp0BHoXNZUNP2pGe6P29/CEwNxdhl9mR3orDOAwzso4IjDoaKKgj4WGSUOLZC9/Dl8GVzrrDRrjd2gpdUUDDpYSWT6fYoCvD8iXuv8jcYVh0RpV7kKvJaEYGUBFRsQFJP4UZnqJUnI4cy1HBmIlG2P8q8enQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eFGrK5CP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eFGrK5CP"
Received: (qmail 70145 invoked by uid 106); 29 Sep 2026 06:52:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qAB8PX8qCySW9kI/KEnL5fBXUd+K88TGwkThKq1W7Zw=; b=eFGrK5CPd4FUM7sHXSIx+n+IwZJBWq9gdsDjdWe/kuxYrsBIs7rqnk6wye5ZKarbMBcCYssN+yARC+uOt+T1DpJSE/3jPxvlxRqTEioJ1kFJiD3U38X5/FerFI/3EOb+Gz0Jr44JInxr3vhVTCkNhuzaJt/ktoV3G8MwkAI9dv8bCHeof23cgbN77a99jchnbGez4znN5eyDcPR1Dt4Tclv6MCGLjtIYgdjt2WSfmzqh50XkEaww08ujvZeYqcqTp5lj2hvxG/q5Sf5uGLx/E5nMjuqbPnjt9r/7BpZwACy6KO5hHfoUG2ZUpcwjsnfH1kWuEguYSRSp15fJthJrNw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 06:52:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 289512 invoked by uid 111); 29 Sep 2026 06:52:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 02:52:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 02:52:39 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/5] xdiff: replace mmbuffer_t with mmfile_t
Message-ID: <20260929065239.GB1697497@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929064935.GA1276867@coredump.intra.peff.net>

Our import of xdiff has two identical buffer structures: mmfile_t and
mmbuffer_t. In upstream xdiff these were actually different, but the
import in 3443546f6e (Use a *real* built-in diff generator, 2006-03-24)
simplified mmfile_t to a simple buffer.

In xdiff we usually use mmfile_t for input and mmbuffer_t for output,
but they are really both just a ptr/len pair. I don't think that having
different types is buying us anything in terms of type safety or
semantics, and having two makes it awkward to use the same helpers for
both. In particular, an external merge driver's output is read from a
file, but we can't easily use read_mmfile(), since we want the result in
an mmbuffer_t.

Let's use mmfile_t for both cases and drop mmbuffer_t. The latter is
probably a more descriptive name, but we have many more uses of
mmfile_t (and helpers like read_mmfile). So let's consolidate using that
name; we can always change it to something more sensible later.

There should be no behavior change here; this is just consolidating the
types.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess this step might be controversial, but I hope not. I think the
ship has long sailed on trying to pull "upstream" changes from xdiff
(there haven't been any, and we've hacked it up quite a bit already).

 Documentation/technical/api-merge.adoc |  7 +++----
 apply.c                                |  2 +-
 builtin/checkout.c                     |  2 +-
 builtin/merge-file.c                   |  2 +-
 builtin/merge-tree.c                   |  2 +-
 builtin/rerere.c                       |  2 +-
 merge-blobs.c                          |  2 +-
 merge-ll.c                             | 12 ++++++------
 merge-ll.h                             |  4 ++--
 merge-ort.c                            |  4 ++--
 notes-merge.c                          |  2 +-
 rerere.c                               |  8 ++++----
 xdiff-interface.c                      |  2 +-
 xdiff/xdiff.h                          |  9 ++-------
 xdiff/xmerge.c                         |  4 ++--
 xdiff/xutils.c                         |  4 ++--
 16 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/Documentation/technical/api-merge.adoc b/Documentation/technical/api-merge.adoc
index c2ba01828c..b691599393 100644
--- a/Documentation/technical/api-merge.adoc
+++ b/Documentation/technical/api-merge.adoc
@@ -20,11 +20,10 @@ responsible for a few things.
 Data structures
 ---------------
 
-* `mmbuffer_t`, `mmfile_t`
+* `mmfile_t`
 
-These store data usable for use by the xdiff backend, for writing and
-for reading, respectively.  See `xdiff/xdiff.h` for the definitions
-and `diff.c` for examples.
+This stores a buffer and its size for input to or output from the xdiff
+backend. See `xdiff/xdiff.h` for the definition and `diff.c` for examples.
 
 * `struct ll_merge_options`
 
diff --git a/apply.c b/apply.c
index f00b7ba4d3..faf3c1dba0 100644
--- a/apply.c
+++ b/apply.c
@@ -3646,7 +3646,7 @@ static int three_way_merge(struct apply_state *state,
 {
 	mmfile_t base_file, our_file, their_file;
 	struct ll_merge_options merge_opts = LL_MERGE_OPTIONS_INIT;
-	mmbuffer_t result = { NULL };
+	mmfile_t result = { NULL };
 	enum ll_merge_result status;
 
 	/* resolve trivial cases first */
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c0f0d2c700..2d575a4f57 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -320,7 +320,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 	enum ll_merge_result merge_status;
 	int status;
 	struct object_id oid;
-	mmbuffer_t result_buf;
+	mmfile_t result_buf;
 	struct object_id threeway[3];
 	unsigned mode = 0;
 	struct ll_merge_options ll_opts = LL_MERGE_OPTIONS_INIT;
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 8fa5765239..ddca408c46 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -64,7 +64,7 @@ int cmd_merge_file(int argc,
 {
 	const char *names[3] = { 0 };
 	mmfile_t mmfs[3] = { 0 };
-	mmbuffer_t result = { 0 };
+	mmfile_t result = { 0 };
 	xmparam_t xmp = { 0 };
 	int ret = 0, i = 0, to_stdout = 0, object_id = 0;
 	int quiet = 0;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 49f41e520f..552c2ad736 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -109,7 +109,7 @@ static void *origin(struct merge_list *entry, size_t *size)
 	return NULL;
 }
 
-static int show_outf(void *priv UNUSED, mmbuffer_t *mb, int nbuf)
+static int show_outf(void *priv UNUSED, mmfile_t *mb, int nbuf)
 {
 	int i;
 	for (i = 0; i < nbuf; i++)
diff --git a/builtin/rerere.c b/builtin/rerere.c
index d39c6e8445..ef03b79f5b 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -16,7 +16,7 @@ static const char * const rerere_usage[] = {
 	NULL,
 };
 
-static int outf(void *dummy UNUSED, mmbuffer_t *ptr, int nbuf)
+static int outf(void *dummy UNUSED, mmfile_t *ptr, int nbuf)
 {
 	int i;
 	for (i = 0; i < nbuf; i++)
diff --git a/merge-blobs.c b/merge-blobs.c
index 16a75bd1e3..49dbec9529 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -38,7 +38,7 @@ static void *three_way_filemerge(struct index_state *istate,
 				 size_t *size)
 {
 	enum ll_merge_result merge_status;
-	mmbuffer_t res;
+	mmfile_t res;
 
 	/*
 	 * This function is only used by cmd_merge_tree, which
diff --git a/merge-ll.c b/merge-ll.c
index ef5287dee8..dfed6411a8 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -21,7 +21,7 @@
 struct ll_merge_driver;
 
 typedef enum ll_merge_result (*ll_merge_fn)(const struct ll_merge_driver *,
-			   mmbuffer_t *result,
+			   mmfile_t *result,
 			   const char *path,
 			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
@@ -56,7 +56,7 @@ void reset_merge_attributes(void)
  * Built-in low-levels
  */
 static enum ll_merge_result ll_binary_merge(const struct ll_merge_driver *drv UNUSED,
-			   mmbuffer_t *result,
+			   mmfile_t *result,
 			   const char *path UNUSED,
 			   mmfile_t *orig, const char *orig_name UNUSED,
 			   mmfile_t *src1, const char *name1 UNUSED,
@@ -101,7 +101,7 @@ static enum ll_merge_result ll_binary_merge(const struct ll_merge_driver *drv UN
 }
 
 static enum ll_merge_result ll_xdl_merge(const struct ll_merge_driver *drv_unused,
-			mmbuffer_t *result,
+			mmfile_t *result,
 			const char *path,
 			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
@@ -147,7 +147,7 @@ static enum ll_merge_result ll_xdl_merge(const struct ll_merge_driver *drv_unuse
 }
 
 static enum ll_merge_result ll_union_merge(const struct ll_merge_driver *drv_unused,
-			  mmbuffer_t *result,
+			  mmfile_t *result,
 			  const char *path,
 			  mmfile_t *orig, const char *orig_name,
 			  mmfile_t *src1, const char *name1,
@@ -189,7 +189,7 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
  * User defined low-level merge driver support.
  */
 static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
-			mmbuffer_t *result,
+			mmfile_t *result,
 			const char *path,
 			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
@@ -403,7 +403,7 @@ static void normalize_file(mmfile_t *mm, const char *path, struct index_state *i
 	}
 }
 
-enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
+enum ll_merge_result ll_merge(mmfile_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
diff --git a/merge-ll.h b/merge-ll.h
index f26aef238d..f95332c682 100644
--- a/merge-ll.h
+++ b/merge-ll.h
@@ -16,7 +16,7 @@
  *   If you have no special requests, skip this and pass `NULL`
  *   as the `opts` parameter to use the default options.
  *
- * - Allocate an mmbuffer_t variable for the result.
+ * - Allocate an mmfile_t variable for the result.
  *
  * - Allocate and fill variables with the file's original content
  *   and two modified versions (using `read_mmfile`, for example).
@@ -100,7 +100,7 @@ enum ll_merge_result {
  * `.gitattributes` or `.git/info/attributes` into account.
  * Returns 0 for a clean merge.
  */
-enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
+enum ll_merge_result ll_merge(mmfile_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
diff --git a/merge-ort.c b/merge-ort.c
index c410a5d353..1d3d193d35 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2111,7 +2111,7 @@ static int merge_3way(struct merge_options *opt,
 		      const struct object_id *b,
 		      const char *pathnames[3],
 		      const int extra_marker_size,
-		      mmbuffer_t *result_buf)
+		      mmfile_t *result_buf)
 {
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = LL_MERGE_OPTIONS_INIT;
@@ -2247,7 +2247,7 @@ static int handle_content_merge(struct merge_options *opt,
 
 	/* Remaining rules depend on file vs. submodule vs. symlink. */
 	else if (S_ISREG(a->mode)) {
-		mmbuffer_t result_buf;
+		mmfile_t result_buf;
 		int ret = 0, merge_status;
 		int two_way;
 
diff --git a/notes-merge.c b/notes-merge.c
index 118cad2518..d361e70a48 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -355,7 +355,7 @@ static void write_note_to_worktree(const struct object_id *obj,
 static int ll_merge_in_worktree(struct notes_merge_options *o,
 				struct notes_merge_pair *p)
 {
-	mmbuffer_t result_buf;
+	mmfile_t result_buf;
 	mmfile_t base, local, remote;
 	enum ll_merge_result status;
 
diff --git a/rerere.c b/rerere.c
index 856347c9ae..8696f8e7b7 100644
--- a/rerere.c
+++ b/rerere.c
@@ -597,7 +597,7 @@ int rerere_remaining(struct repository *r, struct string_list *merge_rr)
  */
 static int try_merge(struct index_state *istate,
 		     const struct rerere_id *id, const char *path,
-		     mmfile_t *cur, mmbuffer_t *result)
+		     mmfile_t *cur, mmfile_t *result)
 {
 	enum ll_merge_result ret;
 	mmfile_t base = {NULL, 0}, other = {NULL, 0};
@@ -638,7 +638,7 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 	int ret;
 	struct strbuf buf = STRBUF_INIT;
 	mmfile_t cur = {NULL, 0};
-	mmbuffer_t result = {NULL, 0};
+	mmfile_t result = {NULL, 0};
 
 	/*
 	 * Normalize the conflicts in path and write it out to
@@ -947,7 +947,7 @@ static int handle_cache(struct index_state *istate,
 			const char *path, unsigned char *hash, const char *output)
 {
 	mmfile_t mmfile[3] = {{NULL}};
-	mmbuffer_t result = {NULL, 0};
+	mmfile_t result = {NULL, 0};
 	const struct cache_entry *ce;
 	int pos, len, i, has_conflicts;
 	struct rerere_io_mem io;
@@ -1040,7 +1040,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 	     id->variant < id->collection->status_nr;
 	     id->variant++) {
 		mmfile_t cur;
-		mmbuffer_t result = {NULL, 0};
+		mmfile_t result = {NULL, 0};
 		int cleanly_resolved;
 
 		if (!has_rerere_resolution(id))
diff --git a/xdiff-interface.c b/xdiff-interface.c
index e3dd2184ae..bc340d5a8a 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -53,7 +53,7 @@ static int consume_one(void *priv_, char *s, unsigned long size)
 	return 0;
 }
 
-static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
+static int xdiff_outf(void *priv_, mmfile_t *mb, int nbuf)
 {
 	struct xdiff_emit_state *priv = priv_;
 	int i;
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index dc370712e9..334eb436f6 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -73,11 +73,6 @@ typedef struct s_mmfile {
 	long size;
 } mmfile_t;
 
-typedef struct s_mmbuffer {
-	char *ptr;
-	long size;
-} mmbuffer_t;
-
 typedef struct s_xpparam {
 	unsigned long flags;
 
@@ -96,7 +91,7 @@ typedef struct s_xdemitcb {
 			long old_begin, long old_nr,
 			long new_begin, long new_nr,
 			const char *func, long funclen);
-	int (*out_line)(void *, mmbuffer_t *, int);
+	int (*out_line)(void *, mmfile_t *, int);
 } xdemitcb_t;
 
 typedef long (*find_func_t)(const char *line, long line_len, char *buffer, long buffer_size, void *priv);
@@ -144,7 +139,7 @@ typedef struct s_xmparam {
 #define DEFAULT_CONFLICT_MARKER_SIZE 7
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
-		xmparam_t const *xmp, mmbuffer_t *result);
+		xmparam_t const *xmp, mmfile_t *result);
 
 #ifdef __cplusplus
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 659ad4ec97..7b37968d25 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -504,7 +504,7 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
  */
 static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		xdfenv_t *xe2, xdchange_t *xscr2,
-		xmparam_t const *xmp, mmbuffer_t *result)
+		xmparam_t const *xmp, mmfile_t *result)
 {
 	xdmerge_t *changes, *c;
 	xpparam_t const *xpp = &xmp->xpp;
@@ -682,7 +682,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 }
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
-		xmparam_t const *xmp, mmbuffer_t *result)
+		xmparam_t const *xmp, mmfile_t *result)
 {
 	xdchange_t *xscr1 = NULL, *xscr2 = NULL;
 	xdfenv_t xe1, xe2;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9a999acdc0..4215f646c5 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -39,7 +39,7 @@ uint64_t xdl_bogosqrt(uint64_t n) {
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 		     xdemitcb_t *ecb) {
 	int i = 2;
-	mmbuffer_t mb[3];
+	mmfile_t mb[3];
 
 	mb[0].ptr = (char *) pre;
 	mb[0].size = psize;
@@ -392,7 +392,7 @@ static int xdl_format_hunk_hdr(long s1, long c1, long s2, long c2,
 			       const char *func, long funclen,
 			       xdemitcb_t *ecb) {
 	int nb = 0;
-	mmbuffer_t mb;
+	mmfile_t mb;
 	char buf[128];
 
 	memcpy(buf, "@@ -", 4);
-- 
2.56.0.325.g545d7e68bc

