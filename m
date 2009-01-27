From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Valgrind updates
Date: Tue, 27 Jan 2009 05:46:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901270544450.14855@racer>
References: <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 05:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRfql-0000il-Vz
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 05:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbZA0Epe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 23:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbZA0Epe
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 23:45:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:51543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751372AbZA0Epd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 23:45:33 -0500
Received: (qmail invoked by alias); 27 Jan 2009 04:45:32 -0000
Received: from pD9EB30BF.dip0.t-ipconnect.de (EHLO noname) [217.235.48.191]
  by mail.gmx.net (mp071) with SMTP; 27 Jan 2009 05:45:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IYroLO0kIkhj9FCxU42eHenztXVcKNV0y7VLrp4
	AX69YkMFov7A9Z
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901270512171.14855@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107306>

Hi,

On Tue, 27 Jan 2009, Johannes Schindelin wrote:

> On Mon, 26 Jan 2009, Linus Torvalds wrote:
> 
> > On Tue, 27 Jan 2009, Johannes Schindelin wrote:
> > > 
> > > Just that much, most of the backtraces are pretty repetitive.  In 
> > > fact, I think most if not all of them touch xwrite.c (I got other 
> > > errors from my patches, as I expected).
> > > 
> > > ==valgrind== Syscall param write(buf) points to uninitialised byte(s)
> > > ==valgrind==    at 0x5609E40: __write_nocancel (in /lib/libpthread-2.6.1.so)
> > > ==valgrind==    by 0x4D0380: xwrite (wrapper.c:129)
> > > ==valgrind==    by 0x4D046E: write_in_full (wrapper.c:159)
> > > ==valgrind==    by 0x4C0697: write_buffer (sha1_file.c:2275)
> > > ==valgrind==    by 0x4C0B1C: write_loose_object (sha1_file.c:2387)
> > 
> > Looks entirely bogus.
> 
> And it gets worse.
> 
> I suspected that zlib does something "cute" with alignments, i.e. that 
> it writes a possibly odd number of bytes, but then rounds up the buffer 
> to the next multiple of two of four bytes.
> 
> Yet, the buffer in question is 195 bytes, stream.total_count (which 
> totally agrees with size - stream.avail_out) says it is 58 bytes, and 
> valgrind says that the byte with offset 51 is uninitialized.
> 
> So it is definitely a zlib error.  And a strange one at that.  Even 
> allowing for a header, if we have 51 valid bytes in the buffer 
> (remember: the 52nd byte is reported uninitialized by valgrind), even on 
> a 64-bit machine, it should not be rounded up to 58 bytes reported by 
> zlib.  And the address of the buffer seems to be even 16-byte aligned 
> (that's probably valgrind's doing).
> 
> Just for bullocks, I let valgrind check if offset 51 is the only 
> uninitialized byte (who knows what zlib is thinking that it's doing?), 
> and here's the rub: offset 51 is indeed the _only_ one which valgrind 
> thinks is uninitialized!
> 
> Wasn't there some zlib wizard in the kernel community?  We could throw 
> that thing at him, to see why it behaves so strangely...
> 
> Of course, it could also be a valgrind issue, as you suggested.  Hmpf.

FWIW this test was done with 3.4.0.SVN.

Just to be sure, I upgraded to 3.5.0.SVN, the very newest update (well, as 
new as I could make my git svn mirror of valgrind and VEX deliver).  Still 
there.

Off to bed,
Dscho
