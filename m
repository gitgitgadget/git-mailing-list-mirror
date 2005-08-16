From: Junio C Hamano <junkio@cox.net>
Subject: Re: symlinked directories in refs are now unreachable
Date: Mon, 15 Aug 2005 23:25:16 -0700
Message-ID: <7vbr3yl7oz.fsf@assigned-by-dhcp.cox.net>
References: <1124073677.27393.15.camel@della.draisey.ca>
	<7v64u7941c.fsf@assigned-by-dhcp.cox.net>
	<1124089116.749.39.camel@della.draisey.ca>
	<1124171194.762.74.camel@della.draisey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 08:26:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ut3-0006la-OM
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 08:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbVHPGZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 02:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVHPGZT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 02:25:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:1936 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932602AbVHPGZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 02:25:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816062517.UCCB16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 02:25:17 -0400
To: Matt Draisey <mattdraisey@sympatico.ca>
In-Reply-To: <1124171194.762.74.camel@della.draisey.ca> (Matt Draisey's
	message of "Tue, 16 Aug 2005 01:46:34 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matt Draisey <mattdraisey@sympatico.ca> writes:

> On Sun, 2005-08-14 at 22:12 -0700, Junio C Hamano wrote:
>> I would like to know
>> a use case or two to illustrate why there are symlinks pointing
>> at real files outside .git/refs/ hierarchy, and how that
>> arrangement is useful.
>...
> This email is a bit long-winded so I didn't CC it to the mailing list.

Thanks for a clear explanation.  Your arrangement indeed is an
intriguing one, in that there are very similar issues in the
fsck/prune area even with arrangements quite different from
yours.  I personally think your reasoning about this issue
deserves to be shared with the list.  I'll CC _this_ message to
the list and leave it up to you to forward your words there as
well.

People are known to do something similar to what you are doing
without having any special commit tool.  They just do this:

    $ mkdir A B
    $ cd A && git init-db
    $ cd ../B && git init-db
    $ rm -fr .git/objects && ln -s ../../A/.git/objects .git/objects

The repositories A and B share the same object database,
and they have independent sets of refs.  For the exact same
reason as your arrangement, you cannot "git prune" in either
repository, because they do not know about objects reachable
only from the other side.

Further, one repository can borrow objects from another
repository via the .git/objects/info/alternates mechanism.  This
is useful when a repository is a local clone of another.  You
would do this:

    $ git clone -l -s linux-2.6/.git/ my-linux
    $ cd my-linux && cat .git/objects/info/alternates
    /path/to/linux-2.6/.git/

The new repository my-linux has the .git/objects with 256
fan-out subdirectories, but starts out without any object files
in it.  It literally borrows the existing objects from the
neighbouring repository, and its own .git/objects hierarchy is
only used to hold newly created objects in it.  For the same
reason as your arrangement, you should not "git prune" the
linux-2.6 repository, either.  However, my-linux repository can
be pruned as long as somebody else does not "borrow" from it.

So while I find your "do follow symlink" patch an improvement in
that it makes things a little bit safer, I think there should be
a more generalized way to say "this object database holds things
that are refered by these refs/ directories outside.  fsck/prune
had better hold onto objects referenced by them, not just by the
refs directory that happens to be next to th objects directory".

That would be the inverse of .git/objects/info/alternates.

-jc
