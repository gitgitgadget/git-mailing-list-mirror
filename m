From: Jeff King <peff@peff.net>
Subject: Re: Pretty format specifier for commit count?
Date: Tue, 20 Jan 2015 16:49:53 -0500
Message-ID: <20150120214952.GA18778@peff.net>
References: <20150119012926.GA24004@thin>
 <54BD0C85.1070001@drmicha.warpmail.net>
 <20150120011724.GA1944@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:52:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDgjA-0002vE-9H
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 22:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbbATVwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 16:52:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:36559 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752375AbbATVty (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 16:49:54 -0500
Received: (qmail 13325 invoked by uid 102); 20 Jan 2015 21:49:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jan 2015 15:49:54 -0600
Received: (qmail 24270 invoked by uid 107); 20 Jan 2015 21:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jan 2015 16:50:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2015 16:49:53 -0500
Content-Disposition: inline
In-Reply-To: <20150120011724.GA1944@thin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262697>

On Mon, Jan 19, 2015 at 05:17:25PM -0800, Josh Triplett wrote:

> > Can you be a bit more specific about the type count that you are after?
> > "git describe" counts commits since the most recent tag (possibly within
> > a specific subset of all tags). Is that your desired format?
> 
> That might work, since the repository in question has no tags; I'd
> actually like "commits since root commit".

That's basically a generation number. But I'm not sure if that's really
what you want; in a non-linear history it's not unique (two children of
commit X are both X+1). It sounds like you really just want commits
counting up from the root, and with side branches to have their own
unique numbers. So something like:

       C
      /
  A--B--D

  A=1
  B=2
  C=3
  D=4

except the last two are assigned arbitrarily. You need some rules for
linearizing the commits.

Git's default output order is deterministic when walking backwards
through history from a specific set of starting points. We keep a queue
of commits to visit, sorted by timestamp, with ties in timestamps broken
by whichever was added "first" (so two parents of a merge get the first
parent added first, then the second). E.g. (and remember we're walking
backwards from the tip here, but you could do the backwards walk and
then reverse it, and start numbering from the other end):

       C--E
      /    \
  A--B--D---F

If we start at F, we might visit F, E, D, C, B, A. Or maybe C before D,
but only if its commit timestamp is newer (and if they tie, we
definitely visit D first, because it will have been queued first).

But that's not deterministic as you add more starting points (either new
ref tips, or just new merges we have to cross). For example, imagine
this:

         G--H
        /    \
       C--E   \
      /    \   \
  A--B--D---F---I

If we start at I, then we might visit H and G first, meaning we learn
about C much earlier than we otherwise would. Then we hit F, and get to
C from there. But now it it may be in a different position with respect
to D!

I suspect your problem statement may simply assume a linear history,
which makes this all much simpler. But we are not likely to add a
feature to git that will break badly once you have a non-linear history. :)

I think in the linear case that a generation number _would_ be correct,
and it is a useful concept by itself. So that may be the best thing to
add.

-Peff
