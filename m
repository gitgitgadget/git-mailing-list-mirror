From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gpg-interface: check gpg signature for correct header
Date: Tue, 14 Jun 2016 07:20:06 -0400
Message-ID: <20160614112006.GA15889@sigill.intra.peff.net>
References: <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
 <2f473a993b6bc951dec76d38c11d0e600b59b8d3.1465902530.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, ZhenTian <loooseleaves@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 13:20:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCmOT-0006Gu-4O
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 13:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbcFNLUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 07:20:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:54526 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751140AbcFNLUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 07:20:10 -0400
Received: (qmail 20874 invoked by uid 102); 14 Jun 2016 11:20:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 07:20:09 -0400
Received: (qmail 27744 invoked by uid 107); 14 Jun 2016 11:20:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 07:20:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 07:20:06 -0400
Content-Disposition: inline
In-Reply-To: <2f473a993b6bc951dec76d38c11d0e600b59b8d3.1465902530.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297288>

On Tue, Jun 14, 2016 at 01:11:19PM +0200, Michael J Gruber wrote:

> When we create a signature, it may happen that gpg returns with
> "success" but not with an actual detached signature on stdout.
> 
> Check for the correct header to catch these cases better.

Seems like a reasonable idea.

I do worry that checking for PGP_SIGNATURE is a little fragile, though.
We currently let you sign with gpgsm, for example, and I think this
would break it (the verification side is not great because we don't
recognize gpgsm headers, but this feels like a step backwards).

That wouldn't be too hard to work around with a "is this a signature"
function that checks both types.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index c4b1e8c..664796f 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -185,7 +185,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  
>  	sigchain_pop(SIGPIPE);
>  
> -	if (finish_command(&gpg) || !len || len < 0)
> +	if (finish_command(&gpg) || !len || len < 0 || strncmp(signature->buf, PGP_SIGNATURE, strlen(PGP_SIGNATURE)))
>  		return error(_("gpg failed to sign the data"));

I think your strncmp is better spelled:

  starts_with(signature->buf, PGP_SIGNATURE);

The check for "!len" is redundant now. I think you could drop "len < 0"
as well (and in fact, drop the "len" variable entirely), as in the error
case we'd simply have an empty signature->len.

Your patch effectively swaps out "did we get any data" for "did we get
the data we expect", which is what those "len" checks were doing.

-Peff
