From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to not download objects more than needed?
Date: Tue, 21 Feb 2006 13:32:02 -0800
Message-ID: <7vek1wwg8d.fsf@assigned-by-dhcp.cox.net>
References: <43FB6C42.5000208@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 22:32:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBf7A-0003TH-FX
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 22:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWBUVcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 16:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWBUVcF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 16:32:05 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:12433 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932780AbWBUVcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 16:32:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060221212912.TILY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 16:29:12 -0500
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16553>

Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> writes:

> I have a pecuilar, but common use case for git.
>
> I have linux-2.6 repository pulled and I'd like to download some branch
> (say, netdev-2.6), which uses many of the same objects,
> but not to get all the objects from the git server.
>
> I've already tried certain commands, but still can't do it,
> and my bandwidth isn't too happy about it.
>
> It seems to require some kind of HEAD rewinding,
> or maybe fetching to another branch, I don't know.
>
> Anyone cares to help?

It is not peculiar at all.  The tools already should do what you
want:

           o---o---o---...---o (netdev-2.6)
          /
         / < netdev forked some time ago.
        /
    ---o---o---o---o---...---o---o---o (linus tip)
               ^v2.6.16-rc3      ^v2.6.16-rc4 

Suppose the "global" ancestry graph was like the above.  And
netdev-2.6 has not been merged into Linus tree.

What you have, already pulled from Linus, is:

    ---o---o---o---o---...---o---o---o (linus tip)
               ^v2.6.16-rc3      ^v2.6.16-rc4 

And suppose what the netdev tree has is something like this:

           o---o---o---...---o (netdev-2.6)
          /
         / < netdev forked some time ago.
        /
    ---o---o---o
               ^v2.6.16-rc3

The point being that the netdev tree does not know about Linus
tip you have.

When you "git fetch git://.../netdev-2.6.git/", a program that
runs on your end (git-fetch-pack) and another program that runs
on the other end (git-upload-pack) discuss to find out what both
of you have in common.  Your side starts from Linus tip and go
backwards, telling the other end "I have this, I have that,
...".  At first, netdev side will not see what it knows about,
but after a while, it will see a commit both of you have
(i.e. where the branch forked from).  After they find that out,
your side tells the other side "I want your netdev-2.6 head".

The other side sends the objects needed to complete the chain up
to the requested head, assuming that your side has objects to
complete the common ancestor point (again, the fork point, but
it could be some revs after that if the graph looked like the
above picture).  Objects behind the fork point does not need to
be sent.
