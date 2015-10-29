From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] checkout: added two options to control progress
 output
Date: Thu, 29 Oct 2015 18:05:19 -0400
Message-ID: <20151029220519.GA466@sigill.intra.peff.net>
References: <1445698768-22614-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Edmundo Carmona <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 23:05:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrvK5-0002FD-Li
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 23:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757653AbbJ2WF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 18:05:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:50055 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757623AbbJ2WFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 18:05:23 -0400
Received: (qmail 20775 invoked by uid 102); 29 Oct 2015 22:05:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Oct 2015 17:05:22 -0500
Received: (qmail 16139 invoked by uid 107); 29 Oct 2015 22:05:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Oct 2015 18:05:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Oct 2015 18:05:19 -0400
Content-Disposition: inline
In-Reply-To: <1445698768-22614-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280460>

On Sat, Oct 24, 2015 at 08:59:28AM -0600, Edmundo Carmona wrote:

> From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> 
> checkout will refuse to print progress information if it's not connected
> to a TTY. These patches will add two options:

Not just checkout, but all of git's progress code. The usual rules are:

  - if the user told us --progress, show progress

  - if the user told us --no-progress, don't show progress

  - if neither is set, guess based on isatty(2)

So with that in mind...

> --progress-no-tty: enable printing progress info even if not using a TTY

This should just be "--progress", shouldn't it?

It looks like checkout does not understand --progress and --no-progress.
It does have "--quiet", but elsewhere we usually use that to mean "no
progress, but also no other informational messages". We should probably
make this consistent with other commands. See how builtin/clone.c does
this, for example. Note also that clone's "quiet" option is part of
OPT__VERBOSITY(), which provides both "-q" and "-v" to turn the
verbosity level up/down. We could switch checkout to use that, too, but
I do not think it buys us anything, as we have no "-v" output for
checkout yet.

> --progress-lf: print progress information using LFs instead of CRs

I notice this is part of your patch 1, but it really seems orthogonal to
checkout's --progress option. It should probably be a separate patch,
and it probably needs some justification in the commit message (i.e.,
explain not just _what_ you are doing in the patch, but _why_ it is
useful).

It also seems like this has nothing to do with checkout in particular.
Should it be triggered by an environment variable or by an option to the
main git binary? E.g.:

  git --progress-lf checkout ...

to affect the progress meter for all commands?

> Edmundo Carmona Antoranz (2):
>   checkout: progress on non-tty. progress with lf
>   checkout: adjust documentation to the two new options

I mentioned above that the two orthogonal features should each get their
own patches. I think you should also do the reverse with the
documentation: include it along with the implementation of the feature.
Sometimes we do documentation as a separate patch (especially if it is
large, or if the feature itself took many patches to complete). But for
a small feature, as a reviewer (and when looking back through history) I
usually find it simpler if the documentation is included in the same
commit.

>  Documentation/git-checkout.txt | 10 ++++++++++
>  builtin/checkout.c             | 12 ++++++++++--
>  progress.c                     |  8 +++++++-
>  progress.h                     |  1 +
>  unpack-trees.c                 |  3 +++
>  unpack-trees.h                 |  2 ++
>  6 files changed, 33 insertions(+), 3 deletions(-)

I didn't look too carefully at the patches themselves, as they would
need to be reworked substantially to follow the suggestions above. But I
didn't notice any style or patch-formatting problems, and you seem to
generally be touching the right areas for what you want to do.

-Peff
