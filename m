X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Using git as a general backup mechanism
Date: Thu, 14 Dec 2006 16:33:51 -0800
Message-ID: <7vwt4uxaj4.fsf@assigned-by-dhcp.cox.net>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
	<Pine.LNX.4.64.0612111837210.20138@iabervon.org>
	<8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
	<200612121553.37499.andyparkins@gmail.com>
	<457F31E6.8090701@midwinter.com>
	<7vfybkof3s.fsf@assigned-by-dhcp.cox.net>
	<4581DF3E.3070806@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 00:34:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4581DF3E.3070806@midwinter.com> (Steven Grimm's message of "Thu,
	14 Dec 2006 15:33:18 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34455>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv11S-0000gv-KQ for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751688AbWLOAdy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWLOAdy
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:33:54 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:48650 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751615AbWLOAdx (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 19:33:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215003352.SENP2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 19:33:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yoa31V00U1kojtg0000000; Thu, 14 Dec 2006
 19:34:04 -0500
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
>>  (2) End of week comes.  Create an empty branch 'weekly' if you
>>      do not already have one.  Make a full tree snapshot, and
>>      create a parentless commit for the week if the 'weekly'
>>      branch did not exist, or make it a child of the 'weekly'
>>      commit from the last week.  Discard 'lastweek' branch if
>>      you have one, and rename 'daily' branch to 'lastweek'.
>
> That sounds like it'd work, but doesn't it imply that the history of a
> given file in the backups is not continuous? That is, an old copy of a
> file on the "weekly" branch doesn't have any kind of ancestor
> relationship with the same file on the "daily" branch? While that's
> obviously no different than the current git-less situation where
> there's no notion of ancestry at all, it'd be neat if this backup
> scheme could actually track long-term changes to individual files.

You can keep them connected by rewriting history of bounded
number of commits.  When you start a new week, you would make
the Monday commit a child of the tip of weekly branch that
represents the latest weekly shapshot.  Then on Friday, the
history would show the 5 commits during the week and behind that
would be a sequence of commits with one-per-week granularity.
When you rotate the week's daily log out and the commit for
Monday is based on the weekly history you are going to toss out,
you may need to rebase that week's daily log branch.

Let's say your policy is to keep daily log for at least one week
and enough number of end-of-week weekly logs.  Let's say it is
week #2 right now.

                        Aooo... (week #2 daily)
                       /|
                ooooooB |  (week #1 daily)
               /        |
     o--------o---------C (end-of-week weekly log)

The first commit in this week's daily log (A) would have two
parents: last commit from daily log of week #1 (B), and the
latest commit on the end-of-week weekly log (C).  Most likely, B
and C would have exactly the same tree.  That way, you would
have at least 7 days of daily log; at the end of this week you
would have close to 14 days but "keeping at least one week" is
satisfied.

When starting the 3rd week, you will discard 1st week's log; you
would need to rewrite 7 days worth of commits from week #2,
because the first commit of week #2 should now only have one
parent (C), and you would forget the commit on the last day of
week #1 as its parent (B).  Which cascades through 7 commits you
made during week #2.  You are not changing any trees, so this
should be quite efficient.

Then the first daily commit of 3rd week would have two parents,
the commit at the end of week #2 daily branch (D), and a new
commit (E) at the tip of the end-of-week log.  Again, D and E
would have the identical trees.

                                o...... (week #3 daily)
                               /|
                        Aooo..D |  (week #2 daily)
                        |       |
 (week #1 daily - gone) |       |
                        |       |
     o--------o---------C-------E (end-of-week weekly log)
