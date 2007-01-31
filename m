From: Nicolas Pitre <nico@cam.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 13:59:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701311335150.3021@xanadu.home>
References: <87odognuhl.wl%cworth@cworth.org>
 <20070130231015.GB10075@coredump.intra.peff.net>
 <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net>
 <20070131032248.GA17504@coredump.intra.peff.net>
 <Pine.LNX.4.64.0701310932320.3021@xanadu.home>
 <20070131170752.GA19527@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 20:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCKgK-00030D-20
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 19:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933339AbXAaS7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 13:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbXAaS7k
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 13:59:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43952 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933339AbXAaS7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 13:59:39 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCQ00EUOY3DQVV0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 13:59:38 -0500 (EST)
In-reply-to: <20070131170752.GA19527@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38284>

On Wed, 31 Jan 2007, Jeff King wrote:

> On Wed, Jan 31, 2007 at 09:59:08AM -0500, Nicolas Pitre wrote:
> 
> > I disagree again.  Making commits on a detached head is not dangerous.
> > 
> > What is dangerous is moving away from the tip of that detached head 
> > without attaching it somewhere.  And that case is well covered already.
> 
> Sure, the dangerous thing is moving away. But my point is there are many
> steps leading up to that, and we can warn at any one. However, the
> warning is _most_ useful as close to the dangerous thing as possible
> (ideally, we would warn when doing the actual dangerous thing, but IIRC,
> there was some complexity with that).

The _only_ dangerous thing is moving away.  Warning at any step is far 
more annoying than warning (actually only notifying) only once when the 
detached head state is entered.

> IOW, here's a rough flow chart of states and user actions:
>          checkout non-branch          commit, etc
> (1) regular  ---------> (2) detached,  --------> (3) detached,
>          ^                  no commits                commits
>          |  checkout branch |  checkout old branch     /\
>           \-----------------<--------------------------  |
>                                                          |  checkout
>                                                          | new branch
>                                                          v
>                                                    (4) new regular branch
> 
> Hopefully my ASCII art skillz are coherent enough. The actual
> "dangerous" thing here is moving from 3 to 1. We can theoretically warn
> at any transition. Right now we warn moving from 1 to 2. But a large
> number of users are just going to go right back to 1, never even doing
> anything dangerous! For them, the warning is confusing.

Let's fix the warning then.  But it must stay just because it is 
important that the user know _why_ and _when_ the head became detached.  
Realizing that head is detached later is far more confusing if the user 
just don't know how that happened.

> I'm proposing warning between 2 and 3.

Given that the commit template already says that the head is detached is 
IMHO far enough given the actual "dangerousness" of the operation.

> I would also be happy with warning (and
> probably blocking without -f) moving from 3 to 1, which is the actual
> dangerous thing.

And that is already what is happening.

> However, I think putting a warning between 2 and 3 is
> reasonable, because the next step the user will make from 3 is either
> moving to 1 (dangerous) or to 4 (ok), and they must use the correct
> git-checkout invocation. So basically, it's our last chance (besides the
> actual git-checkout itself) to warn them.

No it is not.  The user cannot escape the detached head state (moving 
from 3 to 1) without -f or creating a new branch already.  Additional 
warning between (2) and (3) does nothing but add annoyance to the user 
experience.

> > Also the warning when moving to a detached head is useful to make the 
> > user aware of what just happened because there is really something 
> > special about such checkout.  It is not meant to frighten users and if 
> > it does so then maybe it should be reworked some more.  But IMHO it is 
> > important that the user be aware of this special state.
> 
> What is so special about it? My argument is that it is not really very
> special _until you make commits_. Are there other operations which we
> should be warning people about if they have a detached head?

It is a different state and the user must know why.  When doing a commit 
it is too late to say "oh btw your head was detached a while ago".

> > But making a warning at commit time is wrong. It is completely 
> > disconnected from the actual issue and I think it'd create more 
> > confusion because there is in fact nothing to worry about at the moment 
> > the commit is made.  The very fact that you think yourself that a 
> > warning should be displayed at commit time indicates to me that you 
> > might be a bit confused yourself and such warning if present at commit 
> > time wouldn't help clearing that confusion at all.
> 
> I think you are proving my point here. If you think warning at commit
> time is too early, then how is warning _before_ that (when we detach)
> not too early?

Did I say anything about it being too early?

I say that it is unnecessary and redundent, and that it would create 
more confusion than it clears.

> > In Carl's case suggesting -f is probably not a good idea.  Using -f _is_ 
> > dangerous and we better not get people into the habit of using -f 
> > without thinking.
> 
> Agreed.
> 
> > Let's focus on the real issue: the warning message when head gets 
> > detached.  This message is not meant to frighten users.  It is meant to 
> > make the user aware of a special state (pretty useful but special 
> > nevertheless) and give a suggestion about what to do if that state was 
> > entered by mistake.  So if that message scares users away then it is the 
> > message itself which is buggy not its presence.
> 
> Again, I don't understand why the state is special (aside from the
> possibility of losing commits).

It is special because it has an entry point and an exit point, unlike 
being on any branch where there is no such notion.  So it is important 
to know when/how you enters it and how you may leave it.  Intermediate 
operations don't have to be special with useless warnings.


Nicolas
