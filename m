From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] drop length limitations on gecos-derived names and
 emails
Date: Mon, 14 May 2012 17:13:24 -0400
Message-ID: <20120514211324.GA11578@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
 <20120514210225.GA9677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 23:13:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU2aB-0000mJ-4S
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 23:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002Ab2ENVN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 17:13:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43104
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757017Ab2ENVN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 17:13:26 -0400
Received: (qmail 25628 invoked by uid 107); 14 May 2012 21:13:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 17:13:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 17:13:24 -0400
Content-Disposition: inline
In-Reply-To: <20120514210225.GA9677@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197811>

On Mon, May 14, 2012 at 05:02:25PM -0400, Jeff King wrote:

> Ick, there is something very wrong with this patch. While testing a
> completely unrelated bug, I noticed that it set my name to "Jeff
> KingJeff KingJeff King". Which, while a wonderful ego massage, is
> probably excessive.
> 
> I'm sure the problem is the switch to strbuf's appending semantics
> rather than strlcpy's overwriting semantics. I thought we were careful
> not to bother re-run the gecos code if we had already gotten a name, but
> obviously that is not the case in some code paths. I'll investigate.

Ah, I see. The problem is here:

> --- a/config.c
> +++ b/config.c
> @@ -767,7 +767,7 @@ static int git_default_user_config(const char *var, const char *value)
>  	if (!strcmp(var, "user.name")) {
>  		if (!value)
>  			return config_error_nonbool(var);
> -		strlcpy(git_default_name, value, sizeof(git_default_name));
> +		strbuf_addstr(&git_default_name, value);
>  		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
>  		return 0;
>  	}
> @@ -775,7 +775,7 @@ static int git_default_user_config(const char *var, const char *value)
>  	if (!strcmp(var, "user.email")) {
>  		if (!value)
>  			return config_error_nonbool(var);
> -		strlcpy(git_default_email, value, sizeof(git_default_email));
> +		strbuf_addstr(&git_default_email, value);
>  		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;

where we are not careful. The fix is trivial. However, while examining
fmt_ident, I notice there is another potential spot there that needs
further investigation (I think it may actually be unreachable code, but
I need to look closer).

I'll re-roll the series with the fixes after investigating fmt_ident.

-Peff
