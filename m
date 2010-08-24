From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Mon, 23 Aug 2010 21:28:20 -0500
Message-ID: <20100824022820.GE17406@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 04:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnjHA-0002s5-NX
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 04:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab0HXCaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 22:30:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59152 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab0HXCaC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 22:30:02 -0400
Received: by qwh6 with SMTP id 6so5676679qwh.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 19:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t5pCwiyr4ZHWCGQCaz7XtEX6LBszc0e1WjTzkxCRfKY=;
        b=kXP+/L3Khb5gHc1JjBnAOkW3JZgp/YeWvTBZ6hGgqqww9j8AnRm1rhl4IJMHrHnsXf
         kNCi01kv4oAWq4Yrsr9X62NkdhShVx+zUGbbCj8hLejk9pxAwgkUq2x5qCaiPgUKI5pd
         lfwvsFWBYunySvHW4CSf9jfNQylvgOeKbls1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qJNySI2yzQd/sT7Z88575mpC4lkKrKlc6J6NIK22dYJdegcxVWZY2VGhgrA4xGWZuj
         YkIFA3IS0SldBz9tAKsCbwgH/YU/64qtXoSwFNLN+mrYO9cyey3jAi6bXZMYuj8+tFja
         4XpdiyClgiIOt0hEK/sVRzzlf8qWIKMJISsXY=
Received: by 10.224.67.193 with SMTP id s1mr3987882qai.28.1282617001406;
        Mon, 23 Aug 2010 19:30:01 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r36sm7902043qcs.27.2010.08.23.19.29.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 19:30:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100823205915.GA4484@ns1.cockos.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154278>

Justin Frankel wrote:

> This is for the next/ branch

Applies on top of jn/merge-renormalize.  Thanks for the reroll.

> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -49,6 +50,14 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>  				o.renormalize = 1;
>  			else if (!strcmp(arg+2, "no-renormalize"))
>  				o.renormalize = 0;
> +			else if (!strcmp(arg+2, "ignore-all-space"))
> +				o.xdl_opts |= XDF_IGNORE_WHITESPACE;
> +			else if (!strcmp(arg+2, "ignore-space-change"))
> +				o.xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
> +			else if (!strcmp(arg+2, "ignore-space-at-eol"))
> +				o.xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
> +			else if (!strcmp(arg+2, "patience"))
> +				o.xdl_opts |= XDF_PATIENCE_DIFF;

So this teaches merge-recursive and ll-merge to accept the xdiff
whitespace flags (plus "patience").

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -647,6 +648,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  				o.renormalize = 1;
>  			else if (!strcmp(xopts[x], "no-renormalize"))
>  				o.renormalize = 0;
> +			else if (!strcmp(xopts[x], "ignore-all-space"))
> +				o.xdl_opts |= XDF_IGNORE_WHITESPACE;
> +			else if (!strcmp(xopts[x], "ignore-space-change"))
> +				o.xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
> +			else if (!strcmp(xopts[x], "ignore-space-at-eol"))
> +				o.xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
> +			else if (!strcmp(xopts[x], "patience"))
> +				o.xdl_opts |= XDF_PATIENCE_DIFF;

It's tempting to fix this code duplication once and for all.

> +++ b/ll-merge.h
> @@ -7,19 +7,32 @@
>  
>  #define LL_OPT_VIRTUAL_ANCESTOR	(1 << 0)
>  #define LL_OPT_FAVOR_MASK	((1 << 1) | (1 << 2))
> -#define LL_OPT_FAVOR_SHIFT 1
> +#define LL_OPT_FAVOR_SHIFT 	1
>  #define LL_OPT_RENORMALIZE	(1 << 3)
> +#define LL_OPT_XDL_MASK 	(0x3F << 4)
> +#define LL_OPT_XDL_SHIFT 	4

The space-instead-of-tab was intentional: the idea is that this is a
table:

	name			bits
	VIRTUAL_ANCESTOR	0
	FAVOR_MASK		1, 2
	FAVOR_SHIFT = 1
	RENORMALIZE		3
	WHITESPACE_MASK		4, 5, 6
	WHITESPACE_SHIFT = 4
	PATIENCE		7

