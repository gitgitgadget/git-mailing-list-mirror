From: Junio C Hamano <junkio@cox.net>
Subject: Re: My first git success
Date: Fri, 13 Jan 2006 11:37:29 -0800
Message-ID: <7vmzhz7wcm.fsf@assigned-by-dhcp.cox.net>
References: <dq8epd$k28$1@sea.gmane.org>
	<Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
	<86y81kvtvj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 20:37:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExUjw-00082K-JT
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 20:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422855AbWAMThd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 14:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422858AbWAMThd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 14:37:33 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:56967 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1422855AbWAMThc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 14:37:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113193534.LCWY17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 14:35:34 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86y81kvtvj.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "13 Jan 2006 10:57:04 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14639>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> However, before I bug-fix, I have to "snapshot" any working changes in the
> ajax branch or I would lose them on "git-checkout master", which gives me
> commits that look like "snapshot".  Am I doing that wrong?  Is there a better
> way to do parallel development of a "live vs upgrade" branch, and make commits
> only when I make progress?

Although I am sure others would suggest to use more than one
working tree, here are what I generally do, which does not
require more than one.

-- >8 --

Interrupted workflow
--------------------

When you are in the middle of a large change, you can get
interrupted.  The files in your working tree is not in any shape
to be committed, but you need to get to the other branch for a
quick fix.

------------
: on ajax; work work work
: on ajax; git commit -a -m 'snapshot WIP' <1>
: on ajax; git checkout master
: on master; fix fix fix
: on master; git commit ;# commit with real log
: on master; git checkout ajax
: on ajax; git reset --soft HEAD^ ;# go back to WIP state <2>

<1> This commit will get blown away so short log message is just fine.
<2> This removes the 'WIP' commit from the commit history, and makes
    your working tree in the state just before you made that snapshot.

------------

The only difference between the state immediately before <1> and
immediately after <2> is that files you committed in <1> are
still registered in index at state <2>, so your "git diff" would
not give you what you were in the middle of doing at point <2>
and you need to say "git diff HEAD" instead.  You could do a

------------
: on ajax; git read-tree -m HEAD
------------

immediately after the soft reset, which sets your index file to
the last commit you were basing your ajax work on.
