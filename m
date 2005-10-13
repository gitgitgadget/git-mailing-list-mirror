From: Junio C Hamano <junkio@cox.net>
Subject: Re: Regression: Multi-head syntax
Date: Thu, 13 Oct 2005 15:36:48 -0700
Message-ID: <7v4q7l11tr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510132225120.1028@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 00:38:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQBh0-0008NE-F3
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 00:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVJMWgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 18:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVJMWgv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 18:36:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58035 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751116AbVJMWgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 18:36:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013223630.YTSW29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 18:36:30 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510132225120.1028@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 13 Oct 2005 22:28:50 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10093>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> with 221e743c.. [git-fetch --tags: deal with tags with spaces in them.] my 
> usual git-fetch no longer works. My .git/remotes/junio used to look like 
> this:
>
> -- snip --
> URL: rsync://rsync.kernel.org/pub/scm/git/git.git
> Pull: master:junio todo:todo +pu:pu
> -- snap --
>
> but this makes a new head "junio todo:todo +pu:pu". Now I have to write 
> the remote like this to work correctly:
>
> -- snip --
> URL: rsync://rsync.kernel.org/pub/scm/git/git.git
> Pull: master:junio
> Pull: todo:todo
> Pull: +pu:pu
> -- snap --
>
> Is this intended?

Unintended regression whose solution is not quite decided.  My
current thinking is to disallow refnames that:

     * have a path component that begins with a ".", or
     * have two consecutive dots "..", or
     * have ASCII control character, "~", "^", ":" or SP, anywhere, or
     * end with a "/".

and there are series of commits to enforce the above (except two
dots) in the proposed updates branch.

The first one does not have much technical reason for it, but is
just easier on eye, and we do not have to worry about /./ or
/../ if we have that rule.  The second one is so that
"ref1..ref2" notation that means "^ref1 ref2" in some tools
would be unambiguous.

SP and TAB are because of the shell splicing tokens at IFS, LF
is because of remote/ file format, and forbidding the rest of
the control characters are "not strictly necessariy but why not
while we are at it?"  "~" and "^" are "follow-the-parent"
postfix operators, and ":" separates a src:dst pair in a
refspec.

There is a thread on this:

	http://marc.theaimsgroup.com/?l=git&m=112901070817153&w=2

It appears to me that the list does not have many objections to
the above restriction, so that change can goes in now after
double-dot fixes, and perhaps after fixing cvs/arch import to
munge the tag/branch names appropriately, we can revert the
IFS="$LF" change in git-fetch that is giving you this trouble,

This is slightly offtopic, but could you switch to http
transport?  Rsync has been deprecated for quite some time.
