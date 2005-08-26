From: Junio C Hamano <junkio@cox.net>
Subject: Re: Storing state in $GIT_DIR
Date: Thu, 25 Aug 2005 21:31:42 -0700
Message-ID: <7v3boxl3o1.fsf@assigned-by-dhcp.cox.net>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	<Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	<46a038f905082518306e9d7d2a@mail.gmail.com>
	<Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
	<46a038f90508252115415acc04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 07:59:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8VtA-0003Wl-2n
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 06:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVHZEbq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 00:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVHZEbq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 00:31:46 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10972 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751498AbVHZEbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 00:31:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826043143.ZROB19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 00:31:43 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508252115415acc04@mail.gmail.com> (Martin Langhoff's
	message of "Fri, 26 Aug 2005 16:15:37 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7790>

Martin Langhoff <martin.langhoff@gmail.com> writes:

>> In other words, if you just have a "last commit" pointer in your
>> meta-data, then git is _by_definition_ in sync. There's never anything to
>> get out of sync, because objects aren't going to change.
>
> Hmmm. That repo is in sync, but there are no guarantees that they will
> travel together to a different repo. In fact, the push/pull
> infrastructure wants to push/pull one head at a time.

Wrong as of last week ;-), and definitely wrong since this morning.

> And if they are not in sync, I have no way of knowing. Hmpf. I lie:
> the arch metadata could keep track of what it expects the last head
> commits to be, and complain bitterly if something smells rotten.

What Linus suggests is doable by using an object that can hold
a pointer to at least one commit---you used that to record the
head commit of the corresponding git branch that the arch
metainfo represents.

You only pull arch metainfo branch; the objects associated with
the corresponding git branch head will be pulled together when
you pull it.  You do not have to tell git to pull git-part of
the commit chain.  There is no need to worry about version skew
when you use git this way.

Now, among the existing object types, there are only two kinds
of objects you can use for this.  If the only thing you need to
record is some textual information with one pointer to git
branch head, then you can use tag that points at the git head,
and store everything else as the tag comment.  This is doable
but unwieldy.

You could abuse a commit object as well; you store commit
objects (such as the corresponding git branch head) as parent
commits, and put everything else in a tree that is associated
with that commit.
