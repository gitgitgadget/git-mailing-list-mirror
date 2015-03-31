From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cherry-pick: fix docs describing handling of empty
 commits
Date: Mon, 30 Mar 2015 21:21:02 -0400
Message-ID: <20150331012102.GA17961@peff.net>
References: <20150331010854.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:21:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yckrf-0007Hq-0o
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbbCaBVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:21:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:40098 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752066AbbCaBVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:21:05 -0400
Received: (qmail 28346 invoked by uid 102); 31 Mar 2015 01:21:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 20:21:05 -0500
Received: (qmail 18957 invoked by uid 107); 31 Mar 2015 01:21:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 21:21:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 21:21:02 -0400
Content-Disposition: inline
In-Reply-To: <20150331010854.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266496>

On Mon, Mar 30, 2015 at 09:08:54PM -0400, Jeff King wrote:

> Commit b27cfb0 (git-cherry-pick: Add keep-redundant-commits
> option, 2012-04-20), added the --keep-redundant-commits
> option, and switched the default behavior (without that
> option) to silently ignore empty commits. Later, the second
> half of that commit was reverted in ac2b0e8 (cherry-pick:
> regression fix for empty commits, 2012-05-29), but the
> documentation added for --keep-redundant-commits was never
> updated to match. Let's do so now.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-cherry-pick.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 1c03c79..1147c71 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -131,7 +131,8 @@ effect to your index in a row.
>  --keep-redundant-commits::
>  	If a commit being cherry picked duplicates a commit already in the
>  	current history, it will become empty.  By default these
> -	redundant commits are ignored.  This option overrides that behavior and
> +	redundant commits cause `cherry-pick` to stop so the user can
> +	examine the commit. This option overrides that behavior and
>  	creates an empty commit object.  Implies `--allow-empty`.

As an aside, I think what b27cfb0 was trying to do was make:

  git cherry-pick foo~5
  git cherry-pick foo~10..foo

work without stopping (by silently omitting foo~5 in the second
cherry-pick). But it regressed:

  git cherry-pick foo~5
  git cherry-pick foo~5

which should complain (there was nothing to pick). The fix for that in
ac2b0e8 restored the original behavior, and we always stop, even in the
middle of a sequence.

At least that's my guess from reading the nearby thread[1]. I think I
slightly prefer the "auto-skip" behavior, but I don't care enough to
work on it right now. It's been long enough since the original series
that I doubt new patches are forth-coming, so I decided on just doing
the documentation patch for now. :)

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/198319/focus=198926
