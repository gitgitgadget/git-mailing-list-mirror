From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 23:44:01 -0400
Message-ID: <20160615034401.GA3013@sigill.intra.peff.net>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160614210038.31465-1-lfleischer@lfos.de>
 <xmqqbn338nu1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 05:44:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD1kQ-0003aC-DZ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 05:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbcFODoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 23:44:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:55007 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750771AbcFODoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 23:44:05 -0400
Received: (qmail 30467 invoked by uid 102); 15 Jun 2016 03:44:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 23:44:04 -0400
Received: (qmail 2808 invoked by uid 107); 15 Jun 2016 03:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 23:44:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 23:44:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbn338nu1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297351>

On Tue, Jun 14, 2016 at 02:25:42PM -0700, Junio C Hamano wrote:

> > Also, reorganize the overall control flow, remove some superfluous
> > variables and replace a custom implementation of strpbrk() with a call
> > to the standard C library function.
> 
> I find that calling the loop "a custom implementation" is a bit
> unfair.  The original tried to avoid looking beyond "len", but in
> the updated code because you have buf[len] = '\0' to terminate the
> line, and because you pass LARGE_PACKET_MAX to packet_read() while
> your buf[] allocates one more byte, you can use strpbrk() here
> safely. Which would mean "a custom implementation" was done for a
> reason.

Knowing we have a NUL at the end makes strpbrk() safe to use (as opposed
to walking off the end of the buffer). But what about the opposite case,
when there are embedded NULs in the data?

I think this case is already fairly broken by the use of "%s" specifiers
later in the function, and I doubt it is all that useful. So I am OK if
the answer is "we don't care, and do not even consider it a bug that
should be fixed".

-Peff
