From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now What?
Date: Thu, 03 Nov 2005 10:38:15 -0800
Message-ID: <7vu0eth90o.fsf@assigned-by-dhcp.cox.net>
References: <E1EXTw5-00063o-Gt@jdl.com>
	<20051103083840.GA28300@ebar091.ebar.dtu.dk>
	<7v4q6uhx0a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511031151070.25300@iabervon.org>
	<Pine.LNX.4.64.0511030926020.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org,
	Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 19:40:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXjyf-0003c8-JE
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 19:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVKCSiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 13:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbVKCSiS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 13:38:18 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25026 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030415AbVKCSiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 13:38:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103183737.EOLU29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 13:37:37 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511030926020.27915@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 3 Nov 2005 09:27:05 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11081>

Linus Torvalds <torvalds@osdl.org> writes:

> And that's exactly what "git reset --hard" is there for. It will reset to 
> the old head of the branch you are on (ie HEAD), and get rid of everything 
> that was done to the tree.

OK, then let's rewrite the procedure using 'reset --hard'.  Then
we do not have to use 'checkout -f' afterwards.  The advantage
of this approach is that 'reset --hard' would remove the new
files the failed merge might have left in your working tree,
while using 'checkout -f' would.

What now?  Depends on what you wanted to do.  If what you wanted
to do was to merge my "master" to your "maint", then you would
resolve the conflicts by hand, but probably that was not what
you wanted to do.

After that pull, your repository is in this state:

. the index file and working tree is somewhere between your
  "maint" and my "master".  "somewhere between" is because the
  merge obviously failed.

. the "maint" head has not moved.  Your .git/HEAD points at the
  "maint" branch.

. the "origin" head points at my latest "master" head.

First thing is to bring your tree to a known state, to make
recovery easier.

	$ git reset --hard

would match your working tree to your .git/HEAD, i.e. your
"maint".

If you keep a copy of my "master" plus zero or more of your own
development in your "master" branch, and what you wanted to do
was to build my "master" plus those developments of your own,
then:

	$ git checkout master
        $ git pull . origin

If your "master" is just a vanilla copy of my "master", then
this pull would result in a fast forward, and "master" and
"origin" will point at the same commit after this pull
operation.  Otherwise, you would merge your changes and my
"master" updates into your "master" branch.

If what you wanted to do was to build my "master" vanilla, then:

	$ git checkout origin

because your remotes/origin says "origin" is meant to be a
straight copy of my "master".

A good habit to get into is, before pulling, make sure:

. your index matches your HEAD.

. the local modification (i.e. what git-diff-files would report)
  is something you do not mind losing.

. you are on the right branch you want to pull into (check with
  "git branch").
