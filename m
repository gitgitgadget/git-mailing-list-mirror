X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Using git as a general backup mechanism
Date: Tue, 12 Dec 2006 15:43:03 -0800
Message-ID: <7vfybkof3s.fsf@assigned-by-dhcp.cox.net>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
	<Pine.LNX.4.64.0612111837210.20138@iabervon.org>
	<8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
	<200612121553.37499.andyparkins@gmail.com>
	<457F31E6.8090701@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 23:43:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457F31E6.8090701@midwinter.com> (Steven Grimm's message of "Tue,
	12 Dec 2006 14:49:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34168>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuHHB-0007DQ-Tz for gcvg-git@gmane.org; Wed, 13 Dec
 2006 00:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932559AbWLLXnH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWLLXnH
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 18:43:07 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45297 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932559AbWLLXnF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 18:43:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212234303.DKKU4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 18:43:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xzjE1V0191kojtg0000000; Tue, 12 Dec 2006
 18:43:15 -0500
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> What would be great for this would be to store each day's backup as a
> git revision; with a periodic repack, this would be much more
> space-efficient than the rsync hard links.
>
> The problem is that while that would give me a very efficient backup
> scheme, the repository would still grow over time. In rsync land, I
> solve the disk space issue by keeping two weeks' worth of daily
> snapshots, then six months' worth of weekly snapshots, then two years'
> worth of monthly snapshots; files that change daily have a constant
> number of revisions stored in my backups, and older files drop off the
> backup disk as they age.

Why not use N independent branches?  I'd illustrate only with
two levels below, but you could:

 (0) make a full tree snapshot.  Store the commit in 'daily'
     branch as its tip.

 (1) A new day comes.  Create an empty branch 'daily' if you
     do not already have one.  Make a full tree snapshot, and
     create a parentless commit for the day if the 'daily'
     branch did not exist, or make it a child of the 'daily'
     commit from the previous day if the branch existed.

 (2) End of week comes.  Create an empty branch 'weekly' if you
     do not already have one.  Make a full tree snapshot, and
     create a parentless commit for the week if the 'weekly'
     branch did not exist, or make it a child of the 'weekly'
     commit from the last week.  Discard 'lastweek' branch if
     you have one, and rename 'daily' branch to 'lastweek'.

At the end of month, you can rename 'weekly' to 'lastmonth'; if
you discard previous 'lastmonth' at this point, you essentially
made files older than two months drop off the backup disk.  You
can add more hierarchy with longer period to extend the scheme
ad infinitum.
