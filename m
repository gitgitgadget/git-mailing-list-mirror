From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as
 required
Date: Fri, 3 Jul 2015 14:07:19 -0400
Message-ID: <20150703180718.GB9223@peff.net>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com>
 <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <xmqq8uaz8vjb.fsf@gitster.dls.corp.google.com>
 <xmqq4mln8ve2.fsf@gitster.dls.corp.google.com>
 <20150702135309.GA18286@peff.net>
 <xmqq38155e3s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 20:07:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB5N2-0008TI-3v
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 20:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383AbbGCSHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 14:07:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:55424 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754894AbbGCSHW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 14:07:22 -0400
Received: (qmail 17498 invoked by uid 102); 3 Jul 2015 18:07:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jul 2015 13:07:21 -0500
Received: (qmail 14667 invoked by uid 107); 3 Jul 2015 18:07:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jul 2015 14:07:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jul 2015 14:07:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38155e3s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273307>

On Fri, Jul 03, 2015 at 10:45:59AM -0700, Junio C Hamano wrote:

> > Usually flush packets are "0000", and an empty data packet
> > is "0004". Or are you talking about some kind of flush inside the
> > pkt-data stream?
> 
> Neither.  At the wire level there is a difference, but the callers
> of most often used function in pkt-line API, packet_read(), says
> 
> 	while (1) {
> 		len = packet_read();
> 	        if (!len) {
> 	        	/* flush */
> 	                break;
> 		}
> 	        ... do things on the "len" bytes received ...
> 		... and then on to the next packet ...
> 	}

Ah, I see. Yeah, that is a problem. The solutions you proposed seem like
good workarounds to me, but we are unfortunately stuck with existing
clients and servers which did not behave that way.

I wondered briefly whether this impacted the keepalives we added to
`upload-pack` in 05e9515; those are implemented as 0-byte data packets,
which we send during the potentially long counting/delta-compression
phase before we send out pack data. It works there because the packets
actually contain a single sideband byte, so they are never mistaken for
a flush packet.

Related, I recently ran into a case where I think we should do the same
for pushes. After receiving the pack, `index-pack` may chew on the
result for literally minutes (try pushing up the entire linux.git
history sometime). We say nothing at all on the wire until we've
finished that, run check_everything_connected, and run all hooks.  Some
clients (or intermediates on the connection) may give up after a few
minutes of silence.

I think we should have:

  1. Some progress eye-candy from the server to tell us that something
     is happening, and how close we are to finishing (basically
     "index-pack -v").

  2. When progress is disabled, similar keepalive packets saying "nope,
     no output yet".

For (2), hopefully we can implement it in the same way, and rely on
empty sideband-0 packets. I haven't tested it in practice, though (I
have some very rough patches for (1) already).

-Peff
