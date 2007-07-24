From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 12:02:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707241144490.3607@woody.linux-foundation.org>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net>
 <200707241033.36509.robin.rosenberg.lists@dewire.com> <46A5BA87.50105@fs.ei.tum.de>
 <200707241134.31950.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDPfB-0007ax-4i
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 21:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbXGXTDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbXGXTDO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 15:03:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54006 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403AbXGXTDN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 15:03:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6OJ2DXS014932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jul 2007 12:02:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6OJ261q028140;
	Tue, 24 Jul 2007 12:02:06 -0700
In-Reply-To: <200707241134.31950.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=-4.731 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53630>



On Tue, 24 Jul 2007, Robin Rosenberg wrote:
>
> 27778 time(NULL)                        = 1185268822
> 27778 gettimeofday({1185268822, 953340}, NULL) = 0
> 
> Here CVS sleeps. The amount varies between invocations since it
> only sleeps enough for the seconds to wrap.
> 
> 27778 nanosleep({0, 46660000}, NULL)    = 0
> 27778 time(NULL)                        = 1185268823

Btw, this is *really* dangerous and buggy.

The reason? The CPU real-time clock is very different from whatever clock 
the filesystems may use.

Filesystems generally do not use the same clock as the CPU does. That's 
obviously true for things like networked filesystems, but it's actually 
true even for local filesystems (even on UP) because the CPU "realtime" 
clock rather expensive and much too exact for them. It does all the fancy 
NTP date correction etc, and it has all the complex code to actually make 
sure you don't get any time jumps etc.

So you should basically assume that all filesystems will use a clock that 
is *close*, but not synchronized with the real-time clock. You have NFS 
issues, but even locally you'd generally expect the local filesystem to be 
based on a simply clock that is updated by the timer tick, and is "close 
enough" to the realtime clock that you get with gettimeofday(). But *not* 
identical.

So if you sleep for one second, the filesystem times will update by one 
second, but if you try to *synchronize* to exactly one second, it's not at 
all certain that the *filesystem* clock will be synchronized to the same 
second! Time skew is simply a fact of life.

A really obvious example of this is NFS. Anybody who thinks that the NFS 
times are synchronized to the client real-time clock is just seriously 
mistaken. They may be close, but they won't be identical.

So I think CVS is simply buggy here. It assumes that "filesystem time" is 
the same as "CPU time", and while that sounds like an obvious assumption 
to make, if you think about it for even five seconds (the NFS case above), 
you realize that it's a totally *buggy* assumption.

In other words: if you want the timestamps on two files to be one second 
apart, you have to sleep one second in between writing them (or you have 
to set the time explicitly with "utimes()" or similar). Doing the 
"optimized sleep" simply DOES NOT WORK.

So CVS is buggy. Big surprise. Film at 11.

Btw, if anybody can think of a similar scenario in git, please holler. We 
shouldn't have those kinds of bugs.

So the things you generally can depend on:

 - *within* a single filesystem, the clocks should be comparable (ie you 
   can do "stat()" on two files, and compare the date-stamps between the 
   files).

 - the clocks should obviously be "close" to the local realtime. Time skew 
   is a fact of life, but if time skews by more than a big fraction of a 
   second, something is wrong. It's certainly still very possible (NFS 
   with clients not running NTP), but at least at that point a program can 
   validly say "badly maintained network, it's the users problem".

but depending on exact time syncronization is a really really bad idea.

		Linus
