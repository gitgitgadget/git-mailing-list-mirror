From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linear time/space rename logic for *inexact* case
Date: Mon, 22 Oct 2007 17:49:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710221745160.30120@woody.linux-foundation.org>
References: <596909b30710220240g665054d8hc40bc5d2234ba9e1@mail.gmail.com> 
 <20071022103439.GA16648@coredump.intra.peff.net>
 <596909b30710221647y6a7481c5me41c31bbe1015e3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Andy C <andychup@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 02:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik7yC-0006HM-Kj
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 02:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbXJWAtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 20:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbXJWAtu
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 20:49:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37162 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753550AbXJWAtu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 20:49:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9N0neMo025326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Oct 2007 17:49:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9N0ndIx024263;
	Mon, 22 Oct 2007 17:49:40 -0700
In-Reply-To: <596909b30710221647y6a7481c5me41c31bbe1015e3a@mail.gmail.com>
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62064>



On Mon, 22 Oct 2007, Andy C wrote:
> 
> from diffcore-delta.c:
> "
>  * Idea here is very simple.
>  *
>  * Almost all data we are interested in are text, but sometimes we have
>  * to deal with binary data.  So we cut them into chunks delimited by
>  * LF byte, or 64-byte sequence, whichever comes first, and hash them.
> "
> 
> What is the similarity metric for binary files?  Is it related to the
> number of 64 byte chunks they have in common?  How do you know that
> the 64 byte chunks match up?  Suppose I have 10k file, and then I
> insert 10 random bytes at positions, 1000, 2000, 3000, etc.   How does
> that work?

The 'LF' byte will start a new window, so even with binary files (assuming 
some random-enough distribution that you have *some* 'LF' bytes!), you 
basically get a synchronization event on each LF.

So the 64-byte hunks "line up" automatically, even for binary files. Maybe 
not immediately, but soon enough (ie on average, assuming some reasonably 
compressed - ie virtually random - binary format) you should find a LF 
roughly every fourth hunk.

There are probably smarter ways to guarantee it even in the absense of 
certain bit-patterns, but I bet the "break every 64 bytes or when you see 
a LF" thing works well for any reasonable binary file too.

But text files are obviously the most important case. Diffs on binaries 
are somewhat hit-and-miss regardless.

			Linus
