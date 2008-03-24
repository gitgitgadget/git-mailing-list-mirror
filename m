From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] git-init: set receive.guardCurrentBranch = true for
 non-bare repositories
Date: Mon, 24 Mar 2008 18:08:08 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803241714520.19665@iabervon.org>
References: <alpine.LSU.1.00.0803232142460.4353@racer.site> <alpine.LSU.1.00.0803232144070.4353@racer.site> <7v4pax3r6l.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241158301.4353@racer.site> <7v4pawvzgg.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803241807210.4353@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jduqc-0004ps-BU
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbYCXWIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYCXWIL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:08:11 -0400
Received: from iabervon.org ([66.92.72.58]:43105 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbYCXWIK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 18:08:10 -0400
Received: (qmail 13039 invoked by uid 1000); 24 Mar 2008 22:08:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Mar 2008 22:08:08 -0000
In-Reply-To: <alpine.LSU.1.00.0803241807210.4353@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78106>

On Mon, 24 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 24 Mar 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Sun, 23 Mar 2008, Junio C Hamano wrote:
> > > ...
> > >> As I described in my other message, I suspect that treating the 
> > >> current branch specially like this is a wrong approach.  The 
> > >> configuration might be a good idea, but shouldn't it prevent any 
> > >> local branch from getting updated?  Push into non-bare repository is 
> > >> simply a fetch run in reverse direction.
> > >
> > > That would break this work flow:
> > >
> > > 	# machine A
> > > 	$ git push B master:refs/heads/tmp
> > >
> > > 	# machine B
> > > 	$ git merge tmp
> > > 	$ git branch -d tmp
> > 
> > I am afraid that the above is irrelevant.
> > 
> > (1) You can push the temporary into anywhere outside refs/heads/ if that
> >     becomes the problem;
> 
> Okay, didn't think about that one.
> 
> > (2) Your change to forbid current branch already "breaks" another workflow
> >     (which I happen to use everyday) anyway:
> > 
> > 	# machine A (primary development repository)
> >         $ git push k.org ;# master->master, next->next, ...
> > 
> >         # machine B (build test repository)
> >         $ git reset --hard
> >         $ for b in master maint next pu
> >           do git checkout $b && make clean test || break
> > 	  done
> 
> It would not, because it is not activated by default.  Only newly 
> initialised repositories will have that config variable set.
> 
> > > Besides, there is a _vital_ difference between the current branch,...
> > 
> > [...]
> >
> > Now think.  What if one of these operations you do in the repository to 
> > advance the tip was to merge from one of _your_ local branches?  Yes, 
> > you end up merging something you did not expect to merge if you allowed 
> > a push from sideways to affect that local branch, only because the 
> > branch happened to be un-checked-out and you implemented this protection 
> > to forbid only to current branch.  Allowing a push from sideways to any 
> > local branch destabilizes your work environment, not just the current 
> > one.
> 
> Okay, I am starting to see the light.
> 
> How about
> 
> 	receive.localBranches = (refuse | allow)
> 
> with a default "allow"?  Then we could add more rope later with the 
> "update" option, which would run "git read-tree -u -m HEAD" if the current 
> branch is updated, and simply allow all other branches being updated.

The use cases I've seen for pushing into a non-bare repository seem to be 
cases in which "refs/heads/" isn't really local; it's only updated by push 
from elsewhere, and it's named "refs/heads/" because that's where public 
branches are served from. This suggests we could have:

	core.noLocalBranches: true

with the implications:

 - it's definitely okay to push to refs/heads/
 - HEAD is always detached.

That seems to me to accurately describe a repository used to hold branches 
for public consumption and where there's a work tree for testing and 
building, rather than development. (I.e., work tree operations only read 
the repository.)

	-Daniel
*This .sig left intentionally blank*
