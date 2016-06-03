From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/10] diff.c: convert trivial snprintf calls to xsnprintf
Date: Fri, 3 Jun 2016 05:03:20 -0400
Message-ID: <20160603090320.GE28401@sigill.intra.peff.net>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603074724.12173-6-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 11:03:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8l0r-0005zD-Jw
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 11:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbcFCJDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 05:03:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:48324 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932133AbcFCJDY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 05:03:24 -0400
Received: (qmail 1756 invoked by uid 102); 3 Jun 2016 09:03:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 05:03:24 -0400
Received: (qmail 19231 invoked by uid 107); 3 Jun 2016 09:03:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 05:03:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 05:03:20 -0400
Content-Disposition: inline
In-Reply-To: <20160603074724.12173-6-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296290>

On Fri, Jun 03, 2016 at 07:47:20AM +0000, Elia Pinto wrote:

>  diff.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index d3734d3..fb61539 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4491,7 +4491,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
>  		len1 = remove_space(p->one->path, strlen(p->one->path));
>  		len2 = remove_space(p->two->path, strlen(p->two->path));
>  		if (p->one->mode == 0)
> -			len1 = snprintf(buffer, sizeof(buffer),
> +			len1 = xsnprintf(buffer, sizeof(buffer),
>  					"diff--gita/%.*sb/%.*s"
>  					"newfilemode%06o"
>  					"---/dev/null"

More that assume that PATH_MAX is plenty big for any patch we would
see. I'd argue these should be on the heap, which removes that
restriction, and gets rid of the "PATH_MAX * 4 + 20" magic at the top of
the function.

It looks like the buffer just gets fed into sha1, so I was also tempted
to suggest we simply feed the bits of string in directly. But we are
using the format string here to handle the mode, so you'd still have to
deal with that.

-Peff
