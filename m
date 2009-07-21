From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: three-way diff performance problem
Date: Tue, 21 Jul 2009 12:31:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907211225220.19335@localhost.localdomain>
References: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain> <7v7hy1g7vg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTL4F-0006gC-OL
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 21:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbZGUTb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 15:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbZGUTbz
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 15:31:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39275 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751973AbZGUTbz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 15:31:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LJVoGd023758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Jul 2009 12:31:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LJVood026466;
	Tue, 21 Jul 2009 12:31:50 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v7hy1g7vg.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123685>



On Tue, 21 Jul 2009, Junio C Hamano wrote:
> 
> What's that cmovne?

It's "conditional move if not equal".

So the source code is

                /* We cannot squash it with earlier one */
                for (lline = sline->lost_head;
                     lline;
                     lline = lline->next)
                        if (lline->parent_map & this_mask)
                                last_one = lline;

adn the compiler has generated this:

	loop:
		test   %r14,0x10(%rdx)
		cmovne %rdx,%rcx
		mov    (%rdx),%rdx
		test   %rdx,%rdx
		jne loop

from it. In the above, '%r14' contains this_mask, and '%rcx' contains 
'last_line' and '%rdx' contains 'lline'.

So:

 - test   %r14,0x10(%rdx)

   test "this_mask & lline->parent_map"

 - cmovne %rdx,%rcx

   "if the test above was non-zero, then last_one = lline"

 - mov    (%rdx),%rdx

   "lline = lline->next"

 - test   %rdx,%rdx

   "is lline NULL"

 - jne loop

   no, continue.

> The function append_lost() is the meat of combining.  When you have seen
> a hunk like this:
> 
>     @@ -l,k +m,n @@
>     -lost line
>     -another lost line
>      common line
>     +added line
> 
> We queue the lost lines in front of a surviving line (that is sline that
> points at "common line").  "lost line" and "another lost line" are stored
> in lline (lost line) and they are queued to sline->lost_head.

Right. And "sline->lost_head" is going to have over a _million_ entries.

So each time you add one, we'll traverse that loop a million times. For 
each new entry. End result: that loop gets executed on the order of a 
million million times. It doesn't help that the compiler made it be very 
efficient code ;(

			Linus
