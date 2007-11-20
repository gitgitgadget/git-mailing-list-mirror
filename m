From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Mon, 19 Nov 2007 19:03:35 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711191841430.12193@iabervon.org>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com> 
 <7v7ikfwhkj.fsf@gitster.siamese.dyndns.org> 
 <9e4733910711181042x123e99efjad38486654db17e2@mail.gmail.com> 
 <tnxbq9qyvom.fsf@pc1117.cambridge.arm.com> <9e4733910711191454i40d56fa2h9791415c092b9b9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 01:03:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuGaq-0003mN-4t
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 01:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbXKTADj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 19:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXKTADj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 19:03:39 -0500
Received: from iabervon.org ([66.92.72.58]:45073 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbXKTADi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 19:03:38 -0500
Received: (qmail 18741 invoked by uid 1000); 20 Nov 2007 00:03:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2007 00:03:35 -0000
In-Reply-To: <9e4733910711191454i40d56fa2h9791415c092b9b9c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65520>

On Mon, 19 Nov 2007, Jon Smirl wrote:

> On 11/19/07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > "Jon Smirl" <jonsmirl@gmail.com> wrote:
> > > On 11/18/07, Junio C Hamano <gitster@pobox.com> wrote:
> > >> "Jon Smirl" <jonsmirl@gmail.com> writes:
> > >>
> > >> > What's causing this? I'm using stgit on the master branch.
> > [...]
> > >> pushed "A" to the remote's 'master', then built this history:
> > >>
> > >>          o---o---A
> > >>         /
> > >>     ---o---o---o---o---A'
> > >>
> > >> by rewinding and rebuilding, and the tip of the branch now
> > >> points at A', which you tried to push to the remote.
> > >
> > > stgit must be doing this when I rebase. It pops all of it's patches,
> > > moves to head of linus/master and then rebases them.
> > [...]
> > > What is the right way to share repositories using stgit? I have a set
> > > of patches which I am working on for kernel inclusion. I have them
> > > applied as a stgit stack on top of linus/master. I need to share this
> > > patch stack with other developers. These developers may want to change
> > > one of my patches. Right now they are emailing me deltas and I apply
> > > them to the appropriate stgit patch. I have seventeen patches in my
> > > stack currently.
> >
> > StGIT is meant for keeping a clean history but with the big
> > disadvantage that this history is volatile.
> >
> > A solution is for the other developers to use StGIT or just git-rebase
> > so that they always have the same base (volatile) history and keep
> > their patches on top of yours.
> >
> > A 2nd approach is to use topic branches rather than StGIT patches but
> > you might lose some flexibility.
> >
> > Yet another approach (which I used) is to keep a public branch (can be
> > maintained by StGIT) where the history doesn't change and a devel
> > volatile branch. When I modify some patches and they are ready for
> > publishing, switch to the public branch and cherry-pick them (stg
> > pick) from the devel branch. Because this is done with a three-way
> > merge in StGIT, you will only get the new changes rather than the full
> > patch. You need to change the patch message (as it is that of the
> > original patch) to describe the specific changes and run 'stg refresh
> > && stg commit' to store it into the immutable history (well, there is
> > an 'uncommit' command as well if something goes wrong).
> 
> 
> Is a StGit where we can transparently share patches under version
> control in the works?
> 
> Something like this:
> clone repo with stgit
> normal stg commands work with no setup
> change a patch
> stg push the repo
> 
> I stg pull and the patch is updated.
> I also get rebased forward if the base repo has been updated

I've been thinking vaguely about support for essentially version 
controlling a quilt series, with the fundamental idea being that the 
history of the branch you're working on is a sequence of states of the 
series, with magic for having both the series specification and the final 
state in each commit.

Note that this is a different concept from stgit (and, I think, guilt), 
which uses the git engine as the magic behind the quilt-like operation, 
meaning that the history of the commit at the end of the series goes back 
through the patches in the series, not back through the changes to the 
series.

I've got a bunch of ideas on the subject, but I don't really have the 
quilt experience to know how to make this useful to people who want to do 
this kind of thing. My dream, from the perspective of a user of the 
results of somebody else's use of this feature, would be being able to 
bisect -mm to determine first that -mm stopped working when Andrew updated 
a particular tree, and then bisect within that tree (in each case 
generating the test tree with the complete -mm series, but with that 
tree's patch series being from the test point).

	-Daniel
*This .sig left intentionally blank*
