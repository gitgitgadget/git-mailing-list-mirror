From: Junio C Hamano <junkio@cox.net>
Subject: Re: Diff between the non-head git work dir and non-git kernel sources
Date: Tue, 08 Nov 2005 14:18:56 -0800
Message-ID: <7vacgeeqb3.fsf@assigned-by-dhcp.cox.net>
References: <43711088.6070701@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 23:20:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZbnx-0007XQ-9i
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 23:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbVKHWS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 17:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbVKHWS6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 17:18:58 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:31402 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030332AbVKHWS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 17:18:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108221837.FEBO16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 17:18:37 -0500
To: lamikr <lamikr@cc.jyu.fi>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11361>

lamikr <lamikr@cc.jyu.fi> writes:

Let me understand what trees are involved.  I am not sure from
your description.

 1. You based your own development on some kernel snapshot.

 2. The kernel snapshot you based 1. is "some version".

 3. Mvista has d24aff0b commit that contains their changes to
    a kernel snapshot (the same "some version" as 2).

 4. Mvista now has different version, descendant of 3.  This is
    the top of omap tree you cloned.

         --------------------------->[2] yours
        /
     [1]------------->[3]----------->[4] omap tip

Is this the commit history graph you have?

> I would now like to revert the sources in git working dir to state that 
> was after this d24aff0bd3e788d69a45a9d1b1eecda88d847a41 commit
> and then make the diff between that kernel source version and my non-git 
> source version.

You lost me here.  Presumably the ultimate goal of what you are
doing is either one of the following:

(1) port your good changes between [1] and [2] on top of [4], or

(2) port progresses in omap tree between [3] and [4] (or perhaps
    [1] and [4], including changes betwen [1] and [3]) on top of
    your tree [2].

But I am not sure what you mean by the above paragraph.  You
sound as if you want to find out the differences between [3]
("revert it to d24aff") and [2] ("your non-git source").

If that is what you want instead, assuming you have your kernel
tree in linux-lamikr and omap tree in linux-omap:

	$ cd linux-omap
        $ git checkout -b snapshot-d24aff0b d24aff0b
	$ cd ..
	$ diff -ru -X linux-lamikr/Documentation/dontdiff \
        	linux-omap linux-lamikr

would give you the diff between [3] and [2]; if the difference
between [1] and [3] is insignificant, then that diff can be
applied to [4].  However, if you have much stuff going on
between [1] and [2], applying "single diff containing
everything" may turn out to be not so useful.

> 2) Does git-diff support making the diff between git's working dir and 
> "my non" git kernel source dir.
> Or should I just just use normal diff and order that to ignore .git dir 
> and .gitignore files?

Another possibility would be to move your development to .git;
if you know the commit id of [1], then you can branch from that
commit and replay your development trail step by step up to [2].
This obviously requires that you used some SCM to keep track
your development trail between [1] and [2].

Once you have done that (and assuming your branch is called
lamikr), you could compare omap and your tip with:

	$ git checkout lamikr
	$ git diff lamikr origin

Or even merge omap tip into your branch:

	$ git checkout lamikr
	$ git pull . origin

all inside linux-omap/ directory.
