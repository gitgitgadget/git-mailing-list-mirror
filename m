From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 11:55:40 -0800
Message-ID: <7voe4sxooz.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
	<437318CD.2050401@slamail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 20:57:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaIWP-00064K-IO
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVKJTzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVKJTzm
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:55:42 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:11677 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751209AbVKJTzm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 14:55:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110195453.KSHO29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 14:54:53 -0500
To: Yaacov Akiba Slama <ya@slamail.org>
In-Reply-To: <437318CD.2050401@slamail.org> (Yaacov Akiba Slama's message of
	"Thu, 10 Nov 2005 11:54:21 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11515>

Yaacov Akiba Slama <ya@slamail.org> writes:

> /trunk/path/to/file
> /trunk/new/path/to/file (this is a copy of /branches/branch_1/path/to/file)
> /branches/branch_1/path/to/file
> /branches/branch_n/path/to/file
> /tags/tag_1/path/to/file
> /tags/tag_m/path/to/file
>
> Now the commit 109fc2b97b73090a4a0a6550cdf9b2446fd12389 creates a new 
> commit with two parents:
> 1) HEAD
> 2) the git branch called "branch_1"
>
> From what I read about the definition of commit in git's documentation, 
> that seems to be ok, but can this marking of  "branch_1" as a parent of 
> this commit be dangerous for merges done later in pure git ?

I think it is reasonable to record both as parents, to make the
development history in branch_1 accessible from the trunk branch
after they are merged, and I do not think it is dangerous at
all.  It is just a regular merge which, when viewed from trunk
side of the history, creates a directory called 'new' at the top
level, and adds bunch of files there, and if you are viewing it
with rename/copy detection you may even notice that those
changes are mostly copy edits.

But the above example brings up an interesting question.
Subversion lets you copy freely and does not require the
developer to express machine-readably what that copy is about.
Also it lets copy partial trees.  So it is entirely plausible to
run your project like this:

	1. Repo has /trunk/i386/blah.c; i.e. 'ls' at the
           toplevel of the working tree shows 'i386' directory.

               /trunk/i386/blah.h

        2. Somebody wants to do x86-64 equivalent of existing
           thing, and starts preparing it by copying existing
           i386 thing, into his branch, and do development
           there.

		/trunk/i386/blah.c
                /branches/wip-x86-64/blah.c (copy from /trunk/i386)

        3. Later, that x86-64 equivalent matures, and gets
           merged into trunk:

		/trunk/i386/blah.c
		/trunk/x86-64/blah.c (merge back from /branches/wip-x86-64)
                /branches/wip-x86-64/blah.c (development ceased)

But it is also plausible to do this instead:

	2'. Instead of the above, you copy the whole thing

		/trunk/i386/blah.c
                /branches/wip/i386/blah.c (copy from /trunk)
                /branches/wip/x86-64/blah.c (then copy from /branches/wip/i386)

        3'. Instead of the above:

		/trunk/i386/blah.c (merge back from /branches/wip)
		/trunk/x86-64/blah.c (merge back from /branches/wip)
                /branches/wip/i386/blah.c (development ceased)
                /branches/wip/x86-64/blah.c (development ceased)

Do you need to handle the history resulting from these cases
differently when importing from subversion?  I have a feeling
that the user needs to tell what really happend for you to
handle this sensibly (tree root level is different), but I am
not offhand sure what the issues are.
