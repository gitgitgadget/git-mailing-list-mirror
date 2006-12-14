X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Using git as a general backup mechanism
Date: Thu, 14 Dec 2006 15:33:18 -0800
Message-ID: <4581DF3E.3070806@midwinter.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>	<Pine.LNX.4.64.0612111837210.20138@iabervon.org>	<8900B938-1360-4A67-AB15-C9E84255107B@mac.com>	<200612121553.37499.andyparkins@gmail.com>	<457F31E6.8090701@midwinter.com> <7vfybkof3s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 23:40:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 18:39:50 EST
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <7vfybkof3s.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34439>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0B8-0002kA-Jj for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751981AbWLNXjv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbWLNXjv
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:39:51 -0500
Received: from tater.midwinter.com ([216.32.86.90]:57286 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751981AbWLNXju
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 18:39:50 -0500
Received: (qmail 9697 invoked from network); 14 Dec 2006 23:33:08 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 14 Dec 2006 23:33:08
 -0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
>  (2) End of week comes.  Create an empty branch 'weekly' if you
>      do not already have one.  Make a full tree snapshot, and
>      create a parentless commit for the week if the 'weekly'
>      branch did not exist, or make it a child of the 'weekly'
>      commit from the last week.  Discard 'lastweek' branch if
>      you have one, and rename 'daily' branch to 'lastweek'.

That sounds like it'd work, but doesn't it imply that the history of a 
given file in the backups is not continuous? That is, an old copy of a 
file on the "weekly" branch doesn't have any kind of ancestor 
relationship with the same file on the "daily" branch? While that's 
obviously no different than the current git-less situation where there's 
no notion of ancestry at all, it'd be neat if this backup scheme could 
actually track long-term changes to individual files.

I wonder if rebasing can get me what I want. Something like:

(1) Make a new branch from the latest daily. Commit a full tree
    snapshot to the new branch. (Each branch has exactly one commit.)

(2) To expire a daily backup, rebase the second-oldest daily branch,
    which will initially be a child of the oldest daily branch, under
    the latest weekly branch instead. Delete the oldest daily branch.
    I believe the right commands here would be:

    git-rebase -s recursive -s ours --onto latest-weekly \
               oldest-daily second-oldest-daily
    git-branch -D oldest-daily

    (Not sure about the double "-s", but I want it to detect renames
    where possible and never flag any conflicts.)

(3) At the end of the week, instead of expiring the oldest daily
    branch, rename it to indicate that it's now a weekly snapshot.
    (That will implicitly do the first part of step 2, since the
    next daily branch in line will already be a descendant of the
    newly renamed branch.)

    Repeat step 2, rebasing against the latest monthly branch,
    to expire the oldest weekly.

(4) To expire an old monthly, rebase the second-oldest monthly branch
    under the initial empty revision, then delete the oldest monthly.
    This is basically step 2 again, but rebasing under a fixed starting
    point.

(5) Run git-prune to expire the objects in the deleted branches, then
    git-repack -a -d to delta-compress everything.

That's a bit convoluted, admittedly, and probably a perversion of 
everything pure about the branch system, but would it work? The big 
thing I'm not sure about here is whether, after doing my rebase and 
delete in step 2, the objects from the oldest daily will actually be 
removed by git-prune. They should be unreachable at that point, I think.

