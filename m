From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 19:23:21 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061909310.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
 <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 04:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZF7N-00071P-1C
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 04:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbZHGCXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 22:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbZHGCXY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 22:23:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35307 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752166AbZHGCXX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 22:23:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n772NMMx029418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 19:23:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n772NLHH013075;
	Thu, 6 Aug 2009 19:23:21 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125162>



On Thu, 6 Aug 2009, Linus Torvalds wrote:

> 
> 
> On Thu, 6 Aug 2009, Artur Skawina wrote:
> > 
> > Does this make any difference for you? For me it's the best one so far
> > (the linusas2 number clearly shows that for me the register renaming does
> > nothing; other than that the functions should be very similar)
> 
> Nope. If anything, it's bit slower, but it might be in the noise. I 
> generally got 330MB/s with my "cpp renaming" on Nehalem (32-bit - the 
> 64-bit numbers are ~400MB/s), but with this I got 325MB/s twice in a row, 
> which matches the linusas2 numbers pretty exactly.

I actually found a P4 I have access to, except that one is a Prescott.

And I can't run it in 32-bit mode, because I only have a regular user 
login, and it only has the 64-bit development environment.

But I can do the hacked-for-64bit sha1bench runs, and I tested your patch.

It's horrible.

Here's the plain "linus" baseline (ie the "Do register rotation in cpp") 
thing, with the fixed "E += TEMP .." thing):

	#             TIME[s] SPEED[MB/s]
	rfc3174         1.648       37.03
	rfc3174         1.677        36.4
	linus          0.4018       151.9
	linusas        0.4439       137.5
	linusas2       0.4381       139.3
	mozilla        0.9587       63.66
	mozillaas      0.9434        64.7

and here it is with your patch:

	#             TIME[s] SPEED[MB/s]
	rfc3174         1.667       36.61
	rfc3174         1.644       37.12
	linus          0.4653       131.2
	linusas        0.4412       138.3
	linusas2       0.4388       139.1
	mozilla        0.9466       64.48
	mozillaas      0.9449       64.59

(ok, so the numbers aren't horribly stable, but the "plain linus" thing 
consistently outperforms here - and underperforms with your patch).

However, note that since this is the 64-bit thing, there likely aren't any 
spill issues, but it's simply an issue of "just how did the array[] 
accesses get scheduled" etc. And since this is a Prescott (or rather 
"Xeon") P4, the shifter isn't quite as horrible as yours is. _And_ this is 
a different gcc version (4.0.3).

So the numbers aren't really all that comparable. It's more an example of 
"optimizing for P4 is futile, because you're just playing with total 
randomness". That's like a 20MB/s difference, just from moving a few ALU 
ops around a bit.

And it's entirely possible that if I had gcc-4.4 on that machine, your 
patch would magically do the right thing ;)

Sadly, that machine is just a ssh gateway, so there's no real development 
tools on it at all - no way to get good profiles etc. So I can't really 
say exactly what the problem pattern is :(

		Linus
