From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Thu, 27 Mar 2014 18:48:38 -0400
Message-ID: <20140327224837.GB32434@sigill.intra.peff.net>
References: <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
 <20140326212227.GC6991@hashpling.org>
 <20140326215741.GA17716@sigill.intra.peff.net>
 <20140326224616.GA9454@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:48:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJ6K-0007xw-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 23:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138AbaC0Wsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 18:48:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:48807 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755487AbaC0Wsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 18:48:39 -0400
Received: (qmail 4347 invoked by uid 102); 27 Mar 2014 22:48:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Mar 2014 17:48:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2014 18:48:38 -0400
Content-Disposition: inline
In-Reply-To: <20140326224616.GA9454@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245332>

On Wed, Mar 26, 2014 at 10:46:16PM +0000, Charles Bailey wrote:

> On Wed, Mar 26, 2014 at 05:57:41PM -0400, Jeff King wrote:
> > Hmm, so the year you got is actually: 1623969404. That still seems off
> > to me by a factor 20. I don't know if this is really worth digging into
> > that much further, but I wonder what you would get for timestamps of:
> > 
> >   99999999999999999
> >   9999999999999999
> >   999999999999999
> >   etc.
> > 
> 
> AIX goes negative at about the same time Linux and Solaris segfault:
> 
> 9999999 Sun Apr 26 10:46:39 1970 -0700
> 99999999 Sat Mar 3 02:46:39 1973 -0700
> 999999999 Sat Sep 8 18:46:39 2001 -0700
> 9999999999 Sat Nov 20 10:46:39 2286 -0700
> 99999999999 Wed Nov 16 02:46:39 5138 -0700
> 999999999999 Thu Sep 26 18:46:39 33658 -0700
> 9999999999999 Sun May 20 10:46:39 318857 -0700
> 99999999999999 Sat Nov 7 02:46:39 3170843 -0700
> 999999999999999 Sat Jul 4 18:46:39 31690708 -0700
> 9999999999999999 Sat Jan 25 10:46:39 316889355 -0700
> 99999999999999999 Wed Sep 6 02:46:39 -1126091476 -0700
> 999999999999999999 Thu Oct 24 18:46:39 1623969404 -0700

Thanks. Given the value where it fails, it kind of looks like there is
some signed 32-bit value at work (~300 million years is OK, but 10 times
that, rather than yielding ~3 billion, gets us -1 billion). Perhaps
tm.tm_year is 32-bit.

So what do we want to do? I think the options are:

  1. Try to guess when we have a bogus timestamp value with an arbitrary
     cutoff like "greater than 1 million years from now" (and enforce it
     via time_t seconds, and avoid gmtime entirely). That is made-up and
     arbitrary, but it also is sufficiently far that it won't ever
     matter, and sufficiently close that any gmtime should behave
     sensibly with it.

  2. Accept that we can't guess at every broken gmtime's output, and
     just loosen the test to make sure we don't segfault.

-Peff
