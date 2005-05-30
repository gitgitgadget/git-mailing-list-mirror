From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Sun, 29 May 2005 17:50:39 -0700
Message-ID: <7vsm05bkps.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	<20050527192941.GE7068@cip.informatik.uni-erlangen.de>
	<7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
	<20050527195552.GA6541@cip.informatik.uni-erlangen.de>
	<7vu0kowho9.fsf@assigned-by-dhcp.cox.net>
	<20050527203227.GA11139@cip.informatik.uni-erlangen.de>
	<20050529230240.GB12290@cip.informatik.uni-erlangen.de>
	<20050529231053.GD12290@cip.informatik.uni-erlangen.de>
	<20050529231621.GE12290@cip.informatik.uni-erlangen.de>
	<20050529234606.GF12290@cip.informatik.uni-erlangen.de>
	<20050529235630.GG12290@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 02:49:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcYT9-0006FO-BS
	for gcvg-git@gmane.org; Mon, 30 May 2005 02:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVE3AvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 20:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVE3AvV
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 20:51:21 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54245 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261483AbVE3Aul (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 20:50:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530005041.QBTM7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 20:50:41 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050529235630.GG12290@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Mon, 30 May 2005 01:56:31 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Instead of inflicting a Perl script on us, maybe writing a
textual specification of what you want it to do would help to
clarify your thinking and help us understand the problem you are
trying to describe a lot better.  I think Linus publicly stated
he does not do Perl much.  I am OK with Perl but I'd rather
answer questions posed in a more reader-friendly manner, rather
than having to guess what the caller is expected to give this
"merge" sub, which you do not document well.

I think I've already asked you something quite similar when you
posted another part of your script for parsing the new diff-raw
format, which I responded with something like: "Without knowing
how this sub is supposed to be called, I think you are stripping
leading colon from a filename if there is one".  Anyhow.

Are you trying to implement an Octopus capable N-way merger?
If so, the way I would do would be something like this:

 - Accept N parameters, which are heads being merged.

 - Sanity check that given heads are commits, and N <= 16.

 - Initialize a set, HTM (heads to be merged), to contain all of
   the supplied heads.

 - Remove one commit from HTM, call it H0.

 - Initialize a variable, BASE, with H0.  This variable
   determines the base of the merge in the commit topology.

 - Initialize a variable, T, with tree associated with H0.  This
   variable holds the "current intermediate merge result" tree.

 - While HTM is not empty, loop over the following:

   - Remove one commit out of HTM; call it H1.

   - MB = git-merge-base BASE H1;

   - If MB is either BASE or H1, then you have a fast forward.
     Take either BASE or H1 that is not MB and update variable
     BASE with it, and update variable T with the tree
     associated with it.  Continue with the loop (i.e. Perl
     "next").

   - Run your usual read-tree -m MB T H1 and git-merge-cache; as
     Linus explained, if this step ends up involving any
     non-trivial merges, you should not do an Octopus.  So in
     such a case, if HTM is not empty yet, barf (i.e. Perl
     "die", or at least "last").

   - Do not touch your ${GIT-.git}/HEAD in any way at this
     moment.

   - Update variable T with git-write-tree of the resolved cache
     contents.

   - Update varaible BASE with MB.

   - Continue with the loop. 

 - We exited the loop by now.  HTM being empty means that T has
   the result of N-way merge.  Create a single commit object
   that has all the commits you have merged as its parents, and
   register T as its associated tree.  I would imagine recording
   that commit in ${GIT-.git}/HEAD is what the user usually
   wants but there may be use cases that it may not be
   appropriate (I do not do Porcelain so I do not know).

