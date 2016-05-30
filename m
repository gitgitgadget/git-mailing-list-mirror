From: Jeff King <peff@peff.net>
Subject: Re: Fatal bug on revert with --author
Date: Mon, 30 May 2016 14:55:29 -0400
Message-ID: <20160530185529.GA18074@sigill.intra.peff.net>
References: <CAKYJjwgkH5gtQHsV_=4O0SGqb6GEXWC=rdFWO9Jv36dL-NaPcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andreas Lutro <anlutro@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 20:55:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7SLg-0001r3-Px
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161892AbcE3Szd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:55:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:46153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161876AbcE3Szc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:55:32 -0400
Received: (qmail 29174 invoked by uid 102); 30 May 2016 18:55:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 May 2016 14:55:32 -0400
Received: (qmail 16607 invoked by uid 107); 30 May 2016 18:55:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 May 2016 14:55:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2016 14:55:29 -0400
Content-Disposition: inline
In-Reply-To: <CAKYJjwgkH5gtQHsV_=4O0SGqb6GEXWC=rdFWO9Jv36dL-NaPcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295926>

On Mon, May 30, 2016 at 04:16:50PM +0200, Andreas Lutro wrote:

> So I learned today that --author is not a supported argument to git
> revert. It took me a long time to realize this, though, because the
> error I got was very cryptic:
> 
>   fatal: BUG: expected exactly one commit from walk
> 
> Here's a very simple reproducible case:
> https://gist.github.com/anlutro/67e0cec1a6a419e6d44131b0bc1deff6
> 
> I was recommended to send this report here by #git on irc.freenode.net.

Hmm. It _is_ a supported command-line argument, as you can pass
arbitrary revision options to revert. So:

  git revert --author peff HEAD

should revert all of my commits (whether that is _useful_, I am not
sure, but it is a consequence of the fact that revert simply passes its
arguments to the regular revision machinery).

But in your example, you pass the author "test", which matches nothing.
And so we end up with nothing to revert. But rather than saying so, we
fall into a backwards-compatibility code path:

        /*
         * If we were called as "git cherry-pick <commit>", just
         * cherry-pick/revert it, set CHERRY_PICK_HEAD /
         * REVERT_HEAD, and don't touch the sequencer state.
         * This means it is possible to cherry-pick in the middle
         * of a cherry-pick sequence.
         */
        if (opts->revs->cmdline.nr == 1 &&
            opts->revs->cmdline.rev->whence == REV_CMD_REV &&
            opts->revs->no_walk &&
            !opts->revs->cmdline.rev->flags) {
                struct commit *cmit;
                if (prepare_revision_walk(opts->revs))
                        die(_("revision walk setup failed"));
                cmit = get_revision(opts->revs);
                if (!cmit || get_revision(opts->revs))
                        die("BUG: expected exactly one commit from walk");
                return single_pick(cmit, opts);
        }

I think this conditional should not be triggering, because even though
we did receive a single argument, we _also_ got options which imply that
the user expected us to walk and find other commits.

-Peff
