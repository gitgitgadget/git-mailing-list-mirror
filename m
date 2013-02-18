From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 04/10] pkt-line: change error message for oversized
 packet
Date: Mon, 18 Feb 2013 16:33:31 -0500
Message-ID: <20130218213331.GA29200@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092221.GD5096@sigill.intra.peff.net>
 <7vd2vyarjy.fsf@alter.siamese.dyndns.org>
 <20130218094959.GA16408@sigill.intra.peff.net>
 <7v1ucdb9gw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7YLV-0006Pg-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 22:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279Ab3BRVde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 16:33:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52365 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756022Ab3BRVdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 16:33:33 -0500
Received: (qmail 25202 invoked by uid 107); 18 Feb 2013 21:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 16:35:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 16:33:31 -0500
Content-Disposition: inline
In-Reply-To: <7v1ucdb9gw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216537>

On Mon, Feb 18, 2013 at 01:25:35PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But it's easy to do (1), and it starts the clock ticking for
> > the 1000-byte readers to become obsolete.
> 
> Yup, I agree with that goal.

Having just looked at the pkt-line callers a lot, I think most of them
could go for something like:

  char *packet_read(int fd, unsigned *len_p)
  {
          static char buffer[LARGE_PACKET_MAX];
          int len;

          len = packet_read_to_buf(fd, buffer, sizeof(buffer));
          if (len < 0)
                  return NULL;

          *len_p = len;
          return buffer;
  }

That would actually simplify the callers a bit, and would harmonize the
buffer sizes at the same time. I'll look into doing a series tonight.

-Peff
