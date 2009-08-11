From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 08:43:21 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908110810410.3417@localhost.localdomain>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain> <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatW3-0006WM-GL
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbZHKPns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 11:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbZHKPns
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:43:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60029 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751699AbZHKPnr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 11:43:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BFhLck005814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Aug 2009 08:43:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BFhL2g005575;
	Tue, 11 Aug 2009 08:43:21 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125574>



On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> 
> BLK_SHA1:	 5.280s		[original]
> BLK_SHA1:	 7.410s		[with SMALL_REGISTER_SET defined]
> BLK_SHA1:	 7.480s		[with 'W(x)=(val);asm("":"+m" (W(x)))']
> BLK_SHA1:	 4.980s		[with 'W(x)=(val);asm("":::"memory")']
> 
> At this point the generated assembly is pretty slick.  I bet the full 
> memory barrier might help on x86 as well.

No, I had tested that earlier - single-word memory barrier for some reason 
gets _much_ better numbers at least on x86-64. We're talking

	linus            1.46       418.2
vs
	linus           2.004       304.6

kind of differences. With the "+m" it outperforms openssl (375-380MB/s).

The "volatile unsigned int *" cast looks pretty much like the "+m" version 
to me, but Arthur got a speedup from whatever gcc code generation 
differences on his P4.

The really fundamental and basic problem with gcc on this code is that gcc 
does not see _any_ difference what-so-ever between the five variables 
declared with

	unsigned int A, B, C, D, E;

and the sixteen variables declared with

	unsigned int array[16];

and considers those all to be 21 local variables. It really seems to think 
that they are all 100% equivalent, and gcc totally ignores me doing things 
like adding "register" to the A-E ones etc.

And if you are a compiler, and think that the routine has 21 equal 
register variables, you're going to do crazy reload sh*t when you have 
only 7 (or 15) GP registers. So doing that full memory barrier seems to 
just take that random situation, and force some random variable to be 
spilled (this is all from looking at the generated code, not from looking 
at gcc).

In contrast, with the _targeted_ thing ("you'd better write back into 
array[]") we force gcc to spill the array[16] values, and not the A-E 
ones, and that's why it seems to make such a big difference.

And no, I'm not sure why ARM apparently doesn't show the same behavior. Or 
maybe it does, but with an in-order core it doesn't matter as much which 
registers you keep reloading - you'll be serialized all the time _anyway_. 

			Linus
