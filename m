From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did
 not change
Date: Fri, 25 Jul 2008 12:35:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807251231560.11976@eeepc-johanness>
References: <alpine.DEB.1.00.0807222235520.8986@racer> <7vmyk888z5.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807241311450.8986@racer> <7vod4muzck.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 12:35:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKeG-0004ep-LG
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbYGYKeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753217AbYGYKeo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:34:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:39425 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753148AbYGYKen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:34:43 -0400
Received: (qmail invoked by alias); 25 Jul 2008 10:34:41 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp024) with SMTP; 25 Jul 2008 12:34:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XUgQG1K2XpuzoZQ+ByjYcuclyN+S8q3Ink+6EVX
	CoE7IUvLkp9xwi
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vod4muzck.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90025>

Hi,

On Fri, 25 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> At what point in what valid workflow sequence does HEAD become 
> >> different from dotest/amend?
> >
> > $ rebase -i HEAD~5
> >
> > 	<mark one commit as edit>
> >
> > 	<Whoa! While editing, I realize that this contains an unrelated 
> > 	 bugfix>
> >
> > $ git reset HEAD^
> > $ git add -p
> > $ git commit
> >
> > 	<Edit a bit here, a bit there>
> >
> > $ git rebase --continue
> >
> > Sure it is a pilot error.  It hit this pilot, too.
> > ...
> > In the way that the user certainly did not mean to amend _this_ HEAD.  
> > Another HEAD was marked with "edit".
> 
> Ok; after this "refraining from incorrectly squashing them", how would the
> user edit the one the user originally intended to edit (I am not
> complaining, but asking for information)?

In this case, the two commits are two commits, the editor popped up with 
rebase --continue contains the original commit message, and all is fine.

> So in your workflow example, when there is no pilot error, is this the 
> "ideal" sequence?
> 
> 	$ git rebase -i HEAD~5
>         .. mark one as edit
>         .. ah, the one I wanted to just "edit" actually need to be
>         .. split into two because it has some other thing I need to change
> 	$ git reset HEAD^
> 	$ git add -p
>         $ git stash --keep-index
>         .. test to verify the initial part
>         $ git commit ;# first part of split commit
>         $ git stash pop
>         .. test test
>         $ git add -p

Without pilot error, here has to come a "git commit -c HEAD@{1}".

>         $ git rebase --continue ;# gives you the editor to edit
> 
> I wonder if we can make the transcript of the "pilot error" case look like
> this:
> 
> 	$ git rebase -i HEAD~5
> 	...
> 	$ git reset HEAD^
>         .. same as above up to...
>         .. test to verify the initial part
> 	$ git rebase --continue ;# oops
> 	.. gives you the editor to edit the message.
>         .. makes a commit, and says:
>         committed initial part of the change, stopping.
> 	.. ah, the command noticed it and did not escape, thanks!
>         $ git stash pop
>         .. test test
>         $ git add -p
>         $ git rebase --continue ;# gives you the editor to edit
> 	.. and goes on this time.

Possible.

The first hunk (IIRC) of my patch would stay the same, but the second hunk 
would not fall through to the interactive commit, instead testing if amend 
exists, _and_ is different from HEAD, and if both are the case, say 
something helpful and exit.

Ciao,
Dscho
