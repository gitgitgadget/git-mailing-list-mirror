From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATH/RFC] parse-options: report invalid UTF-8 switches
Date: Mon, 11 Feb 2013 14:43:28 +0100
Message-ID: <vpqobfr9da7.fsf@grenoble-inp.fr>
References: <1360589687-9233-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 14:43:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4tfp-00016M-FK
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 14:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327Ab3BKNne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 08:43:34 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37345 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757215Ab3BKNne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 08:43:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1BDhRD1027517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2013 14:43:27 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U4tfN-0003A1-3S; Mon, 11 Feb 2013 14:43:29 +0100
In-Reply-To: <1360589687-9233-1-git-send-email-kusmabite@gmail.com> (Erik
	Faye-Lund's message of "Mon, 11 Feb 2013 14:34:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Feb 2013 14:43:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1BDhRD1027517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361195010.44089@k+TdoBPrxzne4ldk36pkzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216032>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -3,6 +3,7 @@
>  #include "cache.h"
>  #include "commit.h"
>  #include "color.h"
> +#include "utf8.h"
>  
>  static int parse_options_usage(struct parse_opt_ctx_t *ctx,
>  			       const char * const *usagestr,
> @@ -462,7 +463,9 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  		if (ctx.argv[0][1] == '-') {
>  			error("unknown option `%s'", ctx.argv[0] + 2);
>  		} else {
> -			error("unknown switch `%c'", *ctx.opt);
> +			const char *next = ctx.opt;
> +			utf8_width(&next, NULL);
> +			error("unknown switch `%.*s'", (int)(next - ctx.opt), ctx.opt);
>  		}
>  		usage_with_options(usagestr, options);
>  	}

You should be careful with the case where the user has a non-UTF8
environment, and entered a non-ascii sequence. I can see two cases:

1) The non-ascii sequence is valid UTF-8, then I guess your patch would
   show two characters instead of one. Not really correct, but not really
   serious either.

2) The non-ascii sequence is NOT valid UTF-8, then if I read correctly
   (I didn't test) utf8_width would set next to NULL, and then you are
   in big trouble.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
