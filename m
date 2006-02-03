From: Junio C Hamano <junkio@cox.net>
Subject: [Attn - repository browser authors] diff-tree combined format.
Date: Thu, 02 Feb 2006 21:49:11 -0800
Message-ID: <7v1wylkn54.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
	<7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 06:49:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4tor-0002Cc-Rw
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 06:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWBCFtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 00:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWBCFtO
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 00:49:14 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11940 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbWBCFtO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 00:49:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203054759.ZBLA20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 00:47:59 -0500
To: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Kay Sievers <kay.sievers@suse.de>
In-Reply-To: <7v64nxmhqn.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 02 Feb 2006 16:02:56 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15527>

Junio C Hamano <junkio@cox.net> writes:

> Before setting the output format in stone by having gitk
> interpret it, I'd like to do a quick sanity-check poll.

My current thinking is:

    (1) keep the index line, but format it like this:

	index d36904c,376f0fa..4fa6c16

	That is, parents separated with comma, double dots and
	the result.

    (2) match line numbers in the hunk header to normal diff's
        order:

	@@@ -1,87 -1,3 +1,93 @@@

	That is, counts for parents prefixed with '-', and
	the count for result prefixed with '+'.

If somebody has a strong feeling against the above please raise
your hand.

I said "poll" but I mistakenly dropped all the important /
affected people from the CC list, so in case you missed it, here
is a reproduction.  I think gitweb could also use combined diff
so I added Kay to the list.

> Len's merge is a bit too wide, so I'll use GIT 1.0.0 commit as
> an example.  Here is what I have right now.
>
>         $ git diff-tree --cc v1.0.0 -- debian/changelog | head -n 15
>         c2f3bf071ee90b01f2d629921bb04c4f798f02fa
>         diff --cc debian/changelog
>         index d36904c..376f0fa->4fa6c16
>         @@@ +1,93 -1,87 -1,3 @@@
>         ++git-core (1.0.0-0) unstable; urgency=low
>         ++
>         ++  * GIT 1.0.0
>         ++
>         ++ -- Junio C Hamano <junkio@cox.net>  Wed, 21 Dec 2005...
>         ++
>          +git-core (0.99.9n-0) unstable; urgency=low
>          +
>          +  * GIT 0.99.9n aka 1.0rc6
>          +
>          + -- Junio C Hamano <junkio@cox.net>  Wed, 14 Dec 2005...
>
> Two things to note.
>
>  * Somebody said he missed "index" lines.  There is one now, but
>    I am wondering if it might be just be an added noise.  It
>    gets absolutely horrible if you run diff-tree on Len's merge.
>    On the other hand, being able to cut&paste them to "git
>    cat-file blob" command line might be handy.
>
>    Do we want to keep it?
>
>    If we were to keep it, is the format OK?  It lists parent
>    blob names (double-dot separated), an arrow, and then result
>    blob name.  An alternative would be parent,parent..result,
>    like this:
>
>         index d36904c,376f0fa..4fa6c16
>
>    which might be more consistent with the normal ones.
>
>  * I show the line number from the result (+1,93) and then
>    parents' line numbers (-1,87 for the first parent, -1,3 for
>    the second parent).  To be consistent with the normal ones, I
>    am thinking it might be better to move the line number for
>    the result to the last.  One downside of that change is I
>    tend to use the line number of the result to look up the full
>    result more often than to use the line number of the parent,
>    and something like Len's merge would push the most important
>    line number off the edge of the screen.
>
>    Do we want to keep it the way it is, or do we want to do
>    this instead?
>
>         @@@ -1,87 -1,3 +1,93 @@@

To be complete, I'd also describe the rules for combined diff
text here.

1. Unlike normal unidiff that has one column prefix, this has N
   column prefix for N parents (usually 2 -- your branch and the
   other branch that is merged into it -- but more for an
   Octopus).  Column 1 talks about the first parent, column 2
   about the second, etc.

2. The hunk header starts and ends with N+1 (usually 2+1=3, more
   for an Octopus) '@' characters.

3. The column prefix is one of the following two shapes and a
   half:

   * one or more minus '-' and whitespace in others: the line
     does not appear in the result, and parents with '-' has
     it.

   * one or more plus '+' and whitespace in others: the line
     appears in the result, and parents without '+' has it.

   * all whitespace: the line appears in the result and all
     parents have it (this is a special case of the above).
