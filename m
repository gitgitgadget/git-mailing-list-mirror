From: Jeff King <peff@peff.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 12:07:52 -0500
Message-ID: <20070131170752.GA19527@coredump.intra.peff.net>
References: <87odognuhl.wl%cworth@cworth.org> <20070130231015.GB10075@coredump.intra.peff.net> <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net> <20070131032248.GA17504@coredump.intra.peff.net> <Pine.LNX.4.64.0701310932320.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 18:09:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIwS-0002WR-7n
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 18:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbXAaRH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 12:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbXAaRH5
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 12:07:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3278 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030289AbXAaRH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 12:07:56 -0500
Received: (qmail 11881 invoked from network); 31 Jan 2007 12:07:51 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 31 Jan 2007 12:07:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jan 2007 12:07:52 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701310932320.3021@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38279>

On Wed, Jan 31, 2007 at 09:59:08AM -0500, Nicolas Pitre wrote:

> I disagree again.  Making commits on a detached head is not dangerous.
> 
> What is dangerous is moving away from the tip of that detached head 
> without attaching it somewhere.  And that case is well covered already.

Sure, the dangerous thing is moving away. But my point is there are many
steps leading up to that, and we can warn at any one. However, the
warning is _most_ useful as close to the dangerous thing as possible
(ideally, we would warn when doing the actual dangerous thing, but IIRC,
there was some complexity with that).

IOW, here's a rough flow chart of states and user actions:
         checkout non-branch          commit, etc
(1) regular  ---------> (2) detached,  --------> (3) detached,
         ^                  no commits                commits
         |  checkout branch |  checkout old branch     /\
          \-----------------<--------------------------  |
                                                         |  checkout
                                                         | new branch
                                                         v
                                                   (4) new regular branch

Hopefully my ASCII art skillz are coherent enough. The actual
"dangerous" thing here is moving from 3 to 1. We can theoretically warn
at any transition. Right now we warn moving from 1 to 2. But a large
number of users are just going to go right back to 1, never even doing
anything dangerous! For them, the warning is confusing. I'm proposing
warning between 2 and 3. I would also be happy with warning (and
probably blocking without -f) moving from 3 to 1, which is the actual
dangerous thing. However, I think putting a warning between 2 and 3 is
reasonable, because the next step the user will make from 3 is either
moving to 1 (dangerous) or to 4 (ok), and they must use the correct
git-checkout invocation. So basically, it's our last chance (besides the
actual git-checkout itself) to warn them.

> Also the warning when moving to a detached head is useful to make the 
> user aware of what just happened because there is really something 
> special about such checkout.  It is not meant to frighten users and if 
> it does so then maybe it should be reworked some more.  But IMHO it is 
> important that the user be aware of this special state.

What is so special about it? My argument is that it is not really very
special _until you make commits_. Are there other operations which we
should be warning people about if they have a detached head?

> But making a warning at commit time is wrong. It is completely 
> disconnected from the actual issue and I think it'd create more 
> confusion because there is in fact nothing to worry about at the moment 
> the commit is made.  The very fact that you think yourself that a 
> warning should be displayed at commit time indicates to me that you 
> might be a bit confused yourself and such warning if present at commit 
> time wouldn't help clearing that confusion at all.

I think you are proving my point here. If you think warning at commit
time is too early, then how is warning _before_ that (when we detach)
not too early?

> In Carl's case suggesting -f is probably not a good idea.  Using -f _is_ 
> dangerous and we better not get people into the habit of using -f 
> without thinking.

Agreed.

> Let's focus on the real issue: the warning message when head gets 
> detached.  This message is not meant to frighten users.  It is meant to 
> make the user aware of a special state (pretty useful but special 
> nevertheless) and give a suggestion about what to do if that state was 
> entered by mistake.  So if that message scares users away then it is the 
> message itself which is buggy not its presence.

Again, I don't understand why the state is special (aside from the
possibility of losing commits).

-Peff
