From: Daniel Barkalow <barkalow@iabervon.org>
Subject: RE: branch management
Date: Wed, 10 Jun 2009 15:14:20 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906101425420.2147@iabervon.org>
References: <7vfxe9udln.fsf@alter.siamese.dyndns.org> <4A2E0C88.70805@gmail.com> <20090609080612.GG9993@laphroaig.corp> <7viqj5nzgz.fsf@alter.siamese.dyndns.org> <20090609172302.GH9993@laphroaig.corp> <08614AC584A6ED42BD836DE9286376E12A211FA9CA@spswchi6mail1.peak6.net>
 <20090609195018.GA17848@blimp.localdomain> <08614AC584A6ED42BD836DE9286376E12A211FA9D0@spswchi6mail1.peak6.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Alex Riesen' <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Harry Duin <hduin@optionshouse.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:14:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1METFp-0002CJ-RC
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 21:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759759AbZFJTOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 15:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755402AbZFJTOY
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 15:14:24 -0400
Received: from iabervon.org ([66.92.72.58]:50224 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759337AbZFJTOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 15:14:23 -0400
Received: (qmail 8092 invoked by uid 1000); 10 Jun 2009 19:14:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jun 2009 19:14:20 -0000
In-Reply-To: <08614AC584A6ED42BD836DE9286376E12A211FA9D0@spswchi6mail1.peak6.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121294>

On Wed, 10 Jun 2009, Harry Duin wrote:

> Yes, I am aware that branching is different in git than what I have used 
> so far with SVN. But apart from the implementation, I have some 
> information that I want to gather about work done on a branch. Here are 
> a few questions/scenarios that I want to make sure we can handle. 
> Remember that our branches are mapped one to one to a Jira ticket. 

With respect to the branches that other people see, work in git isn't done 
"on" a branch, but rather "for" a branch (or more than one branch); it's 
most literally done "on" a branch on somebody's workstation that doesn't 
matter to anybody else, and it may be borrowed from some other developer 
who happens to have done something relevant but not gotten it into 
production yet. This actually should match your model much better than 
SVN. I'd say you should have a git repository associated with Jira, where
you've got a branch for each ticket. This repository gets maintained along 
with your ticket database, since it's really not about the history of work 
on the product but the disposition of bugs in the bug tracker.

> 1. show all code changes performed on a branch (for code review)

Generally, you want "git log master..branch", but note that this only 
works for code review, not after the fact, because that branch becomes 
part of master when it gets integrated. If you're looking for "the new 
code that goes to this ticket", this kind of makes sense, because when the 
ticket is done, the code isn't new any more.

Also, if you've got a cluster of related tickets, some code may be done 
that goes towards all of them, and therefore appears new the first time 
any of them is code reviewed, but becomes part of master before the last 
ticket is reviewed; so the results here may change (with stuff becoming no 
longer worth reviewing) after the code is complete but before review is 
complete.

You may also want to have a branch for "master relative to this ticket", 
which is master as of the point where the problem was still there (but 
which includes all of the changes that the developer merged in from other 
people that aren't part of the work for the ticket). Then you can do "git 
log base-100..ticket-100" to see the work that contributes to the ticket 
being resolved that didn't get into master for any other ticket. (That is 
to say, tickets generally assume that the rest of the product exists and 
works well enough to get to the point of the particular ticket but not to 
resolve the ticket; in order to maintain in the future a record of what 
this reference state was, you need another branch for that, because the 
future of your product has the ticket resolved and no work at all needed 
for it).

> 2. show list of files/directories touched by a branch (useful when 
> looking for past fixes, but are unsure where the fix was done) 

"git log --stat ticket-branch" will probably answer your question pretty 
quickly (maybe requiring looking through several commits, though). If 
you've got a reference branch from above, you can use "git log --stat 
base-branch..ticket-branch".

Of course, there's the conceptual issue that maybe somebody else, working 
on something different, will have done some work that is useful and turns 
out to be critical to the eventual resolution of the ticket. And it's also 
likely that other stuff was done that's totally irrelevant. And the 
difference is not captured electronically at all, but is entirely a matter 
of whether the developer decided to merge master back into their branch 
with the goal of getting that particular change or some other change that 
went gold around the same time.

So it's probably best to do "git log --stat ticket-branch" and keep 
looking through the results until you find what you're looking for, no 
matter how it got there.

> So far I have not found the exact syntax to get this information, but am 
> convinced that git can provide it! 

Git can provide all sorts of stuff, but it's also able to provide lots of 
information that SVN can't provide, and can't necessarily limit itself to 
telling you things that SVN would be able to capture. So it tells you many 
things, starting from the most likely relevant and going down to very 
unlikely (but still vaguely possible).

	-Daniel
*This .sig left intentionally blank*
