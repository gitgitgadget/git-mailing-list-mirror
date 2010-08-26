From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] ll-merge: replace flag argument with options struct
Date: Thu, 26 Aug 2010 00:49:53 -0500
Message-ID: <20100826054953.GE9708@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100826054158.GB9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 07:51:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVNF-0002v3-M5
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 07:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab0HZFvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 01:51:36 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54209 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab0HZFvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 01:51:35 -0400
Received: by yxg6 with SMTP id 6so505432yxg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 22:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PBA3/gaCDuU2XoUAUQJTtHXzgv35iD5hc8HenlPx/Eo=;
        b=FCL9x5YPOC63EVpkEyO0OhxOutBgjijaw5O2skBlenfYKAEmftSSCHvP+6qAM4SJWT
         puKB77TWEPtRE5nlTGSfgFSKKrXzFsTuUeHoJMrwxtEWoUbHFRrqgl0r7BrpPhhsz6t0
         QjTpV1+cfc/QPZnKrErIvso6x5CxGz60tEOM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HtHTu0P6JOnR5iTjo7clumG6R1XVL8YsQ9utHDNd5WLHzgRn9iqS5pq2xDO/aom99h
         WEDAZgfMixOOcGQPPYtfTzQ7la0sY/iVlsqxI3OpgOhc1+30n2dbGGcfleVUqKmsA+GM
         zUAtYrjAfuBR/WXKL2J8kiZz0KZQNhRf9C834=
Received: by 10.151.131.12 with SMTP id i12mr9913763ybn.110.1282801894295;
        Wed, 25 Aug 2010 22:51:34 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 18sm7138459ybk.19.2010.08.25.22.51.33
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 22:51:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100826054158.GB9708@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154513>

Keeping track of the flag bits is proving more trouble than it's
worth.  Instead, use a pointer to an options struct like most similar
APIs do.

Callers with no special requests can pass NULL to request the default
options.

Cc: Bert Wesarg <bert.wesarg@googlemail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
Helped-by: Justin Frankel <justin@cockos.com>
Helped-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This time, with updated documentation.

Let's avoid the die("BUG: ...") ugliness by using assert().

 Documentation/technical/api-merge.txt |   73 +++++++++++++++++++++++---------
 builtin/checkout.c                    |    2 +-
 ll-merge.c                            |   49 +++++++++++++++-------
 ll-merge.h                            |   21 +++-------
 merge-file.c                          |    2 +-
 merge-recursive.c                     |   22 +++++-----
 rerere.c                              |    2 +-
 7 files changed, 105 insertions(+), 66 deletions(-)

diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
index a7e050b..9dc1bed 100644
--- a/Documentation/technical/api-merge.txt
+++ b/Documentation/technical/api-merge.txt
@@ -17,6 +17,40 @@ responsible for a few things.
    path-specific merge drivers (specified in `.gitattributes`)
    into account.
 
+Data structures
+---------------
+
+* `mmbuffer_t`, `mmfile_t`
+
+These store data usable for use by the xdiff backend, for writing and
+for reading, respectively.  See `xdiff/xdiff.h` for the definitions
+and `diff.c` for examples.
+
+* `struct ll_merge_options`
+
+This describes the set of options the calling program wants to affect
+the operation of a low-level (single file) merge.  Some options:
+
+`virtual_ancestor`::
+	Behave as though this were part of a merge between common
+	ancestors in a recursive merge.
+	If a helper program is specified by the
+	`[merge "<driver>"] recursive` configuration, it will
+	be used (see linkgit:gitattributes[5]).
+
+`variant`::
+	Resolve local conflicts automatically in favor
+	of one side or the other (as in 'git merge-file'
+	`--ours`/`--theirs`/`--union`).  Can be `0`,
+	`XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`, or
+	`XDL_MERGE_FAVOR_UNION`.
+
+`renormalize`::
+	Resmudge and clean the "base", "theirs" and "ours" files
+	before merging.  Use this when the merge is likely to have
+	overlapped with a change in smudge/clean or end-of-line
+	normalization rules.
+
 Low-level (single file) merge
 -----------------------------
 
@@ -28,15 +62,24 @@ Low-level (single file) merge
 	`.git/info/attributes` into account.  Returns 0 for a
 	clean merge.
 
