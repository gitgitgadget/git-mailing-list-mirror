From: Jeff King <peff@peff.net>
Subject: Re: [PREVIEW v3 8/9] checkout-index: there are only two line
 terminators
Date: Thu, 14 Jan 2016 05:18:31 -0500
Message-ID: <20160114101830.GC30772@sigill.intra.peff.net>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-9-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 11:18:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJezI-0006TC-34
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 11:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbcANKSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 05:18:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:53560 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753512AbcANKSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 05:18:33 -0500
Received: (qmail 14716 invoked by uid 102); 14 Jan 2016 10:18:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:18:33 -0500
Received: (qmail 5515 invoked by uid 107); 14 Jan 2016 10:18:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:18:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 05:18:31 -0500
Content-Disposition: inline
In-Reply-To: <1452740590-16827-9-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284028>

On Wed, Jan 13, 2016 at 07:03:08PM -0800, Junio C Hamano wrote:

> The program by default works on LF terminated lines, with an option
> to use NUL terminated records.  Instead of using line_termination
> that happens to take LF or NUL to call strbuf_getline(), switch
> between strbuf_getline_{lf,nul} based on the value of '-z' option.
> 
> Note that this still leaves the option open to use NUL-terminated
> input mixed with LF-terminated output (and vice versa), and even
> HT-terminated output is still left as a possibility, because this
> series is only interested in tightening the overly broad interface
> on the input side.

I see that we switch the line termination on the fly in option_parse_z.
But I'm having trouble seeing how we could actually have mixed inputs.
We don't actually look at the line-terminator until after all of the
options are parsed.

IOW, could this OPT_CALLBACK for 'z' be simplified to a simple OPT_BOOL,
or am I missing some case?

>  #define CHECKOUT_ALL 4
>  static int line_termination = '\n';
> +static strbuf_getline_fn getline_fn = strbuf_getline_lf;

This "line_termination" can become a boolean "1" now, right?

> @@ -144,10 +145,13 @@ static int option_parse_u(const struct option *opt,
>  static int option_parse_z(const struct option *opt,
>  			  const char *arg, int unset)
>  {
> -	if (unset)
> +	if (unset) {
>  		line_termination = '\n';
> -	else
> +		getline_fn = strbuf_getline_lf;
> +	} else {
>  		line_termination = 0;
> +		getline_fn = strbuf_getline_nul;
> +	}

Ditto here (though as before, I think I prefer it as the inverse bool:
did somebody turn on "-z").

I'm also not sure how "unset" would trigger here. If we have a long
option, we can use "--no-foo". But there isn't a long option for "-z".
Is there a way to negate short options?

-Peff
