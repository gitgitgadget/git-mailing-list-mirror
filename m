From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/9] work-tree clean ups
Date: Wed, 1 Aug 2007 11:56:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011147500.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site> <7vbqdsdqfd.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0708010211071.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 12:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGBsc-00037A-Ji
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 12:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757681AbXHAK4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 06:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756954AbXHAK4b
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 06:56:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:46817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756235AbXHAK4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 06:56:30 -0400
Received: (qmail invoked by alias); 01 Aug 2007 10:56:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 01 Aug 2007 12:56:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yOr0pa3GyZh8C96jCxAMogVq02B+48ubcVMITuN
	N2ishPin9CZXh1
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0708010211071.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54427>

Hi,

On Wed, 1 Aug 2007, Johannes Schindelin wrote:

> On Tue, 31 Jul 2007, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > There is not really much that can be done about step 6/9: if we are in a 
> > > work tree: that does not mean that we are _not_ in the git_dir.  (And no, 
> > > this does not break git-clean, as a work tree is a work tree is a work 
> > > tree.  If the user was stupid enough to specify the same directory as 
> > > GIT_DIR and GIT_WORK_TREE, then that is _her_ problem.  Git is a powerful 
> > > tool, and you can harm yourself with it.  Tough.)
> > 
> > I think we might have a slight misunderstanding.  The "clean"
> > issue that was raised in an ancient thread was this sequence:
> > 
> > 	$ git init
> >         $ cd .git
> >         $ git clean
> > 
> > It did not involve GIT_DIR (nor GIT_WORK_TREE as it was not even
> > there).
> 
> I very much _did_ mean that case.  When "git clean" is run in ".git/", it 
> should not say that it is in the working tree.  But I guess that my patch 
> series is not really looking out for that;  I'll make that an add-on 
> patch.  (But that _will_ have to wait until tomorrow afternoon.)

I should not have answered so early.

In setup.c, I put in a comment that explains clearly where (in the absence 
of GIT_DIR) setup_git_directory_gently() looks for the git directory:

        /*
         * Test in the following order (relative to the cwd):
         * - .git/
         * - ./ (bare)
         * - ../.git/
         * - ../ (bare)
         * - ../../.git/
         *   etc.
         */

At least I hope that this explanation is clear.

So what happens in this case:

	$ git init
	$ cd .git
	$ git clean

In setup_git_directory_gently(), it is tested first if there is a 
subdirectory .git/.  No, none.  Then it is tested if "." is a git 
directory.  Yes!  So, work_tree is set to NULL tentatively (to be 
overridden by either core.worktree or GIT_WORK_TREE), and it is assumed to 
be bare (also subject to overriding).  So all is well!

You might have noticed that I left out --work-tree= handling; when 
--work-tree=<something> is specified, GIT_WORK_TREE is _forced_ to the new 
value, so it is literally handled by the same code as GIT_WORK_TREE.

Ciao,
Dscho
