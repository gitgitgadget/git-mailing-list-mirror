From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow setting default diff options via
	diff.defaultOptions
Date: Fri, 10 Apr 2009 04:01:55 -0400
Message-ID: <20090410080155.GB32195@coredump.intra.peff.net>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de> <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 10 10:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsBi9-0007Sk-Kh
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 10:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760319AbZDJIB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758441AbZDJIB6
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 04:01:58 -0400
Received: from peff.net ([208.65.91.99]:51238 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762408AbZDJIB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 04:01:57 -0400
Received: (qmail 24257 invoked by uid 107); 10 Apr 2009 08:01:58 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 10 Apr 2009 04:01:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Apr 2009 04:01:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116245>

On Thu, Apr 09, 2009 at 12:43:28PM +0200, Johannes Schindelin wrote:

> > > Now, it is easy to put a patch on top of my patch to support something 
> > > like --no-defaults.
> > 
> > No, it's not. We went over this in great detail earlier in the thread. 
> > If you want:
> > 
> >   git diff --no-defaults
> > 
> > then you basically have to parse twice to avoid the chicken-and-egg
> > problem.
> 
> So what?  We parse the config a gazillion times, and there we have to 
> access the _disk_.

But the first parse is only looking for "--no-defaults". So you need to:

  1. Understand the semantics of the other options to correctly parse
     around them (i.e., knowing which ones take arguments).

  2. Parse the arguments without actually respecting most of them, since
     they will be parsed again later.

This would actually be pretty easy if we had a declarative structure
describing each option (like parseopt-ified options do). But the diff
options are parsed by a big conditional statement.

Two ways to make it easier would be:

  1. You could loosen (1) above by assuming that --no-defaults will
     never appears as the argument to an option, and therefore any time
     you find it, it should be respected. Thus your first parse is just
     a simple loop looking for the option.

  2. You could loosen (2) above by assuming that all options are
     idempotent. I don't know whether this is the case (I think it
     isn't for all git options, but a cursory look shows that it may be
     for diff options).

-Peff
