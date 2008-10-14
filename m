From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Tue, 14 Oct 2008 11:49:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810131546180.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 11:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpgRI-0007KC-L5
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 11:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbYJNJm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 05:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbYJNJm2
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 05:42:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:45607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752638AbYJNJm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 05:42:27 -0400
Received: (qmail invoked by alias); 14 Oct 2008 09:42:25 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 14 Oct 2008 11:42:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19K0cQvFHxKvbHGjkN/d/dW3t86ZEbW0NoZSjRJX/
	9+0yW0eCgMCQSs
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LNX.1.00.0810131546180.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98177>

Hi,

On Mon, 13 Oct 2008, Daniel Barkalow wrote:

> On Mon, 13 Oct 2008, Johannes Schindelin wrote:
> 
> > I actually understand now why the tests started failing: the change from 
> > resolve_ref() to get_branch() as requested by Daniel are at fault: 
> > get_branch() does not check if the branch has an initial commit.
> > 
> > I am actually regretting making this change.  Daniel, do you agree 
> > that it might be better to change back to resolve_ref(), so that the 
> > initial complaint (IIRC Han-Wen git pull'ed into a freshly initialized 
> > repository with that utterly bogus "git pull origin master:master" 
> > line) is not re-raised?
> 
> Is it, in fact, okay to fetch into the current branch if it's "yet to be 
> born"? I feel like it shouldn't be, since you'll get exactly the same 
> problem that you would if the branch already existed: the index reflects 
> the previous state (in this case, it's empty), so git will show that 
> you've staged removing all of the files, right? So this would make the 
> check for --update-head-ok more strict than before, but I think the 
> behavior change is correct.

I think 
http://thread.gmane.org/gmane.comp.version-control.git/31351/focus=31544 
is the best link to see what Han-Wen said.  Granted, it was a 
misunderstanding on his part, but there have been quite a few people with 
the same misunderstanding.

So what they did was

	$ mkdir just-one-branch
	$ cd just-one-branch
	$ git init
	$ git remote add origin <url>
	$ git pull origin master:master

And this _will_ work correctly.  Except when using get_branch(NULL) 
instead of the validating resolve_ref().

When we talk about not breaking existing behavior, we have to talk about 
this behavior, too.

So, my vote is to revert back to resolve_ref(), even if it needs more 
lines.

Thoughts of others?

Ciao,
Dscho
