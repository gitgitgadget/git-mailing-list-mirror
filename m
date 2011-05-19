From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Thu, 19 May 2011 15:42:52 -0400
Message-ID: <20110519194252.GA26144@sigill.intra.peff.net>
References: <20110517071232.GA19396@mrq1.org>
 <4DD390AF.9020705@drmicha.warpmail.net>
 <7vr57wc9ja.fsf@alter.siamese.dyndns.org>
 <201105191216.51709.trast@student.ethz.ch>
 <20110519110259.GA11507@sigill.intra.peff.net>
 <7v7h9m7arx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Harlan <pgit@pcharlan.com>,
	Hermann Gausterer <git-mailinglist@mrq1.org>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 21:43:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN97g-00039O-Vb
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 21:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934500Ab1ESTmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 15:42:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56676
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934363Ab1ESTmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 15:42:54 -0400
Received: (qmail 19445 invoked by uid 107); 19 May 2011 19:44:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 15:44:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 15:42:52 -0400
Content-Disposition: inline
In-Reply-To: <7v7h9m7arx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173998>

On Thu, May 19, 2011 at 12:25:38PM -0700, Junio C Hamano wrote:

> > Yeah. I personally find the concept of "5y" crazy; how do you know that
> > it is 5, and not 4 or 6, if you haven't yet seen them?
> 
> That one is surprisingly easy to answer. Before I decide to use
> "incremental", I've seen the diff at least once but more often number of
> times. I know where things are when I start my incremental sessions, and
> "5" (just an example) is something I would use when I think I know there
> are 8 or 9, i.e. a number that will surely undershoot but will get me
> to the end sooner. An alternative would be something akin to "/<pattern>"
> but that adds, instead of skips.

OK, I figured it was something like that. I still think it's a little
crazy, but hey, if it works for you, who am I to tell you you're wrong.

> > I think a much better safety valve is to store the user's worktree state
> > that we are about to destroy. Then when they accidentally erase
> > something, whether they realize it immediately, or even 5 minutes later,
> > it is recoverable. And in the common case where everything goes well,
> > they needn't be bothered at all.
> 
> Intereting.
> 
> Where does the data go (perhaps to "stash create", not "stash save"), and
> where would we plug that in ("checkout -p" codepath only)?

Yeah, definitely not "stash save", as we consider the contents of the
stash list to be under user control. Even "stash create" is a bit of an
overkill, as for "checkout -p" we don't care about the index state (er,
wait, do we? I guess for "checkout -p $some_commit", we will be munging
both work-tree and index).

Using "stash create", we could easily print a "by the way, here is your
previous state" message. But I think I prefer a stash-like reflog of
states. Then for the common case (you _didn't_ screw up), there is no
extra cruft printed. Plus, you can go back and recover 5 minutes later,
when you have closed that terminal window and only then realize you
messed something up.

So maybe there should be another stash-like ref at refs/worktree (or
refs/WORKTREE?). Then it would expire naturally according to the usual
reflog expiration rules. We could also write to it during "git reset
--hard", which suffers the same safety issue.

You could also stash the index state during "git reset --mixed" and "git
reset -p". That is not as big an issue, though, as you are only ever
throwing away the work of adding things to the index (for that matter,
one could do the same thing on "git add"). You may lose a minute or two
of sorting changes, but you will never lose actual data, as you can with
"checkout" or "checkout -p".

Obviously this safety valve incurs a performance penalty. Probably it
should be optional via config for each callsite. In general, I wouldn't
expect it to be too expensive, though. The biggest part will be the "git
add" of new content; but in theory, this is stuff you might have
committed anyway, so it's probably not that big.

You could put a similar safety valve in "git clean", but it may be much
more expensive, since it is by definition files that you have _not_
marked to be tracked by git. So they may be large binary cruft.

-Peff
