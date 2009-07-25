From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 11:04:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
References: <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724234648.GA4616@Pilar.aei.mpg.de>
 <20090725004122.GA28477@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:05:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUlcT-0002ru-Rw
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbZGYSFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbZGYSFH
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:05:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38792 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522AbZGYSFG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 14:05:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PI4UI7005587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Jul 2009 11:04:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6PI4Tc1015138;
	Sat, 25 Jul 2009 11:04:30 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090725004122.GA28477@Pilar.aei.mpg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124031>



On Sat, 25 Jul 2009, Carlos R. Mafra wrote:
> 
> Ok, so I killed /usr/sbin/preload and did the tests again. The 
> results were much more stable, with average 0.40 vs 0.79
> (NO_CURL=1 being faster). The pagefaults were pretty stable too,
> (40major+654minor vs 12major+401minor). 
> 
> I will use NO_CURL=1 from now on!

I actually find it interesting that this whole NO_CURL issue is actually a 
lot more noticeable for me in the hot-cache case than all the other 'git 
branch' issues were.

I went back to a version a few days ago (before all the optimizations), 
and on my machine with a hot cache I get (for my kernel repo - I don't 
use branches there, but I have an old 'akpm' branch for taking a emailed 
patch series from Andrew):

	[torvalds@nehalem linux]$ time ~/git/git branch
	  akpm
	* master

	real	0m0.005s
	user	0m0.004s
	sys	0m0.000s

so it's five milliseconds. Big deal, fast enough, right?

Ok, so fast-forward to today, with the optimizations to builtin-branch.c:

	[torvalds@nehalem linux]$ time ~/git/git branch
	  akpm
	* master

	real	0m0.004s
	user	0m0.000s
	sys	0m0.004s

Woot! I shaved a millisecond off it by avoiding all those page faults and 
object lookups. Good, but hey, all that unnecessary lookup was just a 25% 
cost.

So let's build it with NO_CURL:

	[torvalds@nehalem linux]$ time ~/git/git branch
	  akpm
	* master

	real	0m0.002s
	user	0m0.000s
	sys	0m0.000s

Heh. The whole NO_CURL=1 thing is actually a _bigger_ optimization than 
anything else I did to git-branch. Cost of curl: 100%.

The difference in number of system calls and page faults is really quite 
staggering. System calls: 397->184, page faults: 619->293. Just from not 
doing that curl loading. No wonder performance actually doubles.

Now, I admit that 5ms vs 2ms probably doesn't really matter much, but 
dang, performance was a primary goal in git, so I'm a bit upset at how bad 
curl screwed us. Plus those things do add up when scripting things, and 
those 300+ page faults are basically true for _all_ git programs.

So it's not just 'git branch': doing 'git show' shows the exact same 
thing: 6ms -> 4ms, 448->235 system calls, and 1549->1176 page faults.

So curl really must die. It may not matter for the expensive operations, 
but a lot of scripting is about running all those "cheap" things that just 
add up over time.

			Linus
