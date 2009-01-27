From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Valgrind updates
Date: Tue, 27 Jan 2009 17:54:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
 <20090127131404.GA11870@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
X-From: git-owner@vger.kernel.org Tue Jan 27 17:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRrEO-0003Fu-W8
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 17:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbZA0Qym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 11:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbZA0Qym
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 11:54:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:43516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752309AbZA0Qyl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 11:54:41 -0500
Received: (qmail invoked by alias); 27 Jan 2009 16:54:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 27 Jan 2009 17:54:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WRG06us/WAFw9diEJcqqZdBW8nwZOdhS9SqowRi
	Rpc/xaiM+/Nocs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090127131404.GA11870@sirena.org.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107362>

Hi,

On Tue, 27 Jan 2009, Mark Brown wrote:

> On Tue, Jan 27, 2009 at 05:26:34AM +0100, Johannes Schindelin wrote:
> 
> > I suspected that zlib does something "cute" with alignments, i.e. that 
> > it writes a possibly odd number of bytes, but then rounds up the 
> > buffer to the next multiple of two of four bytes.
> 
> I don't recall anything along those lines in zlib but it does generate 
> warnings with valgrind which require overrides - it has at least one 
> unrolled loop which roll on beyond initialised memory (but keep within 
> memory that zlib knows it has allocated).  It rolls back the results of 
> the loop before producing output, but it's possible that some unused 
> bits in the stream may be derived from the results.

That is what I suspected, but the data contradict this:

- accesses to all offsets between 0 and 50 and 52 and 58 (one _more_ than 
  indicated as valid by stream.total_count!) do not trigger any message in 
  valgrind.

- access to offset 51, which is well _within_ the boundaries, and even 
  well outside the range of a stray alignment issue, _does_ trigger a 
  valgrind message.

So either valgrind gets it wrong (which I find rather unlikely), or zlib 
really does not write to that offset.

Or, and I think that makes most sense so far, valgrind has not really 
ignored the initialization of byte number 52 in that buffer which partly 
depended on an uninitialized value (but does not matter, maybe due to 
Huffman cutoff or something similar).

Come to think of it, the word "suppression" is probably a good indicator 
that valgrind never claimed it would mark the zlib buffer as properly 
initialized.

Sorry for the noise, then,
Dscho
