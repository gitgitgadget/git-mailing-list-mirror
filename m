From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] remote-curl: verify smart-http metadata lines
Date: Sun, 17 Feb 2013 14:14:22 -0500
Message-ID: <20130217191422.GA25096@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064707.GB22626@sigill.intra.peff.net>
 <20130217104939.GE6759@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:14:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U79hI-0006bg-TR
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 20:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab3BQTOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 14:14:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50507 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab3BQTOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 14:14:25 -0500
Received: (qmail 12804 invoked by uid 107); 17 Feb 2013 19:15:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Feb 2013 14:15:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2013 14:14:22 -0500
Content-Disposition: inline
In-Reply-To: <20130217104939.GE6759@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216404>

On Sun, Feb 17, 2013 at 02:49:39AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> [...]
> > @@ -155,11 +166,13 @@ static struct discovery* discover_refs(const char *service)
> [...]
> > -		strbuf_reset(&buffer);
> > -		while (packet_get_line(&buffer, &last->buf, &last->len) > 0)
> > -			strbuf_reset(&buffer);
> > +		if (read_packets_until_flush(&last->buf, &last->len) < 0)
> 
> Style nit: this made me wonder "What would it mean if
> read_packets_until_flush() > 0?"  Since the convention for this
> function is "0 for success", I would personally find
> 
> 		if (read_packets_until_flush(...))
> 			handle error;
> 
> easier to read.

My intent was that it followed the error convention of "negative is
error, 0 is success, and positive is not used, but reserved for
future use". And I tend to think the "< 0" makes it obvious that we are
interested in error. But I don't feel that strongly, so if people would
rather see it the other way, I can live with it.

> > +			die("smart-http metadata lines are invalid at %s",
> > +			    refs_url);
> 
> Especially given that other clients would be likely to run into
> trouble in the same situation, as long as this cooks in "next" for a
> suitable amount of time to catch bad servers, it looks like a good
> idea.

Yeah, I have a slight concern that this series would break something in
another implementation, so I would like to see this cook in "next" for a
while (and would be slated for master probably not in this release, but
in the next one). But I think this change is pretty straightforward. If
an implementation is producing bogus packet lines and expecting us not
to complain, it really needs to be fixed.

-Peff
