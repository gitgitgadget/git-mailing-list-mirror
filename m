From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] git-add--interactive: manual hunk editing mode
Date: Mon, 23 Jun 2008 14:38:40 -0400
Message-ID: <20080623183840.GA28887@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806120855.26847.trast@student.ethz.ch> <20080612071311.GA32491@sigill.intra.peff.net> <200806131748.44867.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAqx1-0003mR-Kh
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbYFWSin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757489AbYFWSin
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:38:43 -0400
Received: from peff.net ([208.65.91.99]:2103 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756048AbYFWSim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 14:38:42 -0400
Received: (qmail 28250 invoked by uid 111); 23 Jun 2008 18:38:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 14:38:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 14:38:40 -0400
Content-Disposition: inline
In-Reply-To: <200806131748.44867.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85901>

On Fri, Jun 13, 2008 at 05:48:43PM +0200, Thomas Rast wrote:

> Adds a new option 'e' to the 'add -p' command loop that lets you edit
> the current hunk in your favourite editor.
> [...]
> Applying the changed hunk(s) relies on Johannes Schindelin's new
> --recount option for git-apply.

This version looks pretty good to me (though I do have a few comments
below), and now that we are in the new release cycle, I think it is time
to re-submit "for real".

The big question is what is happening with the recount work. Johannes,
are you planning on re-submitting those patches?

> > Right, but you may get false positives if a later conflicting hunk is
> > not staged. Though as you say, I think it is unlikely in either case.
> I'd rather reject early and offer to re-edit, than notice a problem
> much later, so I left it the way it was.

Yeah, thinking about it more, that is the sanest choice.

> I was tempted to reintroduce globbed unlinking of the temporary file
> as in v3 (that is, removing TMP* instead of just TMP).  In the absence
> of it, backup files made by the user's editor will remain in .git/.
> Eventually I didn't because it seems vi doesn't make backups anyway,
> and while emacs does, enabling that for GIT_EDITOR seems a user error.
> Besides, how do we know the backups match that pattern anyway.  Not
> sure though.

I would leave it; it seems like the editor's responsibility to handle
this. We don't know what patterns are used, or when it is safe to remove
such backups. And this is far from the only place where we invoke the
editor on a temporary file, so any solution should probably be applied
globally.

> +	my @newtext = grep { !/^#/ } <$fh>;
> [...]
> +	# Abort if nothing remains
> +	if (@newtext == 0) {
> +		return undef;
> +	}

Reading over this again, I wonder if it should be:

  # Abort if nothing remains
  if (!grep { /\S/ } @newtext) {
    return undef;
  }

That is, we can't eliminate blank lines on input, since they might be
meaningful to the diff. But if the user removes every non-comment line
_except_ a blank line or a line with only whitespace, we probably want
to abort, too.

-Peff
