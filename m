From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ident.c: add support for IPv6
Date: Fri, 30 Oct 2015 14:29:39 -0400
Message-ID: <20151030182939.GA4729@sigill.intra.peff.net>
References: <1446216487-11503-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:29:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEQs-00087s-UN
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbbJ3S3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:29:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:50521 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759864AbbJ3S3m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:29:42 -0400
Received: (qmail 2766 invoked by uid 102); 30 Oct 2015 18:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 13:29:42 -0500
Received: (qmail 25056 invoked by uid 107); 30 Oct 2015 18:30:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 14:30:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2015 14:29:39 -0400
Content-Disposition: inline
In-Reply-To: <1446216487-11503-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280512>

On Fri, Oct 30, 2015 at 03:48:07PM +0100, Elia Pinto wrote:

> Add IPv6 support by implementing name resolution with the
> protocol agnostic getaddrinfo(3) API. The old gethostbyname(3)
> code is still available when git is compiled with NO_IPV6.

Makes sense. I'm not excited by the duplication in the early part of the
function, though:

> +#ifndef NO_IPV6
> +
> +static void add_domainname(struct strbuf *out)
> +{
> +	char buf[1024];
> +	struct addrinfo hints, *ai;
> +	int gai;
> +
> +	if (gethostname(buf, sizeof(buf))) {
> +		warning("cannot get host name: %s", strerror(errno));
> +		strbuf_addstr(out, "(none)");
> +		return;
> +	}
> +	if (strchr(buf, '.'))
> +		strbuf_addstr(out, buf);
> +	else	{
> +		memset (&hints, '\0', sizeof (hints));
> +		hints.ai_flags = AI_CANONNAME;
> +		if (!(gai = getaddrinfo(buf, NULL, &hints, &ai)) && ai && strchr(ai->ai_canonname, '.')) {
> +			strbuf_addstr(out, ai->ai_canonname);
> +			freeaddrinfo(ai);
> +		}
> +		else
> +			strbuf_addf(out, "%s.(none)", buf);
> +	}
> +}

Especially the "(none)" stuff is ugly enough as it is, without being
duplicated in two spots. Can we factor out the else clause that calls
gethostbyname(), and just override that part with the #ifdef?

For that matter, we have a few other spots that use getaddrinfo and
#ifdef. I wonder if it would be possible to simply use getaddrinfo
everywhere, and make a compatibility wrapper that uses gethostbyname for
older systems. The cut-and-paste duplication in connect.c, for example,
is pretty egregious.

-Peff