-The caller:
-
-1. allocates an mmbuffer_t variable for the result;
-2. allocates and fills variables with the file's original content
-   and two modified versions (using `read_mmfile`, for example);
-3. calls ll_merge();
-4. reads the output from result_buf.ptr and result_buf.size;
-5. releases buffers when finished (free(ancestor.ptr); free(ours.ptr);
-   free(theirs.ptr); free(result_buf.ptr);).
+Calling sequence:
+
+* Prepare a `struct ll_merge_options` to record options.
+  If you have no special requests, skip this and pass `NULL`
+  as the `opts` parameter to use the default options.
+
+* Allocate an mmbuffer_t variable for the result.
+
+* Allocate and fill variables with the file's original content
+  and two modified versions (using `read_mmfile`, for example).
+
+* Call `ll_merge()`.
+
+* Read the merged content from `result_buf.ptr` and `result_buf.size`.
+
+* Release buffers when finished.  A simple
+  `free(ancestor.ptr); free(ours.ptr); free(theirs.ptr);
+  free(result_buf.ptr);` will do.
 
 If the modifications do not merge cleanly, `ll_merge` will return a
 nonzero value and `result_buf` will generally include a description of
@@ -47,18 +90,6 @@ The `ancestor_label`, `our_label`, and `their_label` parameters are
 used to label the different sides of a conflict if the merge driver
 supports this.
 
-The `flag` parameter is a bitfield:
-
- - The `LL_OPT_VIRTUAL_ANCESTOR` bit indicates whether this is an
-   internal merge to consolidate ancestors for a recursive merge.
-
- - The `LL_OPT_FAVOR_MASK` bits allow local conflicts to be automatically
-   resolved in favor of one side or the other (as in 'git merge-file'
-   `--ours`/`--theirs`/`--union`).
-   They can be populated by `create_ll_flag`, whose argument can be
-   `XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`, or
-   `XDL_MERGE_FAVOR_UNION`.
-
 Everything else
 ---------------
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 24b67d5..4d36b28 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -155,7 +155,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	 * merge.renormalize set, too
 	 */
 	status = ll_merge(&result_buf, path, &ancestor, "base",
-			  &ours, "ours", &theirs, "theirs", 0);
+			  &ours, "ours", &theirs, "theirs", NULL);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
diff --git a/ll-merge.c b/ll-merge.c
index 6bb3095..9bd3732 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -18,7 +18,7 @@ typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
 			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int flag,
+			   const struct ll_merge_options *opts,
 			   int marker_size);
 
 struct ll_merge_driver {
@@ -39,14 +39,18 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int flag, int marker_size)
+			   const struct ll_merge_options *opts,
+			   int marker_size)
 {
+	mmfile_t *stolen;
+	assert(opts);
+
 	/*
 	 * The tentative merge result is "ours" for the final round,
 	 * or common ancestor for an internal merge.  Still return
 	 * "conflicted merge" status.
 	 */
-	mmfile_t *stolen = (flag & LL_OPT_VIRTUAL_ANCESTOR) ? orig : src1;
+	stolen = opts->virtual_ancestor ? orig : src1;
 
 	result->ptr = stolen->ptr;
 	result->size = stolen->size;
@@ -60,9 +64,11 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int flag, int marker_size)
+			const struct ll_merge_options *opts,
+			int marker_size)
 {
 	xmparam_t xmp;
+	assert(opts);
 
 	if (buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
@@ -74,12 +80,12 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 				       orig, orig_name,
 				       src1, name1,
 				       src2, name2,
-				       flag, marker_size);
+				       opts, marker_size);
 	}
 
 	memset(&xmp, 0, sizeof(xmp));
 	xmp.level = XDL_MERGE_ZEALOUS;
-	xmp.favor = ll_opt_favor(flag);
+	xmp.favor = opts->variant;
 	if (git_xmerge_style >= 0)
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
@@ -96,14 +102,17 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmfile_t *orig, const char *orig_name,
 			  mmfile_t *src1, const char *name1,
 			  mmfile_t *src2, const char *name2,
-			  int flag, int marker_size)
+			  const struct ll_merge_options *opts,
+			  int marker_size)
 {
 	/* Use union favor */
-	flag &= ~LL_OPT_FAVOR_MASK;
-	flag |= create_ll_flag(XDL_MERGE_FAVOR_UNION);
+	struct ll_merge_options o;
+	assert(opts);
+	o = *opts;
+	o.variant = XDL_MERGE_FAVOR_UNION;
 	return ll_xdl_merge(drv_unused, result, path_unused,
 			    orig, NULL, src1, NULL, src2, NULL,
-			    flag, marker_size);
+			    &o, marker_size);
 	return 0;
 }
 
