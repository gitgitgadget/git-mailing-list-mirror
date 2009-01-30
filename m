From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Fri, 30 Jan 2009 11:22:58 -0500
Message-ID: <20090130162258.GA7065@sigill.intra.peff.net>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net> <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de> <20090130050925.GA18809@coredump.intra.peff.net> <alpine.DEB.1.00.0901301656290.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwAR-0002JN-HF
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZA3QXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbZA3QXD
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:23:03 -0500
Received: from peff.net ([208.65.91.99]:41983 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbZA3QXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:23:01 -0500
Received: (qmail 2849 invoked by uid 107); 30 Jan 2009 16:23:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 30 Jan 2009 11:23:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 11:22:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901301656290.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107842>

On Fri, Jan 30, 2009 at 04:58:25PM +0100, Johannes Schindelin wrote:

> > So either we don't care about http-push being consistent with send-pack,
> > and it is OK to have this feature in one but not the other. Or we do,
> > and we really need to clean up the current divergence.
> 
> I do not see how your patch to send-pack makes that divergence any 
> better, or for that matter, keeps it as bad as it is.

No, it makes it worse. My point was that I am not sure people actually
_care_ that much about the divergence.

> In other words, if you want to give the other protocols at least a 
> _chance_ to catch up, you definitely need the support for push --track in 
> builtin-push.c or at least in transport.c.

But neither of those places has the information to do it _right_. I
think the right thing to do is:

  1. factor out "generic" routines from send-pack, including status
     output formatting and tracking ref updating

  2. refactor http-push to use those routines, bringing it in line with
     send-pack

  3. add --track support in the same generic way, and hook it from both
     transports

I can try to work on this, but I'm not excited about major surgery to
http-push, which I don't have a working test setup for.  I can't bring
myself to care about refactoring rsync, given the recent deprecation
discussion.

If it is going to be added to push or transport, then the transport API
needs refactoring to actually pass out information on what happened
(specifically, how we expanded the refspecs into matching ref pairs).
And maybe that is a more sensible long-term solution, but it is going
involve a lot of changes, too.

-Peff
