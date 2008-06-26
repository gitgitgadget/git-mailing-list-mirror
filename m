From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as
	errors.
Date: Thu, 26 Jun 2008 03:50:37 -0400
Message-ID: <20080626075036.GA25770@sigill.intra.peff.net>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org> <20080619133747.GA31209@sigill.intra.peff.net> <20080619135159.GA19560@artemis.madism.org> <20080619151110.GA31654@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 09:51:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBmGW-0006QI-Cf
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 09:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbYFZHuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 03:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYFZHuk
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 03:50:40 -0400
Received: from peff.net ([208.65.91.99]:3285 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbYFZHuj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 03:50:39 -0400
Received: (qmail 24768 invoked by uid 111); 26 Jun 2008 07:50:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 03:50:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 03:50:37 -0400
Content-Disposition: inline
In-Reply-To: <20080619151110.GA31654@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86409>

On Thu, Jun 19, 2008 at 11:11:10AM -0400, Jeff King wrote:

> >   Please please please do :)
> >   The exit 1 of git-push is really annoying me these days.
> 
> OK, I will try to take a look in the next few days.

I finally got a chance to look at this [distinguishing stale refs from
other non-ff refs]. I was originally planning on doing a multi-patch
series:

 1/4 distinguish visually between stale / non-ff refs
 2/4 config option to let stale refs not count towards exit code of 1
 3/4 disallow "push -f" without explicit refspec or option (like --all)
 4/4 config option not to show stale refs unless "-v" is given (which
     is now reasonably safe, since invisible refs won't get pushed when
     you just repeat your "git push" with a "-f")

But I didn't like how it was turning out. Specifically:

  - two config options doesn't really make sense. Either you care about
    stale refs, or you don't. If you do, you should see them and have
    them impact your exit code.

  - I thought 3/4 would introduce a generally useful safety valve. But I
    realized I really _like_ the current behavior. Most of the time I
    force a push, it is something like "git push", "oops, that is a
    non-ff, but I know it is OK", "git push -f". It makes sense to me
    that I can repeat my last command and simply say "OK, force this."
    But with such a safety valve, I have to realize the shortcut that
    "git push" was performing (i.e., "git push --matching"), and then
    explicitly retype it. Which is not hard mentally, but it makes the
    interface seem very clunky.

Instead of that, I am considering something more like this:

  - we always visually distinguish stale and other non-ff refs

  - if a config option is set, we treat stale refs as "up to date". That
    is, we don't show them (unless -v is set), and they don't affect the
    exit code. The option is unset by default, giving the same as
    current behavior.

  - If the config option is not set, then forcing works as before.

  - If the config option is set, then we _do not_ force stale refs, but
    only other non-ff. Meaning we are truly treating them like our "up
    to date" refs and saying "there is nothing of interest to push".

This leaves one open issue. If you have the "treat stale as up to date"
config option set, how do you force a strict rewind (if the occasion
comes up that in some instance, you do want to treat it differently)?

One solution is for the user to unset the config, do the forced push,
and then reset it. It makes some sense; the user has said, via the
config, that they consider stale refs uninteresting. So to actually
perform such a push, they need to "unsay" that temporarily.

Another solution would be an additional flag for forcing strict rewinds
(or even "-f -f", though I'm not sure that makes sense). This seems a
little hack-ish, since it would _only_ be used if this other config flag
is set.

Yet another solution would be to allow "-f" to force a strict rewind,
but only if the refspec is mentioned explicitly on the command line, and
not part of an automatic match. Reasonably DWIM, but I think it kills
the consistency we have now (that "--all" or "--matching" are really
just shorthands for spelling out all of the respective refspecs).

Does this seem like a good approach overall? Existing behavior should be
identical unless the config option is set, and with it set, I think it
should satisfy Pierre and posters from the original thread. If that is
sensible, which of the solutions for "no, I really want to force this
strict rewind" is the most palatable?

-Peff