@@ -136,7 +145,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int flag, int marker_size)
+			const struct ll_merge_options *opts,
+			int marker_size)
 {
 	char temp[4][50];
 	struct strbuf cmd = STRBUF_INIT;
@@ -144,6 +154,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	const char *args[] = { NULL, NULL };
 	int status, fd, i;
 	struct stat st;
+	assert(opts);
 
 	dict[0].placeholder = "O"; dict[0].value = temp[0];
 	dict[1].placeholder = "A"; dict[1].value = temp[1];
@@ -337,15 +348,21 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
-	     int flag)
+	     const struct ll_merge_options *opts)
 {
 	static struct git_attr_check check[2];
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
-	int virtual_ancestor = flag & LL_OPT_VIRTUAL_ANCESTOR;
 
-	if (flag & LL_OPT_RENORMALIZE) {
+	if (!opts) {
+		struct ll_merge_options default_opts = {0};
+		return ll_merge(result_buf, path, ancestor, ancestor_label,
+				ours, our_label, theirs, their_label,
+				&default_opts);
+	}
+
+	if (opts->renormalize) {
 		normalize_file(ancestor, path);
 		normalize_file(ours, path);
 		normalize_file(theirs, path);
@@ -359,11 +376,11 @@ int ll_merge(mmbuffer_t *result_buf,
 		}
 	}
 	driver = find_ll_merge_driver(ll_driver_name);
-	if (virtual_ancestor && driver->recursive)
+	if (opts->virtual_ancestor && driver->recursive)
 		driver = find_ll_merge_driver(driver->recursive);
 	return driver->fn(driver, result_buf, path, ancestor, ancestor_label,
 			  ours, our_label, theirs, their_label,
-			  flag, marker_size);
+			  opts, marker_size);
 }
 
 int ll_merge_marker_size(const char *path)
diff --git a/ll-merge.h b/ll-merge.h
index ff7ca87..4b707f0 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -5,27 +5,18 @@
 #ifndef LL_MERGE_H
 #define LL_MERGE_H
 
-#define LL_OPT_VIRTUAL_ANCESTOR	(1 << 0)
-#define LL_OPT_FAVOR_MASK	((1 << 1) | (1 << 2))
-#define LL_OPT_FAVOR_SHIFT 1
-#define LL_OPT_RENORMALIZE	(1 << 3)
-
-static inline int ll_opt_favor(int flag)
-{
-	return (flag & LL_OPT_FAVOR_MASK) >> LL_OPT_FAVOR_SHIFT;
-}
-
-static inline int create_ll_flag(int favor)
-{
-	return ((favor << LL_OPT_FAVOR_SHIFT) & LL_OPT_FAVOR_MASK);
-}
+struct ll_merge_options {
+	unsigned virtual_ancestor : 1;
+	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
+	unsigned renormalize : 1;
+};
 
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
-	     int flag);
+	     const struct ll_merge_options *opts);
 
 int ll_merge_marker_size(const char *path);
 
diff --git a/merge-file.c b/merge-file.c
index db4d0d5..f7f4533 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -37,7 +37,7 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	 * common ancestor.
 	 */
 	merge_status = ll_merge(&res, path, base, NULL,
-				our, ".our", their, ".their", 0);
+				our, ".our", their, ".their", NULL);
 	if (merge_status < 0)
 		return NULL;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 44576b7..0e9a29d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -608,22 +608,25 @@ static int merge_3way(struct merge_options *o,
 		      const char *branch2)
 {
 	mmfile_t orig, src1, src2;
+	struct ll_merge_options ll_opts = {0};
 	char *base_name, *name1, *name2;
 	int merge_status;
-	int favor;
 
-	if (o->call_depth)
-		favor = 0;
-	else {
+	ll_opts.renormalize = o->renormalize;
+
+	if (o->call_depth) {
+		ll_opts.virtual_ancestor = 1;
+		ll_opts.variant = 0;
+	} else {
 		switch (o->recursive_variant) {
 		case MERGE_RECURSIVE_OURS:
-			favor = XDL_MERGE_FAVOR_OURS;
+			ll_opts.variant = XDL_MERGE_FAVOR_OURS;
 			break;
 		case MERGE_RECURSIVE_THEIRS:
-			favor = XDL_MERGE_FAVOR_THEIRS;
+			ll_opts.variant = XDL_MERGE_FAVOR_THEIRS;
 			break;
 		default:
-			favor = 0;
+			ll_opts.variant = 0;
 			break;
 		}
 	}
@@ -646,10 +649,7 @@ static int merge_3way(struct merge_options *o,
 	read_mmblob(&src2, b->sha1);
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
-				&src1, name1, &src2, name2,
-				((o->call_depth ? LL_OPT_VIRTUAL_ANCESTOR : 0) |
-				 (o->renormalize ? LL_OPT_RENORMALIZE : 0) |
-				 create_ll_flag(favor)));
+				&src1, name1, &src2, name2, &ll_opts);
 
 	free(name1);
 	free(name2);
diff --git a/rerere.c b/rerere.c
index e40af0d..b180218 100644
--- a/rerere.c
+++ b/rerere.c
@@ -325,7 +325,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	 */
 	ll_merge(&result, path, &mmfile[0], NULL,
 		 &mmfile[1], "ours",
-		 &mmfile[2], "theirs", 0);
+		 &mmfile[2], "theirs", NULL);
 	for (i = 0; i < 3; i++)
 		free(mmfile[i].ptr);
 
-- 
1.7.2.2
