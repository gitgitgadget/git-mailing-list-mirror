From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diesys calls die and also reports strerror(errno)
Date: Thu, 4 Jun 2009 16:50:55 -0400
Message-ID: <20090604205055.GB17478@sigill.intra.peff.net>
References: <20090603015503.GA14166@coredump.intra.peff.net> <1244081105-7149-1-git-send-email-aspotashev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 22:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCJtw-0006pL-Qo
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 22:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbZFDUuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 16:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZFDUuz
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 16:50:55 -0400
Received: from peff.net ([208.65.91.99]:35218 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbZFDUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 16:50:54 -0400
Received: (qmail 901 invoked by uid 107); 4 Jun 2009 20:51:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Jun 2009 16:51:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2009 16:50:55 -0400
Content-Disposition: inline
In-Reply-To: <1244081105-7149-1-git-send-email-aspotashev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120710>

On Thu, Jun 04, 2009 at 06:05:05AM +0400, Alexander Potashev wrote:

> Firstly I was going to write a 'adapt_to_fmt' function which would
> double all inclusions of '%', and then use it for strerror(err) and
> make printf-like functions happy (actually 'die_routine').
> 
> BUT, Have you ever seen an error description containing '%'? I haven't.
> So, handling the case of '%'s is not worth injecting several dump lines
> into the sources of the Beatiful Content Tracker.

That makes me a little nervous. No, I don't think there are any '%'
signs in standard 'C' locale messages (at least not in GNU libc). But
what about other locales, especially ones which use a multi-byte
encoding?

Though your code does at least recognize the situation and does
something sane instead of feeding bogus parameters to fprintf.

> +void diesys(const char *err, ...)
> +{
> +	va_list params;
> +	char *fullfmt;
> +	const char *strerr;
> +
> +	va_start(params, err);
> +
> +	strerr = strerror(errno);
> +	if (strchr(strerr, '%'))
> +		strerr = "<error description contains '%%'>";
> +	fullfmt = xmalloc(strlen(err) + strlen(strerr) + 3);
> +	sprintf(fullfmt, "%s: %s", err, strerr);
> +	die_routine(fullfmt, params);
> +
> +	va_end(params);
> +}

Should we be calling malloc here? One of the possible error conditions
is that we're out of memory (though xmalloc itself just uses "die"). I
don't think there is a good reason not to use a reasonably-sized static
buffer, which should increase robustness (report() is already using a
1024-character buffer, so any message would be truncated there anyway).

-Peff