and since a shift is not a bitmask it does not deserve an entry in the
table.

The flag layout worries me a bit because presumably the next extension
would get bit 8, and so on.  What happens if xdiff learns another
whitespace-ignoring mode?

>  
>  static inline int ll_opt_favor(int flag)
>  {
>  	return (flag & LL_OPT_FAVOR_MASK) >> LL_OPT_FAVOR_SHIFT;
>  }
>  
> +static inline int ll_opt_xdl_opt(int flag)
> +{
> +	return ((flag & LL_OPT_XDL_MASK) >> LL_OPT_XDL_SHIFT);
> +}

Style nit: parentheses around a return value are not needed.

>  static inline int create_ll_flag(int favor)
>  {
>  	return ((favor << LL_OPT_FAVOR_SHIFT) & LL_OPT_FAVOR_MASK);
>  }

Looks like I am guilty of the same thing.
 
> +static inline int create_ll_flag_xdl_opt(int favor, int xdl_opt)
> +{
> +	return ((favor << LL_OPT_FAVOR_SHIFT) & LL_OPT_FAVOR_MASK) |
> +		((xdl_opt << LL_OPT_XDL_SHIFT) & LL_OPT_XDL_MASK);
> +}

This function (like its cousin create_ll_flag) is ugly, as Bert
noticed before.  I am starting to wonder if it would not be simpler
to use

 extern int ll_merge(..., const struct ll_merge_options *opts);

treating NULL as a request for the default options.

In other words, how about something like this?

-- 8< --
Subject: ll-merge: replace flag argument with options struct

Keeping track of the flag bits is proving more trouble than it's
worth.  Instead, use a pointer to an options struct like most similar
APIs do.

Callers with no special requests can pass NULL to request the default
options.

Cc: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout.c |    2 +-
 ll-merge.c         |   42 ++++++++++++++++++++++++++----------------
 ll-merge.h         |   21 ++++++---------------
 merge-file.c       |    2 +-
 merge-recursive.c  |   22 +++++++++++-----------
 rerere.c           |    2 +-
 6 files changed, 46 insertions(+), 45 deletions(-)

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
index 6bb3095..98f353a 100644
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
@@ -39,14 +39,15 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int flag, int marker_size)
+			   const struct ll_merge_options *opts,
+			   int marker_size)
 {
 	/*
 	 * The tentative merge result is "ours" for the final round,
 	 * or common ancestor for an internal merge.  Still return
 	 * "conflicted merge" status.
 	 */
-	mmfile_t *stolen = (flag & LL_OPT_VIRTUAL_ANCESTOR) ? orig : src1;
+	mmfile_t *stolen = opts->virtual_ancestor ? orig : src1;
 
 	result->ptr = stolen->ptr;
 	result->size = stolen->size;
@@ -60,7 +61,8 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int flag, int marker_size)
+			const struct ll_merge_options *opts,
+			int marker_size)
 {
 	xmparam_t xmp;
 
@@ -74,12 +76,12 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
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
@@ -96,14 +98,15 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
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
+	struct ll_merge_options o = *opts;
+	o.variant = XDL_MERGE_FAVOR_UNION;
 	return ll_xdl_merge(drv_unused, result, path_unused,
 			    orig, NULL, src1, NULL, src2, NULL,
-			    flag, marker_size);
+			    &o, marker_size);
 	return 0;
 }
 
@@ -136,7 +139,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int flag, int marker_size)
+			const struct ll_merge_options *opts,
+			int marker_size)
 {
 	char temp[4][50];
 	struct strbuf cmd = STRBUF_INIT;
@@ -337,15 +341,21 @@ int ll_merge(mmbuffer_t *result_buf,
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
@@ -359,11 +369,11 @@ int ll_merge(mmbuffer_t *result_buf,
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
index 762b549..ed09785 100644
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
