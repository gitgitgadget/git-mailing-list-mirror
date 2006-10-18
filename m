From: Jan Hudec <bulb@ucw.cz>
Subject: Alternate revno proposal (Was: Re: VCS comparison table)
Date: Wed, 18 Oct 2006 23:46:23 +0200
Message-ID: <20061018214623.GA32725@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain> <Pine.LNX.4.64.0610170921540.3962@g5.osdl.org> <1161124078.9020.88.camel@localhost.localdomain> <20061017191838.1c36499b.seanlkml@sympatico.ca> <20061017233305.GG20017@pasky.or.cz> <1161149200.3423.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:46:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJF9-00034d-JB
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423025AbWJRVqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbWJRVqX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:46:23 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:28571 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1423025AbWJRVqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:46:21 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 8C2964E27; Wed, 18 Oct 2006 23:46:23 +0200 (CEST)
To: Robert Collins <robertc@robertcollins.net>
Content-Disposition: inline
In-Reply-To: <1161149200.3423.34.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29278>

On Wed, Oct 18, 2006 at 03:26:40PM +1000, Robert Collins wrote:
> revnos visibly change as your work is merged into the mainline - we've
> been doing this for years without trouble: ones own commits to a branch
> get '3', '4', '5' etc as revnos, and when they are merged to the
> mainline they used to stop having revnos at all, but now they will be
> given this dotted decimal revno. If you pull from the mainline after the
> merge, you see the new numbers, and when you look at mainline you can
> see the difference. So while I agree that the surprise the user gets is
> inversely related to the frequency with which they see the behaviour, I
> think our users see it a lot, so are not surprised much.
> 
> FWIW, we're not optimising for mostly straight histories as I understand
> such things : our own history has 3 commits on branches to every one on
> the mainline.

Reading this thread I came to think, that the revnos should be assigned
to _all_ revisions _available_, in order of when they entered the
repository (there are some possible variations I will mention below)

 - Such revnos would be purely local, but:
   - Current revnos are not guaranteed to be the same in different
     branches either.
   - They could be done so that mirror has the same revnos as the
     master.
 - They would be easier to use than the dotted ones. What (at least as
   far as I understand) makes revnos easier to use than revids is, that
   you can remember few of them for short time while composing some
   operation. Ie. look up 2 or 3 revisions in the log and than do some
   command on them. And a 4 to 5-digit number like 10532 is easier to
   remember than something like 3250.2.45.86.
 - Their ordering would be an (arbitrary) superset of the partial
   ordering by descendance, ie. if revision A is ancestor of B, it would
   always have lower revno.
   - The intuition that lower revno means older revision would be always
     valid for related revisions and approximately valid for unrelated
     ones.
 - They would be *localy stable*. That is once assigned the revno would
   always mean the same revision in given branch (as determined by
   location, not tip).
     - This is more than the current scheme can give, since now pull can
       renumber revisions.
 - They wouldn't make any branch special, so the objections Linus raised
   does not apply.
 - They would be the same as subversion and svk, and IIRC mercurial as
   well, use, so:
   - They would already be familiar to users comming from those systems.
   - They are known to be useful that way. In fact for svk it's the only
     way to refer to revisions and seem to work satisfactorily (though
     note that svk is not really suitable to ad-hoc topologies).

Now I said there are two options how to assign them. These are:

 - Repository-wide: Number would be assigned to each revision entering
   the repository, even when it is not in ancestry of any branch (ie.
   if one starts a merge, but than reverts it).
   - Advantages:
     - Simpler to implement (just log every written-out revision).
     - All branches in the same repository use the same revision
       numbers, so if you keep branches in a shared repo, it makes
       easier to look up one revision in log of one branch, other in log
       of other branch and run diff on them.
   - Disadvantages:
     - Mirror only has the same revnos if both master and the mirror are
       stand-alone branches.
 - Branch-wide: Nuber would be assigned to each revision that becomes
   ancestor of the current head revision.
   - Advantages:
     - Mirror (always updated by push from the same source) always have
       the same revision numbers.
     - The revno assignment list could be reused for refering to state
       at particular point in time (in fact, it would be exactly the
       same thing as git reflog).
     - Bound branches could be forced to have the same revnos.
   - Disadvantages:
     - More complex to implement.
     - More work at runtime and more space needed in a shared
       repository, since each branch has it's own mapping.

Both ways, it would be implemented the way revision-history currently
is, just it would list all revisions, not just the path along the
leftmost parent.

Comments?

(Should I put it on the wiki?)

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
