From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
 merge_recursive_generic()
Date: Wed, 13 Aug 2008 16:36:36 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808131559060.19665@iabervon.org>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <1218572040-23362-1-git-send-email-s-beyer@gmx.net> <alpine.LNX.1.00.0808122309460.19665@iabervon.org> <20080813172938.GC12871@leksak.fem-net> <alpine.LNX.1.00.0808131333230.19665@iabervon.org>
 <7v3al8ofjw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTN6b-0001cx-86
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYHMUgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbYHMUgo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:36:44 -0400
Received: from iabervon.org ([66.92.72.58]:41894 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbYHMUgn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:36:43 -0400
Received: (qmail 10537 invoked by uid 1000); 13 Aug 2008 20:36:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Aug 2008 20:36:36 -0000
In-Reply-To: <7v3al8ofjw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92266>

On Wed, 13 Aug 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> Puhh, I've not dug into merging stuff that deep, but for me it does not
> >> look that this can be done in a useful way, i.e. merge_working_tree()
> >> does not do a recursive merge.
> >
> > Ah, true. It's actually doing a single merge in the way that 
> > merge_recursive would do a single merge. I think it ought to be doing 
> > a recursive merge, but that's probably a change for later, anyway. (This 
> > is for -m, which essentially picks the uncommited changes versus the old 
> > branch, applied to the new branch uncommitted)
> 
> Why would you think it should be doing a recursive merge?  It shouldn't.
> 
> Think of builtin-merge-recursive.c::merge_trees() as a fancier version of
> 3-tree variant of "unpack_trees()", with -m and -u option.
> 
> When you want to perform an exact three-way merge (i.e. you have two
> states O and B, and you want to apply changes between O and B to your
> state A, and you _precisely_ know what O is) that's the interface you
> would want to use, not the recursive one.  The recursive behaviour is
> desirable only when you have A and B and need to infer where O should be,
> and/or there are multiple O's to deal with (i.e. running "git-merge B"
> when you are at A).

I understand that you know exactly what the change is, but I'm not 
convinced that you don't want to consider how O is related to A in 
determining who to apply that change to A. My naive impression was:

 - the difference between O and B is to change X to Y, and we can 
   determine this exactly
 - we need to find X' in A to change it to Y'
 - we can more accurately find X' in A if we find Z in the common 
   ancestors of O and A such that X in O corresponds to Z in the
   ancestors, and we get similar benefits in determining the right Y'

That is, we care about the common ancestor not only for finding the 
relevant change in the near side to apply, but also for finding how to 
apply it to the far side.

> In all the potential users of merge-recursive machinery, namely, "revert",
> "cherry-pick", "stash apply", "am -3", and "checkout -m", you know what
> single common tree to use for your three-way merge.  These operations,
> when done with direct C call into merge machinery, should NOT be using the
> "recursive" one.

I agree that they should all be using the same mechanism, but I'm not sure 
it shouldn't be recursive or take history into account.

And I'd certainly believe that just running our merge-recursive won't 
actually do anything clever with the rest of the history, and that 
merge_trees() is the most suitable method currently available (which is 
essentially why I ended up using it in checkout -m, not entirely 
realizing that I'd removed the "recursive" aspect in the process of 
skipping parts of merge_recursive that weren't relevant).

Maybe merge_trees should get the two sides as structs with a struct tree * 
and a char * branch name, and the struct could someday get optional struct 
commit *s for the lineage of the side if somebody comes up with a method 
for merging that makes use of the component changes.

	-Daniel
*This .sig left intentionally blank*
