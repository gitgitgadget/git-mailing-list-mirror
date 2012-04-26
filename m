From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Thu, 26 Apr 2012 09:01:29 -0400
Message-ID: <20120426130129.GA27785@sigill.intra.peff.net>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl>
 <20120414121358.GA26372@ecki>
 <20120414122127.GA31220@ecki>
 <4F8C3E0F.2040300@in.waw.pl>
 <20120416174230.GA19226@sigill.intra.peff.net>
 <20120416224424.GA10314@ecki>
 <20120419060326.GA13982@sigill.intra.peff.net>
 <4F8FB779.60004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 15:01:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNOKP-0003o2-Kw
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 15:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649Ab2DZNBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 09:01:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47141
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab2DZNBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 09:01:32 -0400
Received: (qmail 15849 invoked by uid 107); 26 Apr 2012 13:01:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Apr 2012 09:01:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Apr 2012 09:01:29 -0400
Content-Disposition: inline
In-Reply-To: <4F8FB779.60004@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196366>

On Thu, Apr 19, 2012 at 08:58:01AM +0200, Johannes Sixt wrote:

> > Hmm. Yeah, if you strace the cat, it gets an immediate EOF. And even
> > weirder, I notice this in the strace output:
> > 
> >   clone(...)
> >   close(0)                                = 0
> >   open("/dev/null", O_RDONLY)             = 0
> >   ...
> >   execve("/bin/cat", ["cat"], [/* 50 vars */]) = 0
> > 
> > What? The shell is literally redirecting the cat process's stdin from
> > /dev/null. I'm totally confused.
> 
> You don't have to be; it's mandated by POSIX:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_03_02

Sorry for the delayed response.

Thanks for the pointer; I looked in POSIX but couldn't find that
passage. It does say "In all cases, explicit redirection of standard
input shall override this activity". It looks like dash interprets that
as "open /dev/null, then open the redirected stdin". Which leaves a race
condition.  So I think a custom wrapper like the one posted by Clemens
is our only portable option.

As an aside, should git-daemon be respecting SIGPIPE at all? It seems
pointless at best, as it should be checking all of its writes, and a
liability at worst, as something like failing to log to stderr can kill
the whole process.

(Ignoring SIGPIPE would downgrade the severity of this problem, but I
 think we would still want Clemens' solution. Otherwise the error output
 in the test could be truncated).

-Peff
