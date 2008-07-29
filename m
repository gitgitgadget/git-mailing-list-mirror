From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 18:23:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org>
References: <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org> <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
 <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brown <git@davidb.org>, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 03:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNe0j-0005D2-VN
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 03:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbYG2B1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 21:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYG2B1I
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 21:27:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44452 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752160AbYG2B1H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 21:27:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T1Qt1t031425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 18:26:56 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T1Qsbl006711;
	Mon, 28 Jul 2008 18:26:54 -0700
In-Reply-To: <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.408 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90544>



On Mon, 28 Jul 2008, Junio C Hamano wrote:
> >
> > Anybody who uses extended attributes as part of a indexing scheme is just 
> > insane. Modifying the file you are indexing is not just fundamentally 
> > wrong to begin with, but it will then also be incredibly inefficient to 
> > read those entries one at a time.
> 
> It's a typo and you are saying it _is_ fundamentally wrong, aren't you?

Not a typo, and I'm sayin that "it's not _just_ fundamentally wrong"

So yes, it's fundamentally wrong, but it's worse than that. It's 
fundamentally wrong _and_ it's inefficient as hell.

> If you are prepared to pick up new files, you need to crawl everywhere
> anyway, so if the xattr is used to leave a mark "The last time I looked at
> this file was this" in the file itself, it does not sound too bad to me.

It's absolutely horrible. 

It means that you have another extra indirection and accompanying disk 
seek to check the thing. It's a total performance nightmare. Trust me, 
anybody who uses extended attributes like this simply does not know what 
he is doing.

> It would be irritating that it touches ctime, though, but I do not use it
> http://beagle-project.org/FAQ "Do I really need extended attributes?"
> talks about BEAGLE_DISABLE_XATTR environment variable and interestingly
> it says disabling use of xattr would slow you down.

They don't have a clue. They say that, but it's simply not true. 

Of course, the fact that they think it is probably implies that they did 
something EVEN MORE STUPID for the non-xattr case. That wouldn't surprise 
me at all. If I had to guess, I'd guess that they used an SQL database and 
query language, and did all their tests with hot caches too.

The kernel does caching really well, and the kernel is fast as hell, so 
_of_course_ when you benchmark, using kernel data structures looks good, 
especially if you benchmark against code that isn't well written for the 
particular usage case.

			Linus
