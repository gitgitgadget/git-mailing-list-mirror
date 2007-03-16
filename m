From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 18:04:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 02:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS0rj-000090-AF
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 02:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbXCPBEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 21:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbXCPBEQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 21:04:16 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47482 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbXCPBEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 21:04:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2G14EcD032028
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 18:04:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2G14EV8031565
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 17:04:14 -0800
X-Spam-Status: No, hits=-0.487 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42308>


I looked at git profiles yesterday, and some of them are pretty scary. We 
spend about 50% of the time under some loads in just zlib uncompression, 
and when I actually looked closer at the zlib sources I can kind of 
understand why. That thing is horrid.

The sad part is that it looks like it should be quite possible to make 
zlib simply just perform better. The profiles seem to say that a lot of 
the cost is literally in the "inflate()" state machine code (and by that I 
mean *not* the code itself, but literally in the indirect jump generated 
by the case-statement).

Now, on any high-performance CPU, doing state-machines by having

	for (;;)
		switch (data->state) {
			...
			data->state = NEW_STATE;
			continue;
		}

(which is what zlib seems to be doing) is just about the worst possible 
way to code things.

Now, it's possible that I'm just wrong, but the instruction-level profile 
really did pinpoint the "look up state branch pointer and jump to it" as 
some of the hottest part of that function. Which is just *evil*. You can 
most likely use direct jumps within the loop (zero cost at all on most OoO 
CPU's) most of the time, and the entry condition is likely quite 
predictable too, so a lot of that overhead seems to be just sad and 
unnecessary.

Now, I'm just wondering if anybody knows if there are better zlib 
implementations out there? This really looks like it could be a noticeable 
performance issue, but I'm lazy and would be much happier to hear that 
somebody has already played with optimizing zlib. Especially since I'm not 
100% sure it's really going to be noticeable..

		Linus
