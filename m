From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 16:25:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061609340.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <4A7B5F4C.30102@gmail.com>
 <alpine.LFD.2.01.0908061559120.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZCKo-0005ZV-Ec
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 01:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbZHFXZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 19:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbZHFXZN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 19:25:13 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53083 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbZHFXZM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 19:25:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76NPAgc018512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 16:25:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76NPAdU005699;
	Thu, 6 Aug 2009 16:25:10 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908061559120.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125139>



On Thu, 6 Aug 2009, Linus Torvalds wrote:
> 
> It was prescott that changed a lot (mostly for the worse - the shifter was 
> one of the few upsides of prescott, although increased frequency often 
> made up for the downsides).

Anyway, since you have a Northwood, I bet that the #1 issue for you is to 
spread out the shift instructions in a way that simply doesn't matter 
anywhere else.

In netburst, if I remember the details correcty, a "complex instruction" 
will basically get the trace cache from the microcode roms. I'm not sure 
how it interacts with the TC entries around it, but it's entirely possible 
that it basically disables any instruction scheduling (the microcode 
traces are presumably "pre-scheduled"), so you'd basically see stalls 
where there's little out-of-order execution.

That then explains why you see huge differences from what is basically 
trivial scheduling decisions, and why some random placement of a shift 
makes a big difference.

Just out of curiosity, does anything change if you change the

	B = SHA_ROR(B,2)

into a

	B = SHA_ROR(SHA_ROR(B,1),1)

instead? It's very possible that it becomes _much_ worse, but I guess it's 
also possible in theory that a single-bit rotate ends up being a simple 
instruction and that doing two single-bit ROR's is actually faster than 
one 2-bit ROR (assuming the second one is microcoded and the first one).

In particular, I'm thinking about the warnign in the intel optimization 
manual:

	The rotate by immediate and rotate by register instructions are 
	more expensive than a shift. The rotate by 1 instruction has the 
	same latency as a shift.

so it's very possible that "rotate by 1" is much better than other 
rotates.


			Linus
