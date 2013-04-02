From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] run-command: add new check_command helper
Date: Tue, 2 Apr 2013 01:26:30 -0400
Message-ID: <20130402052630.GB22089@sigill.intra.peff.net>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
 <1364852804-31875-2-git-send-email-felipe.contreras@gmail.com>
 <20130401232326.GA30935@sigill.intra.peff.net>
 <CAMP44s3NxBexkaQa=KxJ963L29T4BAn7e+-3YVz-vgUp8jrb4A@mail.gmail.com>
 <20130402022214.GA719@sigill.intra.peff.net>
 <CAMP44s3-DnBM7Tm_+igLN+c5MGrbJNXUBwcj1HvGCPEJEwJSBQ@mail.gmail.com>
 <20130402051407.GA21906@sigill.intra.peff.net>
 <CAMP44s3oVJs_sWpemFVGSkj-u_SrjsxE1mYja+Scx3PTBXC67Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 07:27:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtkM-0005BZ-Fu
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 07:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759951Ab3DBF0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 01:26:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51701 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759800Ab3DBF0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 01:26:33 -0400
Received: (qmail 6924 invoked by uid 107); 2 Apr 2013 05:28:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 01:28:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 01:26:30 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3oVJs_sWpemFVGSkj-u_SrjsxE1mYja+Scx3PTBXC67Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219741>

On Mon, Apr 01, 2013 at 11:22:36PM -0600, Felipe Contreras wrote:

> On Mon, Apr 1, 2013 at 11:14 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Apr 01, 2013 at 11:11:20PM -0600, Felipe Contreras wrote:
> >
> >> > But if we know from reading waitpid(3) that waitpid should only fail due
> >> > to EINTR, or due to bogus arguments (e.g., a pid that does not exist or
> >> > has already been reaped), then maybe something like this makes sense:
> >> >
> >> >   while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
> >> >           ; /* nothing */
> >>
> >> But we don't want to wait synchronously here, we just want to ping.
> >
> > Yeah, sorry, I forgot the WNOHANG there.
> 
> It still can potentially stay in a loop for some cycles.

That should be OK; it's the same loop we use in wait_or_whine (and that
is in fact how I managed to get the WNOHANG wrong, as I copied the loop
from there but forgot to update the flag variable).  A few cycles is OK,
as it is really about handling a simultaneous signal; it should be rare
that we loop at all, and even rarer to loop more than a single time. On
Linux, I don't think we will ever get EINTR at all, according to the
manpage; however, POSIX seems to allow EINTR even with WNOHANG.

-Peff
