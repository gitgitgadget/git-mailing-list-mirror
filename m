From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/10] pkt-line and remote-curl cleanups server
Date: Mon, 18 Feb 2013 04:55:37 -0500
Message-ID: <20130218095537.GL5096@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin>
 <20130217192830.GB25096@sigill.intra.peff.net>
 <20130218014113.GC3221@elie.Belkin>
 <20130218091203.GB17003@sigill.intra.peff.net>
 <7vhalaas2b.fsf@alter.siamese.dyndns.org>
 <20130218093335.GK5096@sigill.intra.peff.net>
 <7v8v6mar4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:56:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NS8-0006La-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454Ab3BRJzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:55:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51740 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab3BRJzj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:55:39 -0500
Received: (qmail 18077 invoked by uid 107); 18 Feb 2013 09:57:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:57:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:55:37 -0500
Content-Disposition: inline
In-Reply-To: <7v8v6mar4e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216462>

On Mon, Feb 18, 2013 at 01:49:37AM -0800, Junio C Hamano wrote:

> The logic behind the comment "we do not buffer, but we should" is
> that flush tells the receiver that the sending end is "done" feeding
> it a class of data, and the data before flush do not have to reach
> the receiver immediately, hence we can afford to buffer on the
> sending end if we can measure that doing so would give us better
> performance. We haven't measure and turned buffering on yet.
> 
> But when dying, we may of course have data before flushing. We may
> disconnect (by dying) without showing flush (or preceding ERR) to
> the other side, and for that reason, not relying on the flush packet
> on the receiving end is a good change. Once we turn buffering on, we
> probably need to be careful when sending an ERR indicator by making
> it always drain any buffered data and show the ERR indicator without
> buffering, or something.

Yeah, I'd agree. An ERR packet should always be accompanied by a flush
(whether an actual flush packet or not doesn't really matter, but
definitely a buffer flush on the sender). But I think that is really the
sender's problem, and we can deal with it there if and when we buffer.

>From the receiver's end, they simply want to be liberal in interpreting
an ERR as the end of the data stream. They do not have to be picky about
whether it is followed by more data, or by a flush packet, or whatever.
But that is not a change I am introducing; that is how get_remote_heads
has always worked. I am merely correcting the proposed change from v1 of
the series that did not correctly take that into account (and therefore
regressed the error message in the ERR case).

-Peff
