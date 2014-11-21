From: Jeff King <peff@peff.net>
Subject: Re: git merge a b when a == b but neither == o is always a
 successful merge?
Date: Fri, 21 Nov 2014 13:15:40 -0500
Message-ID: <20141121181539.GC26650@peff.net>
References: <21610.16623.746985.383838@perdition.linnaean.org>
 <20141117205304.GA15880@peff.net>
 <21610.29903.366230.851787@perdition.linnaean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Hagerty <hag@linnaean.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 19:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrskH-0003IK-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 19:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbaKUSPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 13:15:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:43304 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751463AbaKUSPm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 13:15:42 -0500
Received: (qmail 15829 invoked by uid 102); 21 Nov 2014 18:15:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Nov 2014 12:15:41 -0600
Received: (qmail 25849 invoked by uid 107); 21 Nov 2014 18:15:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Nov 2014 13:15:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Nov 2014 13:15:40 -0500
Content-Disposition: inline
In-Reply-To: <21610.29903.366230.851787@perdition.linnaean.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 05:21:03PM -0500, Daniel Hagerty wrote:

>  > I don't think there is an easy way to get what you want. You would have
>  > to write a new merge 3-way strategy that handles this case differently.
>  > And most of the file-level heavy lifting in merge strategies is done by
>  > the low-level unpack_trees code, which handles this case. From "git help
> 
>     I have a very rough draft that seems to do what I want, exposed
> through .gitattributes (below).  Given that this is something you probably
> want tightly scoped, does it make sense to expose it anywhere else?

This is the first use of gitattributes in the unpack-trees code path. I
cannot think offhand of any philosophical reason that should not be OK,
but it is something worth considering (i.e., this code path is deep
plumbing; are there cases where we would not want to support
gitattributes?).

>     Is it accurate to speak of this as exposing merge minimal?

I am not 100% sure they are not orthogonal concepts. The tree-diff is
about "just because two separate changes ended at the same place does
not mean they should be merged into the same change". I am actually not
sure what XDL_MERGE_MINIMAL entails exactly. Is it only about coalescing
overlapping endpoints in the merge? Documentation is sparse.

The patch itself doesn't look too bad. It covers the file-level case and
the content-level case. Is there additional code needed to handle the
directory-level case? That is, if I have a tree that starts at
sha1 X, and ends up at sha1 Y in both sides of the merge, do we still
descend into it to make the file-level comparisons, or do we optimize
that out?

> diff --git a/ll-merge.c b/ll-merge.c
> index da59738..2a06ac9 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -84,7 +84,16 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
>  	}
> 
>  	memset(&xmp, 0, sizeof(xmp));
> -	xmp.level = XDL_MERGE_ZEALOUS;
> +
> +	struct git_attr_check check;
> +	check.attr = git_attr("merge-minimal");
> +	(void) git_check_attr(path, 1, &check);

Please void C99 decl-after-statement, as we build on older compilers
that do not like it.

We also do not typically annotate ignored return values.

> +	if(ATTR_TRUE(check.value))
> +	  xmp.level = XDL_MERGE_MINIMAL;
> +	else
> +	  xmp.level = XDL_MERGE_ZEALOUS;

..and indentations should be a single tab.

Other than those minor style nits, I do not see anything obviously
_wrong_ with the patch, but I am far from an expert in the area. It
would need documentation and tests, of course. The next step may be to
wrap it up with those things and post it to the list, which will likely
get more attention.

-Peff
