From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 16:42:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061625300.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <alpine.LFD.2.01.0908061531310.3390@localhost.localdomain>
 <4A7B64F1.2000309@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:42:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZCb7-0002ie-TP
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 01:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbZHFXmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 19:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755715AbZHFXmF
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 19:42:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33239 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754670AbZHFXmE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 19:42:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76Ng2rn019702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 16:42:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76Ng1Fo001630;
	Thu, 6 Aug 2009 16:42:01 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7B64F1.2000309@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125143>



On Fri, 7 Aug 2009, Artur Skawina wrote:
> 
> Actually that's even more of a reason to make sure the code doesn't suck :)
> The difference on less perverse cpus will usually be small, but on P4 it
> can be huge.

No. First off, the things you have to do on P4 are just insane. See the 
email I just sent out asking you to test whether two 1-bit rotates might 
be faster than 1 2-bit rotate.

So optimizing for P4 is often the wrong thing.

Secondly, P4's are going away. You may have one, but they are getting 
rare. So optimizing for them is a losing proposition in the long run.

> A few years back I found my old ip checksum microbenchmark, and when I ran
> it on a P4 (prescott iirc) i didn't believe my eyes. The straightforward 
> 32-bit C implementation was running circles around the in-kernel one...
> And a few tweaks to the assembler version got me another ~100% speedup.[1]

Yeah, not very surprising. The P4 is very good at the simplest possible 
kind of code that does _nothing_ fancy.

But then it completely chokes on some code. I mean _totally_. It slows 
down by a huge amount if there is anything but the most trivial kinds of 
instructions. And by "trivial", I mean _really_ trivial. Shifts (as in 
SHA1), but iirc also things like "adc" (add with carry) etc.

So it's not hard to write code that works well on other uarchs, and then 
totally blow up on P4. I think it doesn't rename the flags at all, so any 
flag dependency (carry being the most common one) will stall things 
horrible.

There's also a very subtle store forwarding failure thing (and a lot of 
other events) that causes a nasty micro-architectural replay trap, and 
again you go from "running like a bat out of hell" to "slower than a i486 
at a tenth the frequency".

Really. It's disgusting. Perfectly fine code can run really slowly on the 
P4 just because it hits some random internal micro-architectural flaw. And 
there's a _lot_ of those "glass jaw" issues.

The best way to avoid them is to use _only_ simple ALU instructions (add, 
sub, and/or/not), and to be _very_ careful with loads and stores. 

		Linus
