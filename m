From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 15:53:28 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908111550470.28882@localhost.localdomain>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain> <alpine.LFD.2.00.0908102246210.10633@xanadu.home> <alpine.LFD.2.01.0908110810410.3417@localhost.localdomain> <alpine.LFD.2.00.0908111437160.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0Et-0000pl-6b
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 00:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbZHKWye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 18:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbZHKWye
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 18:54:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50760 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754124AbZHKWye (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 18:54:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BMrUQN022672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Aug 2009 15:53:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BMrSFK032564;
	Tue, 11 Aug 2009 15:53:30 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0908111437160.10633@xanadu.home>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125612>



On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> 
> Well... gcc is really strange in this case (and similar other ones) with 
> ARM compilation.  A good indicator of the quality of the code is the 
> size of the stack frame.  When using the "+m" then gcc creates a 816 
> byte stack frame, the generated binary grows by approx 3000 bytes, and 
> performances is almost halved (7.600s).  Looking at the assembly result 
> I just can't figure out all the crazy moves taking place.  Even the 
> version with no barrier what so ever produces better assembly with a 
> stack frame of 560 bytes.

Ok, that's just crazy. That function has a required stack size of exactly 
64 bytes, and anything more than that is just spilling. And if you end up 
with a stack frame of 560 bytes, that means that gcc is doing some _crazy_ 
spilling.

One thing that strikes me is that I've been just testing with gcc-4.4, and 
BenH (who did some tests on PPC where SHA1 is just _trivial_ because it 
all fits in the normal register space) noticed that older versions of gcc 
that he tested did much worse on this.

I think Artur also posted (x86) numbers with older gcc versions doing 
worse. Maybe you're seeing some of that?

			Linus
