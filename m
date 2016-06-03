From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] corner cases with "rev-list --use-bitmap-index -n"
Date: Fri, 3 Jun 2016 03:06:49 -0400
Message-ID: <20160603070649.GA24120@sigill.intra.peff.net>
References: <20160602230925.GA11196@sigill.intra.peff.net>
 <20160602231031.GA11247@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:07:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8jCG-000322-BF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 09:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbcFCHGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 03:06:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:48241 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751348AbcFCHGx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 03:06:53 -0400
Received: (qmail 29360 invoked by uid 102); 3 Jun 2016 07:06:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 03:06:52 -0400
Received: (qmail 18263 invoked by uid 107); 3 Jun 2016 07:07:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 03:07:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 03:06:49 -0400
Content-Disposition: inline
In-Reply-To: <20160602231031.GA11247@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296272>

On Thu, Jun 02, 2016 at 07:10:31PM -0400, Jeff King wrote:

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 275da0d..aaa79a3 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -360,6 +360,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  			uint32_t commit_count;
>  			if (!prepare_bitmap_walk(&revs)) {
>  				count_bitmap_commit_list(&commit_count, NULL, NULL, NULL);
> +				if (revs.max_count && revs.max_count < commit_count)
> +					commit_count = revs.max_count;

...aaaaand this patch is totally wrong. For one thing, the "not set"
sentinel value for max_count is "-1", not "0", so it didn't kick in for
"-n0".

And for another, any fallback traversal will actually decrement
revs.max_count, so we have to save the value before traversing.

And as luck would have it, those two bugs cancel each other out in many
cases (including the ones in the test suite!). If you pass "-n1", gets
decremented to "0".  That would give us a bogus adjustment, but instead
we decide that "0" means no adjustement is necessary, and return the
number of commits we traversed, which is the right answer as long as we
didn't hit any bitmaps on the way down (or we hit one right away, in
which case we didn't decrement at all).

Updated patches in a moment (the second has the same sentinel problem,
too).

-Peff
