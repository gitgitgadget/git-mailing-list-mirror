From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Wed, 31 Aug 2005 13:17:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508311306540.23242@iabervon.org>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com> 
 <20050819194832.GA8562@fanta>  <1124572356.7512.21.camel@localhost.localdomain>
  <20050821094059.GA5453@fanta>  <Pine.LNX.4.63.0508221707520.23242@iabervon.org>
 <tnxvf1wd24m.fsf@arm.com>  <Pine.LNX.4.63.0508231304130.23242@iabervon.org>
 <1125438074.6961.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Veldeman <jan.veldeman@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 19:15:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAW9i-0007t0-I2
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 19:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVHaRNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 13:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVHaRNm
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 13:13:42 -0400
Received: from iabervon.org ([66.92.72.58]:26636 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964884AbVHaRNl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2005 13:13:41 -0400
Received: (qmail 6604 invoked by uid 1000); 31 Aug 2005 13:17:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Aug 2005 13:17:26 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1125438074.6961.20.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7981>

On Tue, 30 Aug 2005, Catalin Marinas wrote:

> Back from holiday. Thanks to all who replied to this thread.
> 
> On Tue, 2005-08-23 at 14:05 -0400, Daniel Barkalow wrote:
> > Having a useful diff isn't really a requirement for a parent; the diff in
> > the case of a merge is going to be the total of everything that happened
> > elsewhere. The point is to be able to reach some commits between which
> > there are interesting diffs.
> > 
> > This also depends on how exactly freeze is used; if you use it before
> > commiting a modification to the patch without rebasing, you get:
> > 
> > old-top -> new-top
> >       ^    ^
> >        \  /
> >       bottom
> > 
> > bottom to old-top is the old patch
> > bottom to new-top is the new patch
> > old-top to new-top is the change to the patch
> > 
> > Then you want to keep new-top as a parent for rebasings until one of these
> > is frozen. These links are not interesting to look at, but preserve the
> > path to the old-top:new-top change, which is interesting.
> 
> This was my initial StGIT implementation (up to version 0.3), only that
> there was no freeze command. Since I want an StGIT tree to be clean to
> the outside world, I wouldn't keep multiple parents for the visible top
> of a patch.
> 
> As I understand from Junio's and Linus' e-mails (on the 23rd of August),
> there might be problems with merging the HEAD of an StGIT-managed tree
> if the above method is accessible via HEAD.

Right, you'd want a separate head which is what you ask people to merge; 
the rest is only visible to people who are working on preparing the patch. 
But you could keep both sets of stuff (sharing tree objects but not 
commits).

> > Ignoring the links to the corresponding bottoms, the development therefore
> > looks like:
> > 
> > local1 -> local2 -> merge -> local3 -> merge
> > ^                   ^                  ^
> > mainline---->-->--------->------>-->----->
> > 
> > And this is how development is normally supposed to look. The trick is to
> > only include a minimal number of merges.
> 
> A merge occurs every time a patch is rebased. Anyway, having the bottoms
> in the graph (which is the main idea of StGIT) together with the old-top
> (or frozen state) parents make the graph pretty complicated.

It should be possible to drop merges such that there's only one between 
any pair of local changes. That is, if you rebase at the end of the line 
above, it would get as parents local3 and the new bottom, not the last 
merge and the new bottom.

The mainline changes only come in through the bottoms, so higher levels 
should look the same, but with the lower levels in the place of mainline.

	-Daniel
*This .sig left intentionally blank*
