From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] pretty: Initialize notes if %N is used
Date: Tue, 13 Apr 2010 07:07:24 -0400
Message-ID: <20100413110723.GA2910@coredump.intra.peff.net>
References: <20100413103611.GA4181@dualtron.lan>
 <1271156465-7302-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Tue Apr 13 13:08:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1dyK-0002GD-5q
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 13:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062Ab0DMLHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 07:07:53 -0400
Received: from peff.net ([208.65.91.99]:37619 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab0DMLHw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 07:07:52 -0400
Received: (qmail 4550 invoked by uid 107); 13 Apr 2010 11:07:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 13 Apr 2010 07:07:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Apr 2010 07:07:24 -0400
Content-Disposition: inline
In-Reply-To: <1271156465-7302-1-git-send-email-heipei@hackvalue.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144812>

On Tue, Apr 13, 2010 at 01:01:05PM +0200, Johannes Gilger wrote:

> Introduced space when calling userformat_find_requirements and dealt
> with %+N and %-N during the strbuf_expand phase. I hope strncmp is the
> right way to do it here. strbuf is NUL-terminated so there should not
> be a problem.

Ugh. I didn't even know we had such a thing. Those look like the only
ones that should be a problem, though. I'm glad to have factored out the
"want" code, now. At least it will all be in one spot.

> +static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
> +				   void *context)
> +{
> +	struct userformat_want *w = context;
> +
> +	switch (*placeholder) {
> +		case '-':
> +		case '+':
> +			if (!strncmp(placeholder+1, "N", 1))
> +				w->notes = 1;
> +		case 'N': w->notes = 1;
> +	}
> +	return 0;
> +}

Should this perhaps be:

  if (*placeholder == '+' || *placeholder == '-')
    placeholder++;

  switch (*placeholder) {
    case 'N': w->notes = 1; break;
  }

so that it will extend naturally if other placeholder lookups are needed
(since those ones also could have + or - markers).

Also, I just noticed that your case is missing a 'break'. Not a bug yet,
but it will be if somebody adds a new case. This is almost certainly my
fault from the original version I posted. :)

-Peff
