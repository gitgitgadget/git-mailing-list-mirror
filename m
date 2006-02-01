From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to use git for Linux kernel development ?
Date: Wed, 01 Feb 2006 13:43:45 -0800
Message-ID: <7vmzha92lq.fsf@assigned-by-dhcp.cox.net>
References: <200602011238.44188.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 22:44:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4PlW-00007b-Sj
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 22:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422953AbWBAVns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 16:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422955AbWBAVns
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 16:43:48 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17376 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422953AbWBAVnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 16:43:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201214224.NJZO6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 16:42:24 -0500
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
In-Reply-To: <200602011238.44188.laurent.pinchart@tbox.biz> (Laurent
	Pinchart's message of "Wed, 1 Feb 2006 12:38:44 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15452>

Laurent Pinchart <laurent.pinchart@tbox.biz> writes:

> ... I haven't been able to figure 
> out which branches I should create and how I should use them.

Bruce already responded to this part in a more polite way, but
let me be more blunt.  You need to figure out how your project
and workflow is to be organized first, and that needs your own
thinking.  We could help, but you know your project better than
any of us.  The organization of what git branches to use and how
would fall out as a natural consequence of your workflow.

> ... If really unable to use git, I'll go for SVN (or
> SourceSafe as that's what my company used until today, but I'd
> like to avoid it) even if I feel it will make keeping
> up-to-date with upstream more difficult.

And I suspect you would have the same workflow issues regardless
of the choice of any SCM (some SCM may _force_ particular
workflow on you though; which may be a good thing -- it reduces
confusion coming from having too many possibilities to choose
from).

For example, with my simplified world view, I would do something
like this:

master::
	the tip of the latest of your product.

vanilla::
	the tip of the Linus vanilla kernel. you do not
        commit to it---you only update it via "git fetch".

kfix::
	forked somewhere from refs/heads/vanilla, and may
        occasionally be updated by merging from it, to
        hold your own bugfixes meant for mainline.

maint/1.0, maint/1.1, maint/1.2,...::
	forked somewhere from master when you do a release.


Your product specific work is done in master.  In practice, you
probably would emply "topic branch" workflow to grow the master,
but that is covered pretty well by Tony Luck in one of our howto
documents, so I would not repeat it here. External patches you
pick up from elsewhere would go in the master as well.

When working on bugs present in the vanilla kernel, You checkout
kfix, work in there and commit fixes to this branch.  It may be
a good idea to occasionally sync this branch with vanilla when
your changes conflict with upstream changes.  This is the branch
you would publish to the outside world for consumption by the
kernel community (other branches probably need to be published
to satisfy your GPL obligations as well).

You would merge from kfix into master as needed.

When you release your version 1.0 product, you would tag
"master", and at the same time, branch "maint/1.0" from there.
Further post-release fixes you would commit to maint/1.0
branch.  You might make further tags 1.0.1, 1.0.2 on this branch
as needed.
