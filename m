From: Jeff King <peff@peff.net>
Subject: Re: auto merge bug
Date: Tue, 5 Mar 2013 04:12:03 -0500
Message-ID: <20130305091203.GD13552@sigill.intra.peff.net>
References: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
 <20130305090326.GC13552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Krmpotic <david.krmpotic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 10:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCnvL-0006Xe-2j
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 10:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab3CEJMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 04:12:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35196 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997Ab3CEJMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 04:12:06 -0500
Received: (qmail 12542 invoked by uid 107); 5 Mar 2013 09:13:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 04:13:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 04:12:03 -0500
Content-Disposition: inline
In-Reply-To: <20130305090326.GC13552@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217439>

On Tue, Mar 05, 2013 at 04:03:26AM -0500, Jeff King wrote:

> You might be able to get by with a version of the "union" driver that
> asks the 3-way merge driver to be less aggressive about shrinking the
> conflict blocks. For example, with this patch to git:
> 
> diff --git a/ll-merge.c b/ll-merge.c
> index fb61ea6..61b1d4e 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -100,7 +100,6 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
>  	}
>  
>  	memset(&xmp, 0, sizeof(xmp));
> -	xmp.level = XDL_MERGE_ZEALOUS;
>  	xmp.favor = opts->variant;
>  	xmp.xpp.flags = opts->xdl_opts;
>  	if (git_xmerge_style >= 0)
> 
> I think the merge will produce the results you are looking for. This
> would have to be configurable, though, as it is a regression for
> existing users of "union", which would want the duplicate-line
> suppression (or maybe not; it will only catch such duplicates at the
> beginning and end of the conflict hunk, so maybe it is sane to always
> ask "union" to keep all lines).

Here's what the patch would look like to make it non-configurable, but
to just trigger for the "union" case:

diff --git a/ll-merge.c b/ll-merge.c
index fb61ea6..fc33a23 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -83,7 +83,8 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
 			const struct ll_merge_options *opts,
-			int marker_size)
+			int marker_size,
+			int level)
 {
 	xmparam_t xmp;
 	assert(opts);
@@ -100,7 +101,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	}
 
 	memset(&xmp, 0, sizeof(xmp));
-	xmp.level = XDL_MERGE_ZEALOUS;
+	xmp.level = level;
 	xmp.favor = opts->variant;
 	xmp.xpp.flags = opts->xdl_opts;
 	if (git_xmerge_style >= 0)
@@ -129,7 +130,23 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 	o.variant = XDL_MERGE_FAVOR_UNION;
 	return ll_xdl_merge(drv_unused, result, path_unused,
 			    orig, NULL, src1, NULL, src2, NULL,
-			    &o, marker_size);
+			    &o, marker_size, XDL_MERGE_MINIMAL);
+}
+
+static int ll_text_merge(const struct ll_merge_driver *drv,
+			 mmbuffer_t *result,
+			 const char *path,
+			 mmfile_t *orig, const char *orig_name,
+			 mmfile_t *src1, const char *name1,
+			 mmfile_t *src2, const char *name2,
+			 const struct ll_merge_options *opts,
+			 int marker_size)
+{
+	return ll_xdl_merge(drv, result, path,
+			    orig, orig_name,
+			    src1, name1,
+			    src2, name2,
+			    opts, marker_size, XDL_MERGE_ZEALOUS);
 }
 
 #define LL_BINARY_MERGE 0
@@ -137,7 +154,7 @@ static struct ll_merge_driver ll_merge_drv[] = {
 #define LL_UNION_MERGE 2
 static struct ll_merge_driver ll_merge_drv[] = {
 	{ "binary", "built-in binary merge", ll_binary_merge },
-	{ "text", "built-in 3-way text merge", ll_xdl_merge },
+	{ "text", "built-in 3-way text merge", ll_text_merge },
 	{ "union", "built-in union merge", ll_union_merge },
 };
 
