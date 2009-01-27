From: Jeff King <peff@peff.net>
Subject: Re: Valgrind updates
Date: Mon, 26 Jan 2009 23:48:38 -0500
Message-ID: <20090127044838.GA735@coredump.intra.peff.net>
References: <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 05:50:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRftm-0001BZ-34
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 05:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbZA0Esm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 23:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZA0Esl
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 23:48:41 -0500
Received: from peff.net ([208.65.91.99]:51406 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbZA0Esl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 23:48:41 -0500
Received: (qmail 8698 invoked by uid 107); 27 Jan 2009 04:48:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 23:48:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 23:48:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107307>

On Mon, Jan 26, 2009 at 07:38:56PM -0800, Linus Torvalds wrote:

> > ==valgrind== Syscall param write(buf) points to uninitialised byte(s)
> > ==valgrind==    at 0x5609E40: __write_nocancel (in /lib/libpthread-2.6.1.so)
> > ==valgrind==    by 0x4D0380: xwrite (wrapper.c:129)
> > ==valgrind==    by 0x4D046E: write_in_full (wrapper.c:159)
> > ==valgrind==    by 0x4C0697: write_buffer (sha1_file.c:2275)
> > ==valgrind==    by 0x4C0B1C: write_loose_object (sha1_file.c:2387)
> 
> Looks entirely bogus.
> 
> I suspect that valgrind for some reason doesn't see the writes made by 
> zlib as being initialization, possibly due to some incorrect valgrind 
> annotations on deflate().  We've just totally initialized that whole 
> buffer with deflate().
> 
> It definitely does not look like a git bug, but a valgrind run issue.

Yes, this is exactly the issue I ran into when doing the valgrind stuff
a few months ago. I spent several hours looking carefully at the code
and came to the same conclusion. Anything zlib touches needs to be
manually suppressed for uninitialized writes (which I _thought_ was
covered in the suppressions I sent out originally, but maybe they need
to be tweaked for Dscho's system).

-Peff
