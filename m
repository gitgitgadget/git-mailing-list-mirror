From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] ident: loosen getpwuid error in non-strict mode
Date: Mon, 14 Dec 2015 10:07:29 -0500
Message-ID: <20151214150729.GA21415@sigill.intra.peff.net>
References: <20151210213228.GB29055@sigill.intra.peff.net>
 <20151210214129.GC8374@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:07:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Uj2-0001gT-D9
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbbLNPHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:07:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:41202 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751061AbbLNPHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 10:07:32 -0500
Received: (qmail 22513 invoked by uid 102); 14 Dec 2015 15:07:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 09:07:31 -0600
Received: (qmail 27087 invoked by uid 107); 14 Dec 2015 15:07:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 10:07:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 10:07:29 -0500
Content-Disposition: inline
In-Reply-To: <20151210214129.GC8374@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282358>

On Thu, Dec 10, 2015 at 04:41:29PM -0500, Jeff King wrote:

> -static struct passwd *xgetpwuid_self(void)
> +static struct passwd *xgetpwuid_self(int *is_bogus)
>  {
>  	struct passwd *pw;
>  
>  	errno = 0;
>  	pw = getpwuid(getuid());
> -	if (!pw)
> -		die(_("unable to look up current user in the passwd file: %s"),
> -		    errno ? strerror(errno) : _("no such user"));
> +	if (!pw) {
> +		struct passwd fallback;
> +		fallback.pw_name = "unknown";
> +#ifndef NO_GECOS_IN_PWENT
> +		fallback.pw_gecos = "Unknown";
> +#endif
> +		pw = &fallback;
> +		if (is_bogus)
> +			*is_bogus = 1;
> +	}
>  	return pw;

Ugh. The fallback struct should be static, of course, as we are
returning its address from the function.

Anybody have a brown paper bag I can borrow?

diff --git a/ident.c b/ident.c
index 74de079..831072c 100644
--- a/ident.c
+++ b/ident.c
@@ -32,7 +32,7 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 	errno = 0;
 	pw = getpwuid(getuid());
 	if (!pw) {
-		struct passwd fallback;
+		static struct passwd fallback;
 		fallback.pw_name = "unknown";
 #ifndef NO_GECOS_IN_PWENT
 		fallback.pw_gecos = "Unknown";

-Peff
