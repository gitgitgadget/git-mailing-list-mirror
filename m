From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Mon, 1 Apr 2013 22:30:25 -0400
Message-ID: <20130402023024.GB719@sigill.intra.peff.net>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
 <1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
 <20130401233313.GB30935@sigill.intra.peff.net>
 <CAMP44s0uJ4ivNLw984CXWYk5HcKevuUJmpYOiyqbT1QJDaYd0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 04:31:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMr05-0001H3-7W
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 04:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182Ab3DBCa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 22:30:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51542 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757146Ab3DBCa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 22:30:28 -0400
Received: (qmail 4839 invoked by uid 107); 2 Apr 2013 02:32:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Apr 2013 22:32:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2013 22:30:25 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0uJ4ivNLw984CXWYk5HcKevuUJmpYOiyqbT1QJDaYd0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219731>

On Mon, Apr 01, 2013 at 06:12:45PM -0600, Felipe Contreras wrote:

> > Checking asynchronously for death like this is subject to a rac
> > condition; the helper may be about to die but not have died yet. In
> > practice we may catch some cases, but this seems like an indication that
> > the protocol is not well thought-out. Usually we would wait for a
> > confirmation over the read pipe from a child, and know that the child
> > failed when either:
> >
> >   1. It tells us so on the pipe.
> >
> >   2. The pipe closes (at which point we know it is time to reap the
> >      child).
> >
> > Why doesn't that scheme work here? I am not doubting you that it does
> > not; the import helper protocol is a bit of a mess, and I can easily
> > believe it has such a problem. But I'm wondering if it's possible to
> > improve it in a more robust way.
> 
> The pipe is between fast-export and the remote-helper, "we"
> (transport-helper) are not part of the pipe any more. That's the
> problem.

So in fetch_with_import, we have a remote-helper, and we have a
bidirectional pipe to it. We then call get_importer, which starts
fast-import, whose stdin is connected to the stdout of the remote
helper. We tell the remote-helper to run the import, then we wait for
fast-import to finish (and complain if it fails).

Then what? We seem to do some more work, which I think is what causes
the errors you see; but should we instead be reaping the helper at this
point unconditionally? Its stdout has presumably been flushed out to
fast-import; is there anything else for us to get from it besides its
exit code?

-Peff
