From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: unseeking?
Date: Sun, 24 Apr 2005 14:47:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504241418190.30848-100000@iabervon.org>
References: <20050424180116.GC11094@tumblerings.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 20:42:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPm4H-00023B-9X
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 20:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVDXSrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 14:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVDXSrr
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 14:47:47 -0400
Received: from iabervon.org ([66.92.72.58]:58884 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262367AbVDXSr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 14:47:27 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPm8g-0006Wh-00; Sun, 24 Apr 2005 14:47:30 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050424180116.GC11094@tumblerings.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, Zack Brown wrote:

> That works a little better for me, but neither really works. If I do
> 
> git fork currdir newdir
> 
> I get
> 
> cat: .git/HEAD: No such file or directory
> Invalid id: 
> grep: .git/remotes: No such file or directory
> /home/zbrown/git/git-pasky-0.6.2/gitfork.sh: line 41: .git/heads/mygitdir: No
> such file or directory
> cat: .git/HEAD: No such file or directory
> Invalid id: 
> error: no access to SHA1 file directory
> fatal: invalid cache
> error: no access to SHA1 file directory
> fatal: cache corrupted
> Branch mygitdir ready in mygitdir3 with head 

I think your "mygitdir" directory has lost its idea of what's in it, so
the fork doesn't know what should be there, either. If it's tracking a
remote repository, you should be able to do a "git pull" there to both
bring it up to date and fix this. Then things should work better.

> I'm sure this is all accurate information, but I'm still unclear about several
> points:
> 
> 1) when I fork directory A into directory B, is A at all different from B
> when the fork completes, and if so, how?

They should be the same, but now independant as far as commits into them.

> 2) Are A and B altered by the forking process? i.e., is this an event that is
> recorded in the repo, or is it just the equivalent of 'checking out' the repo?

The repo contains the latest commit on each side in .git/heads/<name>

> 3) What is the significance of a branch 'name'? Is this like a tag?

It's orthogonal to a tag; it's what stays the same when you do more
commits on something. E.g., linux-scsi or linux-stable would be branch
names. (Tags, on the other hand, stick where you put them.)

> 4) In normal work-flow, when would forks be created, as opposed to other ways
> of getting a tree?

I have a tree that I want to modify, but I want to keep the original, and
I may want to update the original from an upstream source (and then sync
my work with it). I start with the original:

  cd original
  git init URL
  git addremote remote-source URL
  git track remote-source

I make my own working directory:

  git fork my-changes ../my-changes
  cd ../my-changes

Then I do my changes, and commit whenever I feel like I've gotten
somewhere (or when I think I'm about to mess something up and might want
to undo changes). Periodically, I check on the mainline:

  cd ../original
  git pull

I also merge changes from the mainline:

  cd ../my-changes
  git merge remote-source

When I'm done, I make a patch for my work:

  cd ../my-changes
  git patch remote-source

I generally then fork the original again, split the patch, apply each
section in the new fork, committing after each one, generate patches for
each of these commits, and send those out. Then I discard my old branch
and continue from the new one. If, at some point, all of the changes I
want to keep have been put into the mainline, I discard all my branches
and fork again from the mainline.

(My personal style is to discard the history of how the changes got made
in favor of the history of how the changes got into the mainline, since I
don't really need to keep all of my debugged mistakes that nobody else
saw.)

	-Daniel
*This .sig left intentionally blank*

