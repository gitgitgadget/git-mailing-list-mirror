From: Junio C Hamano <junkio@cox.net>
Subject: Re: bisect help
Date: Tue, 27 Jun 2006 14:31:09 -0700
Message-ID: <7vy7vi70bm.fsf@assigned-by-dhcp.cox.net>
References: <20060627201302.GA16658@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 23:31:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvL9O-000506-Nq
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 23:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWF0VbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 17:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWF0VbL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 17:31:11 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43439 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161309AbWF0VbK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 17:31:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627213110.PIWI12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 17:31:10 -0400
To: Martin Hicks <mort@bork.org>
In-Reply-To: <20060627201302.GA16658@bork.org> (Martin Hicks's message of
	"Tue, 27 Jun 2006 16:13:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22754>

Martin Hicks <mort@bork.org> writes:

> I've got a use-case that I can't figure out.  The problem:
>
> - I have a tree with 2.6.17 + changes to make my target board work.
> - SATA works as of 2.6.17, but stops working in the libata dev tree.
>
> I want to do a bisect on this to figure out why.  I think the problem is
> that the common ancestor between the two trees is 2.6.17, and when I
> bisect I don't have any of my arch-specific changes still in the tree
> (so the kernel doesn't boot, but not for SATA reasons)

I suspect this is what you have.

                    
              o---o---o---o satadev
             /
            /
           /
   2.6.17 o---o---o---o---o master

In order to test, since vanilla "satadev" would not work with
your board (for that matter neither vanilla 2.6.17 would), I
presume you would have created a throw-away test branch and
merged them for testing:
                    
              o---o---o---o satadev
             /             \   
            /               o test
           /               / 
   2.6.17 o---o---o---o---o master

You say master works but test does not.  But everything between
2.6.17 and satadev would not work with your board *anyway*, so
bisect by itself is not very useful between master and test.

I think you could bisect between 2.6.17 and satadev, and every
time bisect suggests to test a revision (that is, it moves the
head of .git/refs/heads/bisect branch), temporarily merge
"master" in for testing, and discard that temporary merge after
you finished testing, like this:

                  bisect  
              o---o---o---o satadev
             /     \
            /       .-------o test
           /               / 
   2.6.17 o---o---o---o---o master

	$ git bisect good 2.6.17
        $ git bisect bad satadev
        Bisectiong: 1745 revisions left to test after this
	[a04da91...] arch/i386/kernel/apic.c: make modern_...
        $ git pull . master
        .. test this thing ..
        $ git reset --hard HEAD^
        $ git bisect bad ;# if it is bad
        Bisectiong: 1745 revisions left to test after this
	[050335d...] Merge branch 'devel' of ...
        $ git pull . master
        .. test this thing ..
        $ git reset --hard HEAD^

If your merges involve textual conflicts, it might be worthwhile
to enable git-rerere when you do this.
