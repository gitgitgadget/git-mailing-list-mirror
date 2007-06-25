From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Check for IO errors after running a command
Date: Mon, 25 Jun 2007 08:57:43 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706250837550.3593@woody.linux-foundation.org>
References: <87abuq1z6f.fsf@rho.meyering.net> <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
 <alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org>
 <7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com>
 <877ipsw2sz.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthias Lederhofer <matled@gmx.net>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 17:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2qxc-0006qs-QY
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 17:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbXFYP6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbXFYP6j
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 11:58:39 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48395 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752203AbXFYP6i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 11:58:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PFw0Ei004147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2007 08:58:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PFvh3n005446;
	Mon, 25 Jun 2007 08:57:50 -0700
In-Reply-To: <877ipsw2sz.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-3.058 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50903>



On Mon, 25 Jun 2007, Jim Meyering wrote:
> 
> That has the disadvantage of ignoring *all* pipe and socket write errors.

.. which is the only wayt to do it.

There's *no*way* to tell what the error was for the case of

	if (ferror(stdout))
		..

because the original errno has long long since been thrown away.

> Of course, one can probably argue that those are all unlikely.
> They may be even less likely than an actual EPIPE, but the point is
> that people and tools using git plumbing should be able to rely on
> it to report such write failures, no matter how unusual they are.

..but since what you suggest is physically impossible in a half-way 
portable manner, and since all relevant such errors are likely to have 
happened long before, I would suggest:

 - Use my patch

OR

 - Stop using stdio. 

   You *cannot* make stdio error handling sane. It's simply not possible. 
   The whole point of stdio is to simplify things, but it does so to the 
   point where portable and reliable error handling is not an option any 
   more.

   Replace all command output that you care about with some stdio 
   replacement. We do that for all the paths we *really* care about, where 
   we use raw unistd IO and do our own buffering (ie things like the 
   "write_in_full()" stuff and "write_sha1_file()" etc.

Anybody who thinks he can handle errors with stdio is simply barking up 
the wrogn tree. It can be done, but it can be done only by essentially 
making stdio be a really awkward way to do IO, and you're better off with 
the raw unistd.h interfaces.

In particular, you need to make sure you check *each* return value of 
every single stdio operation. Even then, you don't actually know if 
"errno" is set correctly if an error happens in the middle (ie most stdio 
routines are just defined to return EOF or nonzero on error, and it's not 
at all clear that errno is reliable).

If you don't, a buffer flush error may have happened at any time, and 
whatever error code it had has been thrown away, and turned into one 
single bit (the "ferror()" thing).

And yes, some libc's might have extensions that actually guarantee more. 
But even then I would be *very* surprised if they actually work and have 
been tested to any real degree (glibc does not. The stream error is a 
single bit. I checked)

So really: if you care about a particular read or write, use the 
"write_in_full()" and "read_in_full()" functions. NOTHING ELSE!

			Linus
