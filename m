From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 20:12:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171959180.3962@g5.osdl.org>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home> <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172140270.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergey Vlasov <vsu@altlinux.ru>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 05:12:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga1rF-0000zb-EB
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 05:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWJRDMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 23:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWJRDMi
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 23:12:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52651 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751224AbWJRDMh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 23:12:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9I3CFaX021437
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 20:12:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9I3CE8A017595;
	Tue, 17 Oct 2006 20:12:15 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610172140270.1971@xanadu.home>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29182>



On Tue, 17 Oct 2006, Nicolas Pitre wrote:
> 
> But there _is_ a flag for damn sake.  Did you at least try to understand 
> the code and not just skim over it from 10000 feet above?

I only looked at it from the patches, and the actual data structure, 
and they didn't have it, so..

> There is _no_ confusion possible.

Ok. Good.

> Does this mean that, with your own change to xdiff that has just been 
> committed, you actually created a "problem"?  Because this is a change 
> that creates different behaviors whether a 32-bit or 64-bit architecture 
> is used, Right?

If you go back to that discussion, I actually pointed out several times 
that the whole bug _was_ actually introduced exactly because the xdiff 
code used things that behave differently depending on word-size.

My suggestion for a _proper_ fix was to not use "unsigned long" for that, 
and the patch I suggested (and eventually got merged) was to use the _low_ 
bits of the hash, exactly because the low bits are the ones that act the 
same, regardless of wordsize.

> But of course not.  We want it to behave differently on 64-bit than 
> 32-bit.

No, we actually don't. Not for xdiff, at least. The last thing you want is 
for different architectures to get different results. It's horrible. It 
means that bugs are hard to reproduce, and it means that even code that is 
"tested" is actually tested only for a particular architecture.

So the bug in xdiff was _exactly_ that somebody - totally incorrectly - 
thought it should work "better" on 64-bits. 

> Please just try to understand why I'm claming this is not important in 
> this very case.  Please do me this favor.

Maybe the code is fine. Maybe the particular detail wasn't important. But 
the original code didn't have _any_ dependencies on things like structure 
alignment that caused it to do strange things. 

And dammit, the fact is, I think the new format is just worse. I think it 
was a good thing to have the full SHA1 in the pack-file. I think the code 
got less understandable, and had more special cases, just because now we 
have two totally different kinds of deltas. So maybe I'm reacting to the 
fact that I think the bug happened in the first place for a very simple 
reason: the data structure wasn't unambiguous any more. 

		Linus
