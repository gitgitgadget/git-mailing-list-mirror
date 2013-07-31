From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] log: use true parents for diff even when rewriting
Date: Wed, 31 Jul 2013 15:55:21 -0700
Message-ID: <20130731225520.GB25882@sigill.intra.peff.net>
References: <a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
 <e7f2ead2267ff78940aab00fe36c378a2ce5d85e.1375301293.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 01 00:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4fIn-0007Pk-2e
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 00:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760877Ab3GaWzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 18:55:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:51274 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757781Ab3GaWzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 18:55:24 -0400
Received: (qmail 31991 invoked by uid 102); 31 Jul 2013 22:55:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (107.226.235.221)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Jul 2013 17:55:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jul 2013 15:55:21 -0700
Content-Disposition: inline
In-Reply-To: <e7f2ead2267ff78940aab00fe36c378a2ce5d85e.1375301293.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231476>

On Wed, Jul 31, 2013 at 10:13:20PM +0200, Thomas Rast wrote:

> When using pathspec filtering in combination with diff-based log
> output, parent simplification happens before the diff is computed.
> The diff is therefore against the *simplified* parents.
> 
> This works okay, arguably by accident, in the normal case:
> simplification reduces to one parent as long as the commit is TREESAME
> to it.  So the simplified parent of any given commit must have the
> same tree contents on the filtered paths as its true (unfiltered)
> parent.
> 
> However, --full-diff breaks this guarantee, and indeed gives pretty
> spectacular results when comparing the output of
> 
>   git log --graph --stat ...
>   git log --graph --full-diff --stat ...
> 
> (--graph internally kicks in parent simplification, much like
> --parents).

Your description (and solution) make a lot of sense to me. Another code
path that has a similar problem is the "-g" reflog walker. It rewrites
the parents based on the reflog, and the diffs it produces are mostly
useless (e.g., try "git stash list -p").

Should we be applying the same technique there?

I guess it might bother people who really want to see the diff between
two lines in the reflog (e.g., comparing the results stored by "rebase"
with the previous version). I think that is rare enough that "git diff"
would be a better tool in that case, though.

And arguably, "log -g" should not be rewriting the parents at all,
because it makes "--graph" pointless (and indeed, we disallow the
combination). So potentially the solution is to stop the rewriting
entirely, not mask it for the diffs. But doing so might be a good
interim solution until somebody feels like rewriting the reflog walker.

-Peff
