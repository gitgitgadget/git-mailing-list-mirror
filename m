From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 04/10] pkt-line: change error message for oversized
 packet
Date: Mon, 18 Feb 2013 04:49:59 -0500
Message-ID: <20130218094959.GA16408@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092221.GD5096@sigill.intra.peff.net>
 <7vd2vyarjy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:50:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NMr-0004GM-JT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab3BRJuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:50:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51728 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754445Ab3BRJuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:50:10 -0500
Received: (qmail 18003 invoked by uid 107); 18 Feb 2013 09:51:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:51:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:49:59 -0500
Content-Disposition: inline
In-Reply-To: <7vd2vyarjy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216461>

On Mon, Feb 18, 2013 at 01:40:17AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm really tempted to bump all of our 1000-byte buffers to just use
> > LARGE_PACKET_MAX. If we provided a packet_read variant that used a
> > static buffer (which is fine for all but one or two callers), then it
> > would not take much memory...
> 
> I thought that 1000-byte limit was kept when we introduced the 64k
> interface to interoperate with other side that does not yet support
> the 64k interface. Is your justification that such an old version of
> Git no longer matters in the real world (which is true, I think), or
> we use 1000-byte limit in some codepaths even when we know that we
> are talking with a 64k-capable version of Git on the other side?

I should have been more clear that I want to bump only the _reading_
side, not the writing.

The sideband-64k capability bumps the sideband chunk size. But the size
for packetized ref advertisement lines has remained at 1000. Which it
must, since we start outputting them before doing capability
negotiation. The sender will die before writing a longer ref line (see
pkg-line.c:format_packet), and most of the reading callsites feed a
1000-byte buffer to packet_read_line (which will die if we get a larger
packet). So the upgrade path for that would be:

  1. Git bumps up all reading buffers to LARGE_PACKET_MAX, just in case.
     This immediately covers us for any alternate implementations that
     send larger ref packets (I do not know if any exist, but the
     documentation does not mention this limitation at all, so I would
     not be surprised if other implementations just use LARGE_PACKET_MAX
     as a maximum).

  2. Many years pass. We decide that Git v1.8.2 and older are ancient
     history and not worth caring about.

  3. We bump the 1000-byte limit for format_packet to LARGE_PACKET_MAX.

This is not pressing at all; I wouldn't have even noticed it if I hadn't
been wondering how large to make the new buffer I was adding in a later
patch. I have not heard of anyone running up against this limit in
practice. But it's easy to do (1), and it starts the clock ticking for
the 1000-byte readers to become obsolete.

-Peff
