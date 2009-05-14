From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Thu, 14 May 2009 23:41:20 +0200
Message-ID: <20090514214120.GR15420@raven.wolf.lan>
References: <20090504211423.GK15420@raven.wolf.lan> <20090506185224.GM15420@raven.wolf.lan> <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> <20090506225042.GN15420@raven.wolf.lan> <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> <20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan> <32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com> <20090513222243.GQ15420@raven.wolf.lan> <32541b130905132335t3cbd0e7wf29577ee15ba0bac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4iov-0008IL-HB
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 23:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbZENVuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 17:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbZENVuU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 17:50:20 -0400
Received: from quechua.inka.de ([193.197.184.2]:52249 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbZENVuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 17:50:17 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M4iok-0000uR-9h; Thu, 14 May 2009 23:50:18 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id E7ADD2CCF9; Thu, 14 May 2009 23:41:20 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905132335t3cbd0e7wf29577ee15ba0bac@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119227>

On Thu, May 14, 2009 at 02:35:18AM -0400, Avery Pennarun wrote:

> By far the sanest thing you could possibly do is to create a central
> "public" branch that contains all the common commits, then merge from
> that public branch to the site-specific branches, but never merge in
> the opposite direction.  In case you happen to make some changes on
> the site-specific branches that you want to share, you can just
> cherry-pick them; the resulting conflicts when merging back are likely
> to be fairly minor.  This would be entirely consistent with git's
> normal operations, and would be easy:
> 
>    git checkout public
>    git cherry-pick stuff   # as rarely as possible; do the work
> directly on public if you can
> 
>    git checkout svn-1
>    git merge --no-ff public
>    git svn dcommit
> 
>    git checkout svn-2
>    git merge --no-ff public
>    git svn dcommit
> 
> No criss-cross merges, no insanity, no question about whether it's correct.

Indeed, this looks pretty simple.  But AFAICS, this works only when
starting out with a virgin repository.  In my situation, public is
currently empty and have to be constructed from scratch by picking
from the privates.

So it seems I have to sync the privates in a first step and build the
public from that in a second step.

So here's my second plan:
1. instead of doing the cherry-picking in a single repository, it might
   be helpful to do it in separate repositories: one repository for each
   direction.  While there are still two remote svn repositories in each
   svn repository, there is no need for criss-cross anymore.  The flow
   of the data is in one direction and it seems (at least at first glance)
   I can use git-svn-rebase to get a linear history.
2. After the synchronization is done, I would merge the two repositories
   into a third one to create the public repository.  Since this will be
   a pure git environment, I hope that the problems that are caused svn's
   lack of merge support will vanish.
3. Once the public repository exists, create the privates based on that
   public.

Here's my first attempt for the first step:

  # setup a repository template for the synchronization and configure the
  # svn remotes
  mkdir -p svn-sync.templ
  (
    cd svn-sync.templ
    git svn init --stdlayout file:///svn/svn-1
    git config merge.stat true
    for remote in svn-1 svn-2; do
      git config svn-remote.$remote.url      file:///svn/$remote
      git config svn-remote.$remote.fetch    trunk:refs/remotes/$remote/trunk
      git config svn-remote.$remote.branches branches/*:refs/remotes/$remote/*
      git config svn-remote.$remote.tags     tags/*:refs/remotes/$remote/tags/*
      git svn fetch -R $remote
      git checkout -b $remote $remote/trunk
      git tag $remote-orig $remote
    done
    git gc
  )
  
  # now copy the template to create the repositories where the actual
  # synchronization will be done
  cp -a svn-sync.templ  to-svn-1
  cp -a svn-sync.templ  to-svn-2
  
  # move cherries from svn-1 to svn-2 in the to-svn-2 repository
  (
    cd to-svn-2
    git svn fetch svn-1
    git checkout svn-2
    [ pick cherries ]
    git svn dcommit
    git tag -f svn-1-lastmerge svn-1
  )
  
  # move cherries from svn-2 to svn-1 in the to-svn-1 repository
  (
    cd to-svn-1
    git svn fetch svn-2
    git checkout svn-1
    [ pick cherries ]
    git svn dcommit
    git tag -f svn-2-lastmerge svn-2
  )
  
  # time passes
  
  # Move new commits from svn-1 to svn-2
  (
    cd to-svn-2
    git checkout svn-1
    git svn rebase
    git checkout svn-2
    git svn rebase svn-1
    [ more cherries ]
    git svn dcommit
    git tag -f svn-1-lastmerge svn-1
  )
  
  # Move new commits from svn-2 to svn-1
  (
    cd to-svn-1
    git checkout svn-2
    git svn rebase
    git checkout svn-1
    git svn rebase svn-2
    [ more cherries ]
    git svn dcommit
    git tag -f svn-2-lastmerge svn-2
  )

At first glance, this seems to work.  But there's the drawback that I
have to keep track of what have been merged manually.  So there's
certainly room for improvement :)

> More as an academic exercise than anything, I did find a way that will
> let you do criss-cross merging of all changes on A and B.  I still
> don't *really* recommend you use it, because it's extremely error
> prone, and there are lots of places where you could get merge
> conflicts and then end up in trouble.  (The above simple method, in
> contrast, might get conflicts sometimes, but you can just fix them as
> you encounter them and be done with it.)
> 
> The script below demonstrates how to take branches remote-ab and
> remote-ac, and auto-pick their changes (as they happen) into a new
> (automatically managed) branch public.  Then it merges public back
> into each branch, while avoiding conflicts.  The magic itself happens
> in extract() and crossmerge().
> 
> If nothing else, this method makes the gitk output far more sane than
> the original method.  This is because it doesn't include the history
> of 'public' in the site-specific branches.  That was the fundamental
> flaw in the method I had identified originally.  You can trick that
> original method into working too, but it's stunningly complex.  This
> is much more sane, albeit still not really sane.

I will have to play a little bit with this script to get a better
understanding how it works.  But from the description, I got the
impression that it matches my (current) work flow pretty good:
Currently, initial changes are done in some private repository and
propagated to the other repositories from there.  The only exception
is that currently, there's no such thing as a "public" repository.

> P.S. Sorry for the mess.  I suppose I should have broken down and
> written (or asked for :)) a minimal test case earlier, as it quickly
> revealed the problem.

Oh, I have learned a lot in this thread.  And BTW: I _have_ tried to
write a minimal test case several times.  But I simply was not able to
reproduce the problems there.  The problems showed up only on the real
repositories.

Thank you very much Avery!
