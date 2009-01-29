From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Valgrind updates
Date: Thu, 29 Jan 2009 15:22:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291514240.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
 <20090127131404.GA11870@sirena.org.uk> <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain> <alpine.DEB.1.00.0901272241250.14855@racer>
 <alpine.LFD.2.00.0901281751580.3123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: zlib@gzip.org, Mark Brown <broonie@sirena.org.uk>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:24:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXoS-0002yk-5J
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbZA2OWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbZA2OWj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:22:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:53081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752339AbZA2OWi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:22:38 -0500
Received: (qmail invoked by alias); 29 Jan 2009 14:22:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 29 Jan 2009 15:22:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MPD9neyiMiDOHQ9God1RtGsXF1AcYDoSl5lcMmy
	jzoPR3beHGgcnk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0901281751580.3123@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107683>

Hi,

On Wed, 28 Jan 2009, Linus Torvalds wrote:

> On Tue, 27 Jan 2009, Johannes Schindelin wrote:
> > 
> > To help ye Gods, I put together this almost minimal C program:
> 
> This one is buggy.

Not exactly buggy.  Underexplained.

> > 	out = fopen("/dev/null", "w");
> > 	fwrite(compressed + 51, 51, 1, out);
> > 	fwrite(compressed + 51, 1, 1, stderr);
> > 	fflush(out);
> > 	fclose(out);
> 
> The problem is that the first argument to that first "fwrite()" is simply 
> wrong. It shouldn't be "compressed + 51", it should be just "compressed". 

Nope.  It should be "compressed + 51" to narrow down the issue, as 
valgrind does not complain about _any other_ offset.

Not even when that is _well_ after the 58 bytes deflate() says are 
available.

> As it is, you're writing 51 bytes, starting at 51 bytes in, and that's 
> obviously not correct (you only got 58 bytes from deflate()).

It is not, granted.  But I left it in for a purpose: to show that valgrind 
does not even bother to mention bytes we think should be invalid.

I thought that there might be a shortcut for /dev/null, so I changed the 
outfile to a real file, and it _still_ does not complain.

> So valgrind does complain about it, but for a perfectly valid reason.

Only it does not.  It complains about the write of 1 byte, not the write 
of 51.

But I know why: "out" is opened buffered, so it shows the error (well 
delayed, I might add, and not in a helpful manner) when fflush() is 
called.

The real issue, namely that an access of offset 51 triggers a valgrind 
error, is demonstrated by my small test case.

Ciao,
Dscho
