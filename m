From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] ident: check for useConfigOnly before auto-detection
 of name/email
Date: Thu, 31 Mar 2016 10:40:03 -0400
Message-ID: <20160331144003.GE31116@sigill.intra.peff.net>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marios Titas <redneb@gmx.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:40:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldld-0002G3-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117AbcCaOkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:40:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:41520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754063AbcCaOkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:40:06 -0400
Received: (qmail 20835 invoked by uid 102); 31 Mar 2016 14:40:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:40:05 -0400
Received: (qmail 13221 invoked by uid 107); 31 Mar 2016 14:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:40:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 10:40:03 -0400
Content-Disposition: inline
In-Reply-To: <1459366183-15451-1-git-send-email-redneb@gmx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290392>

On Wed, Mar 30, 2016 at 10:29:42PM +0300, Marios Titas wrote:

> If user.useConfigOnly is set, it does not make sense to try to
> auto-detect the name and/or the email. So it's better to do the
> useConfigOnly checks first.

It might be nice to explain how it is better here. I'd guess it is
because we may fail during xgetpwuid(), giving a message that is much
less informative?

> @@ -374,14 +374,14 @@ const char *fmt_ident(const char *name, const char *email,
>  	}
>  
>  	if (!email) {
> +		if (strict && ident_use_config_only
> +		    && !(ident_config_given & IDENT_MAIL_GIVEN))
> +			die("user.useConfigOnly set but no mail given");
>  		email = ident_default_email();
>  		if (strict && default_email_is_bogus) {
>  			fputs(env_hint, stderr);
>  			die("unable to auto-detect email address (got '%s')", email);
>  		}
> -		if (strict && ident_use_config_only
> -		    && !(ident_config_given & IDENT_MAIL_GIVEN))
> -			die("user.useConfigOnly set but no mail given");
>  	}

I wondered on this hunk whether ident_default_email() could ever set the
IDENT_MAIL_GIVEN flag. It _does_ set it, but only for
"explicitly_given", not for "config_given", which makes sense.

So I think this is doing the right thing.

-Peff
