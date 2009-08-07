From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 18:55:19 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061833130.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <4A7B5F4C.30102@gmail.com>
 <alpine.LFD.2.01.0908061559120.3390@localhost.localdomain> <alpine.LFD.2.01.0908061609340.3390@localhost.localdomain> <alpine.LFD.2.01.0908061709400.3390@localhost.localdomain> <4A7B83BC.1040606@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 03:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZEgZ-0000EB-AB
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbZHGBzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbZHGBzw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:55:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59093 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752441AbZHGBzv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 21:55:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n771tKUp027722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 18:55:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n771tJs7030720;
	Thu, 6 Aug 2009 18:55:20 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7B83BC.1040606@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125158>



On Fri, 7 Aug 2009, Artur Skawina wrote:
> 
> I also see 44 extra lea instructions, 44 less adds

add and lea (as long as the lea shift is 1) should be the same on a P4 
(they are not the same on some other microarchitectures and lea can have 
address generation stalls etc).

Lea, of course, gives the potential for register movement at the same time 
(three-address op), and that's likely the reason for lea-vs-adds.

> and changes like:
>         [...]
>         mov    XX(%eRX),%eRX
>         xor    XX(%eRX),%eRX
> -       and    %eRX,%eRX
> +       and    XX(%eRX),%eRX

Yeah, different spill patterns. That's the biggest issue, I think.

In particular, on P4, with unlucky spills, you may end up with things like

	ror $2,reg
	mov reg,x(%esp)
	.. a few instructions ..
	xor x(%esp), reg

and the above is exactly when one of the worst P4 problems hit: a store, 
followed a few cycles later by a load from the same address (and "a few 
cycles later" can be quite a few instructions if they are the nice ones).

What can happen is that if the store data isn't ready yet (because it 
comes from a long-latency op like a shift or a multiply), then you hit a 
store buffer replay thing. The P4 (with its long pipeline) basically 
starts the load speculatively, and if anything bad happens for the load 
(L1 cache miss, TLB miss, store buffer fault, you name it), it will cause 
a replay of the whole pipeline.

Which can take tens of cycles. 

[ That said, it's been a long time since I did a lot of P4 worrying. So I 
  may mis-remember the details. But that whole store buffer forwarding had 
  some really nasty replay issues ]

> which could mean that gcc did a better job of register allocation
> (where "better job" might be just luck).

I suspect that's the biggest issue. Just _happening_ to get the spills so 
that they don't hurt. And with unlucky scheduling, you might hit some of 
the P4 replay issues every single time.

There are some P4 optimizations that are simple:
 - avoid complex instructions
 - don't blow the trace cache
 - predictable branches
but the replay faults can really get you.

			Linus
