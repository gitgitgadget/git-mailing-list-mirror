X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to show log for only one branch
Date: Sun, 05 Nov 2006 22:12:11 -0800
Message-ID: <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
References: <454EAEDB.8020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 06:12:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454EAEDB.8020909@gmail.com> (Liu Yubao's message of "Mon, 06 Nov
	2006 11:41:15 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30995>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgxiR-0002FG-S0 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 07:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423555AbWKFGMM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 01:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423564AbWKFGMM
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 01:12:12 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:44980 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1423555AbWKFGML
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 01:12:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061106061211.JWUT12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Mon, 6
 Nov 2006 01:12:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jJBp1V0011kojtg0000000 Mon, 06 Nov 2006
 01:11:49 -0500
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao <yubao.liu@gmail.com> writes:

> I have heard git treats all parents equally in a merge operation, so I
> am curious how git decides which parent is HEAD^1.

The first parent you see when you do "git cat-file commit HEAD"
is the HEAD^1, the second one is HEAD^2, etc.

With typical Porcelains (including git-core), when you make a
true merge by pulling another branch while on one branch, the
tip of the branch you were on when you initiated the merge
becomes the HEAD^1 of the resulting merge commit.

However, that does not mean HEAD^1 is any special in the global
history.  It is only locally special when viewed by you who did
the merge, and only immediately after you made the merge.  After
a while, even you yourself would feel less special about HEAD^1.

Imagine the following scenario.

 . You fork off from Linus's tip, and you do a great work on the
   kernel for a while.

         o---o---o---o Liu
        /
    ---o Linus

 . Linus's tip progresses, and there are semantically some
   overlapping changes; you merge from Linus to make sure your
   great work still works with the updated upstream.  This merge
   commit (marked '*' in the picture below) has _your_ last
   change as HEAD^1 and Linus's tip as HEAD^2.

         o---o---o---o---* Liu
        /               /
    ---o---o---o---o---o Linus

 . It still works great and you let Linus know about your great
   work.  He likes it and pulls from you.

At this point, the revision history would still look like this:

         o---o---o---o---* Liu = Linus
        /               /
    ---o---o---o---o---o

That is, the DAG did not change since you pulled from Linus.
The only thing that changed was that Linus's tip now points at
the merge commit _you_ made.

Then Linus keeps working, building commits on top of that merge.

                         Liu
         o---o---o---o---*---o---o---o---o Linus
        /               /
    ---o---o---o---o---o

Now, we can say two things about this history.

If you view the development community "centered around Linus",
then when somebody looks back the history from Linus's tip,
whatever great work you did, that is merely "one of the many
contributions from many people".  The "mainline" from this point
of view is still "what Linus saw at each point as the tip of his
development track", and among the commits you made (the ones
between the fork point and '*' in the above picture), the last
one, the merge you made was the only one that was once the tip
of Linus; everything else was "random work that happend in a
side branch".  But HEAD^1 is not special if you wanted to have
this view.

In massively parallel and distributed development, whose track
of development is "mainline" is not absolute, and it all depends
on what you are interested in when you do the archaeology.
Let's say that your work on the side branch was in one specific
area (say, a device driver work for product X), and nobody
else's work in that area appeared on Linus's development track
since you forked until your work was merged.

To somebody who is digging from Linus's tip in order to find out
how that driver evolved, your side branch is much more important
than what happened on Linus's branch (which everybody would
loosely say _the_ "mainline").  On the other hand, when somebody
is interested in some other area that was worked on in Linus's
development track while your work was done in the side branch,
following your development track is not interesting; and the
person who is interested in this "other area" could be you.  In
that case, you would want to follow Linus's development track.

What's mainline is _not_ important, and which parent is first is
even less so.  It solely depends on what you are looking for
which branch matters more.  Putting too much weight on the
difference between HEAD^1 vs HEAD^2 statically does not make any
sense.

Reflecting this view of history, git log and other history
traversal commands treat merge parents more or less equally, and
_how_ you ask your question affects what branches are primarily
followed.  For example, if somebody is interested in your device
driver work, this command:

	git log -- drivers/liu-s-device/

would follow your side branch.  On the other hand,

	git log -- fs/

would follow Linus's development track while you were forked, if
you did not do any fs/ work while on that side branch and
Linus's development track had works in that area, _despite_ the
merge you gave Linus has your development track as its first
parent.
