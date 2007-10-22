From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: Howto request: going home in the middle of something?
Date: Mon, 22 Oct 2007 10:44:24 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710221044.24191.wielemak@science.uva.nl>
References: <200710181144.22655.wielemak@science.uva.nl> <20071018112758.GN18279@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Oct 22 10:51:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijszu-0001E5-DE
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 10:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbXJVIun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 04:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXJVIun
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 04:50:43 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:1599 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbXJVIum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 04:50:42 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9M8odU7017857;
	Mon, 22 Oct 2007 10:50:39 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <20071018112758.GN18279@machine.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61972>

Thanks for the replies.	 I think I can live with something like this

	<work, in the middle of something>
	$ git checkout -b home
	$ git commit
	$ git checkout master
	<arriving at home>
	$ git jan@work:repo fetch home:home	(using ssh)
	$ git checkout home
	<continue editing>
	$ git commit --amend
	$ git checkout master
	$ git merge home
	$ git -d home
	$ git commit
	$ git push
	<arriving at work>
	$ git -d home
	$ git pull

Its still a bit many commands and you have to be aware what you are
doing for quite a while, but it does provide one single clean commit
message, doesn't change the shared repo until all is finished and allows
to abandon all work without leaving traces.

Personally I'd be more happy with

	<work, in the middle of something>
	$ git stash
	<arriving at home>
	$ git stash fetch jan@work{0}	(well, some sensible syntax)
	$ git stash apply
	<continue editing>
	$ git commit
	$ git push
	<arriving at work>
	$ git pull

Its not only shorter, but reduces the risc to make mistakes. I think the
missing fetch to copy the stashed data from work to home is actually
there if you know a bit more about git internals. Right? Ideally, this
could be combined in a little command that will simply move the
uncommitted work from one clone to another, provided you have ssh access
to the machine from which you want to fetch the work.

	--- Jan

On Thursday 18 October 2007 13:27, Petr Baudis wrote:
> On Thu, Oct 18, 2007 at 11:44:22AM +0200, Jan Wielemaker wrote:
> > I've somewhere seen it in a mail, but I can't find it anymore. I have a
> > bare central (public) repository and clones on various machines I work
> > on. We all know it, you're right in the middle of something and it is
> > really time to go home. You want to pick up your work at home, but
> > without pushing to the shared repository.
> >
> > I'm sure GIT can do this elegantly, but I'm not yet sure how.  I guess
> > Ideally I want "git stash" at work, transfer the stashed changes to my
> > other machine and apply them.  How do I do that?
> >
> > Alternatively, I guess, one can commit at machine A, fetch the commit
> > from machine A and continue. I'm still too uncertain about the remote
> > access options to work this out properly, but it also feels less
> > clean.
>
>   this should be pretty simple assuming SSH access to machine A. Git can
> fetch over SSH, so it's merely about telling it that repository X is
> available over ssh over there and it'll fetch it home.
>
>   The exact setup depends on whether you want to do this just once or
> semi-regularily.  If the former, just
>
> 	git pull git+ssh://a.machine.aero/absolute/path
>
> Note that this should fetch only the remote master branch, if I'm not
> mistaken.
>
>   If the latter, tell your home repository about your work repository:
>
> 	git remote add workrepo git+ssh://a.machine.aero/absolute/path
>
>   Then, you can anytime just
>
> 	git fetch workrepo
>
> and it will fetch all the branches from workrepo; whether you want to
> use git fetch and git merge or git pull depends on your local
> arrangement of branches at home.
>
>
>   So, basically, when fetching you deal with your work repository
> exactly the same way as in the shared repository.
>
>   When pushing, this is not so trivial. Git _allows_ you to just push to
> your work repository, but if you push to a branch that is currently
> checked out, unexpected things will happen - always avoid that. If you
> can fetch from home at work, do. If not, at least push to a branch at
> work that can never be checked out and is reserved for that purpose.
