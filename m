X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Wed, 22 Nov 2006 03:51:59 -0800
Message-ID: <7vy7q3snq8.fsf@assigned-by-dhcp.cox.net>
References: <20061117182157.GC11882@fieldses.org>
	<20061118001355.23488.qmail@science.horizon.com>
	<7virhdh9j8.fsf@assigned-by-dhcp.cox.net>
	<7vslghftix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 11:53:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vslghftix.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 17 Nov 2006 17:11:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32081>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmqe6-0006Ja-DL for gcvg-git@gmane.org; Wed, 22 Nov
 2006 12:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753013AbWKVLwD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 06:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbWKVLwB
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 06:52:01 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:32670 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1753013AbWKVLwA
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 06:52:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122115200.EOWX18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 22
 Nov 2006 06:52:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pns71V0081kojtg0000000; Wed, 22 Nov 2006
 06:52:07 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> If you want an esoteric topic for an introductory documentation,
> it would be more useful to talk about evil merges (an evil merge
> is a merge commit whose result does not match any of its
> parents).  A good example is found in
>
> 	git show v1.0.0

I actually remembered a better one.

        Subject: Necessity of "evil" merge and topic branches
        Date: Wed, 17 May 2006 23:25:55 -0700
        Message-ID: <7vy7wz6e8c.fsf@assigned-by-dhcp.cox.net>

This talks about a real-world evil merge and the reason why it
was necessary, and speculates a possible way to make life
easier.  I actually later used the "third branch to remember the
evil merge between two topics" technique I talked about in the
message to merge in another pair of topics, and it turned out
that it worked rather well.

There were two logically independent topics:

 - lt/setup.  Two commits, changing the calling convention of
   setup_git_directory() function -- the final tip of the topic
   was at a633fca0.

 - js/mv.  Three commits, making git-mv a built-in after
   refactoring some code from other parts of the system -- the
   final tip of the topic was at ac64a722).

They were not "obviously correct" when they started, so a topic
branch was used for each.  They had textually and semantically
some conflicts, and if they were to progress at different paces,
there was a need for an evil merge when the later one is merged
to master.

So I created another branch to merge the two topics together and
resolved their conflicts while my reading of their code were
still fresh.

	git checkout -b __/setup-n-mv js/mv
        git pull . lt/setup
	git checkout next
        git pull . __/setup-n-mv

Later js/mv became ready to be merged first.  So I merged it to
'master'.

	git checkout master
        git pull . js/mv

I was planning to cook lt/setup a bit longer but eventually
decided to merge it to 'master' as well after a short while.

	git checkout master
        git pull . __/setup-n-mv

I could have pulled lt/setup into master but then I would have
had to resolve the conflict between the two branches.  Since I
recorded the resolution earlier by making the merge, and pulled
that branch (which contained all of lt/setup already) into
'master', I did not have to remember what I need to adjust when
I did so.  If lt/setup had further updates on its own after the
"third branch __/setup-n-mv" was made, I would have then pulled
the tip of lt/setup into 'master' to complete the merge, and
that would have also resulted in non-conflicting simple merge.

This would have worked equally well if lt/setup were to graduate
first.

This might look too complex at the first look, but I thought it
might be an interesting topic in the "hints for managing your
topic branches" section.
