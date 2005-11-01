From: Junio C Hamano <junkio@cox.net>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 16:20:51 -0800
Message-ID: <7vbr15b4m4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	<Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
	<Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	<20051031195010.GM11488@ca-server1.us.oracle.com>
	<7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	<20051031213616.GO11488@ca-server1.us.oracle.com>
	<7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	<20051031224246.GP11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 01 01:21:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWjtX-0006Ew-QM
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 01:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVKAAUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 19:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVKAAUx
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 19:20:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37041 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964917AbVKAAUw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 19:20:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051101002003.DEPO2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 19:20:03 -0500
To: git@vger.kernel.org
In-Reply-To: <20051031224246.GP11488@ca-server1.us.oracle.com> (Joel Becker's
	message of "Mon, 31 Oct 2005 14:42:46 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10905>

Joel Becker <Joel.Becker@oracle.com> writes:

> 	No, you're reading me wrong, but I wasn't clear enough either.
> At the end of my message, I'm noting that I'm considering smaller
> changes here, not huge features.

OK.  Consolidating two or more patches into one is something I
have done too, but I never felt need for tool support, so that's
probably why I misunderstood you.

After extracting a sequence of the dirty commits using
git-format-patch, I would say:

	for i in 0*.txt; do git-apply --index $i; done

to bring my tree up to date, and then just say "git commit".

Typically when I do this, I have one "significant" commit among
them, usually early in the series, which is followed by smaller
"fix this, fix that, oops fix that too" commits.  So I edit the
log message using the log of the significant commit, and add
some missing bits.

I guess another way to do it without even first extracting them
as patches would be:

        $ git checkout -b mytopic master
        $ work work work, commit commit commit.
        $ git checkout master
        $ git-read-tree -m -u master mytopic
        $ git-commit -c <that-significant-commit-in-mytopic-branch>

If you want a tool support for this workflow, probably the last
two could be somewhat automated.  But what would the user input
for that be?  You need to tell what tree shape you want the
after-commit tree to be in, and where you would want the bulk of
your commit message to come from.

One possibility.

        $ git-squash-pick mytopic

would be something like this:

	#!/bin/sh
        #
        git-read-tree -m -u HEAD "$1"
        git log HEAD.."$1" >.tmp-commit
        git-commit -F .tmp-commit -e

Your commit-log edit buffer would start with the concatenation
of all the commit logs in that throwaway history, and hopefully
you would mostly need to delete lines and move some parts around
before committing.  I do not know how useful this kind of
specialized tool would be, though...

Splitting and merging patches into logical steps is something I
dream of to be automated, but I do not know how (nor even if it
is possible) offhand.  Sometimes, when you want truly logical
steps, you would end up needing intermediate steps that never
existed in your true history (i.e. "in the hindsight, my
development should have progressed in these steps.")



	
