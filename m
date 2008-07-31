From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3-wip] revision traversal: show full history with merge
 simplification
Date: Thu, 31 Jul 2008 15:26:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311513020.3277@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com> <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain> <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org> <7vej5b3ozz.fsf@gitster.siamese.dyndns.org> <7vhca6zcuy.fsf@gitster.siamese.dyndns.org> <7vabfxyacx.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 00:30:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgfR-0007an-86
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 00:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbYGaW3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 18:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbYGaW3j
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 18:29:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37323 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753633AbYGaW3j (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 18:29:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VMTHs9001926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 15:29:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VMTGLS015939;
	Thu, 31 Jul 2008 15:29:17 -0700
In-Reply-To: <7vabfxyacx.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.906 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91008>



On Thu, 31 Jul 2008, Junio C Hamano wrote:
> 
> The same query with 's/| head -n 1/>/dev/null' is more expensive.  In fact
> it is much more expensive than the non-incremental one (v2), and about
> three times more expensive than non-limiting --full-history for explaining
> the history of kernel/printk.c.

Hmm? Why is that, exactly? Does it walk over the same commit over and over 
and over again or something?

Can you combine --simplify-merges and --topo-order to get a fast version 
again (since --topo-order will force a non-incrmental walk)?

I have this suspicion (gut feel only, not anything else to back it up) 
that for any complex global history, you'll always end up having a lot of 
merges "live" and have a hard time getting a lot of early output. 

That may be why you get a fairly big delay before even the first commit:

> $ time sh -c 'git log --pretty=oneline --abbrev-commit \
>        --simplify-merges --parents \
>        -- kernel/printk.c | head -n 1'
> 5dfb66b... 1d9b9f6... c9272c4... Merge branch 'for-linus' of git://git.o-hand.com/linux-mfd
>
> real    0m0.344s
> user    0m0.324s
> sys     0m0.020s

>From your previous email:

   $ git rev-list --parents --full-history --topo-order HEAD -- kernel/printk.c
   3.75user 0.47system 0:04.22elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k

so that's less than 10% of the whole time, but it's still a _lot_ slower 
than the

   $ git rev-list --parents --full-history HEAD -- kernel/printk.c | head -n 200
   0.16user 0.02system 0:00.18elapsed 103%CPU (0avgtext+0avgdata 0maxresident)k

and that was the first 200 commits, not just the first one.  I bet you got 
the first one in about a tenth of that time - so I'm guessing 0.016s (also 
based on my own testing - it's below 0.01s here, but I'm willing to bet my 
machine is faster than yours is).

So getting the first one with "--simplify-merges" was really a _lot_ 
slower.

That said, I'm a huge beliver in the incremental approach - it just looks 
like this is potentially "just barely incremental" in practice.

Of course, with a more linear history than the kernel, your approach 
probably works better.

			Linus
