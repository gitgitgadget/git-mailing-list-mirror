From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Tue, 22 Feb 2011 23:51:43 -0500
Message-ID: <20110223045143.GA11846@sigill.intra.peff.net>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie>
 <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 05:52:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps6hk-0007Su-4u
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 05:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab1BWEvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 23:51:52 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41110 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535Ab1BWEvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 23:51:51 -0500
Received: (qmail 8667 invoked by uid 111); 23 Feb 2011 04:51:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 04:51:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 23:51:43 -0500
Content-Disposition: inline
In-Reply-To: <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167673>

On Tue, Feb 22, 2011 at 11:30:41AM -0800, Junio C Hamano wrote:

> > It is one less thing to need to do when writing new code, and one less
> > thing to have silly textual conflicts on. It probably doesn't matter
> > that much, though; we don't actually add new files or commands all that
> > often.
> 
> Yeah, you would need to add an entry to the builtin command list yourself
> anyway, until we also autogenerate it, which I doubt will ever happen nor
> is necessarily a good idea.

You also have to add the declaration to builtin.h. It is kind of a
hassle to have to add it in three places (Makefile, command list, and
declaration) in addition to the actual code. But again, it's not like we
do this that often.

> > Speaking of Makefiles, one downside to all of this directory
> > segmentation is that you can't run "make" from the subdirectories.
> 
> I had an impression that "make -C lib/" would be one of the goals, iow,
> when we split the directory structure, the next step would be to split the
> top-level Makefile so that each directory is covered by its own Makefile,
> just like Documentation/ is already usable that way.

Ugh. I am not thrilled at the prospect of more recursive make. As it is
now, we have already dealt with bugs from the little bit of recursion
there is (e.g., propagating information between Makefiles) and weird
heisenbugs (I still occasionally get build failures on recursing into
the perl subdir during a parallel make). And then of course it's easy to
misuse; running "make" in t/ is not necessarily testing the latest
version. In my experience recursive make always comes with this sort of
flakiness.

Right now the actual C build process is entirely in the top-level
Makefile. I really like that I can trust it to handle dependencies
correctly, because it means I can bisect without resorting to "make
clean" for each step.

-Peff
