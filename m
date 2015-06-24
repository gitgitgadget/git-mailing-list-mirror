From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Wed, 24 Jun 2015 04:12:24 -0400
Message-ID: <20150624081224.GA4781@peff.net>
References: <20150623105042.GA10888@peff.net>
 <20150623105411.GB12518@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 10:12:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7fnO-0008Ts-Pb
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 10:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbbFXIMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 04:12:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:50871 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750988AbbFXIM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 04:12:27 -0400
Received: (qmail 4106 invoked by uid 102); 24 Jun 2015 08:12:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 03:12:27 -0500
Received: (qmail 25805 invoked by uid 107); 24 Jun 2015 08:12:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 04:12:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jun 2015 04:12:24 -0400
Content-Disposition: inline
In-Reply-To: <20150623105411.GB12518@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272539>

On Tue, Jun 23, 2015 at 06:54:11AM -0400, Jeff King wrote:

> diff --git a/builtin/prune.c b/builtin/prune.c
> index 0c73246..fc0c8e8 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -218,6 +218,9 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  		return 0;
>  	}
>  
> +	if (repository_format_precious_objects)
> +		die("cannot prune in a precious-objects repo");
> +

By the way, I originally wrote this patch on an older version of git,
and was surprised that `git gc` broke when I brought it forward. The
problem was that gc now runs `git prune --worktree`, and my die() was
affecting that case.

It really seems misplaced to me to make worktree-pruning part of
git-prune. I imagine the rationale was "well, we are pruning things, so
let's add an option to this command rather than make a new one". But I
do not think that follows our usual pattern with gc, which is:

  1. Individual areas of code handle their own cleanup. E.g., "reflog
     expire", "rerere gc".

  2. We tie them together with "git gc", not with "git prune".

So it seems weird that "git prune --worktree" is a fundamentally
different command than "git prune". I think by (1), it should be a
separate "git prune-worktree" (or better yet, "git worktree prune", as
the start of a command for manipulating the list of multiple-worktrees).

Not a _huge_ deal, but if we want to change it, it would be nice to do so
now before it is part of a release. Thoughts?

-Peff
