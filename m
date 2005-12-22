From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 12:15:32 -0800
Message-ID: <7v3bkkkhwb.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	<7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vek465cev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AA75D1.7040009@op5.se>
	<Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AA9BE6.7000601@op5.se>
	<Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AACBE9.7060201@op5.se>
	<Pine.LNX.4.63.0512221700310.18982@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AAD9D7.1070503@op5.se> <7vwthxlzai.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512222022510.31591@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 21:15:47 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpWql-0001Qp-ST
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 21:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVLVUPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 15:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVLVUPl
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 15:15:41 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63646 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030305AbVLVUPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 15:15:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222201402.ULVQ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 15:14:02 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512222022510.31591@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Dec 2005 20:28:45 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13966>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And then somebody comes along and allows world access by chmod(0775) and 
> does not realize that *everybody* can delete packs, objects and what-nots 
> in GIT_DIR.

That somebody has to be somebody who owns .git directory not
just a group member, so that is not a serious objection either,
but you need to realize I was joking with 0777 -- a saner
default would obviously be 0775.  Otherwise you would not be
able to server it from gitweb safely -- http server is typically
not a group member.

> Given the complexity we are talking about, and the needs which are not at 
> all that complicated, why not just go with core.umask until somebody 
> *needs* core.repositoryumask?

I am afraid that is going backwards.  Nobody *needs* core.umask
either, but we are still talking about this.  That is because
you wanted to make things easier for people, and I agree with
you that it would be nicer if we did not require people set
umask to sane values suitable for group work themselves, but
somehow we did that automatically for them.  The longer I think
about it, however, the more I feel this is a lost cause.

Earlier, I suggested git-shell one-liner, only because I thought
git-shell users (or administrators that support git-shell users)
may not have any way to set the umask to sane values themselves,
but I think that should also be doable by telling sshd what the
initial umask of the users should be.  And that was where this
umask discussion was started, but I think not touching umask at
all is the right direction.

Your core.umask would make sure the .git/objects/ directory
would be suitable for other members, but git is not the only
tool the people would use in the working tree.  To work well
with an editor that does not overwrite an existing file but does
creat/rename upon saving would require you to have a sane umask
if the user adopts your "shared working tree writable by all
members" workflow.  Running "make" in the working tree would
leave object files, worse yet in a temporary build directory
make created, with permission bits masked with your umask,
making it imposible to run "make clean" for other members.

Regardless of where and how people come from to work in the
working tree, they need to set umask appropriately anyway.

The only possible issue is one umask might not be sufficient,
but unfortunately you can have only one umask at a time.  The
example of "receiption branches" is not a shared repository for
me in the strict sense, but allows for you to push into.  I
cannot work with umask 022 in such a repository even if I wanted
to have files in the working tree honor tighter umask.  To deal
also with such cases, not mucking with umask but solving the
problem in a more direct way may make more sense -- namely we
should be able to say "such and such things under .git/ in this
repository must be ug+rw regardless of user's umask".
