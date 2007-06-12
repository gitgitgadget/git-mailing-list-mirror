From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Support config-based names
Date: Mon, 11 Jun 2007 23:44:43 -0700
Message-ID: <7vfy4xllic.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706112244210.5848@iabervon.org>
	<7vbqfln3mf.fsf@assigned-by-dhcp.pobox.com>
	<Pine.LNX.4.64.0706120131010.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 08:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy07j-0001Ik-LT
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 08:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777AbXFLGop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 02:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbXFLGop
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 02:44:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:45124 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505AbXFLGoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 02:44:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612064444.ZMSO3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 02:44:44 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AWkj1X0051kojtg0000000; Tue, 12 Jun 2007 02:44:44 -0400
In-Reply-To: <Pine.LNX.4.64.0706120131010.5848@iabervon.org> (Daniel
	Barkalow's message of "Tue, 12 Jun 2007 01:56:16 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49926>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 11 Jun 2007, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>
> What I'm worried about is whether we'll eventually want some sort of 
> function and an object with the same name, and then have to have a syntax 
> problem with legacy functions being confusing.

I would agree that I'd worry about that; we will eventually want
some sort of function that is user customizable from command
line, in the same sense as "@{any date specifier}" but possibly
stronger.  And at that point, even [] would get in the way of
that scriptable part.  I'd prefer to provide a set of well
defined and usable "atoms" and let the people script with them.

>> We need to see how useful this would be in practice; we would
>> not want to add new syntax without a set of convincing use
>> cases.  At this point, it still feels as if it is a feature that
>> was implemented only because it could, not because there was a
>> real need.
>
> I'd be a lot more reliable at using git if git-commit reported "git log 
> --pretty=oneline HEAD^{push}..HEAD" after each commit (if there is a 
> HEAD^{push}). I'm forever committing things and forgetting to push them 
> when I mean to.

First, I think 'push' is a misnomer for that purpose, as your
widely popular "pretend we immediately fetched back" topic made
remote tracking branches, which were originally associated more
strongly to 'fetch', associated equally well to 'push'.  You are
comparing what the remote counterpart of your current branch has
(or supposed to have) with what you built.  So I would have
called it 'remote'.

Second, more importantly, that functionality to do log or diff
would go to post commit hook script, and you shouldn't have to
have such a built-in "function" and new syntax to implement
that.  I think more generally useful would be a change to "git
remote" to teach what "git-parse-remote" historically has done,
so that scripts can ask things like:

 - what is the symbolic name of the remote associated with my
   current branch (i.e. branch.$current.remote)?

 - what is the url of the remote given its symbolic name
   (i.e. remote.$remote.url and URL: in .git/remotes/$remote)?

 - what branch at the remote would my current branch pushed to
   (i.e. $current mapped through remote.$remote.push and Push: in
   .git/remotes/$remote)?

 - what remote tracking branch I am using to track that branch
   (i.e. that remote branch mapped through remote.$remote.fetch
   and Pull: in .git/remotes/$remote)?

 - what remote branch do I usually merge into my current branch
   (i.e. branch.$current.merge or the "first refspec listed"
   fallback)?

and combinations of the above.  I would even prefer the
"combinations" to be performed by callers of "git remote", iow,
in your hook script, not as myriad of "git remote" options.

> I didn't have a particular need for ^{merge}, but I accidentally wrote it 
> first because I was confused as to what I wanted.

The last question above is there for completeness.  I think it
would also be a good thing to give to the user.

In other words, I think the questions I listed above are "atoms"
at more appropriate granularity to build flexible tools out of
in order to fit people's different workflow, and I think it is
way premature to embed only a selected-few combinations of them
into syntax sha1_name.c understands.
