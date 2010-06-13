From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Sun, 13 Jun 2010 19:59:43 +0200
Message-ID: <201006131959.43356.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006121212.50545.johan@herland.net> <20100612120620.GA13910@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jun 13 19:59:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONrTM-0005ta-Sk
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 19:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab0FMR7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 13:59:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52568 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576Ab0FMR7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 13:59:46 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3Y00L93SNKY400@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 13 Jun 2010 19:59:44 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 3C5181EA5528_C151C90B	for <git@vger.kernel.org>; Sun,
 13 Jun 2010 17:59:44 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C3F8A1EA3F66_C151C8FF	for <git@vger.kernel.org>; Sun,
 13 Jun 2010 17:59:43 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3Y00IKISNJ8030@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 13 Jun 2010 19:59:43 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <20100612120620.GA13910@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149056>

On Saturday 12 June 2010, Heiko Voigt wrote:
> On Sat, Jun 12, 2010 at 12:12:50PM +0200, Johan Herland wrote:
> > On Friday 11 June 2010, Heiko Voigt wrote:
> > > The following patch series is a work in progress. The idea is
> > > whenever you need to merge two SHA1's of a submodule we search for a
> > > ref in the submodule which already contains both. If one such ref
> > > exists the resulting SHA1 is the one pointed at by that ref.
> > 
> > I appreciate the effort to improve submodule handling, but I'm not sure
> > I like this approach. Even though you try to apply it as
> > conservatively as possible, it still smells a little like trying to
> > make Git too clever for its own good.
> > 
> > E.g. say we have the following commit history in the submodule:
> >   A---B---C---D  <-- master
> > 
> > Now, say that your merge conflict comes from one branch updating the
> > submodule from B to C, while the other branch reverts the submodule
> > from B to A. In your proposed scheme, Git would auto-resolve the
> > conflict to D.
> 
> You are right. I did forget to mention this in my topic letter: Both
> changes need to point forward. This exact case is also tested in the
> testcases and results in a merge conflict which needs to be resolved by
> hand.

Still doesn't solve one of the cases I gave in the last email: Say one 
branch updates the submodule from A to B, and the other updates from A to C. 
Your proposal resolves the merge by fast-forwarding to D, which seems 
irresponsible, since we have no concept of how well D is tested. Maybe it 
introduces another showstopper bug, and that is why neither branch has 
upgraded to it yet?

A better solution would be, to put it generally: Given a submodule being 
part of a superproject conflict, if one of the candidate submodule SHA1s is 
is a descendant of _all_ the other submodule SHA1 candidates, then choose 
that SHA1 as the proposed resolution (but please leave the index entry 
"unmerged", so that the resolution must be confirmed by the user).

This removes all the "stable" branch magic from your patch. All you need to 
look at are the candidate SHA1s and their relationship in the commit graph. 
No refs involved.

In the A->B vs. A->C case above, we would see that C is a descendant of B, 
and we would therefore choose C as a suggested conflict resolution, which 
IMHO is a much better choice than D.

I still don't want to add a lot of auto-resolving cleverness to Git, as it 
inevitably _will_ choose incorrectly sometimes, and in those situations it 
will be much more confusing than if it didn't choose at all.

> > This whole idea is somewhat similar to branch-tracking submodules
> > (recently discussed in another thread), except that it only applies on
> > _merge_ in the superproject, and you don't get to choose _which_
> > branch it's tracking. That's _way_ too arbitrary for my tastes.
> 
> The difference to branch-tracking submodules is, if I understand it
> correctly, that with a merge you get an explicit SHA1 which is recorded.
> Whereras with branch-tracking you never know on which revision on the
> tracked branch the submodule was.

Technically you may be right, but my point is that in your original proposal 
I don't get to _choose_ which submodule SHA1 is explicitly recorded for the 
merge resolution, but instead your patch chooses whatever SHA1 happens to be 
at the tip of some branch considered "stable". Although technically 
different, this is similar in _spirit_ to what branch-tracking submodules is 
about.

> Thats why I only want to search through stable branches further down. I
> mean stable in the git sense that they never get rewound and of course
> should contain the most stable part of development. To ease the
> configuration we would default to master which we could assume as
> stable. But if we want to be on the safe side we could also say that
> automatic submodule merging only works when the user has configured some
> stable branches.

Ok, so you can configure exactly which branch(es) you consider stable. I'd 
still much rather prefer the approach I outlined above, which does away with 
all the "stable" branch magic, and only considers the commit ancestry 
directly.


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
