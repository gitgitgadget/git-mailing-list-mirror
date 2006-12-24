From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git reflog show
Date: Sun, 24 Dec 2006 13:47:47 -0800
Message-ID: <7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
References: <20061223101956.GD9396@spearce.org>
	<7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061224061151.GE7443@spearce.org>
	<Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Dec 24 22:47:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GybCF-0001tg-TI
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 22:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbWLXVrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 16:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLXVrv
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 16:47:51 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48332 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbWLXVru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 16:47:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061224214747.JLWH3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Dec 2006 16:47:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2lo01W00e1kojtg0000000; Sun, 24 Dec 2006 16:48:01 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 24 Dec 2006 13:49:51 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35376>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes, but if we have to read the reflog anyway to determine the logical 
> (local) parent, we can just as well read the message, and display it, too.
>
> What it buys us is that we do not duplicate efforts here, and we can 
> easily visualize the reflog in gitk, too.

I do not think you can sanely rewrite parenthood.

Think about this sequence

	$ git init-db; edit foo; git add foo
	$ git commit -m 'first'
	$ edit foo; git add foo
        $ git commit -m 'second'
        $ git reset --hard HEAD@{1}

At this point, the commits on the reflog are:

        $ git show-branch --reflog=3 HEAD
        ! [HEAD@{0}] first
         ! [HEAD@{1}] second
          ! [HEAD@{2}] first
        ---
         +  [HEAD@{1}] second
        +++ [HEAD@{0}] first

We are currently at the first commit, and its "rewritten" parent
should point at the second commit (i.e. pretend HEAD@{1} is the
parent of HEAD@{0}).  The "rewritten" parent of the second commit
should be HEAD@{2}, but that is actually the same first commit
which is HEAD@{0}.

Also I highly doubt visualization based on parents information
rewritten to match the reflog order is of _any_ use.  By
rewriting the parenthood, you are losing the topology and your
visualization is no better than what "tac .git/logs/$ref" would
give.

I do agree that reusing the message formattng and display code
from the usual log machinery is desirable.  I think you can hook
that information somewhere in object->util (or a callback
mechanism) and teach log display machinery to use it as a
generic mechanism.  That might make the existing code to insert
"Subject: " for --pretty=format simpler, but I haven't looked.
