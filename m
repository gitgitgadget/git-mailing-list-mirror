From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/13] strbuf: add strbuf_add*_urlencode
Date: Tue, 29 Nov 2011 16:19:50 -0500
Message-ID: <20111129211950.GD1793@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110728.GI8417@sigill.intra.peff.net>
 <7vzkfessff.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 22:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVV5p-0000md-2q
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 22:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716Ab1K2VTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 16:19:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55851
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501Ab1K2VTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 16:19:51 -0500
Received: (qmail 2908 invoked by uid 107); 29 Nov 2011 21:26:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 16:26:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 16:19:50 -0500
Content-Disposition: inline
In-Reply-To: <7vzkfessff.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186084>

On Tue, Nov 29, 2011 at 10:19:00AM -0800, Junio C Hamano wrote:

> > +static int is_rfc3986_reserved(char ch)
> > +{
> > +	switch (ch) {
> > +	case '!': case '*': case '\'': case '(': case ')': case ';':
> > +	case ':': case '@': case '&': case '=': case '+': case '$':
> > +	case ',': case '/': case '?': case '#': case '[': case ']':
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> 
> Part of me wonders if we still have extra bits in sane_ctype[] array but
> that one is cumbersome to update, and the above should be easier to read
> and maintain.

We have 2 bits left. I did consider it, but it just seemed excessively
cumbersome for something that really doesn't need to be that fast (if it
is indeed any faster than this case statement).

> > +void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
> > +			  int reserved)
> 
> Does "reserved" parameter mean "must-encode-reserved", or
> "may-encode-reserved" (the latter would be more like "if set to 0,
> per-cent encoding the result would be an error")?

It is "must-encode-reserved". The difference, from my reading of the
rfc, is that we can relax our encoding in the path-name portion of the
URI. For example, in:

  https://user@host/path/to/repo.git

You definitely want to quote "/" in the user or hostname, but doing so
in path/to/repo.git is just annoying.

-Peff
