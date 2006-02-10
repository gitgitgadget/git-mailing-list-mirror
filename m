From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to pull a single changeset from a child branch into a parent branch?
Date: Thu, 09 Feb 2006 21:01:14 -0800
Message-ID: <7vzmkzyfhh.fsf@assigned-by-dhcp.cox.net>
References: <43EC10AA.1040800@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 06:01:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7QPJ-0007BL-NI
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 06:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWBJFBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 00:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWBJFBQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 00:01:16 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2558 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751100AbWBJFBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 00:01:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210045947.MIXE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 23:59:47 -0500
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <43EC10AA.1040800@candelatech.com> (Ben Greear's message of "Thu,
	09 Feb 2006 20:03:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15866>

Ben Greear <greearb@candelatech.com> writes:

> I have a linux-2.6 repo with two branches off of 2.6.13.
>
> One branch (ben_v13) has just my own changes.
> A second branch (work_v13) has the 2.6.13.5 patch, and I've also pulled
> ben_v13 into it.

                     "2.6.13.5"
         o---o---o---o
        /             \ "work_v13"
    ---o "2.6.13"  .---*
        \         /
         o---o---o
                 "ben_v13"

	'o' are commits, '*' is a merge.

> Now, I made a small change to work_v13,

                     "2.6.13.5"
         o---o---o---o
        /             \   "work_v13"
    ---o "2.6.13"  .---*---x
        \         /        (new change)
         o---o---o
                 "ben_v13"

> ... and I'd like to pull only
> that changeset into ben_v13.  Is there a way to do that w/out
> having to export and apply a patch?

I would have done things differently.

It is generally a good idea if a change is applicable to more
than one branches, and these branches have merge relationship
between them (work_v13 merges from ben_v13, which has already
happened), then to apply that change to the oldest branch and
pull the branch to the new one.  In other words, if you made the
change to 2.6.13 based one, you could have pulled that into
2.6.13.5 based one.

                     "2.6.13.5"
         o---o---o---o
        /             \   "work_v13"
    ---o "2.6.13"  .---*
        \         /
         o---o---o---x
                      "ben_v13"
                   (new change)

    [Commit what is applicable to both in older branch]

                     "2.6.13.5"
         o---o---o---o
        /             \   "work_v13"
    ---o "2.6.13"  .---*--*
        \         /      /
         o---o---o---x---'
                      "ben_v13" 
                   (new change)

    [And then merge that to the derived one]


Assuming that correcting the situation like this is not an
option, you could check "git cherry-pick".  It lets you create
something like this:

                     "2.6.13.5"
         o---o---o---o
        /             \   "work_v13"
    ---o "2.6.13"  .---*---x
        \         /
         o---o---o---------x'
                 "ben_v13" (equivalent of 'x' commit)


The command sequence to do this is:

	$ git checkout ben_v13
        $ git cherry-pick work_v13
