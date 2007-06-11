From: "Alex R.M. Turner" <aturner@plexq.com>
Subject: Re: Problem with a push
Date: Mon, 11 Jun 2007 18:35:24 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0706111832070.4830@www.mintpixels.com>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
 <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
Reply-To: plexq@plexq.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: plexq@plexq.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 01:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxtQ8-0002m9-0j
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 01:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbXFKXf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 19:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbXFKXf0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 19:35:26 -0400
Received: from www.mintpixels.com ([72.51.39.73]:33194 "EHLO www.plexq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbXFKXfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 19:35:25 -0400
Received: by www.plexq.com (Postfix, from userid 500)
	id C484D7FC115; Mon, 11 Jun 2007 18:35:24 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by www.plexq.com (Postfix) with ESMTP id BE8BA7F0AC0;
	Mon, 11 Jun 2007 18:35:24 -0500 (CDT)
X-X-Sender: aturner@www.mintpixels.com
In-Reply-To: <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49900>

On Mon, 11 Jun 2007, Linus Torvalds wrote:

> 
> 
> On Mon, 11 Jun 2007, Alex R.M. Turner wrote:
> > 
> > I get the following error when pushing after a merge:
> > 
> > updating 'refs/heads/master'
> >   from c18f9e4350c26e6b45d0a282ff32991784becbdd
> >   to   39b7d927720c9f2810e0af5311975119c0d7c7bd
> > updating 'refs/remotes/origin/HEAD'
> >   from 1e631edb3078ec3a4d1fa598c8f410f6a61659b0
> >   to   c18f9e4350c26e6b45d0a282ff32991784becbdd
> > updating 'refs/remotes/origin/master'
> >   from 1e631edb3078ec3a4d1fa598c8f410f6a61659b0
> >   to   c18f9e4350c26e6b45d0a282ff32991784becbdd
> 
> Ok, pushing out remote branches is a bit odd in the first place. As in 
> "you probably shouldn't do that". The "remote" branches are really local 
> to each repo, and updating them by pushing is really quite suspect.
> 
> So the regular "master" branch pushed out fine:
> 
> > refs/heads/master: c18f9e4350c26e6b45d0a282ff32991784becbdd -> 39b7d927720c9f2810e0af5311975119c0d7c7bd
> 
> and that part is all ok.
> 
> However, I think the problem is this:
> 
> > refs/remotes/origin/HEAD: 1e631edb3078ec3a4d1fa598c8f410f6a61659b0 ->  c18f9e4350c26e6b45d0a282ff32991784becbdd
> 
> You updated the HEAD file, but that actually is a _symbolic_ ref, which 
> normally points to refs/removes/origin/HEAD, and that in turn explains the 
> other errors:
> 
> > ng refs/remotes/origin/master failed to lock
> > error: Ref refs/remotes/origin/master is at c18f9e4350c26e6b45d0a282ff32991784becbdd but expected 1e631edb3078ec3a4d1fa598c8f410f6a61659b0
> > error: failed to lock refs/remotes/origin/master
> > error: failed to push to 'ssh://aturner@svn.mintpixels.com/data/git/mls'
> 
> What happened is that the "remotes/origin/master" branch already got 
> updated when you updated HEAD, so now git is complaining that you are 
> trying to update it again, but it no longer has the same value that it had 
> originally (since you changed it).
> 
> > but when I try it again, it just says Everything up-to-date.
> 
> Right. Because the HEAD update really already did all the changes (to 
> _both_ remotes/origin/HEAD _and_ remotes/origin/master, since it was a 
> symref), so next time around there is nothing to push, and you won't see 
> this issue any more.
> 
> So I don't think there was anything reall bad going on, except for the 
> fact that you really shouldn't try to push out remote branches.
> 
> What was the command line?  In particular, was this a "git push --all" or 
> something? I think we should make sure that we do *not* push remotes by 
> default (and if you really *really* want to push remotes, you'd have to 
> specify them explicitly).
> 
> 			Linus
> 
Cool - that totally makes sense, HEAD is a link to master. so updating 
HEAD failed because it was already up to date.  The command was simply:

git push

This repo was cloned from one on another server (the server I use to 
backup everything) with a git clone command:

git clone ssh://aturner@svn.mintpixels.com/data/git/mls

.git/config looks like this:
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = ssh://aturner@svn.mintpixels.com/data/git/mls
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
[user]
        email = alex@mintpixels.com
        name = Alex R.M. Turner


git branch -a shows:
* master
  origin/HEAD
  origin/master

Based on all this, what is the correct way to update my core repo on my 
server? (I'm sorry - I'm pretty new to git, so I haven't quite cottoned on 
to some aspects yet).

Alex
