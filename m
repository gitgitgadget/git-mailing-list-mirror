From: Junio C Hamano <junkio@cox.net>
Subject: Re: Broken adding of cache entries
Date: Sat, 07 May 2005 22:22:31 -0700
Message-ID: <7vll6q70mg.fsf@assigned-by-dhcp.cox.net>
References: <1115408460.32065.37.camel@localhost.localdomain>
	<20050506231447.GG32629@pasky.ji.cz>
	<1115421933.32065.111.camel@localhost.localdomain>
	<20050506233003.GJ32629@pasky.ji.cz>
	<1115423450.32065.138.camel@localhost.localdomain>
	<20050507001409.GP32629@pasky.ji.cz>
	<1115431767.32065.182.camel@localhost.localdomain>
	<20050507152849.GD9495@pasky.ji.cz>
	<7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
	<20050507224116.GF9495@pasky.ji.cz>
	<7vll6q8s4o.fsf@assigned-by-dhcp.cox.net>
	<7vbr7m8p05.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 07:15:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUe8j-0007uc-Ku
	for gcvg-git@gmane.org; Sun, 08 May 2005 07:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVEHFWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 01:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbVEHFWg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 01:22:36 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:26080 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262815AbVEHFWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 01:22:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508052231.QNZV22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 01:22:31 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7vbr7m8p05.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 07 May 2005 18:50:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> I am not quite sure the semantics is quite right, so I am
JCH> holding it off from putting it in git-jc repository for now, but
JCH> please review it, give it a try and tell me what you think.

Ok, I have two updates pushed out at git-jc archive at
http://members.cox.net/junkio/git-jc.git/

Here is the summary of what the changes do.

The first commit is to simply prevent Kay's situation from
happening from git-update-cache.

By default, git-update-cache refuses to:

 - add "path" when "path/file" exists.  That is, you cannot
   replace a directory with a file (or a symlink).

 - add "path/file" when "path" exists.  That is, you cannot
   replace a file (or a symlink) with a directory.

And the second commit introduces --replace option to the
command.  When --replace is in effect, instead of refusing, the
existing path that conflicts with whatever is being added is
dropped with a warning message.  That means you would lose an
entire subdirectory from the index when you rename it and
replace it with a file and then call git-update-cache on it
(which is probably fine and what the user expects anyway).

Note that this is not enough to prevent nonsensical tree from
happening.  Three-way read-tree can be fed with an ancestor tree
that does not have anything interesting, one side adding "path"
(as a file) and the other side adding "path/file".  Just after
read-tree finishes reading three trees, you would have:

    100644 1 not-interesting
    100644 2 not-interesting
    100644 3 not-interesting
    100644 2 path
    100644 3 path/file

And all of these paths are candidate for trivial "collapsing to
stage 0" operation.  You would end up with path vs path/file
conflicts this way, so the previous change to write-tree to
prevent it from writing such a result is still needed.

Ideally the "collapsing to stage 0" logic could also be tweaked
to detect and prevent this from happening, but I'd rather keep
it simple for now (the tool should not be too clever).  The user
cannot write such a tree, and when this kind of conflict
happens, essentially both heads being merged needs to be
examined and manual resolution is required anyway.


