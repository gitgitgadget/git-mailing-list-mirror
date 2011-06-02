From: Jeff King <peff@peff.net>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Thu, 2 Jun 2011 15:29:27 -0400
Message-ID: <20110602192927.GA21262@sigill.intra.peff.net>
References: <loom.20110601T161508-689@post.gmane.org>
 <7vk4d5h3qt.fsf@alter.siamese.dyndns.org>
 <20110601173524.GF7132@sigill.intra.peff.net>
 <loom.20110601T210757-955@post.gmane.org>
 <loom.20110602T172442-653@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Randy Brandenburg <randy.brandenburg@woh.rr.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:29:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSDaJ-0000tj-Hb
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 21:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab1FBT3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 15:29:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35534
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab1FBT3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 15:29:30 -0400
Received: (qmail 30869 invoked by uid 107); 2 Jun 2011 19:29:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 15:29:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 15:29:27 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110602T172442-653@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174972>

On Thu, Jun 02, 2011 at 03:29:04PM +0000, Randy Brandenburg wrote:

> I rebuilt git-1.7.5 from source on the Solaris 9 platform with gcc-3.4.6, GNU 
> make 3.82, and GNU install (from coreutils 8.11). Following these steps
> 
> ----------------------------------------------------------------------------
> # ./configure CC=gcc

Hmm, I would have thought configure would set up most of what you needed
below, but it's possible our autoconf is not very complete (unlike many
projects, it's not necessary to use it to build).

> Edit the Makefile - set the path to "ar", "gcc" and GNU "install".
> CC = /usr/local/bin/gcc
> AR = /usr/ccs/bin/ar
> INSTALL = /usr/local/bin/install
> Look for ifeq ($(uname_S),SunOS) and set INSTALL to /usr/lcoal/bin/install

Rather than edit the Makefile, you can put these in "config.mak" which
is sourced automatically by the Makefile (after the defaults are set up,
so you can override them).

> # gmake NO_TCLTK=1 NO_CURL=1 NO_PTHREADS=YesPlease install prefix=/opt/sfw
> # git --version
> git version 1.7.5
> ----------------------------------------------------------------------------
> Preliminary testing indicates a working system -- will investigate thourough 
> today and tomorrow.

Great, I'm glad it's working. With NO_PTHREADS set, you will be
fork()ing off the sideband process instead of using a thread. So you
avoid pthreads altogether and it works, but you can't do multi-threaded
delta compression.

If you build without NO_PTHREADS set on a Solaris 9 box, does it work on
that same box? That would confirm or deny my ABI compatibility theory
(and hopefully point us in the right direction for the sunfreeware
people to build a binary that works on Solaris 9 and 10).

-Peff
