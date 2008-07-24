From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did
 not change
Date: Thu, 24 Jul 2008 13:20:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241311450.8986@racer>
References: <alpine.DEB.1.00.0807222235520.8986@racer> <7vmyk888z5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 14:21:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLzpT-0000nk-AB
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 14:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757445AbYGXMUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 08:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757439AbYGXMUy
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 08:20:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:45027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757414AbYGXMUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 08:20:50 -0400
Received: (qmail invoked by alias); 24 Jul 2008 12:20:48 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp062) with SMTP; 24 Jul 2008 14:20:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HhUIx/2eHmQdRk71JoZ1sSOaY84jJdezzTyJFGI
	gI8dIIW7sivX89
X-X-Sender: gene099@racer
In-Reply-To: <7vmyk888z5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89870>

Hi,

On Wed, 23 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If the user called "rebase -i", marked a commit as "edit", "rebase 
> > --continue" would automatically amend the commit when there were 
> > staged changes.
> >
> > However, this is actively wrong when the current commit is not the one 
> > marked with "edit".  So guard against this.
> 
> At what point in what valid workflow sequence does HEAD become different 
> from dotest/amend?

$ rebase -i HEAD~5

	<mark one commit as edit>

	<Whoa! While editing, I realize that this contains an unrelated 
	 bugfix>

$ git reset HEAD^
$ git add -p
$ git commit

	<Edit a bit here, a bit there>

$ git rebase --continue


Sure it is a pilot error.  It hit this pilot, too.

> > @@ -419,7 +419,9 @@ do
> >  		else
> >  			. "$DOTEST"/author-script ||
> >  				die "Cannot find the author identity"
> > -			if test -f "$DOTEST"/amend
> > +			if test -f "$DOTEST"/amend &&
> > +				test $(git rev-parse HEAD) = \
> > +					$(cat "$DOTEST"/amend)
> >  			then
> >  				git reset --soft HEAD^ ||
> >  				die "Cannot rewind the HEAD"
> 
> In what way is this "guarding against it"?

In the way that the user certainly did not mean to amend _this_ HEAD.  
Another HEAD was marked with "edit".

By not amending, the user has a chance to fix anything unintended in 
another rebase -i more easily, since the two commits have not been 
squashed together.

'course, the user should have seen in the editor that popped up that she 
is squashing two different commits, should have deleted the whole commit 
message to abort, make the independent commit herself (finding the correct 
commit to steal the commit message from), then run rebase --continue 
(which would no longer commit anything, there being nothing to).

However, that course of action is a bit unintuitive.

The way it runs with my patch, at least a user has a chance to fix it up 
without a Git expert standing nearby.

I will definitely keep this in my personal fork, even in my personal 
fork of "master" during the rc period.  But if you think it is not worth 
it, and others seem to be utterly disinterested (instead discussing 
behavior changes), I will not push further.

Ciao,
Dscho
