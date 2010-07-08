From: tytso@mit.edu
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 8 Jul 2010 09:54:42 -0400
Message-ID: <20100708135442.GA7549@thunk.org>
References: <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705141012.GA25518@thunk.org>
 <20100706115826.GA15413@sigill.intra.peff.net>
 <1278430303.32094.15.camel@wpalmer.simply-domain>
 <20100706165336.GJ25518@thunk.org>
 <20100708112802.GA2294@sigill.intra.peff.net>
 <1278595295.2668.10.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 15:54:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWrYy-00021Y-KI
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 15:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893Ab0GHNyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 09:54:49 -0400
Received: from thunk.org ([69.25.196.29]:50111 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757859Ab0GHNys (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 09:54:48 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OWrYp-0001jg-Ba; Thu, 08 Jul 2010 09:54:43 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OWrYo-000213-JF; Thu, 08 Jul 2010 09:54:42 -0400
Content-Disposition: inline
In-Reply-To: <1278595295.2668.10.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150575>

On Thu, Jul 08, 2010 at 02:21:35PM +0100, Will Palmer wrote:
> I think these two go hand-in-hand, and would resolve most of my issues
> with it. Auto-tune, starting pessimistically, but then using something
> more-optimized after something like gc has detected that it's okay. On
> pull from an older repository (which I see as happening very frequently,
> I add remotes much more often than I do a straight "clone"), a warning
> and an auto-tune to something which would account for the newly-fetched
> bad data.

Well, keep in mind that we've been using a one-day "maximum clock skew
or you start getting incorrect results" for quite a while.  We just
haven't necessarily publicized this fact or added enforcement to "git
commit" and git-receive-pack.  And I've been introducing clock skews
of about 3 months (roughly equal to the time between Linux stable
releases) into the Linux kernel repository for some 1-2 years (because
I just didn't know about the clock skew dependency and there was no
enforcement of the same), and the number of times people have noticed,
or at least complained, has been relatively small.  So like it or not,
the default of "one day clock skew or you get incorrect results" is
the status quo.

Your idea of being utterly pessimistic until the next "git gc" is
interesting, since it doesn't slow down the "git clone step".
Unfortunately, it also means that commands like "git name-rev" will be
several hundred times slower than they currently are (which probably
makes them unusable) until the first "git gc" --- this is the fact
that we've been depending on the clock skew being less than one day
for quite some time already; again, it _is_ the status quo.

And, "git gc" takes quite a bit longer than scanning for the maximum
skew after doing a "git clone".  Given that "git clone" generally
takes a good long time anyway, adding 1-3 seconds after a clone seems
to be the better way to go.  I think the biggest issue with it is the
complexity concern which Jeff has raised.

Given that, it would seem to me that (a) auto-tuning when cloning, (b)
defaulting to one-day and then auto-tuning on "git gc", or (c)
defaulting to one-day and not auto-tuning at all (the status quo) seem
to be the three most reasonable, listed in order of my preference.

As far as enforcement is concerned, we have choices of (a) add
warnings, which later become hard errors if the skew is greater than
some configurable window, (b) scan for skews during commits and
receive-packs, and update the auto-tune based on the skews found, or
(c) do nothing (the status quo).  (b) is the most user friendly, but
it adds more complexity, which is why I think (a) edges it out as a
better choice, but fortunately, I'm not the one who's paid the big
bucks to make these sorts of decisions.  :-)

> My only other objection is more wishy-washy and/or lazy: currently a
> "commit" doesn't need to know anything at all about what it references
> in order to be considered a valid object, but saying "the time of commit
> needs to be equal to or greater than the parent commit" means that a
> tool.. and by "tool" I mean "wretched abuse of cat-file and sed", which
> is sometimes just faster to throw-together than filter-branch ..needs to
> be more aware of what it's doing. Yes, it's a horrible abuse, but I was
> always under the impression that low-level abuse of the system is
> something which git supports, by virtue of having such a simple model.

I don't know that it's that much more difficult.  See the patch I
proposed for "guilt"; it was a ten line patch, and if you were willing
to be even more "quick and wretched", I could have made it a 3 or 4
line patch.

						- Ted
