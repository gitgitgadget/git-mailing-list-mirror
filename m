From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Fri, 14 Nov 2008 15:10:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811141505100.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org> <7v63mq9iao.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 00:12:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L17pp-0000Oo-7T
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 00:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYKNXLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYKNXLA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:11:00 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55583 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505AbYKNXLA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 18:11:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAENAQg2030524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Nov 2008 15:10:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAENAODV014247;
	Fri, 14 Nov 2008 15:10:25 -0800
In-Reply-To: <7v63mq9iao.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.431 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101026>



On Fri, 14 Nov 2008, Junio C Hamano wrote:
> 
> If you have 1000 files in a single directory, do you still want 2 threads
> following the "1/500" rule, or they would compete reading the same
> directory and using a single thread is better off?

Well, first off, the "single directory" thing is really a Linux kernel 
deficiency, and it's entirely possible that it doesn't even exist on other 
systems. Linux has a very special directory cache (dcache) model that is 
pretty unique - it's part of why cached 'lstat()' calls are so cheap on 
Linux - but it is also part of the reason for why we serialize lookups 
when we do miss in the cache (*).

Secondly, anybody who has a thousand tracked files in a single directory 
can damn well blame themselves for being stupid. So I don't think it's a 
case that is worth worrying too much about. Git will slow down for that 
kind of situation for other reasons (ie a lot of the tree pruning 
optimization won't work for projects that have large flat directories).

So i wouldn't worry about it. That said, with the second patch, we default 
to having people enable this explicitly, so it's something that people can 
decide on their own.

			Linus

(*) That said - the Linux dcache consistency is just _one_ reason why we 
serialize lookups. I would not be in the least surprised if other OS's 
have the exact same issue. I'd love to fix it in Linux, but quiet 
honestly, it has never actually come up before now, and we've literally 
worked on multi-threading the _cached_ case, not the uncached one.
