From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/13] parse-options: stop when encounter a non-option
Date: Mon, 05 Jul 2010 19:36:14 -0700
Message-ID: <7vhbkd72w1.fsf@alter.siamese.dyndns.org>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 04:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVy1S-0006mo-Jh
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 04:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095Ab0GFCg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 22:36:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab0GFCg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 22:36:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B0DCC2B36;
	Mon,  5 Jul 2010 22:36:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pEJXcIkSGZRabGEsQFhYtfIy6Js=; b=QMkBm7S8vpBGF2lT9oYxE6Q
	QVmjyi7zdlfoeR31ap4UmllMYrZJ26meITVi9MrcAlzqcUPK06SjiT/akzN+R+sQ
	ZwIVf8a8rHDIH5wqQ+MCDnY+P3gcZ4/d1/q2CKu6tRZvvg9xf7u9TVpdfnPsS2MQ
	co86WwGTNxixlT8OPIGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=K2MdwyOENSYoCAx7mgHxpjY/Qu+gmPXODnOE5hZZLXGonx5PC
	SeDyWDq2PwzvPom2HM29WKyTdD9XiQQ28Nmew9SzEM7tmxU+esppjWM9XK4SFM99
	VPkyyGnYILpkLF0MNgXTdbBvg9qr2NRd1zHDRWpYaIQlZ0822fl5sraoBA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4867EC2B33;
	Mon,  5 Jul 2010 22:36:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D41AC2B31; Mon,  5 Jul
 2010 22:36:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 43315958-88A7-11DF-AA1D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150312>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Since we need to support the syntax like:
> -L n1,m1 path1 -L n2,m2 path2.
>
> So, make the parse-options API not stop with a

The above sentence does not parse well.

> non-option, but report the status and go on parsing
> the following.
>
> Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  parse-options.c |    3 ++-
>  parse-options.h |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 0fa79bc..cbb49d3 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -374,7 +374,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  			if (parse_nodash_opt(ctx, arg, options) == 0)
>  				continue;
>  			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
> -				break;
> +				return PARSE_OPT_NON_OPTION;
>  			ctx->out[ctx->cpidx++] = ctx->argv[0];
>  			continue;
>  		}
> @@ -456,6 +456,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  	switch (parse_options_step(&ctx, options, usagestr)) {
>  	case PARSE_OPT_HELP:
>  		exit(129);
> +	case PARSE_OPT_NON_OPTION:
>  	case PARSE_OPT_DONE:
>  		break;
>  	default: /* PARSE_OPT_UNKNOWN */
> diff --git a/parse-options.h b/parse-options.h
> index 7435cdb..407697a 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -161,7 +161,8 @@ extern NORETURN void usage_msg_opt(const char *msg,
>  enum {
>  	PARSE_OPT_HELP = -1,
>  	PARSE_OPT_DONE,
> -	PARSE_OPT_UNKNOWN
> +	PARSE_OPT_NON_OPTION,
> +	PARSE_OPT_UNKNOWN,
>  };
>  
>  /*
> -- 
> 1.7.0.2.273.gc2413.dirty
