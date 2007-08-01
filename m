From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git clone error
Date: Wed, 1 Aug 2007 18:17:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011802020.14781@racer.site>
References: <C2D5F3B2.2B00%denbuen@sandia.gov>
 <alpine.LFD.0.999.0708010846360.3582@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708010929070.3582@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <denbuen@sandia.gov>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:18:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHpx-0003HD-6h
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 19:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbXHARSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 13:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbXHARSM
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 13:18:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:45832 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754294AbXHARSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 13:18:11 -0400
Received: (qmail invoked by alias); 01 Aug 2007 17:18:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 01 Aug 2007 19:18:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GrqIbb+BGVrqJUeBj7uBjxvivRsx0C4J1/W8gKj
	19eybCX2t4w/0A
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0708010929070.3582@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54457>

Hi,

On Wed, 1 Aug 2007, Linus Torvalds wrote:

> On Wed, 1 Aug 2007, Linus Torvalds wrote:
> > 
> > > If I just recreate a version I'm happy with, can I add that to the repo and
> > > go from there?
> > 
> > Well, it's not so much a version _you_ are happy with: you'd have to 
> > be able to re-create the exact old version (with the exact same SHA1), 
> > in order for git to be happy.
> 
> Btw, if you really cannot re-generate it, you'd basically need to create 
> a whole new git archive without that blob (or basically with that blob 
> replaced by another version).
> 
> We don't have wonderfully good support for that, because, quite frankly, 
> we've not had this happen before. I think every time before, people have 
> had the blob in some other copy of their git archive.
> 
> But the thing to use is "git filter-branch", which can take a git history 
> and munge it arbitrarily. It would be the "tree-filter" that you'd use to 
> replace that one blob that you cannot regenerate with another (ie you 
> might decide to just replace the original version of the file with that 
> *second* version, and regenerate the tree that way).
> 
> I'm cc'ing Dscho explicitly to see if he can help you with the exact 
> syntax, and maybe we could even make this into a user-manual entry about 
> how to handle corruption. I don't think we have anything in the 
> documentation about this - we only cover the trivial cases where the 
> objects are all good, but you've lost the pointers into it because you 
> removed a branch by mistake or something.

I doubt it would be that easy; the tree filter expects a _valid_ tree, 
which it checks out, and only then you can filter it.

But this is what I would do if I had the problem: I would try to create 
a state which is as close to the corrupt revision as possible, 
use a graft to replace the initial commit with that revision, and 
rewrite the branch. I'd probably start by doing something like this:

	$ git symbolic-ref HEAD refs/heads/recreate-first && rm .git/index
	$ git ls-tree -r --name-only <initial-commit> |
		grep -v "^condor/condor-uninstall.sh$" |
		xargs git checkout <initial-commit>
	$ git checkout <second-commit> condor/condor-uninstall.sh
	[possibly some minor hacking on the latter file to make it work]
	$ git commit -c <initial-commit>

This starts a new branch, which has no ancestor yet.  It takes all files 
except the corrupt one from the first commit, and a replacement of the 
corrupt one from the second commit.  Then it takes all the meta-data from 
the first commit to create a replacement for the first commit.

Now I'd graft the second commit onto the first:

	$ git rev-parse <second-commit> recreate-first >> .git/info/grafts

This explicitely tells git to disregard the parent information given in 
<second-commit>, and to pretend that the recreated commit is its parent.

	BEWARE! Grafts are a powerful weapon, and you can spend tons of 
	time looking for an error, when all you did was grafting parts of 
	the history onto other parts of the history.  For example, I was 
	searching several nights for the bug preventing me to push one of 
	my repos, and it always gave an "unpacking" error.  Once I moved 
	the grafts out of the way, it miraculously worked.

After that, just call git-filter-branch (not yet released, but will 
probably be part of 1.5.3):

	$ git filter-branch <branchname>

Many things can go wrong through that process, so you want to make sure 
that all steps actually worked as intended (especially since I tested 
none of this, but wrote it in the mail program)!

Hth,
Dscho
