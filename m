From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] am: plug FILE * leak in split_mail_conv()
Date: Thu, 12 May 2016 00:47:30 -0400
Message-ID: <20160512044730.GA5436@sigill.intra.peff.net>
References: <20160511233546.13090-1-gitster@pobox.com>
 <20160511233546.13090-2-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 06:47:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0iXD-0002eS-QP
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 06:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbcELEre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 00:47:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:38357 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750711AbcELErd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 00:47:33 -0400
Received: (qmail 26869 invoked by uid 102); 12 May 2016 04:47:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 00:47:33 -0400
Received: (qmail 6118 invoked by uid 107); 12 May 2016 04:47:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 00:47:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 00:47:30 -0400
Content-Disposition: inline
In-Reply-To: <20160511233546.13090-2-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294384>

On Wed, May 11, 2016 at 04:35:46PM -0700, Junio C Hamano wrote:

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/am.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index f1a84c6..a373928 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -761,9 +761,11 @@ static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
>  		mail = mkpath("%s/%0*d", state->dir, state->prec, i + 1);
>  
>  		out = fopen(mail, "w");
> -		if (!out)
> +		if (!out) {
> +			fclose(in);
>  			return error(_("could not open '%s' for writing: %s"),
>  					mail, strerror(errno));
> +		}

Presumably `fclose` doesn't ever overwrite errno in practice, but I
guess it could in theory.

I also found it weird that we might fclose(stdin) via this line, but
that matches what happens in the non-error path, so I guess it's OK?

-Peff
