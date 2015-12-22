From: Jeff King <peff@peff.net>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are
 conflicts.
Date: Tue, 22 Dec 2015 04:30:33 -0500
Message-ID: <20151222093032.GA5173@sigill.intra.peff.net>
References: <20151221142953.GA12764@acm.fritz.box>
 <1450772258.7937.9.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alan Mackenzie <acm@muc.de>, git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Dec 22 10:30:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBJHI-0006Xp-7D
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 10:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbbLVJai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 04:30:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:45177 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754406AbbLVJag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 04:30:36 -0500
Received: (qmail 22515 invoked by uid 102); 22 Dec 2015 09:30:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Dec 2015 03:30:36 -0600
Received: (qmail 28788 invoked by uid 107); 22 Dec 2015 09:30:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Dec 2015 04:30:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Dec 2015 04:30:33 -0500
Content-Disposition: inline
In-Reply-To: <1450772258.7937.9.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282839>

On Tue, Dec 22, 2015 at 09:17:38AM +0100, Dennis Kaarsemaker wrote:

> On ma, 2015-12-21 at 14:29 +0000, Alan Mackenzie wrote:
> > Hello, git project.
> > 
> > Last night, whilst clearing out a stale "stash stack", I did "git stash
> > pop".  There were conflicts in two files.
> > 
> > However, all the popped files became staged.  This doesn't normally happen.
> > It was intensely irritating, and required me to do "git reset HEAD" on
> > each of the files, none of which I wanted to commit.
> > 
> > I searched the git-stash man page for this scenario, but found nothing
> > about it.
> > 
> > Surely staging all the files is a bug?
> 
> That depends. A stash is two commits: one for all changes that were in
> the index when you ran 'git stash save' and one for all changes not yet
> in the index. When you pop the stash, these then get restored as staged
> resp. unstaged changes. So if your changes are now all staged, I'd
> wager that they were staged when you ran git stash save.

No, I think there's something else going on. Try this:
  
    git init repo &&
    cd repo &&
    
    echo base >one &&
    echo base >two &&
    git add . &&
    git commit -m base &&
    
    echo stash >one &&
    echo stash >two &&
    git stash &&
    
    echo "==> No conflicts, nothing staged"
    git stash apply &&
    
    git reset --hard &&
    echo changes >two &&
    git commit -am changes &&
    
    echo "==> Conflict stages non-conflicting file 'one'"
    ! git stash apply &&
    git status

It seems to be a side effect of merge-recursive to stage the results,
and in the no-conflict path we explicitly reset the index. For the
conflicting case, it's trickier, because we would want to retain the
unmerged entries.

So I agree it's kind of weird, but the conflicting case is inherently
going to touch the index, and you'd generally have to `git add` to mark
the resolutions (but if you really want to just touch the working tree,
you'd need to `git reset`).

-Peff
