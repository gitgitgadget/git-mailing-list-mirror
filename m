From: Alan Mackenzie <acm@muc.de>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are
	conflicts.
Date: Thu, 24 Dec 2015 09:20:38 +0000
Message-ID: <20151224092038.GA2397@acm.fritz.box>
References: <20151221142953.GA12764@acm.fritz.box>
	<1450772258.7937.9.camel@kaarsemaker.net>
	<20151222093032.GA5173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 24 10:18:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC22g-0002wn-T3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 10:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbbLXJSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 04:18:32 -0500
Received: from mail.muc.de ([193.149.48.3]:51192 "EHLO mail.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932878AbbLXJS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 04:18:26 -0500
Received: (qmail 8630 invoked by uid 3782); 24 Dec 2015 09:18:22 -0000
Received: from acm.muc.de (p548A5291.dip0.t-ipconnect.de [84.138.82.145]) by
	colin.muc.de (tmda-ofmipd) with ESMTP;
	Thu, 24 Dec 2015 10:18:20 +0100
Received: (qmail 2434 invoked by uid 1000); 24 Dec 2015 09:20:38 -0000
Content-Disposition: inline
In-Reply-To: <20151222093032.GA5173@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
X-Primary-Address: acm@muc.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282975>

Hello, Jeff.

On Tue, Dec 22, 2015 at 04:30:33AM -0500, Jeff King wrote:
> On Tue, Dec 22, 2015 at 09:17:38AM +0100, Dennis Kaarsemaker wrote:

> > On ma, 2015-12-21 at 14:29 +0000, Alan Mackenzie wrote:
> > > Hello, git project.

> > > Last night, whilst clearing out a stale "stash stack", I did "git stash
> > > pop".  There were conflicts in two files.

> > > However, all the popped files became staged.  This doesn't normally happen.
> > > It was intensely irritating, and required me to do "git reset HEAD" on
> > > each of the files, none of which I wanted to commit.

> > > I searched the git-stash man page for this scenario, but found nothing
> > > about it.

> > > Surely staging all the files is a bug?

> > That depends. A stash is two commits: one for all changes that were in
> > the index when you ran 'git stash save' and one for all changes not yet
> > in the index. When you pop the stash, these then get restored as staged
> > resp. unstaged changes. So if your changes are now all staged, I'd
> > wager that they were staged when you ran git stash save.

> No, I think there's something else going on. Try this:
  
>     git init repo &&
>     cd repo &&
    
>     echo base >one &&
>     echo base >two &&
>     git add . &&
>     git commit -m base &&
    
>     echo stash >one &&
>     echo stash >two &&
>     git stash &&
    
>     echo "==> No conflicts, nothing staged"
>     git stash apply &&
    
>     git reset --hard &&
>     echo changes >two &&
>     git commit -am changes &&
    
>     echo "==> Conflict stages non-conflicting file 'one'"
>     ! git stash apply &&
>     git status

Thanks for creating a reproducible test case for me!

> It seems to be a side effect of merge-recursive to stage the results,
> and in the no-conflict path we explicitly reset the index. For the
> conflicting case, it's trickier, because we would want to retain the
> unmerged entries.

> So I agree it's kind of weird, but the conflicting case is inherently
> going to touch the index, and you'd generally have to `git add` to mark
> the resolutions (but if you really want to just touch the working tree,
> you'd need to `git reset`).

>From the point of view of a user, this is suboptimal.  git stash is an
abstraction: the preservation of uncomitted changes for later.  Staging
previously unstaged changes with git stash pop severely damages this
abstraction.

Are there any prospects of this getting fixed?

> -Peff

-- 
Alan Mackenzie (Nuremberg, Germany).
